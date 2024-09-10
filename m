Return-Path: <stable+bounces-75176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E6B973498
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECBE4B2ABC9
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9B8199949;
	Tue, 10 Sep 2024 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tOySWj2t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F83188A28;
	Tue, 10 Sep 2024 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963970; cv=none; b=rU4bs7/bIwq7VI+Xjs8FykxlI+9z9c9vyY0LNBnkp30OhYC15hJ9bcDuLo4AF39iwB/7VkmXPTzDYT+oo3g6RleBtkXENQ1MC9CCTOe5O2lg8KB1t9PMcdS30I8hdnu679VlWwkc3Y65zAbDyIPaWtT/JG90dZtugq8G5Ifr5cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963970; c=relaxed/simple;
	bh=VOL9ybMRhwhd5hVnnkzqzznQ5LXbnO2JEtIcDjSwsMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/KbRudhoL2cJ0h9dfCaZsFriDSDpLU3YkLO9jafZBQAnBzHP9g4n/fO1S6wpah4bKy4TAtRBSc976KmS2+u25tMYuUB5LqDeYFqQSk42Q0YwoCqkyG0NGhPwDsdNAcVOBmg0CaBB0EANsue7jNE3+R9qL5nZb/x9HYpB88IjHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tOySWj2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1BBC4CEC3;
	Tue, 10 Sep 2024 10:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963970;
	bh=VOL9ybMRhwhd5hVnnkzqzznQ5LXbnO2JEtIcDjSwsMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tOySWj2tFoL1Wcu1H3J9bNx3+zhTc7XqpBUxyp54H23kNERR5UVqcHulUPjKpYZdz
	 AbmFdjWMJOXAELFg2ZCPWPWSXnATOSVclW9FDXpAtyZ2XiE3SmV1R2nuo/lrSzm2DV
	 u6AWh2ej3iXg8HOJZ4cTtxKoxTo5uum1C1VPifgA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.6 023/269] Revert "Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE"
Date: Tue, 10 Sep 2024 11:30:10 +0200
Message-ID: <20240910092609.084910691@linuxfoundation.org>
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

commit 532f8bcd1c2c4e8112f62e1922fd1703bc0ffce0 upstream.

This reverts commit 59b047bc98084f8af2c41483e4d68a5adf2fa7f7 which
breaks compatibility with commands like:

bluetoothd[46328]: @ MGMT Command: Load.. (0x0013) plen 74  {0x0001} [hci0]
        Keys: 2
        BR/EDR Address: C0:DC:DA:A5:E5:47 (Samsung Electronics Co.,Ltd)
        Key type: Authenticated key from P-256 (0x03)
        Central: 0x00
        Encryption size: 16
        Diversifier[2]: 0000
        Randomizer[8]: 0000000000000000
        Key[16]: 6ed96089bd9765be2f2c971b0b95f624
        LE Address: D7:2A:DE:1E:73:A2 (Static)
        Key type: Unauthenticated key from P-256 (0x02)
        Central: 0x00
        Encryption size: 16
        Diversifier[2]: 0000
        Randomizer[8]: 0000000000000000
        Key[16]: 87dd2546ededda380ffcdc0a8faa4597
@ MGMT Event: Command Status (0x0002) plen 3                {0x0001} [hci0]
      Load Long Term Keys (0x0013)
        Status: Invalid Parameters (0x0d)

Cc: stable@vger.kernel.org
Link: https://github.com/bluez/bluez/issues/875
Fixes: 59b047bc9808 ("Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/bluetooth/hci_core.h |    5 -----
 net/bluetooth/mgmt.c             |   25 +++++++------------------
 net/bluetooth/smp.c              |    7 -------
 3 files changed, 7 insertions(+), 30 deletions(-)

--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -188,7 +188,6 @@ struct blocked_key {
 struct smp_csrk {
 	bdaddr_t bdaddr;
 	u8 bdaddr_type;
-	u8 link_type;
 	u8 type;
 	u8 val[16];
 };
@@ -198,7 +197,6 @@ struct smp_ltk {
 	struct rcu_head rcu;
 	bdaddr_t bdaddr;
 	u8 bdaddr_type;
-	u8 link_type;
 	u8 authenticated;
 	u8 type;
 	u8 enc_size;
@@ -213,7 +211,6 @@ struct smp_irk {
 	bdaddr_t rpa;
 	bdaddr_t bdaddr;
 	u8 addr_type;
-	u8 link_type;
 	u8 val[16];
 };
 
@@ -221,8 +218,6 @@ struct link_key {
 	struct list_head list;
 	struct rcu_head rcu;
 	bdaddr_t bdaddr;
-	u8 bdaddr_type;
-	u8 link_type;
 	u8 type;
 	u8 val[HCI_LINK_KEY_SIZE];
 	u8 pin_len;
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2827,8 +2827,7 @@ static int load_link_keys(struct sock *s
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_link_key_info *key = &cp->keys[i];
 
-		/* Considering SMP over BREDR/LE, there is no need to check addr_type */
-		if (key->type > 0x08)
+		if (key->addr.type != BDADDR_BREDR || key->type > 0x08)
 			return mgmt_cmd_status(sk, hdev->id,
 					       MGMT_OP_LOAD_LINK_KEYS,
 					       MGMT_STATUS_INVALID_PARAMS);
@@ -7065,7 +7064,6 @@ static int load_irks(struct sock *sk, st
 
 	for (i = 0; i < irk_count; i++) {
 		struct mgmt_irk_info *irk = &cp->irks[i];
-		u8 addr_type = le_addr_type(irk->addr.type);
 
 		if (hci_is_blocked_key(hdev,
 				       HCI_BLOCKED_KEY_TYPE_IRK,
@@ -7075,12 +7073,8 @@ static int load_irks(struct sock *sk, st
 			continue;
 		}
 
-		/* When using SMP over BR/EDR, the addr type should be set to BREDR */
-		if (irk->addr.type == BDADDR_BREDR)
-			addr_type = BDADDR_BREDR;
-
 		hci_add_irk(hdev, &irk->addr.bdaddr,
-			    addr_type, irk->val,
+			    le_addr_type(irk->addr.type), irk->val,
 			    BDADDR_ANY);
 	}
 
@@ -7161,7 +7155,6 @@ static int load_long_term_keys(struct so
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_ltk_info *key = &cp->keys[i];
 		u8 type, authenticated;
-		u8 addr_type = le_addr_type(key->addr.type);
 
 		if (hci_is_blocked_key(hdev,
 				       HCI_BLOCKED_KEY_TYPE_LTK,
@@ -7196,12 +7189,8 @@ static int load_long_term_keys(struct so
 			continue;
 		}
 
-		/* When using SMP over BR/EDR, the addr type should be set to BREDR */
-		if (key->addr.type == BDADDR_BREDR)
-			addr_type = BDADDR_BREDR;
-
 		hci_add_ltk(hdev, &key->addr.bdaddr,
-			    addr_type, type, authenticated,
+			    le_addr_type(key->addr.type), type, authenticated,
 			    key->val, key->enc_size, key->ediv, key->rand);
 	}
 
@@ -9450,7 +9439,7 @@ void mgmt_new_link_key(struct hci_dev *h
 
 	ev.store_hint = persistent;
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(key->link_type, key->bdaddr_type);
+	ev.key.addr.type = BDADDR_BREDR;
 	ev.key.type = key->type;
 	memcpy(ev.key.val, key->val, HCI_LINK_KEY_SIZE);
 	ev.key.pin_len = key->pin_len;
@@ -9501,7 +9490,7 @@ void mgmt_new_ltk(struct hci_dev *hdev,
 		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(key->link_type, key->bdaddr_type);
+	ev.key.addr.type = link_to_bdaddr(LE_LINK, key->bdaddr_type);
 	ev.key.type = mgmt_ltk_type(key);
 	ev.key.enc_size = key->enc_size;
 	ev.key.ediv = key->ediv;
@@ -9530,7 +9519,7 @@ void mgmt_new_irk(struct hci_dev *hdev,
 
 	bacpy(&ev.rpa, &irk->rpa);
 	bacpy(&ev.irk.addr.bdaddr, &irk->bdaddr);
-	ev.irk.addr.type = link_to_bdaddr(irk->link_type, irk->addr_type);
+	ev.irk.addr.type = link_to_bdaddr(LE_LINK, irk->addr_type);
 	memcpy(ev.irk.val, irk->val, sizeof(irk->val));
 
 	mgmt_event(MGMT_EV_NEW_IRK, hdev, &ev, sizeof(ev), NULL);
@@ -9559,7 +9548,7 @@ void mgmt_new_csrk(struct hci_dev *hdev,
 		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &csrk->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(csrk->link_type, csrk->bdaddr_type);
+	ev.key.addr.type = link_to_bdaddr(LE_LINK, csrk->bdaddr_type);
 	ev.key.type = csrk->type;
 	memcpy(ev.key.val, csrk->val, sizeof(csrk->val));
 
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1061,7 +1061,6 @@ static void smp_notify_keys(struct l2cap
 	}
 
 	if (smp->remote_irk) {
-		smp->remote_irk->link_type = hcon->type;
 		mgmt_new_irk(hdev, smp->remote_irk, persistent);
 
 		/* Now that user space can be considered to know the
@@ -1081,28 +1080,24 @@ static void smp_notify_keys(struct l2cap
 	}
 
 	if (smp->csrk) {
-		smp->csrk->link_type = hcon->type;
 		smp->csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->csrk->bdaddr, &hcon->dst);
 		mgmt_new_csrk(hdev, smp->csrk, persistent);
 	}
 
 	if (smp->responder_csrk) {
-		smp->responder_csrk->link_type = hcon->type;
 		smp->responder_csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->responder_csrk->bdaddr, &hcon->dst);
 		mgmt_new_csrk(hdev, smp->responder_csrk, persistent);
 	}
 
 	if (smp->ltk) {
-		smp->ltk->link_type = hcon->type;
 		smp->ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->ltk->bdaddr, &hcon->dst);
 		mgmt_new_ltk(hdev, smp->ltk, persistent);
 	}
 
 	if (smp->responder_ltk) {
-		smp->responder_ltk->link_type = hcon->type;
 		smp->responder_ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->responder_ltk->bdaddr, &hcon->dst);
 		mgmt_new_ltk(hdev, smp->responder_ltk, persistent);
@@ -1122,8 +1117,6 @@ static void smp_notify_keys(struct l2cap
 		key = hci_add_link_key(hdev, smp->conn->hcon, &hcon->dst,
 				       smp->link_key, type, 0, &persistent);
 		if (key) {
-			key->link_type = hcon->type;
-			key->bdaddr_type = hcon->dst_type;
 			mgmt_new_link_key(hdev, key, persistent);
 
 			/* Don't keep debug keys around if the relevant



