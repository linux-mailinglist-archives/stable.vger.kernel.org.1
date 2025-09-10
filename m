Return-Path: <stable+bounces-179139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3421B50987
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 02:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260101C27CA5
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 00:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAF44A04;
	Wed, 10 Sep 2025 00:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OrDTEdu/"
X-Original-To: stable@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73573C17;
	Wed, 10 Sep 2025 00:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757462821; cv=none; b=bWm+IkXx4aCcdoys3Wmo4ykRofeuC3/L0xc0Jw9wTFPW3VbgT0Tca99Ci0ipj6IAvdhwxSp0uri60AU3wVMkVIJNp10tu4KR0+ru97efNGtXoFKlybezcM5Zv0XCUQjouSNA8tDDyTa8PgVN97HLedLpvE62aTIuqeU+U5gGGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757462821; c=relaxed/simple;
	bh=RsmIRUdpmeC+5siB3DndQQwalZ7bkzuKj60a51UgypQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KRM8xSzd98ncGy7swS11e3p+7eT3APao+sbGQ9oY4F5kFvxkNJPbup1F26v/ohI9C1IpehPmYHqzs7yRVc10regPKllHt9m0WRMjxZyinuMSaYrg4bg1ttlgIB7dWIf6GzUplUHcdHDbtsGFn9Z56OJeRWyE1wUrp8w8yDmiDq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OrDTEdu/; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 01478EC024F;
	Tue,  9 Sep 2025 20:06:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 09 Sep 2025 20:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757462817; x=1757549217; bh=iFrYSh+DPwmcqz8uizFLdHufnJyI67r++QL
	TBgAM1pY=; b=OrDTEdu/3+G1F7PYDx2AdwJuFOalhEkGDF+LGUkkf5MK/NR6JXv
	GfeRhyyHMiCyfIlAZtL5Xstscwj2DggWRxqDfEJbwiHsTKbRH0lUOGkXwEJPLp49
	1ZQoRl3+K2vYyT94i2QzoTzQ4UMNDYra3BondziT0gmE18m5E269h+yjUZjLhiu2
	pAk09XzDVmpE1uUtqRfsCScYPITIr1drJRSx9skqxHMhZs+YBhFOolBQWpsFC0Pq
	oPW+mTsNox4z0Mxm6Y5XGiwCY3rfbqEuNZSApBd/usULcLm07vvCC7lR3XlZC+wo
	hkmGAoxsrp/Pv2fsPYpjHC7PQrqMqeVAcDg==
X-ME-Sender: <xms:H8HAaMJpSe4R3eTQSVuFyYoJga6T2iV6aKkJt4eqOuU568W1Wq6Exw>
    <xme:H8HAaNesZsEuhkxHdxaOoxTLu0wtkGxjHvRJXZhEmfjIbXOnv2yPNndKRHCb_kP2w
    6zwDlj67tkuidcVN3Y>
X-ME-Received: <xmr:H8HAaPIIXy4Vlf8eq6_QK9SJ_lO32bf3kK_Go3AU5EtsM-2OPLBwcrcnmukEbRMXVg3Nnw-M39_avuRqkgIigVKwZOSeazMLbzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepiedugeehveevudffudduhedtveehhfejffefuedujeeuheffkeeigeduudfhfeev
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehl
    ihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepvdegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehkvghnthdrohhvvghrshhtrhgvvghtsehlihhnuhigrdgu
    vghvpdhrtghpthhtoheplhgrnhgtvgdrhigrnhhgsehlihhnuhigrdguvghvpdhrtghpth
    htoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthho
    pegrmhgrihhnuggvgiesohhuthhlohhokhdrtghomhdprhgtphhtthhopegrnhhnrgdrsh
    gthhhumhgrkhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgv
    nhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheike
    hkrdhorhhgpdhrtghpthhtohepihhofihorhhkvghrtdesghhmrghilhdrtghomhdprhgt
    phhtthhopehjohgvlhdrghhrrghnrgguohhssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:H8HAaPB6VYSAVwr_gpKUINuvTLw-rVHn00n5zZ-ZXBZoi95rTj6niQ>
    <xmx:H8HAaAgJ9Qsk-lWCVlnrI0PxRrNqkxu1atRFv8nAPPwQu9v0-gyg6A>
    <xmx:H8HAaBNbmk_oAnG3GjNDRDfQCTBcqRAyVxICL6KGPBoeZ6qoAd_VTw>
    <xmx:H8HAaPbqWAEgUx3W3uY_A3SkumywPPEQA9bW4JJf8POEShbQvLMGdg>
    <xmx:IcHAaJxUccZL0deGSWGBnMNamTTPoBjRZpNsFH21TLO2I92IOjnCRC_u>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 20:06:52 -0400 (EDT)
Date: Wed, 10 Sep 2025 10:07:04 +1000 (AEST)
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
In-Reply-To: <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
Message-ID: <99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org>
References: <20250909145243.17119-1-lance.yang@linux.dev> <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Tue, 9 Sep 2025, Kent Overstreet wrote:

> On Tue, Sep 09, 2025 at 10:52:43PM +0800, Lance Yang wrote:
> > From: Lance Yang <lance.yang@linux.dev>
> > 
> > The blocker tracking mechanism assumes that lock pointers are at least
> > 4-byte aligned to use their lower bits for type encoding.
> > 
> > However, as reported by Eero Tamminen, some architectures like m68k
> > only guarantee 2-byte alignment of 32-bit values. This breaks the
> > assumption and causes two related WARN_ON_ONCE checks to trigger.
> 
> Isn't m68k the only architecture that's weird like this?
> 

No. Historically, Linux/CRIS did not naturally align integer types either. 
AFAIK, there's no standard that demands natural alignment of integer 
types. Linux ABIs differ significantly.

For example, Linux/i386 does not naturally align long longs. Therefore, 
x86 may be expected to become the next m68k (or CRIS) unless such 
assumptions are avoided and alignment requirements are made explicit.

The real problem here is the algorithm. Some under-resourced distros 
choose to blame the ABI instead of the algorithm, because in doing so, 
they are freed from having to work to improve upstream code bases.

IMHO, good C doesn't make alignment assumptions, because that hinders 
source code portability and reuse, as well as algorithm extensibility. 
We've seen it before. The issue here [1] is no different from the pointer 
abuse which we fixed in Cpython [2].

Linux is probably the only non-trivial program that could be feasibly 
rebuilt with -malign-int without ill effect (i.e. without breaking 
userland) but that sort of workaround would not address the root cause 
(i.e. algorithms with bad assumptions).

[1]
https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com/

[2]
https://github.com/python/cpython/pull/135016

