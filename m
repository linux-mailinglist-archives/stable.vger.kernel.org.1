Return-Path: <stable+bounces-242808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIwOCvCL92mIiwIAu9opvQ
	(envelope-from <stable+bounces-242808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 19:54:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7479F4B6DA9
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 19:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1AD23006B33
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 17:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0353822A8;
	Sun,  3 May 2026 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UluUCg2N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7E6294A10
	for <stable@vger.kernel.org>; Sun,  3 May 2026 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777830892; cv=none; b=lfZuIq9SIfNSlsnix+ni1NtdErg1xjeVTBbAROVlGLOW4uit0kWWnfUJFak4Y+G2pAUJbqfPVx7ujQy6ATrRiwZsV3PcQug9ECjyVVHO7jr32L3YfaLLCNoF3CapQW1ROiU4V1yHCI9YvSifmAnScQPx9nalBnFWrWKBVNVSuxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777830892; c=relaxed/simple;
	bh=OYcf7noJjMrNPMXoo9K6LIjQ6Y7yZ4L+g/d7zjWeXr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mn9+EPWvx7f36wrhPihQvnvodMyLJ3EpXQEt9m4Ld1bS5Gh+kipYv0UsEE+9l7mqGDs+RBcBqZgl9b8X01j+S8vewkzIxgk70ajCrHDXfNGdn5DofndTF1w3MT2sCx5yhH5LtVGNfGSWV8AMwpRXztJGnCO7G6UvTfdd4QwU65E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UluUCg2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA9CC2BCB4;
	Sun,  3 May 2026 17:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777830891;
	bh=OYcf7noJjMrNPMXoo9K6LIjQ6Y7yZ4L+g/d7zjWeXr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UluUCg2NSk6TxLB14qN+tKzy1N0n+J92MTAs66CXvuXpIwm0g+YSlqBFG8DsvYxWl
	 4V4Q6HjJHm6Tmi20IS+3OBgzr5MSdRHE7LIUxVh2F+Z+7zKQsxhYO2D/yh7iTUgWUf
	 kMTDVDhyUQsOHiCikoRpNIdW6bVSNKjkHREna3Ou44jjXD3QA35id5/w9qCXm+WlKt
	 novRwKvyPz69uMbBjPXvd7kwJAVPVFPDBeiVBQ4ZfD6OqI8GUIsBmPJCIrDcMgZm+5
	 +y0bEvqfJ/4T6slfssb40SFq6Rov6M1pn8QiUbG67Ib4jr6cWmthHBZREuXOX1sl2O
	 0sMwJ/ouQXE7g==
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
Subject: [PATCH 6.1.y] rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
Date: Sun,  3 May 2026 13:54:46 -0400
Message-ID: <20260503175446.1150873-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050107-transpire-unsterile-a205@gregkh>
References: <2026050107-transpire-unsterile-a205@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7479F4B6DA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242808-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,auristor.com:email]

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
[ adapted callback signature to include `_abort_code` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/conn_event.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 5d91ef562ff78..09438850f9a5a 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -285,6 +285,34 @@ static void rxrpc_call_is_secure(struct rxrpc_call *call)
 	}
 }
 
+static int rxrpc_verify_response(struct rxrpc_connection *conn,
+				 struct sk_buff *skb,
+				 u32 *_abort_code)
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
+			rxrpc_new_skb(nskb, rxrpc_skb_unshared);
+			ret = conn->security->verify_response(conn, nskb, _abort_code);
+			rxrpc_free_skb(nskb, rxrpc_skb_freed);
+		} else {
+			/* OOM - Drop the packet. */
+			rxrpc_see_skb(skb, rxrpc_skb_unshared_nomem);
+			ret = -ENOMEM;
+		}
+	} else {
+		ret = conn->security->verify_response(conn, skb, _abort_code);
+	}
+
+	return ret;
+}
+
 /*
  * connection-level Rx packet processor
  */
@@ -337,7 +365,7 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 							    _abort_code);
 
 	case RXRPC_PACKET_TYPE_RESPONSE:
-		ret = conn->security->verify_response(conn, skb, _abort_code);
+		ret = rxrpc_verify_response(conn, skb, _abort_code);
 		if (ret < 0)
 			return ret;
 
-- 
2.53.0


