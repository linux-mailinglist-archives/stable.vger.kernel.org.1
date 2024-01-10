Return-Path: <stable+bounces-9529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C49FE8232C8
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE99285FDA
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD9A1C291;
	Wed,  3 Jan 2024 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TeNk9qzW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A6E1BDFB;
	Wed,  3 Jan 2024 17:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B24C433C8;
	Wed,  3 Jan 2024 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301897;
	bh=TB45Neuzc9W+w9Gfe5A9/EhEc4IHvVK3iiCMDiHPePU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TeNk9qzWQf4PNxtXdh8C98D+qneyCtOT8XK7LoEYimway4pQHZO0m8Z4Cl3rWuNX+
	 PNzVfPgdIRMqpSGNsw5edJhbXyfm0MZGiVKAXddG5Uddx0lU1iuiKnoFPCygTBxFuH
	 wIhhLXUEx59YkqSCPv4FlrStrUc9P32imcsw3Reg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 53/75] Bluetooth: SMP: Convert BT_ERR/BT_DBG to bt_dev_err/bt_dev_dbg
Date: Wed,  3 Jan 2024 17:55:34 +0100
Message-ID: <20240103164851.157316190@linuxfoundation.org>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 2e1614f7d61e407f1a8e7935a2903a6fa3cb0b11 ]

This converts instances of BT_ERR and BT_DBG to bt_dev_err and
bt_dev_dbg which can be enabled at runtime when BT_FEATURE_DEBUG is
enabled.

Note: Not all instances could be converted as some are exercised by
selftest.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Stable-dep-of: 59b047bc9808 ("Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/smp.c | 98 ++++++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 46 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b7374dbee23a3..1c1dc2d2b7d59 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -596,7 +596,7 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 	if (!chan)
 		return;
 
-	BT_DBG("code 0x%2.2x", code);
+	bt_dev_dbg(conn->hcon->hdev, "code 0x%2.2x", code);
 
 	iv[0].iov_base = &code;
 	iv[0].iov_len = 1;
@@ -860,7 +860,8 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	memset(smp->tk, 0, sizeof(smp->tk));
 	clear_bit(SMP_FLAG_TK_VALID, &smp->flags);
 
-	BT_DBG("tk_request: auth:%d lcl:%d rem:%d", auth, local_io, remote_io);
+	bt_dev_dbg(hcon->hdev, "auth:%d lcl:%d rem:%d", auth, local_io,
+		   remote_io);
 
 	/* If neither side wants MITM, either "just" confirm an incoming
 	 * request or use just-works for outgoing ones. The JUST_CFM
@@ -925,7 +926,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 		get_random_bytes(&passkey, sizeof(passkey));
 		passkey %= 1000000;
 		put_unaligned_le32(passkey, smp->tk);
-		BT_DBG("PassKey: %d", passkey);
+		bt_dev_dbg(hcon->hdev, "PassKey: %d", passkey);
 		set_bit(SMP_FLAG_TK_VALID, &smp->flags);
 	}
 
@@ -950,7 +951,7 @@ static u8 smp_confirm(struct smp_chan *smp)
 	struct smp_cmd_pairing_confirm cp;
 	int ret;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(conn->hcon->hdev, "conn %p", conn);
 
 	ret = smp_c1(smp->tk, smp->prnd, smp->preq, smp->prsp,
 		     conn->hcon->init_addr_type, &conn->hcon->init_addr,
@@ -978,7 +979,8 @@ static u8 smp_random(struct smp_chan *smp)
 	u8 confirm[16];
 	int ret;
 
-	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
+	bt_dev_dbg(conn->hcon->hdev, "conn %p %s", conn,
+		   conn->hcon->out ? "master" : "slave");
 
 	ret = smp_c1(smp->tk, smp->rrnd, smp->preq, smp->prsp,
 		     hcon->init_addr_type, &hcon->init_addr,
@@ -1237,7 +1239,7 @@ static void smp_distribute_keys(struct smp_chan *smp)
 	struct hci_dev *hdev = hcon->hdev;
 	__u8 *keydist;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	rsp = (void *) &smp->prsp[1];
 
@@ -1267,7 +1269,7 @@ static void smp_distribute_keys(struct smp_chan *smp)
 		*keydist &= ~SMP_SC_NO_DIST;
 	}
 
-	BT_DBG("keydist 0x%x", *keydist);
+	bt_dev_dbg(hdev, "keydist 0x%x", *keydist);
 
 	if (*keydist & SMP_DIST_ENC_KEY) {
 		struct smp_cmd_encrypt_info enc;
@@ -1367,13 +1369,14 @@ static void smp_timeout(struct work_struct *work)
 					    security_timer.work);
 	struct l2cap_conn *conn = smp->conn;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(conn->hcon->hdev, "conn %p", conn);
 
 	hci_disconnect(conn->hcon, HCI_ERROR_REMOTE_USER_TERM);
 }
 
 static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 {
+	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp;
 
@@ -1383,13 +1386,13 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 
 	smp->tfm_cmac = crypto_alloc_shash("cmac(aes)", 0, 0);
 	if (IS_ERR(smp->tfm_cmac)) {
-		BT_ERR("Unable to create CMAC crypto context");
+		bt_dev_err(hcon->hdev, "Unable to create CMAC crypto context");
 		goto zfree_smp;
 	}
 
 	smp->tfm_ecdh = crypto_alloc_kpp("ecdh", 0, 0);
 	if (IS_ERR(smp->tfm_ecdh)) {
-		BT_ERR("Unable to create ECDH crypto context");
+		bt_dev_err(hcon->hdev, "Unable to create ECDH crypto context");
 		goto free_shash;
 	}
 
@@ -1400,7 +1403,7 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 
 	INIT_DELAYED_WORK(&smp->security_timer, smp_timeout);
 
-	hci_conn_hold(conn->hcon);
+	hci_conn_hold(hcon);
 
 	return smp;
 
@@ -1565,8 +1568,8 @@ static u8 sc_passkey_round(struct smp_chan *smp, u8 smp_op)
 		if (!hcon->out)
 			return 0;
 
-		BT_DBG("%s Starting passkey round %u", hdev->name,
-		       smp->passkey_round + 1);
+		bt_dev_dbg(hdev, "Starting passkey round %u",
+			   smp->passkey_round + 1);
 
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
 
@@ -1626,7 +1629,7 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 	u32 value;
 	int err;
 
-	BT_DBG("");
+	bt_dev_dbg(conn->hcon->hdev, "");
 
 	if (!conn)
 		return -ENOTCONN;
@@ -1652,7 +1655,7 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 	case MGMT_OP_USER_PASSKEY_REPLY:
 		value = le32_to_cpu(passkey);
 		memset(smp->tk, 0, sizeof(smp->tk));
-		BT_DBG("PassKey: %d", value);
+		bt_dev_dbg(conn->hcon->hdev, "PassKey: %d", value);
 		put_unaligned_le32(value, smp->tk);
 		fallthrough;
 	case MGMT_OP_USER_CONFIRM_REPLY:
@@ -1734,7 +1737,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	u8 key_size, auth, sec_level;
 	int ret;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	if (skb->len < sizeof(*req))
 		return SMP_INVALID_PARAMS;
@@ -1888,7 +1891,7 @@ static u8 sc_send_public_key(struct smp_chan *smp)
 	}
 
 	if (hci_dev_test_flag(hdev, HCI_USE_DEBUG_KEYS)) {
-		BT_DBG("Using debug keys");
+		bt_dev_dbg(hdev, "Using debug keys");
 		if (set_ecdh_privkey(smp->tfm_ecdh, debug_sk))
 			return SMP_UNSPECIFIED;
 		memcpy(smp->local_pk, debug_pk, 64);
@@ -1925,7 +1928,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	u8 key_size, auth;
 	int ret;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	if (skb->len < sizeof(*rsp))
 		return SMP_INVALID_PARAMS;
@@ -2020,7 +2023,7 @@ static u8 sc_check_confirm(struct smp_chan *smp)
 {
 	struct l2cap_conn *conn = smp->conn;
 
-	BT_DBG("");
+	bt_dev_dbg(conn->hcon->hdev, "");
 
 	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
 		return sc_passkey_round(smp, SMP_CMD_PAIRING_CONFIRM);
@@ -2079,8 +2082,10 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
+	struct hci_conn *hcon = conn->hcon;
+	struct hci_dev *hdev = hcon->hdev;
 
-	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
+	bt_dev_dbg(hdev, "conn %p %s", conn, hcon->out ? "master" : "slave");
 
 	if (skb->len < sizeof(smp->pcnf))
 		return SMP_INVALID_PARAMS;
@@ -2095,7 +2100,7 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 		if (test_bit(SMP_FLAG_REMOTE_PK, &smp->flags))
 			return sc_check_confirm(smp);
 
-		BT_ERR("Unexpected SMP Pairing Confirm");
+		bt_dev_err(hdev, "Unexpected SMP Pairing Confirm");
 
 		ret = fixup_sc_false_positive(smp);
 		if (ret)
@@ -2126,7 +2131,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	u32 passkey;
 	int err;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hcon->hdev, "conn %p", conn);
 
 	if (skb->len < sizeof(smp->rrnd))
 		return SMP_INVALID_PARAMS;
@@ -2285,7 +2290,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_chan *smp;
 	u8 sec_level, auth;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	if (skb->len < sizeof(*rp))
 		return SMP_INVALID_PARAMS;
@@ -2348,7 +2353,8 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 	__u8 authreq;
 	int ret;
 
-	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, hcon, sec_level);
+	bt_dev_dbg(hcon->hdev, "conn %p hcon %p level 0x%2.2x", conn, hcon,
+		   sec_level);
 
 	/* This may be NULL if there's an unexpected disconnection */
 	if (!conn)
@@ -2484,7 +2490,7 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(conn->hcon->hdev, "conn %p", conn);
 
 	if (skb->len < sizeof(*rp))
 		return SMP_INVALID_PARAMS;
@@ -2517,7 +2523,7 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_ltk *ltk;
 	u8 authenticated;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	if (skb->len < sizeof(*rp))
 		return SMP_INVALID_PARAMS;
@@ -2549,7 +2555,7 @@ static int smp_cmd_ident_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
 
-	BT_DBG("");
+	bt_dev_dbg(conn->hcon->hdev, "");
 
 	if (skb->len < sizeof(*info))
 		return SMP_INVALID_PARAMS;
@@ -2581,7 +2587,7 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	struct hci_conn *hcon = conn->hcon;
 	bdaddr_t rpa;
 
-	BT_DBG("");
+	bt_dev_dbg(hcon->hdev, "");
 
 	if (skb->len < sizeof(*info))
 		return SMP_INVALID_PARAMS;
@@ -2648,7 +2654,7 @@ static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_chan *smp = chan->data;
 	struct smp_csrk *csrk;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(conn->hcon->hdev, "conn %p", conn);
 
 	if (skb->len < sizeof(*rp))
 		return SMP_INVALID_PARAMS;
@@ -2728,7 +2734,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_cmd_pairing_confirm cfm;
 	int err;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	if (skb->len < sizeof(*key))
 		return SMP_INVALID_PARAMS;
@@ -2792,7 +2798,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	smp->method = sc_select_method(smp);
 
-	BT_DBG("%s selected method 0x%02x", hdev->name, smp->method);
+	bt_dev_dbg(hdev, "selected method 0x%02x", smp->method);
 
 	/* JUST_WORKS and JUST_CFM result in an unauthenticated key */
 	if (smp->method == JUST_WORKS || smp->method == JUST_CFM)
@@ -2867,7 +2873,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 	u8 io_cap[3], r[16], e[16];
 	int err;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hcon->hdev, "conn %p", conn);
 
 	if (skb->len < sizeof(*check))
 		return SMP_INVALID_PARAMS;
@@ -2927,7 +2933,7 @@ static int smp_cmd_keypress_notify(struct l2cap_conn *conn,
 {
 	struct smp_cmd_keypress_notify *kp = (void *) skb->data;
 
-	BT_DBG("value 0x%02x", kp->value);
+	bt_dev_dbg(conn->hcon->hdev, "value 0x%02x", kp->value);
 
 	return 0;
 }
@@ -3024,7 +3030,7 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 		break;
 
 	default:
-		BT_DBG("Unknown command code 0x%2.2x", code);
+		bt_dev_dbg(hcon->hdev, "Unknown command code 0x%2.2x", code);
 		reason = SMP_CMD_NOTSUPP;
 		goto done;
 	}
@@ -3049,7 +3055,7 @@ static void smp_teardown_cb(struct l2cap_chan *chan, int err)
 {
 	struct l2cap_conn *conn = chan->conn;
 
-	BT_DBG("chan %p", chan);
+	bt_dev_dbg(conn->hcon->hdev, "chan %p", chan);
 
 	if (chan->data)
 		smp_chan_destroy(conn);
@@ -3066,7 +3072,7 @@ static void bredr_pairing(struct l2cap_chan *chan)
 	struct smp_cmd_pairing req;
 	struct smp_chan *smp;
 
-	BT_DBG("chan %p", chan);
+	bt_dev_dbg(hdev, "chan %p", chan);
 
 	/* Only new pairings are interesting */
 	if (!test_bit(HCI_CONN_NEW_LINK_KEY, &hcon->flags))
@@ -3113,7 +3119,7 @@ static void bredr_pairing(struct l2cap_chan *chan)
 
 	set_bit(SMP_FLAG_SC, &smp->flags);
 
-	BT_DBG("%s starting SMP over BR/EDR", hdev->name);
+	bt_dev_dbg(hdev, "starting SMP over BR/EDR");
 
 	/* Prepare and send the BR/EDR SMP Pairing Request */
 	build_bredr_pairing_cmd(smp, &req, NULL);
@@ -3131,7 +3137,7 @@ static void smp_resume_cb(struct l2cap_chan *chan)
 	struct l2cap_conn *conn = chan->conn;
 	struct hci_conn *hcon = conn->hcon;
 
-	BT_DBG("chan %p", chan);
+	bt_dev_dbg(hcon->hdev, "chan %p", chan);
 
 	if (hcon->type == ACL_LINK) {
 		bredr_pairing(chan);
@@ -3154,7 +3160,7 @@ static void smp_ready_cb(struct l2cap_chan *chan)
 	struct l2cap_conn *conn = chan->conn;
 	struct hci_conn *hcon = conn->hcon;
 
-	BT_DBG("chan %p", chan);
+	bt_dev_dbg(hcon->hdev, "chan %p", chan);
 
 	/* No need to call l2cap_chan_hold() here since we already own
 	 * the reference taken in smp_new_conn_cb(). This is just the
@@ -3172,7 +3178,7 @@ static int smp_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	int err;
 
-	BT_DBG("chan %p", chan);
+	bt_dev_dbg(chan->conn->hcon->hdev, "chan %p", chan);
 
 	err = smp_sig_channel(chan, skb);
 	if (err) {
@@ -3224,7 +3230,7 @@ static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
 {
 	struct l2cap_chan *chan;
 
-	BT_DBG("pchan %p", pchan);
+	bt_dev_dbg(pchan->conn->hcon->hdev, "pchan %p", pchan);
 
 	chan = l2cap_chan_create();
 	if (!chan)
@@ -3245,7 +3251,7 @@ static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
 	 */
 	atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
 
-	BT_DBG("created chan %p", chan);
+	bt_dev_dbg(pchan->conn->hcon->hdev, "created chan %p", chan);
 
 	return chan;
 }
@@ -3286,14 +3292,14 @@ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 
 	tfm_cmac = crypto_alloc_shash("cmac(aes)", 0, 0);
 	if (IS_ERR(tfm_cmac)) {
-		BT_ERR("Unable to create CMAC crypto context");
+		bt_dev_err(hdev, "Unable to create CMAC crypto context");
 		kfree_sensitive(smp);
 		return ERR_CAST(tfm_cmac);
 	}
 
 	tfm_ecdh = crypto_alloc_kpp("ecdh", 0, 0);
 	if (IS_ERR(tfm_ecdh)) {
-		BT_ERR("Unable to create ECDH crypto context");
+		bt_dev_err(hdev, "Unable to create ECDH crypto context");
 		crypto_free_shash(tfm_cmac);
 		kfree_sensitive(smp);
 		return ERR_CAST(tfm_ecdh);
@@ -3349,7 +3355,7 @@ static void smp_del_chan(struct l2cap_chan *chan)
 {
 	struct smp_dev *smp;
 
-	BT_DBG("chan %p", chan);
+	bt_dev_dbg(chan->conn->hcon->hdev, "chan %p", chan);
 
 	smp = chan->data;
 	if (smp) {
@@ -3422,7 +3428,7 @@ int smp_register(struct hci_dev *hdev)
 {
 	struct l2cap_chan *chan;
 
-	BT_DBG("%s", hdev->name);
+	bt_dev_dbg(hdev, "");
 
 	/* If the controller does not support Low Energy operation, then
 	 * there is also no need to register any SMP channel.
-- 
2.43.0




