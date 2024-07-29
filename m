Return-Path: <stable+bounces-62362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B425C93EE4B
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FEBD280C6D
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02277D3EC;
	Mon, 29 Jul 2024 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oFEdIABp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC893D0C5
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722237414; cv=none; b=sIP/4AAnDI0dY09Eo9zPxPy+ugXpb8SoSRgtz7ImGr/sT6cbafQldXP4xpzm4UnGjuTBmAOCf6mGXMReGIhoarVeJ2+I/IYl9Day8Q5vUZJl1X5eIc3Il4WNrILf14ANOCQdFYgK0iJuTG0Fifor/to4Ae01d+Fa0vbIX5UwCvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722237414; c=relaxed/simple;
	bh=rrU6KOHBpPbmEhOuSEW8CqZ3Ury6wj/qDH7vTIPOSYY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=r4PA8U4gfn2ADy6iOV5XMnhNvuPRvIsP/FKRwZtxseCwGKJ+yP6pkKAHRHLtawHm2S3e42ddFOEYvQtcGQUQlZvCOPTF0VBbBjTmtGGpCWy8IbvQDe2k8BCVv9/OsX0daZOcVCoprN1UNimR98s8DYYczZ3KjT4SpsSZoNZb4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oFEdIABp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600EBC4AF0A;
	Mon, 29 Jul 2024 07:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722237413;
	bh=rrU6KOHBpPbmEhOuSEW8CqZ3Ury6wj/qDH7vTIPOSYY=;
	h=Subject:To:Cc:From:Date:From;
	b=oFEdIABpRLbBocOoP1Va1FeU5fm2K7QfxrsCU/qoDHeWrTFyydjyh0FtSAJt4SRMH
	 xu+m/xxmeqpU+tMoLtJzmjVr8EMOOLpOtTlcchk3ys9ZbCAIEPWHNpu9Lxb69KECmI
	 UL+Z42G+fCXXaR0P2gWHeat0k/XkkFDahwFjS8Ug=
Subject: FAILED: patch "[PATCH] mm/huge_memory: avoid PMD-size page cache if needed" failed to apply to 6.6-stable tree
To: gshan@redhat.com,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,david@redhat.com,ddutile@redhat.com,peterx@redhat.com,ryan.roberts@arm.com,stable@vger.kernel.org,william.kucharski@oracle.com,willy@infradead.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:16:50 +0200
Message-ID: <2024072950-factsheet-cabbie-418a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d659b715e94ac039803d7601505d3473393fc0be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072950-factsheet-cabbie-418a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

d659b715e94a ("mm/huge_memory: avoid PMD-size page cache if needed")
e0ffb29bc54d ("mm: simplify thp_vma_allowable_order")
19eaf44954df ("mm: thp: support allocation of anonymous multi-size THP")
3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
7a81751fcdeb ("mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d659b715e94ac039803d7601505d3473393fc0be Mon Sep 17 00:00:00 2001
From: Gavin Shan <gshan@redhat.com>
Date: Mon, 15 Jul 2024 10:04:23 +1000
Subject: [PATCH] mm/huge_memory: avoid PMD-size page cache if needed

xarray can't support arbitrary page cache size.  the largest and supported
page cache size is defined as MAX_PAGECACHE_ORDER by commit 099d90642a71
("mm/filemap: make MAX_PAGECACHE_ORDER acceptable to xarray").  However,
it's possible to have 512MB page cache in the huge memory's collapsing
path on ARM64 system whose base page size is 64KB.  512MB page cache is
breaking the limitation and a warning is raised when the xarray entry is
split as shown in the following example.

[root@dhcp-10-26-1-207 ~]# cat /proc/1/smaps | grep KernelPageSize
KernelPageSize:       64 kB
[root@dhcp-10-26-1-207 ~]# cat /tmp/test.c
   :
int main(int argc, char **argv)
{
	const char *filename = TEST_XFS_FILENAME;
	int fd = 0;
	void *buf = (void *)-1, *p;
	int pgsize = getpagesize();
	int ret = 0;

	if (pgsize != 0x10000) {
		fprintf(stdout, "System with 64KB base page size is required!\n");
		return -EPERM;
	}

	system("echo 0 > /sys/devices/virtual/bdi/253:0/read_ahead_kb");
	system("echo 1 > /proc/sys/vm/drop_caches");

	/* Open the xfs file */
	fd = open(filename, O_RDONLY);
	assert(fd > 0);

	/* Create VMA */
	buf = mmap(NULL, TEST_MEM_SIZE, PROT_READ, MAP_SHARED, fd, 0);
	assert(buf != (void *)-1);
	fprintf(stdout, "mapped buffer at 0x%p\n", buf);

	/* Populate VMA */
	ret = madvise(buf, TEST_MEM_SIZE, MADV_NOHUGEPAGE);
	assert(ret == 0);
	ret = madvise(buf, TEST_MEM_SIZE, MADV_POPULATE_READ);
	assert(ret == 0);

	/* Collapse VMA */
	ret = madvise(buf, TEST_MEM_SIZE, MADV_HUGEPAGE);
	assert(ret == 0);
	ret = madvise(buf, TEST_MEM_SIZE, MADV_COLLAPSE);
	if (ret) {
		fprintf(stdout, "Error %d to madvise(MADV_COLLAPSE)\n", errno);
		goto out;
	}

	/* Split xarray entry. Write permission is needed */
	munmap(buf, TEST_MEM_SIZE);
	buf = (void *)-1;
	close(fd);
	fd = open(filename, O_RDWR);
	assert(fd > 0);
	fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
 		  TEST_MEM_SIZE - pgsize, pgsize);
out:
	if (buf != (void *)-1)
		munmap(buf, TEST_MEM_SIZE);
	if (fd > 0)
		close(fd);

	return ret;
}

[root@dhcp-10-26-1-207 ~]# gcc /tmp/test.c -o /tmp/test
[root@dhcp-10-26-1-207 ~]# /tmp/test
 ------------[ cut here ]------------
 WARNING: CPU: 25 PID: 7560 at lib/xarray.c:1025 xas_split_alloc+0xf8/0x128
 Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib    \
 nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct      \
 nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4      \
 ip_set rfkill nf_tables nfnetlink vfat fat virtio_balloon drm fuse   \
 xfs libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64 virtio_net  \
 sha1_ce net_failover virtio_blk virtio_console failover dimlib virtio_mmio
 CPU: 25 PID: 7560 Comm: test Kdump: loaded Not tainted 6.10.0-rc7-gavin+ #9
 Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20240524-1.el9 05/24/2024
 pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
 pc : xas_split_alloc+0xf8/0x128
 lr : split_huge_page_to_list_to_order+0x1c4/0x780
 sp : ffff8000ac32f660
 x29: ffff8000ac32f660 x28: ffff0000e0969eb0 x27: ffff8000ac32f6c0
 x26: 0000000000000c40 x25: ffff0000e0969eb0 x24: 000000000000000d
 x23: ffff8000ac32f6c0 x22: ffffffdfc0700000 x21: 0000000000000000
 x20: 0000000000000000 x19: ffffffdfc0700000 x18: 0000000000000000
 x17: 0000000000000000 x16: ffffd5f3708ffc70 x15: 0000000000000000
 x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
 x11: ffffffffffffffc0 x10: 0000000000000040 x9 : ffffd5f3708e692c
 x8 : 0000000000000003 x7 : 0000000000000000 x6 : ffff0000e0969eb8
 x5 : ffffd5f37289e378 x4 : 0000000000000000 x3 : 0000000000000c40
 x2 : 000000000000000d x1 : 000000000000000c x0 : 0000000000000000
 Call trace:
  xas_split_alloc+0xf8/0x128
  split_huge_page_to_list_to_order+0x1c4/0x780
  truncate_inode_partial_folio+0xdc/0x160
  truncate_inode_pages_range+0x1b4/0x4a8
  truncate_pagecache_range+0x84/0xa0
  xfs_flush_unmap_range+0x70/0x90 [xfs]
  xfs_file_fallocate+0xfc/0x4d8 [xfs]
  vfs_fallocate+0x124/0x2f0
  ksys_fallocate+0x4c/0xa0
  __arm64_sys_fallocate+0x24/0x38
  invoke_syscall.constprop.0+0x7c/0xd8
  do_el0_svc+0xb4/0xd0
  el0_svc+0x44/0x1d8
  el0t_64_sync_handler+0x134/0x150
  el0t_64_sync+0x17c/0x180

Fix it by correcting the supported page cache orders, different sets for
DAX and other files.  With it corrected, 512MB page cache becomes
disallowed on all non-DAX files on ARM64 system where the base page size
is 64KB.  After this patch is applied, the test program fails with error
-EINVAL returned from __thp_vma_allowable_orders() and the madvise()
system call to collapse the page caches.

Link: https://lkml.kernel.org/r/20240715000423.316491-1-gshan@redhat.com
Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
Signed-off-by: Gavin Shan <gshan@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Don Dutile <ddutile@redhat.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: <stable@vger.kernel.org>	[5.17+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index cff002be83eb..e25d9ebfdf89 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -74,14 +74,20 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
 #define THP_ORDERS_ALL_ANON	((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) | BIT(1)))
 
 /*
- * Mask of all large folio orders supported for file THP.
+ * Mask of all large folio orders supported for file THP. Folios in a DAX
+ * file is never split and the MAX_PAGECACHE_ORDER limit does not apply to
+ * it.
  */
-#define THP_ORDERS_ALL_FILE	(BIT(PMD_ORDER) | BIT(PUD_ORDER))
+#define THP_ORDERS_ALL_FILE_DAX		\
+	(BIT(PMD_ORDER) | BIT(PUD_ORDER))
+#define THP_ORDERS_ALL_FILE_DEFAULT	\
+	((BIT(MAX_PAGECACHE_ORDER + 1) - 1) & ~BIT(0))
 
 /*
  * Mask of all large folio orders supported for THP.
  */
-#define THP_ORDERS_ALL		(THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE)
+#define THP_ORDERS_ALL	\
+	(THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE_DAX | THP_ORDERS_ALL_FILE_DEFAULT)
 
 #define TVA_SMAPS		(1 << 0)	/* Will be used for procfs */
 #define TVA_IN_PF		(1 << 1)	/* Page fault handler */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 04b72912035d..f4be468e06a4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -89,9 +89,17 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	bool smaps = tva_flags & TVA_SMAPS;
 	bool in_pf = tva_flags & TVA_IN_PF;
 	bool enforce_sysfs = tva_flags & TVA_ENFORCE_SYSFS;
+	unsigned long supported_orders;
+
 	/* Check the intersection of requested and supported orders. */
-	orders &= vma_is_anonymous(vma) ?
-			THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;
+	if (vma_is_anonymous(vma))
+		supported_orders = THP_ORDERS_ALL_ANON;
+	else if (vma_is_dax(vma))
+		supported_orders = THP_ORDERS_ALL_FILE_DAX;
+	else
+		supported_orders = THP_ORDERS_ALL_FILE_DEFAULT;
+
+	orders &= supported_orders;
 	if (!orders)
 		return 0;
 


