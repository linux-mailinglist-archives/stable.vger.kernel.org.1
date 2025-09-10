Return-Path: <stable+bounces-179149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48399B50A4D
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 03:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93A9563F39
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 01:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2561F4E59;
	Wed, 10 Sep 2025 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gi5EoDq7"
X-Original-To: stable@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D2441C69;
	Wed, 10 Sep 2025 01:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468152; cv=none; b=LJ+MVBT2urFBqNwweVsRRe803C9uUOV0DHTKugAK9pGY3CU1EK3dpwvHeuNVby1yguj3YHSwE9vWhElHGvfIHKUBndHvNDxVflxXyZI1DdeAN8ozBVm5T7WCDG+vMOiic3zSkKj/Un8ZV0kC5f2GO/O9BC9AzGkLNGNbMgvzxNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468152; c=relaxed/simple;
	bh=qE61qTi8LgUZFVbJJ77bFr2IjshzrNfai6AvqPbqkQ0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Gaxw4Mw3j7qilP0U6yhBvS5jDA1kur+YzivH7mohXCFDSfLaxkMjGOswTKwzadKOKq86r6UPx+kCXIzuTMxRn5Ckkjw0y1clq22JY2CajGfE+iNZrUPNxFB7B770bJX5bAOxUVFeIfNId9ZtfVHScogqjJRFyqhKKs1yKqk0atc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gi5EoDq7; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 67C93EC026E;
	Tue,  9 Sep 2025 21:35:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 09 Sep 2025 21:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757468149; x=1757554549; bh=FaMspWDp0VQGcO34IAI3qq1BsPsPB1Ip27A
	SHORYje8=; b=gi5EoDq7AWQvx+6XbVQhdsANgOr2CqEFz6XUEF4kXTB+wu7K4/k
	mCKE06X+HzIsUipRzPi+IkqHVSvEf/7wXNVmAkFhv3so63GgGR5mkuplfaSUbjx9
	5yTu/QrhA/IEmtylnW+CJEYOGHtAm+BEhkkTHGYJFoXYkfubJZ2LDGsoNpEmHN29
	re27POKBdx8+tjHi8aAhrlfglCqNXjJcejN+sNl6cPyxQDbAoQiokGTAUdTgPOAf
	c9FeOWMtd/DNfCzsGU9fygrHS2Z18GGNtxZ6ty5sKUFC0DoMx4Y2LqlE9TYRbFkS
	fELjOdP8uTYQPsIs9w/v2LTJzbw3u9bW1VA==
X-ME-Sender: <xms:9NXAaPGblCWXdLLWjiNisy0ZybeujhxKEA-igglZpjqlrdoJH-SZkw>
    <xme:9NXAaNpE1eBl5FECw8vjZ-rl0H3P5VUjwYaWYIgFWmWYHW_RzXBrgxMGmLWSqbkjP
    HoQj4qxeGZ5-8XHg9o>
X-ME-Received: <xmr:9NXAaDl0zKlGdfe0W5Sf7manxMM_R2-q0L6kIxgMcawkgVheQ8Q8m3pSB7AWt-X-HQV6K_NLSJ31d60CPFI6EA4J6TmvEmto0y4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueehueel
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthh
    grihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepvdegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkvghnthdrohhvvghrshhtrhgvvghtsehlih
    hnuhigrdguvghvpdhrtghpthhtoheplhgrnhgtvgdrhigrnhhgsehlihhnuhigrdguvghv
    pdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopegrmhgrihhnuggvgiesohhuthhlohhokhdrtghomhdprhgtphhtthhopegr
    nhhnrgdrshgthhhumhgrkhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepsghoqh
    hunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgvvghrtheslhhinhhu
    gidqmheikehkrdhorhhgpdhrtghpthhtohepihhofihorhhkvghrtdesghhmrghilhdrtg
    homhdprhgtphhtthhopehjohgvlhdrghhrrghnrgguohhssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9NXAaCvywdf_hr7ZgceS8S1xH5UK_l6nLTIUMhpwcYK9C4Di1Fc6dA>
    <xmx:9NXAaCfPphh9mfASr2fe10H6bJv-9mgM7HdLlIl1p5ESQbf8aZyv5A>
    <xmx:9NXAaEaQ3_WBoes9oWaCEH49xZlXCQcBoGFCudgNy-_blqolrIH1Xg>
    <xmx:9NXAaK1joD8P8zTNPXoShh1SpiFF5ZqM-m_0c7ekRkwh93TiSJNBtA>
    <xmx:9dXAaHEk5hkzq-D6n6R6acg1uGhnQHyVywsTWyVFtInJ5fO3wOai3L7X>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 21:35:46 -0400 (EDT)
Date: Wed, 10 Sep 2025 11:35:56 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org, 
    amaindex@outlook.com, anna.schumaker@oracle.com, boqun.feng@gmail.com, 
    geert@linux-m68k.org, ioworker0@gmail.com, joel.granados@kernel.org, 
    jstultz@google.com, leonylgao@tencent.com, linux-kernel@vger.kernel.org, 
    linux-m68k@lists.linux-m68k.org, longman@redhat.com, mhiramat@kernel.org, 
    mingo@redhat.com, mingzhe.yang@ly.com, oak@helsinkinet.fi, 
    peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, 
    tfiga@chromium.org, will@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
In-Reply-To: <ufkr7rkg7rsfo6ovsnwz2gqf4mtmmevb3mququeukqlryzwzmz@x4chw22ojvnu>
Message-ID: <bea3d81c-2b33-a89d-ae26-7d565a5d2217@linux-m68k.org>
References: <20250909145243.17119-1-lance.yang@linux.dev> <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov> <99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org> <ufkr7rkg7rsfo6ovsnwz2gqf4mtmmevb3mququeukqlryzwzmz@x4chw22ojvnu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Tue, 9 Sep 2025, Kent Overstreet wrote:

> On Wed, Sep 10, 2025 at 10:07:04AM +1000, Finn Thain wrote:
> > 
> > On Tue, 9 Sep 2025, Kent Overstreet wrote:
> > 
> > > On Tue, Sep 09, 2025 at 10:52:43PM +0800, Lance Yang wrote:
> > > > From: Lance Yang <lance.yang@linux.dev>
> > > > 
> > > > The blocker tracking mechanism assumes that lock pointers are at 
> > > > least 4-byte aligned to use their lower bits for type encoding.
> > > > 
> > > > However, as reported by Eero Tamminen, some architectures like 
> > > > m68k only guarantee 2-byte alignment of 32-bit values. This breaks 
> > > > the assumption and causes two related WARN_ON_ONCE checks to 
> > > > trigger.
> > > 
> > > Isn't m68k the only architecture that's weird like this?
> > > 
> > 
> > No. Historically, Linux/CRIS did not naturally align integer types 
> > either. AFAIK, there's no standard that demands natural alignment of 
> > integer types. Linux ABIs differ significantly.
> > 
> > For example, Linux/i386 does not naturally align long longs. 
> > Therefore, x86 may be expected to become the next m68k (or CRIS) 
> > unless such assumptions are avoided and alignment requirements are 
> > made explicit.
> 
> That doesn't really apply; i386's long long is ugly but it's not as much 
> of an issue in practice, because it's greater than a machine word.
> 

Similarly, on m68k, there is no issue with __alignof(long) == 2 because 
these platforms don't trap on misaligned access. But that seems a bit 
irrelevant to the real issue, which is not specific architectural quirks, 
but the algorithms and their ongoing development.

> ...
> > 
> > IMHO, good C doesn't make alignment assumptions, because that hinders 
> > source code portability and reuse, as well as algorithm extensibility. 
> > We've seen it before. The issue here [1] is no different from the 
> > pointer abuse which we fixed in Cpython [2].
> 
> That kind of thinking really dates from before multithreaded and even 
> lockless algorithms became absolutely pervasive, especially in the 
> kernel.
> 

What I meant was, "assumptions hinder portability etc." not "good C 
hinders portability etc." (my bad).

> These days, READ_ONCE() and WRITE_ONCE() are pervasive, and since C 
> lacks any notion of atomics in the type system (the place this primarily 
> comes up), it would go a long ways towards improving portability and 
> eliminating nasty land mines.
> 

Natural alignment would seem to be desirable for new ABIs, until you 
realize that it implies wasted RAM on embedded systems and reduced data 
locality (that is, cooler caches if you did this on i386).

