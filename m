Return-Path: <stable+bounces-93330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527A59CD8A7
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D0D283C8F
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AAA18B463;
	Fri, 15 Nov 2024 06:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YUQahcVr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD76188A18;
	Fri, 15 Nov 2024 06:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653561; cv=none; b=u8nNJd18lerjcKaNAv9VGy5Ff/N2geSyTHwWptyfYw4cuAZK6RYJh74XePg6NILdkqG6B7L/H2S4/tYqyjDIA/HpGoOxqU8U8qItOWjw10cYfzk+DGZ7AbxA14YTwjxO19yDrCDtWzAD/XuYcGDObIm4lsl888X/6MtSLYtx6Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653561; c=relaxed/simple;
	bh=Ct6gU2CAhEBQ6Xn2e11mmTJ8vabXqFl66y2OKhxSoXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTMm83CA+X9Tzd6Z6VMMm+jTDas/CB+ZXUYLBA3vugQCUttm9RQTcjAg1dtT48o0whBdcsrp3UrzP6eq48s+EUVXleuyJ8vIgpW6owEcUbfIqBYh3pOKlCtiFkfwQd6/9ZhxDlyIpI3nUEI4l+F48ve8MzQd8q72YV1clJxCWp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YUQahcVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED89FC4CECF;
	Fri, 15 Nov 2024 06:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653561;
	bh=Ct6gU2CAhEBQ6Xn2e11mmTJ8vabXqFl66y2OKhxSoXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUQahcVr43+AQWAIg6YDaa4v2YJH9N2eKkq+Zf3ogzVqPHQzE2xBh9UCgZs0RDq/z
	 sgd9BOfrKzMSL1emhY26mzGrcMm40NOZ5pWvygA5Qyq2PlqbcnxOR+wMTIIGanyTJI
	 p49805APiXHSdojJA5Ws6D+V9M22vJe8aVBK+ZLU=
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
Subject: [PATCH 6.1 02/39] Revert "Bluetooth: hci_sync: Fix overwriting request callback"
Date: Fri, 15 Nov 2024 07:38:12 +0100
Message-ID: <20241115063722.693856729@linuxfoundation.org>
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

This reverts commit da77c1d39bc527b31890bfa0405763c82828defb which is
commit 2615fd9a7c2507eb3be3fbe49dcec88a2f56454a upstream.

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
 include/net/bluetooth/hci_core.h |    1 
 net/bluetooth/hci_conn.c         |    2 -
 net/bluetooth/hci_core.c         |   46 +++++++++++----------------------------
 net/bluetooth/hci_event.c        |   18 +++++++--------
 net/bluetooth/hci_sync.c         |   21 ++---------------
 5 files changed, 27 insertions(+), 61 deletions(-)

--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -544,7 +544,6 @@ struct hci_dev {
 	__u32			req_status;
 	__u32			req_result;
 	struct sk_buff		*req_skb;
-	struct sk_buff		*req_rsp;
 
 	void			*smp_data;
 	void			*smp_bredr_data;
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2816,7 +2816,7 @@ int hci_abort_conn(struct hci_conn *conn
 		case HCI_EV_LE_CONN_COMPLETE:
 		case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
 		case HCI_EVT_LE_CIS_ESTABLISHED:
-			hci_cmd_sync_cancel(hdev, ECANCELED);
+			hci_cmd_sync_cancel(hdev, -ECANCELED);
 			break;
 		}
 	}
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1452,8 +1452,8 @@ static void hci_cmd_timeout(struct work_
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    cmd_timer.work);
 
-	if (hdev->req_skb) {
-		u16 opcode = hci_skb_opcode(hdev->req_skb);
+	if (hdev->sent_cmd) {
+		u16 opcode = hci_skb_opcode(hdev->sent_cmd);
 
 		bt_dev_err(hdev, "command 0x%4.4x tx timeout", opcode);
 
@@ -2762,7 +2762,6 @@ void hci_release_dev(struct hci_dev *hde
 
 	ida_simple_remove(&hci_index_ida, hdev->id);
 	kfree_skb(hdev->sent_cmd);
-	kfree_skb(hdev->req_skb);
 	kfree_skb(hdev->recv_event);
 	kfree(hdev);
 }
@@ -3092,33 +3091,21 @@ int __hci_cmd_send(struct hci_dev *hdev,
 EXPORT_SYMBOL(__hci_cmd_send);
 
 /* Get data from the previously sent command */
-static void *hci_cmd_data(struct sk_buff *skb, __u16 opcode)
+void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
 {
 	struct hci_command_hdr *hdr;
 
-	if (!skb || skb->len < HCI_COMMAND_HDR_SIZE)
+	if (!hdev->sent_cmd)
 		return NULL;
 
-	hdr = (void *)skb->data;
+	hdr = (void *) hdev->sent_cmd->data;
 
 	if (hdr->opcode != cpu_to_le16(opcode))
 		return NULL;
 
-	return skb->data + HCI_COMMAND_HDR_SIZE;
-}
+	BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
 
-/* Get data from the previously sent command */
-void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
-{
-	void *data;
-
-	/* Check if opcode matches last sent command */
-	data = hci_cmd_data(hdev->sent_cmd, opcode);
-	if (!data)
-		/* Check if opcode matches last request */
-		data = hci_cmd_data(hdev->req_skb, opcode);
-
-	return data;
+	return hdev->sent_cmd->data + HCI_COMMAND_HDR_SIZE;
 }
 
 /* Get data from last received event */
@@ -4014,19 +4001,17 @@ void hci_req_cmd_complete(struct hci_dev
 	if (!status && !hci_req_is_complete(hdev))
 		return;
 
-	skb = hdev->req_skb;
-
 	/* If this was the last command in a request the complete
-	 * callback would be found in hdev->req_skb instead of the
+	 * callback would be found in hdev->sent_cmd instead of the
 	 * command queue (hdev->cmd_q).
 	 */
-	if (skb && bt_cb(skb)->hci.req_flags & HCI_REQ_SKB) {
-		*req_complete_skb = bt_cb(skb)->hci.req_complete_skb;
+	if (bt_cb(hdev->sent_cmd)->hci.req_flags & HCI_REQ_SKB) {
+		*req_complete_skb = bt_cb(hdev->sent_cmd)->hci.req_complete_skb;
 		return;
 	}
 
-	if (skb && bt_cb(skb)->hci.req_complete) {
-		*req_complete = bt_cb(skb)->hci.req_complete;
+	if (bt_cb(hdev->sent_cmd)->hci.req_complete) {
+		*req_complete = bt_cb(hdev->sent_cmd)->hci.req_complete;
 		return;
 	}
 
@@ -4143,11 +4128,8 @@ static void hci_send_cmd_sync(struct hci
 		return;
 	}
 
-	if (hci_req_status_pend(hdev) &&
-	    !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
-		kfree_skb(hdev->req_skb);
-		hdev->req_skb = skb_clone(skb, GFP_KERNEL);
-	}
+	if (hci_req_status_pend(hdev))
+		hci_dev_set_flag(hdev, HCI_CMD_PENDING);
 
 	atomic_dec(&hdev->cmd_cnt);
 }
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4354,7 +4354,7 @@ static void hci_cmd_status_evt(struct hc
 	 * (since for this kind of commands there will not be a command
 	 * complete event).
 	 */
-	if (ev->status || (hdev->req_skb && !hci_skb_event(hdev->req_skb))) {
+	if (ev->status || (hdev->sent_cmd && !hci_skb_event(hdev->sent_cmd))) {
 		hci_req_cmd_complete(hdev, *opcode, ev->status, req_complete,
 				     req_complete_skb);
 		if (hci_dev_test_flag(hdev, HCI_CMD_PENDING)) {
@@ -7171,10 +7171,10 @@ static void hci_le_meta_evt(struct hci_d
 	bt_dev_dbg(hdev, "subevent 0x%2.2x", ev->subevent);
 
 	/* Only match event if command OGF is for LE */
-	if (hdev->req_skb &&
-	    hci_opcode_ogf(hci_skb_opcode(hdev->req_skb)) == 0x08 &&
-	    hci_skb_event(hdev->req_skb) == ev->subevent) {
-		*opcode = hci_skb_opcode(hdev->req_skb);
+	if (hdev->sent_cmd &&
+	    hci_opcode_ogf(hci_skb_opcode(hdev->sent_cmd)) == 0x08 &&
+	    hci_skb_event(hdev->sent_cmd) == ev->subevent) {
+		*opcode = hci_skb_opcode(hdev->sent_cmd);
 		hci_req_cmd_complete(hdev, *opcode, 0x00, req_complete,
 				     req_complete_skb);
 	}
@@ -7561,10 +7561,10 @@ void hci_event_packet(struct hci_dev *hd
 	}
 
 	/* Only match event if command OGF is not for LE */
-	if (hdev->req_skb &&
-	    hci_opcode_ogf(hci_skb_opcode(hdev->req_skb)) != 0x08 &&
-	    hci_skb_event(hdev->req_skb) == event) {
-		hci_req_cmd_complete(hdev, hci_skb_opcode(hdev->req_skb),
+	if (hdev->sent_cmd &&
+	    hci_opcode_ogf(hci_skb_opcode(hdev->sent_cmd)) != 0x08 &&
+	    hci_skb_event(hdev->sent_cmd) == event) {
+		hci_req_cmd_complete(hdev, hci_skb_opcode(hdev->sent_cmd),
 				     status, &req_complete, &req_complete_skb);
 		req_evt = event;
 	}
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -31,10 +31,6 @@ static void hci_cmd_sync_complete(struct
 	hdev->req_result = result;
 	hdev->req_status = HCI_REQ_DONE;
 
-	/* Free the request command so it is not used as response */
-	kfree_skb(hdev->req_skb);
-	hdev->req_skb = NULL;
-
 	if (skb) {
 		struct sock *sk = hci_skb_sk(skb);
 
@@ -42,7 +38,7 @@ static void hci_cmd_sync_complete(struct
 		if (sk)
 			sock_put(sk);
 
-		hdev->req_rsp = skb_get(skb);
+		hdev->req_skb = skb_get(skb);
 	}
 
 	wake_up_interruptible(&hdev->req_wait_q);
@@ -190,8 +186,8 @@ struct sk_buff *__hci_cmd_sync_sk(struct
 
 	hdev->req_status = 0;
 	hdev->req_result = 0;
-	skb = hdev->req_rsp;
-	hdev->req_rsp = NULL;
+	skb = hdev->req_skb;
+	hdev->req_skb = NULL;
 
 	bt_dev_dbg(hdev, "end: err %d", err);
 
@@ -4941,11 +4937,6 @@ int hci_dev_open_sync(struct hci_dev *hd
 			hdev->sent_cmd = NULL;
 		}
 
-		if (hdev->req_skb) {
-			kfree_skb(hdev->req_skb);
-			hdev->req_skb = NULL;
-		}
-
 		clear_bit(HCI_RUNNING, &hdev->flags);
 		hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
 
@@ -5107,12 +5098,6 @@ int hci_dev_close_sync(struct hci_dev *h
 		hdev->sent_cmd = NULL;
 	}
 
-	/* Drop last request */
-	if (hdev->req_skb) {
-		kfree_skb(hdev->req_skb);
-		hdev->req_skb = NULL;
-	}
-
 	clear_bit(HCI_RUNNING, &hdev->flags);
 	hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
 



