Return-Path: <stable+bounces-163015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135D0B0661B
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 20:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6674E8232
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 18:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF5B28727B;
	Tue, 15 Jul 2025 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B156/TEm"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AD51F0E24
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604511; cv=none; b=AA39+Qv+Xqv4UpOF9B0y3a4duvlh9O2ZRh1KIidM3BpEJCzZfVSoWEtCWlFdFH2aqSf2o9jPxurA0K5RZkSLOJCR5VPpavby3+HVb7iunined764jnKi68QDcfgODzMSdQ9rU5zm9JvBaaqaPpAtHyOfw0zdLmMYZMb3hK2crcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604511; c=relaxed/simple;
	bh=cB14yFYuhIwaNnp7ptkeqN8RlAXDmLTGhT98GLOqRds=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FrN6T2+ypLI+T+ZjvN5SUJuoaa2CIffrCaM0Pxl2z+7yewBYP5c4I7LxgYLsO8vUSF6+cmZEiDElUCA52VEUAtIF3LUeSzcU4YklkT50RHy51+kb3e5ffpADb8sJrO1d7heTCDMfxaZkQVZ5orb40/Qkjc3ByirGo2FXwGs7yIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B156/TEm; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2e95ab2704fso3710516fac.3
        for <stable@vger.kernel.org>; Tue, 15 Jul 2025 11:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752604509; x=1753209309; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y7p0HxEBrQc3yVBJ7FV3yXNo/sxa6P26uZ67qwIZN2s=;
        b=B156/TEmx0u3vKQHLSNUSxPhpX7EiYTXpOAY/XTBf5rU8gyoX0f/9QMErUOvsyfEKy
         YAJPZvpZdSVXUL1DXXdeo0R2GVMe7KVyBu8GlDPwhuNX4Gayj3bE1PUBaXWGUmjxqx8K
         qMitF7H8q9qtO3nDUQnvOjrirp/GuUfhu+vyqmZ829bbQ/Qbbu7k1328n7ICLq1mxVSc
         1xpXZAiE/rj+X8uNH0VoU6lj3eA8ue2gsoQ8TU1UmEIYeuo7m1yozWesAEMS6uwWnFM/
         6RlwewSmGhmoYOwR2Y9DeFyi7WWpn+21eIZ5LhBKFXfnwHDtTXyB4eC8/W+FT2Xrg6o1
         DT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752604509; x=1753209309;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7p0HxEBrQc3yVBJ7FV3yXNo/sxa6P26uZ67qwIZN2s=;
        b=QchOq7ozIxT4nwfLxP3SDQSG9z5O2JdEdcezeYyJVoshoP1CqqYPpABZC/wGuFCinR
         HqrPyRix8t9lqis4MJsvYikwR2i0XU1WwVOSKRkeF3wNTg0O32DMjs90rHOFyRUDPnzB
         WAFBhdqtXSjaXoQODNTtYH7Q4CN3pD3y04LhPU7kQTaYrA+ysvfu6BLpYakcqqGOX7Z9
         fNqgE+c8ddz3TgESyYVOO6QtyawxhtiPrY+dzdasUESN2z9T3eLl5TFA+9a1ONpJUtqG
         53Tvg4g/dGWXPeSCQgnacFsAVJR7fQj/3wAhd+7bGSrRMJc2Kd942EqC6H3wVe6nXPlH
         7tEg==
X-Forwarded-Encrypted: i=1; AJvYcCUn7myS8rHGMypwfmWtJ4Y73EfsYUzg5rTr0UdP1MlSeOqxjHIWcfL2IKwQQYpilj4XRJoNfng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCynIosaOFPLryvv7rMQ1vEMowXY/sC5UDVSnRO+f7gR/4RdhM
	WhPbMzZMyvV6A21yhz55KTHXUvP5+pCvN0eaUYoaI/jFEZNL3IBUbU7N
X-Gm-Gg: ASbGncvtcAJeKwiM0LbEuGbrO4CxpXMe0WpHBFO8CSCYyKxVi9MhnXWAv3sZI8NN1cj
	5lh6cf/6XWEEFA95R0aOlIe6yN4Johvjg/piQmeP+46gDRN05mkzy4TDikrrrLDnQLdBUtJdfei
	/wxc0/3uORwo0oTR8fbwvPurICL/dCoPwT0Ql9CdaUV3v/hBtIr7XlIQmTlaAGBbxK2DYPmvRZX
	xyYk2gCYeCItivSi6TZ5nW2Vw9YBQQzA8fXqQvMAT/5N27rsSuBfURkN7bvDEirSvX5tZit2vye
	/B5Q/j4C8GUcrfluSu+gFGZxD5bjIMoIHlqdGgw0ec3FkD6LpVGU0eNHHz/o0WlHBw74W/fqm67
	oCmB2ZnuLUfPzS98=
X-Google-Smtp-Source: AGHT+IFhIkgOwEaZI1CHlZUmr8X1yn0iZQ092u85DbZgSP3gIOds7ddieGdzgjpq1CjrD8+6kK4AHQ==
X-Received: by 2002:a05:6871:4b83:b0:2fe:f4f4:8506 with SMTP id 586e51a60fabf-2ffaf2aef6emr494888fac.10.1752604508497;
        Tue, 15 Jul 2025 11:35:08 -0700 (PDT)
Received: from localhost ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff9263deeasm793675fac.49.2025.07.15.11.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 11:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=3ccb60537892c3b0582ef50946bc9eaa4ce15e51f0b1a261978dbf73d621;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 15 Jul 2025 15:34:51 -0300
Message-Id: <DBCUFWL772Z5.2MUF08I4D6AH2@gmail.com>
Cc: <patches@lists.linux.dev>, "Mark Pearson" <mpearson-lenovo@squebb.ca>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Sasha
 Levin" <sashal@kernel.org>
Subject: Re: [PATCH 6.1 53/88] platform/x86: think-lmi: Fix sysfs group
 cleanup
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250715130754.497128560@linuxfoundation.org>
 <20250715130756.686654974@linuxfoundation.org>
In-Reply-To: <20250715130756.686654974@linuxfoundation.org>

--3ccb60537892c3b0582ef50946bc9eaa4ce15e51f0b1a261978dbf73d621
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Greg,

On Tue Jul 15, 2025 at 10:14 AM -03, Greg Kroah-Hartman wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me kno=
w.
>
> ------------------
>
> From: Zhang Rui <rui.zhang@intel.com>
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
>  drivers/powercap/intel_rapl_common.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index 26d00b1853b42..02787682b395e 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -21,6 +21,7 @@
>  #include <linux/intel_rapl.h>
>  #include <linux/processor.h>
>  #include <linux/platform_device.h>
> +#include <linux/string_helpers.h>
> =20
>  #include <asm/iosf_mbi.h>
>  #include <asm/cpu_device_id.h>
> @@ -227,17 +228,34 @@ static int find_nr_power_limit(struct rapl_domain *=
rd)
>  static int set_domain_enable(struct powercap_zone *power_zone, bool mode=
)
>  {
>  	struct rapl_domain *rd =3D power_zone_to_rapl_domain(power_zone);
> +	u64 val;
> +	int ret;
> =20
>  	if (rd->state & DOMAIN_STATE_BIOS_LOCKED)
>  		return -EACCES;
> =20
>  	cpus_read_lock();
> -	rapl_write_data_raw(rd, PL1_ENABLE, mode);
> +	ret =3D rapl_write_data_raw(rd, PL1_ENABLE, mode);
> +	if (ret)
> +		goto end;
> +
> +	ret =3D rapl_read_data_raw(rd, PL1_ENABLE, true, &val);
> +	if (ret)
> +		goto end;
> +
> +	if (mode !=3D val) {
> +		pr_debug("%s cannot be %s\n", power_zone->name,
> +			 str_enabled_disabled(mode));
> +		goto end;
> +	}
> +
>  	if (rapl_defaults->set_floor_freq)
>  		rapl_defaults->set_floor_freq(rd, mode);
> +
> +end:
>  	cpus_read_unlock();
> =20
> -	return 0;
> +	return ret;
>  }
> =20
>  static int get_domain_enable(struct powercap_zone *power_zone, bool *mod=
e)

This diff has no relation to commit 4f30f946f27b ("platform/x86:
think-lmi: Fix sysfs group cleanup"), which the commit message claims.

It should be removed ASAP. Thanks!


--=20
 ~ Kurt


--3ccb60537892c3b0582ef50946bc9eaa4ce15e51f0b1a261978dbf73d621
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSHYKL24lpu7U7AVd8WYEM49J/UZgUCaHafTgAKCRAWYEM49J/U
ZvG7AP4qEacgEibjf2eFpmHjZepfSMKgdZTUPk6NdV7CWPgQ4wD+NAP421BzRRou
IKeJ9cuRLJZzuIstV+VqbI4e6T+49gM=
=y/S0
-----END PGP SIGNATURE-----

--3ccb60537892c3b0582ef50946bc9eaa4ce15e51f0b1a261978dbf73d621--

