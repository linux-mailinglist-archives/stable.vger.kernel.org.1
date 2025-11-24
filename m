Return-Path: <stable+bounces-196714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90086C80CC9
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12F794E65B3
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9861C306D23;
	Mon, 24 Nov 2025 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fIla0S8+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5740D306B3E
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763991400; cv=none; b=NbE2d9T9op3LS4KjjJTEQC2ZQvk2fkFfwGA04MPK9D2SVi+Jv0+dUjl3yc1rLPedyX9GsI5vRwhgmDRbPx/KZAWrzFhVFQJyOzPCN270gXuAU9X2+IS79LbX70Qupubh4pYqJeuUIakgvbZAmbrs05x1oCiZ68B2fkqkD01/GSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763991400; c=relaxed/simple;
	bh=kFs0vQmZNPg1Bg/SPTNM4kac8BFuAaOvdVN4nrj6v6I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c59M/YX2RD74+NAx9QApt1Itve3TCQFlr1nz6v599IZoI/2vR9fdcYzLsALpXqkFB9iP61XOmLkdvEwxWdozrSsnKmrCzm7jJWomSFCgO9TshzuH4T3nAk0rD/Pwo3Ted2hAPTfgFsCMJfDk+oNSjBAJRHYn2GyJe80BMOwqWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fIla0S8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94693C4CEF1;
	Mon, 24 Nov 2025 13:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763991400;
	bh=kFs0vQmZNPg1Bg/SPTNM4kac8BFuAaOvdVN4nrj6v6I=;
	h=Subject:To:Cc:From:Date:From;
	b=fIla0S8+6Ax3o4AGG2B6zeaMN/2pb71kH86RA/7ZsgUzDi/AQdjuLLVfVuX0JHqet
	 e1rwG/g51ZXAkEsw4jDezQZID6fSughPgRGLXiGDocx5qa9DaGraEVAE/TJrNKtNFu
	 RpYv0fDAyZrOnT6tnA4v2wmj4kyzaFBh6/ePeMl4=
Subject: FAILED: patch "[PATCH] mm/mempool: fix poisoning order>0 pages with HIGHMEM" failed to apply to 6.1-stable tree
To: vbabka@suse.cz,hch@lst.de,oliver.sang@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:36:35 +0100
Message-ID: <2025112435-agile-sprawl-f420@gregkh>
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
git cherry-pick -x ec33b59542d96830e3c89845ff833cf7b25ef172
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112435-agile-sprawl-f420@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ec33b59542d96830e3c89845ff833cf7b25ef172 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 13 Nov 2025 19:54:35 +0100
Subject: [PATCH] mm/mempool: fix poisoning order>0 pages with HIGHMEM

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

diff --git a/mm/mempool.c b/mm/mempool.c
index 1c38e873e546..d7bbf1189db9 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -68,10 +68,20 @@ static void check_element(mempool_t *pool, void *element)
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
 
@@ -97,10 +107,20 @@ static void poison_element(mempool_t *pool, void *element)
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
 #else /* CONFIG_SLUB_DEBUG_ON */


