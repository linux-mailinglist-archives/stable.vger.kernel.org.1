Return-Path: <stable+bounces-194806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA88C5E77B
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 18:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7633A4EAA8B
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 16:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCC72C08A1;
	Fri, 14 Nov 2025 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhuCOWi+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5262B2BEC34
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763139023; cv=none; b=a15ePTtYvOORa6toXlwnRmNKQpQvdP8cTBIb1HAJu/3WuCjl53IxJElCvquh1FxlLMHYo7QpGqjSZZqHTZ3fwV34amgYW79lGyYwVmDeB+4uf9840hICYN1bSmDK+fsvW8FRJ/qyLxpW2+IeWUDONQss/wMhyjnkXpAUTeDH/VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763139023; c=relaxed/simple;
	bh=qTut9Ewy8dQSzfkbfa8/nMy3/bP67a+YVpEX5V7fsQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQ2JdcJAphu5dz5ZpfOYfkQt3k6EXJAMvRhCjM4McxwLoo+mYrNT7zf1kNbM759+OvEIuXt5vnTE5Vz5d4AqQDfRgPHmx3FJBUiHWogIrlBPB5i5DwU7nBHAld6ayRqDVWYPFN9p6e6fQUTYJCSk53YSdMYky0cVphvDhalN0RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhuCOWi+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477442b1de0so15336065e9.1
        for <stable@vger.kernel.org>; Fri, 14 Nov 2025 08:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763139020; x=1763743820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bNlYOo3f7iFBikvWUb2qjHTSCBHAoUxCAr4nMk+scgM=;
        b=BhuCOWi+BIBgzHf7UO3lLCK7VWgm73q/2c70PYumSWL3BF1NxOIG2h/2TO0dQCUsRI
         yvDmb/i2kncXd6oRITsKU+BN54H6ids+/mCN/JZVZe3aDqBFzfKMCX9fahg+KpPW0NKp
         Wzs2eipSqvHy9Ma2Hzlk9+0pvKju+QzTp31+4Jo4mO8MwFUdZitiJVvLE5LhpxJwxdc6
         Gow4K5kbZwkxf26XmCkTPz0FdFsd3OqEWGEjeAGuTsBP+AKcZiMdysdbGkrXTDf80vwO
         IVUuPCr8r6a3uQIMSbH3HE5z7Ff321vfYAkQDpZwU9qJjM3SDdSfHhC3/kjmxXWWMYR/
         pz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763139020; x=1763743820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNlYOo3f7iFBikvWUb2qjHTSCBHAoUxCAr4nMk+scgM=;
        b=HgB09Jrv1o3C6FXTChzYVk4oZOpeNIL50yVeNbZ2B47CFJCsJORoI82khGUGn4Pidi
         kdd4tR1sSat1i1l+TKE6F947VkOI0MHLwpckbrEJvxWJdP+F/oIkrRdVlUqWkKF8Fs8S
         ibOx/tPVVyLR78L31m+5mqZpk0DSfE9hzR1g0OFyGgEacZpAFlz6fjGT7ub5aM3RcOeJ
         21ybUqfbHMY5HZjNae2lSgFIdAwP4X3RMAj70oNstRU9onINFg17Dsr2KZEoQCn3itJk
         LpcEDlhRNcdy1BIBtL5n3wxKdL8hc9oxL8lWw7crHdqK8HLx2TQGd5oYryS+vBEOkXc+
         sYcw==
X-Forwarded-Encrypted: i=1; AJvYcCWnpOWUJQOqkNcsr+LYazfzl+NBvpvJEM9x5ZBnqLydh6Gl2Xwa0tI+593Frx0XncOfcyBgM1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQN5KlxU1UVTBsazkBwxrJEviXC+vH3byFrpLjmZl3aZPJ0ZsM
	lX0iKlMQTRJpLeEtZwEUf8t9MfEU8oUgf7x0fr/EMBz94PD7D1kaNKpb
X-Gm-Gg: ASbGncuo6/8tjDWc9Hf1wlDRlIvWJZuj0Yk6CnCk9vnvFnch+ivHHGbLOP9jrQQHKL+
	nVPuqGvt9av8ghRcaKBRen6ys40ScqLiQdavXOZsQXylIx3RcCPHY4kAlmB1BTJXQmr4WxZcqB/
	Y4QOJGfONArP9WxEuPKq2Lk/pYrogIBnCSesrn/s7Q7tL6snCmci1GIeYjtPJ+/tbic8N6P09qU
	JhJnf1V0T2fnCvmQptMQ0MZFzNpR1Mc2HDm+HzvHk+M4pSSRl/CfhJt+ek4L+DQ44dteTqeNK0q
	91c30t9m44ori3sFL4P0O91btJCFi5fx8UQ6gZh13hwGBt6293VrSRm1mj8bOI6vSb/85C1eXMd
	6qXNgIjK0XCXRvYiBPjuZvexFm8QD5ah/9Mcpa6yFGyn4ADUVTcwcbv0W6KOCDauPCKLmg5lbM/
	dBhGuON2HJacDbnSm0e66j7ZsLF0RxcyELaMHLmL59cnFUob9Q2pS34zubhi6nVhU=
X-Google-Smtp-Source: AGHT+IFXRuimfT/UdDZFh5llKU8oUWgdFrdqwK0w1rug2KZ0kehK7oWIptlRy5oH5t3yBxq5Rz+agw==
X-Received: by 2002:a05:600c:450f:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-4778fe4a05emr34052525e9.16.1763139019587;
        Fri, 14 Nov 2025 08:50:19 -0800 (PST)
Received: from orome (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47795272c53sm17396905e9.9.2025.11.14.08.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 08:50:18 -0800 (PST)
Date: Fri, 14 Nov 2025 17:50:16 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] amba: tegra-ahb: fix device leak on smmu enable
Message-ID: <iqorxn35xjmylfxjxhnwi3htfloythelsslxndgbfu2tslkmmf@drbc2dikgbof>
References: <20250925150007.24173-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kotf53gdc3t3vlcz"
Content-Disposition: inline
In-Reply-To: <20250925150007.24173-1-johan@kernel.org>


--kotf53gdc3t3vlcz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] amba: tegra-ahb: fix device leak on smmu enable
MIME-Version: 1.0

On Thu, Sep 25, 2025 at 05:00:07PM +0200, Johan Hovold wrote:
> Make sure to drop the reference taken to the ahb platform device when
> looking up its driver data while enabling the smmu.
>=20
> Note that holding a reference to a device does not prevent its driver
> data from going away.
>=20
> Fixes: 89c788bab1f0 ("ARM: tegra: Add SMMU enabler in AHB")
> Cc: stable@vger.kernel.org	# 3.5
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/amba/tegra-ahb.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--kotf53gdc3t3vlcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmkXXcgACgkQ3SOs138+
s6HA1BAAm/crkTtB38iCaI+uSS7RPmokKMeH14URefVtM0cwkYL/m5GApAxSF4jl
hUWfEs7eeuyTFmcest4poJEVtSXx7+uxB11VZWAHsErXDizK+GidvPSRUdYH4mFd
/wC36QiwjcLVQwzGouws2rzYdNT5fcAFkNKsrCHweqPPmRKB5T61WhyqJ2R2s5xP
YQJjk928/QEzgHJryKMtRlXPlKrI/HNq1n2oaZL3JJNqeQVwcjCET2ekg8AWsKwN
FXdfsGHO8aJTzXdNW5bebgWbDz08wjNeAq/UMODvOMUxPFDF7S4rcViOlkF7WGhY
8nA0nT/FikYzSrtA2O6QGeE5B+2FWy02Gb/f9nBNyhBhzxtglbwzCyHTM+m5QVJK
32EM5LhxnSe7INOGQ9eAcaExXbh4+VU/31aTm1cItVEIgyYj8Sqt2Y12Vwr29Mli
OrO0NUy6D0prmk5W61Zm3Ry0arkg0bgNJFNXpvRBxFN6AMU2SYEFi/l7MNaUZLKJ
gzsmEL2P9YVxXl1UCwdNSy290SUwf10yNgpeC37gXSLn7UizmjTYijqg3FPLtyqL
+FKB6JZT0+9XIYiqH1VVAoT2wWLRpqq7DFGZTLgsIQhUkB7gLJRAiVhuflbFhWQe
o+MvGZ5wHULthmb4/Vd6KlnOvrM48+qdScRF4OfmFWx1XGC3WR4=
=4Kgv
-----END PGP SIGNATURE-----

--kotf53gdc3t3vlcz--

