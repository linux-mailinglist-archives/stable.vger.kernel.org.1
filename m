Return-Path: <stable+bounces-99711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3A39E72FA
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8049216A71D
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C7F203710;
	Fri,  6 Dec 2024 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EmwH55wN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4565154BF5;
	Fri,  6 Dec 2024 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498094; cv=none; b=pxDacMEBG1QffzS7U8j76KeybClYBedYKPM8rFgRusTgkV9vlS3yVOo3Nlbu42fAkDK2GVGybGhGDL1O6yMjIrnl6moYflFWNzKV4WOir2FEyeuGGb0gLrnRK65XUcSrXby3MHDLMnDw5kedWrvyf6V716DoHl/Ni5xELPk+C7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498094; c=relaxed/simple;
	bh=VI1+DVZIokSId4C2HwB4NSOjpAKEyPAgvWt1mva6WLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoPnUVdiKnx0y+Gdclq4JXiTJR6OZ67s6fIDcEifNwe0puXYLMPeW6d2h0AJYmWu0QUZLVdOKvKFAK7+gNkigO31HA9rbexKJhe7mTLABrPMPFFv3pfFSB5qGhiQGEK+HoNBenpurQ6BRqkc13thxdpY5YbkTN7+W7GywhQGCl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EmwH55wN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5286AC4CED1;
	Fri,  6 Dec 2024 15:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733498093;
	bh=VI1+DVZIokSId4C2HwB4NSOjpAKEyPAgvWt1mva6WLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EmwH55wNsY5ko/LBErRWpODLz9/RcdoZQvg6sT8ehR5z70MD7NpG8k16UGs25PlpB
	 PrDxvxsMZyjtAwmp5tomhyq1qpCBKVpLdxpBiryHI53FLeczvPM0kOTDthJFjTQAE2
	 B05xrE2Ewz4WXrwF+BnNM1IzfBr5xCxCVJlwEotM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 6.6 453/676] dm-cache: fix warnings about duplicate slab caches
Date: Fri,  6 Dec 2024 15:34:32 +0100
Message-ID: <20241206143711.064535878@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 346dbf1b1345476a6524512892cceb931bee3039 upstream.

The commit 4c39529663b9 adds a warning about duplicate cache names if
CONFIG_DEBUG_VM is selected. These warnings are triggered by the dm-cache
code.

The dm-cache code allocates a slab cache for each device. This commit
changes it to allocate just one slab cache in the module init function.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 4c39529663b9 ("slab: Warn on duplicate cache names when DEBUG_VM=y")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-cache-background-tracker.c |   25 ++++++-------------------
 drivers/md/dm-cache-background-tracker.h |    8 ++++++++
 drivers/md/dm-cache-target.c             |   25 ++++++++++++++++++++-----
 3 files changed, 34 insertions(+), 24 deletions(-)

--- a/drivers/md/dm-cache-background-tracker.c
+++ b/drivers/md/dm-cache-background-tracker.c
@@ -11,12 +11,6 @@
 
 #define DM_MSG_PREFIX "dm-background-tracker"
 
-struct bt_work {
-	struct list_head list;
-	struct rb_node node;
-	struct policy_work work;
-};
-
 struct background_tracker {
 	unsigned int max_work;
 	atomic_t pending_promotes;
@@ -26,10 +20,10 @@ struct background_tracker {
 	struct list_head issued;
 	struct list_head queued;
 	struct rb_root pending;
-
-	struct kmem_cache *work_cache;
 };
 
+struct kmem_cache *btracker_work_cache = NULL;
+
 struct background_tracker *btracker_create(unsigned int max_work)
 {
 	struct background_tracker *b = kmalloc(sizeof(*b), GFP_KERNEL);
@@ -48,12 +42,6 @@ struct background_tracker *btracker_crea
 	INIT_LIST_HEAD(&b->queued);
 
 	b->pending = RB_ROOT;
-	b->work_cache = KMEM_CACHE(bt_work, 0);
-	if (!b->work_cache) {
-		DMERR("couldn't create mempool for background work items");
-		kfree(b);
-		b = NULL;
-	}
 
 	return b;
 }
@@ -66,10 +54,9 @@ void btracker_destroy(struct background_
 	BUG_ON(!list_empty(&b->issued));
 	list_for_each_entry_safe (w, tmp, &b->queued, list) {
 		list_del(&w->list);
-		kmem_cache_free(b->work_cache, w);
+		kmem_cache_free(btracker_work_cache, w);
 	}
 
-	kmem_cache_destroy(b->work_cache);
 	kfree(b);
 }
 EXPORT_SYMBOL_GPL(btracker_destroy);
@@ -180,7 +167,7 @@ static struct bt_work *alloc_work(struct
 	if (max_work_reached(b))
 		return NULL;
 
-	return kmem_cache_alloc(b->work_cache, GFP_NOWAIT);
+	return kmem_cache_alloc(btracker_work_cache, GFP_NOWAIT);
 }
 
 int btracker_queue(struct background_tracker *b,
@@ -203,7 +190,7 @@ int btracker_queue(struct background_tra
 		 * There was a race, we'll just ignore this second
 		 * bit of work for the same oblock.
 		 */
-		kmem_cache_free(b->work_cache, w);
+		kmem_cache_free(btracker_work_cache, w);
 		return -EINVAL;
 	}
 
@@ -244,7 +231,7 @@ void btracker_complete(struct background
 	update_stats(b, &w->work, -1);
 	rb_erase(&w->node, &b->pending);
 	list_del(&w->list);
-	kmem_cache_free(b->work_cache, w);
+	kmem_cache_free(btracker_work_cache, w);
 }
 EXPORT_SYMBOL_GPL(btracker_complete);
 
--- a/drivers/md/dm-cache-background-tracker.h
+++ b/drivers/md/dm-cache-background-tracker.h
@@ -26,6 +26,14 @@
  * protected with a spinlock.
  */
 
+struct bt_work {
+	struct list_head list;
+	struct rb_node node;
+	struct policy_work work;
+};
+
+extern struct kmem_cache *btracker_work_cache;
+
 struct background_work;
 struct background_tracker;
 
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -10,6 +10,7 @@
 #include "dm-bio-record.h"
 #include "dm-cache-metadata.h"
 #include "dm-io-tracker.h"
+#include "dm-cache-background-tracker.h"
 
 #include <linux/dm-io.h>
 #include <linux/dm-kcopyd.h>
@@ -2267,7 +2268,7 @@ static int parse_cache_args(struct cache
 
 /*----------------------------------------------------------------*/
 
-static struct kmem_cache *migration_cache;
+static struct kmem_cache *migration_cache = NULL;
 
 #define NOT_CORE_OPTION 1
 
@@ -3455,22 +3456,36 @@ static int __init dm_cache_init(void)
 	int r;
 
 	migration_cache = KMEM_CACHE(dm_cache_migration, 0);
-	if (!migration_cache)
-		return -ENOMEM;
+	if (!migration_cache) {
+		r = -ENOMEM;
+		goto err;
+	}
+
+	btracker_work_cache = kmem_cache_create("dm_cache_bt_work",
+		sizeof(struct bt_work), __alignof__(struct bt_work), 0, NULL);
+	if (!btracker_work_cache) {
+		r = -ENOMEM;
+		goto err;
+	}
 
 	r = dm_register_target(&cache_target);
 	if (r) {
-		kmem_cache_destroy(migration_cache);
-		return r;
+		goto err;
 	}
 
 	return 0;
+
+err:
+	kmem_cache_destroy(migration_cache);
+	kmem_cache_destroy(btracker_work_cache);
+	return r;
 }
 
 static void __exit dm_cache_exit(void)
 {
 	dm_unregister_target(&cache_target);
 	kmem_cache_destroy(migration_cache);
+	kmem_cache_destroy(btracker_work_cache);
 }
 
 module_init(dm_cache_init);



