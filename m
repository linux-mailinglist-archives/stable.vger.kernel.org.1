Return-Path: <stable+bounces-1040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40167F7DB6
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D001C212E5
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0BF39FF7;
	Fri, 24 Nov 2023 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E9jOFDx3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE88039FC3;
	Fri, 24 Nov 2023 18:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD82C433C7;
	Fri, 24 Nov 2023 18:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850409;
	bh=UdjcWrTLr5mvAlCd8L280mvEDUfU2GdZeo7GzsW4ykc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E9jOFDx3LZiF+rx/zPXVhfVW8RL+Y9SbPWe3jn6ZbKDafyJYpOLqLyogiuqFRUyz0
	 Zh8YelVu3AEyGIbUgyBhBsIrsRkwmO0ya+2ojOIVgBULVOg49cRo5OCKxQSN0z7boZ
	 j43LcKD5TjDqFOJh3hcurA0O9aoN0uyY0xqzUx4Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ZhengHan Wang <wzhmmmmm@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 038/491] Bluetooth: Fix double free in hci_conn_cleanup
Date: Fri, 24 Nov 2023 17:44:34 +0000
Message-ID: <20231124172025.836877488@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ZhengHan Wang <wzhmmmmm@gmail.com>

[ Upstream commit a85fb91e3d728bdfc80833167e8162cce8bc7004 ]

syzbot reports a slab use-after-free in hci_conn_hash_flush [1].
After releasing an object using hci_conn_del_sysfs in the
hci_conn_cleanup function, releasing the same object again
using the hci_dev_put and hci_conn_put functions causes a double free.
Here's a simplified flow:

hci_conn_del_sysfs:
  hci_dev_put
    put_device
      kobject_put
        kref_put
          kobject_release
            kobject_cleanup
              kfree_const
                kfree(name)

hci_dev_put:
  ...
    kfree(name)

hci_conn_put:
  put_device
    ...
      kfree(name)

This patch drop the hci_dev_put and hci_conn_put function
call in hci_conn_cleanup function, because the object is
freed in hci_conn_del_sysfs function.

This patch also fixes the refcounting in hci_conn_add_sysfs() and
hci_conn_del_sysfs() to take into account device_add() failures.

This fixes CVE-2023-28464.

Link: https://syzkaller.appspot.com/bug?id=1bb51491ca5df96a5f724899d1dbb87afda61419 [1]

Signed-off-by: ZhengHan Wang <wzhmmmmm@gmail.com>
Co-developed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_conn.c  |  6 ++----
 net/bluetooth/hci_sysfs.c | 23 ++++++++++++-----------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4e03642488230..c090627ff9751 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -172,13 +172,11 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 			hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
 	}
 
-	hci_conn_del_sysfs(conn);
-
 	debugfs_remove_recursive(conn->debugfs);
 
-	hci_dev_put(hdev);
+	hci_conn_del_sysfs(conn);
 
-	hci_conn_put(conn);
+	hci_dev_put(hdev);
 }
 
 static void hci_acl_create_connection(struct hci_conn *conn)
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 15b33579007cb..367e32fe30eb8 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -35,7 +35,7 @@ void hci_conn_init_sysfs(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	conn->dev.type = &bt_link;
 	conn->dev.class = &bt_class;
@@ -48,27 +48,30 @@ void hci_conn_add_sysfs(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	if (device_is_registered(&conn->dev))
 		return;
 
 	dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->handle);
 
-	if (device_add(&conn->dev) < 0) {
+	if (device_add(&conn->dev) < 0)
 		bt_dev_err(hdev, "failed to register connection device");
-		return;
-	}
-
-	hci_dev_hold(hdev);
 }
 
 void hci_conn_del_sysfs(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	if (!device_is_registered(&conn->dev))
+	bt_dev_dbg(hdev, "conn %p", conn);
+
+	if (!device_is_registered(&conn->dev)) {
+		/* If device_add() has *not* succeeded, use *only* put_device()
+		 * to drop the reference count.
+		 */
+		put_device(&conn->dev);
 		return;
+	}
 
 	while (1) {
 		struct device *dev;
@@ -80,9 +83,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
 		put_device(dev);
 	}
 
-	device_del(&conn->dev);
-
-	hci_dev_put(hdev);
+	device_unregister(&conn->dev);
 }
 
 static void bt_host_release(struct device *dev)
-- 
2.42.0




