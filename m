Return-Path: <stable+bounces-97657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45699E2554
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F6C16A863
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920301F7561;
	Tue,  3 Dec 2024 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eDMEqBqk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2381AB6C9;
	Tue,  3 Dec 2024 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241279; cv=none; b=mj+8y0OBsiDO+RdoM7q6cQWCVGi2GF8T0DjOVnOXh9B2g9WvO5AwK+ljH3DnGNPP08fWpicSugDH9R1gczBJK2IaNgnu9QH1Fs2vejv6JbDWXN/S69W2eygQDbcJjxDm5XJuCVfApkVwFNkyEx0m9b+4cP3rx+fg6vXiPrjdsis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241279; c=relaxed/simple;
	bh=vNm7beoOGDLzFSlBYyx7PYcQ5e8kldJrWL3Jt40SbWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRvLdWycmxxonCP5Igp3THwijSuv20SPF7CqjZsP+qITpS61EsT2wsi/aYCVFEGS6lvO9ue+pW4kwTn2LfPOymi4q7NwUxCXLtzsQTuk7cnkSS3huGa2CQzDH1FBuIInnP6Z4aSAqYS0yp+P7P4o/PMfKmpkQlAJ8TMB78oMt5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eDMEqBqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA154C4CECF;
	Tue,  3 Dec 2024 15:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733241279;
	bh=vNm7beoOGDLzFSlBYyx7PYcQ5e8kldJrWL3Jt40SbWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eDMEqBqk/QOiIdWfRUNRZ0G0H4WPZgYBjwnFUK3anqSunQYw2vqYJRbIxIb9sIYfz
	 7GHNN1vNTPdeW2fSO3iP/R5nY5W160R/rVTTTdBMgFKqqrJw4RLeCBogWY1UA8Y1ab
	 1VJO6Fd1B+keYb4P2/lLbSCfRuEbYlKoRtibTVvI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 343/826] Bluetooth: ISO: Do not emit LE BIG Create Sync if previous is pending
Date: Tue,  3 Dec 2024 15:41:10 +0100
Message-ID: <20241203144757.140190559@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Iulia Tanasescu <iulia.tanasescu@nxp.com>

[ Upstream commit 42ecf1947135110ea08abeaca39741636f9a2285 ]

The Bluetooth Core spec does not allow a LE BIG Create sync command to be
sent to Controller if another one is pending (Vol 4, Part E, page 2586).

In order to avoid this issue, the HCI_CONN_CREATE_BIG_SYNC was added
to mark that the LE BIG Create Sync command has been sent for a hcon.
Once the BIG Sync Established event is received, the hcon flag is
erased and the next pending hcon is handled.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 07a9342b94a9 ("Bluetooth: ISO: Send BIG Create Sync via hci_sync")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h | 29 +++++++++++
 net/bluetooth/hci_conn.c         | 87 +++++++++++++++++++++++++++-----
 net/bluetooth/hci_event.c        | 20 +++++++-
 net/bluetooth/iso.c              |  4 +-
 5 files changed, 125 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 4734e9e99972f..a1864cff616ae 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -29,6 +29,7 @@
 #define HCI_MAX_ACL_SIZE	1024
 #define HCI_MAX_SCO_SIZE	255
 #define HCI_MAX_ISO_SIZE	251
+#define HCI_MAX_ISO_BIS		31
 #define HCI_MAX_EVENT_SIZE	260
 #define HCI_MAX_FRAME_SIZE	(HCI_MAX_ACL_SIZE + 4)
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 494fcd68f8311..4c185a08c3a3a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -711,6 +711,9 @@ struct hci_conn {
 	__s8		tx_power;
 	__s8		max_tx_power;
 	struct bt_iso_qos iso_qos;
+	__u8		num_bis;
+	__u8		bis[HCI_MAX_ISO_BIS];
+
 	unsigned long	flags;
 
 	enum conn_reasons conn_reason;
@@ -946,6 +949,7 @@ enum {
 	HCI_CONN_PER_ADV,
 	HCI_CONN_BIG_CREATED,
 	HCI_CONN_CREATE_CIS,
+	HCI_CONN_CREATE_BIG_SYNC,
 	HCI_CONN_BIG_SYNC,
 	HCI_CONN_BIG_SYNC_FAILED,
 	HCI_CONN_CREATE_PA_SYNC,
@@ -1295,6 +1299,30 @@ static inline struct hci_conn *hci_conn_hash_lookup_big(struct hci_dev *hdev,
 	return NULL;
 }
 
+static inline struct hci_conn *
+hci_conn_hash_lookup_big_sync_pend(struct hci_dev *hdev,
+				   __u8 handle, __u8 num_bis)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type != ISO_LINK)
+			continue;
+
+		if (handle == c->iso_qos.bcast.big && num_bis == c->num_bis) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
+
 static inline struct hci_conn *
 hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,  __u16 state)
 {
@@ -1479,6 +1507,7 @@ void hci_sco_setup(struct hci_conn *conn, __u8 status);
 bool hci_iso_setup_path(struct hci_conn *conn);
 int hci_le_create_cis_pending(struct hci_dev *hdev);
 int hci_pa_create_sync_pending(struct hci_dev *hdev);
+int hci_le_big_create_sync_pending(struct hci_dev *hdev);
 int hci_conn_check_create_cis(struct hci_conn *conn);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6878fc5206c0b..1ff62bf9d41b4 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2180,34 +2180,93 @@ struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 	return conn;
 }
 
+static bool hci_conn_check_create_big_sync(struct hci_conn *conn)
+{
+	if (!conn->num_bis)
+		return false;
+
+	return true;
+}
+
+int hci_le_big_create_sync_pending(struct hci_dev *hdev)
+{
+	DEFINE_FLEX(struct hci_cp_le_big_create_sync, pdu, bis, num_bis, 0x11);
+	struct hci_conn *conn;
+
+	rcu_read_lock();
+
+	pdu->num_bis = 0;
+
+	/* The spec allows only one pending LE BIG Create Sync command at
+	 * a time. If the command is pending now, don't do anything. We
+	 * check for pending connections after each BIG Sync Established
+	 * event.
+	 *
+	 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
+	 * page 2586:
+	 *
+	 * If the Host sends this command when the Controller is in the
+	 * process of synchronizing to any BIG, i.e. the HCI_LE_BIG_Sync_
+	 * Established event has not been generated, the Controller shall
+	 * return the error code Command Disallowed (0x0C).
+	 */
+	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
+		if (test_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags))
+			goto unlock;
+	}
+
+	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
+		if (hci_conn_check_create_big_sync(conn)) {
+			struct bt_iso_qos *qos = &conn->iso_qos;
+
+			set_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
+
+			pdu->handle = qos->bcast.big;
+			pdu->sync_handle = cpu_to_le16(conn->sync_handle);
+			pdu->encryption = qos->bcast.encryption;
+			memcpy(pdu->bcode, qos->bcast.bcode,
+			       sizeof(pdu->bcode));
+			pdu->mse = qos->bcast.mse;
+			pdu->timeout = cpu_to_le16(qos->bcast.timeout);
+			pdu->num_bis = conn->num_bis;
+			memcpy(pdu->bis, conn->bis, conn->num_bis);
+
+			break;
+		}
+	}
+
+unlock:
+	rcu_read_unlock();
+
+	if (!pdu->num_bis)
+		return 0;
+
+	return hci_send_cmd(hdev, HCI_OP_LE_BIG_CREATE_SYNC,
+			    struct_size(pdu, bis, pdu->num_bis), pdu);
+}
+
 int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
 			   struct bt_iso_qos *qos,
 			   __u16 sync_handle, __u8 num_bis, __u8 bis[])
 {
-	DEFINE_FLEX(struct hci_cp_le_big_create_sync, pdu, bis, num_bis, 0x11);
 	int err;
 
-	if (num_bis < 0x01 || num_bis > pdu->num_bis)
+	if (num_bis < 0x01 || num_bis > ISO_MAX_NUM_BIS)
 		return -EINVAL;
 
 	err = qos_set_big(hdev, qos);
 	if (err)
 		return err;
 
-	if (hcon)
-		hcon->iso_qos.bcast.big = qos->bcast.big;
+	if (hcon) {
+		/* Update hcon QoS */
+		hcon->iso_qos = *qos;
 
-	pdu->handle = qos->bcast.big;
-	pdu->sync_handle = cpu_to_le16(sync_handle);
-	pdu->encryption = qos->bcast.encryption;
-	memcpy(pdu->bcode, qos->bcast.bcode, sizeof(pdu->bcode));
-	pdu->mse = qos->bcast.mse;
-	pdu->timeout = cpu_to_le16(qos->bcast.timeout);
-	pdu->num_bis = num_bis;
-	memcpy(pdu->bis, bis, num_bis);
+		hcon->num_bis = num_bis;
+		memcpy(hcon->bis, bis, num_bis);
+	}
 
-	return hci_send_cmd(hdev, HCI_OP_LE_BIG_CREATE_SYNC,
-			    struct_size(pdu, bis, num_bis), pdu);
+	return hci_le_big_create_sync_pending(hdev);
 }
 
 static void create_big_complete(struct hci_dev *hdev, void *data, int err)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 81001cd53e01c..2e4bd3e961ce0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6913,7 +6913,7 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 					    struct sk_buff *skb)
 {
 	struct hci_evt_le_big_sync_estabilished *ev = data;
-	struct hci_conn *bis;
+	struct hci_conn *bis, *conn;
 	int i;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
@@ -6924,6 +6924,20 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	conn = hci_conn_hash_lookup_big_sync_pend(hdev, ev->handle,
+						  ev->num_bis);
+	if (!conn) {
+		bt_dev_err(hdev,
+			   "Unable to find connection for big 0x%2.2x",
+			   ev->handle);
+		goto unlock;
+	}
+
+	clear_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
+
+	conn->num_bis = 0;
+	memset(conn->bis, 0, sizeof(conn->num_bis));
+
 	for (i = 0; i < ev->num_bis; i++) {
 		u16 handle = le16_to_cpu(ev->bis[i]);
 		__le32 interval;
@@ -6973,6 +6987,10 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 			hci_connect_cfm(bis, ev->status);
 		}
 
+unlock:
+	/* Handle any other pending BIG sync command */
+	hci_le_big_create_sync_pending(hdev);
+
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 109bf58c982ae..463c61712b249 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1996,6 +1996,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 		if (sk) {
 			int err;
+			struct hci_conn	*hcon = iso_pi(sk)->conn->hcon;
 
 			iso_pi(sk)->qos.bcast.encryption = ev2->encryption;
 
@@ -2004,7 +2005,8 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 			if (!test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags) &&
 			    !test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
-				err = hci_le_big_create_sync(hdev, NULL,
+				err = hci_le_big_create_sync(hdev,
+							     hcon,
 							     &iso_pi(sk)->qos,
 							     iso_pi(sk)->sync_handle,
 							     iso_pi(sk)->bc_num_bis,
-- 
2.43.0




