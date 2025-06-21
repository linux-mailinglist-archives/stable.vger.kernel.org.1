Return-Path: <stable+bounces-155194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A01AE25C7
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 00:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE143BD4D0
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 22:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC3D239E91;
	Fri, 20 Jun 2025 22:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KcPhrfnN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE1B19E98C;
	Fri, 20 Jun 2025 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750459245; cv=none; b=TkhOysdMzhOslJRl/OBV6uhQoghMzIjmRwGbMEWLBnBqoEzlXY2dBoJsag1dGuTV/gdbH4TAQOgG2yah95MafMzYjBbru4/6n70ZZnqKZh70eIbAcJWWWK4NgLN3y1NHHS9iqgNmMdld1q8d0xzdQnia5mHkhF175JA2fXJed34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750459245; c=relaxed/simple;
	bh=5yZ8b9gZBFicZWykTcDIabZwcu8qrQAjln5V3jKG+Iw=;
	h=Date:To:From:Subject:Message-Id; b=BysGdPC1aOLYpvYlm3voof61rnt4wXvNcVEFd1TLoixDqtoEmnCemd3G2pUwjbfWK8xM9aAz0ly1BUfu3LCnTx6kPxfLFCf6HrcnBAppdwX7LWpyyd3xjUEE73rVnpQQK5ieHXdr4izJPXgpNgX6wV6IPuAuK7W6c6dtl/27ny8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KcPhrfnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879BEC4CEE3;
	Fri, 20 Jun 2025 22:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1750459244;
	bh=5yZ8b9gZBFicZWykTcDIabZwcu8qrQAjln5V3jKG+Iw=;
	h=Date:To:From:Subject:From;
	b=KcPhrfnNdZ3A9hLG3FzSCEFHhEs1UmVt7UJ8Hmi4DpSk2Is7ZU2d2P+PD3FMU9HZB
	 0qPUBy5RgHr1BJW5/o42vOdmWQ2ZaFkCXLkpew8O84NWJ9TTTk+6wNtNRU4rRZGmBl
	 NsTIsi20b+89m/Zv8H3b9wAfa61INBGjBep5a1z8=
Date: Fri, 20 Jun 2025 15:40:43 -0700
To: mm-commits@vger.kernel.org,surenb@google.com,stable@vger.kernel.org,oliver.sang@intel.com,kent.overstreet@linux.dev,cachen@purestorage.com,00107082@163.com,harry.yoo@oracle.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + lib-alloc_tag-do-not-acquire-non-existent-lock-in-alloc_tag_top_users.patch added to mm-hotfixes-unstable branch
Message-Id: <20250620224044.879BEC4CEE3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: lib/alloc_tag: do not acquire non-existent lock in alloc_tag_top_users()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     lib-alloc_tag-do-not-acquire-non-existent-lock-in-alloc_tag_top_users.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/lib-alloc_tag-do-not-acquire-non-existent-lock-in-alloc_tag_top_users.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Harry Yoo <harry.yoo@oracle.com>
Subject: lib/alloc_tag: do not acquire non-existent lock in alloc_tag_top_users()
Date: Sat, 21 Jun 2025 04:53:05 +0900

alloc_tag_top_users() attempts to lock alloc_tag_cttype->mod_lock even
when the alloc_tag_cttype is not allocated because:

  1) alloc tagging is disabled because mem profiling is disabled
     (!alloc_tag_cttype)
  2) alloc tagging is enabled, but not yet initialized (!alloc_tag_cttype)
  3) alloc tagging is enabled, but failed initialization
     (!alloc_tag_cttype or IS_ERR(alloc_tag_cttype))

In all cases, alloc_tag_cttype is not allocated, and therefore
alloc_tag_top_users() should not attempt to acquire the semaphore.

This leads to a crash on memory allocation failure by attempting to
acquire a non-existent semaphore:

  Oops: general protection fault, probably for non-canonical address 0xdffffc000000001b: 0000 [#3] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
  CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G      D             6.16.0-rc2 #1 VOLUNTARY
  Tainted: [D]=DIE
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
  RIP: 0010:down_read_trylock+0xaa/0x3b0
  Code: d0 7c 08 84 d2 0f 85 a0 02 00 00 8b 0d df 31 dd 04 85 c9 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 6b 68 48 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 88 02 00 00 48 3b 5b 68 0f 85 53 01 00 00 65 ff
  RSP: 0000:ffff8881002ce9b8 EFLAGS: 00010016
  RAX: dffffc0000000000 RBX: 0000000000000070 RCX: 0000000000000000
  RDX: 000000000000001b RSI: 000000000000000a RDI: 0000000000000070
  RBP: 00000000000000d8 R08: 0000000000000001 R09: ffffed107dde49d1
  R10: ffff8883eef24e8b R11: ffff8881002cec20 R12: 1ffff11020059d37
  R13: 00000000003fff7b R14: ffff8881002cec20 R15: dffffc0000000000
  FS:  00007f963f21d940(0000) GS:ffff888458ca6000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f963f5edf71 CR3: 000000010672c000 CR4: 0000000000350ef0
  Call Trace:
   <TASK>
   codetag_trylock_module_list+0xd/0x20
   alloc_tag_top_users+0x369/0x4b0
   __show_mem+0x1cd/0x6e0
   warn_alloc+0x2b1/0x390
   __alloc_frozen_pages_noprof+0x12b9/0x21a0
   alloc_pages_mpol+0x135/0x3e0
   alloc_slab_page+0x82/0xe0
   new_slab+0x212/0x240
   ___slab_alloc+0x82a/0xe00
   </TASK>

As David Wang points out, this issue became easier to trigger after commit
780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init").

Before the commit, the issue occurred only when it failed to allocate and
initialize alloc_tag_cttype or if a memory allocation fails before
alloc_tag_init() is called.  After the commit, it can be easily triggered
when memory profiling is compiled but disabled at boot.

To properly determine whether alloc_tag_init() has been called and its
data structures initialized, verify that alloc_tag_cttype is a valid
pointer before acquiring the semaphore.  If the variable is NULL or an
error value, it has not been properly initialized.  In such a case, just
skip and do not attempt acquire the semaphore.

Link: https://lkml.kernel.org/r/20250620195305.1115151-1-harry.yoo@oracle.com
Fixes: 780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init")
Fixes: 1438d349d16b ("lib: add memory allocations report in show_mem()")
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202506181351.bba867dd-lkp@intel.com
Cc: Casey Chen <cachen@purestorage.com>
Cc: David Wang <00107082@163.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/alloc_tag.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/lib/alloc_tag.c~lib-alloc_tag-do-not-acquire-non-existent-lock-in-alloc_tag_top_users
+++ a/lib/alloc_tag.c
@@ -135,7 +135,9 @@ size_t alloc_tag_top_users(struct codeta
 	struct codetag_bytes n;
 	unsigned int i, nr = 0;
 
-	if (can_sleep)
+	if (IS_ERR_OR_NULL(alloc_tag_cttype))
+		return 0;
+	else if (can_sleep)
 		codetag_lock_module_list(alloc_tag_cttype, true);
 	else if (!codetag_trylock_module_list(alloc_tag_cttype))
 		return 0;
_

Patches currently in -mm which might be from harry.yoo@oracle.com are

lib-alloc_tag-do-not-acquire-non-existent-lock-in-alloc_tag_top_users.patch
lib-alloc_tag-do-not-acquire-nonexistent-lock-when-mem-profiling-is-disabled.patch


