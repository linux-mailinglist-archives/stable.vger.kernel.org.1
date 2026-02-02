Return-Path: <stable+bounces-213068-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COBGISytgGmiAQMAu9opvQ
	(envelope-from <stable+bounces-213068-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 14:57:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2B5CCFB3
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 14:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DA8E307D28E
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 13:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A9A36AB60;
	Mon,  2 Feb 2026 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VkwL9o8v"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE08236AB52;
	Mon,  2 Feb 2026 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770040348; cv=none; b=es6TNeXm/i+xM+cMyzZquez3D0ndjQzZL9BM1NPPqpdi0pPk+CBl5UIs+lk5DwhYBjHwiPhi7ZC2GOrJh4+NAAc2I3bQZjmUsZ/4FlnNOufJgvaSUTjDuVrsNEujhGVeCjA1VPkEEe5L8wAM5HlCEfcUKjFUsNXAKj1rEW8b/+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770040348; c=relaxed/simple;
	bh=GkhWbFMpVzRq7MnIMBTWCCOCPa2CcC9fCWqYlwJF0j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmhQC2q88Sm2v9s3xN2GZOpB1m/JRKBpRoMEMzt84RhWUCodu0Tpj06XXxfGHvOTIscn1pexmBvow4+I6R/yUgHXt7iFCjz5x+38Kj9GeWkH8qfWYeiI9tO5lZ7dliT9JlWOK17+0Vbi/lmlqY3oWE/nhE4fLGJq+G4HjUkWIW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VkwL9o8v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oXfG5HjD0eLexGaveDkivvSGOBEOw3IK1EmqCYt7KWE=; b=VkwL9o8v+yiNf1jpLT1CLwcH4Q
	mUFOK94yWW5aM/cJP7KqTfRjEwTDEGi8aA9Eeh813R7r9t4aCkLn8xdYT8t2LSqp3pjPPSPmLz4t1
	pAZBXRwNVQV9qkoIJazPfpskvN/HtemAAV62k6n3xsafWaHuty1fNhwNVxFCkiUzsNA4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vmuLi-005pXN-7x; Mon, 02 Feb 2026 14:52:18 +0100
Date: Mon, 2 Feb 2026 14:52:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Quentin Schulz <foss+kernel@0leil.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: fix Ethernet PHY not found on
 PX30 Cobra
Message-ID: <33d3bdd5-0fed-41f6-8b8c-9690e7665346@lunn.ch>
References: <20260202-px30-eth-phy-v1-0-ef365be64922@cherry.de>
 <20260202-px30-eth-phy-v1-1-ef365be64922@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202-px30-eth-phy-v1-1-ef365be64922@cherry.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213068-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,kernel,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cherry.de:email,lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC2B5CCFB3
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 11:27:25AM +0100, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> When not passing the PHY ID with an ethernet-phy-idX.Y compatible
> property, the MDIO bus will attempt to auto-detect the PHY by reading
> its registers and then probing the appropriate driver. For this to work,
> the PHY needs to be in a working state.
> 
> Unfortunately, the net subsystem doesn't control the PHY reset GPIO when
> attempting to auto-detect the PHY. This means the PHY needs to be in a
> working state when entering the Linux kernel. This historically has been
> the case for this device, but only because the bootloader was taking
> care of initializing the Ethernet controller even when not using it.
> We're attempting to support the removal of the network stack in the
> bootloader, which means the Linux kernel will be entered with the PHY
> still in reset and now Ethernet doesn't work anymore.
> 
> The devices in the field only ever had a TI DP83825, so let's simply
> bypass the auto-detection mechanism entirely by passing the appropriate
> PHY IDs via the compatible.
> 
> Cc: stable@vger.kernel.org
> Fixes: bb510ddc9d3e ("arm64: dts: rockchip: add px30-cobra base dtsi and board variants")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

What is the justification for stable?

     Andrew

