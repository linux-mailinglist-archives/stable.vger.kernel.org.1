Return-Path: <stable+bounces-75278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4974F9733C3
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDC91C24E1C
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF55199254;
	Tue, 10 Sep 2024 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wO5uZ5/f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B9A1552FD;
	Tue, 10 Sep 2024 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964268; cv=none; b=P7Vn+5pVK//4X1utNTkXzaGzaY5fw07BxM5Yga1v26NtV1lu9dNL2uSSgHFQCnJx3meJHM+c/oID2Tng/qC39NtIPjv5BaeGBGnULr+i2XiTdtjxJQ2/tQ1vw66R65n22mNIf3vhYDYOG7XwvptosGCjpjbrS2bNKoNS3/QnSfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964268; c=relaxed/simple;
	bh=bl6C0dPzJVQsmqR8Gx97/FHfNjKXYlpNDBqV9tmqId4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2iP2Qn9i8sMkJJtmeKEywtTBmuKxVnwRIp98uutu9ftfGq5U47LjpJ9qEobwDU3sicMjWjaeUCKdmcH2iZ8h3vVy6gAh9UO5fUEndbBGszpMvUZhFpt74jOxOZw1pgqF8w+tVf5UNpS4FCfVTCYOoVqBuFkkayEL+HeWMJezEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wO5uZ5/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C98C4CEC3;
	Tue, 10 Sep 2024 10:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964267;
	bh=bl6C0dPzJVQsmqR8Gx97/FHfNjKXYlpNDBqV9tmqId4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wO5uZ5/fhE0acu1uz8+r7vbNxqTV06ywDRqd6QBkvTMezWyubBEAL02p7fSKoyjqm
	 nAYWPTzLcXicsVJOSV753mB2GLkhLqyuxa+u0oqwqrHrYivvvEmKvcnsBXVsBzDCFi
	 L9WcD0PYXfB9ujRad8K7HLuIZ5f7nSP0CKyh7pw8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 117/269] Bluetooth: hci_sync: Attempt to dequeue connection attempt
Date: Tue, 10 Sep 2024 11:31:44 +0200
Message-ID: <20240910092612.356871337@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 881559af5f5c545f6828e7c74d79813eb886d523 ]

If connection is still queued/pending in the cmd_sync queue it means no
command has been generated and it should be safe to just dequeue the
callback when it is being aborted.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 227a0cdf4a02 ("Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h | 19 ++++++++
 include/net/bluetooth/hci_sync.h | 10 +++--
 net/bluetooth/hci_conn.c         | 70 ++++++------------------------
 net/bluetooth/hci_sync.c         | 74 ++++++++++++++++++++++++++++----
 4 files changed, 102 insertions(+), 71 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 850f0e46aecf..29f1549ee111 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1041,6 +1041,24 @@ static inline unsigned int hci_conn_count(struct hci_dev *hdev)
 	return c->acl_num + c->sco_num + c->le_num + c->iso_num;
 }
 
+static inline bool hci_conn_valid(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c == conn) {
+			rcu_read_unlock();
+			return true;
+		}
+	}
+	rcu_read_unlock();
+
+	return false;
+}
+
 static inline __u8 hci_conn_lookup_type(struct hci_dev *hdev, __u16 handle)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
@@ -1430,6 +1448,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, bool dst_resolved, u8 sec_level,
 				u16 conn_timeout, u8 role);
+void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status);
 struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 				 u8 sec_level, u8 auth_type,
 				 enum conn_reasons conn_reason);
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 24c0053d8f0c..534c3386e714 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -50,11 +50,11 @@ int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			void *data, hci_cmd_sync_work_destroy_t destroy);
 int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		       void *data, hci_cmd_sync_work_destroy_t destroy);
+int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			    void *data, hci_cmd_sync_work_destroy_t destroy);
 struct hci_cmd_sync_work_entry *
 hci_cmd_sync_lookup_entry(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			  void *data, hci_cmd_sync_work_destroy_t destroy);
-int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
-			    void *data, hci_cmd_sync_work_destroy_t destroy);
 void hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
 			       struct hci_cmd_sync_work_entry *entry);
 bool hci_cmd_sync_dequeue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
@@ -141,8 +141,6 @@ struct hci_conn;
 
 int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason);
 
-int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn);
-
 int hci_le_create_cis_sync(struct hci_dev *hdev);
 
 int hci_le_remove_cig_sync(struct hci_dev *hdev, u8 handle);
@@ -154,3 +152,7 @@ int hci_le_big_terminate_sync(struct hci_dev *hdev, u8 handle);
 int hci_le_pa_terminate_sync(struct hci_dev *hdev, u16 handle);
 
 int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn);
+
+int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn);
+
+int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d15c8ce4b418..efa0881a90e1 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -68,7 +68,7 @@ static const struct sco_param esco_param_msbc[] = {
 };
 
 /* This function requires the caller holds hdev->lock */
-static void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status)
+void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status)
 {
 	struct hci_conn_params *params;
 	struct hci_dev *hdev = conn->hdev;
@@ -1143,6 +1143,9 @@ void hci_conn_del(struct hci_conn *conn)
 	 * rest of hci_conn_del.
 	 */
 	hci_conn_cleanup(conn);
+
+	/* Dequeue callbacks using connection pointer as data */
+	hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);
 }
 
 struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, uint8_t src_type)
@@ -1276,53 +1279,6 @@ u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle)
 	return 0;
 }
 
-static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
-{
-	struct hci_conn *conn;
-	u16 handle = PTR_UINT(data);
-
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!conn)
-		return;
-
-	bt_dev_dbg(hdev, "err %d", err);
-
-	hci_dev_lock(hdev);
-
-	if (!err) {
-		hci_connect_le_scan_cleanup(conn, 0x00);
-		goto done;
-	}
-
-	/* Check if connection is still pending */
-	if (conn != hci_lookup_le_connect(hdev))
-		goto done;
-
-	/* Flush to make sure we send create conn cancel command if needed */
-	flush_delayed_work(&conn->le_conn_timeout);
-	hci_conn_failed(conn, bt_status(err));
-
-done:
-	hci_dev_unlock(hdev);
-}
-
-static int hci_connect_le_sync(struct hci_dev *hdev, void *data)
-{
-	struct hci_conn *conn;
-	u16 handle = PTR_UINT(data);
-
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!conn)
-		return 0;
-
-	bt_dev_dbg(hdev, "conn %p", conn);
-
-	clear_bit(HCI_CONN_SCANNING, &conn->flags);
-	conn->state = BT_CONNECT;
-
-	return hci_le_create_conn_sync(hdev, conn);
-}
-
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, bool dst_resolved, u8 sec_level,
 				u16 conn_timeout, u8 role)
@@ -1389,9 +1345,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->conn_timeout = conn_timeout;
 
-	err = hci_cmd_sync_queue(hdev, hci_connect_le_sync,
-				 UINT_PTR(conn->handle),
-				 create_le_conn_complete);
+	err = hci_connect_le_sync(hdev, conn);
 	if (err) {
 		hci_conn_del(conn);
 		return ERR_PTR(err);
@@ -2880,12 +2834,10 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
 
 static int abort_conn_sync(struct hci_dev *hdev, void *data)
 {
-	struct hci_conn *conn;
-	u16 handle = PTR_UINT(data);
+	struct hci_conn *conn = data;
 
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!conn)
-		return 0;
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
 
 	return hci_abort_conn_sync(hdev, conn, conn->abort_reason);
 }
@@ -2920,8 +2872,10 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 			hci_cmd_sync_cancel(hdev, ECANCELED);
 			break;
 		}
+	/* Cancel connect attempt if still queued/pending */
+	} else if (!hci_cancel_connect_sync(hdev, conn)) {
+		return 0;
 	}
 
-	return hci_cmd_sync_queue(hdev, abort_conn_sync, UINT_PTR(conn->handle),
-				  NULL);
+	return hci_cmd_sync_queue_once(hdev, abort_conn_sync, conn, NULL);
 }
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ed18e35c7097..3131daff56f4 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6370,12 +6370,21 @@ static int hci_le_ext_create_conn_sync(struct hci_dev *hdev,
 					conn->conn_timeout, NULL);
 }
 
-int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
+static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_cp_le_create_conn cp;
 	struct hci_conn_params *params;
 	u8 own_addr_type;
 	int err;
+	struct hci_conn *conn = data;
+
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
+	bt_dev_dbg(hdev, "conn %p", conn);
+
+	clear_bit(HCI_CONN_SCANNING, &conn->flags);
+	conn->state = BT_CONNECT;
 
 	/* If requested to connect as peripheral use directed advertising */
 	if (conn->role == HCI_ROLE_SLAVE) {
@@ -6696,16 +6705,11 @@ int hci_update_adv_data(struct hci_dev *hdev, u8 instance)
 
 static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 {
-	struct hci_conn *conn;
-	u16 handle = PTR_UINT(data);
+	struct hci_conn *conn = data;
 	struct inquiry_entry *ie;
 	struct hci_cp_create_conn cp;
 	int err;
 
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!conn)
-		return 0;
-
 	/* Many controllers disallow HCI Create Connection while it is doing
 	 * HCI Inquiry. So we cancel the Inquiry first before issuing HCI Create
 	 * Connection. This may cause the MGMT discovering state to become false
@@ -6764,6 +6768,58 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 
 int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
-	return hci_cmd_sync_queue(hdev, hci_acl_create_conn_sync,
-				  UINT_PTR(conn->handle), NULL);
+	return hci_cmd_sync_queue_once(hdev, hci_acl_create_conn_sync, conn,
+				       NULL);
+}
+
+static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct hci_conn *conn = data;
+
+	bt_dev_dbg(hdev, "err %d", err);
+
+	if (err == -ECANCELED)
+		return;
+
+	hci_dev_lock(hdev);
+
+	if (!err) {
+		hci_connect_le_scan_cleanup(conn, 0x00);
+		goto done;
+	}
+
+	/* Check if connection is still pending */
+	if (conn != hci_lookup_le_connect(hdev))
+		goto done;
+
+	/* Flush to make sure we send create conn cancel command if needed */
+	flush_delayed_work(&conn->le_conn_timeout);
+	hci_conn_failed(conn, bt_status(err));
+
+done:
+	hci_dev_unlock(hdev);
+}
+
+int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	return hci_cmd_sync_queue_once(hdev, hci_le_create_conn_sync, conn,
+				       create_le_conn_complete);
+}
+
+int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	if (conn->state != BT_OPEN)
+		return -EINVAL;
+
+	switch (conn->type) {
+	case ACL_LINK:
+		return !hci_cmd_sync_dequeue_once(hdev,
+						  hci_acl_create_conn_sync,
+						  conn, NULL);
+	case LE_LINK:
+		return !hci_cmd_sync_dequeue_once(hdev, hci_le_create_conn_sync,
+						  conn, create_le_conn_complete);
+	}
+
+	return -ENOENT;
 }
-- 
2.43.0




