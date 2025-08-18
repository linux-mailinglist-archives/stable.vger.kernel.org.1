Return-Path: <stable+bounces-169938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B273EB29CFD
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90491188D776
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 08:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D150308F0D;
	Mon, 18 Aug 2025 08:58:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2A330AAB8
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507489; cv=none; b=Zmbd2BP0gErmTf2t0DuIfkWuV+f06U9YfRafkHpJZHJ2hZQt94uUaycx/fqlXN2EMu8Riayjvvy4uf0uLS3hBGBVmLEl58G0JFEOLf9lz0tPSojOsfl0SKW1cRuoSbx+xfB9isfj9Su1NzPOabFKsieTWVCdp7VOvkB51abxIFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507489; c=relaxed/simple;
	bh=tanzvi3OYzpmwbV2tx1UtYVkCIbB/H8PG5+jmpR4XZw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kbs6vFDgzl+IsWNqhgO5dZTlJwInX6dq9zYyBX5C+n1kL99N4pOClehVz31e8z0K7UOVMbNIingVFdbPa1vZEkORedDnpA/R0bOPuy29Dkn3aqNbFqyxTcujj8jrmxpYdDCaNkZrAPavap1Z/cgWHPBasDwdsOreubTJBTURGb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c56662ft3zpbjR;
	Mon, 18 Aug 2025 16:57:02 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id A34CE1401E9;
	Mon, 18 Aug 2025 16:58:01 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Aug
 2025 16:58:01 +0800
From: Gu Bowen <gubowen5@huawei.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <linux-mm@kvack.org>, Waiman Long
	<llong@redhat.com>, Breno Leitao <leitao@debian.org>, John Ogness
	<john.ogness@linutronix.de>, Lu Jialin <lujialin4@huawei.com>, Gu Bowen
	<gubowen5@huawei.com>
Subject: [PATCH v4] mm: Fix possible deadlock in kmemleak
Date: Mon, 18 Aug 2025 17:09:44 +0800
Message-ID: <20250818090945.1003644-1-gubowen5@huawei.com>
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

Our syztester report the lockdep WARNING [1], which was identified in
stable kernel version 5.10. However, this deadlock path no longer exists
due to the refactoring of console_lock in v6.2-rc1 [2]. Coincidentally,
there are two types of deadlocks that we have found here. One is the ABBA
deadlock, as mentioned above [1], and the other is the AA deadlock was
reported by Breno [3]. The latter's deadlock issue persists.

To solve this problem, switch to printk_safe mode before printing warning
message, this will redirect all printk()-s to a special per-CPU buffer,
which will be flushed later from a safe context (irq work), and this
deadlock problem can be avoided. The proper API to use should be
printk_deferred_enter()/printk_deferred_exit() [4].

[1]
https://lore.kernel.org/all/20250730094914.566582-1-gubowen5@huawei.com/
[2]
https://lore.kernel.org/all/20221116162152.193147-1-john.ogness@linutronix.de/
[3]
https://lore.kernel.org/all/20250731-kmemleak_lock-v1-1-728fd470198f@debian.org/#t
[4]
https://lore.kernel.org/all/5ca375cd-4a20-4807-b897-68b289626550@redhat.com/
====================

Signed-off-by: Gu Bowen <gubowen5@huawei.com>
---
 mm/kmemleak.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 84265983f239..26113b89d09b 100644
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
@@ -858,8 +870,14 @@ static void delete_object_part(unsigned long ptr, size_t size,
 	object = __find_and_remove_object(ptr, 1, objflags);
 	if (!object) {
 #ifdef DEBUG
+		/*
+		 * Printk deferring due to the kmemleak_lock held.
+		 * This is done to avoid deadlock.
+		 */
+		printk_deferred_enter();
 		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
 			      ptr, size);
+		printk_deferred_exit();
 #endif
 		goto unlock;
 	}
-- 
2.43.0


