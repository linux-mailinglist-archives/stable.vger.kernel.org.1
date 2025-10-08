Return-Path: <stable+bounces-183573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93807BC313A
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 02:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8115E4E2203
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 00:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221842853E9;
	Wed,  8 Oct 2025 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VwdkZqZ4"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F011FA859;
	Wed,  8 Oct 2025 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759884024; cv=none; b=i9T1b80TRU0C0P731yUDzYlt6vu/5MrBARE/gPzSpAubPpnsSg0MPG8g9SsflpzV/rtvxP0Fxx+94SR5s5obYhBE4GY88j8zFFXWqBUJK6/bo1SrkEfbkiKnFuB4Ycpl74rgo69q5xzPEEY1a2P/dhiwKbGjdbql9hwfmUPMKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759884024; c=relaxed/simple;
	bh=4Lj6XaN2MmCn4Ty31dhCcFk/RRrhqYrrk/p2EtLxfgs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=vDheB1fNuMC2SLvcUvXe+qLl/a/rgJzQNdAgkNPqN1GGRNnjhz6N5B3RS+yP2KTchc46nItR2miuCIjDm/PNDK+Jrc+fZumHj/spuDlj5s/ony93FfCg47CjXUTpAJUl2bLB0Cx7MIlcQ0Mq4kQF8zK4pIGa2hd34uHRaPb4VOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VwdkZqZ4; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 229E914005B1;
	Tue,  7 Oct 2025 20:40:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 07 Oct 2025 20:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759884022; x=1759970422; bh=GIQqrOTmZqlirCfdm3X1h0B9JmIfdK5suLW
	7FpXibLA=; b=VwdkZqZ4D9mMNQ50FJ8vt034npGjIiVnaoOm/Cr6hYN0i76aTFC
	DAX/kfGxEMubDBgsZOKO3wTPxRaVEAQD61LBIhIxHPBJfPWdPLhyUjTwE9/IOaoY
	c+/Rcd6CM5Pv/PdH3DPRtUqQaGSXMCcKpP9vz4sER/7ixtx3lCixEpauRin/sCYT
	t2cMvqb50YEo6n/0VTAU4EZUxSATg8uIEMEmFJybkeZEsAJUIruT23P0QJfOQ24g
	rSZ8es58kqIxlrFbGEBbjXC2G6+wCX72ibbAYIN31Uq++o07ZaEVo6QfNcxlp4JV
	4IfZmQXnzsS9Me/lR4hB0GQW1SL25wEyldQ==
X-ME-Sender: <xms:87LlaNp5q7HArd0fhgaJV7uvZQG6_a_eJPncjOasx8yIma_2qD2AwQ>
    <xme:87LlaLWNFyMVVQgBqSvK-kxSyJ2DZK7Di3aMZNWFr1qEuRzvXW4wwR2fRHrSWymoW
    NyokvQVFEBkef4HVZxY561ayUhxq8XvLD72_L8jC1P8KyiEOcq8PIE>
X-ME-Received: <xmr:87LlaE5NfE9cpCiamDcg51BfyMGBd3Gb2UTyy7ckRUFU8hCmrRC2xMnzbJupfQP0PUvA3ObD3juOMQupCSNClqrl1I95HmeoLPU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddukeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopedvgedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhr
    ghdprhgtphhtthhopehorghksehhvghlshhinhhkihhnvghtrdhfihdprhgtphhtthhope
    hkvghnthdrohhvvghrshhtrhgvvghtsehlihhnuhigrdguvghvpdhrtghpthhtoheplhgr
    nhgtvgdrhigrnhhgsehlihhnuhigrdguvghvpdhrtghpthhtoheprghmrghinhguvgigse
    houhhtlhhoohhkrdgtohhmpdhrtghpthhtoheprghnnhgrrdhstghhuhhmrghkvghrseho
    rhgrtghlvgdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homhdprhgtphhtthhopehiohifohhrkhgvrhdtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:87LlaJ1FczvzMhYXPa0JGQElbUfGWoiZGJkuFow5sf0FqicGrvIc3Q>
    <xmx:87LlaL_xGHyojH9SdXJQOn9BYEjUJQIu8tLodRgilRsxOUEZz7rYwQ>
    <xmx:87LlaCuZwC_-s-n_W5DetwBmZRfR5rDbh4ZKCIXU72FuhOH-fknO4Q>
    <xmx:87LlaPorCqtvHMBeN_xkH7zPAltn74kZjyUlNGacXr7gsFIhTjRGOA>
    <xmx:9rLlaOk84XAnOx4ieLBPJf7Fc1DQLRWoIpvkPx00d0A0IuFkcLFfBkyU>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 20:40:17 -0400 (EDT)
Date: Wed, 8 Oct 2025 11:40:09 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Eero Tamminen <oak@helsinkinet.fi>
cc: Kent Overstreet <kent.overstreet@linux.dev>, 
    Lance Yang <lance.yang@linux.dev>, amaindex@outlook.com, 
    anna.schumaker@oracle.com, boqun.feng@gmail.com, ioworker0@gmail.com, 
    joel.granados@kernel.org, jstultz@google.com, leonylgao@tencent.com, 
    linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
    longman@redhat.com, mhiramat@kernel.org, mingo@redhat.com, 
    mingzhe.yang@ly.com, peterz@infradead.org, rostedt@goodmis.org, 
    senozhatsky@chromium.org, tfiga@chromium.org, will@kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
In-Reply-To: <20251007135600.6fc4a031c60b1384dffaead1@linux-foundation.org>
Message-ID: <b43ce4a0-c2b5-53f2-e374-ea195227182d@linux-m68k.org>
References: <20250909145243.17119-1-lance.yang@linux.dev> <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov> <99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org> <CAMuHMdVYiSLOk-zVopXV8i7OZdO7PAK7stZSJNJDMw=ZEqtktA@mail.gmail.com>
 <inscijwnnydibdwwrkggvgxjtimajr5haixff77dbd7cxvvwc7@2t7l7oegsxcp> <20251007135600.6fc4a031c60b1384dffaead1@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Tue, 7 Oct 2025, Andrew Morton wrote:

> 
> Getting back to the $Subject at hand, are people OK with proceeding
> with Lance's original fix?
> 

Lance's patch is probably more appropriate for -stable than the patch I 
proposed -- assuming a fix is needed for -stable.

Besides those two alternatives, there is also a workaround:
$ ./scripts/config -d DETECT_HUNG_TASK_BLOCKER
which may be acceptable to the interested parties (i.e. m68k users).

I don't have a preference. I'll leave it up to the bug reporters (Eero and 
Geert).

