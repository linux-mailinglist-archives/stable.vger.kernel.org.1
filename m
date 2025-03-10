Return-Path: <stable+bounces-123130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4ACA5A623
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 22:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9D91894282
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 21:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6586D1E102E;
	Mon, 10 Mar 2025 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iQmDEC8E"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D406C1DF72D;
	Mon, 10 Mar 2025 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642041; cv=none; b=eOoZyTN8owLfTJf+MVGYYyR+pp+o4SovtAivKZnhMRBF0S0BQ/vGQe2KJICqdwIjL2ZKLttpBJA3qNobayRL6XXxSGgfYuHERCtYVK2Ndte/roUAvjgwgVWQbjZ9LaXbsTNrzlfm6L0JnEF2AWmH9EmfxbSMJg/U8kaaFfn/cZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642041; c=relaxed/simple;
	bh=DvazVX0g80o/XqqnPHhoDEhonQprDhV2KvjSM2hR+t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7AvZzjNqHG/XQeeCO6UWWTMSo79lnEC9Z9KmKi8ldUuPtfKV5fK8FwyWIE9p4JBYnvPnz6KP1BW6RMMQv9EY0FrOzuA4Knyj6dlQt5fRT9eIQ+Sg7dCGooE9JOsX6nsj3DHb6krM2MPjDUadtAAtGDgpunHelS7C3aAxA+nOZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iQmDEC8E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4gvNFaVt7SP8lVgM6g77SePTU6ZZWH3MPFK4OksX/QQ=; b=iQmDEC8EGow0Md5fTAv3RCVgRI
	Yw+FwHamSz5gLPm0YjX9chpb+8a+BEbl8lCYNJThLM2H5mAypAQ0H9ZHCthKAfsxyRKOmVBOnUrfu
	gouWN4yVK4fceh+hf1eFYuefUSbYg1PijazS9ikUMqFKZP9wMEkT8geBOeoitubF8Ed8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1trkeN-0048cC-Th; Mon, 10 Mar 2025 22:27:03 +0100
Date: Mon, 10 Mar 2025 22:27:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Fiona Klute <fiona.klute@gmx.de>
Cc: netdev@vger.kernel.org,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-list@raspberrypi.com, stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: lan78xx: Enforce a minimum interrupt polling
 period
Message-ID: <11f5be1d-9250-4aba-8f51-f231b09d3992@lunn.ch>
References: <20250310165932.1201702-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310165932.1201702-1-fiona.klute@gmx.de>

On Mon, Mar 10, 2025 at 05:59:31PM +0100, Fiona Klute wrote:
> If a new reset event appears before the previous one has been
> processed, the device can get stuck into a reset loop. This happens
> rarely, but blocks the device when it does, and floods the log with
> messages like the following:
> 
>   lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped
> 
> The only bit that the driver pays attention to in the interrupt data
> is "link was reset". If there's a flapping status bit in that endpoint
> data (such as if PHY negotiation needs a few tries to get a stable
> link), polling at a slower rate allows the state to settle.

Could you expand on this a little bit more. What is the issue you are
seeing?

I had a quick look at the PHY handling code, and it looks broken. The
only time a MAC driver should look at members of phydev is during the
adjust link callback, so lan78xx_link_status_change(). Everything is
guaranteed to be consistent at this time. However, the current
lan78xx_link_status_change() only adjusts EEE setting. The PHY code in
lan78xx_link_reset() looks wrong. MAC drivers should not be reading
PHY registers, or calling functions like phy_read_status(). Setting
flow control should be performed in lan78xx_link_status_change() using
phydev->pause and phydev->asym_pause.

	Andrew

