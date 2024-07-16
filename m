Return-Path: <stable+bounces-59884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B255932C3E
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED376283F57
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5E619AD93;
	Tue, 16 Jul 2024 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O+tihxIC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4649F17A93F;
	Tue, 16 Jul 2024 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145203; cv=none; b=qvdIJ02LeS9lo3Ama2j5BQYNu61f5QHK8NUl9R6MrX+VYSHXgFcje5TMAYSM3d3sQVyhoc2FCFNI/SqiI/vsxNcsctzKPJyIZkuON5xQW+Ww8FjuRrK/FWb5YIS5yFJ3gNPtvmIPvKDxUV3VecNY6FvblOR/hV37P47kyfKGFpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145203; c=relaxed/simple;
	bh=Iyd9VvNoOwO6/dNefeT+baHFOi3Jc1RRbAOFeIHO7AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzwzDyvid3DVXrVBzoTkY+9IfWC2wKsI52UXm+ypvBCFQMMKMYwKcr+FDcjWd1KH1dWy75toRAJaPVFisikd7fd24JqQV5ZbaGxyb/i3EL55y4AU7S3WVj9P+t2Blqz5buyP0vmEwzAPp/dOi7R3/auE6yH253f+9arKR9YVRas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O+tihxIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E40C116B1;
	Tue, 16 Jul 2024 15:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721145203;
	bh=Iyd9VvNoOwO6/dNefeT+baHFOi3Jc1RRbAOFeIHO7AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O+tihxICuKLHG3xfcN73sdNN6+FxWpSmgCdl2jfqfxwLqzTpCjZtniprzpFyc9EY5
	 q4gvae8ZOQaBKKjslQjtNgic6uMQ8V92asGYru1rWHPvr1ibDgNdcpRbqMItQ/Wh5m
	 vfq4Gqb/4brzge58QYSbeFBDtFmv0EzWEo9cGrq4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gavin Shan <gshan@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Don Dutile <ddutile@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	William Kucharski <william.kucharski@oracle.com>,
	Zhenyu Zhang <zhenyzha@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.9 090/143] mm/filemap: skip to create PMD-sized page cache if needed
Date: Tue, 16 Jul 2024 17:31:26 +0200
Message-ID: <20240716152759.437051659@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152755.980289992@linuxfoundation.org>
References: <20240716152755.980289992@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gavin Shan <gshan@redhat.com>

commit 3390916aca7af1893ed2ebcdfee1d6fdb65bb058 upstream.

On ARM64, HPAGE_PMD_ORDER is 13 when the base page size is 64KB.  The
PMD-sized page cache can't be supported by xarray as the following error
messages indicate.

------------[ cut here ]------------
WARNING: CPU: 35 PID: 7484 at lib/xarray.c:1025 xas_split_alloc+0xf8/0x128
Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib  \
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct    \
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4    \
ip_set rfkill nf_tables nfnetlink vfat fat virtio_balloon drm      \
fuse xfs libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64      \
sha1_ce virtio_net net_failover virtio_console virtio_blk failover \
dimlib virtio_mmio
CPU: 35 PID: 7484 Comm: test Kdump: loaded Tainted: G W 6.10.0-rc5-gavin+ #9
Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20240524-1.el9 05/24/2024
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : xas_split_alloc+0xf8/0x128
lr : split_huge_page_to_list_to_order+0x1c4/0x720
sp : ffff800087a4f6c0
x29: ffff800087a4f6c0 x28: ffff800087a4f720 x27: 000000001fffffff
x26: 0000000000000c40 x25: 000000000000000d x24: ffff00010625b858
x23: ffff800087a4f720 x22: ffffffdfc0780000 x21: 0000000000000000
x20: 0000000000000000 x19: ffffffdfc0780000 x18: 000000001ff40000
x17: 00000000ffffffff x16: 0000018000000000 x15: 51ec004000000000
x14: 0000e00000000000 x13: 0000000000002000 x12: 0000000000000020
x11: 51ec000000000000 x10: 51ece1c0ffff8000 x9 : ffffbeb961a44d28
x8 : 0000000000000003 x7 : ffffffdfc0456420 x6 : ffff0000e1aa6eb8
x5 : 20bf08b4fe778fca x4 : ffffffdfc0456420 x3 : 0000000000000c40
x2 : 000000000000000d x1 : 000000000000000c x0 : 0000000000000000
Call trace:
 xas_split_alloc+0xf8/0x128
 split_huge_page_to_list_to_order+0x1c4/0x720
 truncate_inode_partial_folio+0xdc/0x160
 truncate_inode_pages_range+0x1b4/0x4a8
 truncate_pagecache_range+0x84/0xa0
 xfs_flush_unmap_range+0x70/0x90 [xfs]
 xfs_file_fallocate+0xfc/0x4d8 [xfs]
 vfs_fallocate+0x124/0x2e8
 ksys_fallocate+0x4c/0xa0
 __arm64_sys_fallocate+0x24/0x38
 invoke_syscall.constprop.0+0x7c/0xd8
 do_el0_svc+0xb4/0xd0
 el0_svc+0x44/0x1d8
 el0t_64_sync_handler+0x134/0x150
 el0t_64_sync+0x17c/0x180

Fix it by skipping to allocate PMD-sized page cache when its size is
larger than MAX_PAGECACHE_ORDER.  For this specific case, we will fall to
regular path where the readahead window is determined by BDI's sysfs file
(read_ahead_kb).

Link: https://lkml.kernel.org/r/20240627003953.1262512-4-gshan@redhat.com
Fixes: 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
Signed-off-by: Gavin Shan <gshan@redhat.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Don Dutile <ddutile@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: Zhenyu Zhang <zhenyzha@redhat.com>
Cc: <stable@vger.kernel.org>	[5.18+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/filemap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3100,7 +3100,7 @@ static struct file *do_sync_mmap_readahe
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* Use the readahead code, even if readahead is disabled */
-	if (vm_flags & VM_HUGEPAGE) {
+	if ((vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
 		ra->size = HPAGE_PMD_NR;



