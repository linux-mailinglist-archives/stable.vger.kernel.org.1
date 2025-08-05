Return-Path: <stable+bounces-166654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7FDB1BBB0
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 23:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD2717855C
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 21:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE75242D6C;
	Tue,  5 Aug 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="shnc9GsQ"
X-Original-To: stable@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755C218AA0;
	Tue,  5 Aug 2025 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754428601; cv=none; b=Yz7Q0NRkGy4GLRSsGKtnCK51r48CR7EYYbCWzPLX7mI7XzUqWdqYzfXSsUnWk0WKHXNAhxgh08J56YEBbelD44D2smKhATqZajhjDHeLL8Grddm0Nh8/2fvvj5ULUbzQVeAQoP3qmUweorI5+RihkYuVbhMYcqQxVYDWHtKLTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754428601; c=relaxed/simple;
	bh=WTogogv5r4A/5ZKWdt14UuL0jyacK2avQADhr9yJluw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NM98hmm9Gtlku/zInSMDSBzhKWGGuPSsUuOjv2Jvx4bM2JwEJhguwS8ybWJ5NiQEiatq9gxpHpaboV6VieNA8WZR0sFGSJd5cJTpdsHyoLvVihLJ5dBvUbK8NtprRW1iy6M6C4Jb2/JsxJpFhVai8ndqpIXKxIpcPYshlESe6vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=shnc9GsQ; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754428590;
	bh=WTogogv5r4A/5ZKWdt14UuL0jyacK2avQADhr9yJluw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Message-ID:Date:From:Reply-To:Subject:To:
	 Cc:In-Reply-To:References:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:User-Agent:Content-Type:Content-Transfer-Encoding;
	b=shnc9GsQAl25TCfuHnWtLsK8dBC6BZyD0joV70TKHd12OHbmHC4hhb8twmTDgSTFr
	 NeKiAXIjKbzNX4Q4XADVsx9gemEsmUyM7nEBgMmxgB/NI7zQD5PdXZ8VdT3lCMwqNa
	 v+DF9LLHfOCuTaRjRhfZlyz8pW2H4dnWWKS5LZEWvoBRxmjFj0qip9NVm3lssWRZCM
	 C8i7jQarfLIRyVMvdWMWizL/SHHwOfxcuERXGwFT21VIFYrrG+Hx/qAV4Bc43EKZs6
	 ywvwBCNZOkmtCMSOXb8QwsP5nExdFo4QhzP3ROa4pQxDecvRdhAy9ELbDQbKZFKhoO
	 7X++jV8qyyHqA==
Received: from linux.gnuweeb.org (unknown [182.253.126.229])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id 5992E3127B6E;
	Tue,  5 Aug 2025 21:16:27 +0000 (UTC)
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Wed, 6 Aug 2025 04:16:24 +0700
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Simon Horman <horms@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
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
Message-ID: <aJJ0qKopqPg38dMG@linux.gnuweeb.org>
References: <20250801190310.58443-1-ammarfaizi2@gnuweeb.org>
 <20250804100050.GQ8494@horms.kernel.org>
 <20250805202848.GC61519@horms.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805202848.GC61519@horms.kernel.org>
X-Machine-Hash: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1

On Tue, Aug 05, 2025 at 09:28:48PM +0100, Simon Horman wrote:
> It seems this has escalated a bit as it broke things for Linus while
> he was travelling. He tested this patch and it resolved the problem.
> Which I think counts for something.
> 
> https://lore.kernel.org/netdev/CAHk-=wgkvNuGCDUMMs9bW9Mz5o=LcMhcDK_b2ThO6_T7cquoEQ@mail.gmail.com/
> 
> I have looked over the patch and it appears to me that it addresses a
> straightforward logic error: a check was added to turn the carrier on only
> if it is already on. Which seems a bit nonsensical. And presumably the
> intention was to add the check for the opposite case.
> 
> This patch addresses that problem.
> 
> So let me try and nudge this on a bit by providing a tag.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Hi Linus,

Given that Reviewed-by tag and the simplicity of the patch, it would be
great if you can take this patch sooner to your tree. The fix is very
critical for network connectivity. Especially for laptop users.

https://lore.kernel.org/all/20250801190310.58443-1-ammarfaizi2@gnuweeb.org/

-- 
Ammar Faizi


