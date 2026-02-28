Return-Path: <stable+bounces-220550-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMFtJThOo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220550-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:21:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B8C1C841D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0DED3300595
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805A03D5660;
	Sat, 28 Feb 2026 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGcXcQ1R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430063D5657;
	Sat, 28 Feb 2026 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300432; cv=none; b=CKO2Y+0JGQzdZ7i35cYG/sB5FTkP4KzwDGSA12g5+UjcGY4nZzrEK9teBv6VkpWxqSbdSmuAwbqEb0HFz8lEX+h8xKPFbM/VdzQejW4fgGh/qLy1bmZZkw7MtAF6E/s8uNJ+IdJcfPsG0Ztat33W2yxWnQqy00F/mEq8FYt6BJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300432; c=relaxed/simple;
	bh=lEa1RlafBsckoZh6eMRjQETxXFx6+7H+LvTwJMaPMvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cX/MmhXZwsW8TfZe5YeQ3LL8gxilsSOZPU3tnpP1GYBr/DH02hj4ESCTcljG8v8bvJ27MDIgkvrMQDV/QFjzlatCg88BI0sV/RzDxxmIdH9Ggxva2PFylA/bb4dmBwxKJKHotOG2JIUvc8NzSHib6eT97m3zVSBxkfF02aOB2CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGcXcQ1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A365FC19424;
	Sat, 28 Feb 2026 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300432;
	bh=lEa1RlafBsckoZh6eMRjQETxXFx6+7H+LvTwJMaPMvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGcXcQ1Rg5v0SYzEKN95uPnPvyiWQQJHb1mjIPY8M0m36YKXQkfGeUsiU8E6dGkD9
	 kY2eWE5FUPu4K61ploPpG/XScLPurJUWuEx76Ci7Pc6Rg+8hB2XhI7otyng3Yv2hPO
	 KQidGTENiG/fJPEhqUIfqKj/09Ve48nwiVBn5BKdbj6VVZs6mR8uGO67j2oSuriIOf
	 1QbVusk5AA8yebNtT130Rjmknd7XrpuWwP/e6MPsFHLoDui1NQHNJyYHCvGyZbnkOq
	 1JTZnOdQo6ywMiIVyNIgXxdspA4jXWOT3iGKRzN69WLubJ3tkwRRrAnU/g7QTr+oaj
	 vcz1ypwDmg85A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 471/844] Bluetooth: L2CAP: Fix result of L2CAP_ECRED_CONN_RSP when MTU is too short
Date: Sat, 28 Feb 2026 12:26:24 -0500
Message-ID: <20260228173244.1509663-472-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220550-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36B8C1C841D
X-Rspamd-Action: no action

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit c28d2bff70444a85b3b86aaf241ece9408c7858c ]

Test L2CAP/ECFC/BV-26-C expect the response to L2CAP_ECRED_CONN_REQ with
and MTU value < L2CAP_ECRED_MIN_MTU (64) to be L2CAP_CR_LE_INVALID_PARAMS
rather than L2CAP_CR_LE_UNACCEPT_PARAMS.

Also fix not including the correct number of CIDs in the response since
the spec requires all CIDs being rejected to be included in the
response.

Link: https://github.com/bluez/bluez/issues/1868
Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/l2cap.h |  6 +++---
 net/bluetooth/l2cap_core.c    | 14 ++++++++------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 9820ccc379f1c..f08ed93bb6fa3 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -284,9 +284,9 @@ struct l2cap_conn_rsp {
 #define L2CAP_CR_LE_BAD_KEY_SIZE	0x0007
 #define L2CAP_CR_LE_ENCRYPTION		0x0008
 #define L2CAP_CR_LE_INVALID_SCID	0x0009
-#define L2CAP_CR_LE_SCID_IN_USE		0X000A
-#define L2CAP_CR_LE_UNACCEPT_PARAMS	0X000B
-#define L2CAP_CR_LE_INVALID_PARAMS	0X000C
+#define L2CAP_CR_LE_SCID_IN_USE		0x000A
+#define L2CAP_CR_LE_UNACCEPT_PARAMS	0x000B
+#define L2CAP_CR_LE_INVALID_PARAMS	0x000C
 
 /* connect/create channel status */
 #define L2CAP_CS_NO_INFO	0x0000
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e705b4a171dec..0b236e977d70e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5035,13 +5035,15 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	struct l2cap_chan *chan, *pchan;
 	u16 mtu, mps;
 	__le16 psm;
-	u8 result, len = 0;
+	u8 result, rsp_len = 0;
 	int i, num_scid;
 	bool defer = false;
 
 	if (!enable_ecred)
 		return -EINVAL;
 
+	memset(pdu, 0, sizeof(*pdu));
+
 	if (cmd_len < sizeof(*req) || (cmd_len - sizeof(*req)) % sizeof(u16)) {
 		result = L2CAP_CR_LE_INVALID_PARAMS;
 		goto response;
@@ -5050,6 +5052,9 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	cmd_len -= sizeof(*req);
 	num_scid = cmd_len / sizeof(u16);
 
+	/* Always respond with the same number of scids as in the request */
+	rsp_len = cmd_len;
+
 	if (num_scid > L2CAP_ECRED_MAX_CID) {
 		result = L2CAP_CR_LE_INVALID_PARAMS;
 		goto response;
@@ -5059,7 +5064,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	mps  = __le16_to_cpu(req->mps);
 
 	if (mtu < L2CAP_ECRED_MIN_MTU || mps < L2CAP_ECRED_MIN_MPS) {
-		result = L2CAP_CR_LE_UNACCEPT_PARAMS;
+		result = L2CAP_CR_LE_INVALID_PARAMS;
 		goto response;
 	}
 
@@ -5079,8 +5084,6 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 
 	BT_DBG("psm 0x%2.2x mtu %u mps %u", __le16_to_cpu(psm), mtu, mps);
 
-	memset(pdu, 0, sizeof(*pdu));
-
 	/* Check if we have socket listening on psm */
 	pchan = l2cap_global_chan_by_psm(BT_LISTEN, psm, &conn->hcon->src,
 					 &conn->hcon->dst, LE_LINK);
@@ -5105,7 +5108,6 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		BT_DBG("scid[%d] 0x%4.4x", i, scid);
 
 		pdu->dcid[i] = 0x0000;
-		len += sizeof(*pdu->dcid);
 
 		/* Check for valid dynamic CID range */
 		if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_LE_DYN_END) {
@@ -5172,7 +5174,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		return 0;
 
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_ECRED_CONN_RSP,
-		       sizeof(*pdu) + len, pdu);
+		       sizeof(*pdu) + rsp_len, pdu);
 
 	return 0;
 }
-- 
2.51.0


