Return-Path: <stable+bounces-172774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADBBB334DF
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 05:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EDEC1B235CC
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 03:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1C6239567;
	Mon, 25 Aug 2025 03:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eN5jjmdS"
X-Original-To: stable@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCCC45009;
	Mon, 25 Aug 2025 03:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756094373; cv=none; b=u5vr7g2JefcYPIDsNmEE/E9PdvEGsS8BdOO7E8jhZgEOLK/CUjfSt0S64dZKAkI0ekTwkW1t8e3Fs9UGmPP5tN7IYEPVoqruCTL6YxVDyvcUzsVleHolNt6uHKo/hxchw8qTyGjBS2tgpoytVbYibSyj1j99qvs+nS4DvDBDB84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756094373; c=relaxed/simple;
	bh=BpLYJBz/OgUK0QsfkqyYCFTLO5lALaDTFxyTD/lHG0o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HvVYGl9ST3WIAj1nUdm0n208UhIM/d/VASQDWYnW+06TsnSynITo6BfMsKVIjNScvkuTmjbs8/sz00o3KFZCoPNQPUNvZHuwIHzxTqNHZOjoXX8poJ+xW5CB0c2jnBEmW2vjEDQhX+Z0bnzouAdHKVj81//mPTL5mLIRLsH6R3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eN5jjmdS; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id ACC5B1D0009E;
	Sun, 24 Aug 2025 23:59:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 24 Aug 2025 23:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756094369; x=1756180769; bh=v5afX053KsvJ4SMpwBkx22A4YZ0qtD8eE3+
	3AxdTItg=; b=eN5jjmdSimtXYqdvEELuN5xzugx3IM/Px8l9iPfL1oZGzKqyu9H
	wPYgPUcs9hInxm9o/PfSklkDT2Cpy4PPfgyXw4zBxM/vMqsUwfvMrdaAfE43KZSX
	erMlVvcfyZzbxpyQazfLR6KjAx+HzcjM2KiWVCpB1YvdML7f9TAFbeeyP2H2PrKf
	NeKADOOPcYMV+/3R1xfIk7R6e8jLLt63ZnX5vJnoyUxKdmmSZg0RjYTQUHqnHXTE
	RIqUPqrBdi4IQKrR08XQXgWQx1+JPJezIsdNwWt7bA0DOJSahp95el6Vnx3hNCRl
	ei5+7Wuw0h4VvZKgNzJtozZT9/N7o6pxLJQ==
X-ME-Sender: <xms:oN-raDYO9uswdoz7Am9Or32-uxEo0M1VmfScWyEs0UkHIyYO7spIBg>
    <xme:oN-raPxobtLIWM132at0mz22pxMxiUbLpCH8WTEg7COEGG042Vb0Qw57uDJzadfDX
    VBKC5xLFROlAqZBDeo>
X-ME-Received: <xmr:oN-raNSSp_QrboYVpt3AUk13lzb_nUPhf5uBnIYhiXCXDx74BfARPkyewTf-Y-1CMpMaz3DTYYt1oatNHm-6f7uHqzDX6-A3O1o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedufeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:oN-raEJldICrR8WUXe_ginDjgsArPGh685i1bhddCXvUdh0aSZ0WAA>
    <xmx:oN-raMV50ptNNW_pCze1DvEOTLzDtbtz1Lqvq_dGW0AQdtj_LJ7XXQ>
    <xmx:oN-raASZGxOFKN7rFtgEyfErpKTeP0zAD-EXafOE3WFBJe60rFo4bg>
    <xmx:oN-raMBEYtiSq2vUvAtw0zSIAcsSyILcVq6rYoBjXPJhtZ2UKirJdw>
    <xmx:od-raAi5AxTdv-XbR_rwt91OaBk4DdERTfuDg_qJSuA-3fFKvZyCw0oW>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 23:59:25 -0400 (EDT)
Date: Mon, 25 Aug 2025 13:59:16 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Lance Yang <ioworker0@gmail.com>
cc: akpm@linux-foundation.org, geert@linux-m68k.org, lance.yang@linux.dev, 
    linux-kernel@vger.kernel.org, mhiramat@kernel.org, oak@helsinkinet.fi, 
    peterz@infradead.org, stable@vger.kernel.org, will@kernel.org
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
In-Reply-To: <20250825032743.80641-1-ioworker0@gmail.com>
Message-ID: <8ca84cf3-4e9c-6bb7-af3c-5ead372e8025@linux-m68k.org>
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
> However, as we've seen from the kernel test robot's report on 
> mt6660_chip, this won't solve the cases where a lock is forced to be 
> unaligned by #pragma pack(1). That will still trigger warnings, IIUC.
> 

I think you've misunderstood the warning that your patch produced. (BTW, I 
have not seen any warnings from my own patch, so far.)

The mistake you made in your patch was to add an alignment attribute to a 
member of a packed struct. That's why I suggested that you should align 
the lock instead.

Is there some problem with my approach?

