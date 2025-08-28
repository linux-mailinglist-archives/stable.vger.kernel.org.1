Return-Path: <stable+bounces-176582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 490F4B398DE
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 11:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60EE41C23B73
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 09:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD7E2FE065;
	Thu, 28 Aug 2025 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N6Zg8vMn"
X-Original-To: stable@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F352FD1D6;
	Thu, 28 Aug 2025 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374841; cv=none; b=LEU0DMalFbXdbU8PLP4SJoPUilyvzBBUifyODbnSNOY7kZIjKgeng+0XVKueZiTOoPDvbeTO6Ldc6WhDoOCOUYQTcCarR4q1/3Y+zj4LGteU6ggMNHYclXrBd8Pz9sA6LN9WzMLx0BJARzoCw4Zrg3EEadw9ZydoRN8ELxn6v3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374841; c=relaxed/simple;
	bh=5Rv5C8k1jzRHy4/cxgOl7lPgfeqFs3kOHjyVxKxdfmU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PCEcLbX+cTt7cEv/KCWpISiVwlIiYkMJrcJQaLKQCD0xbGKoCLjXTWLM/IqGxEG2GIId+70jw1EMIKWpFMnAwcrtyGEsLyqX1w1r3hxvfY1s/Omjq3/j9OIJBd9z2bPOywnGrJQunfT/vsS45BhCRrjsDnmDR9H4W1bORhQ481M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N6Zg8vMn; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D2B251D000A8;
	Thu, 28 Aug 2025 05:53:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 28 Aug 2025 05:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756374837; x=1756461237; bh=3YH2nSJxyfGdYHWOcLtHzcrvKz8K1+OQsxu
	/mr71K2k=; b=N6Zg8vMn6+DVRmfTGgN5E+uzke1Jmyhl3ybLDf0pBS48IhWbALV
	4kA+ohseswrxG8jYrzH7oGxSbZatxbzyq5U+ELaPJSH6I+hb5JDGSmZq1XmHjPfN
	QFGihd2xLObmwujm4wRLXCUgq43JqcJ5dKoxR8owNQvcOJL/Tnq93bZulmzxGgHe
	HB9DtSpCcfsiRg9NrQSIVbGa7+24Z3S4HAiZP+BlUTME/XqsJ5LNXTbI1o+AnPu5
	6KIbj6Aew9tkETApfCaQLlsddYZAh+yFLvgXe6NoIxz6vbOCaG52O1Es3gCIZngf
	jyRfLkoFU/HNBGETmQ2lAtdCDOWrTcwI+3A==
X-ME-Sender: <xms:NCewaL2uW3z2Ps7_peLqfWSIFyfLG7kcPXM88oCX6wmP9nQgtpUFwg>
    <xme:NCewaEtkw88geyhiOh3ur7bnVEGF42XI-kP5Z3BzUYGl8vrxE9flUOksPSEQw9njn
    SjvDiARWp9HHtpR0Rw>
X-ME-Received: <xmr:NCewaB7MEpMHSXrT_NMBYygp-VCN9fpstwR9gF26zAmCJvunhJb3Vh7PDPPwh1RBuyYbtKOtwFjaDl2ffcHVoe01bLzx4eQ3s1U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedtjedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:NCewaAfZEntjjSY8iiv0Mi_8SATXZ0tqDdASBnIoF-lOLUOB1UYjmw>
    <xmx:NCewaOyYQvI5UdHjNQnZ6cl6J1FsJvOPOuiQuGtd_DZWL-nhA7i_Tg>
    <xmx:NCewaF9d9RBV-co-h5bs8ALUidlh9uHW5XWOoCoS0RA6i__gtRzMrg>
    <xmx:NCewaMwcZVDy5oI_SBDI71fAuT3QpuR1ORFVK84sC7Njxg_JnoGHJA>
    <xmx:NSewaGdFrcidvN-OLX2Q8t_EUMODwC8mQt4wM7331z7pPzeC09ekS13s>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 05:53:53 -0400 (EDT)
Date: Thu, 28 Aug 2025 19:53:52 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Peter Zijlstra <peterz@infradead.org>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Lance Yang <lance.yang@linux.dev>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, Eero Tamminen <oak@helsinkinet.fi>, 
    Will Deacon <will@kernel.org>, stable@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
In-Reply-To: <20250827115447.GR3289052@noisy.programming.kicks-ass.net>
Message-ID: <10b5aaae-5947-53a9-88bb-802daafd83d4@linux-m68k.org>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org> <20250825071247.GO3245006@noisy.programming.kicks-ass.net> <58dac4d0-2811-182a-e2c1-4edfe4759759@linux-m68k.org> <20250825114136.GX3245006@noisy.programming.kicks-ass.net>
 <9453560f-2240-ab6f-84f1-0bb99d118998@linux-m68k.org> <20250827115447.GR3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Wed, 27 Aug 2025, Peter Zijlstra wrote:

> On Wed, Aug 27, 2025 at 05:17:19PM +1000, Finn Thain wrote:
> > 
> > On Mon, 25 Aug 2025, Peter Zijlstra wrote:
> > 
> > > On Mon, Aug 25, 2025 at 06:03:23PM +1000, Finn Thain wrote:
> > > > 
> > > > On Mon, 25 Aug 2025, Peter Zijlstra wrote:
> > > > 
> > > > > 
> > > > > And your architecture doesn't trap on unaligned atomic access ?!!?!
> > > > > 
> > > > 
> > > > Right. This port doesn't do SMP.
> > > 
> > > There is RMW_INSN which seems to imply a compare-and-swap instruction of 
> > > sorts. That is happy to work on unaligned storage?
> > > 
> > 
> > Yes, the TAS and CAS instructions are happy to work on unaligned storage. 
> > 
> > However, these operations involve an indivisible bus cycle that hogs the 
> > bus to the detriment of other processors, DMA controllers etc. So I 
> > suspect lock alignment would tend to shorten read-modify-write cycles, and 
> > improve efficiency, when CONFIG_RMW_INSN is enabled.
> > 
> > Most m68k platforms will have CONFIG_RMW_INSN disabled, or else simply 
> > don't implement TAS and CAS. In this case, lock alignment might still 
> > help, just because L1 cache entries are long words. I've not tried to 
> > measure this.
> 
> Fair enough; this sounds a little like the x86 LOCK prefix, it will work
> on unaligned memory, but at tremendous cost (recent chips have an
> optional exception on unaligned).
> 
> Anyway, I'm not opposed to adding an explicit alignment to atomic_t.
> Isn't s32 or __s32 already having this?
> 

For Linux/m68k, __alignof__(__s32) == 2 and __alignof__(s32) == 2.

> But I think it might make sense to have a DEBUG alignment check right
> along with adding that alignment, just to make sure things are indeed /
> stay aligned.
> 

A run-time assertion seems surperfluous as long as other architectures 
already trap for misaligned locks. For m68k, perhaps we could have a 
compile-time check:

--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -371,6 +371,12 @@ void __init setup_arch(char **cmdline_p)
        }
 #endif
 #endif
+
+       /*
+        * 680x0 CPUs don't require aligned storage for atomic ops.
+        * However, alignment assumptions may appear in core kernel code.
+        */
+       BUILD_BUG_ON(__alignof__(atomic_t) < sizeof(atomic_t));
 }

But I'm not sure that arch/m68k is a good place for that kind of thing -- 
my inclination would be to place such compile-time assertions closer to 
the code that rests on that assertion, like in hung_task.c or mutex.c. 
E.g.

--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -54,8 +54,6 @@ __mutex_init(struct mutex *lock, const char *name, 
struct lock_class_key *key)
 #endif
 
        debug_mutex_init(lock, name, key);
+
+       BUILD_BUG_ON(__alignof__(lock->owner) < sizeof(lock->owner));
 }
 EXPORT_SYMBOL(__mutex_init);


Is that the kind of check you had in mind? I'm open to suggestions.

