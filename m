Return-Path: <stable+bounces-208371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D74D2054F
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 17:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A2BD3004610
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 16:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34FA3A6401;
	Wed, 14 Jan 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogP5hRl7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04EA3A4F3E;
	Wed, 14 Jan 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409506; cv=none; b=ucHIt8zUFBUxwsFgQggFf8iTV+T15nxoWxf1yq24XSmIdli5PSBI4x0m9Ipg3BLPdLQP+r/5zSds84Tn2d8+KdTAEpXdjaMHmFnK0TJTfc9Gl73qdI0M5xdtsk1mKx/1HozYjSlUOuCcsYWM+LEMoEmgy80GcXeKR7ck0hvb+4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409506; c=relaxed/simple;
	bh=/tgfdZY8ioB8gIjvJqRjpf9WBA+xTl0wFAFGXzU2Z0s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lorf7huk42+SXrlwCWDS4CyydbbYlttSW2rxtF/emT2bMsjYCq5pUCOwQPY2z1tQxS/Crh6G5YH9iKrc+fvhugrGSeuJQzt4tS4EaVgCzC4LEeqniby7xeDH4fc13I/9qZ+Yilk99lR33SObuuL9IuEScNMqJi9TPJjVaQCupjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogP5hRl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB8DC4CEF7;
	Wed, 14 Jan 2026 16:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768409506;
	bh=/tgfdZY8ioB8gIjvJqRjpf9WBA+xTl0wFAFGXzU2Z0s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ogP5hRl7ZGHyboOHJ4LgSzWMelQsORYeIMLCjQGlLrnC64h7mettLRSmBvMavI+QE
	 36AE4qPgEXG5CWfztYQ6KYDF2p8d8uDcgvR3f8p3RHJ7IKggksgC9PkDMjZ48dlsBJ
	 oDoRmI/u1xJ3u6hdAqcsb6iAUoA8j6L41KOg9kn8m8CL8Kg1aJuzkldi632txUgKzi
	 Hd6UWRc24iw70mELDBw6tOBjVmluOgK+GJNkS1+Xh6zVyjZRV7HvfYCO0vTXFRD3mW
	 5uqzQWm4SeH05zN4XInRHpmDYxXOIUCrqsKVJYE52dliVS/nDtmGS7QJLg1JEO4zvR
	 74Lrsr5Ra8XNA==
From: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rafael Beims <rafael@beims.me>
Cc: linux-phy@lists.infradead.org, imx@lists.linux.dev, 
 Rafael Beims <rafael.beims@toradex.com>, 
 Sahaj Sarup <sahaj.sarup@linaro.org>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20251223150254.1075221-1-rafael@beims.me>
References: <20251223150254.1075221-1-rafael@beims.me>
Subject: Re: [PATCH] phy: freescale: imx8m-pcie: assert phy reset during
 power on
Message-Id: <176840950251.979468.11893376937726009802.b4-ty@kernel.org>
Date: Wed, 14 Jan 2026 22:21:42 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 23 Dec 2025 12:02:54 -0300, Rafael Beims wrote:
> After U-Boot initializes PCIe with "pcie enum", Linux fails to detect
> an NVMe disk on some boot cycles with:
> 
>   phy phy-32f00000.pcie-phy.0: phy poweron failed --> -110
> 
> Discussion with NXP identified that the iMX8MP PCIe PHY PLL may fail to
> lock when re-initialized without a reset cycle [1].
> 
> [...]

Applied, thanks!

[1/1] phy: freescale: imx8m-pcie: assert phy reset during power on
      commit: f2ec4723defbc66a50e0abafa830ae9f8bceb0d7

Best regards,
-- 
~Vinod



