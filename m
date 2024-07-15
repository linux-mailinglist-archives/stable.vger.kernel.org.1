Return-Path: <stable+bounces-59335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8580A93131D
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 13:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E5D1C21761
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 11:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD44D139D10;
	Mon, 15 Jul 2024 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oa9vBzt8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED181E89C
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043112; cv=none; b=E+J02USQYtIMKdOrWB1ZIE52A7Xvx8TIsH7jslFG/wZNrED4Pej58wDiKyozByGaSzA+42wexdnawt3wtSR/+yDy+9RTS69uscRPgXC/lzQys0pQahemxzG1fHR5UlO4Umn+H5TqoF4xf+gCHndMK0Xt5hSAbU5fbx6/9y3zGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043112; c=relaxed/simple;
	bh=5ctmU/OOM8RB2aA7mYEEdtbfy7vMMuoxssSZEDVZ048=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oK6zYkb1HWG1VRAYBhAj+JK3lvW5Za28A66W/3UcNF4wnwdPWA1ziZ6V9j8PvDhxeGASVCqSL2hIogIq0aIurycb/uNquUD+r+80fAuHB5Qw5YNEzlkecFy/GRs85ZkPAVxGgCuKfg4LccZKGs+avoiISSJQRNj9vZDDJIG0yV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oa9vBzt8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF92BC32782;
	Mon, 15 Jul 2024 11:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721043112;
	bh=5ctmU/OOM8RB2aA7mYEEdtbfy7vMMuoxssSZEDVZ048=;
	h=Subject:To:Cc:From:Date:From;
	b=Oa9vBzt8MgtXo8jbnzRHrfnyT03VAUAJscwctq/Ndem0t2wAxHL0cD/JqKo9+bxrS
	 oMacCHsOjQAX5y6UR+qD/igJUO+GzTjoQIQeaEummnyQ67I3Qv9ZB4RV1metdvBx9+
	 raw3cmG85+QWBHf9iFo5RrdwK/yJ7AaqWdljeq7U=
Subject: FAILED: patch "[PATCH] mm/shmem: disable PMD-sized page cache if needed" failed to apply to 6.1-stable tree
To: gshan@redhat.com,akpm@linux-foundation.org,david@redhat.com,ddutile@redhat.com,djwong@kernel.org,hughd@google.com,ryan.roberts@arm.com,stable@vger.kernel.org,torvalds@linux-foundation.org,william.kucharski@oracle.com,willy@infradead.org,zhenyzha@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 13:31:49 +0200
Message-ID: <2024071549-stapling-unhitched-789b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9fd154ba926b34c833b7bfc4c14ee2e931b3d743
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071549-stapling-unhitched-789b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

9fd154ba926b ("mm/shmem: disable PMD-sized page cache if needed")
2cf1338454a8 ("mm: fix khugepaged with shmem_enabled=advise")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9fd154ba926b34c833b7bfc4c14ee2e931b3d743 Mon Sep 17 00:00:00 2001
From: Gavin Shan <gshan@redhat.com>
Date: Thu, 27 Jun 2024 10:39:52 +1000
Subject: [PATCH] mm/shmem: disable PMD-sized page cache if needed

For shmem files, it's possible that PMD-sized page cache can't be
supported by xarray.  For example, 512MB page cache on ARM64 when the base
page size is 64KB can't be supported by xarray.  It leads to errors as the
following messages indicate when this sort of xarray entry is split.

WARNING: CPU: 34 PID: 7578 at lib/xarray.c:1025 xas_split_alloc+0xf8/0x128
Modules linked in: binfmt_misc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6   \
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject        \
nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4  \
ip_set rfkill nf_tables nfnetlink vfat fat virtio_balloon drm fuse xfs  \
libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce virtio_net \
net_failover virtio_console virtio_blk failover dimlib virtio_mmio
CPU: 34 PID: 7578 Comm: test Kdump: loaded Tainted: G W 6.10.0-rc5-gavin+ #9
Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20240524-1.el9 05/24/2024
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : xas_split_alloc+0xf8/0x128
lr : split_huge_page_to_list_to_order+0x1c4/0x720
sp : ffff8000882af5f0
x29: ffff8000882af5f0 x28: ffff8000882af650 x27: ffff8000882af768
x26: 0000000000000cc0 x25: 000000000000000d x24: ffff00010625b858
x23: ffff8000882af650 x22: ffffffdfc0900000 x21: 0000000000000000
x20: 0000000000000000 x19: ffffffdfc0900000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000018000000000 x15: 52f8004000000000
x14: 0000e00000000000 x13: 0000000000002000 x12: 0000000000000020
x11: 52f8000000000000 x10: 52f8e1c0ffff6000 x9 : ffffbeb9619a681c
x8 : 0000000000000003 x7 : 0000000000000000 x6 : ffff00010b02ddb0
x5 : ffffbeb96395e378 x4 : 0000000000000000 x3 : 0000000000000cc0
x2 : 000000000000000d x1 : 000000000000000c x0 : 0000000000000000
Call trace:
 xas_split_alloc+0xf8/0x128
 split_huge_page_to_list_to_order+0x1c4/0x720
 truncate_inode_partial_folio+0xdc/0x160
 shmem_undo_range+0x2bc/0x6a8
 shmem_fallocate+0x134/0x430
 vfs_fallocate+0x124/0x2e8
 ksys_fallocate+0x4c/0xa0
 __arm64_sys_fallocate+0x24/0x38
 invoke_syscall.constprop.0+0x7c/0xd8
 do_el0_svc+0xb4/0xd0
 el0_svc+0x44/0x1d8
 el0t_64_sync_handler+0x134/0x150
 el0t_64_sync+0x17c/0x180

Fix it by disabling PMD-sized page cache when HPAGE_PMD_ORDER is larger
than MAX_PAGECACHE_ORDER.  As Matthew Wilcox pointed, the page cache in a
shmem file isn't represented by a multi-index entry and doesn't have this
limitation when the xarry entry is split until commit 6b24ca4a1a8d ("mm:
Use multi-index entries in the page cache").

Link: https://lkml.kernel.org/r/20240627003953.1262512-5-gshan@redhat.com
Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
Signed-off-by: Gavin Shan <gshan@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Don Dutile <ddutile@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: Zhenyu Zhang <zhenyzha@redhat.com>
Cc: <stable@vger.kernel.org>	[5.17+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/shmem.c b/mm/shmem.c
index a8b181a63402..c1befe046c7e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -541,8 +541,9 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 
 static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
 
-bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
-		   struct mm_struct *mm, unsigned long vm_flags)
+static bool __shmem_is_huge(struct inode *inode, pgoff_t index,
+			    bool shmem_huge_force, struct mm_struct *mm,
+			    unsigned long vm_flags)
 {
 	loff_t i_size;
 
@@ -573,6 +574,16 @@ bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
 	}
 }
 
+bool shmem_is_huge(struct inode *inode, pgoff_t index,
+		   bool shmem_huge_force, struct mm_struct *mm,
+		   unsigned long vm_flags)
+{
+	if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
+		return false;
+
+	return __shmem_is_huge(inode, index, shmem_huge_force, mm, vm_flags);
+}
+
 #if defined(CONFIG_SYSFS)
 static int shmem_parse_huge(const char *str)
 {


