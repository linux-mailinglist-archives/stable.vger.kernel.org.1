Return-Path: <stable+bounces-2119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251067F82DA
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52D628650C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5448381BF;
	Fri, 24 Nov 2023 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sRNAc20T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797FF364AE;
	Fri, 24 Nov 2023 19:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099BFC433C7;
	Fri, 24 Nov 2023 19:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853095;
	bh=wJW1jU1f3TDf0bUWOkciCyJ1azzp/lRpaaDTi2e9hrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sRNAc20TgrPBUXb2rhyYR8EgLdsKOCzkVdeOUmBUedgTnQAHIxXlKbfpwN74RGcMR
	 abSXfTnLg7o+B4PLf1CIj3gYTyjaaqlRfzyKZNJ2VgybiyAYWYwJOpTsnbHhhMQLzy
	 2I6nKFBAyRnnzk+0hohqHzvY8edLmpj0Behbn0XM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ZhengHan Wang <wzhmmmmm@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 017/297] Bluetooth: Fix double free in hci_conn_cleanup
Date: Fri, 24 Nov 2023 17:50:59 +0000
Message-ID: <20231124172000.697477044@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 5f1e388c2b951..ce538dbe89d13 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -135,13 +135,11 @@ static void hci_conn_cleanup(struct hci_conn *conn)
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
 
 static void le_scan_cleanup(struct work_struct *work)
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 08542dfc2dc53..633b82d542728 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -33,7 +33,7 @@ void hci_conn_init_sysfs(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	conn->dev.type = &bt_link;
 	conn->dev.class = bt_class;
@@ -46,27 +46,30 @@ void hci_conn_add_sysfs(struct hci_conn *conn)
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
@@ -78,9 +81,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
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




