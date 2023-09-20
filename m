Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9A27A77F0
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 11:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjITJvy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 05:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbjITJvx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 05:51:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE019E
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 02:51:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02416C433C7;
        Wed, 20 Sep 2023 09:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695203500;
        bh=pstjqN73Icn3DFPC6yWiS2Oz9m7/j7IxrIQzY2YXsu8=;
        h=Subject:To:Cc:From:Date:From;
        b=C4ZJP9rfB6QB/bE26q1OcTXHPbbD3v+RpocL64z5mZw4XGAl7B77A7wgc8qHzNo1/
         +gYQ7o4HnATD+Xs9fsGYfaMgDySYJefn0op1mxzEBtD9030d8viRqzK9D0lbO9fdQZ
         BsK5lBCknpZXPfzzrPriycv068+tIQuUJFDLwk8I=
Subject: FAILED: patch "[PATCH] dm: fix a race condition in retrieve_deps" failed to apply to 6.1-stable tree
To:     mpatocka@redhat.com, lilingfeng3@huawei.com, luomeng12@huawei.com,
        snitzer@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 11:51:38 +0200
Message-ID: <2023092038-jingle-defuse-c9fa@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f6007dce0cd35d634d9be91ef3515a6385dcee16
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023092038-jingle-defuse-c9fa@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

f6007dce0cd3 ("dm: fix a race condition in retrieve_deps")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f6007dce0cd35d634d9be91ef3515a6385dcee16 Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 9 Aug 2023 12:44:20 +0200
Subject: [PATCH] dm: fix a race condition in retrieve_deps

There's a race condition in the multipath target when retrieve_deps
races with multipath_message calling dm_get_device and dm_put_device.
retrieve_deps walks the list of open devices without holding any lock
but multipath may add or remove devices to the list while it is
running. The end result may be memory corruption or use-after-free
memory access.

See this description of a UAF with multipath_message():
https://listman.redhat.com/archives/dm-devel/2022-October/052373.html

Fix this bug by introducing a new rw semaphore "devices_lock". We grab
devices_lock for read in retrieve_deps and we grab it for write in
dm_get_device and dm_put_device.

Reported-by: Luo Meng <luomeng12@huawei.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Tested-by: Li Lingfeng <lilingfeng3@huawei.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 0d93661f88d3..095b9b49aa82 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -214,6 +214,7 @@ struct dm_table {
 
 	/* a list of devices used by this table */
 	struct list_head devices;
+	struct rw_semaphore devices_lock;
 
 	/* events get handed up using this callback */
 	void (*event_fn)(void *data);
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index f5ed729a8e0c..21ebb6c39394 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1630,6 +1630,8 @@ static void retrieve_deps(struct dm_table *table,
 	struct dm_dev_internal *dd;
 	struct dm_target_deps *deps;
 
+	down_read(&table->devices_lock);
+
 	deps = get_result_buffer(param, param_size, &len);
 
 	/*
@@ -1644,7 +1646,7 @@ static void retrieve_deps(struct dm_table *table,
 	needed = struct_size(deps, dev, count);
 	if (len < needed) {
 		param->flags |= DM_BUFFER_FULL_FLAG;
-		return;
+		goto out;
 	}
 
 	/*
@@ -1656,6 +1658,9 @@ static void retrieve_deps(struct dm_table *table,
 		deps->dev[count++] = huge_encode_dev(dd->dm_dev->bdev->bd_dev);
 
 	param->data_size = param->data_start + needed;
+
+out:
+	up_read(&table->devices_lock);
 }
 
 static int table_deps(struct file *filp, struct dm_ioctl *param, size_t param_size)
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 7d208b2b1a19..37b48f63ae6a 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -135,6 +135,7 @@ int dm_table_create(struct dm_table **result, blk_mode_t mode,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&t->devices);
+	init_rwsem(&t->devices_lock);
 
 	if (!num_targets)
 		num_targets = KEYS_PER_NODE;
@@ -359,16 +360,20 @@ int __ref dm_get_device(struct dm_target *ti, const char *path, blk_mode_t mode,
 	if (dev == disk_devt(t->md->disk))
 		return -EINVAL;
 
+	down_write(&t->devices_lock);
+
 	dd = find_device(&t->devices, dev);
 	if (!dd) {
 		dd = kmalloc(sizeof(*dd), GFP_KERNEL);
-		if (!dd)
-			return -ENOMEM;
+		if (!dd) {
+			r = -ENOMEM;
+			goto unlock_ret_r;
+		}
 
 		r = dm_get_table_device(t->md, dev, mode, &dd->dm_dev);
 		if (r) {
 			kfree(dd);
-			return r;
+			goto unlock_ret_r;
 		}
 
 		refcount_set(&dd->count, 1);
@@ -378,12 +383,17 @@ int __ref dm_get_device(struct dm_target *ti, const char *path, blk_mode_t mode,
 	} else if (dd->dm_dev->mode != (mode | dd->dm_dev->mode)) {
 		r = upgrade_mode(dd, mode, t->md);
 		if (r)
-			return r;
+			goto unlock_ret_r;
 	}
 	refcount_inc(&dd->count);
 out:
+	up_write(&t->devices_lock);
 	*result = dd->dm_dev;
 	return 0;
+
+unlock_ret_r:
+	up_write(&t->devices_lock);
+	return r;
 }
 EXPORT_SYMBOL(dm_get_device);
 
@@ -419,9 +429,12 @@ static int dm_set_device_limits(struct dm_target *ti, struct dm_dev *dev,
 void dm_put_device(struct dm_target *ti, struct dm_dev *d)
 {
 	int found = 0;
-	struct list_head *devices = &ti->table->devices;
+	struct dm_table *t = ti->table;
+	struct list_head *devices = &t->devices;
 	struct dm_dev_internal *dd;
 
+	down_write(&t->devices_lock);
+
 	list_for_each_entry(dd, devices, list) {
 		if (dd->dm_dev == d) {
 			found = 1;
@@ -430,14 +443,17 @@ void dm_put_device(struct dm_target *ti, struct dm_dev *d)
 	}
 	if (!found) {
 		DMERR("%s: device %s not in table devices list",
-		      dm_device_name(ti->table->md), d->name);
-		return;
+		      dm_device_name(t->md), d->name);
+		goto unlock_ret;
 	}
 	if (refcount_dec_and_test(&dd->count)) {
-		dm_put_table_device(ti->table->md, d);
+		dm_put_table_device(t->md, d);
 		list_del(&dd->list);
 		kfree(dd);
 	}
+
+unlock_ret:
+	up_write(&t->devices_lock);
 }
 EXPORT_SYMBOL(dm_put_device);
 

