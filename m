Return-Path: <stable+bounces-50432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D45D79065D3
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB3A282060
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A3D13D244;
	Thu, 13 Jun 2024 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rmcuPqKg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89FA13D2AA
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265366; cv=none; b=OdfO2dehrEk2JyEERKBei02l73/so6rPyFTWCJyinYRb1p74wVPD4jqXIBLTznN4uv+aPKIjJOKurEdtQb4xPTH8DV+E2uv5HY5nvWhWjwW0CyHYkRHy0Ocug8EBB4IyZvgAm6xQsZIxqVk2YfewCFLY9ImNVQHB6iZaRHCDCt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265366; c=relaxed/simple;
	bh=Yh+hJj3kz+m+36ufHiu8QNMS2xsHxIeWeOLul4lQ2ik=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Lzy/G3OfoYDeUZVOT6dDqZAlSt+sZ8C1x3zjyowN6k9CSh7Z9KiL3agMUfYxuEc4VDag0Z75zDrv/M6spD4n9rcqnS95hzZvD108a/iGCAIY1j35f+ffwuaHog1ZMBSDizMWUrxfFYr0fZ7Kqi9LVHnHIEs58ZIs0IwDa0Pgs4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rmcuPqKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E93C3277B;
	Thu, 13 Jun 2024 07:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718265366;
	bh=Yh+hJj3kz+m+36ufHiu8QNMS2xsHxIeWeOLul4lQ2ik=;
	h=Subject:To:Cc:From:Date:From;
	b=rmcuPqKgSOmX8xwcWWWpF6vNpp1UMcqfdiDFETu8nekfPQY7e44uGeasOIVhAtd4G
	 /UtYhGjIV65YmNUeTlhvFvx7bhgBAxT3mE1sdXBsrpG2MX3d1Lt57iBxe/5/pelsKJ
	 M286H7Kvw/Jkr+Q9X9xD2pwXzZ/k/h0P6ntQklNo=
Subject: FAILED: patch "[PATCH] mm/vmalloc: fix vmalloc which may return null if called with" failed to apply to 6.1-stable tree
To: hailong.liu@oppo.com,21cnbao@gmail.com,akpm@linux-foundation.org,baohua@kernel.org,chao@kernel.org,hch@infradead.org,liyangouwen1@oppo.com,lstoakes@gmail.com,mhocko@suse.com,stable@vger.kernel.org,urezki@gmail.com,xiang@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 09:56:03 +0200
Message-ID: <2024061303-heap-catalyst-0a58@gregkh>
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
git cherry-pick -x 8e0545c83d672750632f46e3f9ad95c48c91a0fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061303-heap-catalyst-0a58@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

8e0545c83d67 ("mm/vmalloc: fix vmalloc which may return null if called with __GFP_NOFAIL")
e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8e0545c83d672750632f46e3f9ad95c48c91a0fc Mon Sep 17 00:00:00 2001
From: "Hailong.Liu" <hailong.liu@oppo.com>
Date: Fri, 10 May 2024 18:01:31 +0800
Subject: [PATCH] mm/vmalloc: fix vmalloc which may return null if called with
 __GFP_NOFAIL

commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
includes support for __GFP_NOFAIL, but it presents a conflict with commit
dd544141b9eb ("vmalloc: back off when the current task is OOM-killed").  A
possible scenario is as follows:

process-a
__vmalloc_node_range(GFP_KERNEL | __GFP_NOFAIL)
    __vmalloc_area_node()
        vm_area_alloc_pages()
		--> oom-killer send SIGKILL to process-a
        if (fatal_signal_pending(current)) break;
--> return NULL;

To fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
if __GFP_NOFAIL set.

This issue occurred during OPLUS KASAN TEST. Below is part of the log
-> oom-killer sends signal to process
[65731.222840] [ T1308] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/apps/uid_10198,task=gs.intelligence,pid=32454,uid=10198

[65731.259685] [T32454] Call trace:
[65731.259698] [T32454]  dump_backtrace+0xf4/0x118
[65731.259734] [T32454]  show_stack+0x18/0x24
[65731.259756] [T32454]  dump_stack_lvl+0x60/0x7c
[65731.259781] [T32454]  dump_stack+0x18/0x38
[65731.259800] [T32454]  mrdump_common_die+0x250/0x39c [mrdump]
[65731.259936] [T32454]  ipanic_die+0x20/0x34 [mrdump]
[65731.260019] [T32454]  atomic_notifier_call_chain+0xb4/0xfc
[65731.260047] [T32454]  notify_die+0x114/0x198
[65731.260073] [T32454]  die+0xf4/0x5b4
[65731.260098] [T32454]  die_kernel_fault+0x80/0x98
[65731.260124] [T32454]  __do_kernel_fault+0x160/0x2a8
[65731.260146] [T32454]  do_bad_area+0x68/0x148
[65731.260174] [T32454]  do_mem_abort+0x151c/0x1b34
[65731.260204] [T32454]  el1_abort+0x3c/0x5c
[65731.260227] [T32454]  el1h_64_sync_handler+0x54/0x90
[65731.260248] [T32454]  el1h_64_sync+0x68/0x6c

[65731.260269] [T32454]  z_erofs_decompress_queue+0x7f0/0x2258
--> be->decompressed_pages = kvcalloc(be->nr_pages, sizeof(struct page *), GFP_KERNEL | __GFP_NOFAIL);
	kernel panic by NULL pointer dereference.
	erofs assume kvmalloc with __GFP_NOFAIL never return NULL.
[65731.260293] [T32454]  z_erofs_runqueue+0xf30/0x104c
[65731.260314] [T32454]  z_erofs_readahead+0x4f0/0x968
[65731.260339] [T32454]  read_pages+0x170/0xadc
[65731.260364] [T32454]  page_cache_ra_unbounded+0x874/0xf30
[65731.260388] [T32454]  page_cache_ra_order+0x24c/0x714
[65731.260411] [T32454]  filemap_fault+0xbf0/0x1a74
[65731.260437] [T32454]  __do_fault+0xd0/0x33c
[65731.260462] [T32454]  handle_mm_fault+0xf74/0x3fe0
[65731.260486] [T32454]  do_mem_abort+0x54c/0x1b34
[65731.260509] [T32454]  el0_da+0x44/0x94
[65731.260531] [T32454]  el0t_64_sync_handler+0x98/0xb4
[65731.260553] [T32454]  el0t_64_sync+0x198/0x19c

Link: https://lkml.kernel.org/r/20240510100131.1865-1-hailong.liu@oppo.com
Fixes: 9376130c390a ("mm/vmalloc: add support for __GFP_NOFAIL")
Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Suggested-by: Barry Song <21cnbao@gmail.com>
Reported-by: Oven <liyangouwen1@oppo.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Chao Yu <chao@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Gao Xiang <xiang@kernel.org>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6641be0ca80b..5d3aa2dc88a8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3498,7 +3498,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 {
 	unsigned int nr_allocated = 0;
 	gfp_t alloc_gfp = gfp;
-	bool nofail = false;
+	bool nofail = gfp & __GFP_NOFAIL;
 	struct page *page;
 	int i;
 
@@ -3555,12 +3555,11 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		 * and compaction etc.
 		 */
 		alloc_gfp &= ~__GFP_NOFAIL;
-		nofail = true;
 	}
 
 	/* High-order pages or fallback path if "bulk" fails. */
 	while (nr_allocated < nr_pages) {
-		if (fatal_signal_pending(current))
+		if (!nofail && fatal_signal_pending(current))
 			break;
 
 		if (nid == NUMA_NO_NODE)


