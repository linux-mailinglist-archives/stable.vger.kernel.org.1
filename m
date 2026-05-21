Return-Path: <stable+bounces-253409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEnHB5dMDmrL9gUAu9opvQ
	(envelope-from <stable+bounces-253409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:06:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 909C959D26D
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A17230BEEBB
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0AD3EA66;
	Thu, 21 May 2026 00:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdKfB16T"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFC11386C9
	for <stable@vger.kernel.org>; Thu, 21 May 2026 00:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321972; cv=none; b=UUMuTtlctXK6v0jtTQZCRbMPhpLSAYtQpbJ7K+udL5NFlCQVmW1o7vO05fEuW52fCV4cHhAoYxqCruUTcjBwUGFawKFZRjSFXSgYgxMGamF5s7FqHYoiPilmebjD/nerpy37vsq8gexSQhq5uz9alB2Pb1ldRlqrJ/QynlbIvkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321972; c=relaxed/simple;
	bh=zahVRzkLToA6oMFieq+LNgXnW2Tf/2BUPcvcXVza/7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6TxpyhwyDhoX7LZcFN3s2EMxq9n57UX20d/jb+bYk8nIpwAhkNxhlTYOplKcWcFIvdyaw5OsneyeCKfB+t94UAoeXwpA6KARH+mHRJP4spnlgMjfK0tQ2takaS+2omAVT3Aj6jHKSi+d+k8Xo6fu6820c54hhqiF+1P1BmyPHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdKfB16T; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-902deb2412fso681330185a.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 17:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779321970; x=1779926770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZNvk1BovRx97OnCimNnt74dFamxA5DuthwM7CtyImQ=;
        b=ZdKfB16TSYpDIZbZ0DLkuPoClmrOk0o8zUySVIJcBkr6zLq/QhJUEBU9xrmh1/TppG
         B4iIpo5WdElfingawitMeD8dNulFNSCEa2Ez8QSD5f9eMkEVeyI7a6C3vKAHZJahpMhm
         V6amTfRI74lQaQ62d0TqoIMlRAM2X82na8FfeRWcQPLCsV3WlRkWcifhiy9RJ76EOoBG
         NGUpEoOO8jhqDmimROmmsYX5ZvqZ3mWnhHH1RiG5ZKjqHTO0EItwpo63UavzGd6/o5or
         0dXXbvdl7XAddPdUwFl5v2VM2K5K2dplVs7bW4s/WJRWgEa4mETWc8Vf+OLG7HukpdIS
         YZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779321970; x=1779926770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ZNvk1BovRx97OnCimNnt74dFamxA5DuthwM7CtyImQ=;
        b=clEJY8/FmIHBwzsOl2vCRLGirZf8zJTIvLS0WcWdcDCGZ+53ZynueyZUvoo/ve9+1O
         sb3pj0rqZFjY8przzedwAa6jwAV/Mcy0LAH+QmUbvgMRFqg7QjyAgzyB1s4mLtKtig73
         riFvLGPEK5QIS0XHMANg/fAqKwVQXolh/SICfCZJ7vgQqAdhWmFj29Eedwf/nkLKvJpd
         qIPhqXBPOEWJBImsRcbQutRQpwaiLAzm96IWV7a+bKJMVMoN0tBKn2BnB/tf+6a0trLD
         Mg7SaYFlOGHSMBUgMwr2x5EZDYXT6rdmhqoYAQS54KwRVlO9iKmQQ+MVBZl30gNZJ1AF
         wNFQ==
X-Forwarded-Encrypted: i=1; AFNElJ/sSmMO12W4JH81tgM23YtS30ylcLlvPJNsGV1yvL/+xcNs6FqsTQYmHIbQhL/oms2zthvDFPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTzgVwI8ODe5iIMNo4mvSpvIimVo6M2XMNIvS1W2nGi/dPUpiu
	I+/tdHoZ3wGCbH4yAqisD0JXsTIDdapaCFieXvjK/E1Fv0DYFZawl+Ae
X-Gm-Gg: Acq92OF7qBJj1yCpqU3CQmtMtZh/wPma9yxMLQAB790TIZ+6X54JxzLMtVTO8w8kW/S
	1nMGQfV83vZ1mEUvsGdtdSi5CpEMMdCdLbdk8rVxncjF0O20UIiJHHoWOfmCFgMrZykl5Vx9ezl
	aDTp17r7qxwf0UwKFht854VIhKq/EUWlCSdxMYAqLXY1F5b8vS/AhWLpPe82hMvEPCdyJIORPia
	DHQ7yqW1j4IUXzlOo5iBJwLf4aPrlNDK7Hr79Ua1kmHNWzmyUGOLMFBXuSVx3LWmmHk8jI+uJPs
	8LnLQjAjQQg7GT85VHcwXS7Uy1WrC6wYDQzBh+UIHxfGfXhkQDL/exhfx6WCpFi4Z6r5wPluR1W
	1xkF7mdIIEOF8VDebM5aJVbTW1B0OGV5M3rMikWDf9DxpGZz9IxUkboOTZiBalfgtfV9M2Uh4NB
	v6OjzP2y6tQIAOZZ1roxrd7ZC4JrltWBQqNzNQ16vuTjJQee1BZ7O6OCRI5B0e8MwC78cO+/Apl
	g0Q8z7g7ojgDH4iXguU963uiqxEzF8=
X-Received: by 2002:a05:620a:19a0:b0:912:5d2a:4baf with SMTP id af79cd13be357-914a2e507e2mr67313885a.61.1779321969362;
        Wed, 20 May 2026 17:06:09 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf353b9sm2360405085a.35.2026.05.20.17.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 17:06:08 -0700 (PDT)
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
Subject: [PATCH v3] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
Date: Wed, 20 May 2026 20:05:55 -0400
Message-ID: <20260521000555.3712030-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520135034.1060859-1-michael.bommarito@gmail.com>
References: <20260520135034.1060859-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253409-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 909C959D26D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

net/bluetooth/l2cap_core.c:l2cap_sig_channel() accepts BR/EDR
signaling packets up to the channel MTU and dispatches each command
without enforcing the signaling MTU (MTUsig). A Bluetooth BR/EDR peer
within radio range can send a fixed-channel CID 0x0001 packet that is
larger than MTUsig and contains many L2CAP_ECHO_REQ commands before
pairing. In a real-radio stock-kernel run, one 681-byte signaling
packet containing 168 zero-length ECHO_REQ commands made the target
transmit 168 ECHO_RSP frames over about 220 ms.

Impact: a Bluetooth BR/EDR peer within radio range, before pairing, can
force 168 ECHO_RSP frames from one 681-byte fixed-channel signaling
packet containing packed ECHO_REQ commands.

Define Linux's BR/EDR signaling MTU as the spec minimum of 48 bytes and
reject any larger signaling packet with one L2CAP_COMMAND_REJECT_RSP
carrying L2CAP_REJ_MTU_EXCEEDED before any command is dispatched.

The Bluetooth Core spec wording for MTUExceeded says the reject
identifier shall match the first request command in the packet, and
that packets containing only responses shall be silently discarded.
Linux intentionally deviates from that prescription: silently
discarding desynchronizes the peer because the remote stack never
learns its responses were dropped, and locating the first request
command requires walking command headers past MTUsig, i.e. processing
bytes from a packet we have already decided is too large to process.
We therefore always emit one reject and use the identifier from the
first command header (a single fixed-offset byte read), falling back
to zero when the packet is too short to carry a header at all.

The unrestricted BR/EDR signaling parser and ECHO_REQ response path both
trace to the initial git import; no later introducing commit is
available for a Fixes tag.

Cc: stable@vger.kernel.org
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Link: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@gmail.com
Link: https://lore.kernel.org/r/20260520135034.1060859-1-michael.bommarito@gmail.com
Assisted-by: Claude:claude-opus-4-7
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
I reproduced the stock behavior with a real-radio BR/EDR ACL link and a
harness that sends a single fixed-channel signaling packet containing
packed zero-length ECHO_REQ commands, and confirmed on a patched kernel
that the same packet now produces one L2CAP_REJ_MTU_EXCEEDED command
reject and zero ECHO_RSP frames. The patched code builds for
net/bluetooth/l2cap_core.o on x86_64 defconfig with W=1. There are no
in-tree Bluetooth selftests that reference l2cap_sig_channel(),
L2CAP_SIG_MTU, or L2CAP_ECHO_REQ.

Changes in v3:
- Drop l2cap_sig_cmd_is_req() and l2cap_sig_first_req_ident(); the
  reject is now unconditional and uses only the first command
  header's identifier byte at a fixed offset. Per Luiz, the spec's
  "match the first request command identifier" rule would require
  parsing past MTUsig, and the spec's "silently discard if only
  responses" rule desynchronizes the peer.
- Replace the v2 walk with a verbose comment quoting the relevant
  Bluetooth Core section and documenting why Linux deviates.

Changes in v2:
- Replace the per-PDU echo-count cap with the MTUsig direction from
  review.
- Reject the whole over-MTUsig signaling packet with one
  L2CAP_REJ_MTU_EXCEEDED command reject.
- Add L2CAP_SIG_MTU and drop over-MTUsig packets when no valid request
  command identifier is found.

v1: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@gmail.com
v2: https://lore.kernel.org/r/20260520135034.1060859-1-michael.bommarito@gmail.com
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 47 +++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

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
index 7701528f11677..0b1e062057695 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5618,6 +5618,15 @@ static inline void l2cap_sig_send_rej(struct l2cap_conn *conn, u16 ident)
 	l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej);
 }
 
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
@@ -5630,6 +5639,44 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 	if (hcon->type != ACL_LINK)
 		goto drop;
 
+	/*
+	 * Bluetooth Core v5.4, Vol 3, Part A, Section 4: the BR/EDR
+	 * signaling channel has a fixed signaling MTU (MTUsig) whose
+	 * minimum and default is 48 octets.  Section 4.1 says that on
+	 * an MTUExceeded command reject the identifier "shall match
+	 * the first request command in the L2CAP packet" and that
+	 * packets containing only response commands "shall be
+	 * silently discarded".
+	 *
+	 * Linux intentionally deviates from that prescription:
+	 *
+	 *   1. Silently discarding desynchronizes the peer.  The
+	 *      remote stack never learns its responses were dropped,
+	 *      so any state machine waiting on a paired response
+	 *      stalls until its own timer fires.
+	 *
+	 *   2. Locating "the first request command" requires walking
+	 *      command headers past MTUsig, i.e. processing bytes
+	 *      from a packet we have already decided is too large to
+	 *      process.
+	 *
+	 * Reject every over-MTUsig signaling packet with one
+	 * L2CAP_REJ_MTU_EXCEEDED command reject.  The reject's
+	 * reason field is what tells the peer that the whole packet
+	 * was discarded; the identifier value is informational, so
+	 * we use the identifier from the first command header (a
+	 * single fixed-offset byte read) or zero when the packet is
+	 * too short to carry even one header.
+	 */
+	if (skb->len > L2CAP_SIG_MTU) {
+		u8 ident = (skb->len >= L2CAP_CMD_HDR_SIZE) ?
+			   skb->data[1] : 0;
+
+		BT_DBG("signaling packet exceeds MTU");
+		l2cap_sig_send_mtu_rej(conn, ident);
+		goto drop;
+	}
+
 	while (skb->len >= L2CAP_CMD_HDR_SIZE) {
 		u16 len;
 
-- 
2.53.0


