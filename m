Return-Path: <stable+bounces-45532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890658CB431
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 21:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269811F22EEE
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 19:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E71A149C41;
	Tue, 21 May 2024 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vRjQkKgG"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1771494BE;
	Tue, 21 May 2024 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716319522; cv=none; b=V+KDBvJbMF58MFVJDLnbJZ5NkGql2MZ92+9Sb14EybqlEFepa/+nJzCgn2RBe7WYXIqgDIPXOTqYMUwJ3mvoPo9zXHWQK5dT/ooNPGCw/QpuS4hvpSzvGdp+zoWnT3Pp2mgAb6Y7cMuNLtGY7NYrKhLLn4SEb/FdhAMqDd73WJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716319522; c=relaxed/simple;
	bh=13sRR4Cg7j5Obz0rW59UU1DAKPd30HumByDp2DZT2dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVSmlxEv0lzbl/7dKWnwUg51NsB8A+/ZzJzLK40GLNOH5SRCHYbcg/6a/Lwt/gkZshM9EKKdyl6kRhzzjD/mAcA+lPHVpcOFxW6G9AvK1X8ZMstQiNIdDn5Uc62OVAtF5cOsVIDFWQ3yj+ICD/kMEPjp4sTtg2u/EsTZBYx5hIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vRjQkKgG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZFRPG/s8Udv0lTg44aiXcb7QGspIA/wWM/HaBDg/rf0=; b=vRjQkKgGcgQ8JjB+noOjPk4YvA
	hNS7dUTomZslnzQzvqOklJZU7SP8WWxR63hLGSC1tqfepoehuvV1U/gRRNpWDz4lh2gCVwITQFtKu
	hO+U+omMCnpejxzzOw3itoUi7JIgQB9qr/COAKHRkky3tmBhTSpe+5UsBdsKYzbf3jx0wE4w8KQ/K
	Tuu4GQvfGh3xp3rCPIHNI1KYi6v4BqEcKqWGIM63pMHwo7ef+DlDuCZ2J06VfXGoNUF0xDWXwuf1f
	9aB0rK3gqCR5DBoT1dGWt8k+a/lTa9KlHZdLd5pyw/CYUPXRPoM+1IA+H5EM3xwC1vlUJdjRlERPh
	y9xNIX0A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49428)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s9V6Q-0002hi-1S;
	Tue, 21 May 2024 20:24:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s9V6Q-0005S3-5B; Tue, 21 May 2024 20:24:50 +0100
Date: Tue, 21 May 2024 20:24:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Da Xue <da@libre.computer>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH] net: mdio: meson-gxl set 28th bit in eth_reg2
Message-ID: <Zkz1Au7njclh1r3g@shell.armlinux.org.uk>
References: <CACqvRUbx-KsrMwCHYQS6eGXBohynD8Q1CQx=8=9VhqZi13BCQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACqvRUbx-KsrMwCHYQS6eGXBohynD8Q1CQx=8=9VhqZi13BCQQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 21, 2024 at 02:56:45PM -0400, Da Xue wrote:
> @@ -65,7 +66,7 @@ static void gxl_enable_internal_mdio(struct
> gxl_mdio_mux *priv)
>   * The only constraint is that it must match the one in
>   * drivers/net/phy/meson-gxl.c to properly match the PHY.
>   */
> - writel(FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
> + writel(REG2_RESERVED_28 | FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
>          priv->regs + ETH_REG2);
> 
>   /* Enable the internal phy */

In addition to what Andrew said, you need to look at how you're sending
patches - this patch looks like it has been whitespace damaged, which
means it can't be applied.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

