Return-Path: <stable+bounces-121212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D53A5485E
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 11:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBEA17315D
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 10:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DBD2040B3;
	Thu,  6 Mar 2025 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ou+5EIWH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7B253BE;
	Thu,  6 Mar 2025 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258137; cv=none; b=GmQrB7K/ZbKPX0Cw1Ln0gXjOuqBb+FKrhvkXgZIQeFjUn+1de/ehsuEGoT2+COT1FAgyY4YxD8Fldw26YDLc2h5wwM44Bpz9XcWkNEGCq9Uz+se7O+BH1+I1GZGQ2U/XTeCF5Q0kfuc5RmNoy8xYW1QVLtm2Vxb7MUFBqpkbZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258137; c=relaxed/simple;
	bh=FSlDLjSruasqpbbVH9KKk9xG245xhWItcS/O7RHeIt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DF4b6gGHmkB8vYW2IwMCMaVaDjvZgH2uHcWH33YkLEJbwAtVUfPIl5LgHOlocNSGiVeyto+HoWRl+4JFULsZla3KstEOl43uGtLPJ8gGNPTVYtr3CRT7u1gckzdCxSFegnH9VSHLFjntFpQdNn3uYB6YlT0tg7J6VQyKHXnfVls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ou+5EIWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AD5C4CEE9;
	Thu,  6 Mar 2025 10:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258136;
	bh=FSlDLjSruasqpbbVH9KKk9xG245xhWItcS/O7RHeIt4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ou+5EIWHnSdt/PveSDG+3rA8j/J3Ve8O4ESVyo+Edc3vU0oe6a38vip0foMxNaUZz
	 cgL/jJCGYCG/7njA+NmLm6Aj8ZxfCFvFF/LwCHsjMHw7/+dFl/OjTQU9Xwdn24qI7v
	 tn2YKleQZv9fUtudt9sNJQob9BFGLsyqG4c1RBHgdja34GxlVajRkXmC+KNlb4lXq/
	 GVn8Y4NiHASikUCta1wR7OUy/SXOWHjJkQnaVYgWCXbwwVmZRTE0lglpOyAARpZzHc
	 7H548l5niauyLOaj9ves6tb1XtTiYGLf/vRswhMs4jnXNh43BEN21avjEJ21NVNF86
	 W8M1wIo1z33OQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5fe944b3fa0so227219eaf.0;
        Thu, 06 Mar 2025 02:48:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3BbX7DX7nJ8hB1X3ymO9usZX3vtHqIWIFlkoXrU+ZkGRoDe3wkB3ZomdBjOezYKDeXVz4w0FE@vger.kernel.org, AJvYcCWG6Acg2KQ35Wkt/KIRqjY/EauVcG0eeMPPc97kw6amShtw/gkAftJrM6SFc+uUFxIlXpskVsCMhQTTaFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNDiOV9g4We8NjBgpxUaphfNAtvgV6k6UmUGdqy/QfHTfrDAZH
	q3Q0IKUT06hYy7vgbmcCH33e/1iPPQNvVubD26KUPJaMkklwRFQm6sXCCywEGxcrXaFZzFTNTLR
	CYaPlGCOvlydDlMlO1vzVVbvGN8I=
X-Google-Smtp-Source: AGHT+IFI0qY/CIKCrUBke3To4Yac2aOGvK/YOzpOQHRPkqQTLEMR2DsPCXQaXulvD9accx6QhcDWYY+WGTuU5ompyFs=
X-Received: by 2002:a05:6820:1891:b0:5fd:50d:49e4 with SMTP id
 006d021491bc7-600336527abmr3188281eaf.7.1741258136032; Thu, 06 Mar 2025
 02:48:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306065055.1220699-1-dmitry.torokhov@gmail.com> <20250306065055.1220699-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20250306065055.1220699-2-dmitry.torokhov@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 6 Mar 2025 11:48:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hLyfFW0ab8eCYGsqa56upGNb_bKNekLXmjidXAefGniA@mail.gmail.com>
X-Gm-Features: AQ5f1Jri9v7HRYvxxYw-bQ-g0iDVp7lmMqjzLT22kUBmKP1BI-FROcucypVUm3s
Message-ID: <CAJZ5v0hLyfFW0ab8eCYGsqa56upGNb_bKNekLXmjidXAefGniA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] driver core: fix potential NULL pointer
 dereference in dev_uevent()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 7:51=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> If userspace reads "uevent" device attribute at the same time as another
> threads unbinds the device from its driver, change to dev->driver from a
> valid pointer to NULL may result in crash. Fix this by using READ_ONCE()
> when fetching the pointer, and take bus' drivers klist lock to make sure
> driver instance will not disappear while we access it.
>
> Use WRITE_ONCE() when setting the driver pointer to ensure there is no
> tearing.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>
> v2: addressed Rafael's feedback by introducing device_set_driver()
> helper that does WRITE_ONCE() to prevent tearing.

So the code changes look OK to me now, but I would introduce
device_set_driver() in a separate preliminary patch, to start with as
a simple assignment.

Then, in the fix patch proper, I'd replace the assignment in
device_set_driver() with WRITE_ONCE().

That would allow the fix itself to be distinguished from the
tangentially related changes depended on by it.

> I added Cc: stable however I do not think we need to worry too much
> about backporting it to [very] old kernels: the race window is very
> small, and in real life we do not unbind devices that often.
>
> I believe there are more questionable places where we read dev->driver
> pointer, those need to be adjusted separately.
>
>  drivers/base/base.h | 18 ++++++++++++++++++
>  drivers/base/bus.c  |  2 +-
>  drivers/base/core.c | 34 +++++++++++++++++++++++++++++++---
>  drivers/base/dd.c   |  7 +++----
>  4 files changed, 53 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 8cf04a557bdb..ed2d7ccc7354 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -73,6 +73,7 @@ static inline void subsys_put(struct subsys_private *sp=
)
>                 kset_put(&sp->subsys);
>  }
>
> +struct subsys_private *bus_to_subsys(const struct bus_type *bus);
>  struct subsys_private *class_to_subsys(const struct class *class);
>
>  struct driver_private {
> @@ -179,6 +180,23 @@ int driver_add_groups(const struct device_driver *dr=
v, const struct attribute_gr
>  void driver_remove_groups(const struct device_driver *drv, const struct =
attribute_group **groups);
>  void device_driver_detach(struct device *dev);
>
> +static inline void device_set_driver(struct device *dev, const struct de=
vice_driver *drv)
> +{
> +
> +       /*
> +        * Majority (all?) read accesses to dev->driver happens either
> +        * while holding device lock or in bus/driver code that is only
> +        * invoked when the device is bound to a driver and there is no
> +        * concern of the pointer being changed while it is being read.
> +        * However when reading device's uevent file we read driver point=
er
> +        * without taking device lock (so we do not block there for
> +        * arbitrary amount of time). We use WRITE_ONCE() here to prevent
> +        * tearing so that READ_ONCE() can safely be used in uevent code.
> +        */
> +       // FIXME - this cast should not be needed "soon"
> +       WRITE_ONCE(dev->driver, (struct device_driver *)drv);
> +}
> +
>  int devres_release_all(struct device *dev);
>  void device_block_probing(void);
>  void device_unblock_probing(void);
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 6b9e65a42cd2..c8c7e0804024 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -57,7 +57,7 @@ static int __must_check bus_rescan_devices_helper(struc=
t device *dev,
>   * NULL.  A call to subsys_put() must be done when finished with the poi=
nter in
>   * order for it to be properly freed.
>   */
> -static struct subsys_private *bus_to_subsys(const struct bus_type *bus)
> +struct subsys_private *bus_to_subsys(const struct bus_type *bus)
>  {
>         struct subsys_private *sp =3D NULL;
>         struct kobject *kobj;
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 9f4d4868e3b4..27fe69d06765 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2623,6 +2623,34 @@ static const char *dev_uevent_name(const struct ko=
bject *kobj)
>         return NULL;
>  }
>
> +/*
> + * Try filling "DRIVER=3D<name>" uevent variable for a device. Because t=
his
> + * function may race with binding and unbinding device from a driver we =
need to
> + * be careful. Binding is generally safe, at worst we miss the fact that=
 device
> + * is already bound to a driver (but the driver information that is deli=
vered
> + * through uevents is best-effort, it may become obsolete as soon as it =
is
> + * generated anyways). Unbinding is more risky as driver transitioning t=
o NULL,
> + * so READ_ONCE() should be used to make sure we are dealing with the sa=
me
> + * pointer, and to ensure that driver structure is not going to disappea=
r from
> + * under us we take bus' drivers klist lock. The assumption that only re=
gistered
> + * driver can be bound to a device, and to unregister a driver bus code =
will
> + * take the same lock.
> + */
> +static void dev_driver_uevent(const struct device *dev, struct kobj_ueve=
nt_env *env)
> +{
> +       struct subsys_private *sp =3D bus_to_subsys(dev->bus);
> +
> +       if (sp) {
> +               scoped_guard(spinlock, &sp->klist_drivers.k_lock) {
> +                       struct device_driver *drv =3D READ_ONCE(dev->driv=
er);
> +                       if (drv)
> +                               add_uevent_var(env, "DRIVER=3D%s", drv->n=
ame);
> +               }
> +
> +               subsys_put(sp);
> +       }
> +}
> +
>  static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env=
 *env)
>  {
>         const struct device *dev =3D kobj_to_dev(kobj);
> @@ -2654,8 +2682,8 @@ static int dev_uevent(const struct kobject *kobj, s=
truct kobj_uevent_env *env)
>         if (dev->type && dev->type->name)
>                 add_uevent_var(env, "DEVTYPE=3D%s", dev->type->name);
>
> -       if (dev->driver)
> -               add_uevent_var(env, "DRIVER=3D%s", dev->driver->name);
> +       /* Add "DRIVER=3D%s" variable if the device is bound to a driver =
*/
> +       dev_driver_uevent(dev, env);
>
>         /* Add common DT information about the device */
>         of_device_uevent(dev, env);
> @@ -3696,7 +3724,7 @@ int device_add(struct device *dev)
>         device_pm_remove(dev);
>         dpm_sysfs_remove(dev);
>   DPMError:
> -       dev->driver =3D NULL;
> +       device_set_driver(dev, NULL);
>         bus_remove_device(dev);
>   BusError:
>         device_remove_attrs(dev);
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index f0e4b4aba885..b526e0e0f52d 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -550,7 +550,7 @@ static void device_unbind_cleanup(struct device *dev)
>         arch_teardown_dma_ops(dev);
>         kfree(dev->dma_range_map);
>         dev->dma_range_map =3D NULL;
> -       dev->driver =3D NULL;
> +       device_set_driver(dev, NULL);
>         dev_set_drvdata(dev, NULL);
>         if (dev->pm_domain && dev->pm_domain->dismiss)
>                 dev->pm_domain->dismiss(dev);
> @@ -629,8 +629,7 @@ static int really_probe(struct device *dev, const str=
uct device_driver *drv)
>         }
>
>  re_probe:
> -       // FIXME - this cast should not be needed "soon"
> -       dev->driver =3D (struct device_driver *)drv;
> +       device_set_driver(dev, drv);
>
>         /* If using pinctrl, bind pins now before probing */
>         ret =3D pinctrl_bind_pins(dev);
> @@ -1014,7 +1013,7 @@ static int __device_attach(struct device *dev, bool=
 allow_async)
>                 if (ret =3D=3D 0)
>                         ret =3D 1;
>                 else {
> -                       dev->driver =3D NULL;
> +                       device_set_driver(dev, NULL);
>                         ret =3D 0;
>                 }
>         } else {
> --
> 2.49.0.rc0.332.g42c0ae87b1-goog
>

