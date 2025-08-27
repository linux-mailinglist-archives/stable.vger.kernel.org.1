Return-Path: <stable+bounces-176468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157F0B37CAA
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 10:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14663BAA2B
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 08:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD42321F43;
	Wed, 27 Aug 2025 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VhIluC/q"
X-Original-To: stable@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F110A32145D;
	Wed, 27 Aug 2025 08:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281649; cv=none; b=byTtz/nn+/CFUX9b5mkRJudEf4v6h5HNVn2ocM/hBf9C5mvQS0wd71leNR9VYyt9vBUJ8AwOtuLXb5SnBWqyVUPSV1luCc3/Tf72CQUrYhE5iqQKOBF/hrRX1eUWb0cBMwSP1jCqe09oXdzgqdlT24ib+TxPhp7gSkbeyueorgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281649; c=relaxed/simple;
	bh=IFI5IEqviMYeGQz8mOqLXuunI+6V5VvCW77dx4CtKE0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pfx18cM/lPfcnC0Zr+POrjmwOJwbqjEUd3U5svUZCBCiQeKeiJYkqwB7pcbUDcR5NGGRfFrZrvnrO1nJ+eIOE5qqt4Rn+RrTu9ZzHA5VrP7TK2alKm7SuFDyuqBVh5y236lDx1tVo18oOCC8LkcmVx8fg1+PQer26/ypQhzadlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VhIluC/q; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 90B8E1D001BB;
	Wed, 27 Aug 2025 04:00:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 27 Aug 2025 04:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756281646; x=1756368046; bh=giTxXPs34nsMyod8hLGAXg4/KSFcikyw3c2
	iZ7B+EA8=; b=VhIluC/qxy2tWVsuRpQXSYOidID3ehfAKR/oY3TN9YD5fmsPeWH
	AJYDdw79T8EplszNM5LYjFSAEQqb7qZcRu3uXNa6dzoDKJtiNsABRule+z/WMyGo
	cENu9SbbBBQmq4+fzZPid55RKzK0qeQ0pBdHHB8J5Ok1L9DY/Pq/QYIt/8v53PbF
	1Ich36NiLcUOc8FvxffdYJs+wLtGwNkjEVVZoVCBwYc7SeDI7vw8+Cxg29tof1yV
	i+hN4eV3/eBgO2WficlNBQQXXypZGizJG+u1A4RfXmfnwH0ixsPHLKlQ31toftig
	w9VdKRnATyiE/1zd0XjTO0oV6ok3Ei4VrRQ==
X-ME-Sender: <xms:LbuuaKKqLjE-z3j7_APGsA1o5_u7H4Q-7QYD8ZvuLs9Hn_uGPLvbFA>
    <xme:LbuuaKx20p6NOddJbukWc_Q8yyJVvSs6QYZNzOoxI55SZ4GFGArcoFcK454VaJw5c
    ErAb0O0oXXYwAc0oNE>
X-ME-Received: <xmr:LbuuaCLirzssA8kvtY0bwx6KRjT91wqt4ulLXTTRsbInD7rG3za3Sz_8E6IFil-t9335L6PY8pDEeT9At2sRXYV87ZF05VhVtlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeejiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeduuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgrnhgtvgdrhigrnhhgsehlihhnuhigrd
    guvghvpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohgrkhes
    hhgvlhhsihhnkhhinhgvthdrfhhipdhrtghpthhtohepphgvthgvrhiisehinhhfrhgrug
    gvrggurdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:LbuuaJXvMDLRRVpCE54t9f8Wc22szdDwQL7b_12KtYMBXmbo42S5nQ>
    <xmx:LbuuaFZLoyZzP3wFelgHd-mmpKVUVGTzj8V_STfFX_mdUTu1HT7foA>
    <xmx:LbuuaAyRz_hhRGQXnSJNv8tLSsVC8pThuqjw3qhuo5qILJcpzU-rvQ>
    <xmx:LbuuaF3Hb74zdX5pOOd-2DD_hsp6EBEFY5VPFTJkfvhLU4Dcvpg2HQ>
    <xmx:LruuaGAhtVdB-WvB9v7Bglg8fKf8x3nAsB7tFMHCc2YBeGXDZEu9Av1d>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 04:00:43 -0400 (EDT)
Date: Wed, 27 Aug 2025 18:00:43 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Lance Yang <lance.yang@linux.dev>
cc: David Laight <david.laight.linux@gmail.com>, akpm@linux-foundation.org, 
    geert@linux-m68k.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org, 
    oak@helsinkinet.fi, peterz@infradead.org, stable@vger.kernel.org, 
    will@kernel.org, Lance Yang <ioworker0@gmail.com>
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
In-Reply-To: <b199a90c-4a7f-42bf-9d17-d96f63bb5e62@linux.dev>
Message-ID: <312ba353-6b4e-c3ef-40ce-a9dddf3275a3@linux-m68k.org>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org> <20250825032743.80641-1-ioworker0@gmail.com> <c8851682-25f1-f594-e30f-5b62e019d37b@linux-m68k.org> <96ae7afc-c882-4c3d-9dea-3e2ae2789caf@linux.dev>
 <5a44c60b-650a-1f8a-d5cb-abf9f0716817@linux-m68k.org> <4e7e7292-338d-4a57-84ec-ae7427f6ad7c@linux.dev> <20250825130715.3a1141ed@pumpkin> <b199a90c-4a7f-42bf-9d17-d96f63bb5e62@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Mon, 25 Aug 2025, Lance Yang wrote:

> > 
> > More problematic is that, IIRC, m68k kmalloc() allocates 16bit aligned 
> > memory. This has broken other things in the past. I doubt that 
> > increasing the alignment to 32bits would make much difference to the 
> > kernel memory footprint.
> 
> @Finn Given this new information, how about we just apply the runtime 
> check fix for now?

New information? No, that's just hear-say.

> Since we plan to remove the entire pointer-encoding scheme later anyway, 
> a minimal and targeted change could be the logical choice. It's easy and 
> safe to backport, and it cleanly stops the warnings from all sources 
> without introducing new risks - exactly what we need for stable kernels.
> 

Well, that's up to you, of course. If you want my comment, I'd only ask 
whether or not the bug is theoretical (outside of m68k).

