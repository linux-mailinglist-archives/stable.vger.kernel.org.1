Return-Path: <stable+bounces-172687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB91B32D82
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 06:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880D920813E
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 04:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3AD8634F;
	Sun, 24 Aug 2025 04:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H8scj8/7"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A711A5B8D;
	Sun, 24 Aug 2025 04:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756009136; cv=none; b=Tk0Rg/xPdK/VgvGcgwHN0vJm9fNQZiyVCgEdVKLM0mo4BSX1I1Yh+4Yao7jiEUi4inPa7ebjYliB0nAWOILjt5CACtet4n2NxQdyoldFK8wRObGyqqu1Ufyo3B3IJvfG9hhtZDmvi+erLtRegVqXRo62QKOJC7ljSRtEzxzNe2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756009136; c=relaxed/simple;
	bh=PgrvWjQLdnobuzqkl8Do45OnUnsVww0l+TYYOWTgVdk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=legaSVtU+OucZ8khFkEvz+8KZyljxv/jyKsTJ0Btr2oEfqzHXXKx74YVFAod9MAPHCBOfLQIpq/pcC56gmxAOAOpnNJrs0gqDmYKuL9BkXnOqklGzoOIz7OCHvHqKZrs0rtSOUn83mbA1TjKNYODcFq7IdrulYHeWKDu8QtubZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H8scj8/7; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 014137A00E2;
	Sun, 24 Aug 2025 00:18:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 24 Aug 2025 00:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756009132; x=1756095532; bh=UL4fY53RuCaHLxIJCFVkyxRiL0i1Tp062V0
	6DMdlvbI=; b=H8scj8/74QNVhs4DbfNlzFP4jlrlh5ALAxYt7glQgipUfZlOMQV
	MCDfPjYaiq+cgZFT57SDAaZT/lBTXPGI7EKo6dXELXvrNWVJ2dG0tA6Ee6dmS2F5
	jIXn5s5IHwBR4TeXIJzhadNY7NT0WxnyadLUQBqsq/3+NDBgpG2C0bN7hSFM/Z6z
	rV3ezuU4giMR42JcEjg0Il1IKuj8hoPyg+u29Q7yocbQwnqlh+3UiCsj0dx5LBSz
	QM+zQea9BVEJ73CUr7O58EzbD3/ANxJlnWy3GgICieCzCM7pHTRTtPOyh5mNYE7K
	XwIq1AuLQeGhgReTyNaMjD50UWRZbynWsgw==
X-ME-Sender: <xms:qZKqaFO8LKndKcBt9qf0PdMrtINu1XvXj0ml0uvY_sNzCj24uNPbWg>
    <xme:qZKqaKsNDfjRR4fY04YKifdN_rWVDOH7gAPkhHTwktSjNmbNIHVSYjMBAeaPILCKZ
    ozSlKTrN1UVg0mEOY0>
X-ME-Received: <xmr:qZKqaBIP187swfwj4IYLZy3rAaXDGciBVI1ygr3JYv3JR_IdxiDOzSWqo5-7Tx8EqWz8qrZaB_79DXL0N_iJsul39IwBKu7KFts>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieekheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeefieehjedvtefgiedtudethfekieelhfevhefgvddtkeekvdekhefftdekvedv
    ueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdr
    ohhrghdpnhgspghrtghpthhtohepvdehpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehlrghntggvrdihrghngheslhhinhhugidruggvvhdprhgtphhtthhopegrkhhpmhes
    lhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepmhhhihhrrghmrg
    htsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhpsehinhhtvghlrdgtohhmpdhr
    tghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepsh
    gvnhhoiihhrghtshhkhiestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepohgvqdhk
    sghuihhlugdqrghllheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegrmh
    grihhnuggvgiesohhuthhlohhokhdrtghomhdprhgtphhtthhopegrnhhnrgdrshgthhhu
    mhgrkhgvrhesohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:qpKqaJNHssbWWP-dsqJQ7cORuhnGhSZaPzIdfHh55mlFOqAVvRb5_w>
    <xmx:qpKqaFCBKZWUtYia3Y_0RJiGsUnva6fhq40CMDmOQQQuh79jF5JEPg>
    <xmx:qpKqaBVMBmesj0NSmobphqvPNHu3iMyVxRrXPTH0VlkOFDdWNvuQtw>
    <xmx:qpKqaBfCRwDNEnyxB1UBl781vtiYemd9BK0pUMXTw26WtHdx-AUJfw>
    <xmx:rJKqaIQuTqVUEE9FDyS9-ybqM9ozOiCX-pS7Za_ZAyY-bdOQWmSysZPH>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 00:18:46 -0400 (EDT)
Date: Sun, 24 Aug 2025 14:18:39 +1000 (AEST)
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
In-Reply-To: <9efaadc9-7f96-435e-9711-7f2ce96a820a@linux.dev>
Message-ID: <a70ad7be-390f-2a2c-c920-5064cabe2b36@linux-m68k.org>
References: <20250823074048.92498-1-lance.yang@linux.dev> <202508240539.ARmC1Umu-lkp@intel.com> <29f4f58e-2f14-99c8-3899-3b0be79382c2@linux-m68k.org> <9efaadc9-7f96-435e-9711-7f2ce96a820a@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Sun, 24 Aug 2025, Lance Yang wrote:

> On 2025/8/24 08:47, Finn Thain wrote:
> > 
> > On Sun, 24 Aug 2025, kernel test robot wrote:
> > 
> >> All warnings (new ones prefixed by >>):
> >>
> >>     In file included from sound/soc/codecs/mt6660.c:15:
> >>>> sound/soc/codecs/mt6660.h:28:1: warning: alignment 1 of 'struct
> >>>> mt6660_chip' is less than 8 [-Wpacked-not-aligned]
> >>        28 | };
> >>           | ^
> >>>> sound/soc/codecs/mt6660.h:25:22: warning: 'io_lock' offset 49 in 'struct
> >>>> mt6660_chip' isn't aligned to 8 [-Wpacked-not-aligned]
> >>        25 |         struct mutex io_lock;
> >>           |                      ^~~~~~~
> >>
> > 
> > Misalignment warnings like this one won't work if you just pick an
> > alignment arbitrarily i.e. to suit whatever bitfield you happen to need.
> 
> Yes.
> 
> The build warnings reported by the test robot are exactly the kind of
> unintended side effect I was concerned about. It confirms that forcing
> alignment on a core structure like struct mutex breaks other parts of
> the kernel that rely on packed structures ;)
> 

Sure, your patch broke the build. So why not write a better patch? You 
don't need to align the struct, you need to align the lock, like I said 
already.

> > 
> > Instead, I think I would naturally align the actual locks, that is, 
> > arch_spinlock_t and arch_rwlock_t in include/linux/spinlock_types*.h.
> 
> That's an interesting point. The blocker tracking mechanism currently 
> operates on higher-level structures like struct mutex. Moving the type 
> encoding down to the lowest-level locks would be a more complex and 
> invasive change, likely beyond the scope of fixing this particular 
> issue.
> 

I don't see why changing kernel struct layouts on m68k is particularly 
invasive. Perhaps I'm missing something (?)

> Looking further ahead, a better long-term solution might be to stop 
> repurposing pointer bits altogether. We could add an explicit 
> blocker_type field to task_struct to be used alongside the blocker 
> field. That would be a much cleaner design. TODO +1 for that idea :)
> 
> So, let's drop the patch[1] that enforces alignment and go back to my 
> initial proposal[2], which adjusts the runtime checks to gracefully 
> handle unaligned pointers. That one is self-contained, has minimal 
> impact, and is clearly the safer solution for now.
> 
> [1] https://lore.kernel.org/lkml/20250823074048.92498-1-lance.yang@linux.dev
> [2] https://lore.kernel.org/lkml/20250823050036.7748-1-lance.yang@linux.dev
> 

I am willing to send a patch if it serves correctness and portability. So 
you may wish to refrain from crippling your blocker tracking algorithm for 
now.

