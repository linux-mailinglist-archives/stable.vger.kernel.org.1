Return-Path: <stable+bounces-174246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C1AB36232
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5188A31FF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A694F2676E9;
	Tue, 26 Aug 2025 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kZiLEvDQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6411A1FBCB5;
	Tue, 26 Aug 2025 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213880; cv=none; b=mpqmcIVtz1B6i6wYQErbZctySHMTkXcnpzY+CFXo/wl3AaFL9sd8nUck7JpvwD3YfYCoR+pZBL7XXj3JjDZvtT9gqDSKoily/rCnNWCb9PWT2QVsZdv4AKyhqaZYPFZ9GF1MWTJzWN9vzXdV8/h97N+kHd+7+zS3D0rnDFp17go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213880; c=relaxed/simple;
	bh=LHUXvntYVU3BSKefY7ZlJ7fXKNzUwpsoVKpogGKbISw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oksCjd4a0Ainwm1d9p5BZMIaUFVRjrkZsni7tLXxv/R3Qfzuh4fudHEX3Fs1aCNVhJseSCXbY3fyRHIsUeXIUANsgq0N/1nGuyz0hPRnLUbJW2WRSiMU4iBlVecViIK8qXt7ZKKExpqb+4/pr1qwegvCRYVUStO+FDjguOkTLWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kZiLEvDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B00C4CEF1;
	Tue, 26 Aug 2025 13:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213880;
	bh=LHUXvntYVU3BSKefY7ZlJ7fXKNzUwpsoVKpogGKbISw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kZiLEvDQ7nw7d+bdDogN6pMXjFb/SLM3mGh8JA77XMAo4D2Y6520sPItU1D6/j1Pt
	 7v40S7xUM569uCbSgh8/hlg0rr61UFQ0PoiIOuOiDJJm3mD2IJuaWqB4nxFcjkFBfm
	 5MuQWWQWNe1YWvsM7AkeoAc1ti8kP+cmJmkJxAJ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Herton R. Krzesinski" <herton@redhat.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Gavin Shan <gshan@redhat.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 483/587] mm/debug_vm_pgtable: clear page table entries at destroy_args()
Date: Tue, 26 Aug 2025 13:10:32 +0200
Message-ID: <20250826111005.261201145@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herton R. Krzesinski <herton@redhat.com>

commit dde30854bddfb5d69f30022b53c5955a41088b33 upstream.

The mm/debug_vm_pagetable test allocates manually page table entries for
the tests it runs, using also its manually allocated mm_struct.  That in
itself is ok, but when it exits, at destroy_args() it fails to clear those
entries with the *_clear functions.

The problem is that leaves stale entries.  If another process allocates an
mm_struct with a pgd at the same address, it may end up running into the
stale entry.  This is happening in practice on a debug kernel with
CONFIG_DEBUG_VM_PGTABLE=y, for example this is the output with some extra
debugging I added (it prints a warning trace if pgtables_bytes goes
negative, in addition to the warning at check_mm() function):

[    2.539353] debug_vm_pgtable: [get_random_vaddr         ]: random_vaddr is 0x7ea247140000
[    2.539366] kmem_cache info
[    2.539374] kmem_cachep 0x000000002ce82385 - freelist 0x0000000000000000 - offset 0x508
[    2.539447] debug_vm_pgtable: [init_args                ]: args->mm is 0x000000002267cc9e
(...)
[    2.552800] WARNING: CPU: 5 PID: 116 at include/linux/mm.h:2841 free_pud_range+0x8bc/0x8d0
[    2.552816] Modules linked in:
[    2.552843] CPU: 5 UID: 0 PID: 116 Comm: modprobe Not tainted 6.12.0-105.debug_vm2.el10.ppc64le+debug #1 VOLUNTARY
[    2.552859] Hardware name: IBM,9009-41A POWER9 (architected) 0x4e0202 0xf000005 of:IBM,FW910.00 (VL910_062) hv:phyp pSeries
[    2.552872] NIP:  c0000000007eef3c LR: c0000000007eef30 CTR: c0000000003d8c90
[    2.552885] REGS: c0000000622e73b0 TRAP: 0700   Not tainted  (6.12.0-105.debug_vm2.el10.ppc64le+debug)
[    2.552899] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24002822  XER: 0000000a
[    2.552954] CFAR: c0000000008f03f0 IRQMASK: 0
[    2.552954] GPR00: c0000000007eef30 c0000000622e7650 c000000002b1ac00 0000000000000001
[    2.552954] GPR04: 0000000000000008 0000000000000000 c0000000007eef30 ffffffffffffffff
[    2.552954] GPR08: 00000000ffff00f5 0000000000000001 0000000000000048 0000000000004000
[    2.552954] GPR12: 00000003fa440000 c000000017ffa300 c0000000051d9f80 ffffffffffffffdb
[    2.552954] GPR16: 0000000000000000 0000000000000008 000000000000000a 60000000000000e0
[    2.552954] GPR20: 4080000000000000 c0000000113af038 00007fffcf130000 0000700000000000
[    2.552954] GPR24: c000000062a6a000 0000000000000001 8000000062a68000 0000000000000001
[    2.552954] GPR28: 000000000000000a c000000062ebc600 0000000000002000 c000000062ebc760
[    2.553170] NIP [c0000000007eef3c] free_pud_range+0x8bc/0x8d0
[    2.553185] LR [c0000000007eef30] free_pud_range+0x8b0/0x8d0
[    2.553199] Call Trace:
[    2.553207] [c0000000622e7650] [c0000000007eef30] free_pud_range+0x8b0/0x8d0 (unreliable)
[    2.553229] [c0000000622e7750] [c0000000007f40b4] free_pgd_range+0x284/0x3b0
[    2.553248] [c0000000622e7800] [c0000000007f4630] free_pgtables+0x450/0x570
[    2.553274] [c0000000622e78e0] [c0000000008161c0] exit_mmap+0x250/0x650
[    2.553292] [c0000000622e7a30] [c0000000001b95b8] __mmput+0x98/0x290
[    2.558344] [c0000000622e7a80] [c0000000001d1018] exit_mm+0x118/0x1b0
[    2.558361] [c0000000622e7ac0] [c0000000001d141c] do_exit+0x2ec/0x870
[    2.558376] [c0000000622e7b60] [c0000000001d1ca8] do_group_exit+0x88/0x150
[    2.558391] [c0000000622e7bb0] [c0000000001d1db8] sys_exit_group+0x48/0x50
[    2.558407] [c0000000622e7be0] [c00000000003d810] system_call_exception+0x1e0/0x4c0
[    2.558423] [c0000000622e7e50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
(...)
[    2.558892] ---[ end trace 0000000000000000 ]---
[    2.559022] BUG: Bad rss-counter state mm:000000002267cc9e type:MM_ANONPAGES val:1
[    2.559037] BUG: non-zero pgtables_bytes on freeing mm: -6144

Here the modprobe process ended up with an allocated mm_struct from the
mm_struct slab that was used before by the debug_vm_pgtable test.  That is
not a problem, since the mm_struct is initialized again etc., however, if
it ends up using the same pgd table, it bumps into the old stale entry
when clearing/freeing the page table entries, so it tries to free an entry
already gone (that one which was allocated by the debug_vm_pgtable test),
which also explains the negative pgtables_bytes since it's accounting for
not allocated entries in the current process.

As far as I looked pgd_{alloc,free} etc.  does not clear entries, and
clearing of the entries is explicitly done in the free_pgtables->
free_pgd_range->free_p4d_range->free_pud_range->free_pmd_range->
free_pte_range path.  However, the debug_vm_pgtable test does not call
free_pgtables, since it allocates mm_struct and entries manually for its
test and eg.  not goes through page faults.  So it also should clear
manually the entries before exit at destroy_args().

This problem was noticed on a reboot X number of times test being done on
a powerpc host, with a debug kernel with CONFIG_DEBUG_VM_PGTABLE enabled.
Depends on the system, but on a 100 times reboot loop the problem could
manifest once or twice, if a process ends up getting the right mm->pgd
entry with the stale entries used by mm/debug_vm_pagetable.  After using
this patch, I couldn't reproduce/experience the problems anymore.  I was
able to reproduce the problem as well on latest upstream kernel (6.16).

I also modified destroy_args() to use mmput() instead of mmdrop(), there
is no reason to hold mm_users reference and not release the mm_struct
entirely, and in the output above with my debugging prints I already had
patched it to use mmput, it did not fix the problem, but helped in the
debugging as well.

Link: https://lkml.kernel.org/r/20250731214051.4115182-1-herton@redhat.com
Fixes: 3c9b84f044a9 ("mm/debug_vm_pgtable: introduce struct pgtable_debug_args")
Signed-off-by: Herton R. Krzesinski <herton@redhat.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Gavin Shan <gshan@redhat.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/debug_vm_pgtable.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1047,29 +1047,34 @@ static void __init destroy_args(struct p
 
 	/* Free page table entries */
 	if (args->start_ptep) {
+		pmd_clear(args->pmdp);
 		pte_free(args->mm, args->start_ptep);
 		mm_dec_nr_ptes(args->mm);
 	}
 
 	if (args->start_pmdp) {
+		pud_clear(args->pudp);
 		pmd_free(args->mm, args->start_pmdp);
 		mm_dec_nr_pmds(args->mm);
 	}
 
 	if (args->start_pudp) {
+		p4d_clear(args->p4dp);
 		pud_free(args->mm, args->start_pudp);
 		mm_dec_nr_puds(args->mm);
 	}
 
-	if (args->start_p4dp)
+	if (args->start_p4dp) {
+		pgd_clear(args->pgdp);
 		p4d_free(args->mm, args->start_p4dp);
+	}
 
 	/* Free vma and mm struct */
 	if (args->vma)
 		vm_area_free(args->vma);
 
 	if (args->mm)
-		mmdrop(args->mm);
+		mmput(args->mm);
 }
 
 static struct page * __init



