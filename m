Return-Path: <stable+bounces-166663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27001B1BD9E
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 01:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96C23B92CF
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 23:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194122BDC32;
	Tue,  5 Aug 2025 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="iSXA1EcL"
X-Original-To: stable@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F614524F;
	Tue,  5 Aug 2025 23:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754438183; cv=none; b=L/zbjHsZC2dYXcwTllzKwYFapPBu6+fB4N64P2DRNPv9EMWiqcvsR0HxqikE50dtVZR0mNrj14iJ721xjKAYPEpG9UAqOT0VVHJMZZlZySG4FutYk8qOfXdCXLTVU2575QSOYy6MhQ9pc3nPiOQDkoTFuTnBn5izsI0YPRdJiy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754438183; c=relaxed/simple;
	bh=Fp4dneLqTfyYyNFcsLTlIeIqD6d5bnThYhVIbjpAZ6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z81YBP6zLnCkdyCGh3KoaD4AnLXd5ayndGzAuM5V2do1wajq/ABL0VIkbknSGFHAOyTNHdB2mfiouIZ6gbGGfyMf0fJpdOzQYdHBmMzfLOgMsPeBKLoTmPj7HEIJRX93qgD+cZ0tj6k1BJhfZO82YcKdryB2AO0Txcfwa3mMnyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=iSXA1EcL; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754438179;
	bh=Fp4dneLqTfyYyNFcsLTlIeIqD6d5bnThYhVIbjpAZ6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Message-ID:Date:From:Reply-To:Subject:To:
	 Cc:In-Reply-To:References:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:User-Agent:Content-Type:Content-Transfer-Encoding;
	b=iSXA1EcLlpi139YZSA1TqLJ/mAPinPiVHWwrOcGJ7FgLsfZSIUIa61dgmfgItkkwN
	 KteFPcdOx0HUAaUCCbRWFIi8deXz5CKVKurtsjcP/SRol9tzTj/QlW018R55Cv8GTt
	 8Hai+R0mT+A/ziU4FHJjbWGTOM2HKpq3Sa7ZJtQYLAt/+L/wZqrMg3f7qynCB9Awsz
	 3vZ9TFDcDM+xZB05QD8Hnv9/Zp20B2VcEq+hhTtPl+Kfs3J0cyPy4XyaC1dJuyDrKJ
	 fYL3lNXqtWcP95HaRSGNyN0jtpq4w5PDcWCItLxlW1gkAn0E3ULveXM4sXivy7rx/5
	 qGSPKvDNSXIhw==
Received: from linux.gnuweeb.org (unknown [182.253.126.229])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id 710BF3127C24;
	Tue,  5 Aug 2025 23:56:16 +0000 (UTC)
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Wed, 6 Aug 2025 06:56:13 +0700
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Simon Horman <horms@kernel.org>, Oliver Neukum <oneukum@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Netdev Mailing List <netdev@vger.kernel.org>,
	Linux USB Mailing List <linux-usb@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Armando Budianto <sprite@gnuweeb.org>, gwml@vger.gnuweeb.org,
	stable@vger.kernel.org, John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH net v2] net: usbnet: Fix the wrong netif_carrier_on()
 call placement
Message-ID: <aJKaHfLteSF842IY@linux.gnuweeb.org>
References: <20250801190310.58443-1-ammarfaizi2@gnuweeb.org>
 <20250804100050.GQ8494@horms.kernel.org>
 <20250805202848.GC61519@horms.kernel.org>
 <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com>
X-Machine-Hash: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1

On Wed, Aug 06, 2025 at 01:40:37AM +0300, Linus Torvalds wrote:
> In particular, the whole *rest* of the code in that
> 
>         if (!netif_carrier_ok(dev->net)) {
> 
> no longer makes sense after we've turned the link on with that
> 
>                 if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
>                         netif_carrier_on(dev->net);
> 
> sequence.
> 
> Put another way - once we've turned the carrier on, now that whole
> 
>                 /* kill URBs for reading packets to save bus bandwidth */
>                 unlink_urbs(dev, &dev->rxq);
> 
>                 /*
>                  * tx_timeout will unlink URBs for sending packets and
>                  * tx queue is stopped by netcore after link becomes off
>                  */
> 
> thing makes no sense.

After taking a look further, I agree with you. I git-blamed the
unlink_urbs()'s line and it's indeed expected to be called after link
becomes off. So yes, it makes no sense to call that when we're turning
the link on.

    commit 4b49f58fff00e6e9b24eaa31d4c6324393d76b0a
    Author: Ming Lei <ming.lei@canonical.com>
    Date:   Thu Apr 11 04:40:40 2013 +0000

        usbnet: handle link change
    
        The link change is detected via the interrupt pipe, and bulk
        pipes are responsible for transfering packets, so it is reasonable
        to stop bulk transfer after link is reported as off.
 
Even though my patch works on my machine. Something may go wrong.

> So my gut feel is that the
> 
>                 if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
>                         netif_carrier_on(dev->net);
> 
> should actually be done outside that if-statement entirely, because it
> literally ends up changing the thing that if-statement is testing.

Apart from moving it outside that if-statement, unlink_urbs() call
should probably also be guarded as we agreed it makes no sense to call
it when we're turning the link on.

-- 
Ammar Faizi


