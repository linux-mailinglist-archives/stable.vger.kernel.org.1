Return-Path: <stable+bounces-242797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIQRHLhc92ljggIAu9opvQ
	(envelope-from <stable+bounces-242797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 16:33:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B954B6137
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 16:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE2093003D07
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 14:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0D61A680B;
	Sun,  3 May 2026 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sD+r6dF8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6E778F4F
	for <stable@vger.kernel.org>; Sun,  3 May 2026 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777818803; cv=none; b=LZQkPPTS6HAu9W7Jk5aIZZqn5LN3U488erX6pbUaq8Jh2gjYEn65g65pfmT0ORIXf7izfYJ2Jae97kg2RxRCfVvv0h6Tfl7Ym2fnEFfy4sKnp68QDN0ulaNbMqERdRH0WfqSaI2njED1f+bVqSn+fjKUkQi6mAxciZQL8fZeA+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777818803; c=relaxed/simple;
	bh=rWw1b9B6OugRkPPkwf3R4M/zvmxoS/aeyUu38w6RFwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDQBtZf/eIEG1fJDu9t2EOWkR59C20g+QINohuxGgKY0buDOtx9872UVmH2b0n0rLWiT/uGfo8PJdRgDI/UUDnxAndKbqe1SswIKIBA+TWAeeGF0NU4eES+WaIynPH3/DQov6RElSSe5WQtP2Tr++AxDhZK6qZHXpFhL93oq1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sD+r6dF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD935C2BCB4;
	Sun,  3 May 2026 14:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777818802;
	bh=rWw1b9B6OugRkPPkwf3R4M/zvmxoS/aeyUu38w6RFwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sD+r6dF8xOM2KrvqmrT+SMVM3mkAqeOh/BGG9a8LkeqX1H7FM/cvaMwdydCnTujx1
	 r+lGklf9gKgF+BgQTHtCu8OcjStTpJaTz2fd7emcvsYCYR/bSLfvtSdYAI+MfSAjkR
	 divBjWgIaqEAysbW4vsopoY/KwjE+fXdnFKT1hGoeZKygCFLN2/FUaSOO2Ti3o3rvj
	 PL9sNFMBYhVh9+MdzgV76/Fg8NS3fw/zGKNOWUgDhTPdGFyJZGqpumXyf3TV+4zHvR
	 19IhG7BUqGtsWTJlbFoeHr30Zq9Vju40m3wSohx6y1pIMMfUPosYVODkqs4s9mnaKE
	 56hTwQ9hJdanQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
Date: Sun,  3 May 2026 10:33:17 -0400
Message-ID: <20260503143317.1089945-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050141-endearing-facedown-3f88@gregkh>
References: <2026050141-endearing-facedown-3f88@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 04B954B6137
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242797-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,msgid.link:url,auristor.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: David Howells <dhowells@redhat.com>

[ Upstream commit 24481a7f573305706054c59e275371f8d0fe919f ]

The security operations that verify the RESPONSE packets decrypt bits of it
in place - however, the sk_buff may be shared with a packet sniffer, which
would lead to the sniffer seeing an apparently corrupt packet (actually
decrypted).

Fix this by handing a copy of the packet off to the specific security
handler if the packet was cloned.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Closes: https://sashiko.dev/#/patchset/20260408121252.2249051-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260422161438.2593376-5-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/rxrpc.h |  2 ++
 net/rxrpc/conn_event.c       | 29 ++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 6965099dda89f..e8a5beca79cff 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -145,12 +145,14 @@
 	EM(rxrpc_skb_put_jumbo_subpacket,	"PUT jumbo-sub") \
 	EM(rxrpc_skb_put_last_nack,		"PUT last-nack") \
 	EM(rxrpc_skb_put_purge,			"PUT purge    ") \
+	EM(rxrpc_skb_put_response_copy,		"PUT resp-cpy ") \
 	EM(rxrpc_skb_put_rotate,		"PUT rotate   ") \
 	EM(rxrpc_skb_put_unknown,		"PUT unknown  ") \
 	EM(rxrpc_skb_see_conn_work,		"SEE conn-work") \
 	EM(rxrpc_skb_see_recvmsg,		"SEE recvmsg  ") \
 	EM(rxrpc_skb_see_reject,		"SEE reject   ") \
 	EM(rxrpc_skb_see_rotate,		"SEE rotate   ") \
+	EM(rxrpc_skb_see_unshare_nomem,		"SEE unshar-nm") \
 	E_(rxrpc_skb_see_version,		"SEE version  ")
 
 #define rxrpc_local_traces \
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 6ef2dc1aa8cc2..6d7b064661d88 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -226,6 +226,33 @@ static void rxrpc_call_is_secure(struct rxrpc_call *call)
 		rxrpc_notify_socket(call);
 }
 
+static int rxrpc_verify_response(struct rxrpc_connection *conn,
+				 struct sk_buff *skb)
+{
+	int ret;
+
+	if (skb_cloned(skb)) {
+		/* Copy the packet if shared so that we can do in-place
+		 * decryption.
+		 */
+		struct sk_buff *nskb = skb_copy(skb, GFP_NOFS);
+
+		if (nskb) {
+			rxrpc_new_skb(nskb, rxrpc_skb_new_unshared);
+			ret = conn->security->verify_response(conn, nskb);
+			rxrpc_free_skb(nskb, rxrpc_skb_put_response_copy);
+		} else {
+			/* OOM - Drop the packet. */
+			rxrpc_see_skb(skb, rxrpc_skb_see_unshare_nomem);
+			ret = -ENOMEM;
+		}
+	} else {
+		ret = conn->security->verify_response(conn, skb);
+	}
+
+	return ret;
+}
+
 /*
  * connection-level Rx packet processor
  */
@@ -253,7 +280,7 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 		}
 		spin_unlock(&conn->state_lock);
 
-		ret = conn->security->verify_response(conn, skb);
+		ret = rxrpc_verify_response(conn, skb);
 		if (ret < 0)
 			return ret;
 
-- 
2.53.0


