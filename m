Return-Path: <stable+bounces-145739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A0EABE953
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 03:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8961D3AC6AA
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 01:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1131A5BB7;
	Wed, 21 May 2025 01:51:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D511BE251
	for <stable@vger.kernel.org>; Wed, 21 May 2025 01:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747792270; cv=none; b=fkE8TKgbu9C2eV8hOBdGUSiRvSc7IWVzrnpbinmhjwGl5shN8HsIl5JmhkJEOQ3TocUH7Wf144g3A6DPjyxWvHajK7cY9IZXbsmS+WgOD31zVujDNbl21kH3rwj2sVgPW4mSSOo4JUN0ZAtxosnLBgbIET5gX58XgghI74kXass=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747792270; c=relaxed/simple;
	bh=EIEHBct1LRjrFIpG+dMizkc2dYcslIuMANipXN0AZ7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n1LukDozsos43tUHpC77yE6HMkdR23elG6U9efIK/9Ya/ZPIa4HYvmD9kTDFgd6NjxypeXz3j7IMldJuNeQG++rzusgWYhi56E+NVQ6IS921zXoFJZ/nizdTiHLhUjupY3eK/OkcNAFcLKX9qEt61XL7mOZeflnb8MebGmZdCyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrAAnLRV1MS1o0iglCQ--.13980S2;
	Wed, 21 May 2025 09:50:45 +0800 (CST)
Received: from ubuntu.localdomain (unknown [10.12.190.56])
	by gateway (Coremail) with SMTP id _____wCH9wh1MS1owTYfAw--.43522S4;
	Wed, 21 May 2025 09:50:45 +0800 (CST)
From: Zhaoyang Li <lizy04@hust.edu.cn>
To: stable@vger.kernel.org
Cc: dzm91@hust.edu.cn,
	Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Zhaoyang Li <lizy04@hust.edu.cn>
Subject: [PATCH 6.1.y] btrfs: check folio mapping after unlock in relocate_one_folio()
Date: Wed, 21 May 2025 09:50:43 +0800
Message-Id: <20250521015043.533471-1-lizy04@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024123045-parka-sublet-a95d@gregkh>
References: <2024123045-parka-sublet-a95d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrAAnLRV1MS1o0iglCQ--.13980S2
Authentication-Results: app1; spf=neutral smtp.mail=lizy04@hust.edu.cn
	;
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWkurW5Zw43Ar18AF48Crg_yoWrXF43pr
	y7Gr1DKr48Jr1UJr4xJ3Wjyr1rK3WDZay7XrWxZrn3Z3W3Jwn8t34DGr1jyFyUtr4ktrW2
	qws8tw10qrn8AaUanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQSb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8Zw
	CF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUkCedUUUUU
X-CM-SenderInfo: rpsqjjixsriko6kx23oohg3hdfq/1tbiAQgJB2gr+2JQ3wABsT

From: Boris Burkov <boris@bur.io>

[ Upstream commit 3e74859ee35edc33a022c3f3971df066ea0ca6b9 ]

When we call btrfs_read_folio() to bring a folio uptodate, we unlock the
folio. The result of that is that a different thread can modify the
mapping (like remove it with invalidate) before we call folio_lock().
This results in an invalid page and we need to try again.

In particular, if we are relocating concurrently with aborting a
transaction, this can result in a crash like the following:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP
  CPU: 76 PID: 1411631 Comm: kworker/u322:5
  Workqueue: events_unbound btrfs_reclaim_bgs_work
  RIP: 0010:set_page_extent_mapped+0x20/0xb0
  RSP: 0018:ffffc900516a7be8 EFLAGS: 00010246
  RAX: ffffea009e851d08 RBX: ffffea009e0b1880 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: ffffc900516a7b90 RDI: ffffea009e0b1880
  RBP: 0000000003573000 R08: 0000000000000001 R09: ffff88c07fd2f3f0
  R10: 0000000000000000 R11: 0000194754b575be R12: 0000000003572000
  R13: 0000000003572fff R14: 0000000000100cca R15: 0000000005582fff
  FS:  0000000000000000(0000) GS:ffff88c07fd00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 000000407d00f002 CR4: 00000000007706f0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  PKRU: 55555554
  Call Trace:
  <TASK>
  ? __die+0x78/0xc0
  ? page_fault_oops+0x2a8/0x3a0
  ? __switch_to+0x133/0x530
  ? wq_worker_running+0xa/0x40
  ? exc_page_fault+0x63/0x130
  ? asm_exc_page_fault+0x22/0x30
  ? set_page_extent_mapped+0x20/0xb0
  relocate_file_extent_cluster+0x1a7/0x940
  relocate_data_extent+0xaf/0x120
  relocate_block_group+0x20f/0x480
  btrfs_relocate_block_group+0x152/0x320
  btrfs_relocate_chunk+0x3d/0x120
  btrfs_reclaim_bgs_work+0x2ae/0x4e0
  process_scheduled_works+0x184/0x370
  worker_thread+0xc6/0x3e0
  ? blk_add_timer+0xb0/0xb0
  kthread+0xae/0xe0
  ? flush_tlb_kernel_range+0x90/0x90
  ret_from_fork+0x2f/0x40
  ? flush_tlb_kernel_range+0x90/0x90
  ret_from_fork_asm+0x11/0x20
  </TASK>

This occurs because cleanup_one_transaction() calls
destroy_delalloc_inodes() which calls invalidate_inode_pages2() which
takes the folio_lock before setting mapping to NULL. We fail to check
this, and subsequently call set_extent_mapping(), which assumes that
mapping != NULL (in fact it asserts that in debug mode)

Note that the "fixes" patch here is not the one that introduced the
race (the very first iteration of this code from 2009) but a more recent
change that made this particular crash happen in practice.

Fixes: e7f1326cc24e ("btrfs: set page extent mapped after read_folio in relocate_one_page")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Zhaoyang Li <lizy04@hust.edu.cn>
---
 fs/btrfs/relocation.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d6cda0b2e925..fd6ea3fcab33 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2977,6 +2977,7 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 	int ret;
 
 	ASSERT(page_index <= last_index);
+again:
 	page = find_lock_page(inode->i_mapping, page_index);
 	if (!page) {
 		page_cache_sync_readahead(inode->i_mapping, ra, NULL,
@@ -2998,6 +2999,11 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 			ret = -EIO;
 			goto release_page;
 		}
+		if (page->mapping != inode->i_mapping) {
+			unlock_page(page);
+			put_page(page);
+			goto again;
+		}
 	}
 
 	/*
-- 
2.25.1


