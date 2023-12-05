Return-Path: <stable+bounces-4679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CE08055D3
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 14:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A94F1F2139E
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 13:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F925D4AE;
	Tue,  5 Dec 2023 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EV9QHJtv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C86196;
	Tue,  5 Dec 2023 05:26:03 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2851a2b30a2so3781798a91.3;
        Tue, 05 Dec 2023 05:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701782763; x=1702387563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sjQ8FbYAEzFu8r4HsmvBApJRCHY6/m3K/5DU4Y50k/M=;
        b=EV9QHJtvGFTAU/vf21bKleYWgdoLGNa/WVYj1noiQ1MPgYDbR7Ja3QQS67ArkPBY42
         fhdJbt2r4nNDUM9owFhvzvbFGw7qaZV1fJ2OsE7WfuogagrRmumx4fQzGW7C7+gQFkey
         sr7t3seA+SKvEMRPgPyb4pGGnpI0HArlSNOigETWUNSjYdLmPvJ077E5IXsoZkViWceu
         oQqTA0zEpbINMZ7XXzGzKDp9GUh09e87qCH9DOktQp/OtJ7gOWbL4bNF51MtFjFNJlP/
         MHv/UDAGJCSbN4dsz0EteWC9FoZcIn5qMS1uV631uQz7TsT05wLBPmfs5E4bqdjE9ThK
         2pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701782763; x=1702387563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjQ8FbYAEzFu8r4HsmvBApJRCHY6/m3K/5DU4Y50k/M=;
        b=D22+J7mtHASDZoZoBpbzCs73HBNil9nhz4MYdl4B48L+dBUkUaOOe3cMakCfVJwBfX
         lqx4RCIaHkj3tnG7W3G7gVgNmmDNROD4l69Bp19SIQMp+B/lqhjR/DutEYMk9y+XJtcI
         U/5WI4U67jQpmhk8mhtyOtscH89OW4OQH8MY+TswRKjVdly4ARWORIVRSAK6vQFG9ZTH
         JU3YeqOmOViT8uIeKyh9BfU36+3d5bRIojRU7y7fI4KnYvqDfhhmI2YfX6bIyRFzMj7M
         Ht1C9OUXjLVyJ/N3Q/8lBYRuXSh+EArGNdVOV6WHjp+GH7tD2MaB/cME2vHTZELMjEj0
         fEnA==
X-Gm-Message-State: AOJu0Yzhf5xi9QFfu4rgl6sukiFHuH3Mgqm1c9nM2XEIO/LPzfINdh0d
	aSRvh40Q7eHVJ6j0SPfDoLk=
X-Google-Smtp-Source: AGHT+IFp2Jj31O+0BXJBVxO8BaeSKJ7diLNOfgCRhO3xZpxPwleAwXdlIiF3KnJLTnUQGjThMvsqlw==
X-Received: by 2002:a17:90b:2685:b0:286:6cc0:8858 with SMTP id pl5-20020a17090b268500b002866cc08858mr901109pjb.69.1701782762886;
        Tue, 05 Dec 2023 05:26:02 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a1a5e00b00280c6f35546sm3864062pjl.49.2023.12.05.05.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 05:26:02 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 0A802102278D8; Tue,  5 Dec 2023 20:25:55 +0700 (WIB)
Date: Tue, 5 Dec 2023 20:25:55 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/134] 6.6.5-rc1 review
Message-ID: <ZW8k4xq-zVRSiBfi@archie.me>
References: <20231205031535.163661217@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fWlXNSfIUeLq0awe"
Content-Disposition: inline
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>


--fWlXNSfIUeLq0awe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 12:14:32PM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.5 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--fWlXNSfIUeLq0awe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZW8k3wAKCRD2uYlJVVFO
o6mOAP0RMX7+rbnuDUG/AieS0bEk7A4zKiBbn/cxEuJoKjGZigEAjzdFmJIb/M01
IA/++F53PTz3U0rf0wED1lL+p48q2AU=
=OO4r
-----END PGP SIGNATURE-----

--fWlXNSfIUeLq0awe--

