Return-Path: <stable+bounces-192626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 656E5C3C045
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 16:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 523684E1194
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 15:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1CC26B971;
	Thu,  6 Nov 2025 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="MwNwUFK0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yffzupEs"
X-Original-To: stable@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A3F1FB1;
	Thu,  6 Nov 2025 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442581; cv=none; b=sKHMp0HCRsYgpZFjidRGUtKZJgVb2YBa8iwnCtYvdjSGJS+mYnsrxdvQhgxsMB8yuaFw5zlTlCySL1GVvQYssRuBjcgHMphwue7d1S25Fa8r2BOBdZa+qAYeqm45FF6KGx7Q7s4r6vKj3aSjDV0j9VUBTwPOJ366Wef0limfmYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442581; c=relaxed/simple;
	bh=xTn451c/pAvImKFjP3a/90RV8MewRySH4Qi40m2vawk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIZlCgkZdHcaGL/hnaPtpzmn4dYU2Vb3qnYNjWnj7luAKwxjO+9lzjmpUMy1Qda05M0Z0gzn2WW55nmBVbVJ+ZnxdIETmvHcQQBfH1YUy2QuZrs8C6tKFlDDKeiVCD8QcbwUSHedvhpvhPRRpWLg+usZygjhMz+7q30xTEeDgOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=MwNwUFK0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yffzupEs; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B4738EC0266;
	Thu,  6 Nov 2025 10:22:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 06 Nov 2025 10:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1762442576; x=
	1762528976; bh=iRONszTGNTUZtxLVBxFznt3xQfJqQ/mEQh6dCf+a6No=; b=M
	wNwUFK0eaaqcfbvpl9e7KZK+05U6YFnC3V/ZawOUgF3rpLGIR5euNJrs9Bd5kcn4
	Eg1/jgrdaXY6JExVXWwYriao1AW4vfH22gkoPHKXZHL7r3PucdcVBcL8aPXEOE5u
	etcDsW5jSvVcX7VRGs5wrYezl2CsA9FS1NFIvsx+kv6wkl7jTge38RyaGPp8jT20
	lzckXe5xU9oJpgbWmo8z84KrrIi4L1VzaXzl7PxgIeqRQPALuZzkivtWnAtFtVu0
	CMxxriljQFQ3h0cv4hTWjgfJrb9c/c8AfrWPpsWS2rUfzjHniYfP8Z054Ml4KHjv
	X7sTBedS3JVYg404s/R7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762442576; x=1762528976; bh=iRONszTGNTUZtxLVBxFznt3xQfJqQ/mEQh6
	dCf+a6No=; b=yffzupEs75CB5rYaHS2r2a691/fHp9PXoBtAUcZl2iIvJEbOjl3
	VuNCELmogghwUoFkNfCjlmNi0cLFMuf17sjfp4Ssw7OHmlE/49UNWhIaBZmCdRLj
	sIQ+dUprlzSPpV1f6DlgXweQ3Ix/V+hdyzmDQ0qzy+MuEhD3ShCO3T0XvhoSeKrY
	Zsg2SKANMC3uRQIsYMH22+JhdEoUtFQzJ0XoHZv31o0mR7NebgyryH/K6pMMGrba
	TzKOMhl/o2bSVgJdQI9HBcvLIxnTLjEb1dZ/EgcfIGzuEGWqplEqduO2N8LVq6It
	/58BHHL9uaZeGdkFbKccuNUCpyYNnwhgxTw==
X-ME-Sender: <xms:T70MacmvdDBFA5rdLZxgK6ddF-LTnRSvZVR5mjO_GobF8FCmW2taXg>
    <xme:T70MaaxzFGc5u_W3qARGqQCep4T_UEO-49gt9Yki4GRI9APUkB3SNS-e91QC_9u29
    K9I4dHHok6uOLejIK9wGBpv0XyawcZztpiBxocsRuL2PJrBCWuD5Q>
X-ME-Received: <xmr:T70MaWs73EFwyJur2_v-VzWGKvCKFhuTaX3EeedoZD0j03ZyttAzqSs7ZwnO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeejudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrtghosgdrvgdrkhgvlhhlvghrsehinh
    htvghlrdgtohhmpdhrtghpthhtohepnhgrthgvrdhkrghrshhtvghnshesghgrrhhmihhn
    rdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtph
    htthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhm
    sheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhguse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigsehtrhgvsghlihhgrdhorhhg
X-ME-Proxy: <xmx:T70MacHertnrQZ5ImRC2djkd9z4noT_KEDIX6AIZmS9IDfnMmTBHHw>
    <xmx:T70Mac4NFNqGAZcqnSDTVMVmosO8kYskOV_S1iZcgsVypXfk1b2Udg>
    <xmx:T70MaVz_g1fDGGPKLZwiQ8RI4bxcQeYlPXfWNcOhzOkOSXnaELrj6A>
    <xmx:T70Maa3BI78SOz3CpUvEptLWrM8gKNlAc3GEjDImovUheZRaYtM9Cg>
    <xmx:UL0MaeQcdZSk7apX-h3vfdMgg9KvaRV6AgytORwd03hnQUWJKyXMTyjN>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 10:22:55 -0500 (EST)
Date: Thu, 6 Nov 2025 16:22:53 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Nate Karstens <nate.karstens@garmin.com>, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, john.fastabend@gmail.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux@treblig.org,
	mrpre@163.com, nate.karstens@gmail.com, netdev@vger.kernel.org,
	pabeni@redhat.com, stable@vger.kernel.org, tom@quantonium.net
Subject: Re: [PATCH] strparser: Fix signed/unsigned mismatch bug
Message-ID: <aQy9TZm4rpP3ZB4b@krikkit>
References: <1097ef25-d36e-4cbb-96cb-7516c1f640e7@intel.com>
 <20251105231212.1491817-1-nate.karstens@garmin.com>
 <f1f2c082-0597-4130-91d2-2059df3ba72f@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1f2c082-0597-4130-91d2-2059df3ba72f@intel.com>

2025-11-05, 15:47:00 -0800, Jacob Keller wrote:
> 
> 
> On 11/5/2025 3:12 PM, Nate Karstens wrote:
> > Thanks, Jake!
> > 
> >> So, without the ssize_t, I guess everything switches back to unsigned
> >> here when subtracting skb->len..
> > 
> > That's right. In C, if there is a mix of signed an unsigned, then signed are converted to unsigned and unsigned arithmetic is used.

Not if the signed type is bigger than the unsigned?

on x86_64 (with long = s64 and unsigned int = u32):
(long)1 - (unsigned int)100  <  0
(int)1  - (unsigned int)100  >  0

Are you testing on some 32b arch? Otherwise ssize_t would be s64 and
int/unsigned int should be 32b so the missing cast would not matter?


> >> I don't quite recall the signed vs unsigned rules for this. Is
> >> stm.strp.offset also unsigned? which means that after head->len -
> >> skb->len resolves to unsigned 0 then we underflow?
> > 
> > Here is a summary of the types for the variables involved:
> > 
> > len => ssize_t (signed)
> > (ssize_t)head->len => unsigned int cast to ssize_t
> > skb->len => unsigned int, causes the whole comparison to use unsigned arithmetic
> > stm->strp.offset => int (see struct strp_msg)
> > 
> 
> Ah, right so if we don't cast skb->len then the entire thing uses
> unsigned arithmetic which results in the bad outcome for certain values
> of input.
> 
> Casting would fix this. Another alternative would be to re-write the
> checks so that they don't fail when using unsigned arithmetic.
> 
> Given that we already cast one to ssize_t, it does seem reasonable to
> just add the other cast as your patch did.

Agree. And adding a summary of the information in this thread to the
commit message would be really useful (clearly, this stuff is not so
obvious :)).

> >> If we don't actually use the strparser code anywhere then it could be
> >> dropped
> > 
> > It is still used elsewhere, and ktls still uses some of the data structures.
> > 
> 
> Right. Fixing it makes the most sense, so that other users don't
> accidentally behave unexpectedly.

Agree. I didn't mean to dismiss the presence of a bug, sorry if it
sounded like that. But I was a bit unclear on the conditions, this
discussion is helpful.

-- 
Sabrina

