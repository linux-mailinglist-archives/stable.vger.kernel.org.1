Return-Path: <stable+bounces-93350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA2C9CD8BE
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 306EDB2608B
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85610186294;
	Fri, 15 Nov 2024 06:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iSFHrjrp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427E014EC77;
	Fri, 15 Nov 2024 06:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653627; cv=none; b=Uc34VXexXrGj61pJOkJCaa+efO3Ti13bADrw2uOXP7AW6PFE5HnA6abKZUzhjvTt2c54WOpl7vefrvg8hkD13lN5qzyzD5yE+hcvxrzRegLIMDDgWiaTtPRLkff2Dxbyg/9ABp8kqsFnxR7o7BK9Sq5VrfJZBtELmp24BMk+CJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653627; c=relaxed/simple;
	bh=9XfPI7IRioeZS7mScNXOQrNz96Yjpe+egGr/OpUBDoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFvQEfzWOtNlm6WgQp5WjArQ3J5OuLRhAd24f9Bdj/7c+sg55nirrt+V2E6JndytD5NjmNw6+OcAuGc6y0HHyHgIN48RMV9ezn6d6OhmZBgH0ZXpo6snfdRoQ3JvoGyuPH+V+bAMNxWVUhoeR4eqxjsuE8VFA7R58gtVOl/mw0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iSFHrjrp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74167C4CECF;
	Fri, 15 Nov 2024 06:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653626;
	bh=9XfPI7IRioeZS7mScNXOQrNz96Yjpe+egGr/OpUBDoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iSFHrjrpLLQofx/Kt8I2ShM70kKmFlH2Q5Ki06h6MUPxLefe8vBRHcMtKDPNgWjE4
	 W3WKDtQjymDbb1q8B4xbMa5XYVRN5cOundXiLS8DF22q4DtZvmLIX1PNfZWFPILN/I
	 eW3phKqt87UamdyEmhzqoMAhwD9dhn6FBOah1Oxs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Jeremy=20Lain=C3=A9?= <jeremy.laine@m4x.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Mike <user.service2016@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 05/39] Revert "Bluetooth: hci_conn: Consolidate code for aborting connections"
Date: Fri, 15 Nov 2024 07:38:15 +0100
Message-ID: <20241115063722.803044175@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.599985562@linuxfoundation.org>
References: <20241115063722.599985562@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 6083089ab00631617f9eac678df3ab050a9d837a which is
commit a13f316e90fdb1fb6df6582e845aa9b3270f3581 upstream.

It is reported to cause regressions in the 6.1.y tree, so revert it for
now.

Link: https://lore.kernel.org/all/CADRbXaDqx6S+7tzdDPPEpRu9eDLrHQkqoWTTGfKJSRxY=hT5MQ@mail.gmail.com/
Reported-by: Jeremy Lainé <jeremy.laine@m4x.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>
Cc: Mike <user.service2016@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Pauli Virtanen <pav@iki.fi>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/bluetooth/hci_core.h |    2 
 net/bluetooth/hci_conn.c         |  156 +++++++++++++++++++++++++++++++--------
 net/bluetooth/hci_sync.c         |   23 ++---
 net/bluetooth/mgmt.c             |   15 +++
 4 files changed, 148 insertions(+), 48 deletions(-)

--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -734,7 +734,6 @@ struct hci_conn {
 	unsigned long	flags;
 
 	enum conn_reasons conn_reason;
-	__u8		abort_reason;
 
 	__u32		clock;
 	__u16		clock_accuracy;
@@ -754,6 +753,7 @@ struct hci_conn {
 	struct delayed_work auto_accept_work;
 	struct delayed_work idle_work;
 	struct delayed_work le_conn_timeout;
+	struct work_struct  le_scan_cleanup;
 
 	struct device	dev;
 	struct dentry	*debugfs;
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -174,6 +174,57 @@ static void hci_conn_cleanup(struct hci_
 	hci_dev_put(hdev);
 }
 
+static void le_scan_cleanup(struct work_struct *work)
+{
+	struct hci_conn *conn = container_of(work, struct hci_conn,
+					     le_scan_cleanup);
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_conn *c = NULL;
+
+	BT_DBG("%s hcon %p", hdev->name, conn);
+
+	hci_dev_lock(hdev);
+
+	/* Check that the hci_conn is still around */
+	rcu_read_lock();
+	list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
+		if (c == conn)
+			break;
+	}
+	rcu_read_unlock();
+
+	if (c == conn) {
+		hci_connect_le_scan_cleanup(conn, 0x00);
+		hci_conn_cleanup(conn);
+	}
+
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
+	hci_conn_put(conn);
+}
+
+static void hci_connect_le_scan_remove(struct hci_conn *conn)
+{
+	BT_DBG("%s hcon %p", conn->hdev->name, conn);
+
+	/* We can't call hci_conn_del/hci_conn_cleanup here since that
+	 * could deadlock with another hci_conn_del() call that's holding
+	 * hci_dev_lock and doing cancel_delayed_work_sync(&conn->disc_work).
+	 * Instead, grab temporary extra references to the hci_dev and
+	 * hci_conn and perform the necessary cleanup in a separate work
+	 * callback.
+	 */
+
+	hci_dev_hold(conn->hdev);
+	hci_conn_get(conn);
+
+	/* Even though we hold a reference to the hdev, many other
+	 * things might get cleaned up meanwhile, including the hdev's
+	 * own workqueue, so we can't use that for scheduling.
+	 */
+	schedule_work(&conn->le_scan_cleanup);
+}
+
 static void hci_acl_create_connection(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -625,6 +676,13 @@ static void hci_conn_timeout(struct work
 	if (refcnt > 0)
 		return;
 
+	/* LE connections in scanning state need special handling */
+	if (conn->state == BT_CONNECT && conn->type == LE_LINK &&
+	    test_bit(HCI_CONN_SCANNING, &conn->flags)) {
+		hci_connect_le_scan_remove(conn);
+		return;
+	}
+
 	hci_abort_conn(conn, hci_proto_disconn_ind(conn));
 }
 
@@ -996,6 +1054,7 @@ struct hci_conn *hci_conn_add(struct hci
 	INIT_DELAYED_WORK(&conn->auto_accept_work, hci_conn_auto_accept);
 	INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
 	INIT_DELAYED_WORK(&conn->le_conn_timeout, le_conn_timeout);
+	INIT_WORK(&conn->le_scan_cleanup, le_scan_cleanup);
 
 	atomic_set(&conn->refcnt, 0);
 
@@ -2781,46 +2840,81 @@ u32 hci_conn_get_phy(struct hci_conn *co
 	return phys;
 }
 
-static int abort_conn_sync(struct hci_dev *hdev, void *data)
+int hci_abort_conn(struct hci_conn *conn, u8 reason)
 {
-	struct hci_conn *conn;
-	u16 handle = PTR_ERR(data);
+	int r = 0;
 
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!conn)
+	if (test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
 		return 0;
 
-	return hci_abort_conn_sync(hdev, conn, conn->abort_reason);
-}
-
-int hci_abort_conn(struct hci_conn *conn, u8 reason)
-{
-	struct hci_dev *hdev = conn->hdev;
+	switch (conn->state) {
+	case BT_CONNECTED:
+	case BT_CONFIG:
+		if (conn->type == AMP_LINK) {
+			struct hci_cp_disconn_phy_link cp;
+
+			cp.phy_handle = HCI_PHY_HANDLE(conn->handle);
+			cp.reason = reason;
+			r = hci_send_cmd(conn->hdev, HCI_OP_DISCONN_PHY_LINK,
+					 sizeof(cp), &cp);
+		} else {
+			struct hci_cp_disconnect dc;
 
-	/* If abort_reason has already been set it means the connection is
-	 * already being aborted so don't attempt to overwrite it.
-	 */
-	if (conn->abort_reason)
-		return 0;
+			dc.handle = cpu_to_le16(conn->handle);
+			dc.reason = reason;
+			r = hci_send_cmd(conn->hdev, HCI_OP_DISCONNECT,
+					 sizeof(dc), &dc);
+		}
 
-	bt_dev_dbg(hdev, "handle 0x%2.2x reason 0x%2.2x", conn->handle, reason);
+		conn->state = BT_DISCONN;
 
-	conn->abort_reason = reason;
+		break;
+	case BT_CONNECT:
+		if (conn->type == LE_LINK) {
+			if (test_bit(HCI_CONN_SCANNING, &conn->flags))
+				break;
+			r = hci_send_cmd(conn->hdev,
+					 HCI_OP_LE_CREATE_CONN_CANCEL, 0, NULL);
+		} else if (conn->type == ACL_LINK) {
+			if (conn->hdev->hci_ver < BLUETOOTH_VER_1_2)
+				break;
+			r = hci_send_cmd(conn->hdev,
+					 HCI_OP_CREATE_CONN_CANCEL,
+					 6, &conn->dst);
+		}
+		break;
+	case BT_CONNECT2:
+		if (conn->type == ACL_LINK) {
+			struct hci_cp_reject_conn_req rej;
+
+			bacpy(&rej.bdaddr, &conn->dst);
+			rej.reason = reason;
+
+			r = hci_send_cmd(conn->hdev,
+					 HCI_OP_REJECT_CONN_REQ,
+					 sizeof(rej), &rej);
+		} else if (conn->type == SCO_LINK || conn->type == ESCO_LINK) {
+			struct hci_cp_reject_sync_conn_req rej;
+
+			bacpy(&rej.bdaddr, &conn->dst);
+
+			/* SCO rejection has its own limited set of
+			 * allowed error values (0x0D-0x0F) which isn't
+			 * compatible with most values passed to this
+			 * function. To be safe hard-code one of the
+			 * values that's suitable for SCO.
+			 */
+			rej.reason = HCI_ERROR_REJ_LIMITED_RESOURCES;
 
-	/* If the connection is pending check the command opcode since that
-	 * might be blocking on hci_cmd_sync_work while waiting its respective
-	 * event so we need to hci_cmd_sync_cancel to cancel it.
-	 */
-	if (conn->state == BT_CONNECT && hdev->req_status == HCI_REQ_PEND) {
-		switch (hci_skb_event(hdev->sent_cmd)) {
-		case HCI_EV_LE_CONN_COMPLETE:
-		case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
-		case HCI_EVT_LE_CIS_ESTABLISHED:
-			hci_cmd_sync_cancel(hdev, -ECANCELED);
-			break;
+			r = hci_send_cmd(conn->hdev,
+					 HCI_OP_REJECT_SYNC_CONN_REQ,
+					 sizeof(rej), &rej);
 		}
+		break;
+	default:
+		conn->state = BT_CLOSED;
+		break;
 	}
 
-	return hci_cmd_sync_queue(hdev, abort_conn_sync, ERR_PTR(conn->handle),
-				  NULL);
+	return r;
 }
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5293,27 +5293,22 @@ static int hci_disconnect_sync(struct hc
 }
 
 static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
-				      struct hci_conn *conn, u8 reason)
+				      struct hci_conn *conn)
 {
-	/* Return reason if scanning since the connection shall probably be
-	 * cleanup directly.
-	 */
 	if (test_bit(HCI_CONN_SCANNING, &conn->flags))
-		return reason;
+		return 0;
 
-	if (conn->role == HCI_ROLE_SLAVE ||
-	    test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
+	if (test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
 		return 0;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_CONN_CANCEL,
 				     0, NULL, HCI_CMD_TIMEOUT);
 }
 
-static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn,
-				   u8 reason)
+static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	if (conn->type == LE_LINK)
-		return hci_le_connect_cancel_sync(hdev, conn, reason);
+		return hci_le_connect_cancel_sync(hdev, conn);
 
 	if (hdev->hci_ver < BLUETOOTH_VER_1_2)
 		return 0;
@@ -5366,11 +5361,9 @@ int hci_abort_conn_sync(struct hci_dev *
 	case BT_CONFIG:
 		return hci_disconnect_sync(hdev, conn, reason);
 	case BT_CONNECT:
-		err = hci_connect_cancel_sync(hdev, conn, reason);
+		err = hci_connect_cancel_sync(hdev, conn);
 		/* Cleanup hci_conn object if it cannot be cancelled as it
-		 * likelly means the controller and host stack are out of sync
-		 * or in case of LE it was still scanning so it can be cleanup
-		 * safely.
+		 * likelly means the controller and host stack are out of sync.
 		 */
 		if (err) {
 			hci_dev_lock(hdev);
@@ -6285,7 +6278,7 @@ int hci_le_create_conn_sync(struct hci_d
 
 done:
 	if (err == -ETIMEDOUT)
-		hci_le_connect_cancel_sync(hdev, conn, 0x00);
+		hci_le_connect_cancel_sync(hdev, conn);
 
 	/* Re-enable advertising after the connection attempt is finished. */
 	hci_resume_advertising_sync(hdev);
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3600,6 +3600,18 @@ unlock:
 	return err;
 }
 
+static int abort_conn_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_conn *conn;
+	u16 handle = PTR_ERR(data);
+
+	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!conn)
+		return 0;
+
+	return hci_abort_conn_sync(hdev, conn, HCI_ERROR_REMOTE_USER_TERM);
+}
+
 static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 			      u16 len)
 {
@@ -3650,7 +3662,8 @@ static int cancel_pair_device(struct soc
 					      le_addr_type(addr->type));
 
 	if (conn->conn_reason == CONN_REASON_PAIR_DEVICE)
-		hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+		hci_cmd_sync_queue(hdev, abort_conn_sync, ERR_PTR(conn->handle),
+				   NULL);
 
 unlock:
 	hci_dev_unlock(hdev);



