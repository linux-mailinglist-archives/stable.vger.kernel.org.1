Return-Path: <stable+bounces-166767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C95B1D487
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 11:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87273B631A
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 09:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C88231C8D;
	Thu,  7 Aug 2025 09:03:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA301E520E
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754557409; cv=none; b=osoA6VZZKZV+00U7krxMdVAgSZ2tz4S3ph+IZlxtr1bpN8a82jqqyzVvDbD5WgqqLbuHy0Z80TvpjXLDKhtRLvkh/d3uJKiXsh+zdqM9sljAo5Zp1VKZs29SWEb46zRS3gFme+Zeb2E74NxRZAkPCoMId7htDyaLffNzepGX8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754557409; c=relaxed/simple;
	bh=1Rp3yioVhWC3DBdn2Z5dRVWwP6wwVtGspHCrybb6YoM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ESRrvdBLIJTDeS9vV1kvB8IsGJs/5Pu893xocoxtbIiMrlJ012SlcL7YTJwt/sXnGAn6+ERVI1LA/QnRlsHzabGPyapTZcjUhbwlevXZk1Aw/aTbMUJ9KyGvTIF1THBifMUeeG/Rt4uvXfkYxvXRRaIIq4yuxfzb3sdFftc+Pz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4byLhd0f2lz13MvG;
	Thu,  7 Aug 2025 17:00:01 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id 788CB180B60;
	Thu,  7 Aug 2025 17:03:17 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 7 Aug
 2025 17:03:16 +0800
From: Gu Bowen <gubowen5@huawei.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <stable@vger.kernel.org>, <linux-mm@kvack.org>, Waiman Long
	<llong@redhat.com>, Breno Leitao <leitao@debian.org>, John Ogness
	<john.ogness@linutronix.de>, Lu Jialin <lujialin4@huawei.com>, Gu Bowen
	<gubowen5@huawei.com>
Subject: [PATCH v2] mm: Fix possible deadlock in console_trylock_spinning
Date: Thu, 7 Aug 2025 17:14:44 +0800
Message-ID: <20250807091444.1999938-1-gubowen5@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemh100007.china.huawei.com (7.202.181.92)

Our syztester report the lockdep WARNING [1]. kmemleak_scan_thread()
invokes scan_block() which may invoke a nomal printk() to print warning
message. This can cause a deadlock in the scenario reported below:

       CPU0                    CPU1
       ----                    ----
  lock(kmemleak_lock);
                               lock(&port->lock);
                               lock(kmemleak_lock);
  lock(console_owner);

To solve this problem, switch to printk_safe mode before printing warning
message, this will redirect all printk()-s to a special per-CPU buffer,
which will be flushed later from a safe context (irq work), and this
deadlock problem can be avoided. The proper API to use should be
printk_deferred_enter()/printk_deferred_exit() if we want to deferred the
printing [2].

This patch also fix some similar cases that need to use the printk
deferring [3].

[1]
https://lore.kernel.org/all/20250730094914.566582-1-gubowen5@huawei.com/
[2]
https://lore.kernel.org/all/5ca375cd-4a20-4807-b897-68b289626550@redhat.com/
[3]
https://lore.kernel.org/all/aJCir5Wh362XzLSx@arm.com/
====================

Cc: stable@vger.kernel.org # 5.10
Signed-off-by: Gu Bowen <gubowen5@huawei.com>
---
 mm/kmemleak.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 4801751cb6b6..381145dde54f 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -390,9 +390,15 @@ static struct kmemleak_object *lookup_object(unsigned long ptr, int alias)
 		else if (object->pointer == ptr || alias)
 			return object;
 		else {
+			/*
+			 * Printk deferring due to the kmemleak_lock held.
+			 * This is done to avoid deadlock.
+			 */
+			printk_deferred_enter();
 			kmemleak_warn("Found object by alias at 0x%08lx\n",
 				      ptr);
 			dump_object_info(object);
+			printk_deferred_exit();
 			break;
 		}
 	}
@@ -433,8 +439,15 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
 		list_del(&object->object_list);
 	else if (mem_pool_free_count)
 		object = &mem_pool[--mem_pool_free_count];
-	else
+	else {
+		/*
+		 * Printk deferring due to the kmemleak_lock held.
+		 * This is done to avoid deadlock.
+		 */
+		printk_deferred_enter();
 		pr_warn_once("Memory pool empty, consider increasing CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE\n");
+		printk_deferred_exit();
+	}
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 
 	return object;
@@ -632,6 +645,11 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 		else if (parent->pointer + parent->size <= ptr)
 			link = &parent->rb_node.rb_right;
 		else {
+			/*
+			 * Printk deferring due to the kmemleak_lock held.
+			 * This is done to avoid deadlock.
+			 */
+			printk_deferred_enter();
 			kmemleak_stop("Cannot insert 0x%lx into the object search tree (overlaps existing)\n",
 				      ptr);
 			/*
@@ -639,6 +657,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 			 * be freed while the kmemleak_lock is held.
 			 */
 			dump_object_info(parent);
+			printk_deferred_exit();
 			kmem_cache_free(object_cache, object);
 			object = NULL;
 			goto out;
-- 
2.25.1


