Return-Path: <stable+bounces-202897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFEDCC979A
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 21:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DC2D3029D30
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 20:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9321B2D4B66;
	Wed, 17 Dec 2025 20:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RsnXHAHw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3942749CB
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766003031; cv=none; b=nUr7zBUW/BS10ZJGLzqkgmMhbg0Caov9Vl94SPrPb+H0moOpuH77S/mrPYvWSeTauzDENq3qzp05OWeIEd0TxFI/dFwU5VZFOaYPrEAeWV65FSzl2NjqYLdDpVSCa36tq44732eS2SHVhMrvMvhvITbzC4GRa2NO8/AUbRs+R+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766003031; c=relaxed/simple;
	bh=1v2ii48ES/WKvW2UtzdM5TsGxD0Y2FGi3H3LMmjMMIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=O2bVkazJi6fBEXACAsw+caO3XbNRWp/9xwHZbg5k0ZUNJCgLCn153gMmYcFANq9V3wsc4HV6uECb6HWg3hjDPdgn8LMT+OvrU9XF6upBR/l+bcgYixIqCin3gKAr0NLO1wdsA0He3Izfi1nRd+1+iRnwzC7OYqC3t8NbqN2yscI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RsnXHAHw; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-430fcfe4494so2568048f8f.2
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 12:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766003028; x=1766607828; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDhEke3Pf/QosbPquaV4OeIZU/HBm2+1j+nd/s0NsM0=;
        b=RsnXHAHwZ6lGonQZVlrmLyNKyUnJwtqxDgnFZS/xqgtQXiqlQT9G8P5Penla9G7AIe
         zeplTMfqsVHWV75b3HbMHrhW81KlLI3Hm2lh2py75mo5NjOhdz4Uod4O/9mxZlM7sULW
         1XCQ1gvRG8mWtdFDER7f0NpQ8T3DV+VzW5X43jH66PguCFtuklpbABB1AFa9JkJdwkE6
         87TqhsHHE2dFwv1mS21SM+9xyt30w72redhN6x1tJVWIURLsQC5GJCKOD0fppBYgZy0Z
         zSSkx4IEXL81xSbU73aJjIhqgJHLUoFy/BXn9oZH8tnfSGxRp9i5iIaAyreWK1ktR5ke
         6apQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766003028; x=1766607828;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDhEke3Pf/QosbPquaV4OeIZU/HBm2+1j+nd/s0NsM0=;
        b=Zix3VHAqSNJL/heJg7ar2YMhF4M6CGiOqdcXUtR54ntMIdTEV9w4V6SmE0bfjn9jWM
         v6uusEA097HiDQ61UautVDPBYDXLlhfBjPiv00g3Rm1o9yizlbPPHXs9Lzj0X1TVXosE
         qj3K9gTtjN+Q414xieStVsNF4BApM/MJaUbekTs/RSkbdyPRpJbr8RD6AXE6KfDHqOvs
         vW4hhAyItT6cWAbpVKCSJAWo4RnrskZbq6nwQWNCFgJfOkmuD9mALBM/XWNWdE/u4rGV
         ZfCzQey9ktWK8jAo96+6taBuvuMvaU1pAJVI6Vh7Jz39OZXBLCqGQ7hEQM1N/rRrYWDw
         z9OA==
X-Forwarded-Encrypted: i=1; AJvYcCUFCU4qVtQMKqD5PpRZfjBL4OpcM2xRzBYQtm7AKP/Vpwu0eB+KYhe+tepslmwlh4L0meh2Csc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6LnzfyAcQCffFZtm+7sj1pns96pgv/S2tTRmYM8A1WClQFqOH
	bivepK1SUhqdoedT/lzRHXCNOKiT+J/dc4rv51TK+/gHTEhLLjB6EHnzooi2HDlXJ/DTG6TR6Ig
	SMQS6EeQUj2KGVcfdnw==
X-Google-Smtp-Source: AGHT+IGe1YKA5nJYn157r/8t+8P2Lqp3XAQpgh8jYBuoKq5Q9ybBqIVF49axwtfUPOWQ8rlRijN6+2u3mSKJ2LU=
X-Received: from wrbgv21.prod.google.com ([2002:a05:6000:4615:b0:430:f87c:654f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:438a:b0:430:fa52:9eaf with SMTP id ffacd0b85a97d-430fa52a19emr14329354f8f.60.1766003028201;
 Wed, 17 Dec 2025 12:23:48 -0800 (PST)
Date: Wed, 17 Dec 2025 20:23:47 +0000
In-Reply-To: <rfpdf2suobpchpuw5gqzgivwvon2kd2cub5eltvbburnsus2iy@j26cinzdxxnl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251217-maple-drop-rcu-v1-1-702af063573f@google.com> <rfpdf2suobpchpuw5gqzgivwvon2kd2cub5eltvbburnsus2iy@j26cinzdxxnl>
Message-ID: <aUMRU0yKwQVDuUnZ@google.com>
Subject: Re: [PATCH] rust: maple_tree: rcu_read_lock() in destructor to
 silence lockdep
From: Alice Ryhl <aliceryhl@google.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Dec 17, 2025 at 02:49:18PM -0500, Liam R. Howlett wrote:
> * Alice Ryhl <aliceryhl@google.com> [251217 08:10]:
> > When running the Rust maple tree kunit tests with lockdep, you may
> > trigger a warning that looks like this:
> > 
> > 	lib/maple_tree.c:780 suspicious rcu_dereference_check() usage!
> > 
> > 	other info that might help us debug this:
> > 
> > 	rcu_scheduler_active = 2, debug_locks = 1
> > 	no locks held by kunit_try_catch/344.
> > 
> > 	stack backtrace:
> > 	CPU: 3 UID: 0 PID: 344 Comm: kunit_try_catch Tainted: G                 N  6.19.0-rc1+ #2 NONE
> > 	Tainted: [N]=TEST
> > 	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> > 	Call Trace:
> > 	 <TASK>
> > 	 dump_stack_lvl+0x71/0x90
> > 	 lockdep_rcu_suspicious+0x150/0x190
> > 	 mas_start+0x104/0x150
> > 	 mas_find+0x179/0x240
> > 	 _RINvNtCs5QSdWC790r4_4core3ptr13drop_in_placeINtNtCs1cdwasc6FUb_6kernel10maple_tree9MapleTreeINtNtNtBL_5alloc4kbox3BoxlNtNtB1x_9allocator7KmallocEEECsgxAQYCfdR72_25doctests_kernel_generated+0xaf/0x130
> > 	 rust_doctest_kernel_maple_tree_rs_0+0x600/0x6b0
> > 	 ? lock_release+0xeb/0x2a0
> > 	 ? kunit_try_catch_run+0x210/0x210
> > 	 kunit_try_run_case+0x74/0x160
> > 	 ? kunit_try_catch_run+0x210/0x210
> > 	 kunit_generic_run_threadfn_adapter+0x12/0x30
> > 	 kthread+0x21c/0x230
> > 	 ? __do_trace_sched_kthread_stop_ret+0x40/0x40
> > 	 ret_from_fork+0x16c/0x270
> > 	 ? __do_trace_sched_kthread_stop_ret+0x40/0x40
> > 	 ret_from_fork_asm+0x11/0x20
> > 	 </TASK>
> > 
> > This is because the destructor of maple tree calls mas_find() without
> 
> The wording of "destructor of maple tree" makes it sound like the tree
> itself is being destroyed, but this is to do with the stored entries
> being destroyed, correct?

Yes, it's the destructor of the Rust MapleTree<T>, which performs a
mas_find() loop to drop each Rust value before it calls mtree_destroy().

> > taking rcu_read_lock() or the spinlock. Doing that is actually ok in
> > this case since the destructor has exclusive access to the entire maple
> > tree, but it triggers a lockdep warning. To fix that, take the rcu read
> > lock.
> > 
> > In the future, it's possible that memory reclaim could gain a feature
> > where it reallocates entries in maple trees even if no user-code is
> > touching it. If that feature is added, then this use of rcu read lock
> > would become load-bearing, so I did not make it conditional on lockdep.
> > 
> > We have to repeatedly take and release rcu because the destructor of T
> > might perform operations that sleep.
> 
> The c side avoids handling the life cycle of the entries because we
> really don't know what is required.  Maybe it would be better to let the
> person storing the data handle the freeing of the entries (and thus the
> locking)?

The general expectation is that dropping a container also drops anything
contained within it. It would be very surprising for a data structure to
violate that in Rust.

The end-user is always welcome to use a type with no destructor if they
don't want the mas_find() loop.

Alice

