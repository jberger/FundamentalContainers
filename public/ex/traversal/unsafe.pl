use Mojolicious::Lite -signatures;

use Mojo::File 'path';

get '/*file' => sub ($c) {
  # this is a really bad idea
  my $path = path("/" . $c->stash->{file});
  $c->render(data => $path->to_abs->slurp);
};

app->start;

