Return-Path: <stable+bounces-211156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNKlJJo3cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-211156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:31:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4AB5D44A
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A7D3A1013C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23EE32E6BA;
	Wed, 21 Jan 2026 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Cv7abE+0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27664319852;
	Wed, 21 Jan 2026 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024706; cv=none; b=Ht2LAReElszTSf2YOMYJngSrIE3SmRHOtHT+NvFQkAZ6HSUQLzdu8k7LQ4mVDOapQcmULqCMR9FmQ7loX9h9waXe06y92X7uQqdwRDA7l7TCBx66Yup+SbEyXsaOmD+cl4UquCnms/kKdpslfG0pna14zHgRpepmqr3T+PWrkCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024706; c=relaxed/simple;
	bh=J3Q3hUaP6eRIs6EPdWpRz02ClajqzwenrVDWIA29nYw=;
	h=Date:To:From:Subject:Message-Id; b=iyq0JNiGaxa7SMkzV7+5EXm6Pjgus47UfsYkEPiGiDdVumlHJNnL8osETbfie0JqVDRv0veuy80EZGXnWgMMJHbus/hLABOSR7WfzXjW0gDlJ7hVEi/qTchmvYVF/+7nbQH4tfcQqA345klZmPvXsf1hz5xHd3SkOY9aqtO8tE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Cv7abE+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1178EC4CEF1;
	Wed, 21 Jan 2026 19:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769024705;
	bh=J3Q3hUaP6eRIs6EPdWpRz02ClajqzwenrVDWIA29nYw=;
	h=Date:To:From:Subject:From;
	b=Cv7abE+0vyX4RuD2AgoRjWXYBKbGF4L2j1m+reTq/eXNaXyZYkNYSqHuPGH2Z0BsE
	 8ORD2THX5/nalEJ20ctC81i/c3swreEbPXuCw99pwn/bQRAD4l8GOxBAjadlIyxS71
	 6KCttju1zzBj7R9A3WVDJL9u36wXdnXXvHKMoBHU=
Date: Wed, 21 Jan 2026 11:45:04 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,rppt@kernel.org,rostedt@goodmis.org,richard.weiyang@gmail.com,paulmck@kernel.org,david@kernel.org,bigeasy@linutronix.de,longman@redhat.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-mm_init-dont-call-cond_resched-in-deferred_init_memmap_chunk-if-rcu_preempt_depth-set.patch added to mm-hotfixes-unstable branch
Message-Id: <20260121194505.1178EC4CEF1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,goodmis.org,gmail.com,linutronix.de,redhat.com,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-211156-lists,stable=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,goodmis.org:email,linux-foundation.org:email,linux-foundation.org:dkim,linutronix.de:email]
X-Rspamd-Queue-Id: 2E4AB5D44A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch titled
     Subject: mm/mm_init: don't call cond_resched() in deferred_init_memmap_chunk() if rcu_preempt_depth() set
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-mm_init-dont-call-cond_resched-in-deferred_init_memmap_chunk-if-rcu_preempt_depth-set.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-mm_init-dont-call-cond_resched-in-deferred_init_memmap_chunk-if-rcu_preempt_depth-set.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

------------------------------------------------------
From: Waiman Long <longman@redhat.com>
Subject: mm/mm_init: don't call cond_resched() in deferred_init_memmap_chunk() if rcu_preempt_depth() set
Date: Wed, 21 Jan 2026 14:10:36 -0500

Commit 3acb913c9d5b ("mm/mm_init: use deferred_init_memmap_chunk() in
deferred_grow_zone()") made deferred_grow_zone() call
deferred_init_memmap_chunk() within a pgdat_resize_lock() critical section
with irqs disabled.  It did check for irqs_disabled() in
deferred_init_memmap_chunk() to avoid calling cond_resched().  For a
PREEMPT_RT kernel build, however, spin_lock_irqsave() does not disable
interrupt but rcu_read_lock() is called.  This leads to the following bug
report.

  BUG: sleeping function called from invalid context at mm/mm_init.c:2091
  in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
  preempt_count: 0, expected: 0
  RCU nest depth: 1, expected: 0
  3 locks held by swapper/0/1:
   #0: ffff80008471b7a0 (sched_domains_mutex){+.+.}-{4:4}, at: sched_domains_mutex_lock+0x28/0x40
   #1: ffff003bdfffef48 (&pgdat->node_size_lock){+.+.}-{3:3}, at: deferred_grow_zone+0x140/0x278
   #2: ffff800084acf600 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1b4/0x408
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           6.19.0-rc6-test #1 PREEMPT_{RT,(full)
}
  Tainted: [W]=WARN
  Call trace:
   show_stack+0x20/0x38 (C)
   dump_stack_lvl+0xdc/0xf8
   dump_stack+0x1c/0x28
   __might_resched+0x384/0x530
   deferred_init_memmap_chunk+0x560/0x688
   deferred_grow_zone+0x190/0x278
   _deferred_grow_zone+0x18/0x30
   get_page_from_freelist+0x780/0xf78
   __alloc_frozen_pages_noprof+0x1dc/0x348
   alloc_slab_page+0x30/0x110
   allocate_slab+0x98/0x2a0
   new_slab+0x4c/0x80
   ___slab_alloc+0x5a4/0x770
   __slab_alloc.constprop.0+0x88/0x1e0
   __kmalloc_node_noprof+0x2c0/0x598
   __sdt_alloc+0x3b8/0x728
   build_sched_domains+0xe0/0x1260
   sched_init_domains+0x14c/0x1c8
   sched_init_smp+0x9c/0x1d0
   kernel_init_freeable+0x218/0x358
   kernel_init+0x28/0x208
   ret_from_fork+0x10/0x20

Fix it by checking rcu_preempt_depth() as well to prevent calling
cond_resched(). Note that CONFIG_PREEMPT_RCU should always be enabled
in a PREEMPT_RT kernel.

Link: https://lkml.kernel.org/r/20260121191036.461389-1-longman@redhat.com
Fixes: 3acb913c9d5b ("mm/mm_init: use deferred_init_memmap_chunk() in deferred_grow_zone()")
Signed-off-by: Waiman Long <longman@redhat.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/mm_init.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/mm/mm_init.c~mm-mm_init-dont-call-cond_resched-in-deferred_init_memmap_chunk-if-rcu_preempt_depth-set
+++ a/mm/mm_init.c
@@ -2085,7 +2085,12 @@ deferred_init_memmap_chunk(unsigned long
 
 			spfn = chunk_end;
 
-			if (irqs_disabled())
+			/*
+			 * pgdat_resize_lock() only disables irqs in non-RT
+			 * kernels but calls rcu_read_lock() in a PREEMPT_RT
+			 * kernel.
+			 */
+			if (irqs_disabled() || rcu_preempt_depth())
 				touch_nmi_watchdog();
 			else
 				cond_resched();
_

Patches currently in -mm which might be from longman@redhat.com are

mm-mm_init-dont-call-cond_resched-in-deferred_init_memmap_chunk-if-rcu_preempt_depth-set.patch


