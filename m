Return-Path: <stable+bounces-172689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99C2B32DA2
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 07:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748494836F2
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 05:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0384C8F;
	Sun, 24 Aug 2025 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JpWc6EW3"
X-Original-To: stable@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C4548EE;
	Sun, 24 Aug 2025 05:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756015087; cv=none; b=WBHWiclDQp7IoJ1l+RENd49crjA8UXb7vTuyPJR84WeVGfYoTrZzHtUIEOQkA4dSfLL8NsQ6iBwySjzwf5vLKrxvn6W0azATwOfJAGI/dzXiZ6mDL58qQh0pU3DNt0rIILXoiS4wP8u2J0woaz20oZW04Ad6Gvt1Ut5+ILlRENo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756015087; c=relaxed/simple;
	bh=NOsVvWeGq9yVoxU0He0LWaxS05fvufnHzf9w7iIGplQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tLQ9+Obdp/qQFpWlvfKO+qKau05unyk3IqWSPv5GYTUySQHKbGPeMYTU1Ovq+M6eq6qyZ1Aqn9YCqNbyG5RaxrYXJW236dn5X/oyFQHd04VPTGf/G4VO1GJkH8+KJxDEp41gDuzazqTnoA8UfgcjKjP44vIU5MYeHnKegU+67PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JpWc6EW3; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A5EA91D000C3;
	Sun, 24 Aug 2025 01:58:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 24 Aug 2025 01:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756015083; x=1756101483; bh=PUgkjS9h8mwj/ORjb6NeXOBXhic0qYmAbfd
	1iyBJAEw=; b=JpWc6EW35YUmwkueYRGWjYIDc4jCCyAXWL28WAipnBUfZQr4E5n
	YedCEOSoKauSS/zDW800bpTqfAphEGz5tL3VwpHIwApYj0709R3fCio70/ZU5Bv7
	z4A4kgjB6bCQHQ+wfbBJhfaHUfey4XeoMqoKisfZJjMQWUbrSBXqqvjc2wZITRPf
	rgWqKEGxg38PNLQjFJxTwyExAJELPnbueB7JyJMW0Wn+ITRzdkeCnJIDnRq0nkGn
	F48kHILksQ8KS8N0S9IixSYX1bbLjC/XN40yNohH2KqnagJeGKThP36SO/dROqKI
	lZn9Pu46K89jE8HN0nmDjU4ArvBZdua3UPA==
X-ME-Sender: <xms:6KmqaKGu9YT4hfhHuhvVFQldZyk2dF-mlD9twvdlECRmofeiBcKhOA>
    <xme:6KmqaOFMNhqugSFlktbEJ06LzgJNWa8TV6b2nklogX_JxdGHiw5f9sPC24HhfMpvb
    N1fsfhXoukbHq-LpXE>
X-ME-Received: <xmr:6KmqaBB9-YK4ib1kuFU5UcPRWr_Lj5u1BGc_ju3zP_5DcIToYGvINIiNeHm9ZgUGDycgr7o2-bTH7UZMqfLGwFS0Aoup6mBXq4k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieekjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopedvhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgrnhgtvgdrhigrnhhgsehlihhnuhigrd
    guvghvpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhm
    ieekkhdrohhrghdprhgtphhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumh
    drohhrghdprhgtphhtthhopehovgdqkhgsuhhilhguqdgrlhhlsehlihhsthhsrdhlihhn
    uhigrdguvghvpdhrtghpthhtoheprghmrghinhguvgigsehouhhtlhhoohhkrdgtohhmpd
    hrtghpthhtoheprghnnhgrrdhstghhuhhmrghkvghrsehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:6KmqaLlQVRLeAlNRzH1KS39Yxr6XT3tzgC0Y-QAw7IEl2Jpx3eTuIg>
    <xmx:6KmqaH6K1Kb6DKji1QIQCoUXGd9kMOJoynPIHuriidpTxhOV9ctiZQ>
    <xmx:6KmqaKuIgPE2oQg4HsyDBrD2d4VZLJxNLIvHYGxBpLfAMpVOqh73qA>
    <xmx:6KmqaPVRCrdzXWWsMFlq2-2GWTNwECUI61rwIMXNoMBYSRRwIB7VGQ>
    <xmx:66mqaCL7N51l9u1OwvKUR7zbwtUGrEPap9ilgiaCuJJRvkX34Yex6NFs>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 01:57:57 -0400 (EDT)
Date: Sun, 24 Aug 2025 15:57:51 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Lance Yang <lance.yang@linux.dev>
cc: akpm@linux-foundation.org, mhiramat@kernel.org, 
    kernel test robot <lkp@intel.com>, geert@linux-m68k.org, 
    senozhatsky@chromium.org, oe-kbuild-all@lists.linux.dev, 
    amaindex@outlook.com, anna.schumaker@oracle.com, boqun.feng@gmail.com, 
    ioworker0@gmail.com, joel.granados@kernel.org, jstultz@google.com, 
    kent.overstreet@linux.dev, leonylgao@tencent.com, 
    linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
    longman@redhat.com, mingo@redhat.com, mingzhe.yang@ly.com, 
    oak@helsinkinet.fi, rostedt@goodmis.org, tfiga@chromium.org, 
    will@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] hung_task: fix warnings by enforcing alignment on
 lock structures
In-Reply-To: <e27b6484-8fb9-4c7f-9c8f-4d583cb64781@linux.dev>
Message-ID: <0e0d52b4-8c69-9774-c69d-579985c0f0ee@linux-m68k.org>
References: <20250823074048.92498-1-lance.yang@linux.dev> <202508240539.ARmC1Umu-lkp@intel.com> <29f4f58e-2f14-99c8-3899-3b0be79382c2@linux-m68k.org> <9efaadc9-7f96-435e-9711-7f2ce96a820a@linux.dev> <a70ad7be-390f-2a2c-c920-5064cabe2b36@linux-m68k.org>
 <e27b6484-8fb9-4c7f-9c8f-4d583cb64781@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Sun, 24 Aug 2025, Lance Yang wrote:

> 
> The blocker tracking mechanism operates on pointers to higher-level 
> locks (like struct mutex), as that is what is stored in the 
> task_struct->blocker field. It does not operate on the lower-level 
> arch_spinlock_t inside it.
> 

Perhaps you are aware that the minimum alignment of the struct is at least 
the minimum alignment of the first member. I believe that the reason why 
the lock is always the first member is that misaligned accesses would harm 
performance.

I really don't know why you want to argue about fixing this.

> While we could track the internal arch_spinlock_t, that would break 
> encapsulation.
>

Would it.

> The hung task detector should remain generic and not depend on 
> lock-specific implementation details ;)
> 

OK, like a new class derived from bitfield and pointer? Is that what you 
mean by "generic" and "encapsulated"?

