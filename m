Return-Path: <stable+bounces-123211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DCEA5C27F
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 14:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817D83B37D8
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 13:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E221BB6BA;
	Tue, 11 Mar 2025 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IVhwc+ZA"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367CE1B85C5;
	Tue, 11 Mar 2025 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699372; cv=none; b=OsHt31XNqYv8tXo+jkTYX8Tc8eiU60jabKQVLJfjGMBY8oeHD8lmHTjzx5/xwgVUAnFL1+A8+r/2ra4KeKYqMzCexh9ydLcfbce9VkjG/1bQNH7qsW99Sr+ciY0N025jZnXXXQS4GDcLm3k5xciC40uh4mUV2Xq7zXplqm3D7Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699372; c=relaxed/simple;
	bh=I+SCe9MX6V3blbxDTOuaalfFAo7Cc3wjzO0ktOoJzk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0SVUinQcCGqZ8O7F5uS4p+t9cM2+C0gnBv5vHSPAqb1xIV7p/+cOH6o2s4h2zaEe3DkYYZ7ukd7yao7W/s2I6koSxTqXG8HA/UaaEi3ww6jcEKfVFDoMgVDVLBbw+KcmlxdHMZa1+G+a+jNX2IqZfs2sa79Tf4UQTqyhXc+4Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IVhwc+ZA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=q2lRJqxioOkDdgMU0m5I8o/nVWV18+O78LM9RQ0Z25c=; b=IVhwc+ZAAZYERH3aWpS/qKKgSL
	GLdw9NG8k6Y0LXQyJEFMnB4JGYiiD8w+jWjY3TpwE6Vl2IKq+TT8Kr1VzvQrEFec/cXRAKuzjZr10
	PUapSgnzpwnOncMnx0owt40uKNXh831iHGYxpOMx1JCaPZOZCwDDKg7Ydl3BpSl9uwQc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1trzZA-004LfG-0m; Tue, 11 Mar 2025 14:22:40 +0100
Date: Tue, 11 Mar 2025 14:22:40 +0100
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
Message-ID: <42b5d49b-caf8-492d-8dba-b5292279478a@lunn.ch>
References: <20250310165932.1201702-1-fiona.klute@gmx.de>
 <11f5be1d-9250-4aba-8f51-f231b09d3992@lunn.ch>
 <4577e7d7-cadc-41c6-b93f-eca7d5a8eb46@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4577e7d7-cadc-41c6-b93f-eca7d5a8eb46@gmx.de>

On Tue, Mar 11, 2025 at 01:30:54PM +0100, Fiona Klute wrote:
> Am 10.03.25 um 22:27 schrieb Andrew Lunn:
> > On Mon, Mar 10, 2025 at 05:59:31PM +0100, Fiona Klute wrote:
> > > If a new reset event appears before the previous one has been
> > > processed, the device can get stuck into a reset loop. This happens
> > > rarely, but blocks the device when it does, and floods the log with
> > > messages like the following:
> > > 
> > >    lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped
> > > 
> > > The only bit that the driver pays attention to in the interrupt data
> > > is "link was reset". If there's a flapping status bit in that endpoint
> > > data (such as if PHY negotiation needs a few tries to get a stable
> > > link), polling at a slower rate allows the state to settle.
> > 
> > Could you expand on this a little bit more. What is the issue you are
> > seeing?
> 
> What happens is that *sometimes* when the interface is activated (up, im
> my case via NetworkManager) during boot, the "kevent 4 may have been
> dropped" message starts to be emitted about every 6 or 7 ms.

This sounding a bit like an interrupt storm. The PHY interrupt is not
being cleared correctly. PHY interrupts are level interrupts, so if
you don't clear the interrupt at the source, it will fire again as
soon as you re-enable it.

So which PHY driver is being used? If you look for the first kernel
message about the lan78xx it probably tells you.

> [   27.918335] Call trace:
> [   27.918338]  console_flush_all+0x2b0/0x4f8 (P)
> [   27.918346]  console_unlock+0x8c/0x170
> [   27.918352]  vprintk_emit+0x238/0x3b8
> [   27.918357]  dev_vprintk_emit+0xe4/0x1b8
> [   27.918364]  dev_printk_emit+0x64/0x98
> [   27.918368]  __netdev_printk+0xc8/0x228
> [   27.918376]  netdev_info+0x70/0xa8
> [   27.918382]  phy_print_status+0xcc/0x138
> [   27.918386]  lan78xx_link_status_change+0x78/0xb0
> [   27.918392]  phy_link_change+0x38/0x70
> [   27.918398]  phy_check_link_status+0xa8/0x110
> [   27.918405]  _phy_start_aneg+0x5c/0xb8
> [   27.918409]  lan88xx_link_change_notify+0x5c/0x128
> [   27.918416]  _phy_state_machine+0x12c/0x2b0
> [   27.918420]  phy_state_machine+0x34/0x80
> [   27.918425]  process_one_work+0x150/0x3b8
> [   27.918432]  worker_thread+0x2a4/0x4b8
> [   27.918438]  kthread+0xec/0xf8
> [   27.918442]  ret_from_fork+0x10/0x20
> [   27.918534] lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped
> [   27.924985] lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped

Ah, O.K. This tells me the PHY is a lan88xx. And there is a workaround
involved for an issue in this PHY. Often PHYs are driven by polling
for status changes once per second. Not all PHYs/boards support
interrupts. It could be this workaround has only been tested with
polling, not interrupts, and so is broken when interrupts are used.

As a quick hack test, in lan78xx_phy_init()

	/* if phyirq is not set, use polling mode in phylib */
	if (dev->domain_data.phyirq > 0)
		phydev->irq = dev->domain_data.phyirq;
	else
		phydev->irq = PHY_POLL;

Hard code phydev->irq to PHY_POLL, so interrupts are not used.

See if you can reproduce the issue when interrupts are not used.

	Andrew

