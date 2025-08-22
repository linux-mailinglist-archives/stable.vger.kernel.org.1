Return-Path: <stable+bounces-172319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB16CB3103F
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0913AAE88
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 07:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4BF2E765E;
	Fri, 22 Aug 2025 07:23:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC2222587
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847437; cv=none; b=QHGgIbBy8W1DEKxKolxlZDFWNQ4CnQk9AEFHnjvU42YPSuzq5GqG1OYI4LhwYTX8C4YrEIzut+pgBuEuyrm3hZ5SpoIuAq0zkD8Q+RgdyP9Lz/1vlkg+92ucSonZFzFoeoYJiCtT38589wpax/op9tEE4y8+mO2NSjASAZMrEI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847437; c=relaxed/simple;
	bh=OzeHz+QWUn3dytEBfoKBpJQiU9ONaHHInpaQMMCgy9c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jIoTwtNb1P/Obie077nTiwLF3CFtrP5x/SMyGHS+9AsFxTM21m4vedn/q3IM2pWbbyFKhKtb+Ohw2V/XvEyfGhdiS+9XXOr3xNEThbIAgaxDcWlwDQDvnc8st9aZ9hZR/iHeVPfZA5tJSrss5yxMzoWFF0KLkMpPErWDeIoX7is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c7Wrf0dhYz14MYw;
	Fri, 22 Aug 2025 15:23:46 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id AD39214027A;
	Fri, 22 Aug 2025 15:23:50 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 22 Aug
 2025 15:23:50 +0800
From: Gu Bowen <gubowen5@huawei.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Waiman Long <llong@redhat.com>
CC: <stable@vger.kernel.org>, <linux-mm@kvack.org>, Breno Leitao
	<leitao@debian.org>, John Ogness <john.ogness@linutronix.de>, Lu Jialin
	<lujialin4@huawei.com>, Gu Bowen <gubowen5@huawei.com>
Subject: [PATCH v5] mm: Fix possible deadlock in kmemleak
Date: Fri, 22 Aug 2025 15:35:41 +0800
Message-ID: <20250822073541.1886469-1-gubowen5@huawei.com>
X-Mailer: git-send-email 2.43.0
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

There are some AA deadlock issues in kmemleak, similar to the situation
reported by Breno [1]. The deadlock path is as follows:

mem_pool_alloc()
  -> raw_spin_lock_irqsave(&kmemleak_lock, flags);
      -> pr_warn()
          -> netconsole subsystem
	     -> netpoll
	         -> __alloc_skb
		   -> __create_object
		     -> raw_spin_lock_irqsave(&kmemleak_lock, flags);

To solve this problem, switch to printk_safe mode before printing warning
message, this will redirect all printk()-s to a special per-CPU buffer,
which will be flushed later from a safe context (irq work), and this
deadlock problem can be avoided. The proper API to use should be
printk_deferred_enter()/printk_deferred_exit() [2]. Another way is to
place the warn print after kmemleak is released.

[1]
https://lore.kernel.org/all/20250731-kmemleak_lock-v1-1-728fd470198f@debian.org/#t
[2]
https://lore.kernel.org/all/5ca375cd-4a20-4807-b897-68b289626550@redhat.com/
====================

Signed-off-by: Gu Bowen <gubowen5@huawei.com>
---
 mm/kmemleak.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 84265983f239..1ac56ceb29b6 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -437,9 +437,15 @@ static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
 		else if (untagged_objp == untagged_ptr || alias)
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
@@ -736,6 +742,11 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
 		else if (untagged_objp + parent->size <= untagged_ptr)
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
@@ -743,6 +754,7 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
 			 * be freed while the kmemleak_lock is held.
 			 */
 			dump_object_info(parent);
+			printk_deferred_exit();
 			return -EEXIST;
 		}
 	}
@@ -856,13 +868,8 @@ static void delete_object_part(unsigned long ptr, size_t size,
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 	object = __find_and_remove_object(ptr, 1, objflags);
-	if (!object) {
-#ifdef DEBUG
-		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
-			      ptr, size);
-#endif
+	if (!object)
 		goto unlock;
-	}
 
 	/*
 	 * Create one or two objects that may result from the memory block
@@ -882,8 +889,14 @@ static void delete_object_part(unsigned long ptr, size_t size,
 
 unlock:
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
-	if (object)
+	if (object) {
 		__delete_object(object);
+	} else {
+#ifdef DEBUG
+		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
+			      ptr, size);
+#endif
+	}
 
 out:
 	if (object_l)
-- 
2.43.0


