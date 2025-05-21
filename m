Return-Path: <stable+bounces-145939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F160ABFE9B
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 23:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05261BC0D92
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 21:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37712BCF47;
	Wed, 21 May 2025 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="G90upe9/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3228FAB2
	for <stable@vger.kernel.org>; Wed, 21 May 2025 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747861461; cv=none; b=XkyZ/OINoseoXhXidybApQwL9PYZRlcwZUrj0LuD3Ux2y5aQlvrYCCGi7QGQQa3lWz0FMHWiAqMNRbJP4r0eJmR9cDw1CXOyROJ82ThviDvzZJsMCy1fvcs3B4aHnckdwdkOa132WULZJYQqGC0GX2lUlYiLILRDz19iaNj/eCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747861461; c=relaxed/simple;
	bh=JzJvkSy83wbjXuXRYHa0uZFurnD/wkEJrnn5mEpke7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvTWmgOjCd2IRBjpUe5BRsb1e3mo26izDN7+JhJ9Yjj2PuKR0BXGvE1FbTUf50vzARMtbTWmhuZENQe7wK5kgoHEuX8ev0EQRLk+WDyZQMppklaeuwofcPT45v0kK48Skn9gD+k01tRuFDM9PA1sxyB6/qix78iUzDd6Ez1VgQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=G90upe9/; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3108652400cso247544a91.1
        for <stable@vger.kernel.org>; Wed, 21 May 2025 14:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747861459; x=1748466259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8E8wJ2KkrPpB4/N0ejd9jMNIZBIK2MiFknrDOo+EPg=;
        b=G90upe9/oAIDS/7Oinivr+q4+aY9GvoAtFBv+1EA49A9uGIXPNyq6XJwKRIAj1ZQls
         X13a6x8C6WvzrJQH3byvUMeedA0KPA2SQhGu38NxMFmfMfRHXdQphvHCKukAwFsWLi3e
         cKyBqDiHmrcxb4lb/z6LIv/B4L295eYOqamElhclqj4/jUPaCdKXhWd/bdoAmd5cROYA
         lBUe5JtEkZNpd8xKBkKorn/eIL58IvrjO32HtNFvDMMcAjbKA9vdCz3uJ/PnzU24Eqou
         JQrYccMy+6WAK+L+3DwvuTYmjOI44+mpsDCoMepc+BBFs2IzO/8MgIOJb+ks+6qkl6ks
         Inpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747861459; x=1748466259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8E8wJ2KkrPpB4/N0ejd9jMNIZBIK2MiFknrDOo+EPg=;
        b=t0HmiN93hUUBQGZTzvJi7UQx3jGmexaFycJq+33k01ycF9afZki7dYTtArKUF0TF0q
         9A/ZVoUW47oYVvL4mww2F/tp5165Z1K39uxXmSBFLugc8mcLWWUCTmT5omeF0bzbTZ1X
         D/g8LPz+Bm7YK6DquGqOSfgb4sFPaDZqRNFy9TLn4+gpsfndeWTsSRiU9sVaf7fCtLXj
         oglNccciTv+DMjpkApl6u87nCwe8g1wTsF8TfZfigMCUib+A8R2KDFen8UrBWWKC6S86
         IHyILsxmbuvn6CzIfF3ZAbGfFDaK2QXH/w1uykdP6hZDN9Ri4fit0s8vgtEiAytK1Y/y
         V5Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWErjNTMYCR+GLqnyn8JqoRCQTpdonAwT4POciNlBV9WAV4mC7Nvln8gdAvXsRORvUOSXk9qPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAU5mvFYterJBPgfMnAtyjumPA+JXiQQr0eFJX7YUqKSm7+KZv
	qsWDLyAzzKWmMUUZdpypoWdD4+T2BE8dUGZbW2MCHWa/MIUiPA7dz+UDXhMqpcGywBfj4cc59c4
	kR9UYpQxhwERWEJayT5C91/HVgoc/8cSbNfbOeSfQbQ==
X-Gm-Gg: ASbGncswpa0BCPleqK+zh/FOaxCRj9vxJcM32rXenTztyXlGZ88fVaCNwcjBc7GmAhO
	S1Tc78SZOjJK/0r3qITXOJeKc9pHqc0nK5xMB05qeISMy2pcfrvSGpc7YwX/KWvrcf3rgC3/WiH
	x61ELtQbwLy07oaADX7lzh+UHnhNWApZKo
X-Google-Smtp-Source: AGHT+IFrKr2jOATSh5phGB7JDX3d0p2qTLIwC0enPg9MgjlANV5ZNeu2VZnogm+JbvBPSdfOD03MBfWftCNR0tBRptM=
X-Received: by 2002:a17:90b:3142:b0:30e:6ac1:372a with SMTP id
 98e67ed59e1d1-30e7d691099mr12156692a91.7.1747861458366; Wed, 21 May 2025
 14:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521160602.1940771-1-surenb@google.com>
In-Reply-To: <20250521160602.1940771-1-surenb@google.com>
From: Casey Chen <cachen@purestorage.com>
Date: Wed, 21 May 2025 14:04:07 -0700
X-Gm-Features: AX0GCFvHkqtUFc-QqB9enzcf-M5GCvbCgMbexO38pxocJAzfC9FE27WWxlR2Ro8
Message-ID: <CALCePG2f+aXvabQiJ-=jYL1c4Z-RZW-=Rkj3LLxXDW+WFXwuBA@mail.gmail.com>
Subject: Re: [PATCH 1/1] alloc_tag: handle module codetag load errors as
 module load failures
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mcgrof@kernel.org, 
	petr.pavlu@suse.com, samitolvanen@google.com, da.gomez@samsung.com, 
	00107082@163.com, linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 9:06=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Failures inside codetag_load_module() are currently ignored. As a
> result an error there would not cause a module load failure and freeing
> of the associated resources. Correct this behavior by propagating the
> error code to the caller and handling possible errors. With this change,
> error to allocate percpu counters, which happens at this stage, will not
> be ignored and will cause a module load failure and freeing of resources.
> With this change we also do not need to disable memory allocation
> profiling when this error happens, instead we fail to load the module.
>
> Fixes: 10075262888b ("alloc_tag: allocate percpu counters for module tags=
 dynamically")
> Reported-by: Casey Chen <cachen@purestorage.com>
> Closes: https://lore.kernel.org/all/20250520231620.15259-1-cachen@puresto=
rage.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: stable@vger.kernel.org
> ---
>  include/linux/codetag.h |  8 ++++----
>  kernel/module/main.c    |  5 +++--
>  lib/alloc_tag.c         | 12 +++++++-----
>  lib/codetag.c           | 34 +++++++++++++++++++++++++---------
>  4 files changed, 39 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> index 0ee4c21c6dbc..5f2b9a1f722c 100644
> --- a/include/linux/codetag.h
> +++ b/include/linux/codetag.h
> @@ -36,8 +36,8 @@ union codetag_ref {
>  struct codetag_type_desc {
>         const char *section;
>         size_t tag_size;
> -       void (*module_load)(struct module *mod,
> -                           struct codetag *start, struct codetag *end);
> +       int (*module_load)(struct module *mod,
> +                          struct codetag *start, struct codetag *end);
>         void (*module_unload)(struct module *mod,
>                               struct codetag *start, struct codetag *end)=
;
>  #ifdef CONFIG_MODULES
> @@ -89,7 +89,7 @@ void *codetag_alloc_module_section(struct module *mod, =
const char *name,
>                                    unsigned long align);
>  void codetag_free_module_sections(struct module *mod);
>  void codetag_module_replaced(struct module *mod, struct module *new_mod)=
;
> -void codetag_load_module(struct module *mod);
> +int codetag_load_module(struct module *mod);
>  void codetag_unload_module(struct module *mod);
>
>  #else /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */
> @@ -103,7 +103,7 @@ codetag_alloc_module_section(struct module *mod, cons=
t char *name,
>                              unsigned long align) { return NULL; }
>  static inline void codetag_free_module_sections(struct module *mod) {}
>  static inline void codetag_module_replaced(struct module *mod, struct mo=
dule *new_mod) {}
> -static inline void codetag_load_module(struct module *mod) {}
> +static inline int codetag_load_module(struct module *mod) { return 0; }
>  static inline void codetag_unload_module(struct module *mod) {}
>
>  #endif /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 5c6ab20240a6..9861c2ac5fd5 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3399,11 +3399,12 @@ static int load_module(struct load_info *info, co=
nst char __user *uargs,
>                         goto sysfs_cleanup;
>         }
>
> +       if (codetag_load_module(mod))
> +               goto sysfs_cleanup;
> +
>         /* Get rid of temporary copy. */
>         free_copy(info, flags);
>
> -       codetag_load_module(mod);
> -
>         /* Done! */
>         trace_module_load(mod);
>
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 45dae7da70e1..d48b80f3f007 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -607,15 +607,16 @@ static void release_module_tags(struct module *mod,=
 bool used)
>         mas_unlock(&mas);
>  }
>
> -static void load_module(struct module *mod, struct codetag *start, struc=
t codetag *stop)
> +static int load_module(struct module *mod, struct codetag *start, struct=
 codetag *stop)
>  {
>         /* Allocate module alloc_tag percpu counters */
>         struct alloc_tag *start_tag;
>         struct alloc_tag *stop_tag;
>         struct alloc_tag *tag;
>
> +       /* percpu counters for core allocations are already statically al=
located */
>         if (!mod)
> -               return;
> +               return 0;
>
>         start_tag =3D ct_to_alloc_tag(start);
>         stop_tag =3D ct_to_alloc_tag(stop);
> @@ -627,12 +628,13 @@ static void load_module(struct module *mod, struct =
codetag *start, struct codeta
>                                 free_percpu(tag->counters);
>                                 tag->counters =3D NULL;
>                         }
> -                       shutdown_mem_profiling(true);
> -                       pr_err("Failed to allocate memory for allocation =
tag percpu counters in the module %s. Memory allocation profiling is disabl=
ed!\n",
> +                       pr_err("Failed to allocate memory for allocation =
tag percpu counters in the module %s\n",
>                                mod->name);
> -                       break;
> +                       return -ENOMEM;
>                 }
>         }
> +
> +       return 0;
>  }
>
>  static void replace_module(struct module *mod, struct module *new_mod)
> diff --git a/lib/codetag.c b/lib/codetag.c
> index de332e98d6f5..650d54d7e14d 100644
> --- a/lib/codetag.c
> +++ b/lib/codetag.c
> @@ -167,6 +167,7 @@ static int codetag_module_init(struct codetag_type *c=
ttype, struct module *mod)
>  {
>         struct codetag_range range;
>         struct codetag_module *cmod;
> +       int mod_id;
>         int err;
>
>         range =3D get_section_range(mod, cttype->desc.section);
> @@ -190,11 +191,20 @@ static int codetag_module_init(struct codetag_type =
*cttype, struct module *mod)
>         cmod->range =3D range;
>
>         down_write(&cttype->mod_lock);
> -       err =3D idr_alloc(&cttype->mod_idr, cmod, 0, 0, GFP_KERNEL);
> -       if (err >=3D 0) {
> -               cttype->count +=3D range_size(cttype, &range);
> -               if (cttype->desc.module_load)
> -                       cttype->desc.module_load(mod, range.start, range.=
stop);
> +       mod_id =3D idr_alloc(&cttype->mod_idr, cmod, 0, 0, GFP_KERNEL);
> +       if (mod_id >=3D 0) {
> +               if (cttype->desc.module_load) {
> +                       err =3D cttype->desc.module_load(mod, range.start=
, range.stop);
> +                       if (!err)
> +                               cttype->count +=3D range_size(cttype, &ra=
nge);
> +                       else
> +                               idr_remove(&cttype->mod_idr, mod_id);
> +               } else {
> +                       cttype->count +=3D range_size(cttype, &range);
> +                       err =3D 0;
> +               }
> +       } else {
> +               err =3D mod_id;
>         }
>         up_write(&cttype->mod_lock);
>

Overall looks good, just one small nit: should we not increase
cttype->count if there is no module_load callback ?
Personally I prefer having tag allocation and counter allocation at
the same place in move_module() by calling something like
codetag_alloc_module_tag_counter(). But your approach looks more
modular. I don't have a strong preference, you can choose what you
want. Thanks!

int codetag_alloc_module_tag_counter(struct module *mod, void *start_addr,
                                        unsigned long size)
{
        struct codetag_type *cttype;
        int ret =3D -ENODEV;

        mutex_lock(&codetag_lock);
        list_for_each_entry(cttype, &codetag_types, link) {
                if (WARN_ON(!cttype->desc.alloc_counter_mem))
                        break;

                down_write(&cttype->mod_lock);
                ret =3D cttype->desc.alloc_counter_mem(mod, start_addr, siz=
e);
                up_write(&cttype->mod_lock);
                break;
        }
        mutex_unlock(&codetag_lock);

        return ret;
}

Casey

> @@ -295,17 +305,23 @@ void codetag_module_replaced(struct module *mod, st=
ruct module *new_mod)
>         mutex_unlock(&codetag_lock);
>  }
>
> -void codetag_load_module(struct module *mod)
> +int codetag_load_module(struct module *mod)
>  {
>         struct codetag_type *cttype;
> +       int ret =3D 0;
>
>         if (!mod)
> -               return;
> +               return 0;
>
>         mutex_lock(&codetag_lock);
> -       list_for_each_entry(cttype, &codetag_types, link)
> -               codetag_module_init(cttype, mod);
> +       list_for_each_entry(cttype, &codetag_types, link) {
> +               ret =3D codetag_module_init(cttype, mod);
> +               if (ret)
> +                       break;
> +       }
>         mutex_unlock(&codetag_lock);
> +
> +       return ret;
>  }
>
>  void codetag_unload_module(struct module *mod)
>
> base-commit: 9f3e87f6c8d4b28b96eb8bddb22d3ba4b846e10b
> --
> 2.49.0.1112.g889b7c5bd8-goog
>

