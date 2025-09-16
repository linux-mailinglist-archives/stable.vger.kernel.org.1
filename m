Return-Path: <stable+bounces-179738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5CCB59AA6
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 16:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D8C1883DE8
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 14:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B71F33A034;
	Tue, 16 Sep 2025 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTDC3X4b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED7932F77B;
	Tue, 16 Sep 2025 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033782; cv=none; b=etP7oUjiPNw3K4IaVrv8H35EKzfVJx8RUOm1xpZ1WR2UHgyr/5G+I8sjGnS++A8MrHvBKC8Y/3Z5GLFeh4tUalsChrm0IB+8nlSJP6N3ownBFSUntGZy2JNSB7qqDtczm5NeGcR4l6snYZXBJ9r6fQ1+cOMZ5aBg/JaXGu0r1QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033782; c=relaxed/simple;
	bh=9CXMfeWckRDvBvDHG9XadDvfadOIeWKQ5x4Hda3B4pA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Do0ETyFFpqAX7ZjSVF5v5BckdPP8i56Djr6Ixy+Ri2pqwPNksKeTo0Il5GeuzfuDWwXkNFYzshTturtlLCWX6fu6QV7siN08kIJHT1R4Di3QO65GVIaVvAmoAhpb1jMltwsG6uMV98yiYqU7/4dMKFJoyBOM1xUpWaTlfnpanig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTDC3X4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D1AC4CEEB;
	Tue, 16 Sep 2025 14:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758033780;
	bh=9CXMfeWckRDvBvDHG9XadDvfadOIeWKQ5x4Hda3B4pA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lTDC3X4bKxLH2t/3/4Y1FMq57qD4H2OA8iFV5D7XfOCnxgFbuRlQWLN/hgpT0ImnX
	 XArmcMufNimUat9F7TQKapLm+ELbpmklb0OWALKXJvBKsQRYLfGoVnidWBde3LZb4u
	 +6cOQPLpG29uGuNg7Dz+ZmxNBtUohnMIWCMmJSU/KxR4YX2+AE+f8nXaG1aF3fPnnC
	 tz74rwSPDLG2tPkFevWux32vJJ6FQDz6yhAW3q9bxInrfpoLmXvAOMHiGRCmurTHaO
	 2RFSdVF8t8RN02HZ4K5u/c4zs704H6+hiBtf54LWD3+jtIC/UOJQk5O6K10seTjvtU
	 flFvejGWLWdcQ==
Date: Tue, 16 Sep 2025 07:42:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Hubert =?UTF-8?B?V2nFm25pZXdza2k=?=
 <hubert.wisniewski.25632@gmail.com>, stable@vger.kernel.org,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, Xu Yang
 <xu.yang_2@nxp.com>, linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: drop phylink use in
 PM to avoid MDIO runtime PM wakeups
Message-ID: <20250916074259.509382a8@kernel.org>
In-Reply-To: <aMkPMa650kfKfmF4@pengutronix.de>
References: <CGME20250911135853eucas1p283b1afd37287b715403cd2cdbfa03a94@eucas1p2.samsung.com>
	<b5ea8296-f981-445d-a09a-2f389d7f6fdd@samsung.com>
	<aMLfGPIpWKwZszrY@shell.armlinux.org.uk>
	<20250911075513.1d90f8b0@kernel.org>
	<aMM1K_bkk4clt5WD@shell.armlinux.org.uk>
	<22773d93-cbad-41c5-9e79-4d7f6b9e5ec0@rowland.harvard.edu>
	<aMPawXCxlFmz6MaC@shell.armlinux.org.uk>
	<a25b24ec-67bd-42b7-ac7b-9b8d729faba4@rowland.harvard.edu>
	<aMQwQAaoSB0Y0-YD@shell.armlinux.org.uk>
	<aMUS8ZIUpZJ4HNNX@pengutronix.de>
	<aMkPMa650kfKfmF4@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Sep 2025 09:18:09 +0200 Oleksij Rempel wrote:
> Given autosuspend brings no measurable benefit here, and it hasn=E2=80=99=
t been
> effectively functional for this device in earlier kernels, I suggest a mi=
nimal
> -stable patch that disables USB autosuspend for ASIX driver to avoid the
> PM/RTNL/MDIO issues. If someone needs autosuspend-based low-power later, =
they
> can implement a proper device low-power sequence and re-enable it.
>=20
> Would this minimal -stable patch be acceptable?

SGTM

