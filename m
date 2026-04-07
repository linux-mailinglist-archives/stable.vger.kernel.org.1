Return-Path: <stable+bounces-233626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNzSODoc1Wli0wcAu9opvQ
	(envelope-from <stable+bounces-233626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:01:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD083B08A7
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26F0D306BA9B
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 14:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621A533D6D2;
	Tue,  7 Apr 2026 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kVFnspdj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DC633C53F
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573773; cv=none; b=bST6cc1oEcYXR+XtpnGjV2zhze9I/9iC3DAsTKznF4CPtzlmq/l6oRhtVCVDTmZ2yx2nsTQkdRuDZvrdxwvGxEoCMJ9iiHidlKluYJBnwi6OP/udGPo/92GxFjBro+/svy2EnYWlmldZl0rGWaKr1jmUptDW8wUvPf6fh0ThW6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573773; c=relaxed/simple;
	bh=DsN61ZJS8ewi7dOzmsSxY1g+TgCEEjfXlSN6JlAbhRU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eHFZE/+KGOVs0cX/9fMIP/7s7L9zmF/r2IMnYYkOWiGprJ+68daQlnBCGbio6q6o4UVjXpGX43yZU9pGh1qqEpR5MHwiSRF/1M8IrlHcwiZiIXzD+2z68AFVkmjY/MmKgUYmarm30MHACcpIQoMPxbjTAeiKH6Z4QI7ih9DUex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kVFnspdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61672C19424;
	Tue,  7 Apr 2026 14:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775573772;
	bh=DsN61ZJS8ewi7dOzmsSxY1g+TgCEEjfXlSN6JlAbhRU=;
	h=Subject:To:Cc:From:Date:From;
	b=kVFnspdjIrbS51XcORYiJ4QxxyqkIh/QKJMmkYnEtrgYRsPRXtoh4tsmFcBZAE3Tk
	 xINDYLZLiTgX+BWc3CBEEio8sCYIBLKfz9vMDRtQIhyoouy6sP8mW57fFQSIqMg4z+
	 6eD7MsqFeiTOQ3cF9DyRlH0DF5tkKwLwEOZp7VO8=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_event: move wake reason storage into validated" failed to apply to 6.1-stable tree
To: security@1seal.org,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 07 Apr 2026 16:56:04 +0200
Message-ID: <2026040704-stature-approve-14e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233626-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RSPAMD_URIBL_FAIL(0.00)[1seal.org:query timed out];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,1seal.org:email,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Queue-Id: 9CD083B08A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2b2bf47cd75518c36fa2d41380e4a40641cc89cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040704-stature-approve-14e3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2b2bf47cd75518c36fa2d41380e4a40641cc89cd Mon Sep 17 00:00:00 2001
From: Oleh Konko <security@1seal.org>
Date: Thu, 26 Mar 2026 17:31:24 +0000
Subject: [PATCH] Bluetooth: hci_event: move wake reason storage into validated
 event handlers

hci_store_wake_reason() is called from hci_event_packet() immediately
after stripping the HCI event header but before hci_event_func()
enforces the per-event minimum payload length from hci_ev_table.
This means a short HCI event frame can reach bacpy() before any bounds
check runs.

Rather than duplicating skb parsing and per-event length checks inside
hci_store_wake_reason(), move wake-address storage into the individual
event handlers after their existing event-length validation has
succeeded. Convert hci_store_wake_reason() into a small helper that only
stores an already-validated bdaddr while the caller holds hci_dev_lock().
Use the same helper after hci_event_func() with a NULL address to
preserve the existing unexpected-wake fallback semantics when no
validated event handler records a wake address.

Annotate the helper with __must_hold(&hdev->lock) and add
lockdep_assert_held(&hdev->lock) so future call paths keep the lock
contract explicit.

Call the helper from hci_conn_request_evt(), hci_conn_complete_evt(),
hci_sync_conn_complete_evt(), le_conn_complete_evt(),
hci_le_adv_report_evt(), hci_le_ext_adv_report_evt(),
hci_le_direct_adv_report_evt(), hci_le_pa_sync_established_evt(), and
hci_le_past_received_evt().

Fixes: 2f20216c1d6f ("Bluetooth: Emit controller suspend and resume events")
Cc: stable@vger.kernel.org
Signed-off-by: Oleh Konko <security@1seal.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 286529d2e554..81d2f9a3eec9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -80,6 +80,10 @@ static void *hci_le_ev_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,
 	return data;
 }
 
+static void hci_store_wake_reason(struct hci_dev *hdev,
+				  const bdaddr_t *bdaddr, u8 addr_type)
+	__must_hold(&hdev->lock);
+
 static u8 hci_cc_inquiry_cancel(struct hci_dev *hdev, void *data,
 				struct sk_buff *skb)
 {
@@ -3111,6 +3115,7 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	hci_dev_lock(hdev);
+	hci_store_wake_reason(hdev, &ev->bdaddr, BDADDR_BREDR);
 
 	/* Check for existing connection:
 	 *
@@ -3274,6 +3279,10 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "bdaddr %pMR type 0x%x", &ev->bdaddr, ev->link_type);
 
+	hci_dev_lock(hdev);
+	hci_store_wake_reason(hdev, &ev->bdaddr, BDADDR_BREDR);
+	hci_dev_unlock(hdev);
+
 	/* Reject incoming connection from device with same BD ADDR against
 	 * CVE-2020-26555
 	 */
@@ -5021,6 +5030,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	hci_dev_lock(hdev);
+	hci_store_wake_reason(hdev, &ev->bdaddr, BDADDR_BREDR);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
 	if (!conn) {
@@ -5713,6 +5723,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	int err;
 
 	hci_dev_lock(hdev);
+	hci_store_wake_reason(hdev, bdaddr, bdaddr_type);
 
 	/* All controllers implicitly stop advertising in the event of a
 	 * connection, so ensure that the state bit is cleared.
@@ -6005,6 +6016,7 @@ static void hci_le_past_received_evt(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
 	hci_dev_lock(hdev);
+	hci_store_wake_reason(hdev, &ev->bdaddr, ev->bdaddr_type);
 
 	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
 
@@ -6403,6 +6415,8 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, void *data,
 					info->length + 1))
 			break;
 
+		hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_type);
+
 		if (info->length <= max_adv_len(hdev)) {
 			rssi = info->data[info->length];
 			process_adv_report(hdev, info->type, &info->bdaddr,
@@ -6491,6 +6505,8 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, void *data,
 					info->length))
 			break;
 
+		hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_type);
+
 		evt_type = __le16_to_cpu(info->type) & LE_EXT_ADV_EVT_TYPE_MASK;
 		legacy_evt_type = ext_evt_type_to_legacy(hdev, evt_type);
 
@@ -6536,6 +6552,7 @@ static void hci_le_pa_sync_established_evt(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
 	hci_dev_lock(hdev);
+	hci_store_wake_reason(hdev, &ev->bdaddr, ev->bdaddr_type);
 
 	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
 
@@ -6834,6 +6851,8 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev, void *data,
 	for (i = 0; i < ev->num; i++) {
 		struct hci_ev_le_direct_adv_info *info = &ev->info[i];
 
+		hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_type);
+
 		process_adv_report(hdev, info->type, &info->bdaddr,
 				   info->bdaddr_type, &info->direct_addr,
 				   info->direct_addr_type, HCI_ADV_PHY_1M, 0,
@@ -7517,73 +7536,29 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
 	return true;
 }
 
-static void hci_store_wake_reason(struct hci_dev *hdev, u8 event,
-				  struct sk_buff *skb)
+static void hci_store_wake_reason(struct hci_dev *hdev,
+				  const bdaddr_t *bdaddr, u8 addr_type)
+	__must_hold(&hdev->lock)
 {
-	struct hci_ev_le_advertising_info *adv;
-	struct hci_ev_le_direct_adv_info *direct_adv;
-	struct hci_ev_le_ext_adv_info *ext_adv;
-	const struct hci_ev_conn_complete *conn_complete = (void *)skb->data;
-	const struct hci_ev_conn_request *conn_request = (void *)skb->data;
-
-	hci_dev_lock(hdev);
+	lockdep_assert_held(&hdev->lock);
 
 	/* If we are currently suspended and this is the first BT event seen,
 	 * save the wake reason associated with the event.
 	 */
 	if (!hdev->suspended || hdev->wake_reason)
-		goto unlock;
+		return;
+
+	if (!bdaddr) {
+		hdev->wake_reason = MGMT_WAKE_REASON_UNEXPECTED;
+		return;
+	}
 
 	/* Default to remote wake. Values for wake_reason are documented in the
 	 * Bluez mgmt api docs.
 	 */
 	hdev->wake_reason = MGMT_WAKE_REASON_REMOTE_WAKE;
-
-	/* Once configured for remote wakeup, we should only wake up for
-	 * reconnections. It's useful to see which device is waking us up so
-	 * keep track of the bdaddr of the connection event that woke us up.
-	 */
-	if (event == HCI_EV_CONN_REQUEST) {
-		bacpy(&hdev->wake_addr, &conn_request->bdaddr);
-		hdev->wake_addr_type = BDADDR_BREDR;
-	} else if (event == HCI_EV_CONN_COMPLETE) {
-		bacpy(&hdev->wake_addr, &conn_complete->bdaddr);
-		hdev->wake_addr_type = BDADDR_BREDR;
-	} else if (event == HCI_EV_LE_META) {
-		struct hci_ev_le_meta *le_ev = (void *)skb->data;
-		u8 subevent = le_ev->subevent;
-		u8 *ptr = &skb->data[sizeof(*le_ev)];
-		u8 num_reports = *ptr;
-
-		if ((subevent == HCI_EV_LE_ADVERTISING_REPORT ||
-		     subevent == HCI_EV_LE_DIRECT_ADV_REPORT ||
-		     subevent == HCI_EV_LE_EXT_ADV_REPORT) &&
-		    num_reports) {
-			adv = (void *)(ptr + 1);
-			direct_adv = (void *)(ptr + 1);
-			ext_adv = (void *)(ptr + 1);
-
-			switch (subevent) {
-			case HCI_EV_LE_ADVERTISING_REPORT:
-				bacpy(&hdev->wake_addr, &adv->bdaddr);
-				hdev->wake_addr_type = adv->bdaddr_type;
-				break;
-			case HCI_EV_LE_DIRECT_ADV_REPORT:
-				bacpy(&hdev->wake_addr, &direct_adv->bdaddr);
-				hdev->wake_addr_type = direct_adv->bdaddr_type;
-				break;
-			case HCI_EV_LE_EXT_ADV_REPORT:
-				bacpy(&hdev->wake_addr, &ext_adv->bdaddr);
-				hdev->wake_addr_type = ext_adv->bdaddr_type;
-				break;
-			}
-		}
-	} else {
-		hdev->wake_reason = MGMT_WAKE_REASON_UNEXPECTED;
-	}
-
-unlock:
-	hci_dev_unlock(hdev);
+	bacpy(&hdev->wake_addr, bdaddr);
+	hdev->wake_addr_type = addr_type;
 }
 
 #define HCI_EV_VL(_op, _func, _min_len, _max_len) \
@@ -7830,14 +7805,15 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	skb_pull(skb, HCI_EVENT_HDR_SIZE);
 
-	/* Store wake reason if we're suspended */
-	hci_store_wake_reason(hdev, event, skb);
-
 	bt_dev_dbg(hdev, "event 0x%2.2x", event);
 
 	hci_event_func(hdev, event, skb, &opcode, &status, &req_complete,
 		       &req_complete_skb);
 
+	hci_dev_lock(hdev);
+	hci_store_wake_reason(hdev, NULL, 0);
+	hci_dev_unlock(hdev);
+
 	if (req_complete) {
 		req_complete(hdev, status, opcode);
 	} else if (req_complete_skb) {


