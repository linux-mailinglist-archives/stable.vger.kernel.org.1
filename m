Return-Path: <stable+bounces-163021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A0EB06666
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 21:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F351AA20AC
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 19:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F311EDA3C;
	Tue, 15 Jul 2025 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoZm7xnG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE516281358
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606018; cv=none; b=r6sbqo6Dd4ST2bxIIaIUVeJJ8r11z/i448+zqn4QUwxUP7nLP2PfmmVaLjfixYPA7tVmX2j+RNIF7w0fAv00szQZICDNeHWsq7fq3Esz2pIZ4E4pfpHuMp1ANprZBmnQe7E0RriqYWqxEaz/UlUYq66KR09uYeBnDsLkGmQ6gS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606018; c=relaxed/simple;
	bh=pWXwXM6tAdo40Zqoke4D1RqRiDl4ZRREhPbpU8XtXRw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=dwpmX9IRFmiNSnwqm7xCjD0u7BM62aQk7/yGBTscJzxIyOz6Uy4z4r1mbB2NJ3KptZ4DjxgofWyltmVtF9Ra0PV7smH9uQTNbfZrTTXY1Gu5uBqU4lXBj8mK68s6nNzfbkOQ6jxdU3I1Ci1DXf3sbS6vidvgetrGRiC7AFTERgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoZm7xnG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23636167b30so52968405ad.1
        for <stable@vger.kernel.org>; Tue, 15 Jul 2025 12:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752606010; x=1753210810; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B614pib7pAycthxoO8JsT0qk8Pb5A/7JMNSYzzDIx9g=;
        b=eoZm7xnG9Pi+iQECHm18YT13puv7PRJll26LBFcGJVL+Xe+sOtXwRuQdAisWcYY18D
         2bV4iBrI2KdZr2bqv0Urxgi1tGaA29uLU6Fs/i6lVvfYx7t3dz4iDFxT8iL2cqG8lzbT
         ajCfOAhuoUdcnqQJ/b1eb73U8m08+rQ1Twd6POA8ynJbwZ3J0UfAQYhxAEqVeblFFNmB
         VXOUvYR7kQCXWcynpU6AYrJ2nbCgHaRnw3RNSvFSJTCqpflKdiBomvEfg49EwZbrr/UK
         UnpKjA9IVAJfdNgJCCPdHMijNVisi6w4lP+mq21cY8PAk3yvSh3GrjSWP2OKE5zqfl7o
         gLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752606010; x=1753210810;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B614pib7pAycthxoO8JsT0qk8Pb5A/7JMNSYzzDIx9g=;
        b=KOhCYxysx8g06m/AWzO26IX2v7Sm26gt+HQVHQcrSTPkmxoNjGuvpjfZ+GxZ8wkwaf
         IFMkTWegghKmN9S6KMY2YhxpfpjcxxxHZfbLOKQxCJcvEL5fd5/4vSFFoSWQUnQ5nyop
         gO0IM+EDEcH0OluAOzqW0n9jIhYIMGlZ7syU9MdFd/SVxbU1s6EstgPnRJMkOLtc8WUQ
         oLcuTzHpzi2H4t+o06S+BKhbI0R9qPjsUrcrZAfWJZyrDpR+oAp5aRwIOiP0+MwHrHWP
         ADJ+4GhGvcH93Fj5hbKoQGlcMzpFEs8Ryvl6gyP/oiqHLkv+N+ZVWKARY1AUFTCbPON7
         vCGg==
X-Forwarded-Encrypted: i=1; AJvYcCX5RK0p5F3RT8CLhkGoYrl9uxIsErP2x+C+2484n/5c/2MeY/0VhCk9FzX1WFKqmKI6auUq5tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcNufuAXnihYPYstGmwjmC+vCvdreHM/3ORUhIJaQqBxK/KrL2
	++CdEqSPDIVZAwfa+jFpVGG+c4/vbt3y60eQlUlixpwlUEWVxG4uB51j
X-Gm-Gg: ASbGncu9VpfFnffHK017+UNAuyViZJ8D0iC0hmTGZhwe8bgTvsqmVFUHOYPOLlkJbO9
	oTS+w94rJ+9UW6eFzoTCvBIhL+sIAvARXgK+hJg49W4mSX/PpPzDUuH1GwnSI/f7r1sGcpMSZ8d
	UnWOJ2d1lCF0+rheV/8xKxTQJXaQJ4ZV25xvi5HpJ72zVSQYZ3HsuoKbFepPvc1sfaMbTu0XxrW
	0tgvAiYDNv0BflHUkdRIE5OHrta0MJJAtEIBmLh9ENz63wsb32zZ1X4JwfsOgLbohBgH5slYzP3
	dpavdIo+DYjMzp+iLgLuOe/dYro/ek+njk7ymZszZpNopHIKJ0QERZhVRDR4v5IkI0yLwOPoJbN
	jAVpRkhC8+OV7HXk=
X-Google-Smtp-Source: AGHT+IGXg63En8UwNbHvC3EVCnl48K0RJt2iU0X+MJUPoLgvwhmELNpjE06v08xMkZ1otSaUADAgkg==
X-Received: by 2002:a17:902:f64b:b0:235:7c6:ebd2 with SMTP id d9443c01a7336-23e24f4a447mr1572015ad.31.1752606009764;
        Tue, 15 Jul 2025 12:00:09 -0700 (PDT)
Received: from localhost ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4332e8bsm111828635ad.159.2025.07.15.12.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 12:00:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=88259b1cec92413ceb591c4ba6bff3312655c8c3fb7b4f234cc6a689c960;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 15 Jul 2025 16:00:06 -0300
Message-Id: <DBCUZ88MSEOA.1Z8AFHVC0U0T4@gmail.com>
Subject: Re: [PATCH 5.15 53/77] platform/x86: think-lmi: Fix sysfs group
 cleanup
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Kurt Borja" <kuurtb@gmail.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
Cc: <patches@lists.linux.dev>, "Mark Pearson" <mpearson-lenovo@squebb.ca>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Sasha
 Levin" <sashal@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250715130751.668489382@linuxfoundation.org>
 <20250715130753.855799519@linuxfoundation.org>
 <DBCUJ1QHGTKA.3H4TW1FB3FYJC@gmail.com>
In-Reply-To: <DBCUJ1QHGTKA.3H4TW1FB3FYJC@gmail.com>

--88259b1cec92413ceb591c4ba6bff3312655c8c3fb7b4f234cc6a689c960
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jul 15, 2025 at 3:38 PM -03, Kurt Borja wrote:
> Hi Greg,
>
> On Tue Jul 15, 2025 at 10:13 AM -03, Greg Kroah-Hartman wrote:
>> 5.15-stable review patch.  If anyone has any objections, please let me k=
now.
>>
>> ------------------
>>
>> From: Kurt Borja <kuurtb@gmail.com>
>>
>> [ Upstream commit 4f30f946f27b7f044cf8f3f1f353dee1dcd3517a ]
>>
>> Many error paths in tlmi_sysfs_init() lead to sysfs groups being removed
>> when they were not even created.
>>
>> Fix this by letting the kobject core manage these groups through their
>> kobj_type's defult_groups.
>>
>> Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support=
 on Lenovo platforms")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> Link: https://lore.kernel.org/r/20250630-lmi-fix-v3-3-ce4f81c9c481@gmail=
.com
>> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/platform/x86/think-lmi.c | 35 +++++++++-----------------------
>>  1 file changed, 10 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/thi=
nk-lmi.c
>> index 36ff64a7b6847..cc46aa5f1da2c 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -491,6 +491,7 @@ static struct attribute *auth_attrs[] =3D {
>>  static const struct attribute_group auth_attr_group =3D {
>>  	.attrs =3D auth_attrs,
>>  };
>> +__ATTRIBUTE_GROUPS(auth_attr);
>> =20
>>  /* ---- Attributes sysfs ----------------------------------------------=
----------- */
>>  static ssize_t display_name_show(struct kobject *kobj, struct kobj_attr=
ibute *attr,
>> @@ -643,6 +644,7 @@ static const struct attribute_group tlmi_attr_group =
=3D {
>>  	.is_visible =3D attr_is_visible,
>>  	.attrs =3D tlmi_attrs,
>>  };
>> +__ATTRIBUTE_GROUPS(tlmi_attr);
>> =20
>>  static ssize_t tlmi_attr_show(struct kobject *kobj, struct attribute *a=
ttr,
>>  				    char *buf)
>> @@ -688,12 +690,14 @@ static void tlmi_pwd_setting_release(struct kobjec=
t *kobj)
>> =20
>>  static struct kobj_type tlmi_attr_setting_ktype =3D {
>>  	.release        =3D &tlmi_attr_setting_release,
>> -	.sysfs_ops	=3D &tlmi_kobj_sysfs_ops,
>> +	.sysfs_ops	=3D &kobj_sysfs_ops,
>> +	.default_groups =3D tlmi_attr_groups,
>
> I did *not* author this change and it utterly *breaks* the driver.
>
> This patch should be dropped ASAP.

I double checked and apparently it does not exactly break the driver.

But still. I did not author this patch. It's similar from the one I
authored but still has other issues. It breaks cleanup instead of fixing
it.

Was this an AI conflict resolution?

I really don't appreciate the lack of transparency, specially when it
claims to be authored by me (!).

Please, drop.

--=20
 ~ Kurt


--88259b1cec92413ceb591c4ba6bff3312655c8c3fb7b4f234cc6a689c960
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSHYKL24lpu7U7AVd8WYEM49J/UZgUCaHalOAAKCRAWYEM49J/U
Zt03AP9RPeO+DDoeBYDtV2lxY0uoJz8T4pTzTZGmlqMJ9gk8PwD/WDQ6gKObLgX1
CSsQxgX5YggbhZzZpOrO0yotg+uYCwQ=
=oycW
-----END PGP SIGNATURE-----

--88259b1cec92413ceb591c4ba6bff3312655c8c3fb7b4f234cc6a689c960--

