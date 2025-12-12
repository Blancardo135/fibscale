# Base image for Ruby 3.2
FROM ruby:3.2-alpine


# Create group and user
RUN addgroup --system fibscale \
&& adduser --system --ingroup fibscale fibscale


# Set working directory
WORKDIR /fibscale

# Fix ownership of working directory
RUN chown fibscale:fibscale .


# Install build tools
RUN apk add --no-cache g++ make patch


# Copy project files
COPY --chown=fibscale:fibscale ./ ./


# Switch to non-root user
USER fibscale


# Install Ruby dependencies
RUN bundle install

# Launch application
CMD ["bundle", "exec", "ruby", "fibscale.rb"]