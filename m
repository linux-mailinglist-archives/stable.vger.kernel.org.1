Return-Path: <stable+bounces-183597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CF5BC4427
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 12:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E5B18996B7
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 10:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385E82F5463;
	Wed,  8 Oct 2025 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KapiCPuC"
X-Original-To: stable@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DFE2EBDF0;
	Wed,  8 Oct 2025 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759918358; cv=none; b=o4ANX6+PwwrCkPNehEGJb/OF7jogneJ4XN1YjChHJtPn5rkRX18acwBr224MWukwxp7yuVFerFKMM0uUxP9NhEaFipvUfCtMY29zXb8dakwjvZqltedcejxh8QgUTZ9CqXbMR09pFT55nKJrOdIPfWwsy0yoUXuZIPqb+/jU8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759918358; c=relaxed/simple;
	bh=jTzS4kwuSRRXeuWd1CLD8POBVGHVhraKrwblg4VzhoY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hdLLeCPQbX9y1kHk2nnwEDRxHkMrpOJwIOeZyN9iYIbPxZXgbmr8746iFAiP2C9EBlqee8nXJ+/tCfIa2TjeJDvuXSBlxsUR7xT9GgEmgxHMSyiAijtvRFmPO4x4eYQmJJ2CkA4eZxn12fZikoP7T94d3p5iUd/KLp068ZKGBhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KapiCPuC; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B05E91D000FE;
	Wed,  8 Oct 2025 06:12:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 08 Oct 2025 06:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759918354; x=1760004754; bh=C0mcj3R+Pq8SIGSRvhGuf+yHogOBW1PlBpA
	1eheqQNM=; b=KapiCPuCp29GApxnLpCSKulJsqpaf8XHRowgnKPp4jrgvHasYCZ
	Et4yb5sn+JzWcER1uSpLeM71B9du/M1aRSzq0zTWWybwyaJ2Pzl6fHGGGwcyIMBy
	MNa0JZIjKuZaS5oPw+1wBI/9z7lOC7wEFGsoLMUMJkxAt3glA77fZDSth0IP+PGd
	mwuVEu+KoQKd4a/z/HXGLeZawExXcoShz5zRASOfKV0u6nQOF6lBpvBJlGMxr3VX
	IiXVBU74iOgaDJktCoe4suDAR7p0uOpNufzCAxI448uFV4HYY7mbwCJtqEfEvHwV
	6Hr3Ak+57cjrRbPkk+cJtr0ah4KAIkv0hWA==
X-ME-Sender: <xms:EDnmaCkxwIP7KCxdmOBTKLYXjtTAfuYD-4_KFP-fH1rXw3v1nDV3UQ>
    <xme:EDnmaFiUbrHuADkHU4jwiYnnI6i1JmwVU9imU0GDJ15BNcpgsX_6p-v5KlfzIk79e
    z099J1GKSoxyLM8Yf8g1SscDqHv8vT8_wUWgqQZpbFXNuVemu2kxAF3>
X-ME-Received: <xmr:EDnmaLWSxJInq4dHcPBwHkQYAzyQI8pukgAHsC3j82dRJ3uF9si0LGiU7yjwkYmXM2pXb7UVYUplJc8V69vDTVSqrF5JUdYDszw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeftddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopedvgedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgrnhgtvgdrhigrnhhgsehlihhnuhigrd
    guvghvpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtth
    hopehorghksehhvghlshhinhhkihhnvghtrdhfihdprhgtphhtthhopehkvghnthdrohhv
    vghrshhtrhgvvghtsehlihhnuhigrdguvghvpdhrtghpthhtoheprghmrghinhguvgigse
    houhhtlhhoohhkrdgtohhmpdhrtghpthhtoheprghnnhgrrdhstghhuhhmrghkvghrseho
    rhgrtghlvgdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homhdprhgtphhtthhopehiohifohhrkhgvrhdtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:EDnmaHhchxw7do8bN3Csr6DXSWWYITTQu_fXTdKWOxl3okX7cwIYVg>
    <xmx:EDnmaP5uE1polYs9_9nbOSKFHRzQoKXIvzwW5hNT7w9MJnvbghRq5w>
    <xmx:EDnmaP6GAth2rEMCVRdbPubAvY9k8qzkF7Tw_0dOXXIpfuNiFnLoDA>
    <xmx:EDnmaNEATMPGkyTg9DPaHQXiWarxNONnV-fuk4oWC77sB-bPZmd56g>
    <xmx:EjnmaLSMmBUvoF2AHnNlW92owPDU9p8ndw6RcIizLqHogBTKm53hQFnZ>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 06:12:29 -0400 (EDT)
Date: Wed, 8 Oct 2025 21:12:24 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Lance Yang <lance.yang@linux.dev>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Eero Tamminen <oak@helsinkinet.fi>, 
    Kent Overstreet <kent.overstreet@linux.dev>, amaindex@outlook.com, 
    anna.schumaker@oracle.com, boqun.feng@gmail.com, ioworker0@gmail.com, 
    joel.granados@kernel.org, jstultz@google.com, leonylgao@tencent.com, 
    linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
    longman@redhat.com, mhiramat@kernel.org, mingo@redhat.com, 
    mingzhe.yang@ly.com, peterz@infradead.org, rostedt@goodmis.org, 
    senozhatsky@chromium.org, tfiga@chromium.org, will@kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
In-Reply-To: <2bd2c4a8-456e-426a-aece-6d21afe80643@linux.dev>
Message-ID: <ba00388c-1d5b-4d95-054d-a6f09af41e7b@linux-m68k.org>
References: <20250909145243.17119-1-lance.yang@linux.dev> <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov> <99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org> <CAMuHMdVYiSLOk-zVopXV8i7OZdO7PAK7stZSJNJDMw=ZEqtktA@mail.gmail.com>
 <inscijwnnydibdwwrkggvgxjtimajr5haixff77dbd7cxvvwc7@2t7l7oegsxcp> <20251007135600.6fc4a031c60b1384dffaead1@linux-foundation.org> <b43ce4a0-c2b5-53f2-e374-ea195227182d@linux-m68k.org> <56784853-b653-4587-b850-b03359306366@linux.dev>
 <693a62e0-a2b5-113b-d5d9-ffb7f2521d6c@linux-m68k.org> <23b67f9d-20ff-4302-810c-bf2d77c52c63@linux.dev> <2bd2c4a8-456e-426a-aece-6d21afe80643@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Wed, 8 Oct 2025, Lance Yang wrote:

> 
> In other words, we are not just fixing the bug reported by Eero and 
> Geert, but correcting the blocker tracking mechanism's flawed assumption 
> for -stable ;)
> 
> If you feel this doesn't qualify as a fix, I can change the Fixes: tag 
> to point to the original commit that introduced this flawed mechanism 
> instead.
> 

That's really a question for the bug reporters. I don't personally have a 
problem with CONFIG_DETECT_HUNG_TASK_BLOCKER so I can't say whether the 
fix meets the requirements set in 
Documentation/process/stable-kernel-rules.rst. And I still don't know 
what's meant by "unnecessary warnings in a few unexpected cases".

