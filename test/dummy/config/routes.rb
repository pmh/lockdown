Dummy::Application.routes.draw do
  match 'wide_open'        => 'protected#wide_open'
  match 'users'            => 'protected#users'
  match 'admins'           => 'protected#admins'
  match 'users_and_admins' => 'protected#users_and_admins'
end
