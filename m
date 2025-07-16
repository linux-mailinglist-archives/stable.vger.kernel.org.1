Return-Path: <stable+bounces-163203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66426B07FBC
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 23:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854134A739E
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 21:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409962ECD1E;
	Wed, 16 Jul 2025 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nM7HPF5f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C07FBF0;
	Wed, 16 Jul 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752702002; cv=none; b=lP5GwM1j+HImoziRzgXxE6PlUhA7aHYZN8jw+8cZy4bm1uVBjEu8fsXf0dqufjy+ZdTQSzaYIfZIFKJY3CqvLg+RGnH30GX2juq16ZX/lHSK5uNB1L5pdXSGufp+z9YIWiyIuu4WIkToYr/y2PQOirOqxxqc2o05uQRRREzjXmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752702002; c=relaxed/simple;
	bh=jGPLM5UMm6HRhpvpB1axC22mIwzUp6GFM1ylnmPR7AY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRv1fUkujHSmLGCmOBJ6Emtl1Q47Jk7lHayFSuCTAMXE9zX9BxtgzQMefrRklApUe8NFfpfYS4bPMBAIfDpE29I9SDn7YvSI32ffQmJPZribbGRTKN5pF1reFV0vExwlCMiIbj+fjEnQLtyqYouBv80QoOG6aeRuAIj1TQTqAFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nM7HPF5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC97C4CEE7;
	Wed, 16 Jul 2025 21:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752702000;
	bh=jGPLM5UMm6HRhpvpB1axC22mIwzUp6GFM1ylnmPR7AY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nM7HPF5fEeW74Nmis2g5+7UXb/oK5Oh90W0ThPw8GTm2naHeiWOLm4oQW0xoD/Y2w
	 ioVjUnhovsxIFi9bs5qk5whbu+GBt+SpW09yEQJLOYmY0rEJRrkgaQk4LzDDa+Qp9a
	 mxuoDhGY9k7cJ+3+gkGBCGLROuFjdqmlyyUgkoNLqtBDr/fffeV4pQ/I5VpjL8u0+M
	 ++oeT6EfGq9NQuaYWKekSRYeKrBsuRGw2OLbUMeRjauSZCPaPnrx1gZLqKP2wwbYNB
	 8eecrCdtElgJSgRGoQfU0moX0V9C1ltzX3cbBML+nMixF4eusjOkMb503aebI2kf9K
	 bZqsx6CG5JenA==
Date: Wed, 16 Jul 2025 14:39:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: John Ernberg <john.ernberg@actia.se>
Cc: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ming Lei
 <ming.lei@canonical.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH] net: usbnet: Avoid potential RCU stall on LINK_CHANGE
 event
Message-ID: <20250716143959.683df283@kernel.org>
In-Reply-To: <fbd03180-cca0-4a0f-8fd9-4daf5ff28ff5@actia.se>
References: <20250710085028.1070922-1-john.ernberg@actia.se>
	<20250714163505.44876e62@kernel.org>
	<74a87648-bc02-4edb-9e6a-102cb6621547@actia.se>
	<20250715065403.641e4bd7@kernel.org>
	<fbd03180-cca0-4a0f-8fd9-4daf5ff28ff5@actia.se>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Jul 2025 14:54:46 +0000 John Ernberg wrote:
> I ended up with the following log:
> 
> [   23.823289] cdc_ether 1-1.1:1.8 wwan0: network connection 0
> [   23.830874] cdc_ether 1-1.1:1.8 wwan0: unlink urb start: 5 devflags=1880
> [   23.840148] cdc_ether 1-1.1:1.8 wwan0: unlink urb counted 5
> [   25.356741] cdc_ether 1-1.1:1.8 wwan0: network connection 1
> [   25.364745] cdc_ether 1-1.1:1.8 wwan0: network connection 0
> [   25.371106] cdc_ether 1-1.1:1.8 wwan0: unlink urb start: 5 devflags=880
> [   25.378710] cdc_ether 1-1.1:1.8 wwan0: network connection 1
> [   51.422757] rcu: INFO: rcu_sched self-detected stall on CPU
> [   51.429081] rcu:     0-....: (6499 ticks this GP) 
> idle=da7c/1/0x4000000000000000 softirq=2067/2067 fqs=2668
> [   51.439717] rcu:              hardirqs   softirqs   csw/system
> [   51.445897] rcu:      number:    62096      59017            0
> [   51.452107] rcu:     cputime:        0      11397         1470   ==> 
> 12996(ms)
> [   51.459852] rcu:     (t=6500 jiffies g=2397 q=663 ncpus=2)
> 
>  From a USB capture where the stall didn't happen I can see:
> * A bunch of CDC_NETWORK_CONNECTION events with Disconnected state (0).
> * Then a CDC_NETWORK_CONNECTION event with Connected state (1) once the 
> WWAN interface is turned on by the modem.
> * Followed by a Disconnected in the next USB INTR poll.
> * Followed by a Connected in the next USB INTR poll.
> (I'm not sure if I can achieve a different timing with enough captures 
> or a faster system)
> 
> Which makes the off and on LINK_CHANGE events race on our system (ARM64 
> based, iMX8QXP) as they cannot be handled fast enough. Nothing stops 
> usbnet_link_change() from being called while the deferred work is running.
> 
> As Oliver points out usbnet_resume_rx() causes scheduling which seems 
> unnecessary or maybe even inappropriate for all cases except when the 
> carrier was turned on during the race.
> 
> I gave the ZTE modem quirk a go anyway, despite the comment explaining a 
> different situation than what I am seeing, and it has no observable 
> effect on this RCU stall.
> 
> Currently drawing a blank on what the correct fix would be.

Thanks for the analysis, I think I may have misread the code.
What I was saying is that we are restoring the carrier while
we are still processing the previous carrier off event in
the workqueue. My thinking was that if we deferred the
netif_carrier_on() to the workqueue this race couldn't happen.

usbnet_bh() already checks netif_carrier_ok() - we're kinda duplicating
the carrier state with this RX_PAUSED workaround.

I don't feel strongly about this, but deferring the carrier_on()
the the workqueue would be a cleaner solution IMO.

