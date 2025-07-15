Return-Path: <stable+bounces-162852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD79B0603B
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F866583DA2
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C092ED175;
	Tue, 15 Jul 2025 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXFQbtwh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592742EBDC3;
	Tue, 15 Jul 2025 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587645; cv=none; b=LgJevWxCsLS4Kt03vntLrsA+GRh4esI6YX1NPxtBhPn/k/LJn5meUI0zSyhaL0NnbNlhVjExoqAtwWHPadiE2zrlU8QhLREl249xtnmu4JqnW9IETgueRhQ1tDZOsv4JAGL3mQoXWlLFSKK4dHmI2YUwCUTOI00i++gdda1qzgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587645; c=relaxed/simple;
	bh=1xRksTaDRgRjBjZIJNwdzAtfvCb5wQYItHCj8+duVLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAyuU3oArqg1xlqj/AJwzl8VnFyzKSfwitrIFZDNNugn5LHjFsOLRQgJlLVDdFdoNUtv+bisnnXRLry2rw2ZVmSNAP3JMgI1uJHho2xNS/3uNj/Ae356Ot/skSAJXY0hYK92VH/zJXDSfLekVbCN01j8rMexqq08kCq/TUq5d9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXFQbtwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658B4C4CEE3;
	Tue, 15 Jul 2025 13:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752587644;
	bh=1xRksTaDRgRjBjZIJNwdzAtfvCb5wQYItHCj8+duVLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sXFQbtwhjlensPrNb2Ua3WXJt8ii6PGJWzKy6I5QxY2HwOYYAwr6TleWr5QCTHtVY
	 2O1svq0fKeTw/YpRluEQ1C+Mbk1p/5PN/nDIJpxlEvPvA5N7/mM40Vj6wO+4tUAc4B
	 UD1L/LDaw81sCJgmz9O/im8Jl2RPJE3idnsiF8U7NBfE9kqhAjro9UIdfqQIf4jAaW
	 uneMK9bvk5j/Fvbyda7xa/Gov4uSi+Zxh1vd0cwNIcQb94i4zDB6UUjBN9qtC90OX0
	 YXzoy5PbJvyaY7xE+fTLcNvtIKtwX6ql58xx2LTxjOlbv8tSsbiOLE5L/DCRrH71Cw
	 iBGkKCeLarqYg==
Date: Tue, 15 Jul 2025 06:54:03 -0700
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
Message-ID: <20250715065403.641e4bd7@kernel.org>
In-Reply-To: <74a87648-bc02-4edb-9e6a-102cb6621547@actia.se>
References: <20250710085028.1070922-1-john.ernberg@actia.se>
	<20250714163505.44876e62@kernel.org>
	<74a87648-bc02-4edb-9e6a-102cb6621547@actia.se>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 07:15:51 +0000 John Ernberg wrote:
> > I'm worried that this is still racy.
> > Since usbnet_bh checks if carrier is ok and __handle_link_change()
> > checks the opposite something must be out of sync if both run.
> > Most likely something restored the carrier while we're still handling
> > the previous carrier loss.  
> 
> There could definitely be other factors, I'll try to dig some in 
> cdc_ether and see if something there could be causing problems for the 
> usbnet core.
> I honestly kinda stopped digging when I found unlink_urbs() being 
> wrapped with a pause/unpause at another place tied to a commit seeing a 
> similar issue.

Looking at cdc_ether:

static void usbnet_cdc_zte_status(struct usbnet *dev, struct urb *urb)
[...]
        if (event->wValue &&                                                    
            netif_carrier_ok(dev->net))                                         
                netif_carrier_off(dev->net);  

This looks sus. Is the Gemalto Cinterion PLS83-W ZTE based?

