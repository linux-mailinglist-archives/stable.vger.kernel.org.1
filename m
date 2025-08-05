Return-Path: <stable+bounces-166662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D72B1BD82
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 01:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E25A57AFA6C
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 23:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6EF291C1B;
	Tue,  5 Aug 2025 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xji4qPCu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C79235364;
	Tue,  5 Aug 2025 23:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754437670; cv=none; b=CNytp4WQ0vngKzKOzCUCJ1YFHorPrMwE9n6blNrJVZuM03JTM1YpempHqOnBjdC1G+gRUKJeDXu2+fWKNhoTbqoORKZPSUskB2UlssHmdqAY9fRbWHm+k572y3niY+3671EY30H7FBEw+FO/slDo1TrXBcJ+AFu6ma1kMUU6FZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754437670; c=relaxed/simple;
	bh=T+TQB9L6nkRD5oCLbLR5cryrKU8+F1aWEUgdRNPnQw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDSfflcJGje8mikcDjRDeH5f5TmfDqekXK4qKeEy0uGjOK2HpYzuhU62x0MpQ7i0A8ZaBI6pBkiWWsMV6p3Kf3KaN5LgwTHFnjXbgcwQtzr/yQ9nDz4UcQ40D86mHtgE15jYxDBySXzjH68eVazbdsYQuOE8TtQLj5Pq/f8aSBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xji4qPCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B34C4CEF0;
	Tue,  5 Aug 2025 23:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754437669;
	bh=T+TQB9L6nkRD5oCLbLR5cryrKU8+F1aWEUgdRNPnQw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xji4qPCu3qnlfabkVpSBksej6fDAS4kX5md1OfqcrAiLJdQnDqqZsumjw/OXZpxFz
	 RGtoGyJFbL1xwnKB4fTMEk3iPS2cocKvhkQXRoAb5PIzkz2OyEejSgeZg2lG+fhgVC
	 GR/5gkdcPjkEUESPItt0CBA+GkO2uXi/oHK/kpLR8lVvPDtU3BY1LRT8J/M5tgyscN
	 Lt34wXvZJ9zr0gtmdIVye5BtWnmqv6k6Fsv1vtpCUxAkdpYUOBYIhgGtPai6JlIYqp
	 bU3VjiypbFoDw2FgOuX31rb1MehFi+iAjqno/GHnqCKzEUGDQdXWfOOw6k83U5DMwC
	 IYM5zyaXSgNTA==
Date: Tue, 5 Aug 2025 16:47:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Ammar Faizi
 <ammarfaizi2@gnuweeb.org>
Cc: Simon Horman <horms@kernel.org>, Oliver Neukum <oneukum@suse.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux
 Netdev Mailing List <netdev@vger.kernel.org>, Linux USB Mailing List
 <linux-usb@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Armando Budianto <sprite@gnuweeb.org>,
 gwml@vger.gnuweeb.org, stable@vger.kernel.org, John Ernberg
 <john.ernberg@actia.se>
Subject: Re: [PATCH net v2] net: usbnet: Fix the wrong netif_carrier_on()
 call placement
Message-ID: <20250805164747.40e63f6d@kernel.org>
In-Reply-To: <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Aug 2025 01:40:37 +0300 Linus Torvalds wrote:
> So my gut feel is that the
> 
>                 if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
>                         netif_carrier_on(dev->net);
> 
> should actually be done outside that if-statement entirely, because it
> literally ends up changing the thing that if-statement is testing.

Right. I think it should be before the if (!netif_carrier_ok(dev->net))

Ammar, could you retest and repost that, since we haven't heard from
John?

