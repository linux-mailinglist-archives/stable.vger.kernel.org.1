Return-Path: <stable+bounces-107908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384BEA04BD8
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 22:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB267A1858
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 21:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269291F470D;
	Tue,  7 Jan 2025 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSoDP17q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76941E0084;
	Tue,  7 Jan 2025 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736285871; cv=none; b=PfDx7vJhHqA0zXEBgAhzv9op/mP8fyfcMdhLqO9bcBM/VH7ya5GG6+AiKeieMmfWJNx2EByjv94YZIBS9RSHJw5KqM8fya2YsbvwtVyYTzPpccjXj/uFECGd/Usw8vKvXivJUJ6tUust0wmAQ9S1P7BD1AyIeOPGMkG3qcB2XXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736285871; c=relaxed/simple;
	bh=GjzVX/I1GveeBX7xZ9uuWut1elUjGHEkShwxEDr55uY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=pA2wEIZXe1M80JybR6kijStw6T03Pc4SlmFf42JZRqBQIGYdZL0/7cGuTuemgFMECkRk7xrAGQtKdyoSf/amtYvxOAetL/EdMsGe/cNhcwJVju1NVfmVSeG74qts//vupeB/FbpNYaeBvces9NzkrB3uik6K7w7SSx1S/mROC/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSoDP17q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C32EC4CEDD;
	Tue,  7 Jan 2025 21:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736285871;
	bh=GjzVX/I1GveeBX7xZ9uuWut1elUjGHEkShwxEDr55uY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jSoDP17qavU8LEAEfegtpqtPAK5z9/O2QyILaZjdeuYDT+DsaeEfCrlukfgtCmGxY
	 Ac9CT/JQOuakImEjCuoIzWG6eU+Mdd3H97Drjp0pYqXs3OuPrsXoFbcVBgEXMv+VKC
	 D9u/Rb4MHZPIoUN74sFVl/Tk13h+d5d6Ik9icyb+te3HxygC1m+7DF4qFiLA+A7FtI
	 WhydD36jbBi6IWL3AUeAzQELIiC9hiFYgvevpaZUUSVbBMZX3DLZwsKxRoSGTFSfW+
	 GDxJ/3N4N5J3IMDE9MNLyBFENTZAmT8YrVrGhWss9gbxBagpoySXYaFFbCVHUqS2+S
	 zc87fPanH02qQ==
Message-ID: <899f7dc2cea70fa6bfc22ad08354ec98.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241231190336.423172-1-lkundrak@v3.sk>
References: <20241231190336.423172-1-lkundrak@v3.sk>
Subject: Re: [PATCH] clk: mmp2: call pm_genpd_init() only after genpd.name is set
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Lubomir Rintel <lkundrak@v3.sk>, stable@vger.kernel.org
To: Lubomir Rintel <lrintel@redhat.com>, linux-clk@vger.kernel.org
Date: Tue, 07 Jan 2025 13:37:49 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Lubomir Rintel (2024-12-31 11:03:35)
> Setting the genpd's struct device's name with dev_set_name() is
> happening within pm_genpd_init(). If it remains NULL, things can blow up
> later, such as when crafting the devfs hierarchy for the power domain:
>=20
>   8<--- cut here --- [please do not actually cut, you'll ruin your displa=
y]
>   Unable to handle kernel NULL pointer dereference at virtual address 000=
00000 when read
>   ...
>   Call trace:
>    strlen from start_creating+0x90/0x138
>    start_creating from debugfs_create_dir+0x20/0x178
>    debugfs_create_dir from genpd_debug_add.part.0+0x4c/0x144
>    genpd_debug_add.part.0 from genpd_debug_init+0x74/0x90
>    genpd_debug_init from do_one_initcall+0x5c/0x244
>    do_one_initcall from kernel_init_freeable+0x19c/0x1f4
>    kernel_init_freeable from kernel_init+0x1c/0x12c
>    kernel_init from ret_from_fork+0x14/0x28
>=20
> Bisecting tracks this crash back to commit 899f44531fe6 ("pmdomain: core:
> Add GENPD_FLAG_DEV_NAME_FW flag"), which exchanges use of genpd->name
> with dev_name(&genpd->dev) in genpd_debug_add.part().
>=20
> Fixes: 899f44531fe6 ("pmdomain: core: Add GENPD_FLAG_DEV_NAME_FW flag")
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Please tell me which author domain it is supposed to be. redhat.com or
v3.sk?

