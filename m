Return-Path: <stable+bounces-153865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039A4ADD6EF
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CA594A0601
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE3A2DFF16;
	Tue, 17 Jun 2025 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tYqdm7ut"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B092DFF33;
	Tue, 17 Jun 2025 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177347; cv=none; b=eIuQUutWlPCPfR0dfHVKY5yscOIRw4p7f0b55IFe11qRo3lrhQzv4i4YOgzZliwN2FMJKJncyqnGqsBFqfU6uNU5jf18Keos/MdutN2lcD65cN6zLmtt8ohYGqpAANpdBduYpYBIOyad6bIXXl6D0BeqE69fcbDZxZHRDeg9hiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177347; c=relaxed/simple;
	bh=AR+PD21dwMdXoylaxojkr09spV+mxmj5xbYocxlQFGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOvn4TVc15SpIvFwxXesCn72oLXeWnRJpNLKLlpUZRZEGZKXunL1nkS5uw8K0RlDw15yX1dhy3gzfjxL1O5fvVhYCzcMVWz41oxpJR1ASEfIHiHRV8Bvn+Mi3WZaOUlxbtrSdrDoHmmKhUANUAj6jTge8lOlhoIAilrq0rw9T+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tYqdm7ut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3A4C4CEE3;
	Tue, 17 Jun 2025 16:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750177346;
	bh=AR+PD21dwMdXoylaxojkr09spV+mxmj5xbYocxlQFGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYqdm7utoIM/1zQvkrB9cnR2TKJtCiKeUsA7l1n4Bov3JOnLDNGWCmSt5wCNvCOxt
	 WiU9OiT17CTMrWG13/gX5loF5bJouAj8pJ9BN7Si7ivdEzXjZgyi0T6q9U4pSsgopp
	 ALBuNFQaC6UxphHyJ/a9Dx7Yx1tKRGJtoPdhWxFo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 293/780] Bluetooth: ISO: Fix not using SID from adv report
Date: Tue, 17 Jun 2025 17:20:01 +0200
Message-ID: <20250617152503.400713188@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit e2d471b7806b09744d65a64bcf41337468f2443b ]

Up until now it has been assumed that the application would be able to
enter the advertising SID in sockaddr_iso_bc.bc_sid, but userspace has
no access to SID since the likes of MGMT_EV_DEVICE_FOUND cannot carry
it, so it was left unset (0x00) which means it would be unable to
synchronize if the broadcast source is using a different SID e.g. 0x04:

> HCI Event: LE Meta Event (0x3e) plen 57
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x0000
            Props: 0x0000
            Data status: Complete
          Address type: Random (0x01)
          Address: 0B:82:E8:50:6D:C8 (Non-Resolvable)
          Primary PHY: LE 1M
          Secondary PHY: LE 2M
          SID: 0x04
          TX power: 127 dBm
          RSSI: -55 dBm (0xc9)
          Periodic advertising interval: 180.00 msec (0x0090)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 0x1f
        06 16 52 18 5b 0b e1 05 16 56 18 04 00 11 30 4c  ..R.[....V....0L
        75 69 7a 27 73 20 53 32 33 20 55 6c 74 72 61     uiz's S23 Ultra
        Service Data: Broadcast Audio Announcement (0x1852)
        Broadcast ID: 14748507 (0xe10b5b)
        Service Data: Public Broadcast Announcement (0x1856)
          Data[2]: 0400
        Unknown EIR field 0x30[16]: 4c75697a27732053323320556c747261
< HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044) plen 14
        Options: 0x0000
        Use advertising SID, Advertiser Address Type and address
        Reporting initially enabled
        SID: 0x00 (<- Invalid)
        Adv address type: Random (0x01)
        Adv address: 0B:82:E8:50:6D:C8 (Non-Resolvable)
        Skip: 0x0000
        Sync timeout: 20000 msec (0x07d0)
        Sync CTE type: 0x0000

So instead this changes now allow application to set HCI_SID_INVALID
which will make hci_le_pa_create_sync to wait for a report, update the
conn->sid using the report SID and only then issue PA create sync
command:

< HCI Command: LE Periodic Advertising Create Sync
        Options: 0x0000
        Use advertising SID, Advertiser Address Type and address
        Reporting initially enabled
        SID: 0x04
        Adv address type: Random (0x01)
        Adv address: 0B:82:E8:50:6D:C8 (Non-Resolvable)
        Skip: 0x0000
        Sync timeout: 20000 msec (0x07d0)
        Sync CTE type: 0x0000
> HCI Event: LE Meta Event (0x3e) plen 16
      LE Periodic Advertising Sync Established (0x0e)
        Status: Success (0x00)
        Sync handle: 64
        Advertising SID: 0x04
        Advertiser address type: Random (0x01)
        Advertiser address: 0B:82:E8:50:6D:C8 (Non-Resolvable)
        Advertiser PHY: LE 2M (0x02)
        Periodic advertising interval: 180.00 msec (0x0090)
        Advertiser clock accuracy: 0x05

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 23205562ffc8 ("Bluetooth: separate CIS_LINK and BIS_LINK link types")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_conn.c  |  2 ++
 net/bluetooth/hci_core.c  | 13 ++++++-----
 net/bluetooth/hci_event.c | 16 ++++++++++++-
 net/bluetooth/hci_sync.c  | 49 +++++++++++++++++++++++++++++++++++----
 net/bluetooth/iso.c       |  9 +++++--
 5 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 946d2ae551f86..c0207812f4328 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2070,6 +2070,8 @@ struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 {
 	struct hci_conn *conn;
 
+	bt_dev_dbg(hdev, "dst %pMR type %d sid %d", dst, dst_type, sid);
+
 	conn = hci_conn_add_unset(hdev, ISO_LINK, dst, HCI_ROLE_SLAVE);
 	if (IS_ERR(conn))
 		return conn;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5eb0600bbd03c..75da6f6e39c9e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4057,10 +4057,13 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	}
 
-	err = hci_send_frame(hdev, skb);
-	if (err < 0) {
-		hci_cmd_sync_cancel_sync(hdev, -err);
-		return;
+	if (hci_skb_opcode(skb) != HCI_OP_NOP) {
+		err = hci_send_frame(hdev, skb);
+		if (err < 0) {
+			hci_cmd_sync_cancel_sync(hdev, -err);
+			return;
+		}
+		atomic_dec(&hdev->cmd_cnt);
 	}
 
 	if (hdev->req_status == HCI_REQ_PEND &&
@@ -4068,8 +4071,6 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
 	}
-
-	atomic_dec(&hdev->cmd_cnt);
 }
 
 static void hci_cmd_work(struct work_struct *work)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c38ada69c3d7f..4183560582a3a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6351,6 +6351,17 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, void *data,
 			info->secondary_phy &= 0x1f;
 		}
 
+		/* Check if PA Sync is pending and if the hci_conn SID has not
+		 * been set update it.
+		 */
+		if (hci_dev_test_flag(hdev, HCI_PA_SYNC)) {
+			struct hci_conn *conn;
+
+			conn = hci_conn_hash_lookup_create_pa_sync(hdev);
+			if (conn && conn->sid == HCI_SID_INVALID)
+				conn->sid = info->sid;
+		}
+
 		if (legacy_evt_type != LE_ADV_INVALID) {
 			process_adv_report(hdev, legacy_evt_type, &info->bdaddr,
 					   info->bdaddr_type, NULL, 0,
@@ -7155,7 +7166,8 @@ static void hci_le_meta_evt(struct hci_dev *hdev, void *data,
 
 	/* Only match event if command OGF is for LE */
 	if (hdev->req_skb &&
-	    hci_opcode_ogf(hci_skb_opcode(hdev->req_skb)) == 0x08 &&
+	   (hci_opcode_ogf(hci_skb_opcode(hdev->req_skb)) == 0x08 ||
+	    hci_skb_opcode(hdev->req_skb) == HCI_OP_NOP) &&
 	    hci_skb_event(hdev->req_skb) == ev->subevent) {
 		*opcode = hci_skb_opcode(hdev->req_skb);
 		hci_req_cmd_complete(hdev, *opcode, 0x00, req_complete,
@@ -7511,8 +7523,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		goto done;
 	}
 
+	hci_dev_lock(hdev);
 	kfree_skb(hdev->recv_event);
 	hdev->recv_event = skb_clone(skb, GFP_KERNEL);
+	hci_dev_unlock(hdev);
 
 	event = hdr->evt;
 	if (!event) {
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e56b1cbedab90..d00ff18f3be0d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6898,20 +6898,37 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 
 static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 {
+	struct hci_conn *conn = data;
+	struct hci_conn *pa_sync;
+
 	bt_dev_dbg(hdev, "err %d", err);
 
-	if (!err)
+	if (err == -ECANCELED)
 		return;
 
+	hci_dev_lock(hdev);
+
 	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
 
-	if (err == -ECANCELED)
-		return;
+	if (!hci_conn_valid(hdev, conn))
+		clear_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
 
-	hci_dev_lock(hdev);
+	if (!err)
+		goto unlock;
 
-	hci_update_passive_scan_sync(hdev);
+	/* Add connection to indicate PA sync error */
+	pa_sync = hci_conn_add_unset(hdev, ISO_LINK, BDADDR_ANY,
+				     HCI_ROLE_SLAVE);
 
+	if (IS_ERR(pa_sync))
+		goto unlock;
+
+	set_bit(HCI_CONN_PA_SYNC_FAILED, &pa_sync->flags);
+
+	/* Notify iso layer */
+	hci_connect_cfm(pa_sync, bt_status(err));
+
+unlock:
 	hci_dev_unlock(hdev);
 }
 
@@ -6925,9 +6942,23 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 	if (!hci_conn_valid(hdev, conn))
 		return -ECANCELED;
 
+	if (conn->sync_handle != HCI_SYNC_HANDLE_INVALID)
+		return -EINVAL;
+
 	if (hci_dev_test_and_set_flag(hdev, HCI_PA_SYNC))
 		return -EBUSY;
 
+	/* Stop scanning if SID has not been set and active scanning is enabled
+	 * so we use passive scanning which will be scanning using the allow
+	 * list programmed to contain only the connection address.
+	 */
+	if (conn->sid == HCI_SID_INVALID &&
+	    hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
+		hci_scan_disable_sync(hdev);
+		hci_dev_set_flag(hdev, HCI_LE_SCAN_INTERRUPTED);
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+	}
+
 	/* Mark HCI_CONN_CREATE_PA_SYNC so hci_update_passive_scan_sync can
 	 * program the address in the allow list so PA advertisements can be
 	 * received.
@@ -6936,6 +6967,14 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 
 	hci_update_passive_scan_sync(hdev);
 
+	/* SID has not been set listen for HCI_EV_LE_EXT_ADV_REPORT to update
+	 * it.
+	 */
+	if (conn->sid == HCI_SID_INVALID)
+		__hci_cmd_sync_status_sk(hdev, HCI_OP_NOP, 0, NULL,
+					 HCI_EV_LE_EXT_ADV_REPORT,
+					 conn->conn_timeout, NULL);
+
 	memset(&cp, 0, sizeof(cp));
 	cp.options = qos->bcast.options;
 	cp.sid = conn->sid;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 2819cda616bce..7c0012ce1b890 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -941,7 +941,7 @@ static int iso_sock_bind_bc(struct socket *sock, struct sockaddr *addr,
 
 	iso_pi(sk)->dst_type = sa->iso_bc->bc_bdaddr_type;
 
-	if (sa->iso_bc->bc_sid > 0x0f)
+	if (sa->iso_bc->bc_sid > 0x0f && sa->iso_bc->bc_sid != HCI_SID_INVALID)
 		return -EINVAL;
 
 	iso_pi(sk)->bc_sid = sa->iso_bc->bc_sid;
@@ -2029,6 +2029,9 @@ static bool iso_match_sid(struct sock *sk, void *data)
 {
 	struct hci_ev_le_pa_sync_established *ev = data;
 
+	if (iso_pi(sk)->bc_sid == HCI_SID_INVALID)
+		return true;
+
 	return ev->sid == iso_pi(sk)->bc_sid;
 }
 
@@ -2075,8 +2078,10 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	if (ev1) {
 		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sid, ev1);
-		if (sk && !ev1->status)
+		if (sk && !ev1->status) {
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1->handle);
+			iso_pi(sk)->bc_sid = ev1->sid;
+		}
 
 		goto done;
 	}
-- 
2.39.5




