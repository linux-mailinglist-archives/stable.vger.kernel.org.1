Return-Path: <stable+bounces-45120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F518C5FC9
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 06:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A5C1C21175
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 04:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86372744C;
	Wed, 15 May 2024 04:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdOHkH+6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BAA3B293;
	Wed, 15 May 2024 04:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748387; cv=none; b=YxlPzBFG3sOQPFFW7FA2xram4nw8+0EbeR1M2rIYkksFd9vYeMv7uO070O9pNitKZp0RG5sm6/lixr5FjpUJ9j0PMGYOxWNrT368rPzNg40JtXnyKqpi1Bhpi2nYUD1aks84AG2BAoDe5y30PU2+n92GHXvqZgtU5NmydgrbdaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748387; c=relaxed/simple;
	bh=iJ2O8f/PoiMWbkLO39zieFIrs3iybhip4LTxR4g5Uk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2MOuK28DjmnbefwgnMB4PWM9NaN7iIOdZU1nTj6bxUozqXgpNf+Y5k2zAWMqkei7NhDQUMJxWaPnhptQyhJIBzz7XuseF0Pq9WSiYHAHTEQisxyAWoi29Mcn0qCxmYlqGgbqcgNx1fJKuB0+XJcJW1wkqk/ugaLcDO1h9vMSEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdOHkH+6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1edf506b216so43656865ad.2;
        Tue, 14 May 2024 21:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715748386; x=1716353186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VtxoGe1/eejPDg5Q4HDf5+EPwAkFuKKE1kZFYnwxgJA=;
        b=jdOHkH+6rELUVJRbFkSMsPLXd48AjcawZ/tLM/M42pfEdYE5bura+wYF04THa3W+++
         ZgkhbzPNHYiotVRPA2ophTtQ++/EZ+Au8e2giguKOF/9SKoaM2FuhH4hsIbE1WamxUZn
         yRtyItu/9JgQgFfIS2+RdCA89jxNBOh4v2P0qS7JcJqw6CYu3lcycxBqfmsgDBBEC4c9
         W4do4h+rS3ktgfUSJRLoIIKXnyJYe1HHs7l8v9eJ65lsulXowrXmkg1ceb7+ikicY9EY
         kVi0rjxyDdDTyL6kg9INUK6Bum+e94bmUwAPTH+1LfQKkj3yW4LnCwnMUvVQL27qgvpc
         4DDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748386; x=1716353186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtxoGe1/eejPDg5Q4HDf5+EPwAkFuKKE1kZFYnwxgJA=;
        b=EywdI24sijEFrH7xhzUfU3Y7n7OR4PfmeKojrn5B3n3QHA2y8pZ6MwQJnkpp2+aEdq
         bNWK58PWGYtONqtoF3E9NP5K6qUolWcR+JftG2EP66AaRIt4MPxH3Ko/rd5LbkdxJU0x
         YoYHo5/nd3b26xH1kXumWmHXIZeawSoHKseEiwuoqxFzMizk5n+b/jA2BHGEzRg1sbXN
         sqJsOXkGlw3KXn5oBV0qriHkkf4bICBuFl0x2y5have0fiNpTeKUnm1SuQHi8g+epCw0
         Sz8ZImTc/oei+8wskXVcfXOYMuqG9U4yKaEwN8hxTmHS3X6+7qKHww4LKVdKLUxWgxkF
         ZNiw==
X-Forwarded-Encrypted: i=1; AJvYcCVV7N6llccpnKqm84kZcibmLGmWDJawPHNleS5+V2BVS5NmCCEZUMOr1EZM3XRXXfGsX8VnXU3tb5fbqPG75/MnQRbYeGJVonyFqRBGF+pw3zFu7qx/sjb5/RzPOaJnyRJsETdI
X-Gm-Message-State: AOJu0YwQMJaV31I6O4qNnRm4e/Fx3TE2jKnePrGKuFTzBsJiCHe7uDKq
	MIDyixUaM65XA+l6fK2IY2BmebxR1lFUgAFPedKGm1EHxsdRBQDI
X-Google-Smtp-Source: AGHT+IH/XrTjM2PeRK+50jEYxUmUQv3h8fFp5IUdKc92GIpW+8kEgTsvHOgSiD+PFyw0gIrd/g4NFQ==
X-Received: by 2002:a17:903:2cf:b0:1e4:436e:801b with SMTP id d9443c01a7336-1ef441c113dmr187211615ad.67.1715748385636;
        Tue, 14 May 2024 21:46:25 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d4877sm107308485ad.24.2024.05.14.21.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:46:25 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E02F618109C16; Wed, 15 May 2024 11:46:22 +0700 (WIB)
Date: Wed, 15 May 2024 11:46:22 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 000/336] 6.8.10-rc1 review
Message-ID: <ZkQ-HpCHYxv9mq2_@archie.me>
References: <20240514101038.595152603@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9cOENGfmL5IvcNVJ"
Content-Disposition: inline
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>


--9cOENGfmL5IvcNVJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 12:13:24PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.10 release.
> There are 336 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--9cOENGfmL5IvcNVJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZkQ+GgAKCRD2uYlJVVFO
oxkvAQCaEZP/0IxV0UUSD2YwRSFuTtlUslOem7aMf+/F7g9FLgEA+XQtjHx4Emzb
IzL9957c/X+XjIs2cThK7f/EoyVX0Qc=
=7K6X
-----END PGP SIGNATURE-----

--9cOENGfmL5IvcNVJ--

