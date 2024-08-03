Return-Path: <stable+bounces-65310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DA094678F
	for <lists+stable@lfdr.de>; Sat,  3 Aug 2024 07:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3172281BB4
	for <lists+stable@lfdr.de>; Sat,  3 Aug 2024 05:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1551482F2;
	Sat,  3 Aug 2024 05:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wU8CM6FE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F0B146D69;
	Sat,  3 Aug 2024 05:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722663837; cv=none; b=nB/ZCU2Cphy9CrsGurQ5PdIZ81eIAX0efsY6LjqrKrVDFlBNO09f8dg4Ba6LAL4Rs4bkloGZlDU4qQg29iKu6HFV78058j0CrV1gvl7xZecZ0+2+fqByJHjJ4nL9l41iDqYkt7cfqD0Qz4AEPrnCzi/ChWCV2cRnKUbjDEOvF3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722663837; c=relaxed/simple;
	bh=ZsHMdeaN8XKjW3fVPG9G6327Ij6CCHtoWgElx/+OTiU=;
	h=Date:To:From:Subject:Message-Id; b=u2dp164RgqUb2aC+she0KFDif2xvpsqPUIPLNfM556iCCUXNSm0cEOED59HmYUspI80zGid6zydvyMryIp+2s2tvCjuoeS28ajuFMnpVqjFyJ3y/bTyEuDz1nakxQb88LWw17XlO4aAvAPWt1dgUVONpXpDHtJuaYczVF8QRecM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wU8CM6FE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B62C116B1;
	Sat,  3 Aug 2024 05:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722663836;
	bh=ZsHMdeaN8XKjW3fVPG9G6327Ij6CCHtoWgElx/+OTiU=;
	h=Date:To:From:Subject:From;
	b=wU8CM6FEriUkTW61avJg75Qp6zXAHIK1Kj17/FVQKRlArp60t2+VP4a6AYnc8OVPm
	 M8YeGQRuy921KTsufM1adVMgzTyMsfiolUcHy+pw0EfM4ATuzyCN1R/GZsUbBbpzwd
	 AiBLTV82pye+2TDRC1yVMuUSLmn4KCQBQxHjrhjI=
Date: Fri, 02 Aug 2024 22:43:55 -0700
To: mm-commits@vger.kernel.org,vgoyal@redhat.com,stable@vger.kernel.org,paul.walmsley@sifive.com,palmer@dabbelt.com,dyoung@redhat.com,chenjiahao16@huawei.com,bhe@redhat.com,aou@eecs.berkeley.edu,alex@ghiti.fr,ruanjinjie@huawei.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + crash-fix-riscv64-crash-memory-reserve-dead-loop.patch added to mm-hotfixes-unstable branch
Message-Id: <20240803054356.60B62C116B1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: crash: Fix riscv64 crash memory reserve dead loop
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     crash-fix-riscv64-crash-memory-reserve-dead-loop.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/crash-fix-riscv64-crash-memory-reserve-dead-loop.patch

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
From: Jinjie Ruan <ruanjinjie@huawei.com>
Subject: crash: Fix riscv64 crash memory reserve dead loop
Date: Fri, 2 Aug 2024 17:01:05 +0800

On RISCV64 Qemu machine with 512MB memory, cmdline "crashkernel=500M,high"
will cause system stall as below:

	 Zone ranges:
	   DMA32    [mem 0x0000000080000000-0x000000009fffffff]
	   Normal   empty
	 Movable zone start for each node
	 Early memory node ranges
	   node   0: [mem 0x0000000080000000-0x000000008005ffff]
	   node   0: [mem 0x0000000080060000-0x000000009fffffff]
	 Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
	(stall here)

commit 5d99cadf1568 ("crash: fix x86_32 crash memory reserve dead loop
bug") fix this on 32-bit architecture.  However, the problem is not
completely solved.  If `CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX` on
64-bit architecture, for example, when system memory is equal to
CRASH_ADDR_LOW_MAX on RISCV64, the following infinite loop will also
occur:

	-> reserve_crashkernel_generic() and high is true
	   -> alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] fail
	      -> alloc at [0, CRASH_ADDR_LOW_MAX] fail and repeatedly
	         (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).

Before refactor in commit 9c08a2a139fe ("x86: kdump: use generic interface
to simplify crashkernel reservation code"), x86 do not try to reserve
crash memory at low if it fails to alloc above high 4G.  However before
refator in commit fdc268232dbba ("arm64: kdump: use generic interface to
simplify crashkernel reservation"), arm64 try to reserve crash memory at
low if it fails above high 4G.  For 64-bit systems, this attempt is less
beneficial than the opposite, remove it to fix this bug and align with
native x86 implementation.

After this patch, it print:
	cannot allocate crashkernel (size:0x1f400000)

Link: https://lkml.kernel.org/r/20240802090105.3871929-1-ruanjinjie@huawei.com
Fixes: 39365395046f ("riscv: kdump: use generic interface to simplify crashkernel reservation")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Chen Jiahao <chenjiahao16@huawei.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/crash_reserve.c |    9 ---------
 1 file changed, 9 deletions(-)

--- a/kernel/crash_reserve.c~crash-fix-riscv64-crash-memory-reserve-dead-loop
+++ a/kernel/crash_reserve.c
@@ -416,15 +416,6 @@ retry:
 			goto retry;
 		}
 
-		/*
-		 * For crashkernel=size[KMG],high, if the first attempt was
-		 * for high memory, fall back to low memory.
-		 */
-		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
-			search_end = CRASH_ADDR_LOW_MAX;
-			search_base = 0;
-			goto retry;
-		}
 		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
 			crash_size);
 		return;
_

Patches currently in -mm which might be from ruanjinjie@huawei.com are

crash-fix-riscv64-crash-memory-reserve-dead-loop.patch
crash-fix-x86_32-crash-memory-reserve-dead-loop-bug.patch
crash-fix-x86_32-crash-memory-reserve-dead-loop.patch
arm-use-generic-interface-to-simplify-crashkernel-reservation.patch
crash-fix-crash-memory-reserve-exceed-system-memory-bug.patch


