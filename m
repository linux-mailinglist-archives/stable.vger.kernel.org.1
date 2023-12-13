Return-Path: <stable+bounces-5949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB64B80D801
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7211C209CB
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C4852F60;
	Mon, 11 Dec 2023 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kjcLFTwb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70551D696;
	Mon, 11 Dec 2023 18:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC9BC433C8;
	Mon, 11 Dec 2023 18:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320101;
	bh=cXpSMEvtKsa2Te9e8cqtH/rObwSHUKOjBVdUQ9gDvvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjcLFTwbnQITleV074B25eK8GIKhSdZ4aYi+/iiyKPHv68HbVfgSMVS8gf9FigeHX
	 2gYL56PG/KuZeOH5FGCxgZtGWNMyfMJVUB64Yo3Lr9Uo58mUzkliU0dHonqoMgouW1
	 qWdJIRkLi3VWxYoIdo4fOoEG4kkgWKAOC+9RBBzU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 95/97] devcoredump : Serialize devcd_del work
Date: Mon, 11 Dec 2023 19:22:38 +0100
Message-ID: <20231211182023.905295581@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182019.802717483@linuxfoundation.org>
References: <20231211182019.802717483@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mukesh Ojha <quic_mojha@quicinc.com>

[ Upstream commit 01daccf748323dfc61112f474cf2ba81015446b0 ]

In following scenario(diagram), when one thread X running dev_coredumpm()
adds devcd device to the framework which sends uevent notification to
userspace and another thread Y reads this uevent and call to
devcd_data_write() which eventually try to delete the queued timer that
is not initialized/queued yet.

So, debug object reports some warning and in the meantime, timer is
initialized and queued from X path. and from Y path, it gets reinitialized
again and timer->entry.pprev=NULL and try_to_grab_pending() stucks.

To fix this, introduce mutex and a boolean flag to serialize the behaviour.

 	cpu0(X)			                cpu1(Y)

    dev_coredump() uevent sent to user space
    device_add()  ======================> user space process Y reads the
                                          uevents writes to devcd fd
                                          which results into writes to

                                         devcd_data_write()
                                           mod_delayed_work()
                                             try_to_grab_pending()
                                               del_timer()
                                                 debug_assert_init()
   INIT_DELAYED_WORK()
   schedule_delayed_work()
                                                   debug_object_fixup()
                                                     timer_fixup_assert_init()
                                                       timer_setup()
                                                         do_init_timer()
                                                       /*
                                                        Above call reinitializes
                                                        the timer to
                                                        timer->entry.pprev=NULL
                                                        and this will be checked
                                                        later in timer_pending() call.
                                                       */
                                                 timer_pending()
                                                  !hlist_unhashed_lockless(&timer->entry)
                                                    !h->pprev
                                                /*
                                                  del_timer() checks h->pprev and finds
                                                  it to be NULL due to which
                                                  try_to_grab_pending() stucks.
                                                */

Link: https://lore.kernel.org/lkml/2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com/
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Link: https://lore.kernel.org/r/1663073424-13663-1-git-send-email-quic_mojha@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: af54d778a038 ("devcoredump: Send uevent once devcd is ready")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/devcoredump.c | 83 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 9243468e2c99f..ef23c1c33eb2c 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -29,6 +29,47 @@ struct devcd_entry {
 	struct device devcd_dev;
 	void *data;
 	size_t datalen;
+	/*
+	 * Here, mutex is required to serialize the calls to del_wk work between
+	 * user/kernel space which happens when devcd is added with device_add()
+	 * and that sends uevent to user space. User space reads the uevents,
+	 * and calls to devcd_data_write() which try to modify the work which is
+	 * not even initialized/queued from devcoredump.
+	 *
+	 *
+	 *
+	 *        cpu0(X)                                 cpu1(Y)
+	 *
+	 *        dev_coredump() uevent sent to user space
+	 *        device_add()  ======================> user space process Y reads the
+	 *                                              uevents writes to devcd fd
+	 *                                              which results into writes to
+	 *
+	 *                                             devcd_data_write()
+	 *                                               mod_delayed_work()
+	 *                                                 try_to_grab_pending()
+	 *                                                   del_timer()
+	 *                                                     debug_assert_init()
+	 *       INIT_DELAYED_WORK()
+	 *       schedule_delayed_work()
+	 *
+	 *
+	 * Also, mutex alone would not be enough to avoid scheduling of
+	 * del_wk work after it get flush from a call to devcd_free()
+	 * mentioned as below.
+	 *
+	 *	disabled_store()
+	 *        devcd_free()
+	 *          mutex_lock()             devcd_data_write()
+	 *          flush_delayed_work()
+	 *          mutex_unlock()
+	 *                                   mutex_lock()
+	 *                                   mod_delayed_work()
+	 *                                   mutex_unlock()
+	 * So, delete_work flag is required.
+	 */
+	struct mutex mutex;
+	bool delete_work;
 	struct module *owner;
 	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
 			void *data, size_t datalen);
@@ -88,7 +129,12 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
-	mod_delayed_work(system_wq, &devcd->del_wk, 0);
+	mutex_lock(&devcd->mutex);
+	if (!devcd->delete_work) {
+		devcd->delete_work = true;
+		mod_delayed_work(system_wq, &devcd->del_wk, 0);
+	}
+	mutex_unlock(&devcd->mutex);
 
 	return count;
 }
@@ -116,7 +162,12 @@ static int devcd_free(struct device *dev, void *data)
 {
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
+	mutex_lock(&devcd->mutex);
+	if (!devcd->delete_work)
+		devcd->delete_work = true;
+
 	flush_delayed_work(&devcd->del_wk);
+	mutex_unlock(&devcd->mutex);
 	return 0;
 }
 
@@ -126,6 +177,30 @@ static ssize_t disabled_show(struct class *class, struct class_attribute *attr,
 	return sysfs_emit(buf, "%d\n", devcd_disabled);
 }
 
+/*
+ *
+ *	disabled_store()                                	worker()
+ *	 class_for_each_device(&devcd_class,
+ *		NULL, NULL, devcd_free)
+ *         ...
+ *         ...
+ *	   while ((dev = class_dev_iter_next(&iter))
+ *                                                             devcd_del()
+ *                                                               device_del()
+ *                                                                 put_device() <- last reference
+ *             error = fn(dev, data)                           devcd_dev_release()
+ *             devcd_free(dev, data)                           kfree(devcd)
+ *             mutex_lock(&devcd->mutex);
+ *
+ *
+ * In the above diagram, It looks like disabled_store() would be racing with parallely
+ * running devcd_del() and result in memory abort while acquiring devcd->mutex which
+ * is called after kfree of devcd memory  after dropping its last reference with
+ * put_device(). However, this will not happens as fn(dev, data) runs
+ * with its own reference to device via klist_node so it is not its last reference.
+ * so, above situation would not occur.
+ */
+
 static ssize_t disabled_store(struct class *class, struct class_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -282,13 +357,16 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	devcd->read = read;
 	devcd->free = free;
 	devcd->failing_dev = get_device(dev);
+	devcd->delete_work = false;
 
+	mutex_init(&devcd->mutex);
 	device_initialize(&devcd->devcd_dev);
 
 	dev_set_name(&devcd->devcd_dev, "devcd%d",
 		     atomic_inc_return(&devcd_count));
 	devcd->devcd_dev.class = &devcd_class;
 
+	mutex_lock(&devcd->mutex);
 	if (device_add(&devcd->devcd_dev))
 		goto put_device;
 
@@ -302,10 +380,11 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 
 	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
 	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
-
+	mutex_unlock(&devcd->mutex);
 	return;
  put_device:
 	put_device(&devcd->devcd_dev);
+	mutex_unlock(&devcd->mutex);
  put_module:
 	module_put(owner);
  free:
-- 
2.42.0




