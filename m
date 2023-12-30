Return-Path: <stable+bounces-8871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAA582053E
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6112D1F21520
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DB079EF;
	Sat, 30 Dec 2023 12:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lrq3RdB8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693D079DC;
	Sat, 30 Dec 2023 12:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60EFC433C8;
	Sat, 30 Dec 2023 12:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703937979;
	bh=sQJigKFAQ5CZ8wuXB8JGhUedE3J/QvZeoH3i8dJeQe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lrq3RdB8AqRzEn3UZd/7+X/hmdgnsbvGfyMzNlqfmSQarmG2FGyBBNIklO2At/mk0
	 uoNWf2sWWO8UaHkViB10I26gIUeG0ho/sK6gTdlDXp/TWctznpU86RuI2Wn1HjiXuT
	 gKaZf3rw2LTTG0cHtElYVatq/wPg1i9WXM+W2nhg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiao Yao <xiaoyao@rock-chips.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.6 112/156] Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE
Date: Sat, 30 Dec 2023 11:59:26 +0000
Message-ID: <20231230115816.026693764@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
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

From: Xiao Yao <xiaoyao@rock-chips.com>

commit 59b047bc98084f8af2c41483e4d68a5adf2fa7f7 upstream.

If two Bluetooth devices both support BR/EDR and BLE, and also
support Secure Connections, then they only need to pair once.
The LTK generated during the LE pairing process may be converted
into a BR/EDR link key for BR/EDR transport, and conversely, a
link key generated during the BR/EDR SSP pairing process can be
converted into an LTK for LE transport. Hence, the link type of
the link key and LTK is not fixed, they can be either an LE LINK
or an ACL LINK.

Currently, in the mgmt_new_irk/ltk/crsk/link_key functions, the
link type is fixed, which could lead to incorrect address types
being reported to the application layer. Therefore, it is necessary
to add link_type/addr_type to the smp_irk/ltk/crsk and link_key,
to ensure the generation of the correct address type.

SMP over BREDR:
Before Fix:
> ACL Data RX: Handle 11 flags 0x02 dlen 12
        BR/EDR SMP: Identity Address Information (0x09) len 7
        Address: F8:7D:76:F2:12:F3 (OUI F8-7D-76)
@ MGMT Event: New Identity Resolving Key (0x0018) plen 30
        Random address: 00:00:00:00:00:00 (Non-Resolvable)
        LE Address: F8:7D:76:F2:12:F3 (OUI F8-7D-76)
@ MGMT Event: New Long Term Key (0x000a) plen 37
        LE Address: F8:7D:76:F2:12:F3 (OUI F8-7D-76)
        Key type: Authenticated key from P-256 (0x03)

After Fix:
> ACL Data RX: Handle 11 flags 0x02 dlen 12
      BR/EDR SMP: Identity Address Information (0x09) len 7
        Address: F8:7D:76:F2:12:F3 (OUI F8-7D-76)
@ MGMT Event: New Identity Resolving Key (0x0018) plen 30
        Random address: 00:00:00:00:00:00 (Non-Resolvable)
        BR/EDR Address: F8:7D:76:F2:12:F3 (OUI F8-7D-76)
@ MGMT Event: New Long Term Key (0x000a) plen 37
        BR/EDR Address: F8:7D:76:F2:12:F3 (OUI F8-7D-76)
        Key type: Authenticated key from P-256 (0x03)

SMP over LE:
Before Fix:
@ MGMT Event: New Identity Resolving Key (0x0018) plen 30
        Random address: 5F:5C:07:37:47:D5 (Resolvable)
        LE Address: F8:7D:76:F2:12:F3 (OUI F8-7D-76)
@ MGMT Event: New Long Term Key (0x000a) plen 37
        LE Address: F8:7D:76:F2:12:F3 (OUI F8-7D-76)
        Key type: Authenticated key from P-256 (0x03)
@ MGMT Event: New Link Key (0x0009) plen 26
        BR/EDR Address: F8:7D:76:F2:12:F3 (OUI F8-7D-76)
        Key type: Authenticated Combination key from P-256 (0x08)

After Fix:
@ MGMT Event: New Identity Resolving Key (0x0018) plen 30
        Random address: 5E:03:1C:00:38:21 (Resolvable)
        LE Address: F8:7D:76:F2:12:F3 (OUI F8-7D-76)
@ MGMT Event: New Long Term Key (0x000a) plen 37
        LE Address: F8:7D:76:F2:12:F3 (OUI F8-7D-76)
        Key type: Authenticated key from P-256 (0x03)
@ MGMT Event: New Link Key (0x0009) plen 26
        Store hint: Yes (0x01)
        LE Address: F8:7D:76:F2:12:F3 (OUI F8-7D-76)
        Key type: Authenticated Combination key from P-256 (0x08)

Cc: stable@vger.kernel.org
Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/bluetooth/hci_core.h |    5 +++++
 net/bluetooth/mgmt.c             |   25 ++++++++++++++++++-------
 net/bluetooth/smp.c              |    7 +++++++
 3 files changed, 30 insertions(+), 7 deletions(-)

--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -189,6 +189,7 @@ struct blocked_key {
 struct smp_csrk {
 	bdaddr_t bdaddr;
 	u8 bdaddr_type;
+	u8 link_type;
 	u8 type;
 	u8 val[16];
 };
@@ -198,6 +199,7 @@ struct smp_ltk {
 	struct rcu_head rcu;
 	bdaddr_t bdaddr;
 	u8 bdaddr_type;
+	u8 link_type;
 	u8 authenticated;
 	u8 type;
 	u8 enc_size;
@@ -212,6 +214,7 @@ struct smp_irk {
 	bdaddr_t rpa;
 	bdaddr_t bdaddr;
 	u8 addr_type;
+	u8 link_type;
 	u8 val[16];
 };
 
@@ -219,6 +222,8 @@ struct link_key {
 	struct list_head list;
 	struct rcu_head rcu;
 	bdaddr_t bdaddr;
+	u8 bdaddr_type;
+	u8 link_type;
 	u8 type;
 	u8 val[HCI_LINK_KEY_SIZE];
 	u8 pin_len;
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2897,7 +2897,8 @@ static int load_link_keys(struct sock *s
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_link_key_info *key = &cp->keys[i];
 
-		if (key->addr.type != BDADDR_BREDR || key->type > 0x08)
+		/* Considering SMP over BREDR/LE, there is no need to check addr_type */
+		if (key->type > 0x08)
 			return mgmt_cmd_status(sk, hdev->id,
 					       MGMT_OP_LOAD_LINK_KEYS,
 					       MGMT_STATUS_INVALID_PARAMS);
@@ -7130,6 +7131,7 @@ static int load_irks(struct sock *sk, st
 
 	for (i = 0; i < irk_count; i++) {
 		struct mgmt_irk_info *irk = &cp->irks[i];
+		u8 addr_type = le_addr_type(irk->addr.type);
 
 		if (hci_is_blocked_key(hdev,
 				       HCI_BLOCKED_KEY_TYPE_IRK,
@@ -7139,8 +7141,12 @@ static int load_irks(struct sock *sk, st
 			continue;
 		}
 
+		/* When using SMP over BR/EDR, the addr type should be set to BREDR */
+		if (irk->addr.type == BDADDR_BREDR)
+			addr_type = BDADDR_BREDR;
+
 		hci_add_irk(hdev, &irk->addr.bdaddr,
-			    le_addr_type(irk->addr.type), irk->val,
+			    addr_type, irk->val,
 			    BDADDR_ANY);
 	}
 
@@ -7221,6 +7227,7 @@ static int load_long_term_keys(struct so
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_ltk_info *key = &cp->keys[i];
 		u8 type, authenticated;
+		u8 addr_type = le_addr_type(key->addr.type);
 
 		if (hci_is_blocked_key(hdev,
 				       HCI_BLOCKED_KEY_TYPE_LTK,
@@ -7255,8 +7262,12 @@ static int load_long_term_keys(struct so
 			continue;
 		}
 
+		/* When using SMP over BR/EDR, the addr type should be set to BREDR */
+		if (key->addr.type == BDADDR_BREDR)
+			addr_type = BDADDR_BREDR;
+
 		hci_add_ltk(hdev, &key->addr.bdaddr,
-			    le_addr_type(key->addr.type), type, authenticated,
+			    addr_type, type, authenticated,
 			    key->val, key->enc_size, key->ediv, key->rand);
 	}
 
@@ -9523,7 +9534,7 @@ void mgmt_new_link_key(struct hci_dev *h
 
 	ev.store_hint = persistent;
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
-	ev.key.addr.type = BDADDR_BREDR;
+	ev.key.addr.type = link_to_bdaddr(key->link_type, key->bdaddr_type);
 	ev.key.type = key->type;
 	memcpy(ev.key.val, key->val, HCI_LINK_KEY_SIZE);
 	ev.key.pin_len = key->pin_len;
@@ -9574,7 +9585,7 @@ void mgmt_new_ltk(struct hci_dev *hdev,
 		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(LE_LINK, key->bdaddr_type);
+	ev.key.addr.type = link_to_bdaddr(key->link_type, key->bdaddr_type);
 	ev.key.type = mgmt_ltk_type(key);
 	ev.key.enc_size = key->enc_size;
 	ev.key.ediv = key->ediv;
@@ -9603,7 +9614,7 @@ void mgmt_new_irk(struct hci_dev *hdev,
 
 	bacpy(&ev.rpa, &irk->rpa);
 	bacpy(&ev.irk.addr.bdaddr, &irk->bdaddr);
-	ev.irk.addr.type = link_to_bdaddr(LE_LINK, irk->addr_type);
+	ev.irk.addr.type = link_to_bdaddr(irk->link_type, irk->addr_type);
 	memcpy(ev.irk.val, irk->val, sizeof(irk->val));
 
 	mgmt_event(MGMT_EV_NEW_IRK, hdev, &ev, sizeof(ev), NULL);
@@ -9632,7 +9643,7 @@ void mgmt_new_csrk(struct hci_dev *hdev,
 		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &csrk->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(LE_LINK, csrk->bdaddr_type);
+	ev.key.addr.type = link_to_bdaddr(csrk->link_type, csrk->bdaddr_type);
 	ev.key.type = csrk->type;
 	memcpy(ev.key.val, csrk->val, sizeof(csrk->val));
 
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1060,6 +1060,7 @@ static void smp_notify_keys(struct l2cap
 	}
 
 	if (smp->remote_irk) {
+		smp->remote_irk->link_type = hcon->type;
 		mgmt_new_irk(hdev, smp->remote_irk, persistent);
 
 		/* Now that user space can be considered to know the
@@ -1079,24 +1080,28 @@ static void smp_notify_keys(struct l2cap
 	}
 
 	if (smp->csrk) {
+		smp->csrk->link_type = hcon->type;
 		smp->csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->csrk->bdaddr, &hcon->dst);
 		mgmt_new_csrk(hdev, smp->csrk, persistent);
 	}
 
 	if (smp->responder_csrk) {
+		smp->responder_csrk->link_type = hcon->type;
 		smp->responder_csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->responder_csrk->bdaddr, &hcon->dst);
 		mgmt_new_csrk(hdev, smp->responder_csrk, persistent);
 	}
 
 	if (smp->ltk) {
+		smp->ltk->link_type = hcon->type;
 		smp->ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->ltk->bdaddr, &hcon->dst);
 		mgmt_new_ltk(hdev, smp->ltk, persistent);
 	}
 
 	if (smp->responder_ltk) {
+		smp->responder_ltk->link_type = hcon->type;
 		smp->responder_ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->responder_ltk->bdaddr, &hcon->dst);
 		mgmt_new_ltk(hdev, smp->responder_ltk, persistent);
@@ -1116,6 +1121,8 @@ static void smp_notify_keys(struct l2cap
 		key = hci_add_link_key(hdev, smp->conn->hcon, &hcon->dst,
 				       smp->link_key, type, 0, &persistent);
 		if (key) {
+			key->link_type = hcon->type;
+			key->bdaddr_type = hcon->dst_type;
 			mgmt_new_link_key(hdev, key, persistent);
 
 			/* Don't keep debug keys around if the relevant



