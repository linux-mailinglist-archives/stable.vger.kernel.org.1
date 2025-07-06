Return-Path: <stable+bounces-159744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3818EAF7A27
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA304A39EC
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D907F2ED168;
	Thu,  3 Jul 2025 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DYcAxIDC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956562BDC1B;
	Thu,  3 Jul 2025 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555204; cv=none; b=su9bIrHCLirCLEo7Ucb5JjmCWoyjZc4hN4RmvDmIeSEXaFyJK9TztrD1lXqW1ih7axSdf6XslFM2+Di6w+qHqycv4mBMDfE/H34tbRnvzgYGVBGzTEwJM1hrzRsz2jsh6QnehLGoalM6qowRmynlMJWDJgGcLZMnP3DH3pWoB7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555204; c=relaxed/simple;
	bh=/hPmf6e50/JKejAwm7xPqHEtdcGZwjsnR8qvQvX6xIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGFz3BGMeF6xIofv1XIoo2a9IWQ4BwDzFA5OpN/H8kxLx4y771GtXl1DazvYejX0s09onnycKa01kLkc3SpM6TEk/3TWlp9uDUk6vNakkNAwO8XrQxi9tHyKvdwddrV3eI2KOE4cHml2/rnsfw9udZNgFOxXD38643KwaPivzbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DYcAxIDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8051C4CEE3;
	Thu,  3 Jul 2025 15:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555204;
	bh=/hPmf6e50/JKejAwm7xPqHEtdcGZwjsnR8qvQvX6xIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DYcAxIDCXJtZDVSc8zpO9pckNAOH8Im5/dSbXDKN/9PeWtXXoZBdmCQcSSQKk3aVq
	 syrMhpjkJOmDCDbPdlLcK4RiAVUEoI1UdY8aHjYRKg8UNFyrOKZgMfJIdoyVGLO+Sv
	 7tcPqYoUF/j+osbUT+ahddJEN4tD+oBjTSO5Rf4c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baoquan He <bhe@redhat.com>,
	Chris Li <chrisl@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.15 190/263] mm/shmem, swap: fix softlockup with mTHP swapin
Date: Thu,  3 Jul 2025 16:41:50 +0200
Message-ID: <20250703144011.974309161@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kairui Song <kasong@tencent.com>

commit a05dd8ae5cbb1cb45f349922cfea4f548a5e5d6f upstream.

Following softlockup can be easily reproduced on my test machine with:

echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled
swapon /dev/zram0 # zram0 is a 48G swap device
mkdir -p /sys/fs/cgroup/memory/test
echo 1G > /sys/fs/cgroup/test/memory.max
echo $BASHPID > /sys/fs/cgroup/test/cgroup.procs
while true; do
    dd if=/dev/zero of=/tmp/test.img bs=1M count=5120
    cat /tmp/test.img > /dev/null
    rm /tmp/test.img
done

Then after a while:
watchdog: BUG: soft lockup - CPU#0 stuck for 763s! [cat:5787]
Modules linked in: zram virtiofs
CPU: 0 UID: 0 PID: 5787 Comm: cat Kdump: loaded Tainted: G             L      6.15.0.orig-gf3021d9246bc-dirty #118 PREEMPT(voluntary)·
Tainted: [L]=SOFTLOCKUP
Hardware name: Red Hat KVM/RHEL-AV, BIOS 0.0.0 02/06/2015
RIP: 0010:mpol_shared_policy_lookup+0xd/0x70
Code: e9 b8 b4 ff ff 31 c0 c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 41 54 55 53 <48> 8b 1f 48 85 db 74 41 4c 8d 67 08 48 89 fb 48 89 f5 4c 89 e7 e8
RSP: 0018:ffffc90002b1fc28 EFLAGS: 00000202
RAX: 00000000001c20ca RBX: 0000000000724e1e RCX: 0000000000000001
RDX: ffff888118e214c8 RSI: 0000000000057d42 RDI: ffff888118e21518
RBP: 000000000002bec8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000bf4 R11: 0000000000000000 R12: 0000000000000001
R13: 00000000001c20ca R14: 00000000001c20ca R15: 0000000000000000
FS:  00007f03f995c740(0000) GS:ffff88a07ad9a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f03f98f1000 CR3: 0000000144626004 CR4: 0000000000770eb0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 shmem_alloc_folio+0x31/0xc0
 shmem_swapin_folio+0x309/0xcf0
 ? filemap_get_entry+0x117/0x1e0
 ? xas_load+0xd/0xb0
 ? filemap_get_entry+0x101/0x1e0
 shmem_get_folio_gfp+0x2ed/0x5b0
 shmem_file_read_iter+0x7f/0x2e0
 vfs_read+0x252/0x330
 ksys_read+0x68/0xf0
 do_syscall_64+0x4c/0x1c0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f03f9a46991
Code: 00 48 8b 15 81 14 10 00 f7 d8 64 89 02 b8 ff ff ff ff eb bd e8 20 ad 01 00 f3 0f 1e fa 80 3d 35 97 10 00 00 74 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48 83 ec
RSP: 002b:00007fff3c52bd28 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000040000 RCX: 00007f03f9a46991
RDX: 0000000000040000 RSI: 00007f03f98ba000 RDI: 0000000000000003
RBP: 00007fff3c52bd50 R08: 0000000000000000 R09: 00007f03f9b9a380
R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000040000
R13: 00007f03f98ba000 R14: 0000000000000003 R15: 0000000000000000
 </TASK>

The reason is simple, readahead brought some order 0 folio in swap cache,
and the swapin mTHP folio being allocated is in conflict with it, so
swapcache_prepare fails and causes shmem_swap_alloc_folio to return
-EEXIST, and shmem simply retries again and again causing this loop.

Fix it by applying a similar fix for anon mTHP swapin.

The performance change is very slight, time of swapin 10g zero folios
with shmem (test for 12 times):
Before:  2.47s
After:   2.48s

[kasong@tencent.com: add comment]
  Link: https://lkml.kernel.org/r/20250610181645.45922-1-ryncsn@gmail.com
Link: https://lkml.kernel.org/r/20250610181645.45922-1-ryncsn@gmail.com
Link: https://lkml.kernel.org/r/20250609171751.36305-1-ryncsn@gmail.com
Fixes: 1dd44c0af4fa ("mm: shmem: skip swapcache for swapin of synchronous swap device")
Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory.c |   20 --------------------
 mm/shmem.c  |    6 +++++-
 mm/swap.h   |   23 +++++++++++++++++++++++
 3 files changed, 28 insertions(+), 21 deletions(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4224,26 +4224,6 @@ static struct folio *__alloc_swap_folio(
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
-{
-	struct swap_info_struct *si = swp_swap_info(entry);
-	pgoff_t offset = swp_offset(entry);
-	int i;
-
-	/*
-	 * While allocating a large folio and doing swap_read_folio, which is
-	 * the case the being faulted pte doesn't have swapcache. We need to
-	 * ensure all PTEs have no cache as well, otherwise, we might go to
-	 * swap devices while the content is in swapcache.
-	 */
-	for (i = 0; i < max_nr; i++) {
-		if ((si->swap_map[offset + i] & SWAP_HAS_CACHE))
-			return i;
-	}
-
-	return i;
-}
-
 /*
  * Check if the PTEs within a range are contiguous swap entries
  * and have consistent swapcache, zeromap.
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2262,6 +2262,7 @@ static int shmem_swapin_folio(struct ino
 	folio = swap_cache_get_folio(swap, NULL, 0);
 	order = xa_get_order(&mapping->i_pages, index);
 	if (!folio) {
+		int nr_pages = 1 << order;
 		bool fallback_order0 = false;
 
 		/* Or update major stats only when swapin succeeds?? */
@@ -2275,9 +2276,12 @@ static int shmem_swapin_folio(struct ino
 		 * If uffd is active for the vma, we need per-page fault
 		 * fidelity to maintain the uffd semantics, then fallback
 		 * to swapin order-0 folio, as well as for zswap case.
+		 * Any existing sub folio in the swap cache also blocks
+		 * mTHP swapin.
 		 */
 		if (order > 0 && ((vma && unlikely(userfaultfd_armed(vma))) ||
-				  !zswap_never_enabled()))
+				  !zswap_never_enabled() ||
+				  non_swapcache_batch(swap, nr_pages) != nr_pages))
 			fallback_order0 = true;
 
 		/* Skip swapcache for synchronous device. */
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -106,6 +106,25 @@ static inline int swap_zeromap_batch(swp
 		return find_next_bit(sis->zeromap, end, start) - start;
 }
 
+static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
+{
+	struct swap_info_struct *si = swp_swap_info(entry);
+	pgoff_t offset = swp_offset(entry);
+	int i;
+
+	/*
+	 * While allocating a large folio and doing mTHP swapin, we need to
+	 * ensure all entries are not cached, otherwise, the mTHP folio will
+	 * be in conflict with the folio in swap cache.
+	 */
+	for (i = 0; i < max_nr; i++) {
+		if ((si->swap_map[offset + i] & SWAP_HAS_CACHE))
+			return i;
+	}
+
+	return i;
+}
+
 #else /* CONFIG_SWAP */
 struct swap_iocb;
 static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
@@ -199,6 +218,10 @@ static inline int swap_zeromap_batch(swp
 	return 0;
 }
 
+static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
+{
+	return 0;
+}
 #endif /* CONFIG_SWAP */
 
 #endif /* _MM_SWAP_H */



