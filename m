Return-Path: <stable+bounces-196803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8644BC82807
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 22:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E59394E2FFB
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 21:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9C732E737;
	Mon, 24 Nov 2025 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Af1nE0F8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697792F3620
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764019087; cv=none; b=CxRbVu9m2OyciDjpKrdTnY6ll5FhQN2vduxZ+pxlJUwlnZD4RQ4VirdaoBynbgwubMROWTaAuiqE4oRQ2EkB/NOSNzsQFCBjW6KX5FjI7BHKgXAK9x4F/zjgmIWMR2CoghvuHuMbUKan9HK/cqkBZKiLcH/K1yFVOX4RC/iX/kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764019087; c=relaxed/simple;
	bh=RochjBOWr22UbdjKV8hEWYy2B/iPEmwxHm2jWS6g6U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imiU19xubTY4lyTVMndTSrsAS+JBEMtSn1HoG1xPgmR5nuySp4NIPNL43KNRqjxzMBnHqkDUSfC7WYju96gn+/Zq9xo/JOalSkBzPWDCYyzH4vSB83+3VBEfirF+oN7vSXfi9nvbS83K/kUDfTWaINM9gz+Rhmh3/ukmMxcy17I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Af1nE0F8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37152C4CEFB;
	Mon, 24 Nov 2025 21:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764019086;
	bh=RochjBOWr22UbdjKV8hEWYy2B/iPEmwxHm2jWS6g6U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Af1nE0F86u7a9q75Qt6NKOaEzi1KURU3pe63dzt1qKfPSxVXhn58DXf19sX8VoGrb
	 589jr7Ye03ei5P/jLa3S+5Q4i9ABl5WHRtRi/Ww8r9T1RN0nCzzQxowo8IoCttSetx
	 ITCCbxkLAQjC9T37j27o/YKT/jQHKlZ98QnCau/EIivb0ZDiRBEpFRQGxqEDNn+It8
	 ynaqZVWU24XMr7B1NtrS0l4iAbwEy9UTzChuLkfO6FFLjInmmHSpnCE8D9nDJVo1Q9
	 ddfH07kHbbU9mHSGMQ5kOBCng2GfaXPWJ4LO+Y77ZtI9UjiHKZSROi9aaG0L94G8Dl
	 4D9PQSRl48HJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	kernel test robot <oliver.sang@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] mm/mempool: fix poisoning order>0 pages with HIGHMEM
Date: Mon, 24 Nov 2025 16:18:03 -0500
Message-ID: <20251124211803.34596-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124211803.34596-1-sashal@kernel.org>
References: <2025112435-agile-sprawl-f420@gregkh>
 <20251124211803.34596-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlastimil Babka <vbabka@suse.cz>

[ Upstream commit ec33b59542d96830e3c89845ff833cf7b25ef172 ]

The kernel test has reported:

  BUG: unable to handle page fault for address: fffba000
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  *pde = 03171067 *pte = 00000000
  Oops: Oops: 0002 [#1]
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T   6.18.0-rc2-00031-gec7f31b2a2d3 #1 NONE  a1d066dfe789f54bc7645c7989957d2bdee593ca
  Tainted: [T]=RANDSTRUCT
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  EIP: memset (arch/x86/include/asm/string_32.h:168 arch/x86/lib/memcpy_32.c:17)
  Code: a5 8b 4d f4 83 e1 03 74 02 f3 a4 83 c4 04 5e 5f 5d 2e e9 73 41 01 00 90 90 90 3e 8d 74 26 00 55 89 e5 57 56 89 c6 89 d0 89 f7 <f3> aa 89 f0 5e 5f 5d 2e e9 53 41 01 00 cc cc cc 55 89 e5 53 57 56
  EAX: 0000006b EBX: 00000015 ECX: 001fefff EDX: 0000006b
  ESI: fffb9000 EDI: fffba000 EBP: c611fbf0 ESP: c611fbe8
  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010287
  CR0: 80050033 CR2: fffba000 CR3: 0316e000 CR4: 00040690
  Call Trace:
   poison_element (mm/mempool.c:83 mm/mempool.c:102)
   mempool_init_node (mm/mempool.c:142 mm/mempool.c:226)
   mempool_init_noprof (mm/mempool.c:250 (discriminator 1))
   ? mempool_alloc_pages (mm/mempool.c:640)
   bio_integrity_initfn (block/bio-integrity.c:483 (discriminator 8))
   ? mempool_alloc_pages (mm/mempool.c:640)
   do_one_initcall (init/main.c:1283)

Christoph found out this is due to the poisoning code not dealing
properly with CONFIG_HIGHMEM because only the first page is mapped but
then the whole potentially high-order page is accessed.

We could give up on HIGHMEM here, but it's straightforward to fix this
with a loop that's mapping, poisoning or checking and unmapping
individual pages.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202511111411.9ebfa1ba-lkp@intel.com
Analyzed-by: Christoph Hellwig <hch@lst.de>
Fixes: bdfedb76f4f5 ("mm, mempool: poison elements backed by slab allocator")
Cc: stable@vger.kernel.org
Tested-by: kernel test robot <oliver.sang@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20251113-mempool-poison-v1-1-233b3ef984c3@suse.cz
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mempool.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 81f38f8c2cbbe..9b5bd2c141116 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -62,10 +62,20 @@ static void check_element(mempool_t *pool, void *element)
 	} else if (pool->free == mempool_free_pages) {
 		/* Mempools backed by page allocator */
 		int order = (int)(long)pool->pool_data;
-		void *addr = kmap_local_page((struct page *)element);
 
-		__check_element(pool, addr, 1UL << (PAGE_SHIFT + order));
-		kunmap_local(addr);
+#ifdef CONFIG_HIGHMEM
+		for (int i = 0; i < (1 << order); i++) {
+			struct page *page = (struct page *)element;
+			void *addr = kmap_local_page(page + i);
+
+			__check_element(pool, addr, PAGE_SIZE);
+			kunmap_local(addr);
+		}
+#else
+		void *addr = page_address((struct page *)element);
+
+		__check_element(pool, addr, PAGE_SIZE << order);
+#endif
 	}
 }
 
@@ -85,10 +95,20 @@ static void poison_element(mempool_t *pool, void *element)
 	} else if (pool->alloc == mempool_alloc_pages) {
 		/* Mempools backed by page allocator */
 		int order = (int)(long)pool->pool_data;
-		void *addr = kmap_local_page((struct page *)element);
 
-		__poison_element(addr, 1UL << (PAGE_SHIFT + order));
-		kunmap_local(addr);
+#ifdef CONFIG_HIGHMEM
+		for (int i = 0; i < (1 << order); i++) {
+			struct page *page = (struct page *)element;
+			void *addr = kmap_local_page(page + i);
+
+			__poison_element(addr, PAGE_SIZE);
+			kunmap_local(addr);
+		}
+#else
+		void *addr = page_address((struct page *)element);
+
+		__poison_element(addr, PAGE_SIZE << order);
+#endif
 	}
 }
 #else /* CONFIG_DEBUG_SLAB || CONFIG_SLUB_DEBUG_ON */
-- 
2.51.0


