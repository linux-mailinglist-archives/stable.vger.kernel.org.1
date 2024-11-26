Return-Path: <stable+bounces-95535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 885459D9A64
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 16:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB3BDB2B665
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736531D47DC;
	Tue, 26 Nov 2024 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bM35mmQN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217AA1D45E5
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732634645; cv=none; b=fej4m9DjPfsKjIISjB4VEffNs/3rGLDpX6NsUNK/MVoi27qSZ1K9HiWjGtebfZTkuYMSZDUQPwvMy9TVBtTwUsXcosljVppUGwVQdu2NyU05yTQPManr+YrfLkhud7Pt3yuCm7+M4L54vdZtR5KsQfTRQ1JImcHzZq4Nx8MwxCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732634645; c=relaxed/simple;
	bh=69S/unKJG7P+RxflH8cMxSqFJ784XoadFDGX6RMg4ts=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=QvokNkD7BOk1P1Sn519CBDsw+42bS5g3yPm0CW10ijy6fyHaXEFVPnGrJ25OnbJbPK2k7uoGdtApyhVsHk2xDH70uSrIJB/kEIxF+ncZWfbw1eEeCmXUdErZg2kX/Ff8C7rysaCarz+FMqUsTj8WedVnA7iYWuJWBLyutVwKmNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bM35mmQN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732634642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=yqT1Jk+f7AUfcz8qWIbMt40hQ6rqyqmn/gpddJNHFQg=;
	b=bM35mmQNFvLroqRRe2lkraySHmF1cv7OJG/8NnfI9/goEm/wFCkZnZGsPE8+rswUv1IX8j
	DnYDOR8rQiEyqTPCnXRQBG5LvO6+5Z5VSAMbcfHVESYzE6NbJZG8inCLxFqLJ3jmNVqxPJ
	09IvJhazeTz9cpFgGYuF0K3YIeubme4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-sCixh-V1PRCF90YJ7Q8ZcQ-1; Tue,
 26 Nov 2024 10:23:58 -0500
X-MC-Unique: sCixh-V1PRCF90YJ7Q8ZcQ-1
X-Mimecast-MFC-AGG-ID: sCixh-V1PRCF90YJ7Q8ZcQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D25B51955EEA;
	Tue, 26 Nov 2024 15:23:57 +0000 (UTC)
Received: from [10.45.225.96] (unknown [10.45.225.96])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D82A196BC05;
	Tue, 26 Nov 2024 15:23:55 +0000 (UTC)
Date: Tue, 26 Nov 2024 16:23:53 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Sasha Levin <sashal@kernel.org>
cc: Matthew Sakai <msakai@redhat.com>, 
    Zdenek Kabelac <zdenek.kabelac@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] dm-cache: fix warnings about duplicate slab caches
Message-ID: <0492df60-836c-c13d-bdb6-53059ac3687c@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi

I submit this upstream patch for the stable branches 6.6 and 6.11.

Matthew Sakai from the DM-VDO team found out that there is a very narrow
race condition in the slub sysfs code and it could cause crashes if caches
with the same name are rapidly created and deleted. In order to work
around these crashes, we need to have unique slab cache names.

Mikulas



commit 346dbf1b1345476a6524512892cceb931bee3039
Author: Mikulas Patocka <mpatocka@redhat.com>
Date:   Mon Nov 11 16:51:02 2024 +0100

    dm-cache: fix warnings about duplicate slab caches
    
    The commit 4c39529663b9 adds a warning about duplicate cache names if
    CONFIG_DEBUG_VM is selected. These warnings are triggered by the dm-cache
    code.
    
    The dm-cache code allocates a slab cache for each device. This commit
    changes it to allocate just one slab cache in the module init function.
    
    Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
    Fixes: 4c39529663b9 ("slab: Warn on duplicate cache names when DEBUG_VM=y")

diff --git a/drivers/md/dm-cache-background-tracker.c b/drivers/md/dm-cache-background-tracker.c
index 9c5308298cf1..f3051bd7d2df 100644
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
@@ -48,12 +42,6 @@ struct background_tracker *btracker_create(unsigned int max_work)
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
@@ -66,10 +54,9 @@ void btracker_destroy(struct background_tracker *b)
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
@@ -180,7 +167,7 @@ static struct bt_work *alloc_work(struct background_tracker *b)
 	if (max_work_reached(b))
 		return NULL;
 
-	return kmem_cache_alloc(b->work_cache, GFP_NOWAIT);
+	return kmem_cache_alloc(btracker_work_cache, GFP_NOWAIT);
 }
 
 int btracker_queue(struct background_tracker *b,
@@ -203,7 +190,7 @@ int btracker_queue(struct background_tracker *b,
 		 * There was a race, we'll just ignore this second
 		 * bit of work for the same oblock.
 		 */
-		kmem_cache_free(b->work_cache, w);
+		kmem_cache_free(btracker_work_cache, w);
 		return -EINVAL;
 	}
 
@@ -244,7 +231,7 @@ void btracker_complete(struct background_tracker *b,
 	update_stats(b, &w->work, -1);
 	rb_erase(&w->node, &b->pending);
 	list_del(&w->list);
-	kmem_cache_free(b->work_cache, w);
+	kmem_cache_free(btracker_work_cache, w);
 }
 EXPORT_SYMBOL_GPL(btracker_complete);
 
diff --git a/drivers/md/dm-cache-background-tracker.h b/drivers/md/dm-cache-background-tracker.h
index 5b8f5c667b81..09c8fc59f7bb 100644
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
 
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 40709310e327..849eb6333e98 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -10,6 +10,7 @@
 #include "dm-bio-record.h"
 #include "dm-cache-metadata.h"
 #include "dm-io-tracker.h"
+#include "dm-cache-background-tracker.h"
 
 #include <linux/dm-io.h>
 #include <linux/dm-kcopyd.h>
@@ -2263,7 +2264,7 @@ static int parse_cache_args(struct cache_args *ca, int argc, char **argv,
 
 /*----------------------------------------------------------------*/
 
-static struct kmem_cache *migration_cache;
+static struct kmem_cache *migration_cache = NULL;
 
 #define NOT_CORE_OPTION 1
 
@@ -3445,22 +3446,36 @@ static int __init dm_cache_init(void)
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


