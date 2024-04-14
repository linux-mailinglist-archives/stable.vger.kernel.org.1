Return-Path: <stable+bounces-37312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C90589C454
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B5A1F21F4E
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0577EF03;
	Mon,  8 Apr 2024 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jMP8YL8o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE617E105;
	Mon,  8 Apr 2024 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583864; cv=none; b=L3yKo3LgvqgcIn3qfybf1Atb2tdkjZ1aPEh/RCktl3LqM5u6YVNS4IO8Adyom05IH3vNSbrvDm4yokMNMKiA8Rmf1cQqd2fmlc2LPjlV7JACzlAw6F9cjqWcyeXlE8pYHakGe4alw7gGuDwg6ziVTmGMpLA668Cbev0/HLbGfkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583864; c=relaxed/simple;
	bh=nKO7dUSLCQt/w5yvQ09Rm7q6VVeK4vGtJeEVg+DcivQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQ4kt2yZ56DMy5ahjuh0/S+RdG9KOSG9AUP6EG35KOVtYa5uOvINHOvAwgKsqwGIya0zPXTi4UtDowcqwxWfenH3VrCOiZkd9HR1qX6l+PSimLq4p9Cz8Yt3zFwc2Aoz2b1pzvZxw7awboGn3YoVmev22OuxukQvmKWayUrrPPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jMP8YL8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CBCC43390;
	Mon,  8 Apr 2024 13:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583864;
	bh=nKO7dUSLCQt/w5yvQ09Rm7q6VVeK4vGtJeEVg+DcivQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jMP8YL8o+A2KUV3fgIE01J53QQmGt+QoYyu9V+Ct85ZowLt9lNrW1BG0/6xjZIBQf
	 9wkHFeQbhFeIGSY7IwDr86MljSMwamQHCM8Q7uxgT5wyPBADLZjqH/BRWJjHdtq4z2
	 WyiTSiX52ANtethFlu/gXShyb+Yu+3ARiPZIBTRg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Saravana Kannan <saravanak@google.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 6.8 228/273] driver core: Introduce device_link_wait_removal()
Date: Mon,  8 Apr 2024 14:58:23 +0200
Message-ID: <20240408125316.499562512@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herve Codina <herve.codina@bootlin.com>

commit 0462c56c290a99a7f03e817ae5b843116dfb575c upstream.

The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
introduces a workqueue to release the consumer and supplier devices used
in the devlink.
In the job queued, devices are release and in turn, when all the
references to these devices are dropped, the release function of the
device itself is called.

Nothing is present to provide some synchronisation with this workqueue
in order to ensure that all ongoing releasing operations are done and
so, some other operations can be started safely.

For instance, in the following sequence:
  1) of_platform_depopulate()
  2) of_overlay_remove()

During the step 1, devices are released and related devlinks are removed
(jobs pushed in the workqueue).
During the step 2, OF nodes are destroyed but, without any
synchronisation with devlink removal jobs, of_overlay_remove() can raise
warnings related to missing of_node_put():
  ERROR: memory leak, expected refcount 1 instead of 2

Indeed, the missing of_node_put() call is going to be done, too late,
from the workqueue job execution.

Introduce device_link_wait_removal() to offer a way to synchronize
operations waiting for the end of devlink removals (i.e. end of
workqueue jobs).
Also, as a flushing operation is done on the workqueue, the workqueue
used is moved from a system-wide workqueue to a local one.

Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: Saravana Kannan <saravanak@google.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20240325152140.198219-2-herve.codina@bootlin.com
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c    |   26 +++++++++++++++++++++++---
 include/linux/device.h |    1 +
 2 files changed, 24 insertions(+), 3 deletions(-)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -44,6 +44,7 @@ static bool fw_devlink_is_permissive(voi
 static void __fw_devlink_link_to_consumers(struct device *dev);
 static bool fw_devlink_drv_reg_done;
 static bool fw_devlink_best_effort;
+static struct workqueue_struct *device_link_wq;
 
 /**
  * __fwnode_link_add - Create a link between two fwnode_handles.
@@ -532,12 +533,26 @@ static void devlink_dev_release(struct d
 	/*
 	 * It may take a while to complete this work because of the SRCU
 	 * synchronization in device_link_release_fn() and if the consumer or
-	 * supplier devices get deleted when it runs, so put it into the "long"
-	 * workqueue.
+	 * supplier devices get deleted when it runs, so put it into the
+	 * dedicated workqueue.
 	 */
-	queue_work(system_long_wq, &link->rm_work);
+	queue_work(device_link_wq, &link->rm_work);
 }
 
+/**
+ * device_link_wait_removal - Wait for ongoing devlink removal jobs to terminate
+ */
+void device_link_wait_removal(void)
+{
+	/*
+	 * devlink removal jobs are queued in the dedicated work queue.
+	 * To be sure that all removal jobs are terminated, ensure that any
+	 * scheduled work has run to completion.
+	 */
+	flush_workqueue(device_link_wq);
+}
+EXPORT_SYMBOL_GPL(device_link_wait_removal);
+
 static struct class devlink_class = {
 	.name = "devlink",
 	.dev_groups = devlink_groups,
@@ -4098,9 +4113,14 @@ int __init devices_init(void)
 	sysfs_dev_char_kobj = kobject_create_and_add("char", dev_kobj);
 	if (!sysfs_dev_char_kobj)
 		goto char_kobj_err;
+	device_link_wq = alloc_workqueue("device_link_wq", 0, 0);
+	if (!device_link_wq)
+		goto wq_err;
 
 	return 0;
 
+ wq_err:
+	kobject_put(sysfs_dev_char_kobj);
  char_kobj_err:
 	kobject_put(sysfs_dev_block_kobj);
  block_kobj_err:
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1247,6 +1247,7 @@ void device_link_del(struct device_link
 void device_link_remove(void *consumer, struct device *supplier);
 void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
+void device_link_wait_removal(void);
 
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \



