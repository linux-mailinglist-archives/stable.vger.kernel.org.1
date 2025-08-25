Return-Path: <stable+bounces-172775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B59B334E6
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 06:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555621662F8
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 04:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD70A21CC44;
	Mon, 25 Aug 2025 04:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UkgWmbib"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40F62BAF9;
	Mon, 25 Aug 2025 04:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756094865; cv=none; b=EFU/d1yOGgzprwVtCg+JhJZyfSGCUWhIKlw9t2qNOkz1W3fCfLpWeHEKV7tiRKNIh1dOruYecEA0BtNu6lJnrNn+kXYxzM6xb5L7onb2LNFEcrQ2smiNmVGGIdz5gko4d27cmRm4NGkC2oEa/6SWDn0j4fgMfSHpupCZ2jwe4bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756094865; c=relaxed/simple;
	bh=9STNmw1NP+n/qB6uSK3QVwDPSSZ82huLZJGbTIrMEYA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TUC9rzN626ULvyUIdxVRHxVSzT/hFvm4XFlt3b5eUaegXrjEyq3ZB3g237TeBaXiJ+ZP49cyjTiuUxghiZ9DIuidiBE5KKWKwiEuiSmw/EZEhjydJzozwm8e1r7Vb0Y/mBQ4iK8uj003DNWc6UoEObHVfqydiATQZWT9sVwaoN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UkgWmbib; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A4F2E7A0088;
	Mon, 25 Aug 2025 00:07:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 25 Aug 2025 00:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756094861; x=1756181261; bh=dyZHZwwxqe9+pKnwIUiBHFx8JbR5+h/w/sZ
	hv6QXdOc=; b=UkgWmbib1JoWoAZXCOONKIAJORuBHg63a8qIeupWr67/+I15p4L
	maUF281NG4fR3OZL6MNFvsMdNEyh1RRnYKpRtK36oZyzL7Wj4Wt5+haomZky8NFO
	R7RhAnaF+AenBJdy5kFfTHeIsudg3US37RkNPwcCfanosGL1o7EpaQAcEeHpm+Tm
	MuVUPNxhhzAQJqGGEO1+hllmaanAWG4M3tf863tu+g4KRj3GkgGZy9QgNpm8gf/S
	+UxlHdsRZxrdBAdTeJanvuDvkp/iLU68Y8r2czXRHN+kyzS81Vd2TYtjzor4aJut
	PROz5RLIPn67FlG+o4N3lzY2q58hIMhaIqQ==
X-ME-Sender: <xms:jOGraFf8_rqwg8oUBv-3fr1Wqp3oZO49AaaMZWGNh9Elzf8o4nepMQ>
    <xme:jOGraAlzmSMrFuZz87Hsejk5iUFJZ-7VLXVQBlgEcVnENFqNtCFgubiyyMyx-phXv
    IvlluCKIQ14NuceU2o>
X-ME-Received: <xmr:jOGraF2I_rjBwkMSvy-LH3DwYdr9MDC3BgA7Fnd_9KBjLpFGmuBdrHGg6xncayXL1-ZZUWPAXHOVjR_WmYKWZVUiEe5gXcGKcUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedufeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefujgfkfhggtgesthdtredttd
    dtvdenucfhrhhomhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhm
    ieekkhdrohhrgheqnecuggftrfgrthhtvghrnhepleeuheelheekgfeuvedtveetjeekhf
    ffkeeffffftdfgjeevkeegfedvueehueelnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
    dpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehi
    ohifohhrkhgvrhdtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuh
    igqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehgvggvrhhtsehlihhnuhig
    qdhmieekkhdrohhrghdprhgtphhtthhopehlrghntggvrdihrghngheslhhinhhugidrug
    gvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepohgrkheshhgvlhhsihhnkhhinhgvthdrfhhipdhrtghpthhtohepphgvthgvrhii
    sehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jOGraJcGYGIMLF6W5PyKV0rvljeuC5_4hflpLzRUEooSq4QvVFG1WQ>
    <xmx:jOGraPaIdPD28HPuVJqeCsWIMYmHtjRQ_SQ0nYInnjTpN4ErqfXyjQ>
    <xmx:jOGraOEW7jQ5SWGGyzCMmu69sdWaQYO1PXEYnury63cQbzCQF0_EBA>
    <xmx:jOGraNlp0glfrfFxA_k221wMfwVKUOkzEffNdFNjBgXywg1J8NDF3g>
    <xmx:jeGraBXCVbyX_DQy6TBnMifWyo61n2vW3dFqJ06KhkTR92-OZxlldnpD>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 00:07:37 -0400 (EDT)
Date: Mon, 25 Aug 2025 14:07:32 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Lance Yang <ioworker0@gmail.com>
cc: akpm@linux-foundation.org, geert@linux-m68k.org, lance.yang@linux.dev, 
    linux-kernel@vger.kernel.org, mhiramat@kernel.org, oak@helsinkinet.fi, 
    peterz@infradead.org, stable@vger.kernel.org, will@kernel.org
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
In-Reply-To: <20250825032743.80641-1-ioworker0@gmail.com>
Message-ID: <c8851682-25f1-f594-e30f-5b62e019d37b@linux-m68k.org>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org> <20250825032743.80641-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Mon, 25 Aug 2025, Lance Yang wrote:

> 
> Perhaps we should also apply the follwoing?
> 
> diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
> index 34e615c76ca5..940f8f3558f6 100644
> --- a/include/linux/hung_task.h
> +++ b/include/linux/hung_task.h
> @@ -45,7 +45,7 @@ static inline void hung_task_set_blocker(void *lock, unsigned long type)
>  	 * If the lock pointer matches the BLOCKER_TYPE_MASK, return
>  	 * without writing anything.
>  	 */
> -	if (WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK))
> +	if (lock_ptr & BLOCKER_TYPE_MASK)
>  		return;
> 
>  	WRITE_ONCE(current->blocker, lock_ptr | type);
> @@ -53,8 +53,6 @@ static inline void hung_task_set_blocker(void *lock, unsigned long type)
> 
>  static inline void hung_task_clear_blocker(void)
>  {
> -	WARN_ON_ONCE(!READ_ONCE(current->blocker));
> -
>  	WRITE_ONCE(current->blocker, 0UL);
>  }
> 
> Let the feature gracefully do nothing on that ;)
> 

This is poor style indeed.

The conditional you've added to the hung task code has no real relevance 
to hung tasks. It doesn't belong there.

Of course, nobody wants that sort of logic to get duplicated at each site 
affected by the architectural quirk in question. Try to imagine if the 
whole kernel followed your example, and such unrelated conditionals were 
scattered across code base for a few decades. Now imagine trying to work 
on that code.

You can see special cases for architectural quirks in drivers, but we do 
try to avoid them. And this is not a driver.

