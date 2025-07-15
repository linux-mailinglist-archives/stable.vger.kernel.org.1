Return-Path: <stable+bounces-163016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F62B0661F
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 20:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D8B501792
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 18:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04A42BDC2B;
	Tue, 15 Jul 2025 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUmKw7Ev"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292934545
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604744; cv=none; b=L3/+2ZrlPv2FEi2J2ZNbOCYUwCW3GVsYMf4gQdeerXXfbR85wIdhMzK/eFTodE0jQ2YtwI7LTOBN6UobQvqa/tvkyWN+VPPAqlXB3K0mQgaEIXhFvNEO/gWE9tmH5VCFDP0RdMd+YqDRHhiV9jEfetYnMztRdzWN77sX4151Tb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604744; c=relaxed/simple;
	bh=I8L3ew79X5CSvq+s/7n8cEYRMDXbbDNRkMsVvRH9Jfg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=drzud+0Z0gK4E+m4/G+Kh2yoM+WDgGd3gL9EWgPQXs4Js7qhgmB5oEz2mKCgdM0H8Scg7mjavGRaKKH0l5reP1k6fNuwTV9JUt4FqOKvSFs3ziItPVWQW968jcra5rBhPoquexIaUImyFJImtbaSDmZxWJRsQ9kIwPRjIiDnB5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUmKw7Ev; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2c6ed7efb1dso3809974fac.2
        for <stable@vger.kernel.org>; Tue, 15 Jul 2025 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752604742; x=1753209542; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=80i78qYt3Pv+lypvP3B4IMlSZ1afCERVWEA7YyAzlDE=;
        b=eUmKw7Ev8BVGzcF9IvmlFgdvCu49DRwBZbhUUN2d770w6VieoTcDwvnYCLEBJpqbzf
         cu4ZyZ9WnKS05GC1eDAz47wWkLXJLanER999XJNlWiW+AkZuXvROldlz90Ta+RYABdcQ
         Kx5BcXbR9h/LuQb+wR+LKdYgfa5cvSbQIRYqhxKUsAAA+4cc207kA2DRp4RmMur5HNm8
         H2xvV2Hd/EZS4kb01aeiX2uhtkvrbi2yenO/2+JX/rvURQwI/kGVjlf2X6mQ1jEO1+01
         HRiFmb9T6ghh6aZByLyReWz4/JxbdWhpCJYeM/Or+V3xT89EmAU47ulWg1zh7ag2G5V7
         unsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752604742; x=1753209542;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80i78qYt3Pv+lypvP3B4IMlSZ1afCERVWEA7YyAzlDE=;
        b=g4zjG42qQljqJB67fTKcNVI3K028j9MGcNYnjO/Sli0P6XN9VeH4btgoAeW474XuQU
         Bq4NNvR9cbJ6c7R/M/a2zBse5OtdW9LmxiMwmeY8wzvDU8d/3o6kf50AVRACCDKxKgF8
         ziZkAD+UxPBdyXR3Za3vkJFVhR7SzltgsHW64SYH6hMDQvoxHYQKlM2BVLoDtejJzqJl
         vmqrI8S4FI+0a4BlCYALRkiOloTsTQj65dgKojzh4J7lcI8nfJPZQIsFTRGlFo+2HsiV
         4iPyhgrZr1gNTz0vJTM4jo+9JdB+c1VrDxrwhEe/RyUx6+b2gl7493VXrM9oviN3UEcH
         eavw==
X-Forwarded-Encrypted: i=1; AJvYcCX27jzACtZjte/zWtucaLvljM2NwxirQNpSIa1Y2ABKHn5kyxs3/Tk2ZGyaY9DPqDw6kJgIT38=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsoK6wFa6algMb0nmxKKf6WeE67C5TbqiWo6zLK6R6/oHx5Ood
	lvTNcdYc+gRVdArjQXK6KaBOArQKOpm+2v5qer5J4swV0RohKGr+fzAl
X-Gm-Gg: ASbGncuiWxuGH/BIUqQ6lUZsvpPuyKDp1B79SV4WyuOSUPNW+nISaMMcDvamzXmbBAq
	M2LuYsSE6OguYy8XAM72mZJBfVegTtWv22VFqCKhhBkFQjtbm5CdDYLsB44gjpTSqY8ZD7NGmcp
	2605yHgdNwX7UoYK3QkWF8+6+6O1ZTZYKJADBaz+awnn23kV/WuqovWyKXBuyv7xOJJ/DD8FdhN
	5TfjJyCoc5v3znMBnIddhsbjDw4mtRd1z16+D5sh2YN59cZpcI7OOv56SsNo4TrfSoAUJsoQkLC
	bPkkzNa0Zxb6pBbg4N+wkJ0CgJSLBcDrigUbSDU4WlEcPZx7M0mc1gKdNVNnlAML7JOFO5ScwKL
	JfPLqWEEo472KbRc=
X-Google-Smtp-Source: AGHT+IFY86/4L9JmlcJO5FaTpJNoLzHbjQg+twhXtC3EPeJbMGjfusO5WXBfvalsGk/8tcQcciHr9g==
X-Received: by 2002:a05:6871:529a:b0:2d4:ce45:698d with SMTP id 586e51a60fabf-2ffaf235f3amr542268fac.4.1752604742003;
        Tue, 15 Jul 2025 11:39:02 -0700 (PDT)
Received: from localhost ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff116d68a8sm2830718fac.38.2025.07.15.11.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 11:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=acc470c6f884e867562e65ba2487d89062f142533239f6b3138001d72221;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 15 Jul 2025 15:38:58 -0300
Message-Id: <DBCUJ1QHGTKA.3H4TW1FB3FYJC@gmail.com>
Cc: <patches@lists.linux.dev>, "Mark Pearson" <mpearson-lenovo@squebb.ca>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Sasha
 Levin" <sashal@kernel.org>
Subject: Re: [PATCH 5.15 53/77] platform/x86: think-lmi: Fix sysfs group
 cleanup
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250715130751.668489382@linuxfoundation.org>
 <20250715130753.855799519@linuxfoundation.org>
In-Reply-To: <20250715130753.855799519@linuxfoundation.org>

--acc470c6f884e867562e65ba2487d89062f142533239f6b3138001d72221
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Greg,

On Tue Jul 15, 2025 at 10:13 AM -03, Greg Kroah-Hartman wrote:
> 5.15-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: Kurt Borja <kuurtb@gmail.com>
>
> [ Upstream commit 4f30f946f27b7f044cf8f3f1f353dee1dcd3517a ]
>
> Many error paths in tlmi_sysfs_init() lead to sysfs groups being removed
> when they were not even created.
>
> Fix this by letting the kobject core manage these groups through their
> kobj_type's defult_groups.
>
> Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support =
on Lenovo platforms")
> Cc: stable@vger.kernel.org
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> Link: https://lore.kernel.org/r/20250630-lmi-fix-v3-3-ce4f81c9c481@gmail.=
com
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/platform/x86/think-lmi.c | 35 +++++++++-----------------------
>  1 file changed, 10 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/thin=
k-lmi.c
> index 36ff64a7b6847..cc46aa5f1da2c 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -491,6 +491,7 @@ static struct attribute *auth_attrs[] =3D {
>  static const struct attribute_group auth_attr_group =3D {
>  	.attrs =3D auth_attrs,
>  };
> +__ATTRIBUTE_GROUPS(auth_attr);
> =20
>  /* ---- Attributes sysfs -----------------------------------------------=
---------- */
>  static ssize_t display_name_show(struct kobject *kobj, struct kobj_attri=
bute *attr,
> @@ -643,6 +644,7 @@ static const struct attribute_group tlmi_attr_group =
=3D {
>  	.is_visible =3D attr_is_visible,
>  	.attrs =3D tlmi_attrs,
>  };
> +__ATTRIBUTE_GROUPS(tlmi_attr);
> =20
>  static ssize_t tlmi_attr_show(struct kobject *kobj, struct attribute *at=
tr,
>  				    char *buf)
> @@ -688,12 +690,14 @@ static void tlmi_pwd_setting_release(struct kobject=
 *kobj)
> =20
>  static struct kobj_type tlmi_attr_setting_ktype =3D {
>  	.release        =3D &tlmi_attr_setting_release,
> -	.sysfs_ops	=3D &tlmi_kobj_sysfs_ops,
> +	.sysfs_ops	=3D &kobj_sysfs_ops,
> +	.default_groups =3D tlmi_attr_groups,

I did *not* author this change and it utterly *breaks* the driver.

This patch should be dropped ASAP.

--=20
 ~ Kurt


--acc470c6f884e867562e65ba2487d89062f142533239f6b3138001d72221
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSHYKL24lpu7U7AVd8WYEM49J/UZgUCaHagRAAKCRAWYEM49J/U
Zk3ZAP92t38XQIYRJWuljb68R76QUHIpl0O6hNcW/vqrjw+c+AD+IM+NEeAczSX3
73Y71kPT8UV5dZEyGtXL74YO1AJaAQI=
=gIcr
-----END PGP SIGNATURE-----

--acc470c6f884e867562e65ba2487d89062f142533239f6b3138001d72221--

