Return-Path: <stable+bounces-241301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBtDClZV72nJAQEAu9opvQ
	(envelope-from <stable+bounces-241301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:23:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAA14726D0
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9EBE30158B7
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 12:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3B13B95EB;
	Mon, 27 Apr 2026 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="UYzELeGy"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749F3B894A;
	Mon, 27 Apr 2026 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777292616; cv=none; b=pO8STWCdhXir8JkdSzIHj0NX1y/Sq96f+jcsQYDj9Winqy2xnReVNc+I48cfrRbSMT8MXbguyC1f0rLrx0csjJS36K3cLeM2zvC0B7hbubOr/S9jTtpkeWDka8mQ38/CRJh/hRuNMWi+RVbmvZDbDyhp2n8tupwJeBEEUPEIElY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777292616; c=relaxed/simple;
	bh=wHwgwUHjFL+DaHaQ7+2+TRjloCkt1nTGqE101j5LmC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrvhX/bZisY1KDjXvQ5jmXa9DS5hnS00bDwo1kvCSPl4+yeCisK9VP2gxVvsw+BkrnxN5p1hidOs2YG/GAZAg/7O2DbLbR3wBVEABZOhq2SAJeWz5UOHHNof3C0+HZRxbmzOY5UHcYF0ibYmfLw5bYjdhUgcstrsE20irz8e6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=UYzELeGy; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=rSa4DsT5RHn/LdrwfWnRLn67k6i1+NfLB6ROGNloCyo=; b=UYzELeGymE59QPg89eSJu+qECD
	6mqObrTNGCj4NLoYQNA/Q3HgnAIl1clnfFZiJPFl0oY0nEbUGEhVoLcoN3QunicBTxe++VzPdizGL
	0x9TFsEhxGeiWwnoUl3FbTezFHK5BmDRCyWeqgHdmHHJ4gD8xgMRHhuO30bLkBPBdA+vhX16dIO5M
	ZgNcNcrWx4/+1SUMSXKoXD/HgOgGLnbg/wQu5JOw+S61WY673LcD6ykWOahZmccHrKM0/bhEelTxg
	bhPrABLndzFbmv+jUZD8d/luHby8kKUAev3Bota6q2DGYrVtrFcb9Uks5r25lJopooGZoTGyL+NDM
	d6OMEPcg==;
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Quentin Schulz <foss+kernel@0leil.net>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: rockchip: fix Ethernet PHY on Theobroma PX30 devices
Date: Mon, 27 Apr 2026 14:23:19 +0200
Message-ID: <177729258224.1866089.13274076466595011566.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421-px30-eth-phy-v2-0-68c375b120fd@cherry.de>
References: <20260421-px30-eth-phy-v2-0-68c375b120fd@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9CAA14726D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241301-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sntech.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sntech.de:email,sntech.de:dkim,sntech.de:mid]


On Tue, 21 Apr 2026 11:45:04 +0200, Quentin Schulz wrote:
> This removes the reliance on the bootloader setting up the Ethernet PHY
> for the Linux kernel to be able to use Ethernet.
> 
> This is due to the HW default of the PHY reset line being active and the
> MDIO auto-detection mechanism not controlling a PHY's reset line such
> that we need to hardcode the PHY ID in the compatible property for it to
> be usable by the kernel, regardless of what the bootloader is doing.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: fix Ethernet PHY not found on PX30 Cobra
      commit: 6598ed3586a4b1cc79423666e66b9861631a6c7e
[2/2] arm64: dts: rockchip: fix Ethernet PHY not found on PX30 Ringneck
      commit: ae653cb854f36d1555681ce70ca3d80d0ec73516

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

