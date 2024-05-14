Return-Path: <stable+bounces-44307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E33EE8C522A
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B181C2114C
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095C312D755;
	Tue, 14 May 2024 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KnTzQHEO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC76B53E30;
	Tue, 14 May 2024 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685603; cv=none; b=lFJ8xdLddsBaLNqWXyJy2ussMN5500WoDP6MHUe8ozmJFAGyJscMM/1PELQiA52Mf/fbDyOKGkT0rYoGkIfKNNzn6QzgqDKquv/2xLWZrOVFAAdtYc8a4rFziyHncS7ZGfbpP29u4qh+nbRgKIoogMolHBiQieEVbsxlwIod5nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685603; c=relaxed/simple;
	bh=/+LejgYF+0t21hoP/0Q+tH2uHxgCGVjpqA4j6InBoQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hf6IC9k4ddDrsWTo7HdkqHhXvNbwySQY6KTCyWiXtcOmkKRKa4wbIPlegcNcjU4lw+P//IU1p46V3XCyIvew+Z88gdjBQj99AJHprpziy+wGUFDAVO5ITAtRQDf8fO/HLVXZ5oCJ1TUy15g8yMv3CXg8l1vtIYLa3pKIhPPjONQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KnTzQHEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5FAC2BD10;
	Tue, 14 May 2024 11:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715685603;
	bh=/+LejgYF+0t21hoP/0Q+tH2uHxgCGVjpqA4j6InBoQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KnTzQHEOIW1gfybQQY/2WL4NmH7jRRet7mkJ/qc5o6LebWt2Sz6XmQ7GB8YU+LH2S
	 gDqKGZ2exlxZfSjO81SqPXECmpqaPRd7kbVE+dCd3PErpSMR28VAE/2Qer7I6Gsouo
	 WI4P8+ReOnpzcFu85LiPRDt34jZhPx7xSCz7Lbjo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev, David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Jeffrey Altman <"jaltman@auristor.commailto:jaltman"@auristor.com>
Subject: [PATCH 6.6 196/301] rxrpc: Only transmit one ACK per jumbo packet received
Date: Tue, 14 May 2024 12:17:47 +0200
Message-ID: <20240514101039.656268436@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
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

From: David Howells <dhowells@redhat.com>

[ Upstream commit 012b7206918dcc5a4dcf1432b3e643114c95957e ]

Only generate one ACK packet for all the subpackets in a jumbo packet.  If
we would like to generate more than one ACK, we prioritise them base on
their reason code, in the order, highest first:

   OutOfSeq > NoSpace > ExceedsWin > Duplicate > Requested > Delay > Idle

For the first four, we reference the lowest offending subpacket; for the
last three, the highest.

This reduces the number of ACKs we end up transmitting to one per UDP
packet transmitted to reduce network loading and packet parsing.

Fixes: 5d7edbc9231e ("rxrpc: Get rid of the Rx ring")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Reviewed-by: Jeffrey Altman <jaltman@auristor.com <mailto:jaltman@auristor.com>>
Link: https://lore.kernel.org/r/20240503150749.1001323-3-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/input.c | 46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index f7304e06aadca..5dfda1ac51dda 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -9,6 +9,17 @@
 
 #include "ar-internal.h"
 
+/* Override priority when generating ACKs for received DATA */
+static const u8 rxrpc_ack_priority[RXRPC_ACK__INVALID] = {
+	[RXRPC_ACK_IDLE]		= 1,
+	[RXRPC_ACK_DELAY]		= 2,
+	[RXRPC_ACK_REQUESTED]		= 3,
+	[RXRPC_ACK_DUPLICATE]		= 4,
+	[RXRPC_ACK_EXCEEDS_WINDOW]	= 5,
+	[RXRPC_ACK_NOSPACE]		= 6,
+	[RXRPC_ACK_OUT_OF_SEQUENCE]	= 7,
+};
+
 static void rxrpc_proto_abort(struct rxrpc_call *call, rxrpc_seq_t seq,
 			      enum rxrpc_abort_reason why)
 {
@@ -366,7 +377,7 @@ static void rxrpc_input_queue_data(struct rxrpc_call *call, struct sk_buff *skb,
  * Process a DATA packet.
  */
 static void rxrpc_input_data_one(struct rxrpc_call *call, struct sk_buff *skb,
-				 bool *_notify)
+				 bool *_notify, rxrpc_serial_t *_ack_serial, int *_ack_reason)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct sk_buff *oos;
@@ -419,8 +430,6 @@ static void rxrpc_input_data_one(struct rxrpc_call *call, struct sk_buff *skb,
 		/* Send an immediate ACK if we fill in a hole */
 		else if (!skb_queue_empty(&call->rx_oos_queue))
 			ack_reason = RXRPC_ACK_DELAY;
-		else
-			call->ackr_nr_unacked++;
 
 		window++;
 		if (after(window, wtop)) {
@@ -498,12 +507,16 @@ static void rxrpc_input_data_one(struct rxrpc_call *call, struct sk_buff *skb,
 	}
 
 send_ack:
-	if (ack_reason >= 0)
-		rxrpc_send_ACK(call, ack_reason, serial,
-			       rxrpc_propose_ack_input_data);
-	else
-		rxrpc_propose_delay_ACK(call, serial,
-					rxrpc_propose_ack_input_data);
+	if (ack_reason >= 0) {
+		if (rxrpc_ack_priority[ack_reason] > rxrpc_ack_priority[*_ack_reason]) {
+			*_ack_serial = serial;
+			*_ack_reason = ack_reason;
+		} else if (rxrpc_ack_priority[ack_reason] == rxrpc_ack_priority[*_ack_reason] &&
+			   ack_reason == RXRPC_ACK_REQUESTED) {
+			*_ack_serial = serial;
+			*_ack_reason = ack_reason;
+		}
+	}
 }
 
 /*
@@ -514,9 +527,11 @@ static bool rxrpc_input_split_jumbo(struct rxrpc_call *call, struct sk_buff *skb
 	struct rxrpc_jumbo_header jhdr;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb), *jsp;
 	struct sk_buff *jskb;
+	rxrpc_serial_t ack_serial = 0;
 	unsigned int offset = sizeof(struct rxrpc_wire_header);
 	unsigned int len = skb->len - offset;
 	bool notify = false;
+	int ack_reason = 0;
 
 	while (sp->hdr.flags & RXRPC_JUMBO_PACKET) {
 		if (len < RXRPC_JUMBO_SUBPKTLEN)
@@ -536,7 +551,7 @@ static bool rxrpc_input_split_jumbo(struct rxrpc_call *call, struct sk_buff *skb
 		jsp = rxrpc_skb(jskb);
 		jsp->offset = offset;
 		jsp->len = RXRPC_JUMBO_DATALEN;
-		rxrpc_input_data_one(call, jskb, &notify);
+		rxrpc_input_data_one(call, jskb, &notify, &ack_serial, &ack_reason);
 		rxrpc_free_skb(jskb, rxrpc_skb_put_jumbo_subpacket);
 
 		sp->hdr.flags = jhdr.flags;
@@ -549,7 +564,16 @@ static bool rxrpc_input_split_jumbo(struct rxrpc_call *call, struct sk_buff *skb
 
 	sp->offset = offset;
 	sp->len    = len;
-	rxrpc_input_data_one(call, skb, &notify);
+	rxrpc_input_data_one(call, skb, &notify, &ack_serial, &ack_reason);
+
+	if (ack_reason > 0) {
+		rxrpc_send_ACK(call, ack_reason, ack_serial,
+			       rxrpc_propose_ack_input_data);
+	} else {
+		call->ackr_nr_unacked++;
+		rxrpc_propose_delay_ACK(call, sp->hdr.serial,
+					rxrpc_propose_ack_input_data);
+	}
 	if (notify) {
 		trace_rxrpc_notify_socket(call->debug_id, sp->hdr.serial);
 		rxrpc_notify_socket(call);
-- 
2.43.0




