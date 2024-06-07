Return-Path: <stable+bounces-49941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB7C8FF9E3
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 04:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2782E286067
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 02:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EE211718;
	Fri,  7 Jun 2024 02:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q38czejR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8DAFC1D;
	Fri,  7 Jun 2024 02:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717726137; cv=none; b=ZaAk+V6kKIyoTHhuHqn7UbMdI3JAnziLx0EQ4IbXNRqy9cd8pkapJTONIN8IZUrrfX6YCPQpX2y+hewCwBeZdOI53Gm238EtXFZQ+NJA80SK3wNU7zJ3smHk0oDkb2H+O0CAAm+U1bDku2j+ugOn6so2KkocdgHzbVoK628SDAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717726137; c=relaxed/simple;
	bh=Zgs6EUaw+fgETHFqLyu+EyBx0t4ITnZTlUfvdp01WrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjLlUnq4cJn1Bnh0K4AvVM+8e6zNvRqRHAkM5IhnTh6Uqr2/JWLLOI/DWj2GM1DiMbAfbUP0ihm5PaGU6Xp8q9xIZlTyZEfY7BDurBg01BkwKSE/EbtDTwOOG08QkQcRJuBvWgGalZSRN7x9dLsXke3LFBzhI5ptSgp4HumNYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q38czejR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7024cd9dd3dso1324804b3a.3;
        Thu, 06 Jun 2024 19:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717726136; x=1718330936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2YbNkfBTg7QNL7W0fk9O5zt5ZxmyJT5/V6X8thSn3Xs=;
        b=Q38czejR0p4uW0/oga7n1rL8vphLHa4xPOp70+uFl+VROqECzLTrMmtHtz2kwdZMDT
         rc7nMSSx6VOeQLrFLN6TiO5pDOKGPar4QpshvpfsIBIxW9I3xITtaHN0mXqgTzIlUCSt
         MucFMf4Jx9eOlE/PpC+eHqqRN+hV8v67S7AkMWVbA6vw3qCBP7hKd5K8NxtCa2ZhwiH6
         ikbdVcVj9cNlzJxSP9mPBBHaQmFCk8Jdi17UISJCZAjFuvQPL4ECp/Es0vV473ju65bm
         FPAVEitimy9yt39MlhLoWkhAUfoTpHFmw3xY2tDr1NpBiAcR16M18461P47OHSR0sJjo
         wzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717726136; x=1718330936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YbNkfBTg7QNL7W0fk9O5zt5ZxmyJT5/V6X8thSn3Xs=;
        b=umLcQ26FBz/qUhGl/CkKH5BSnKLKP2Ly3CrgFjxjaDIRnrP2ECrDJ210dQx5AHUZqf
         tpcXx/7KckGTYQH4baP9M5iLBYoAdn5BZbjKeZSoropScHsfWFO6zbsZ8L+21Sj05CGR
         NUjWdtNQaS2aH6qLKY/a0adzAXKkPs7yjqfX5vkP6qHw5nLR0Ye9Ig/yHydbwFxWAFNk
         HW8ZHhQ3EY0EQ7uhyaPAy6TwkNIphefa2+6TYau0v4Cj/O7mOJ7DjQE7ve8yIoXiXGBy
         BTY1cUvUTukX4GEog3fqNmCi6YvG0SJZ5+YBhQf7mu8hPrJp+RqCkKuGnxJhlgvozPn0
         YHnw==
X-Forwarded-Encrypted: i=1; AJvYcCXDBgrfLoBt8xyl6ZdVKKVyVxQCfRswPBIsRibpivooPscIO+OOpkH5ES7jrz0PGu2dRkb2LgeGI58ZffKw+0SVNT1Cv7R2wGdJN2q+PU3rj+udB0+G8bBwPb98IOWn/KiCIIj7
X-Gm-Message-State: AOJu0Yy7Hm/2sP37Tu2nbZic8Q+VUPd8dkCNHtUWKJHwVxEqMcKy6YtS
	DClRjquNhzq7si25lBW1+M+w7kMNT5jRRk9aoAItQ2x5XlX3Jf6O
X-Google-Smtp-Source: AGHT+IGMw2tKALOAt5+mXjWbsar+Mn1+2+TehGkELpiwdXYkZoU9WWSW+/rp2sKMuUd8tEkbZiJgug==
X-Received: by 2002:a05:6a00:2387:b0:6ec:db05:36c3 with SMTP id d2e1a72fcca58-7040c615964mr1144379b3a.4.1717726135546;
        Thu, 06 Jun 2024 19:08:55 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd498a8fsm1687742b3a.109.2024.06.06.19.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 19:08:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id F110618463038; Fri, 07 Jun 2024 09:08:51 +0700 (WIB)
Date: Fri, 7 Jun 2024 09:08:51 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/374] 6.9.4-rc1 review
Message-ID: <ZmJrs2ntqb77ebCn@archie.me>
References: <20240606131651.683718371@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3AxIghRg5g1ofXuB"
Content-Disposition: inline
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>


--3AxIghRg5g1ofXuB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 03:59:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.4 release.
> There are 374 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--3AxIghRg5g1ofXuB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZmJrrgAKCRD2uYlJVVFO
o00uAQCB/IULpEyo/wECqAHRYZiQNScetvGwBHIp1X3fIjCUrwEAwRAk2sft3lXh
QNyLORJJ7s94M/OI8Gn+/TuL2Ahv1wQ=
=POE3
-----END PGP SIGNATURE-----

--3AxIghRg5g1ofXuB--

