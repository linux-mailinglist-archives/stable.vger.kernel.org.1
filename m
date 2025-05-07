Return-Path: <stable+bounces-142531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9BFAAEB05
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 21:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA6C1C44CEF
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 19:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7515F2144BF;
	Wed,  7 May 2025 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ucOR6qDv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3261B288A8;
	Wed,  7 May 2025 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644540; cv=none; b=bDWOYG2LhnFBYBr3LGQ7weER5feZisgJbzBhuYlMdWukEpI07fVpeP2gPuTLpW3SCopXjgIDBUXWSiu+9FVbVuKfZDhCFj2a9vng0V39bNZUuiNbfvh4bizo4UkNANyW24lddxa3ishax8yX/7pP56IC9+TR9mix8tUDI4Xl3CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644540; c=relaxed/simple;
	bh=UpxIa0z/3UZPD/zPD8fI3hNx+23uyxhh2jdqQZ9Fb5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaCQB/rTLbLl8O976zuQQjlOgBowXgVeEOmoveTLp4Uw94JHADNAcf76wbvoFKP/R54fbTry5QKnAihHtiloY4npRNejIAblR7xH4nr1HPG/g2k5GGEYy0Mo1Y1FQ4RvA3NmoKrjuZpwwdIO9uTUn2gUbkxdTLtowIX8KQ14ix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ucOR6qDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9025CC4CEE2;
	Wed,  7 May 2025 19:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746644540;
	bh=UpxIa0z/3UZPD/zPD8fI3hNx+23uyxhh2jdqQZ9Fb5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ucOR6qDva3aNEZCX6BL8EgC90vSlkTekHEj0ydfH4gDxjVUilQt7UdnV5KbedIUat
	 MzBH68taNPEoEjDBT1oOQeAfIaKinzzOXRwAsX0a8obfy6bdzhCTys4mqnLa6W6TNF
	 rySHIKWXhyN4GnkDZnKhaiIQBVTtilhGvJ5g6hOI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 076/164] Bluetooth: hci_conn: Fix not setting timeout for BIG Create Sync
Date: Wed,  7 May 2025 20:39:21 +0200
Message-ID: <20250507183824.039484423@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183820.781599563@linuxfoundation.org>
References: <20250507183820.781599563@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 024421cf39923927ab2b5fe895d1d922b9abe67f ]

BIG Create Sync requires the command to just generates a status so this
makes use of __hci_cmd_sync_status_sk to wait for
HCI_EVT_LE_BIG_SYNC_ESTABLISHED, also because of this chance it is not
longer necessary to use a custom method to serialize the process of
creating the BIG sync since the cmd_work_sync itself ensures only one
command would be pending which now awaits for
HCI_EVT_LE_BIG_SYNC_ESTABLISHED before proceeding to next connection.

Fixes: 42ecf1947135 ("Bluetooth: ISO: Do not emit LE BIG Create Sync if previous is pending")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci.h      |  2 +-
 include/net/bluetooth/hci_core.h |  7 ++-
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_conn.c         | 89 ++------------------------------
 net/bluetooth/hci_event.c        |  9 ++--
 net/bluetooth/hci_sync.c         | 63 ++++++++++++++++++++++
 net/bluetooth/iso.c              | 26 +++++-----
 7 files changed, 88 insertions(+), 109 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3d1599cdbb8d0..40fce4193cc1d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2814,7 +2814,7 @@ struct hci_evt_le_create_big_complete {
 	__le16  bis_handle[];
 } __packed;
 
-#define HCI_EVT_LE_BIG_SYNC_ESTABILISHED 0x1d
+#define HCI_EVT_LE_BIG_SYNC_ESTABLISHED 0x1d
 struct hci_evt_le_big_sync_estabilished {
 	__u8    status;
 	__u8    handle;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1753869000164..4f3b537476e10 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1506,7 +1506,6 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
 bool hci_iso_setup_path(struct hci_conn *conn);
 int hci_le_create_cis_pending(struct hci_dev *hdev);
-int hci_le_big_create_sync_pending(struct hci_dev *hdev);
 int hci_conn_check_create_cis(struct hci_conn *conn);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
@@ -1547,9 +1546,9 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 __u8 data_len, __u8 *data);
 struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 		       __u8 dst_type, __u8 sid, struct bt_iso_qos *qos);
-int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
-			   struct bt_iso_qos *qos,
-			   __u16 sync_handle, __u8 num_bis, __u8 bis[]);
+int hci_conn_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
+			     struct bt_iso_qos *qos, __u16 sync_handle,
+			     __u8 num_bis, __u8 bis[]);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index fbc4d753ef842..dbabc17b30cdf 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -188,3 +188,4 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 			    struct hci_conn_params *params);
 
 int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn);
+int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index badaa6c199204..ae66fa0a5fb58 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2084,89 +2084,9 @@ struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 	return conn;
 }
 
-static bool hci_conn_check_create_big_sync(struct hci_conn *conn)
-{
-	if (!conn->num_bis)
-		return false;
-
-	return true;
-}
-
-static void big_create_sync_complete(struct hci_dev *hdev, void *data, int err)
-{
-	bt_dev_dbg(hdev, "");
-
-	if (err)
-		bt_dev_err(hdev, "Unable to create BIG sync: %d", err);
-}
-
-static int big_create_sync(struct hci_dev *hdev, void *data)
-{
-	DEFINE_FLEX(struct hci_cp_le_big_create_sync, pdu, bis, num_bis, 0x11);
-	struct hci_conn *conn;
-
-	rcu_read_lock();
-
-	pdu->num_bis = 0;
-
-	/* The spec allows only one pending LE BIG Create Sync command at
-	 * a time. If the command is pending now, don't do anything. We
-	 * check for pending connections after each BIG Sync Established
-	 * event.
-	 *
-	 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
-	 * page 2586:
-	 *
-	 * If the Host sends this command when the Controller is in the
-	 * process of synchronizing to any BIG, i.e. the HCI_LE_BIG_Sync_
-	 * Established event has not been generated, the Controller shall
-	 * return the error code Command Disallowed (0x0C).
-	 */
-	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		if (test_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags))
-			goto unlock;
-	}
-
-	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		if (hci_conn_check_create_big_sync(conn)) {
-			struct bt_iso_qos *qos = &conn->iso_qos;
-
-			set_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
-
-			pdu->handle = qos->bcast.big;
-			pdu->sync_handle = cpu_to_le16(conn->sync_handle);
-			pdu->encryption = qos->bcast.encryption;
-			memcpy(pdu->bcode, qos->bcast.bcode,
-			       sizeof(pdu->bcode));
-			pdu->mse = qos->bcast.mse;
-			pdu->timeout = cpu_to_le16(qos->bcast.timeout);
-			pdu->num_bis = conn->num_bis;
-			memcpy(pdu->bis, conn->bis, conn->num_bis);
-
-			break;
-		}
-	}
-
-unlock:
-	rcu_read_unlock();
-
-	if (!pdu->num_bis)
-		return 0;
-
-	return hci_send_cmd(hdev, HCI_OP_LE_BIG_CREATE_SYNC,
-			    struct_size(pdu, bis, pdu->num_bis), pdu);
-}
-
-int hci_le_big_create_sync_pending(struct hci_dev *hdev)
-{
-	/* Queue big_create_sync */
-	return hci_cmd_sync_queue_once(hdev, big_create_sync,
-				       NULL, big_create_sync_complete);
-}
-
-int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
-			   struct bt_iso_qos *qos,
-			   __u16 sync_handle, __u8 num_bis, __u8 bis[])
+int hci_conn_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
+			     struct bt_iso_qos *qos, __u16 sync_handle,
+			     __u8 num_bis, __u8 bis[])
 {
 	int err;
 
@@ -2183,9 +2103,10 @@ int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
 
 		hcon->num_bis = num_bis;
 		memcpy(hcon->bis, bis, num_bis);
+		hcon->conn_timeout = msecs_to_jiffies(qos->bcast.timeout * 10);
 	}
 
-	return hci_le_big_create_sync_pending(hdev);
+	return hci_connect_big_sync(hdev, hcon);
 }
 
 static void create_big_complete(struct hci_dev *hdev, void *data, int err)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bdf36ce06c68c..bc5b42fce2b80 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6918,7 +6918,7 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
-	if (!hci_le_ev_skb_pull(hdev, skb, HCI_EVT_LE_BIG_SYNC_ESTABILISHED,
+	if (!hci_le_ev_skb_pull(hdev, skb, HCI_EVT_LE_BIG_SYNC_ESTABLISHED,
 				flex_array_size(ev, bis, ev->num_bis)))
 		return;
 
@@ -6988,9 +6988,6 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 		}
 
 unlock:
-	/* Handle any other pending BIG sync command */
-	hci_le_big_create_sync_pending(hdev);
-
 	hci_dev_unlock(hdev);
 }
 
@@ -7112,8 +7109,8 @@ static const struct hci_le_ev {
 		     hci_le_create_big_complete_evt,
 		     sizeof(struct hci_evt_le_create_big_complete),
 		     HCI_MAX_EVENT_SIZE),
-	/* [0x1d = HCI_EV_LE_BIG_SYNC_ESTABILISHED] */
-	HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_ESTABILISHED,
+	/* [0x1d = HCI_EV_LE_BIG_SYNC_ESTABLISHED] */
+	HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_ESTABLISHED,
 		     hci_le_big_sync_established_evt,
 		     sizeof(struct hci_evt_le_big_sync_estabilished),
 		     HCI_MAX_EVENT_SIZE),
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index d603810ccda99..6597936fbd51b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6964,3 +6964,66 @@ int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	return hci_cmd_sync_queue_once(hdev, hci_le_pa_create_sync, conn,
 				       create_pa_complete);
 }
+
+static void create_big_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct hci_conn *conn = data;
+
+	bt_dev_dbg(hdev, "err %d", err);
+
+	if (err == -ECANCELED)
+		return;
+
+	if (hci_conn_valid(hdev, conn))
+		clear_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
+}
+
+static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
+{
+	DEFINE_FLEX(struct hci_cp_le_big_create_sync, cp, bis, num_bis, 0x11);
+	struct hci_conn *conn = data;
+	struct bt_iso_qos *qos = &conn->iso_qos;
+	int err;
+
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
+	set_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
+
+	memset(cp, 0, sizeof(*cp));
+	cp->handle = qos->bcast.big;
+	cp->sync_handle = cpu_to_le16(conn->sync_handle);
+	cp->encryption = qos->bcast.encryption;
+	memcpy(cp->bcode, qos->bcast.bcode, sizeof(cp->bcode));
+	cp->mse = qos->bcast.mse;
+	cp->timeout = cpu_to_le16(qos->bcast.timeout);
+	cp->num_bis = conn->num_bis;
+	memcpy(cp->bis, conn->bis, conn->num_bis);
+
+	/* The spec allows only one pending LE BIG Create Sync command at
+	 * a time, so we forcefully wait for BIG Sync Established event since
+	 * cmd_work can only schedule one command at a time.
+	 *
+	 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
+	 * page 2586:
+	 *
+	 * If the Host sends this command when the Controller is in the
+	 * process of synchronizing to any BIG, i.e. the HCI_LE_BIG_Sync_
+	 * Established event has not been generated, the Controller shall
+	 * return the error code Command Disallowed (0x0C).
+	 */
+	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_BIG_CREATE_SYNC,
+				       struct_size(cp, bis, cp->num_bis), cp,
+				       HCI_EVT_LE_BIG_SYNC_ESTABLISHED,
+				       conn->conn_timeout, NULL);
+	if (err == -ETIMEDOUT)
+		hci_le_big_terminate_sync(hdev, cp->handle);
+
+	return err;
+}
+
+int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	return hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync, conn,
+				       create_big_complete);
+}
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 644b606743e21..72bf9b1db2247 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1414,14 +1414,13 @@ static void iso_conn_big_sync(struct sock *sk)
 	lock_sock(sk);
 
 	if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
-		err = hci_le_big_create_sync(hdev, iso_pi(sk)->conn->hcon,
-					     &iso_pi(sk)->qos,
-					     iso_pi(sk)->sync_handle,
-					     iso_pi(sk)->bc_num_bis,
-					     iso_pi(sk)->bc_bis);
+		err = hci_conn_big_create_sync(hdev, iso_pi(sk)->conn->hcon,
+					       &iso_pi(sk)->qos,
+					       iso_pi(sk)->sync_handle,
+					       iso_pi(sk)->bc_num_bis,
+					       iso_pi(sk)->bc_bis);
 		if (err)
-			bt_dev_err(hdev, "hci_le_big_create_sync: %d",
-				   err);
+			bt_dev_err(hdev, "hci_big_create_sync: %d", err);
 	}
 
 	release_sock(sk);
@@ -1855,7 +1854,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 		if (test_bit(HCI_CONN_BIG_SYNC, &hcon->flags) ||
 		    test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
 			ev = hci_recv_event_data(hcon->hdev,
-						 HCI_EVT_LE_BIG_SYNC_ESTABILISHED);
+						 HCI_EVT_LE_BIG_SYNC_ESTABLISHED);
 
 			/* Get reference to PA sync parent socket, if it exists */
 			parent = iso_get_sock(&hcon->src, &hcon->dst,
@@ -2047,12 +2046,11 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 			if (!test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags) &&
 			    !test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
-				err = hci_le_big_create_sync(hdev,
-							     hcon,
-							     &iso_pi(sk)->qos,
-							     iso_pi(sk)->sync_handle,
-							     iso_pi(sk)->bc_num_bis,
-							     iso_pi(sk)->bc_bis);
+				err = hci_conn_big_create_sync(hdev, hcon,
+							       &iso_pi(sk)->qos,
+							       iso_pi(sk)->sync_handle,
+							       iso_pi(sk)->bc_num_bis,
+							       iso_pi(sk)->bc_bis);
 				if (err) {
 					bt_dev_err(hdev, "hci_le_big_create_sync: %d",
 						   err);
-- 
2.39.5




