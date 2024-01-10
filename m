Return-Path: <stable+bounces-9540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BCA8232D3
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE482866D4
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB1B1C284;
	Wed,  3 Jan 2024 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s32C8XbL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DAD1BDEC;
	Wed,  3 Jan 2024 17:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3275EC433C8;
	Wed,  3 Jan 2024 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301930;
	bh=NTNAgQycTYteId1YyMvkJkfvBJyhayEUqGiwYC7IxRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s32C8XbL7WBHsIAOJeWEiNRr1nHA3DCiOOY0J+GmgX19z3iH909K2nhTnWyQtSe13
	 ClFlGz6soCqb9pruI2I2WpY1r/dMnAfysR+1SRrjUu2K7ZT6atlOktOdlTU8a3vPHg
	 bpl2MUtbwsQhutdtvoAeFUgJDM/9sCt7aJJ4swNU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Archie Pusaka <apusaka@chromium.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 54/75] Bluetooth: use inclusive language in SMP
Date: Wed,  3 Jan 2024 17:55:35 +0100
Message-ID: <20240103164851.282988051@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164842.953224409@linuxfoundation.org>
References: <20240103164842.953224409@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Archie Pusaka <apusaka@chromium.org>

[ Upstream commit fad646e16d3cafd67d3cfff8e66f77401190957e ]

This patch replaces some non-inclusive terms based on the appropriate
language mapping table compiled by the Bluetooth SIG:
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf

Specifically, these terms are replaced:
master -> initiator
slave  -> responder

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Stable-dep-of: 59b047bc9808 ("Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/mgmt.h |  2 +-
 net/bluetooth/mgmt.c         | 10 +++---
 net/bluetooth/smp.c          | 66 +++++++++++++++++++-----------------
 net/bluetooth/smp.h          |  6 ++--
 4 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 6b55155e05e97..faaba22e0d386 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -202,7 +202,7 @@ struct mgmt_cp_load_link_keys {
 struct mgmt_ltk_info {
 	struct mgmt_addr_info addr;
 	__u8	type;
-	__u8	master;
+	__u8	initiator;
 	__u8	enc_size;
 	__le16	ediv;
 	__le64	rand;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 878bf73822449..c62ea4c954645 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5939,7 +5939,7 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 
 static bool ltk_is_valid(struct mgmt_ltk_info *key)
 {
-	if (key->master != 0x00 && key->master != 0x01)
+	if (key->initiator != 0x00 && key->initiator != 0x01)
 		return false;
 
 	switch (key->addr.type) {
@@ -6017,11 +6017,11 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 		switch (key->type) {
 		case MGMT_LTK_UNAUTHENTICATED:
 			authenticated = 0x00;
-			type = key->master ? SMP_LTK : SMP_LTK_SLAVE;
+			type = key->initiator ? SMP_LTK : SMP_LTK_RESPONDER;
 			break;
 		case MGMT_LTK_AUTHENTICATED:
 			authenticated = 0x01;
-			type = key->master ? SMP_LTK : SMP_LTK_SLAVE;
+			type = key->initiator ? SMP_LTK : SMP_LTK_RESPONDER;
 			break;
 		case MGMT_LTK_P256_UNAUTH:
 			authenticated = 0x00;
@@ -8055,7 +8055,7 @@ static u8 mgmt_ltk_type(struct smp_ltk *ltk)
 {
 	switch (ltk->type) {
 	case SMP_LTK:
-	case SMP_LTK_SLAVE:
+	case SMP_LTK_RESPONDER:
 		if (ltk->authenticated)
 			return MGMT_LTK_AUTHENTICATED;
 		return MGMT_LTK_UNAUTHENTICATED;
@@ -8101,7 +8101,7 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
 	ev.key.rand = key->rand;
 
 	if (key->type == SMP_LTK)
-		ev.key.master = 1;
+		ev.key.initiator = 1;
 
 	/* Make sure we copy only the significant bytes based on the
 	 * encryption key size, and set the rest of the value to zeroes.
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1c1dc2d2b7d59..af6cc2e8c0284 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -112,9 +112,9 @@ struct smp_chan {
 	u8		id_addr_type;
 	u8		irk[16];
 	struct smp_csrk	*csrk;
-	struct smp_csrk	*slave_csrk;
+	struct smp_csrk	*responder_csrk;
 	struct smp_ltk	*ltk;
-	struct smp_ltk	*slave_ltk;
+	struct smp_ltk	*responder_ltk;
 	struct smp_irk	*remote_irk;
 	u8		*link_key;
 	unsigned long	flags;
@@ -754,7 +754,7 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 	mgmt_smp_complete(hcon, complete);
 
 	kfree_sensitive(smp->csrk);
-	kfree_sensitive(smp->slave_csrk);
+	kfree_sensitive(smp->responder_csrk);
 	kfree_sensitive(smp->link_key);
 
 	crypto_free_shash(smp->tfm_cmac);
@@ -777,9 +777,9 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 			kfree_rcu(smp->ltk, rcu);
 		}
 
-		if (smp->slave_ltk) {
-			list_del_rcu(&smp->slave_ltk->list);
-			kfree_rcu(smp->slave_ltk, rcu);
+		if (smp->responder_ltk) {
+			list_del_rcu(&smp->responder_ltk->list);
+			kfree_rcu(smp->responder_ltk, rcu);
 		}
 
 		if (smp->remote_irk) {
@@ -980,7 +980,7 @@ static u8 smp_random(struct smp_chan *smp)
 	int ret;
 
 	bt_dev_dbg(conn->hcon->hdev, "conn %p %s", conn,
-		   conn->hcon->out ? "master" : "slave");
+		   conn->hcon->out ? "initiator" : "responder");
 
 	ret = smp_c1(smp->tk, smp->rrnd, smp->preq, smp->prsp,
 		     hcon->init_addr_type, &hcon->init_addr,
@@ -1022,8 +1022,8 @@ static u8 smp_random(struct smp_chan *smp)
 		else
 			auth = 0;
 
-		/* Even though there's no _SLAVE suffix this is the
-		 * slave STK we're adding for later lookup (the master
+		/* Even though there's no _RESPONDER suffix this is the
+		 * responder STK we're adding for later lookup (the initiator
 		 * STK never needs to be stored).
 		 */
 		hci_add_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
@@ -1078,10 +1078,10 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 		mgmt_new_csrk(hdev, smp->csrk, persistent);
 	}
 
-	if (smp->slave_csrk) {
-		smp->slave_csrk->bdaddr_type = hcon->dst_type;
-		bacpy(&smp->slave_csrk->bdaddr, &hcon->dst);
-		mgmt_new_csrk(hdev, smp->slave_csrk, persistent);
+	if (smp->responder_csrk) {
+		smp->responder_csrk->bdaddr_type = hcon->dst_type;
+		bacpy(&smp->responder_csrk->bdaddr, &hcon->dst);
+		mgmt_new_csrk(hdev, smp->responder_csrk, persistent);
 	}
 
 	if (smp->ltk) {
@@ -1090,10 +1090,10 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 		mgmt_new_ltk(hdev, smp->ltk, persistent);
 	}
 
-	if (smp->slave_ltk) {
-		smp->slave_ltk->bdaddr_type = hcon->dst_type;
-		bacpy(&smp->slave_ltk->bdaddr, &hcon->dst);
-		mgmt_new_ltk(hdev, smp->slave_ltk, persistent);
+	if (smp->responder_ltk) {
+		smp->responder_ltk->bdaddr_type = hcon->dst_type;
+		bacpy(&smp->responder_ltk->bdaddr, &hcon->dst);
+		mgmt_new_ltk(hdev, smp->responder_ltk, persistent);
 	}
 
 	if (smp->link_key) {
@@ -1273,7 +1273,7 @@ static void smp_distribute_keys(struct smp_chan *smp)
 
 	if (*keydist & SMP_DIST_ENC_KEY) {
 		struct smp_cmd_encrypt_info enc;
-		struct smp_cmd_master_ident ident;
+		struct smp_cmd_initiator_ident ident;
 		struct smp_ltk *ltk;
 		u8 authenticated;
 		__le16 ediv;
@@ -1294,14 +1294,15 @@ static void smp_distribute_keys(struct smp_chan *smp)
 
 		authenticated = hcon->sec_level == BT_SECURITY_HIGH;
 		ltk = hci_add_ltk(hdev, &hcon->dst, hcon->dst_type,
-				  SMP_LTK_SLAVE, authenticated, enc.ltk,
+				  SMP_LTK_RESPONDER, authenticated, enc.ltk,
 				  smp->enc_key_size, ediv, rand);
-		smp->slave_ltk = ltk;
+		smp->responder_ltk = ltk;
 
 		ident.ediv = ediv;
 		ident.rand = rand;
 
-		smp_send_cmd(conn, SMP_CMD_MASTER_IDENT, sizeof(ident), &ident);
+		smp_send_cmd(conn, SMP_CMD_INITIATOR_IDENT, sizeof(ident),
+			     &ident);
 
 		*keydist &= ~SMP_DIST_ENC_KEY;
 	}
@@ -1344,7 +1345,7 @@ static void smp_distribute_keys(struct smp_chan *smp)
 				csrk->type = MGMT_CSRK_LOCAL_UNAUTHENTICATED;
 			memcpy(csrk->val, sign.csrk, sizeof(csrk->val));
 		}
-		smp->slave_csrk = csrk;
+		smp->responder_csrk = csrk;
 
 		smp_send_cmd(conn, SMP_CMD_SIGN_INFO, sizeof(sign), &sign);
 
@@ -2049,7 +2050,7 @@ static int fixup_sc_false_positive(struct smp_chan *smp)
 	struct smp_cmd_pairing *req, *rsp;
 	u8 auth;
 
-	/* The issue is only observed when we're in slave role */
+	/* The issue is only observed when we're in responder role */
 	if (hcon->out)
 		return SMP_UNSPECIFIED;
 
@@ -2085,7 +2086,8 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
 
-	bt_dev_dbg(hdev, "conn %p %s", conn, hcon->out ? "master" : "slave");
+	bt_dev_dbg(hdev, "conn %p %s", conn,
+		   hcon->out ? "initiator" : "responder");
 
 	if (skb->len < sizeof(smp->pcnf))
 		return SMP_INVALID_PARAMS;
@@ -2252,7 +2254,7 @@ static bool smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
 	hci_le_start_enc(hcon, key->ediv, key->rand, key->val, key->enc_size);
 	hcon->enc_key_size = key->enc_size;
 
-	/* We never store STKs for master role, so clear this flag */
+	/* We never store STKs for initiator role, so clear this flag */
 	clear_bit(HCI_CONN_STK_ENCRYPT, &hcon->flags);
 
 	return true;
@@ -2468,7 +2470,7 @@ int smp_cancel_and_remove_pairing(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		/* Set keys to NULL to make sure smp_failure() does not try to
 		 * remove and free already invalidated rcu list entries. */
 		smp->ltk = NULL;
-		smp->slave_ltk = NULL;
+		smp->responder_ltk = NULL;
 		smp->remote_irk = NULL;
 
 		if (test_bit(SMP_FLAG_COMPLETE, &smp->flags))
@@ -2504,7 +2506,7 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 		return SMP_INVALID_PARAMS;
 	}
 
-	SMP_ALLOW_CMD(smp, SMP_CMD_MASTER_IDENT);
+	SMP_ALLOW_CMD(smp, SMP_CMD_INITIATOR_IDENT);
 
 	skb_pull(skb, sizeof(*rp));
 
@@ -2513,9 +2515,9 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	return 0;
 }
 
-static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
+static int smp_cmd_initiator_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct smp_cmd_master_ident *rp = (void *) skb->data;
+	struct smp_cmd_initiator_ident *rp = (void *)skb->data;
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
 	struct hci_dev *hdev = conn->hcon->hdev;
@@ -2914,7 +2916,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 			return 0;
 		}
 
-		/* Slave sends DHKey check as response to master */
+		/* Responder sends DHKey check as response to initiator */
 		sc_dhkey_check(smp);
 	}
 
@@ -3001,8 +3003,8 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 		reason = smp_cmd_encrypt_info(conn, skb);
 		break;
 
-	case SMP_CMD_MASTER_IDENT:
-		reason = smp_cmd_master_ident(conn, skb);
+	case SMP_CMD_INITIATOR_IDENT:
+		reason = smp_cmd_initiator_ident(conn, skb);
 		break;
 
 	case SMP_CMD_IDENT_INFO:
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 121edadd5f8da..5fe68e255cb29 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -79,8 +79,8 @@ struct smp_cmd_encrypt_info {
 	__u8	ltk[16];
 } __packed;
 
-#define SMP_CMD_MASTER_IDENT	0x07
-struct smp_cmd_master_ident {
+#define SMP_CMD_INITIATOR_IDENT	0x07
+struct smp_cmd_initiator_ident {
 	__le16	ediv;
 	__le64	rand;
 } __packed;
@@ -146,7 +146,7 @@ struct smp_cmd_keypress_notify {
 enum {
 	SMP_STK,
 	SMP_LTK,
-	SMP_LTK_SLAVE,
+	SMP_LTK_RESPONDER,
 	SMP_LTK_P256,
 	SMP_LTK_P256_DEBUG,
 };
-- 
2.43.0




