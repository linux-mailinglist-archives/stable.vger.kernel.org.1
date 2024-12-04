Return-Path: <stable+bounces-98565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB49F9E477F
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29881284A68
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 22:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F801A01BE;
	Wed,  4 Dec 2024 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LWnw+FQf"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FE023919F
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350102; cv=none; b=o9nIuizPE/ZfzrdPRs/vaO2IU480/QvndbplP8RS1lzJkINUNfPNgew9LzvlhLLpWcBM919Z51F5fboPhQx1SMy+ucavZ5su8s3blQpVu3e1byeIuTniAl2yAu223Foa1LiVdCLO4qlLN0krlI5LvVFiTaolq40DpNzy0cLLY2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350102; c=relaxed/simple;
	bh=q5OhOzwVG+k/pOiLTI389gqSC97MS66v9zEBOF5UeMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nzqrh9XwgWZgMp4gcwdHjvkKoOaqRdH2+u+hMgYeMJYivxDVeoNhpmvBXi6jozms9qe76nkoohBmvPl4fv2nJomthhhXdraiFZiT837gh39yA/ySdQfPpT9WpvbU7RmOMLOgwD+4bd7vST/zjMT5Tox2dioR+5gG6gDtZono0iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LWnw+FQf; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e398273d6ffso378794276.0
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 14:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733350099; x=1733954899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrwnGgCCWRQTdxJ9OT4Enu4LhAL/3xLqgw2hy87dtYc=;
        b=LWnw+FQfpWHpcO+EjOSRusQbv+QgZD/t6U3luZHTfQ5leJFP7CT4rAbBY7NnMd8CgA
         0ttbCkn5VzZ5vw1AhmihemJhZGxdZLgG2QtSMQWlNEbG+jjTkbZPvzcvZsqU6iL1wbPD
         AMyLCbXwONlR/8Dwtb93r0zNqdxurt7rjkb4ARTk5Xobt8kioITIMtYhRP9vqDFwZUQV
         Hm6Tba9M9Ri1soDZ9u57Sy2vOHEzrnI2zBz/NKQZ8bgRuB9ITims6UYF4pGTMQnPwfXb
         Smrc2y4egKsMZMzKWWBWZBChjNYXKNA1pIEnD0EyDmVMW2FP/XFHFvEzDzIldAJv8irp
         8U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733350099; x=1733954899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrwnGgCCWRQTdxJ9OT4Enu4LhAL/3xLqgw2hy87dtYc=;
        b=lq8jj6ug89hvXLg7OFNSUxMHl/SNye39tCGp2Vao+EJTSl9HmTXba6mcel+DPUjU/b
         hMCaGvjWNtfNN/9yvK1kPjm8/XD5INUqZA+8u+o/GXIa6vBv6uxpQVPVvfTngLtCy4cv
         9EsYQhjz5v9qbxUl7xblXIaqEqohTtpswbYV+B8daeafVqJX1MOg21vECPnFv3ybydf9
         4SMcQ0fjhvtl+au2wipEd6nNcus2fk9+u14l7uJzSwopDOXZ7wqCWQ17BmPsNTgV7H/p
         GV7rpyzE3AZmaQfYJDqw7oyVffNMgOgJmnkED9lOSXKwOde83Zti7DUpq6gaP77x1PGM
         9QlA==
X-Forwarded-Encrypted: i=1; AJvYcCXwpaM8q1B0X8deU/AQiHzNDgC9ejB1FkMm53JjB+Atq38ApQhgWUXP2cusWXsZy9qdhS94O4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQDEHQxIpVPyeIC52jg8H2fpQvcDZXj12FVgV9iX7DzYwCR3E
	9JDmDt7c2GKhv5MZX6WhaPzxZqrF7Ooed/Tk3cr3XfLwhe9g9P61bh7Xo86WKncB+vkChlgT7AE
	a5dgFrcmWM06NSndzCZV6uI/WxGRLflpy6hhS
X-Gm-Gg: ASbGncubFHpv3xo1MGlFRxlkEQKVTJJozQmk+ly0D3krqvMLVbRT96XuNropCxebvGR
	t/DWGWcdCdjYsfBvcizBCKOXB9qQYLw==
X-Google-Smtp-Source: AGHT+IG9J5dfJZtkdH4Xl4lwZXjltkdTFM/VIpSFWhQTq9Yxj5XvuqJj4SKWPdWcqJCxskqSjKkd2zQirO/VWFATcUE=
X-Received: by 2002:a05:6902:1a43:b0:e39:a15b:907d with SMTP id
 3f1490d57ef6-e39d4387f53mr7736105276.50.1733350098841; Wed, 04 Dec 2024
 14:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203222741.1739916-1-tweek@google.com>
In-Reply-To: <20241203222741.1739916-1-tweek@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Dec 2024 17:08:08 -0500
Message-ID: <CAHC9VhQxcNtVLkORLFkd=a=_aEfYreRJt-xs3ZRdXwqd9sjBmg@mail.gmail.com>
Subject: Re: [PATCH] selinux: ignore unknown extended permissions
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 5:27=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@google=
.com> wrote:
>
> When evaluating extended permissions, ignore unknown permissions instead
> of calling BUG(). This commit ensures that future permissions can be
> added without interfering with older kernels.
>
> Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> ---
>  security/selinux/ss/services.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 971c45d576ba..2fa8aebcb2e5 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -979,7 +979,8 @@ void services_compute_xperms_decision(struct extended=
_perms_decision *xpermd,
>                         return;
>                 break;
>         default:
> -               BUG();
> +               // An unknown extended permission has been found. Ignore =
it.
> +               return;

There is also a BUG() call lower in the function when it generates the
extended data, do you want to update/remove that as well?

It also seems like we should have a pr_warn_once() or
pr_warn_ratelimited() message here to alert the admin of a mismatch
between the policy and the kernel.

>         }
>
>         if (node->key.specified =3D=3D AVTAB_XPERMS_ALLOWED) {
> --

--=20
paul-moore.com

