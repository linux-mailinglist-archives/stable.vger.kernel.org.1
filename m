Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4C2755301
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjGPUOf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjGPUOc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:14:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EAA90
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:14:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40E9F60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C501C433C8;
        Sun, 16 Jul 2023 20:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538470;
        bh=3cu3x4sHQW+WxnS/w03PDRp/mqDkaA/Mfp0rdcJj7oA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QDNW9uugBt+IEnZ1nvTm4dvqkCGTRYRseZ4L3Kw5Nu74ICZeGIpsrMmexRks3BI2K
         BxwAFiaD731aIEHkJrJBEpEh8uIKrL31enAPdPGZI7Tdr4S4obgwoq+ZMa0VEDtl1E
         bjNlvs/s4EEnaSRwoTmdfIwVl3bRyOOeXiRE10B0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 433/800] iommufd: Do not access the area pointer after unlocking
Date:   Sun, 16 Jul 2023 21:44:46 +0200
Message-ID: <20230716194959.142133347@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 804ca14d04df09bf7924bacc5ad22a4bed80c94f ]

A concurrent unmap can trigger freeing of the area pointers while we are
generating an unmapping notification for accesses.

syzkaller reports:

  BUG: KASAN: slab-use-after-free in iopt_unmap_iova_range+0x5ba/0x5f0
  Read of size 4 at addr ffff888075996184 by task syz-executor.2/31160

  CPU: 1 PID: 31160 Comm: syz-executor.2 Not tainted 6.4.0-rc5-syzkaller-00313-g4c605260bc60 #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
  Call Trace:
   <TASK>
   dump_stack_lvl+0xd9/0x150
   print_address_description.constprop.0+0x2c/0x3c0
   kasan_report+0x11c/0x130
   iopt_unmap_iova_range+0x5ba/0x5f0
   iopt_unmap_all+0x27/0x50
   iommufd_ioas_unmap+0x3d0/0x490
   iommufd_fops_ioctl+0x317/0x4b0
   __x64_sys_ioctl+0x197/0x210
   do_syscall_64+0x39/0xb0
   entry_SYSCALL_64_after_hwframe+0x63/0xcd
  RIP: 0033:0x7f0812c8c169
  Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007f0813914168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 00007f0812dabf80 RCX: 00007f0812c8c169
  RDX: 0000000020000100 RSI: 0000000000003b86 RDI: 0000000000000005
  RBP: 00007f0812ce7ca1 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  R13: 00007f0812ecfb1f R14: 00007f0813914300 R15: 0000000000022000
   </TASK>

  Allocated by task 31160:
   kasan_save_stack+0x22/0x40
   kasan_set_track+0x25/0x30
   __kasan_kmalloc+0xa2/0xb0
   iopt_alloc_area_pages+0x94/0x560
   iopt_map_user_pages+0x205/0x4e0
   iommufd_ioas_map+0x329/0x5f0
   iommufd_fops_ioctl+0x317/0x4b0
   __x64_sys_ioctl+0x197/0x210
   do_syscall_64+0x39/0xb0
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

  Freed by task 31161:
   kasan_save_stack+0x22/0x40
   kasan_set_track+0x25/0x30
   kasan_save_free_info+0x2e/0x40
   ____kasan_slab_free+0x160/0x1c0
   slab_free_freelist_hook+0x8b/0x1c0
   __kmem_cache_free+0xaf/0x2d0
   iopt_unmap_iova_range+0x288/0x5f0
   iopt_unmap_all+0x27/0x50
   iommufd_ioas_unmap+0x3d0/0x490
   iommufd_fops_ioctl+0x317/0x4b0
   __x64_sys_ioctl+0x197/0x210
   do_syscall_64+0x39/0xb0
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

  The buggy address belongs to the object at ffff888075996100
   which belongs to the cache kmalloc-cg-192 of size 192
  The buggy address is located 132 bytes inside of
   freed 192-byte region [ffff888075996100, ffff8880759961c0)

  The buggy address belongs to the physical page:
  page:ffffea0001d66580 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x75996
  memcg:ffff88801f1c2701
  flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
  page_type: 0xffffffff()
  raw: 00fff00000000200 ffff88801244ddc0 dead000000000122 0000000000000000
  raw: 0000000000000000 0000000080100010 00000001ffffffff ffff88801f1c2701
  page dumped because: kasan: bad access detected
  page_owner tracks the page as allocated
  page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 31157, tgid 31154 (syz-executor.0), ts 1984547323469, free_ts 1983933451331
   post_alloc_hook+0x2db/0x350
   get_page_from_freelist+0xf41/0x2c00
   __alloc_pages+0x1cb/0x4a0
   alloc_pages+0x1aa/0x270
   allocate_slab+0x25f/0x390
   ___slab_alloc+0xa91/0x1400
   __slab_alloc.constprop.0+0x56/0xa0
   __kmem_cache_alloc_node+0x136/0x320
   kmalloc_trace+0x26/0xe0
   iommufd_test+0x1328/0x2c20
   iommufd_fops_ioctl+0x317/0x4b0
   __x64_sys_ioctl+0x197/0x210
   do_syscall_64+0x39/0xb0
   entry_SYSCALL_64_after_hwframe+0x63/0xcd
  page last free stack trace:
   free_unref_page_prepare+0x62e/0xcb0
   free_unref_page_list+0xe3/0xa70
   release_pages+0xcd8/0x1380
   tlb_batch_pages_flush+0xa8/0x1a0
   tlb_finish_mmu+0x14b/0x7e0
   exit_mmap+0x2b2/0x930
   __mmput+0x128/0x4c0
   mmput+0x60/0x70
   do_exit+0x9b0/0x29b0
   do_group_exit+0xd4/0x2a0
   get_signal+0x2318/0x25b0
   arch_do_signal_or_restart+0x79/0x5c0
   exit_to_user_mode_prepare+0x11f/0x240
   syscall_exit_to_user_mode+0x1d/0x50
   do_syscall_64+0x46/0xb0
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

Precompute what is needed to call the access function and do not check the
area's num_accesses again as the pointer may not be valid anymore. Use a
counter instead.

Fixes: 51fe6141f0f6 ("iommufd: Data structure to provide IOVA to PFN mapping")
Link: https://lore.kernel.org/r/1-v2-9a03761d445d+54-iommufd_syz2_jgg@nvidia.com
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reported-by: syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/0000000000001d40fc05fe385332@google.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/io_pagetable.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index e0ae72b9e67f8..724c4c5742417 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -458,6 +458,7 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 {
 	struct iopt_area *area;
 	unsigned long unmapped_bytes = 0;
+	unsigned int tries = 0;
 	int rc = -ENOENT;
 
 	/*
@@ -484,19 +485,26 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 			goto out_unlock_iova;
 		}
 
+		if (area_first != start)
+			tries = 0;
+
 		/*
 		 * num_accesses writers must hold the iova_rwsem too, so we can
 		 * safely read it under the write side of the iovam_rwsem
 		 * without the pages->mutex.
 		 */
 		if (area->num_accesses) {
+			size_t length = iopt_area_length(area);
+
 			start = area_first;
 			area->prevent_access = true;
 			up_write(&iopt->iova_rwsem);
 			up_read(&iopt->domains_rwsem);
-			iommufd_access_notify_unmap(iopt, area_first,
-						    iopt_area_length(area));
-			if (WARN_ON(READ_ONCE(area->num_accesses)))
+
+			iommufd_access_notify_unmap(iopt, area_first, length);
+			/* Something is not responding to unmap requests. */
+			tries++;
+			if (WARN_ON(tries > 100))
 				return -EDEADLOCK;
 			goto again;
 		}
-- 
2.39.2



