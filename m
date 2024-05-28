Return-Path: <stable+bounces-47554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDA28D163E
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 10:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E861F2352C
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 08:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F244213C3F4;
	Tue, 28 May 2024 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHVO2LKj"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7560313C3D7;
	Tue, 28 May 2024 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716884926; cv=none; b=fbfZqFYj7c7aECjQ+2QOGcaYmNO2HuP1aNPv/aVh+BMb4MEpqxTRya9Ngog9i405MpKXApW/sou1R7VSYnWzgtB5JzLX8DfH+aBSs6FLs1pjPwjXcVPP2svV2hnPVnOxtv3YcHg+EKyKYknLARA6mxxjnHS6aWmGF/6LKvUiprw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716884926; c=relaxed/simple;
	bh=7+Dmi2a3OCv15TElasSV7hwVIentUngqikUSgH5uZ3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6boMqvNTIQhnjAaBU0Md7wE36ZhL9tOfMMYA0WOmmlBSBoqrUQdDzo+xFV6L3vnLU8tI/pvQs8J4rL013eMRma8iolARMA7F95qu3+aAF5y2qVm2OUb/G4Hl6LViEavyMKvVzXFwp13AMcASVmGA1tmjAoJ8LPoTLOYCiE/y28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHVO2LKj; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b970a97e8eso296084eaf.1;
        Tue, 28 May 2024 01:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716884924; x=1717489724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+NFBxch5o2weMyKmXEPJqUhdy9B3WA/Sx9huWinPs4=;
        b=kHVO2LKjM6vcoaL0OvmMqtw7rgTa69QA0bsEYDEH4mDmEaQszeB1j7oJJi1O/lO5iJ
         iVSzMA85F000xOJqU6Hq4u32YnFbZJLIOZfAbnyH/ARJFe9Gwwp3UiVDp9KuPJzv9LPb
         ocWahzkzmwdb/PgWs7UfiYlYb4KBui/WXhn9//pRhMD7NgECuvN34ABprzOSn+gc5uSt
         j9QQ1aGWAHCE97YQg3EACAyXgrVlLi2MfpHZc6Mi/FSXdcngoeVVUTHLFUCSBv6b9+90
         aRuwj6UPlE7aC3c7zFWS/Aud6D4hK8BID/n8whhA7bu+KYrraSH9e+0IhIJOTyxLRpNs
         MrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716884924; x=1717489724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+NFBxch5o2weMyKmXEPJqUhdy9B3WA/Sx9huWinPs4=;
        b=CCpWdUnE4tj/u7HFC1ghWXgGNRpT7F0yFoVUyzzjmSZPnt8xinhIw9nnbgzmZX+e2J
         Y7whyOjfhI0gtMUBmdL5lpWWdbz7WBhyzi2Yj02+bwhrzEPnYDmAQcgqfBLMPD/0/bld
         EzTa4IOBBQEYqwHntLe4NREQnfevF2+Hx+NVVEpkpIEfbjF9S+fV/xs+HRYprN7Ottbg
         O8Bi1tNiR9opQRG0ywuZvn71hPF8xMSa1JZBtQCeXb6eOSCkmBQ2sGk9+CNp6JLN7z/i
         FHpfuvIZMP3pQQg3wkCuDujH09JK/YIKZPDAR2sTarFgeBZvpTjf6pfwYqUuFOjLnwYu
         /XLw==
X-Forwarded-Encrypted: i=1; AJvYcCXrrBaHqLy0oVBRTrmaSBiPxfi9YsszBTGRjAutyBHmi676DNLnpbu19ao7fsC4EHvb1hNJ43ssa3DZRopO3rXP8Qg5ptnEHbkmBFnonWKLXuk868k1AqjrhpG1TrAvAKVETSpB
X-Gm-Message-State: AOJu0YyFDmyhlhhG8SjHcdvbeJ7f1mwfGqaQ2Q/bdduWSJLRQBFIAwNI
	fIb6Tl8VJyGUil49rixbiJZXBGB3IycRKGR36H16L+9Z9b6UAV2F
X-Google-Smtp-Source: AGHT+IG0W2C9Vr08kpDwxSL4GFgML7zehKBlYGDcZ0u/V7Tszz0txTw7IV1F/avSshcLNP5rBHcQzA==
X-Received: by 2002:a05:6359:4c9f:b0:198:e85c:7f1c with SMTP id e5c5f4694b2df-198e85c7f6cmr151058655d.29.1716884924055;
        Tue, 28 May 2024 01:28:44 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682265492a9sm6982180a12.68.2024.05.28.01.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 01:28:43 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 39B37181B0975; Tue, 28 May 2024 15:28:38 +0700 (WIB)
Date: Tue, 28 May 2024 15:28:38 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/427] 6.9.3-rc1 review
Message-ID: <ZlWVti89yJTy4pRk@archie.me>
References: <20240527185601.713589927@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D8/S/B9eUORHrQ2q"
Content-Disposition: inline
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>


--D8/S/B9eUORHrQ2q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 08:50:47PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.3 release.
> There are 427 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--D8/S/B9eUORHrQ2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZlWVrgAKCRD2uYlJVVFO
o+H1AQD4r2ke7pmMXyARVMn7KXpZL76cajKE9WetOnCqwO6TywD+Mw8yy6CBN6lj
fpktwn+SUkaafSH8hnwaf89CsQOeiwY=
=FJmB
-----END PGP SIGNATURE-----

--D8/S/B9eUORHrQ2q--

