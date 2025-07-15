Return-Path: <stable+bounces-163024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1F6B066BA
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 21:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A101656598E
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 19:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45C9298984;
	Tue, 15 Jul 2025 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6SAFPHN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066B115B54A
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752607348; cv=none; b=GUQnG/AQxfTmv4CAaEbpwpxi/H58wUHMhrVZZwOS4goiGfoLVITfRfAKA7goJY+sr9zBg/3s8AsMCNQVls9d0lcDqLsHpkVI/0kQfy+G+GfXdiL1mwo18myagfVxZTWTpDO5ihe68WrssvISV7SioSobppXDVr0TWSC/rUrNg7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752607348; c=relaxed/simple;
	bh=oToBQFl/oLRd6LiRFPZA03xR1Ux9Gmb9vRekzdonvbY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TObGoGh4ibJ5OqcvfefhxYfCFIhtQKEznMb+WhTaE4SJ2TLiuTHwDdCZdwr7cfS6CK8iqw+I4eqyt37TayBM+NSlPGwN7YzlaUhM50GgSvypcI7nKD+ctEB6gGEuWdvKP9GLaEf6+u4S12/4FBHy6RM8fCoKkjTSN8tRXBWYXQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6SAFPHN; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748f5a4a423so3589021b3a.1
        for <stable@vger.kernel.org>; Tue, 15 Jul 2025 12:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752607346; x=1753212146; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Iqx4Xcv9AghIcTSzHdS9SKVSVY1/cLSo0iNuXyESICI=;
        b=l6SAFPHNy1tzK8q9C8BA67dhmkC8QBXht065oM8a5s05tO57UxvHp4cx4EegO/JKtb
         S5wB6LiGbKnsvY39ILEJJMmxKZKpEMRGyStVGWqF/AfBXDfavyAjHOk9tzq/I/WJjZ96
         D7CHWuxOEyvXerGZ0i0CwZRQOMgmy3u3t/IOURM0eCC0agIe7GB0DLHZKiH6nq3tcmb+
         RY9BXXTpS1xYdP7PmElGd9rJOp8HyPv9MjPrNP1b6EDkwwgEVYK6ajwX7bIpdLvcDZzM
         1zDAKNNKnDfOYRF11VEpcZcZxW8tc1DcHvi2H9bVP/VyTGv1r4/8s+4F2jSBEC6wXX1X
         L3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752607346; x=1753212146;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iqx4Xcv9AghIcTSzHdS9SKVSVY1/cLSo0iNuXyESICI=;
        b=Zn9eAogIgreV+8vcIOnU9bON1u94mzk4YQJIJTof8LTnlwswNeyv+3VOjD6RGn+6rh
         LRrOClzo8TSSP/xkUOFjK6oZbmcmHm2HPbMzbTB+7di5PVcnKFeRxj0LJQYsu5h9bkRL
         /cttPZ4wpP4CxMQ5vl3BqUPVTEH4ZnMIeh2WvJqgEn+67hx5wp0oRlkInlJ4EkcUZTgu
         vBpEqMuo/vawwq6PRp/UxKztC7jh6mV+1c7KB2WeVFiHQIaSq+Me1eeEKFXKetx7tAX9
         Axh8F+Ysdu3BoA+yk6zeLU8bxTM5ZGIX+W7tx3knlCr1cAm5rDacmATKr8++tNNFLz4Q
         iw2g==
X-Forwarded-Encrypted: i=1; AJvYcCUuWnJkzryLKr+yWcmp+TIcW0tEBQNmBFTDe1Ihqbd8t2JYM4MEomCtEuKkLYDK1LR3yaZVwmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6w7hJB+Q5Xm4sHfhipkh8t06ADKD5D2ngBXwFQpM7zdnbSVA6
	2Cwsuo7ZoUwIJMJiQnZFcAil2g8oK7OR6qOECeLIFx5sr3QbmSQMWN9xRjNsIg==
X-Gm-Gg: ASbGncvlCPKiI1XDyfKR3ScH3AXansMlQV3GNJ++i/wcPAx2kupQOiGl6DA0zh/Tblb
	ZEZPntUfEbYQmlC+9usAMyUOKV0zjvSsNC8MUSVuElPiYiYtvu5t7BNkvWTF3xJGK+GdXWk+2sE
	rjr8azCgzMkEF4FcTszBm54lTvWDVbXPmHC+OgX0KKNdA+Hwg6o+TCGTDzJcQWqC9n7qRQ4J84R
	cJXkIGYMZ0ZklKLIn5oE6eDvTwjqkjrAfTsUIQeM+GJFI4qILpN2VFxn+BPhHzZNjf5LMs2R7P6
	pCcDAP3uRLhxD1hsjCp+/es4TuEp+xtcePjgbaLtRLnGSAthDs8QFV63vCzY+FFDj6l1Z7cgfee
	2P5D1RujfXpofQrs=
X-Google-Smtp-Source: AGHT+IGV6Us7AntuLGK7LUcvMm8vOdgXM0pfw7/6EBueWdz0EwmPy4ABRhhK9UDAFn5UFat+mPggcg==
X-Received: by 2002:a05:6a00:1783:b0:74e:a560:dd23 with SMTP id d2e1a72fcca58-756ea5c7fdemr778177b3a.21.1752607346128;
        Tue, 15 Jul 2025 12:22:26 -0700 (PDT)
Received: from localhost ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd605dsm12993248b3a.18.2025.07.15.12.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 12:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=3fb2b530144c5e186ba68dddb0f636d694b930e5d15f164eaa64d2f185cc;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 15 Jul 2025 16:22:22 -0300
Message-Id: <DBCVGAAFB8Q3.21ZP9FUITWDI9@gmail.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>, <patches@lists.linux.dev>, "Mark Pearson"
 <mpearson-lenovo@squebb.ca>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 5.15 53/77] platform/x86: think-lmi: Fix sysfs group
 cleanup
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Sasha Levin" <sashal@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250715130751.668489382@linuxfoundation.org>
 <20250715130753.855799519@linuxfoundation.org>
 <DBCUJ1QHGTKA.3H4TW1FB3FYJC@gmail.com> <aHamVeuNznVqMb2x@lappy>
In-Reply-To: <aHamVeuNznVqMb2x@lappy>

--3fb2b530144c5e186ba68dddb0f636d694b930e5d15f164eaa64d2f185cc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Sasha,

On Tue Jul 15, 2025 at 4:04 PM -03, Sasha Levin wrote:
> On Tue, Jul 15, 2025 at 03:38:58PM -0300, Kurt Borja wrote:
>>Hi Greg,
>>
>>On Tue Jul 15, 2025 at 10:13 AM -03, Greg Kroah-Hartman wrote:
>>> 5.15-stable review patch.  If anyone has any objections, please let me =
know.
>>>
>>> ------------------
>>>
>>> From: Kurt Borja <kuurtb@gmail.com>
>>>
>>> [ Upstream commit 4f30f946f27b7f044cf8f3f1f353dee1dcd3517a ]
>>>
>>> Many error paths in tlmi_sysfs_init() lead to sysfs groups being remove=
d
>>> when they were not even created.
>>>
>>> Fix this by letting the kobject core manage these groups through their
>>> kobj_type's defult_groups.
>>>
>>> Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface suppor=
t on Lenovo platforms")
>>> Cc: stable@vger.kernel.org
>>> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>>> Link: https://lore.kernel.org/r/20250630-lmi-fix-v3-3-ce4f81c9c481@gmai=
l.com
>>> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>> ---
>>>  drivers/platform/x86/think-lmi.c | 35 +++++++++-----------------------
>>>  1 file changed, 10 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/th=
ink-lmi.c
>>> index 36ff64a7b6847..cc46aa5f1da2c 100644
>>> --- a/drivers/platform/x86/think-lmi.c
>>> +++ b/drivers/platform/x86/think-lmi.c
>>> @@ -491,6 +491,7 @@ static struct attribute *auth_attrs[] =3D {
>>>  static const struct attribute_group auth_attr_group =3D {
>>>  	.attrs =3D auth_attrs,
>>>  };
>>> +__ATTRIBUTE_GROUPS(auth_attr);
>>>
>>>  /* ---- Attributes sysfs ---------------------------------------------=
------------ */
>>>  static ssize_t display_name_show(struct kobject *kobj, struct kobj_att=
ribute *attr,
>>> @@ -643,6 +644,7 @@ static const struct attribute_group tlmi_attr_group=
 =3D {
>>>  	.is_visible =3D attr_is_visible,
>>>  	.attrs =3D tlmi_attrs,
>>>  };
>>> +__ATTRIBUTE_GROUPS(tlmi_attr);
>>>
>>>  static ssize_t tlmi_attr_show(struct kobject *kobj, struct attribute *=
attr,
>>>  				    char *buf)
>>> @@ -688,12 +690,14 @@ static void tlmi_pwd_setting_release(struct kobje=
ct *kobj)
>>>
>>>  static struct kobj_type tlmi_attr_setting_ktype =3D {
>>>  	.release        =3D &tlmi_attr_setting_release,
>>> -	.sysfs_ops	=3D &tlmi_kobj_sysfs_ops,
>>> +	.sysfs_ops	=3D &kobj_sysfs_ops,
>>> +	.default_groups =3D tlmi_attr_groups,
>>
>>I did *not* author this change and it utterly *breaks* the driver.
>>
>>This patch should be dropped ASAP.
>
> Right sorry about that - I accidently left that extra line of context
> you've pointed out. Dropped now along with the other patch you've
> pointed out.

Thank you for the quick response!

May I suggest informing authors and maintainers about manual conflict
resolution in the email's subject?

This resolution was not acked by anyone and I don't appreciate that.

In the past couple of weeks and I got like 50 stable related emails. I
simply cannot check each and every one for things like this.


--=20
 ~ Kurt


--3fb2b530144c5e186ba68dddb0f636d694b930e5d15f164eaa64d2f185cc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSHYKL24lpu7U7AVd8WYEM49J/UZgUCaHaqcQAKCRAWYEM49J/U
Zr9RAPwPLJ1jZQIFHed5MmIJjqgvv3W5l3iwhO5EPzVer0ZMAQD/bOtKqWbD1ovC
aJ+ozq1HW4kFHCTZleLVVL2YzgzrqAQ=
=VUQ/
-----END PGP SIGNATURE-----

--3fb2b530144c5e186ba68dddb0f636d694b930e5d15f164eaa64d2f185cc--

