Return-Path: <stable+bounces-248904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DvXAhd5B2pL4QIAu9opvQ
	(envelope-from <stable+bounces-248904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 21:50:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 592FF5571E3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 21:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 518253026F1B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF912D0C84;
	Fri, 15 May 2026 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+0VULYB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35671239562
	for <stable@vger.kernel.org>; Fri, 15 May 2026 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874591; cv=pass; b=ZbnfDWSd6czQnGMjX4kkenbeUc1dB8DmzaIlYRhHDlxGk94/KBt1Zlz6Tdt34+xTJ0pjlOSrFixkZ5pzDnLPiN6aowc/+d2r532SuCAO4wguMei+GwCJ0EXCZtaH8vNJEeNxCM1xfy/hLs+uG+WeSMctH6Qo4mVkbyvPSA0DXTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874591; c=relaxed/simple;
	bh=7GxTdDyRZn8E+iKjGgyBFLAj2qAgtyJ3AFZlUlQjvac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0jGccme0tkmiS6+uwdKUMlso99AmmYBEvHhF4vLAWj5+DmrOCTdLefJR/YeNR3B6sHpNb44CvMzVhzq8YXsgz8vQ+mvLNKAOACp1Y+RJivcBfzgRICcCYBhzEojSo6kSzAJyzxGB3jApNg/xzDA7t8whO9cDzCX0t/1z7Cb8PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+0VULYB; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bd4f7f05e90so33819766b.2
        for <stable@vger.kernel.org>; Fri, 15 May 2026 12:49:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778874589; cv=none;
        d=google.com; s=arc-20240605;
        b=kfa/XAfA7lIjHS7wm2d1/VQE06peSi4RQh3pjJbpCvw4jhKueQ/YfLWkiN7k5bp6WQ
         A2iD6wm2dH0pNAhqXn5FJ5QLrebM6Ltmt4+9H1964oStx25h0wwunIwOxQCXSNs2gi23
         h1l0Rlej1/Sf39Qcd5mGYF6Vh7QUqi742m98pLLbPgFHDFGWGzYQGejohMYpTGuzPw2e
         sRkWoK+Vq+HXviZiZGAb/KlpPJUYDxdgbvPZIpj8ca3BZHkVXM7tuWolgM/b0Y8XzQuj
         tuCQGOBaFsUSGuhGGjQC/Jh9D2Fm/6ZpSA5lEmDFPgZF9WP4J1ZPrFM44kDlXEobV1i9
         +PXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pkgl8ZnS3HS5+fJnS7bmbyJkmLbqIPNkR/OfPnxajBs=;
        fh=IzOW+jn2QgmmtRBa5pLkdBMff8jNTtEZpYMccVcENRk=;
        b=Jqd33KS3Or21oN0131M2ZwGTfNBj3CjBxbp6mtlXnhhFzW9VdGKKZ+7f9ocUb92abi
         BgUnAc7CIMY/9/lGpJfSeJG8eXjyWOXNeDogXJHeucVVgC8OkhqlLbeP3kRPIDVsh6Rb
         xTnHq0yyRVFwVQHu+O8s/FHShgupmPlGYD3mkZjZFrIS1K1PviFehxW7EcOn90Pmvowa
         ok5e4cEPssouA2M6kZUm1eZ9DtF3B+rR1mLO+dxTpYa1lq9W9Xutqtv1CKKXdJ+r9l/2
         IPcKBLfCp7X7vXR3LSU0i4uVU8L7VjBiBElfHGQnVn2L41AZXCCJTn+RRXQ+g3rfLx0D
         yzFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778874589; x=1779479389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pkgl8ZnS3HS5+fJnS7bmbyJkmLbqIPNkR/OfPnxajBs=;
        b=P+0VULYBrh/oy+EVn+WklzZLXw43V7hgoLD5YjhGn88lN3fDzIZbs4LTx7I4mlht8U
         xcRibuZwtEznG4yhhu+16696KgXz1vTBr45+OfjtcqxyuMF2f6oV4gBwiIULAR5TYokt
         LrBDxS1xP84FhxUHXc6zim1/bY61PXvnL5+qOabpWaLnmsCclSthR39qabdB8TaDtJjx
         +wHqGjwAUQMYZSwotRw3ynvnLGLTwFKxq9P2/AHmr8MRxa9VgMKzaxargE9bbKBuQUOZ
         iNaLjfzR6osEGYBJ+OeZ+2Ohn2spegsZ9tHDmJRRstjgP8FoWcrWdzsbGZvD1iY70E6l
         2m6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778874589; x=1779479389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pkgl8ZnS3HS5+fJnS7bmbyJkmLbqIPNkR/OfPnxajBs=;
        b=OFyEo3V1wEGKXc8/TWwoRFtesByAqBbTtTCouQzHB/7/OT9zvy3W3b4L8ZHBsX3CCr
         Dx6sU9MKuSyt942jT9xCWwztGAOGFi/UV9iS6RGEQoG4g6LWh+icTkYbgYn+8Iq2jjfh
         XVKFtp+f6ZbHLfNVY78d+BFeU15PsVt8htyXv0VqCr4VBfHyfWoSkHlTb0sGWd+9h82i
         wBOG92caaO6hHEQkk7G8I/ICHZ+prdPlHj2OGr6eY90mRyxNNT28un6SWP7L42QlvZqH
         8MQSPP/npsxjbtok51lpw2c5mT2FfOGDM1djYWojk2db4o34HNqiDWigy3dGPWIbAPUa
         IFSg==
X-Forwarded-Encrypted: i=1; AFNElJ/NyalL5zxrnUwS2adGZrPkuvmqrbZmDdNOA8M+FAHQJjmcwM1Wu4LvUmWVUDURcSF95CX4a7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJjjFGH5oXe2fM/vN9bCqozCdEj/urhqfXim6d6NJYIrJWDgc
	79ooyALcCXaEUHclohem7DwxdNPR7kXYwWVYgDsetFDD+mr8E4bPiduWSgKiTol74Dy2w+27zAS
	dLS3hniVzHKTf021Qt+RX4VT67gXOLCA=
X-Gm-Gg: Acq92OEfK//ZuyQht8EbCp4thBVQ54fHeKAQJbQWdnOnmHXZH7OXN1kJiBfkL3+woXJ
	QaFb0IgBMs1qp0CRcxWUVBKILXG8pkOoDb2oGFKZhwrOw02Z+SyKhOfifeeuWXgzSBFKq+rq8ls
	Y9vGifOlIyBau8BisuSLpEeSzXXukzOoPIGmhNe+a+iSAZVwmnKSJ3nk05+KbHAqR91MxjqmCed
	wDL91Fj73vb3fMl+5EMPUg7OMqRH/OCj2HBLJSmGgMWX51+SnxUFIPhwopUCfRQVGANkVpJ91p6
	btpLZgZgrK5IGSzwvIeZgJBXc2QxcT1RcBLIw+wl+w==
X-Received: by 2002:a17:907:97d2:b0:ba6:e18f:1568 with SMTP id
 a640c23a62f3a-bd51797076dmr296076966b.32.1778874588611; Fri, 15 May 2026
 12:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514111354.3552538-1-nirmoyd@nvidia.com> <20260514144258.3068715-1-nirmoyd@nvidia.com>
In-Reply-To: <20260514144258.3068715-1-nirmoyd@nvidia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 May 2026 21:49:37 +0200
X-Gm-Features: AVHnY4L8qm9R6-_mhbzvddNr_Ax06itGXdxnNHato15ItBX6CxiYSHsayaZCoRc
Message-ID: <CAOQ4uxjEZzy3wOM9pm6BKB9v8862LjHbPT8SwU5TKx3wHsnwSw@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: keep err zero after successful ovl_cache_get()
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+a16fb0cce329a320661c@syzkaller.appspotmail.com, stable@vger.kernel.org, 
	Nirmoy Das <nirmoyd@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 592FF5571E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248904-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,a16fb0cce329a320661c];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 4:43=E2=80=AFPM Nirmoy Das <nirmoyd@nvidia.com> wro=
te:
>
> ovl_iterate_merged() stores PTR_ERR(cache) in err before checking
> IS_ERR(cache). On success err holds the truncated cache pointer and
> can be returned as a bogus non-zero error.
>
> The syzbot reproducer reaches this through overlay-on-overlay readdir:
>
>   getdents64
>     iterate_dir(outer overlay file)
>       ovl_iterate_merged()
>         ovl_cache_get()
>           ovl_dir_read_merged()
>             ovl_dir_read()
>               iterate_dir(inner overlay file)
>                 ovl_iterate_merged()
>
> Only compute PTR_ERR(cache) on the error path.
>
> Fixes: d25e4b739f83 ("ovl: refactor ovl_iterate() and port to cred guard"=
)
> Reported-by: syzbot+a16fb0cce329a320661c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da16fb0cce329a320661c
> Cc: stable@vger.kernel.org
> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> ---
> v2:
>  - Drop the now-redundant 'int err =3D 0' initializer and the trailing
>    'return err' in ovl_iterate_merged(); err is only used inside the
>    loop's update-check, so the function can just return 0 on success.
>    (Amir Goldstein)
>  - Link to v1:
>    https://lore.kernel.org/all/20260514111354.3552538-1-nirmoyd@nvidia.co=
m/
>
>  fs/overlayfs/readdir.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 1dcc75b3a90f9..e7fe29cb6028b 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -838,15 +838,14 @@ static int ovl_iterate_merged(struct file *file, st=
ruct dir_context *ctx)
>         struct ovl_dir_file *od =3D file->private_data;
>         struct dentry *dentry =3D file->f_path.dentry;
>         struct ovl_cache_entry *p;
> -       int err =3D 0;
> +       int err;
>
>         if (!od->cache) {
>                 struct ovl_dir_cache *cache;
>
>                 cache =3D ovl_cache_get(dentry);
> -               err =3D PTR_ERR(cache);
>                 if (IS_ERR(cache))
> -                       return err;
> +                       return PTR_ERR(cache);
>
>                 od->cache =3D cache;
>                 ovl_seek_cursor(od, ctx->pos);
> @@ -869,7 +868,7 @@ static int ovl_iterate_merged(struct file *file, stru=
ct dir_context *ctx)
>                 od->cursor =3D p->l_node.next;
>                 ctx->pos++;
>         }
> -       return err;
> +       return 0;
>  }
>
>  static bool ovl_need_adjust_d_ino(struct file *file)
> --
> 2.43.0
>

Christian,

Would you mind picking this one via vfs-fixes?

Thanks,
Amir.

