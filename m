Return-Path: <stable+bounces-213074-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJkyEli9gGl3AgMAu9opvQ
	(envelope-from <stable+bounces-213074-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 16:06:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B15B1CDDC3
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 16:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBDE8308775B
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 14:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9126737419D;
	Mon,  2 Feb 2026 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BvP8XhFN"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645C36F43E;
	Mon,  2 Feb 2026 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044167; cv=none; b=MqEIkyvf0rqouKtkOxWuL1TSKzAP9o3ALR8emzn9uQAjZC773IlVF8HlK9ChF2w75WiLXpb15STxe+qKDdh027GHECGCBWXtqw6/jVyqe7PDwb+B6dr6HmqaeK/n1vhm8E4bsFpCzEQxxNb+mWKWW470u+cj9EefETj6SeH5LUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044167; c=relaxed/simple;
	bh=k7mARi3aDSskRfWdb82r+p2uGc6x2hUb+zjPCcJLNrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDEpVfksSmhvzWzT9O7LztgKi7tB9rDXS0ckxKIASy6cs8z9JkGyR/Ipm9YK1VEPBbI4oryTmGNuCeLYToiw3ZyJWlMRdyYG8Ew3KpzStvqczTTfGb7CeWAG2WVYL18tbfR2qP3+rchrXuHQeg6azsv4eYDLl2/xwoCBWnT31EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BvP8XhFN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=udxGf0xljtegrIJMFi88Nd41JfqjJkfTxsoBLvLuTok=; b=BvP8XhFNFHfFYcqQ5d1LiHaXxr
	JQvdJk6EbKEyUY/RbHqipwCf0fNGkgB9egtxe2JkNeUWe/0A9zIarl54uaWyUnn5Bi5k1KaIz/uyi
	/36dmO2/lMn8zSQkOJb1hb3YIWnoCkoutMpxK5Wqwfwmp4ZX/abo4PnE28gKqxjNJVro=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vmvLI-005pyz-Am; Mon, 02 Feb 2026 15:55:56 +0100
Date: Mon, 2 Feb 2026 15:55:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+kernel@0leil.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: fix Ethernet PHY not found on
 PX30 Cobra
Message-ID: <38452338-6e65-47ad-a696-b90c02ac42f0@lunn.ch>
References: <20260202-px30-eth-phy-v1-0-ef365be64922@cherry.de>
 <20260202-px30-eth-phy-v1-1-ef365be64922@cherry.de>
 <33d3bdd5-0fed-41f6-8b8c-9690e7665346@lunn.ch>
 <567d6404-2a71-43ad-8ba7-5053fe1576bd@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <567d6404-2a71-43ad-8ba7-5053fe1576bd@cherry.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213074-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim,cherry.de:email]
X-Rspamd-Queue-Id: B15B1CDDC3
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 03:02:08PM +0100, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 2/2/26 2:52 PM, Andrew Lunn wrote:
> > On Mon, Feb 02, 2026 at 11:27:25AM +0100, Quentin Schulz wrote:
> > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > 
> > > When not passing the PHY ID with an ethernet-phy-idX.Y compatible
> > > property, the MDIO bus will attempt to auto-detect the PHY by reading
> > > its registers and then probing the appropriate driver. For this to work,
> > > the PHY needs to be in a working state.
> > > 
> > > Unfortunately, the net subsystem doesn't control the PHY reset GPIO when
> > > attempting to auto-detect the PHY. This means the PHY needs to be in a
> > > working state when entering the Linux kernel. This historically has been
> > > the case for this device, but only because the bootloader was taking
> > > care of initializing the Ethernet controller even when not using it.
> > > We're attempting to support the removal of the network stack in the
> > > bootloader, which means the Linux kernel will be entered with the PHY
> > > still in reset and now Ethernet doesn't work anymore.
> > > 
> > > The devices in the field only ever had a TI DP83825, so let's simply
> > > bypass the auto-detection mechanism entirely by passing the appropriate
> > > PHY IDs via the compatible.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: bb510ddc9d3e ("arm64: dts: rockchip: add px30-cobra base dtsi and board variants")
> > > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > 
> > What is the justification for stable?
> > 
> 
> Bootloader without network stack = no network in Linux.

I can see this multiple ways....

Changing the bootloader introduces a regression. Hence you cannot
change the bootloader.

I personally also don't like boot loaders with basic functionality
missing. Why cripple the bootloader by removing the network stack?

But i also don't like Linux being dependent on the bootloader. Because
some vendors ship boards with crippled bootloaders and you need to
replace the bootloader. And then hidden vendor initialization is not
in the mainline version of the bootloader, and something breaks in
Linux.  Making Linux more robust is generally ongoing development, not
a bug fix.

However, it bootloader developers decide to break the contract between
the bootloader and the kernel, regressions have been reported, then it
would make sense to backport the fix to work around the bootloader
breakage.

I don't know the internal of uboot too well. Can you remove the IP
stack, but leave the drivers? Get the driver to probe and setup the
PHY, so you keep the agreed contract with Linux, but you also get the
crippled bootloader you want.

For the commit message, i would like to see a reasoned argument, based
on

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

why this should be in stable.

	 Andrew


