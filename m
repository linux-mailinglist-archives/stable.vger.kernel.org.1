Return-Path: <stable+bounces-249926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHk0BYe/DWr32wUAu9opvQ
	(envelope-from <stable+bounces-249926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:04:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6354F58F45E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C776300CE53
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FD939B94C;
	Wed, 20 May 2026 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLuaInrL"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0059C23C39A
	for <stable@vger.kernel.org>; Wed, 20 May 2026 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285050; cv=none; b=ohHBN72WRKyGgLOUY4QaL1FTxHR+m/CjdNGSs/0pwa5x6/Z6IyHvxGhBr5bpITZJjbm93vUOkRG4g6Y6m/zPE3394jSzpw9BhAly1Z8amGNUpbkflfIp8vGxkY8zLHQvJQn33al0n9Tuk/9DdemJB0iterRKwDb/emZpq/wOIPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285050; c=relaxed/simple;
	bh=V8kEWX7aacPDgr69xJjI766tL4M9rqVYuHze2pOIrps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H0dNbEJx1epHdDJ438cKQTA5GIMRzPrnxGIBY9clnC81g58FFHy30toYOH2LTzFLTux12OaaZNhfP1hDlrl0k/Phlc4YU1b329hpnsI5A0cggKXtrjMFwyOqyTUWlCjMetOmdR03TIdNZataXVc5yRsrWo/DZCf9hNdSMPx5Eis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLuaInrL; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50e614fdb42so39107301cf.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779285048; x=1779889848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VWLZlw1o5rrWsIR88B5vFwajJpqsIVjTgSharoBZII8=;
        b=NLuaInrLfwbvjbCjfPE90t+InoopK+JcVVBlyiccs6vKFaHPeSIApxcHagNnO3F6OF
         NYdPJZXRllw3Y6x6c+aSDSnw2ywYjdbkGJpiasB8VtZPqxb24w4NHA1yIw2cN0iDIEc9
         UpjuGI3JRjCPZ4helqTCseWKnzUB5Ki5OYdv5u77m4T29aJ6sj8aHu5j+TeDa+XEYnGA
         +WkgqPiT3hBkEky6shAe1QlDSOhMQ46JPSm0fgmSVtwMS4jfWIDy2pqAYG6AbMmeUjao
         4issY2+GGYBsVGtcwk/4VM6ufzEdQ4Ug1+SQy1mtNlCyYHKWU2HLGF3NuqEG/YDR1Yuo
         QSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779285048; x=1779889848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWLZlw1o5rrWsIR88B5vFwajJpqsIVjTgSharoBZII8=;
        b=iKIlQqdQ4FRfOj3J6vzXp7RMF5c7EamakAYq2AJCeYTQoz4PrdMVTnfnAVKqwtDl7f
         ifIKIrxNBYmhrCqrVq1pArRZL0h4TTxOS+rlXWIg1yaItiUfbwL17LyIla8Ndc5t5DjG
         0xzZpLFLVgpSYDaKYjzGgEcIrdSpvb/WkfG51h89bWAKoYK3++Xug6D2ROgsP1k3AxP0
         MT/Rie8RQEhgXfb3Gh5cmt3WFPczZ9AbwTNCBXNnR4KsEpUI3uwnIoKuFQXh8yrRuh3H
         LltNtZEewcKpTPL2xuNzTjvzRMfWHHHWasA1Kp/7v83y3o7PE4EhFnBIdFKtKn79g889
         twHA==
X-Forwarded-Encrypted: i=1; AFNElJ9zsEi6CSBKFF/KN8vjD/8fmE+EFBQs+BqPwSWwHri+eauc61T10URt6DXrdOYWip+lEG96MZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAelx3w3NvXhw5hoWTltFU9r2wCFCwhldVKqccEpNtGeR8qdX0
	gDpCAd40DSGmCeCplg14tRKA+ik+IYIH0dF5Cd0eaqHN1sLryNxL2pQs
X-Gm-Gg: Acq92OH2I29VpswCJtlJpZPPwCHCagBkHhI7iyHU14SwCLXLVa1nSUgVQoOw3Ztejeo
	YLAH2KD4CLyZCBNlBxtFHiPB3s5kJScFzAxop2iNKGx9k8k3ZNFtBAjZc2k8ufqHJlU7aDKhvbp
	5iVEUR5EPf9kBh1bwvO9MpdazRHHjY4qM/Vxv/3lxAkGtmCg8EEFRhhocPziB+dBEAgPxra3vq4
	TfaNIzNxtWIyaZ4FtsbC1p7XTfbGmFojcmWndQRhPni/sOvb96QIl76Hy91TpLyh+/mhHKI6GyD
	XJAkGjxz4295WXchHPE+BIAfcpE82RpSsyK6N+7NCGZy8xPeSSy5A5d6JCIP3hZAWzpv0mGunis
	BfcJEbs9gmF4AflMHVRBUyk57DYm7sKLey2PsgZ1nKuStQ6Cx8gHaWZ8AxPXwYAkX+d4ScG87yJ
	lLt6J5wYLxzIOlEI0FMMV8sGXOYXGiAa9ykzfTHEu2ufgVdMQpqkLlGVBo8eiSMZ/ahXDymKnaT
	9BfosURrC50T4mwGEZFSqaABMsHKes=
X-Received: by 2002:ac8:5cd0:0:b0:50e:60b7:bb40 with SMTP id d75a77b69052e-51659ede9c0mr359598541cf.0.1779285047670;
        Wed, 20 May 2026 06:50:47 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456889dcsm202159561cf.2.2026.05.20.06.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 06:50:46 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
Date: Wed, 20 May 2026 09:50:34 -0400
Message-ID: <20260520135034.1060859-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249926-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6354F58F45E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

net/bluetooth/l2cap_core.c:l2cap_sig_channel() accepts BR/EDR
signaling packets up to the channel MTU and dispatches each command
without enforcing the signaling MTU (MTUsig). A Bluetooth BR/EDR peer
within radio range can send a fixed-channel CID 0x0001 packet that is
larger than MTUsig and contains many L2CAP_ECHO_REQ commands before
pairing.

In a real-radio stock-kernel run, one 681-byte signaling
packet containing 168 zero-length ECHO_REQ commands made the target
transmit 168 ECHO_RSP frames over about 220 ms.

Define Linux's BR/EDR signaling MTU as the spec minimum of 48 bytes and
reject larger signaling packets before dispatching their commands. When
the over-MTUsig packet contains a request command, send one
L2CAP_COMMAND_REJECT_RSP with L2CAP_REJ_MTU_EXCEEDED and the first
request identifier; packets for which no valid request command is found
are dropped.

Cc: stable@vger.kernel.org
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Link: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@gmail.com
Assisted-by: Claude:claude-opus-4-7
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
I reproduced the stock behavior with a real-radio BR/EDR ACL link and a
harness that sends a single fixed-channel signaling packet containing
packed zero-length ECHO_REQ commands. The patched code builds for
net/bluetooth/l2cap_core.o on x86_64 defconfig. There are no in-tree
Bluetooth selftests that reference l2cap_sig_channel(), L2CAP_SIG_MTU,
or L2CAP_ECHO_REQ.

The unrestricted BR/EDR signaling parser and ECHO_REQ response path both
trace to the initial git import; no later introducing commit is
available for a Fixes tag.

Changes in v2:
- Replace the per-PDU echo-count cap with the MTUsig direction from
  review.
- Reject the whole over-MTUsig signaling packet with one
  L2CAP_REJ_MTU_EXCEEDED command reject.
- Add L2CAP_SIG_MTU and drop over-MTUsig packets when no valid request
  command identifier is found.

v1: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@gmail.com
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 60 +++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5172afee54943..e0a1f2293679a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -33,6 +33,7 @@
 /* L2CAP defaults */
 #define L2CAP_DEFAULT_MTU		672
 #define L2CAP_DEFAULT_MIN_MTU		48
+#define L2CAP_SIG_MTU			48	/* BR/EDR signaling MTU */
 #define L2CAP_DEFAULT_FLUSH_TO		0xFFFF
 #define L2CAP_EFS_DEFAULT_FLUSH_TO	0xFFFFFFFF
 #define L2CAP_DEFAULT_TX_WINDOW		63
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 77dec104a9c36..5417e3cb0636d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5626,6 +5626,55 @@ static inline void l2cap_sig_send_rej(struct l2cap_conn *conn, u16 ident)
 	l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej);
 }
 
+static bool l2cap_sig_cmd_is_req(u8 code)
+{
+	switch (code) {
+	case L2CAP_CONN_REQ:
+	case L2CAP_CONF_REQ:
+	case L2CAP_DISCONN_REQ:
+	case L2CAP_ECHO_REQ:
+	case L2CAP_INFO_REQ:
+	case L2CAP_CONN_PARAM_UPDATE_REQ:
+	case L2CAP_LE_CONN_REQ:
+	case L2CAP_ECRED_CONN_REQ:
+	case L2CAP_ECRED_RECONF_REQ:
+		return true;
+	}
+
+	return false;
+}
+
+static u8 l2cap_sig_first_req_ident(const struct sk_buff *skb)
+{
+	const u8 *data = skb->data;
+	unsigned int len = skb->len;
+
+	while (len >= L2CAP_CMD_HDR_SIZE) {
+		const struct l2cap_cmd_hdr *cmd = (const void *)data;
+		u16 cmd_len = le16_to_cpu(cmd->len);
+
+		if (cmd->ident && l2cap_sig_cmd_is_req(cmd->code))
+			return cmd->ident;
+
+		if (cmd_len > len - L2CAP_CMD_HDR_SIZE)
+			break;
+
+		data += L2CAP_CMD_HDR_SIZE + cmd_len;
+		len -= L2CAP_CMD_HDR_SIZE + cmd_len;
+	}
+
+	return 0;
+}
+
+static inline void l2cap_sig_send_mtu_rej(struct l2cap_conn *conn, u8 ident)
+{
+	struct l2cap_cmd_rej_mtu rej;
+
+	rej.reason = cpu_to_le16(L2CAP_REJ_MTU_EXCEEDED);
+	rej.max_mtu = cpu_to_le16(L2CAP_SIG_MTU);
+	l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej);
+}
+
 static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 				     struct sk_buff *skb)
 {
@@ -5638,6 +5687,17 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 	if (hcon->type != ACL_LINK)
 		goto drop;
 
+	if (skb->len > L2CAP_SIG_MTU) {
+		u8 ident = l2cap_sig_first_req_ident(skb);
+
+		BT_DBG("signaling packet exceeds MTU");
+
+		if (ident)
+			l2cap_sig_send_mtu_rej(conn, ident);
+
+		goto drop;
+	}
+
 	while (skb->len >= L2CAP_CMD_HDR_SIZE) {
 		u16 len;
 
-- 
2.53.0


