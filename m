Return-Path: <stable+bounces-176462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7DFB37B59
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 09:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E8D6818FD
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 07:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E96314B89;
	Wed, 27 Aug 2025 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BZeJdeb7"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C6025B1CB;
	Wed, 27 Aug 2025 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756279047; cv=none; b=ncNPn+oC/F46qFCaTvqxaadnsQzEl5D/dJwWfh7u74JpI7yoqMJdhE3cvl9XjAeudV2fDPFiOQXS5mVqqNLrMtj3Q0VQlr9OmcX45eDBNAp//nzHGLTUdYY2SitCGPEK/OtvQC7IRbTGj2GZ2gFiM4D6LW8IgDft2pPpLfUVvQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756279047; c=relaxed/simple;
	bh=qLC53StXZFW+6X9riho55iA3y6os4QIsqa03TFKFkOU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WKfnfpjC8ns7u/TUe6CRjcEr+cgYv8Gb/K8ttQMYjfcS5DhX8MF2MTpAL3Lrv5m5R9La6IkNvbwPq7j1+Y7PrpWQxHf/UlGbTjuorccFCLc7bqZj6pQq/o+hySvc8erF/AGMRqecHWz8eecCCjnEdWrZnq2bKz7zYJm8s1YPwpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BZeJdeb7; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B443B7A01B6;
	Wed, 27 Aug 2025 03:17:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 27 Aug 2025 03:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756279043; x=1756365443; bh=TRPUqU5i8tcWANGMpkmvpTzAU/bgHfQuZgK
	QdInClDE=; b=BZeJdeb7bd+JdwUunh6xHrHl4MXB2J62IAnFSX20nwhjGB8DOnv
	YEK+8gbHxER1dru+U/Cbv8IPELZ6Lid7trvapBhBnk4HVjonHjBoQWuyreHLKA/t
	i6tP7lmVo2d50t5VlW8xiqwzOAccMmAcMuyfti4ajI2Ih2AWgI9akeo/OnnJMOBK
	n6cYp7U63KJ3O4xCik6YnMMjC27XYfufAigijGr9YqrKXLnm3VmIBNlDWD3v/QLw
	sj9Od8Iy8FJSqqvM9uIHdSRVILC+1tyKiKhwDGqqj3JFb9s5oC1G9iZANsWa70b3
	jUPrANuQTm+gdGD2zmuT6NjVkrZ7sPo+SqQ==
X-ME-Sender: <xms:ArGuaJTpjKACwhU1krrsEZDEkBeG5ykgVj3O4mxFKAqJxC34p7KjmA>
    <xme:ArGuaNabyiOPkNCL9lKmZPREFA21v_aEydHRddfR2HVwb83EJougQrx9E26rtNVXb
    Q4CO9LIHxIPXI90prk>
X-ME-Received: <xmr:ArGuaE1UMJT-qGu23QowhE3xC6_6jpNXayMn06jAsvIYSi5nE0f5LMdbcah0SNXX7yQ6d96RVGybFMdwNSkzrzKPkUMRc7DzSak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeejhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtoheplhgrnhgtvgdrhigrnhhgsehlihhnuhigrdguvghvpdhrtghpthhtoh
    epghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepmhhhihhrrghm
    rghtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehorghksehhvghlshhinhhkihhnvg
    htrdhfihdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ArGuaAoPVMrFJkEoxUQWIs98XMYDgKVJlhW8xE74LGRV6zzeGJIstw>
    <xmx:ArGuaDNKUawbYxP5NcUsZBDPORnAuBnjTcm2iMX8AgwCmqOIRUzqWg>
    <xmx:ArGuaJqi8HvNi0eavK-iinM0LBN1Up462-L-33Ts3HhX4I6bSjgnbg>
    <xmx:ArGuaOuY-JnD5_PVqxPX_9EP09aV8erEooqHh9ENQctN2q9SfHfHQA>
    <xmx:A7GuaP7B0SYlUw3ocUCDxPB_eYG_6DyZpOsFxmIynvYKGgskTMG9evoR>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 03:17:20 -0400 (EDT)
Date: Wed, 27 Aug 2025 17:17:19 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Peter Zijlstra <peterz@infradead.org>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Lance Yang <lance.yang@linux.dev>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, Eero Tamminen <oak@helsinkinet.fi>, 
    Will Deacon <will@kernel.org>, stable@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
In-Reply-To: <20250825114136.GX3245006@noisy.programming.kicks-ass.net>
Message-ID: <9453560f-2240-ab6f-84f1-0bb99d118998@linux-m68k.org>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org> <20250825071247.GO3245006@noisy.programming.kicks-ass.net> <58dac4d0-2811-182a-e2c1-4edfe4759759@linux-m68k.org>
 <20250825114136.GX3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Mon, 25 Aug 2025, Peter Zijlstra wrote:

> On Mon, Aug 25, 2025 at 06:03:23PM +1000, Finn Thain wrote:
> > 
> > On Mon, 25 Aug 2025, Peter Zijlstra wrote:
> > 
> > > 
> > > And your architecture doesn't trap on unaligned atomic access ?!!?!
> > > 
> > 
> > Right. This port doesn't do SMP.
> 
> There is RMW_INSN which seems to imply a compare-and-swap instruction of 
> sorts. That is happy to work on unaligned storage?
> 

Yes, the TAS and CAS instructions are happy to work on unaligned storage. 

However, these operations involve an indivisible bus cycle that hogs the 
bus to the detriment of other processors, DMA controllers etc. So I 
suspect lock alignment would tend to shorten read-modify-write cycles, and 
improve efficiency, when CONFIG_RMW_INSN is enabled.

Most m68k platforms will have CONFIG_RMW_INSN disabled, or else simply 
don't implement TAS and CAS. In this case, lock alignment might still 
help, just because L1 cache entries are long words. I've not tried to 
measure this.

