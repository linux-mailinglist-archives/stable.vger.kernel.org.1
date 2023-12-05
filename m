Return-Path: <stable+bounces-4342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12CC804718
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DCF4B20CAE
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661A58BF2;
	Tue,  5 Dec 2023 03:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="meHmXUld"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207FA6FB1;
	Tue,  5 Dec 2023 03:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1DCC433C7;
	Tue,  5 Dec 2023 03:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747286;
	bh=BjvYX6KDqM4I7KHlzJabeRTrE9mRF9i79UJv7XMB2xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=meHmXUldDVARn0/6EtbmkADLsi5ynpc0it+bWX8WQEzghM0E6ynxzKFbmWPAq+xiS
	 1Vp+hF4YS1Vs8sVj2pWDUfWWRF6WTS8jv4GHdhWLpqX6IoVHFhRTkTuu+9uJZ8G8o0
	 JbzuP8cFnBnib8mBrSZliW4af7fkREVam80GKrJg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charles Yi <be286@163.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 020/135] HID: fix HID device resource race between HID core and debugging support
Date: Tue,  5 Dec 2023 12:15:41 +0900
Message-ID: <20231205031531.841933588@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031530.557782248@linuxfoundation.org>
References: <20231205031530.557782248@linuxfoundation.org>
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

From: Charles Yi <be286@163.com>

[ Upstream commit fc43e9c857b7aa55efba9398419b14d9e35dcc7d ]

hid_debug_events_release releases resources bound to the HID device instance.
hid_device_release releases the underlying HID device instance potentially
before hid_debug_events_release has completed releasing debug resources bound
to the same HID device instance.

Reference count to prevent the HID device instance from being torn down
preemptively when HID debugging support is used. When count reaches zero,
release core resources of HID device instance using hiddev_free.

The crash:

[  120.728477][ T4396] kernel BUG at lib/list_debug.c:53!
[  120.728505][ T4396] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[  120.739806][ T4396] Modules linked in: bcmdhd dhd_static_buf 8822cu pcie_mhi r8168
[  120.747386][ T4396] CPU: 1 PID: 4396 Comm: hidt_bridge Not tainted 5.10.110 #257
[  120.754771][ T4396] Hardware name: Rockchip RK3588 EVB4 LP4 V10 Board (DT)
[  120.761643][ T4396] pstate: 60400089 (nZCv daIf +PAN -UAO -TCO BTYPE=--)
[  120.768338][ T4396] pc : __list_del_entry_valid+0x98/0xac
[  120.773730][ T4396] lr : __list_del_entry_valid+0x98/0xac
[  120.779120][ T4396] sp : ffffffc01e62bb60
[  120.783126][ T4396] x29: ffffffc01e62bb60 x28: ffffff818ce3a200
[  120.789126][ T4396] x27: 0000000000000009 x26: 0000000000980000
[  120.795126][ T4396] x25: ffffffc012431000 x24: ffffff802c6d4e00
[  120.801125][ T4396] x23: ffffff8005c66f00 x22: ffffffc01183b5b8
[  120.807125][ T4396] x21: ffffff819df2f100 x20: 0000000000000000
[  120.813124][ T4396] x19: ffffff802c3f0700 x18: ffffffc01d2cd058
[  120.819124][ T4396] x17: 0000000000000000 x16: 0000000000000000
[  120.825124][ T4396] x15: 0000000000000004 x14: 0000000000003fff
[  120.831123][ T4396] x13: ffffffc012085588 x12: 0000000000000003
[  120.837123][ T4396] x11: 00000000ffffbfff x10: 0000000000000003
[  120.843123][ T4396] x9 : 455103d46b329300 x8 : 455103d46b329300
[  120.849124][ T4396] x7 : 74707572726f6320 x6 : ffffffc0124b8cb5
[  120.855124][ T4396] x5 : ffffffffffffffff x4 : 0000000000000000
[  120.861123][ T4396] x3 : ffffffc011cf4f90 x2 : ffffff81fee7b948
[  120.867122][ T4396] x1 : ffffffc011cf4f90 x0 : 0000000000000054
[  120.873122][ T4396] Call trace:
[  120.876259][ T4396]  __list_del_entry_valid+0x98/0xac
[  120.881304][ T4396]  hid_debug_events_release+0x48/0x12c
[  120.886617][ T4396]  full_proxy_release+0x50/0xbc
[  120.891323][ T4396]  __fput+0xdc/0x238
[  120.895075][ T4396]  ____fput+0x14/0x24
[  120.898911][ T4396]  task_work_run+0x90/0x148
[  120.903268][ T4396]  do_exit+0x1bc/0x8a4
[  120.907193][ T4396]  do_group_exit+0x8c/0xa4
[  120.911458][ T4396]  get_signal+0x468/0x744
[  120.915643][ T4396]  do_signal+0x84/0x280
[  120.919650][ T4396]  do_notify_resume+0xd0/0x218
[  120.924262][ T4396]  work_pending+0xc/0x3f0

[ Rahul Rameshbabu <sergeantsagara@protonmail.com>: rework changelog ]
Fixes: cd667ce24796 ("HID: use debugfs for events/reports dumping")
Signed-off-by: Charles Yi <be286@163.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-core.c  | 12 ++++++++++--
 drivers/hid/hid-debug.c |  3 +++
 include/linux/hid.h     |  3 +++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index ab3bca4d5ad2b..476967ab6294c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -702,15 +702,22 @@ static void hid_close_report(struct hid_device *device)
  * Free a device structure, all reports, and all fields.
  */
 
-static void hid_device_release(struct device *dev)
+void hiddev_free(struct kref *ref)
 {
-	struct hid_device *hid = to_hid_device(dev);
+	struct hid_device *hid = container_of(ref, struct hid_device, ref);
 
 	hid_close_report(hid);
 	kfree(hid->dev_rdesc);
 	kfree(hid);
 }
 
+static void hid_device_release(struct device *dev)
+{
+	struct hid_device *hid = to_hid_device(dev);
+
+	kref_put(&hid->ref, hiddev_free);
+}
+
 /*
  * Fetch a report description item from the data stream. We support long
  * items, though they are not used yet.
@@ -2492,6 +2499,7 @@ struct hid_device *hid_allocate_device(void)
 	spin_lock_init(&hdev->debug_list_lock);
 	sema_init(&hdev->driver_input_lock, 1);
 	mutex_init(&hdev->ll_open_lock);
+	kref_init(&hdev->ref);
 
 	return hdev;
 }
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 1f60a381ae63e..81da80f0c75b5 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1082,6 +1082,7 @@ static int hid_debug_events_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 	list->hdev = (struct hid_device *) inode->i_private;
+	kref_get(&list->hdev->ref);
 	file->private_data = list;
 	mutex_init(&list->read_mutex);
 
@@ -1174,6 +1175,8 @@ static int hid_debug_events_release(struct inode *inode, struct file *file)
 	list_del(&list->node);
 	spin_unlock_irqrestore(&list->hdev->debug_list_lock, flags);
 	kfifo_free(&list->hid_debug_fifo);
+
+	kref_put(&list->hdev->ref, hiddev_free);
 	kfree(list);
 
 	return 0;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 7818dbafab0f7..9e306bf9959df 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -624,10 +624,13 @@ struct hid_device {							/* device report descriptor */
 	struct list_head debug_list;
 	spinlock_t  debug_list_lock;
 	wait_queue_head_t debug_wait;
+	struct kref			ref;
 
 	unsigned int id;						/* system unique id */
 };
 
+void hiddev_free(struct kref *ref);
+
 #define to_hid_device(pdev) \
 	container_of(pdev, struct hid_device, dev)
 
-- 
2.42.0




