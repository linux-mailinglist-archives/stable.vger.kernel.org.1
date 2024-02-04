Return-Path: <stable+bounces-18764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1BB848BB8
	for <lists+stable@lfdr.de>; Sun,  4 Feb 2024 08:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34871F216F4
	for <lists+stable@lfdr.de>; Sun,  4 Feb 2024 07:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E027494;
	Sun,  4 Feb 2024 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvdDonHi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DE079C2
	for <stable@vger.kernel.org>; Sun,  4 Feb 2024 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707030020; cv=none; b=I4kYkZ+RDWhcTZL1xs6BSfgs1S85YA9TsKaCg0T+2XQxCn5VM9RmE+6PrC7x6S0HSAEA+gVOEmcLaiSJXjFdV0I3I13V1+zWmKSLHYgq+Trt9/BYeXWK+ggpFTQoaXDQjjDiz2VDnZo/J0Zbn1ZQuA+m5B09UDaiZfTALxGiFOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707030020; c=relaxed/simple;
	bh=8661Y0/Nx7RuVYumZYoG7drVF0R/l5u7s+/FglujsaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtKYfxfqff/vTyB+FXmVSrJcoEIZk9VxyGhYTAuhulxP/xLA66tHkJ/zyO/Ldk/LYW2ftqDDsts+DaW6ALnf3p+5hAbthRZjwxplBnKZDXYr5qB36DdU1DQfrEP34U7gwtsBm55Si5gSs7OuxYiv9qpY3gg1EcysITV7eZw4sO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvdDonHi; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-296717ccc2aso326186a91.1
        for <stable@vger.kernel.org>; Sat, 03 Feb 2024 23:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707030018; x=1707634818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ls6Mi40yNUbNNpO5+Qb+1ZFV4tqKPYuOaltTFV8czDk=;
        b=MvdDonHi4ACz6/Fzxnh1Qxnmanq0YF2316qA8yPNpNndDmal6e4ooh9m5qcFpAToMs
         02ki81YIhrVxX1de/YwA1FzL/JRD24R9HmnUJ6BEitfxi/9awEl/c/lmfO8DNH/iImg1
         Vjg35jrQ5uLK9+OKDsCSF1NQC0Lsm0CoUh1u9jNytpMf88162VCKirlzgE7QpSQxGyq8
         /6gOtt0rHNUSzXrsp0huLuGHJ5Cc9Zw6FPd9AlXz2X2XGCvPCuhP2FI/P6nnxCUzRGfM
         +GTG/WxYQEg+a9MW/vgKWKkty/TPpbRK7VDNfVKzoxLzLqZVckoc5I4WQ+H3I+0M5SnK
         4bVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707030018; x=1707634818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ls6Mi40yNUbNNpO5+Qb+1ZFV4tqKPYuOaltTFV8czDk=;
        b=tKVsUNw1D/kixriMS6+pIdV1bsuAUTTxQsAV3OpKMYqvnl6WIabgphgN7wTBqJi5l2
         rR+n3EjOCCAc6qktyYzj96HZrvY7vcVo2U8Ai4C+42VRgc4ugGXH2wozKJy/SjdhbI59
         njwRKmKXrUE5ERpBLDIhEP41GrWR0vN1t1Oerepa5ujlNQrMyIESBYOU/s6RY/trjB0T
         Nqetksq1i5Rt+UymWguzkwKLuiw0mvdXtQAH6HJ8owNKgJGHFTXKnzG/UlbRrvSkT+eg
         ulcDo3sd4mLdyLA57g17XvP1u/TP8YuNp2f/MJ9mvtK7QNlpHgKjQd9X2qsRrRbt7gEH
         FImA==
X-Gm-Message-State: AOJu0Yz9FcD7CWUGrEiWGSa3ApNLw4MHj6+5JhZG9au4fmeq/1+GYoG7
	2FKcgiZ8EPxzn2YOuSnFedGI2pVER8sX6O6QreyfW8tnIR9haz0i
X-Google-Smtp-Source: AGHT+IGumx77O+mD7S0IJk8bTE/rcgFHuK13SpzHA2E2ZfF9WzS+fqNP+YLJp2x3QcB6wa9jFfxaYA==
X-Received: by 2002:a17:90b:118:b0:296:66a4:2e6c with SMTP id p24-20020a17090b011800b0029666a42e6cmr4209357pjz.23.1707030017181;
        Sat, 03 Feb 2024 23:00:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW6bAJUuy0WFBeag/Wv1txPVhF6TSKN7feT1iyJljFgrJynow2lAlw2/C7Oy4hITWstghiGrm08V7/z/lm4elbJ+ScSldEoHvi7PQqgVchDymeJyA2aOIqFHNonqxmO9Ae1CzRF4NKnCvMvro9TByv23W0V+U9TMcAGr4pEkfVjDUu99q8h00Wd/A9JuLN+ED7eVMGlWsu7LcwIctJjftIritOT+Wxz/YG4JBrO2iTGzm2MsME/ttVe1Gqw2Y1iautGgK+T1TRUhG+ltZwGgF1Y3TJUXYta6XB7svSYbg2SfeiyFg==
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id pc4-20020a17090b3b8400b002966d60854asm1810725pjb.52.2024.02.03.23.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 23:00:16 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id E83631846855D; Sun,  4 Feb 2024 14:00:12 +0700 (WIB)
Date: Sun, 4 Feb 2024 14:00:12 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Ale Crismani <ale.crismani@automattic.com>,
	David Wang <00107082@163.com>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>,
	=?utf-8?B?0KHRgtCw0YEg0J3QuNGH0LjQv9C+0YDQvtCy0LjRhw==?= <stasn77@gmail.com>,
	Linux Regressions <regressions@lists.linux.dev>
Subject: Re: [PATCH 6.6 295/322] netfilter: ipset: fix performance regression
 in swap operation
Message-ID: <Zb81_PFP54xFYQSd@archie.me>
References: <20240203035359.041730947@linuxfoundation.org>
 <20240203035408.592513874@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7MNbQI9FVEC8e4H/"
Content-Disposition: inline
In-Reply-To: <20240203035408.592513874@linuxfoundation.org>


--7MNbQI9FVEC8e4H/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 08:06:32PM -0800, Greg Kroah-Hartman wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me kno=
w.
>=20
> ------------------
>=20
> From: Jozsef Kadlecsik <kadlec@netfilter.org>
>=20
> [ Upstream commit 97f7cf1cd80eeed3b7c808b7c12463295c751001 ]
>=20
> The patch "netfilter: ipset: fix race condition between swap/destroy
> and kernel side add/del/test", commit 28628fa9 fixes a race condition.
> But the synchronize_rcu() added to the swap function unnecessarily slows
> it down: it can safely be moved to destroy and use call_rcu() instead.
>=20
> Eric Dumazet pointed out that simply calling the destroy functions as
> rcu callback does not work: sets with timeout use garbage collectors
> which need cancelling at destroy which can wait. Therefore the destroy
> functions are split into two: cancelling garbage collectors safely at
> executing the command received by netlink and moving the remaining
> part only into the rcu callback.

Hi,

=D0=A1=D1=82=D0=B0=D1=81 =D0=9D=D0=B8=D1=87=D0=B8=D0=BF=D0=BE=D1=80=D0=BE=
=D0=B2=D0=B8=D1=87 <stasn77@gmail.com> reported ipset kernel panic with this
patch [1]. He noted that reverting it fixed the regression.

Thanks.

[1]: https://lore.kernel.org/stable/CAH37n11s_8qjBaDrao3PKct4FriCWNXHWBBHe-=
ddMYHSw4wK0Q@mail.gmail.com/

--=20
An old man doll... just what I always wanted! - Clara

--7MNbQI9FVEC8e4H/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZb81/AAKCRD2uYlJVVFO
o6yMAQD+XIfg2ZnUmevc4CxPU6FzWaEm65ZEJsavQBjlnb1qYAD+M2/ludbMe4FC
raLjLPmYz5/r3XpCmIGRkkQ67dSZ7AM=
=NAm+
-----END PGP SIGNATURE-----

--7MNbQI9FVEC8e4H/--

