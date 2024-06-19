Return-Path: <stable+bounces-54509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF7790EE95
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297EA1C24512
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F42514D70F;
	Wed, 19 Jun 2024 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BMaYxomQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5AD14C5B8;
	Wed, 19 Jun 2024 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803790; cv=none; b=p12792Dnpr9tjo+aZPyaalHuVjheknZR+ZwHPR+bthYHF/DIXEShb0N06yLWdfn03m2YaMWejHbYBpPwcCXEVVsZbVZS0dZn1tMR83AHiZjY2yyi9uIZ2UwAKiZzPgH9235Q4RordhhHfnlfyiDEBkylY3phxO2qos7pcYUQmIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803790; c=relaxed/simple;
	bh=Xc71xN4rHHl+eNY48E8alQoz19K3j14wileFRz/Y2Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXkY1LweC7EKRDJMq0FlB1xg8JszNrgpR8HB82ezVP70u8KyF6merBQ4K29NFdEZMhKjcot9yQclEmcTMdwcnhBPYNdRyTKFy34tSlE2YZRCMrjEy97nb8dKIfbRkhkx9rGxhVOkSgglCYepzpTHTMQGaNP8emeFoEVc6yNFeOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BMaYxomQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559C9C2BBFC;
	Wed, 19 Jun 2024 13:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803789;
	bh=Xc71xN4rHHl+eNY48E8alQoz19K3j14wileFRz/Y2Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BMaYxomQqu1jsqNxvOuDa4zgKwifmgphS5nbzpxFSK5WO9+yQSdv8ALDPiu7YOOLQ
	 wvhpbSJF72arsVTVUsPrmkkLBOTGkHgQ77ynJ1RlA6UNPk6ThUxqAP2oDz5wfiVoZ1
	 f6ZJg1NcJ/o3Jmtgq+ao7wHVBPD+CV4gzrQfzt3c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Hailong.Liu" <hailong.liu@oppo.com>,
	Michal Hocko <mhocko@suse.com>,
	Barry Song <21cnbao@gmail.com>,
	Oven <liyangouwen1@oppo.com>,
	Barry Song <baohua@kernel.org>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Chao Yu <chao@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Gao Xiang <xiang@kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 073/217] mm/vmalloc: fix vmalloc which may return null if called with __GFP_NOFAIL
Date: Wed, 19 Jun 2024 14:55:16 +0200
Message-ID: <20240619125559.502263919@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
References: <20240619125556.491243678@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hailong.Liu <hailong.liu@oppo.com>

[ Upstream commit 8e0545c83d672750632f46e3f9ad95c48c91a0fc ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vmalloc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index cab30d9497e6b..c5e30b52844c8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2924,7 +2924,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 {
 	unsigned int nr_allocated = 0;
 	gfp_t alloc_gfp = gfp;
-	bool nofail = false;
+	bool nofail = gfp & __GFP_NOFAIL;
 	struct page *page;
 	int i;
 
@@ -2981,12 +2981,11 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
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
-- 
2.43.0




