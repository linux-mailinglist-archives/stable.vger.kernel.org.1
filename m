Return-Path: <stable+bounces-183583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1937BBC3725
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 08:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CA54351325
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 06:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DA22E11AB;
	Wed,  8 Oct 2025 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H4pIYGV1"
X-Original-To: stable@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AF71EA7CF;
	Wed,  8 Oct 2025 06:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759904109; cv=none; b=ffQtRW6XGFpWNSy7E+nd3wU3fvaGkpt7B/eeuO8HY8pv2BFrFFFWO+U2GoTNOo4Kognw7fetYG3mw9dJeMqYqjIlqFIb4uU5m758YxEi3MCPazG3ELtbAMacUTL5AVDBInm2pAsfk5cIUwvtbK3yCfF2mt/pi4U7HTIW9lIFXOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759904109; c=relaxed/simple;
	bh=/ysWvONG/rRVXYMAmJinyLug2h51k7AZJtFHEIsBFSs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SNDVBu9qyDdxBfUxXlau5OKbFqO81Iz8rxI/8Pk0Ij8ESTbN4Nlmd1AGRGUGGwyQppZAHFw92zFj60/sr5pf3eehTCxJcv9jm6A1W/ZPkU9RQi6khbnYJydwx3W+gkEoKV9xOUnENH34UlOS+hqGAIRAcPk+G/cFXRWAFG6oNgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H4pIYGV1; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id D0D641D000F6;
	Wed,  8 Oct 2025 02:15:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 08 Oct 2025 02:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759904105; x=1759990505; bh=OR22NrgfEglb+PpHIQeRBTrbvW1PJ4Cuam0
	YJIEfV0I=; b=H4pIYGV1EQNs1jQJwTh4cFbdIOIqDSRbUJOrNMgSNleCr1uaDbz
	83gtppMOOi95c+qeZe0RZ6vT582FQQ61PIefr9Q4yZJ310MpqhxVG7cj2kaK7tH4
	R6Qtmse+wvoJQAPKfkJ9OxTnb8KM0V04PyvutoH0qntdFmDnVWd7neyq5+6jqhD+
	X2UTfd1xSNAAczuhzRZIxIhZ/JTdWQ/iKVgmrMDrjKm4O7fPXgNdTgezoH6zR7yA
	RiB+X5Ep/bT+FXlCqIvQb94rYcoGzq+kMkVr573/rrsyWX3YSyFjo/X8r6jLI1ZJ
	qkTnRMoUf9OodVOhWmo9IS3w0f05X0II3dQ==
X-ME-Sender: <xms:ZwHmaNI3P6wZKZ5XO7ttzt61tyxCx8Bx_CNiJVfGMKAb6DxNBsDI_Q>
    <xme:ZwHmaKfJ8VDqB04FBE21xAuXhTQMhnrAO0UagQJw9ZEow9A3k0WtjFPbv083SVBMy
    xJctAfMKO9TLLuVMOooppePT3bL5m2ahbddAFSjLHUMS_F6Q8o0CA>
X-ME-Received: <xmr:ZwHmaIItPTjqlOlS8uTwwV3QhM0Ud-0jiIvtel90eiw981OOu0gJ2HBYf3ZSoWkj_XJMV_cCIfL-X4N1kS-pOSyuZHkfsguImyc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvheehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ZwHmaEBshOGlofW4dgdH5pof2eeL8jG8Uku8px4j0R_klQ9lsJySTA>
    <xmx:ZwHmaBiof7ulRVDPwVSy9Bpjh9MPMSbYOSsyMXNNNAHM7E4HjLu2Jg>
    <xmx:ZwHmaON0SBtdBi7Q3fvlg8CEdc4pqpySVuxNjfHvktaxb05saU-6WQ>
    <xmx:ZwHmaIbIalGzzuNpmRJXqOfdvkK4sOffNS7H0h-RNQIHyNP-_xL39w>
    <xmx:aQHmaJbYvfqHNm6XqREz3Fom4EgOagPCSmFgJ5--AAVtb_uujybWKyuf>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 02:15:01 -0400 (EDT)
Date: Wed, 8 Oct 2025 17:14:51 +1100 (AEDT)
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
In-Reply-To: <56784853-b653-4587-b850-b03359306366@linux.dev>
Message-ID: <693a62e0-a2b5-113b-d5d9-ffb7f2521d6c@linux-m68k.org>
References: <20250909145243.17119-1-lance.yang@linux.dev> <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov> <99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org> <CAMuHMdVYiSLOk-zVopXV8i7OZdO7PAK7stZSJNJDMw=ZEqtktA@mail.gmail.com>
 <inscijwnnydibdwwrkggvgxjtimajr5haixff77dbd7cxvvwc7@2t7l7oegsxcp> <20251007135600.6fc4a031c60b1384dffaead1@linux-foundation.org> <b43ce4a0-c2b5-53f2-e374-ea195227182d@linux-m68k.org> <56784853-b653-4587-b850-b03359306366@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Wed, 8 Oct 2025, Lance Yang wrote:

> On 2025/10/8 08:40, Finn Thain wrote:
> > 
> > On Tue, 7 Oct 2025, Andrew Morton wrote:
> > 
> >> Getting back to the $Subject at hand, are people OK with proceeding
> >> with Lance's original fix?
> >>
> > 
> > Lance's patch is probably more appropriate for -stable than the patch I
> > proposed -- assuming a fix is needed for -stable.
> 
> Thanks!
> 
> Apart from that, I believe this fix is still needed for the hung task 
> detector itself, to prevent unnecessary warnings in a few unexpected 
> cases.
> 

Can you be more specific about those cases? A fix for a theoretical bug 
doesn't qualify for -stable branches. But if it's a fix for a real bug, I 
have misunderstood Andrew's question...

> > 
> > Besides those two alternatives, there is also a workaround:
> > $ ./scripts/config -d DETECT_HUNG_TASK_BLOCKER
> > which may be acceptable to the interested parties (i.e. m68k users).
> > 
> > I don't have a preference. I'll leave it up to the bug reporters (Eero 
> > and Geert).
> 

