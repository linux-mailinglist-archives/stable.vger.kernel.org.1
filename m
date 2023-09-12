Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C2B79B237
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjIKUwE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240171AbjIKOiY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:38:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E21CF2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:38:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54092C433C8;
        Mon, 11 Sep 2023 14:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443099;
        bh=X3P+N818EjDyjTgow0XqHySaPvwAXsjJ8SWyUWoFagM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPcrSmNYmjxwl9oCGToQap4G2Q7vhBi0eLRteOoB4zSw3gueW5/+mgcZfR/SqDmjn
         nGffZIfGG1Ij75T9m0yPOCo7/0aFb+2Pox7/HNvJb+Apb0DdHU/2ow2c3qNhfYWqiP
         TQVFFp5oL67jYGUT50TNZyCtl//DzAPQUsDQ1gXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 240/737] Bluetooth: hci_conn: Consolidate code for aborting connections
Date:   Mon, 11 Sep 2023 15:41:39 +0200
Message-ID: <20230911134657.310409665@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit a13f316e90fdb1fb6df6582e845aa9b3270f3581 ]

This consolidates code for aborting connections using
hci_cmd_sync_queue so it is synchronized with other threads, but
because of the fact that some commands may block the cmd_sync_queue
while waiting specific events this attempt to cancel those requests by
using hci_cmd_sync_cancel.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 94d9ba9f9888 ("Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h |   2 +-
 net/bluetooth/hci_conn.c         | 154 ++++++-------------------------
 net/bluetooth/hci_sync.c         |  23 +++--
 net/bluetooth/mgmt.c             |  15 +--
 4 files changed, 47 insertions(+), 147 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2db826cdf76fa..e4c1e503415b6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -741,6 +741,7 @@ struct hci_conn {
 	unsigned long	flags;
 
 	enum conn_reasons conn_reason;
+	__u8		abort_reason;
 
 	__u32		clock;
 	__u16		clock_accuracy;
@@ -760,7 +761,6 @@ struct hci_conn {
 	struct delayed_work auto_accept_work;
 	struct delayed_work idle_work;
 	struct delayed_work le_conn_timeout;
-	struct work_struct  le_scan_cleanup;
 
 	struct device	dev;
 	struct dentry	*debugfs;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7ced6077488f7..f05b99437e280 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -178,57 +178,6 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 	hci_conn_put(conn);
 }
 
-static void le_scan_cleanup(struct work_struct *work)
-{
-	struct hci_conn *conn = container_of(work, struct hci_conn,
-					     le_scan_cleanup);
-	struct hci_dev *hdev = conn->hdev;
-	struct hci_conn *c = NULL;
-
-	BT_DBG("%s hcon %p", hdev->name, conn);
-
-	hci_dev_lock(hdev);
-
-	/* Check that the hci_conn is still around */
-	rcu_read_lock();
-	list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
-		if (c == conn)
-			break;
-	}
-	rcu_read_unlock();
-
-	if (c == conn) {
-		hci_connect_le_scan_cleanup(conn, 0x00);
-		hci_conn_cleanup(conn);
-	}
-
-	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-	hci_conn_put(conn);
-}
-
-static void hci_connect_le_scan_remove(struct hci_conn *conn)
-{
-	BT_DBG("%s hcon %p", conn->hdev->name, conn);
-
-	/* We can't call hci_conn_del/hci_conn_cleanup here since that
-	 * could deadlock with another hci_conn_del() call that's holding
-	 * hci_dev_lock and doing cancel_delayed_work_sync(&conn->disc_work).
-	 * Instead, grab temporary extra references to the hci_dev and
-	 * hci_conn and perform the necessary cleanup in a separate work
-	 * callback.
-	 */
-
-	hci_dev_hold(conn->hdev);
-	hci_conn_get(conn);
-
-	/* Even though we hold a reference to the hdev, many other
-	 * things might get cleaned up meanwhile, including the hdev's
-	 * own workqueue, so we can't use that for scheduling.
-	 */
-	schedule_work(&conn->le_scan_cleanup);
-}
-
 static void hci_acl_create_connection(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -679,13 +628,6 @@ static void hci_conn_timeout(struct work_struct *work)
 	if (refcnt > 0)
 		return;
 
-	/* LE connections in scanning state need special handling */
-	if (conn->state == BT_CONNECT && conn->type == LE_LINK &&
-	    test_bit(HCI_CONN_SCANNING, &conn->flags)) {
-		hci_connect_le_scan_remove(conn);
-		return;
-	}
-
 	hci_abort_conn(conn, hci_proto_disconn_ind(conn));
 }
 
@@ -1086,7 +1028,6 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	INIT_DELAYED_WORK(&conn->auto_accept_work, hci_conn_auto_accept);
 	INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
 	INIT_DELAYED_WORK(&conn->le_conn_timeout, le_conn_timeout);
-	INIT_WORK(&conn->le_scan_cleanup, le_scan_cleanup);
 
 	atomic_set(&conn->refcnt, 0);
 
@@ -2885,81 +2826,46 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
 	return phys;
 }
 
-int hci_abort_conn(struct hci_conn *conn, u8 reason)
+static int abort_conn_sync(struct hci_dev *hdev, void *data)
 {
-	int r = 0;
+	struct hci_conn *conn;
+	u16 handle = PTR_ERR(data);
 
-	if (test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
+	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!conn)
 		return 0;
 
-	switch (conn->state) {
-	case BT_CONNECTED:
-	case BT_CONFIG:
-		if (conn->type == AMP_LINK) {
-			struct hci_cp_disconn_phy_link cp;
+	return hci_abort_conn_sync(hdev, conn, conn->abort_reason);
+}
 
-			cp.phy_handle = HCI_PHY_HANDLE(conn->handle);
-			cp.reason = reason;
-			r = hci_send_cmd(conn->hdev, HCI_OP_DISCONN_PHY_LINK,
-					 sizeof(cp), &cp);
-		} else {
-			struct hci_cp_disconnect dc;
+int hci_abort_conn(struct hci_conn *conn, u8 reason)
+{
+	struct hci_dev *hdev = conn->hdev;
 
-			dc.handle = cpu_to_le16(conn->handle);
-			dc.reason = reason;
-			r = hci_send_cmd(conn->hdev, HCI_OP_DISCONNECT,
-					 sizeof(dc), &dc);
-		}
+	/* If abort_reason has already been set it means the connection is
+	 * already being aborted so don't attempt to overwrite it.
+	 */
+	if (conn->abort_reason)
+		return 0;
 
-		conn->state = BT_DISCONN;
+	bt_dev_dbg(hdev, "handle 0x%2.2x reason 0x%2.2x", conn->handle, reason);
 
-		break;
-	case BT_CONNECT:
-		if (conn->type == LE_LINK) {
-			if (test_bit(HCI_CONN_SCANNING, &conn->flags))
-				break;
-			r = hci_send_cmd(conn->hdev,
-					 HCI_OP_LE_CREATE_CONN_CANCEL, 0, NULL);
-		} else if (conn->type == ACL_LINK) {
-			if (conn->hdev->hci_ver < BLUETOOTH_VER_1_2)
-				break;
-			r = hci_send_cmd(conn->hdev,
-					 HCI_OP_CREATE_CONN_CANCEL,
-					 6, &conn->dst);
-		}
-		break;
-	case BT_CONNECT2:
-		if (conn->type == ACL_LINK) {
-			struct hci_cp_reject_conn_req rej;
-
-			bacpy(&rej.bdaddr, &conn->dst);
-			rej.reason = reason;
-
-			r = hci_send_cmd(conn->hdev,
-					 HCI_OP_REJECT_CONN_REQ,
-					 sizeof(rej), &rej);
-		} else if (conn->type == SCO_LINK || conn->type == ESCO_LINK) {
-			struct hci_cp_reject_sync_conn_req rej;
-
-			bacpy(&rej.bdaddr, &conn->dst);
-
-			/* SCO rejection has its own limited set of
-			 * allowed error values (0x0D-0x0F) which isn't
-			 * compatible with most values passed to this
-			 * function. To be safe hard-code one of the
-			 * values that's suitable for SCO.
-			 */
-			rej.reason = HCI_ERROR_REJ_LIMITED_RESOURCES;
+	conn->abort_reason = reason;
 
-			r = hci_send_cmd(conn->hdev,
-					 HCI_OP_REJECT_SYNC_CONN_REQ,
-					 sizeof(rej), &rej);
+	/* If the connection is pending check the command opcode since that
+	 * might be blocking on hci_cmd_sync_work while waiting its respective
+	 * event so we need to hci_cmd_sync_cancel to cancel it.
+	 */
+	if (conn->state == BT_CONNECT && hdev->req_status == HCI_REQ_PEND) {
+		switch (hci_skb_event(hdev->sent_cmd)) {
+		case HCI_EV_LE_CONN_COMPLETE:
+		case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
+		case HCI_EVT_LE_CIS_ESTABLISHED:
+			hci_cmd_sync_cancel(hdev, -ECANCELED);
+			break;
 		}
-		break;
-	default:
-		conn->state = BT_CLOSED;
-		break;
 	}
 
-	return r;
+	return hci_cmd_sync_queue(hdev, abort_conn_sync, ERR_PTR(conn->handle),
+				  NULL);
 }
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 50f34c812cccd..e3b7f21046dbc 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5271,22 +5271,27 @@ static int hci_disconnect_sync(struct hci_dev *hdev, struct hci_conn *conn,
 }
 
 static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
-				      struct hci_conn *conn)
+				      struct hci_conn *conn, u8 reason)
 {
+	/* Return reason if scanning since the connection shall probably be
+	 * cleanup directly.
+	 */
 	if (test_bit(HCI_CONN_SCANNING, &conn->flags))
-		return 0;
+		return reason;
 
-	if (test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
+	if (conn->role == HCI_ROLE_SLAVE ||
+	    test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
 		return 0;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_CONN_CANCEL,
 				     0, NULL, HCI_CMD_TIMEOUT);
 }
 
-static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn)
+static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn,
+				   u8 reason)
 {
 	if (conn->type == LE_LINK)
-		return hci_le_connect_cancel_sync(hdev, conn);
+		return hci_le_connect_cancel_sync(hdev, conn, reason);
 
 	if (hdev->hci_ver < BLUETOOTH_VER_1_2)
 		return 0;
@@ -5339,9 +5344,11 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 	case BT_CONFIG:
 		return hci_disconnect_sync(hdev, conn, reason);
 	case BT_CONNECT:
-		err = hci_connect_cancel_sync(hdev, conn);
+		err = hci_connect_cancel_sync(hdev, conn, reason);
 		/* Cleanup hci_conn object if it cannot be cancelled as it
-		 * likelly means the controller and host stack are out of sync.
+		 * likelly means the controller and host stack are out of sync
+		 * or in case of LE it was still scanning so it can be cleanup
+		 * safely.
 		 */
 		if (err) {
 			hci_dev_lock(hdev);
@@ -6255,7 +6262,7 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 
 done:
 	if (err == -ETIMEDOUT)
-		hci_le_connect_cancel_sync(hdev, conn);
+		hci_le_connect_cancel_sync(hdev, conn, 0x00);
 
 	/* Re-enable advertising after the connection attempt is finished. */
 	hci_resume_advertising_sync(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d4498037fadc6..6240b20f020a8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3580,18 +3580,6 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
-static int abort_conn_sync(struct hci_dev *hdev, void *data)
-{
-	struct hci_conn *conn;
-	u16 handle = PTR_ERR(data);
-
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!conn)
-		return 0;
-
-	return hci_abort_conn_sync(hdev, conn, HCI_ERROR_REMOTE_USER_TERM);
-}
-
 static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 			      u16 len)
 {
@@ -3642,8 +3630,7 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 					      le_addr_type(addr->type));
 
 	if (conn->conn_reason == CONN_REASON_PAIR_DEVICE)
-		hci_cmd_sync_queue(hdev, abort_conn_sync, ERR_PTR(conn->handle),
-				   NULL);
+		hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.40.1



