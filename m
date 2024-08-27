Return-Path: <stable+bounces-70611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D75E960F14
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208591F21A7A
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96321C825C;
	Tue, 27 Aug 2024 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k5zdzZVR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B2D1C7B9D;
	Tue, 27 Aug 2024 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770484; cv=none; b=LT+BOXqUgGhRzAem5wKwRKd3sgFqVA/b1BSIkiNHS7SdCVqjISpyxryBg7ohO78i/toPFpNcsEe/I+pys181MUwzlmsP40bPClJqx0apuQb4oNB2mtHjRWEeRUtRq8DvR1ibM1nEBGlgpm26Co/9fofPc6hN7rNA25uvArBJHKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770484; c=relaxed/simple;
	bh=YTr/fProx0Fy/b0oWaHkD6VvNfi3KUA//pGKYYIbdmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPGCh4rF7DVsUP9y6V8L1IC4/tHgqrQeNaQv1h7b9vTO2fRocwk1Iqv11xu68szJKhLgSx+OIv8Qs9ri0yKl8yYTR92Hi5ZQP7KXJxmU3s4ZJOmG2vrEJXzg9AnqiBPQCdj7c2M8+KjXX2gUcpm9d+rDE2VNdUW2WSOp5SooS1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k5zdzZVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C08C4E673;
	Tue, 27 Aug 2024 14:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724770484;
	bh=YTr/fProx0Fy/b0oWaHkD6VvNfi3KUA//pGKYYIbdmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5zdzZVRvA5Jm7QvfbOdehGwvaEmMbg8fLui0G1HY/RCQPwUBLGiAXp12LxvFpTA/
	 nh5hezrHM8jtaPBeUfmAhNd0OqZw1reYv9AtnVEhF67wC8RX71Et9THRfTkbhwq7YM
	 h7bVNmHZzN7UrEc7RWYwY61k+9pj/+LCMgCRc+34=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 242/341] Bluetooth: SMP: Fix assumption of Central always being Initiator
Date: Tue, 27 Aug 2024 16:37:53 +0200
Message-ID: <20240827143852.617350244@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
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

[ Upstream commit 28cd47f75185c4818b0fb1b46f2f02faaba96376 ]

SMP initiator role shall be considered the one that initiates the
pairing procedure with SMP_CMD_PAIRING_REQ:

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part H
page 1557:

Figure 2.1: LE pairing phases

Note that by sending SMP_CMD_SECURITY_REQ it doesn't change the role to
be Initiator.

Link: https://github.com/bluez/bluez/issues/567
Fixes: b28b4943660f ("Bluetooth: Add strict checks for allowed SMP PDUs")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/smp.c | 144 ++++++++++++++++++++++----------------------
 1 file changed, 72 insertions(+), 72 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 37f95ea8c7db5..fa3986cfd5266 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -915,7 +915,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	 * Confirms and the responder Enters the passkey.
 	 */
 	if (smp->method == OVERLAP) {
-		if (hcon->role == HCI_ROLE_MASTER)
+		if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 			smp->method = CFM_PASSKEY;
 		else
 			smp->method = REQ_PASSKEY;
@@ -965,7 +965,7 @@ static u8 smp_confirm(struct smp_chan *smp)
 
 	smp_send_cmd(smp->conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
 
-	if (conn->hcon->out)
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
 	else
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
@@ -981,7 +981,8 @@ static u8 smp_random(struct smp_chan *smp)
 	int ret;
 
 	bt_dev_dbg(conn->hcon->hdev, "conn %p %s", conn,
-		   conn->hcon->out ? "initiator" : "responder");
+		   test_bit(SMP_FLAG_INITIATOR, &smp->flags) ? "initiator" :
+		   "responder");
 
 	ret = smp_c1(smp->tk, smp->rrnd, smp->preq, smp->prsp,
 		     hcon->init_addr_type, &hcon->init_addr,
@@ -995,7 +996,7 @@ static u8 smp_random(struct smp_chan *smp)
 		return SMP_CONFIRM_FAILED;
 	}
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		u8 stk[16];
 		__le64 rand = 0;
 		__le16 ediv = 0;
@@ -1257,14 +1258,15 @@ static void smp_distribute_keys(struct smp_chan *smp)
 	rsp = (void *) &smp->prsp[1];
 
 	/* The responder sends its keys first */
-	if (hcon->out && (smp->remote_key_dist & KEY_DIST_MASK)) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags) &&
+	    (smp->remote_key_dist & KEY_DIST_MASK)) {
 		smp_allow_key_dist(smp);
 		return;
 	}
 
 	req = (void *) &smp->preq[1];
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		keydist = &rsp->init_key_dist;
 		*keydist &= req->init_key_dist;
 	} else {
@@ -1433,7 +1435,7 @@ static int sc_mackey_and_ltk(struct smp_chan *smp, u8 mackey[16], u8 ltk[16])
 	struct hci_conn *hcon = smp->conn->hcon;
 	u8 *na, *nb, a[7], b[7];
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		na   = smp->prnd;
 		nb   = smp->rrnd;
 	} else {
@@ -1461,7 +1463,7 @@ static void sc_dhkey_check(struct smp_chan *smp)
 	a[6] = hcon->init_addr_type;
 	b[6] = hcon->resp_addr_type;
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		local_addr = a;
 		remote_addr = b;
 		memcpy(io_cap, &smp->preq[1], 3);
@@ -1540,7 +1542,7 @@ static u8 sc_passkey_round(struct smp_chan *smp, u8 smp_op)
 		/* The round is only complete when the initiator
 		 * receives pairing random.
 		 */
-		if (!hcon->out) {
+		if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
 				     sizeof(smp->prnd), smp->prnd);
 			if (smp->passkey_round == 20)
@@ -1568,7 +1570,7 @@ static u8 sc_passkey_round(struct smp_chan *smp, u8 smp_op)
 
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
 
-		if (hcon->out) {
+		if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
 				     sizeof(smp->prnd), smp->prnd);
 			return 0;
@@ -1579,7 +1581,7 @@ static u8 sc_passkey_round(struct smp_chan *smp, u8 smp_op)
 	case SMP_CMD_PUBLIC_KEY:
 	default:
 		/* Initiating device starts the round */
-		if (!hcon->out)
+		if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 			return 0;
 
 		bt_dev_dbg(hdev, "Starting passkey round %u",
@@ -1624,7 +1626,7 @@ static int sc_user_reply(struct smp_chan *smp, u16 mgmt_op, __le32 passkey)
 	}
 
 	/* Initiator sends DHKey check first */
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		sc_dhkey_check(smp);
 		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
 	} else if (test_and_clear_bit(SMP_FLAG_DHKEY_PENDING, &smp->flags)) {
@@ -1747,7 +1749,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_cmd_pairing rsp, *req = (void *) skb->data;
 	struct l2cap_chan *chan = conn->smp;
 	struct hci_dev *hdev = conn->hcon->hdev;
-	struct smp_chan *smp;
+	struct smp_chan *smp = chan->data;
 	u8 key_size, auth, sec_level;
 	int ret;
 
@@ -1756,16 +1758,14 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*req))
 		return SMP_INVALID_PARAMS;
 
-	if (conn->hcon->role != HCI_ROLE_SLAVE)
+	if (smp && test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		return SMP_CMD_NOTSUPP;
 
-	if (!chan->data)
+	if (!smp) {
 		smp = smp_chan_create(conn);
-	else
-		smp = chan->data;
-
-	if (!smp)
-		return SMP_UNSPECIFIED;
+		if (!smp)
+			return SMP_UNSPECIFIED;
+	}
 
 	/* We didn't start the pairing, so match remote */
 	auth = req->auth_req & AUTH_REQ_MASK(hdev);
@@ -1947,7 +1947,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*rsp))
 		return SMP_INVALID_PARAMS;
 
-	if (conn->hcon->role != HCI_ROLE_MASTER)
+	if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		return SMP_CMD_NOTSUPP;
 
 	skb_pull(skb, sizeof(*rsp));
@@ -2042,7 +2042,7 @@ static u8 sc_check_confirm(struct smp_chan *smp)
 	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
 		return sc_passkey_round(smp, SMP_CMD_PAIRING_CONFIRM);
 
-	if (conn->hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
@@ -2064,7 +2064,7 @@ static int fixup_sc_false_positive(struct smp_chan *smp)
 	u8 auth;
 
 	/* The issue is only observed when we're in responder role */
-	if (hcon->out)
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		return SMP_UNSPECIFIED;
 
 	if (hci_dev_test_flag(hdev, HCI_SC_ONLY)) {
@@ -2100,7 +2100,8 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct hci_dev *hdev = hcon->hdev;
 
 	bt_dev_dbg(hdev, "conn %p %s", conn,
-		   hcon->out ? "initiator" : "responder");
+		   test_bit(SMP_FLAG_INITIATOR, &smp->flags) ? "initiator" :
+		   "responder");
 
 	if (skb->len < sizeof(smp->pcnf))
 		return SMP_INVALID_PARAMS;
@@ -2122,7 +2123,7 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 			return ret;
 	}
 
-	if (conn->hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RANDOM);
@@ -2157,7 +2158,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!test_bit(SMP_FLAG_SC, &smp->flags))
 		return smp_random(smp);
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		pkax = smp->local_pk;
 		pkbx = smp->remote_pk;
 		na   = smp->prnd;
@@ -2170,7 +2171,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	}
 
 	if (smp->method == REQ_OOB) {
-		if (!hcon->out)
+		if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
 				     sizeof(smp->prnd), smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
@@ -2181,7 +2182,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
 		return sc_passkey_round(smp, SMP_CMD_PAIRING_RANDOM);
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		u8 cfm[16];
 
 		err = smp_f4(smp->tfm_cmac, smp->remote_pk, smp->local_pk,
@@ -2222,7 +2223,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		return SMP_UNSPECIFIED;
 
 	if (smp->method == REQ_OOB) {
-		if (hcon->out) {
+		if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 			sc_dhkey_check(smp);
 			SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
 		}
@@ -2296,10 +2297,27 @@ bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level,
 	return false;
 }
 
+static void smp_send_pairing_req(struct smp_chan *smp, __u8 auth)
+{
+	struct smp_cmd_pairing cp;
+
+	if (smp->conn->hcon->type == ACL_LINK)
+		build_bredr_pairing_cmd(smp, &cp, NULL);
+	else
+		build_pairing_cmd(smp->conn, &cp, NULL, auth);
+
+	smp->preq[0] = SMP_CMD_PAIRING_REQ;
+	memcpy(&smp->preq[1], &cp, sizeof(cp));
+
+	smp_send_cmd(smp->conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
+	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
+
+	set_bit(SMP_FLAG_INITIATOR, &smp->flags);
+}
+
 static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_security_req *rp = (void *) skb->data;
-	struct smp_cmd_pairing cp;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
 	struct smp_chan *smp;
@@ -2348,16 +2366,20 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	skb_pull(skb, sizeof(*rp));
 
-	memset(&cp, 0, sizeof(cp));
-	build_pairing_cmd(conn, &cp, NULL, auth);
+	smp_send_pairing_req(smp, auth);
 
-	smp->preq[0] = SMP_CMD_PAIRING_REQ;
-	memcpy(&smp->preq[1], &cp, sizeof(cp));
+	return 0;
+}
 
-	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
-	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
+static void smp_send_security_req(struct smp_chan *smp, __u8 auth)
+{
+	struct smp_cmd_security_req cp;
 
-	return 0;
+	cp.auth_req = auth;
+	smp_send_cmd(smp->conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
+	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_REQ);
+
+	clear_bit(SMP_FLAG_INITIATOR, &smp->flags);
 }
 
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
@@ -2428,23 +2450,11 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 			authreq |= SMP_AUTH_MITM;
 	}
 
-	if (hcon->role == HCI_ROLE_MASTER) {
-		struct smp_cmd_pairing cp;
-
-		build_pairing_cmd(conn, &cp, NULL, authreq);
-		smp->preq[0] = SMP_CMD_PAIRING_REQ;
-		memcpy(&smp->preq[1], &cp, sizeof(cp));
-
-		smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
-		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
-	} else {
-		struct smp_cmd_security_req cp;
-		cp.auth_req = authreq;
-		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
-		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_REQ);
-	}
+	if (hcon->role == HCI_ROLE_MASTER)
+		smp_send_pairing_req(smp, authreq);
+	else
+		smp_send_security_req(smp, authreq);
 
-	set_bit(SMP_FLAG_INITIATOR, &smp->flags);
 	ret = 0;
 
 unlock:
@@ -2695,8 +2705,6 @@ static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 
 static u8 sc_select_method(struct smp_chan *smp)
 {
-	struct l2cap_conn *conn = smp->conn;
-	struct hci_conn *hcon = conn->hcon;
 	struct smp_cmd_pairing *local, *remote;
 	u8 local_mitm, remote_mitm, local_io, remote_io, method;
 
@@ -2709,7 +2717,7 @@ static u8 sc_select_method(struct smp_chan *smp)
 	 * the "struct smp_cmd_pairing" from them we need to skip the
 	 * first byte which contains the opcode.
 	 */
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		local = (void *) &smp->preq[1];
 		remote = (void *) &smp->prsp[1];
 	} else {
@@ -2778,7 +2786,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	/* Non-initiating device sends its public key after receiving
 	 * the key from the initiating device.
 	 */
-	if (!hcon->out) {
+	if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		err = sc_send_public_key(smp);
 		if (err)
 			return err;
@@ -2840,7 +2848,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	}
 
 	if (smp->method == REQ_OOB) {
-		if (hcon->out)
+		if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
 				     sizeof(smp->prnd), smp->prnd);
 
@@ -2849,7 +2857,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 		return 0;
 	}
 
-	if (hcon->out)
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
 
 	if (smp->method == REQ_PASSKEY) {
@@ -2864,7 +2872,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	/* The Initiating device waits for the non-initiating device to
 	 * send the confirm value.
 	 */
-	if (conn->hcon->out)
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		return 0;
 
 	err = smp_f4(smp->tfm_cmac, smp->local_pk, smp->remote_pk, smp->prnd,
@@ -2898,7 +2906,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 	a[6] = hcon->init_addr_type;
 	b[6] = hcon->resp_addr_type;
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		local_addr = a;
 		remote_addr = b;
 		memcpy(io_cap, &smp->prsp[1], 3);
@@ -2923,7 +2931,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (crypto_memneq(check->e, e, 16))
 		return SMP_DHKEY_CHECK_FAILED;
 
-	if (!hcon->out) {
+	if (!test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		if (test_bit(SMP_FLAG_WAIT_USER, &smp->flags)) {
 			set_bit(SMP_FLAG_DHKEY_PENDING, &smp->flags);
 			return 0;
@@ -2935,7 +2943,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	sc_add_ltk(smp);
 
-	if (hcon->out) {
+	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		hci_le_start_enc(hcon, 0, 0, smp->tk, smp->enc_key_size);
 		hcon->enc_key_size = smp->enc_key_size;
 	}
@@ -3084,7 +3092,6 @@ static void bredr_pairing(struct l2cap_chan *chan)
 	struct l2cap_conn *conn = chan->conn;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
-	struct smp_cmd_pairing req;
 	struct smp_chan *smp;
 
 	bt_dev_dbg(hdev, "chan %p", chan);
@@ -3136,14 +3143,7 @@ static void bredr_pairing(struct l2cap_chan *chan)
 
 	bt_dev_dbg(hdev, "starting SMP over BR/EDR");
 
-	/* Prepare and send the BR/EDR SMP Pairing Request */
-	build_bredr_pairing_cmd(smp, &req, NULL);
-
-	smp->preq[0] = SMP_CMD_PAIRING_REQ;
-	memcpy(&smp->preq[1], &req, sizeof(req));
-
-	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(req), &req);
-	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
+	smp_send_pairing_req(smp, 0x00);
 }
 
 static void smp_resume_cb(struct l2cap_chan *chan)
-- 
2.43.0




