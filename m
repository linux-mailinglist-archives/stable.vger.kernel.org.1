Return-Path: <stable+bounces-269194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WbUUCOGnPmoLJwkAu9opvQ
	(envelope-from <stable+bounces-269194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:25:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3F16CEFFF
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:25:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=narfation.org header.s=20121 header.b=XyxCwvbk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269194-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269194-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=narfation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D883530D966B
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819624028FF;
	Fri, 26 Jun 2026 16:12:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C43F402B8A
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490361; cv=none; b=qxQii0Wz9ojmpMaP+c873M3Vk2SUdTwFF1A6ZiKgsiOVSUKpzD4/QrPWJcqLstCDNgP/ELH6Jn5FLMywunvQY3rgx2IFOAOz3WTv2NgD3me58VLhXCy/V9fePW19ZRBDhZrCGcqs3BBXj1cdwhZQ2wUD5GZnQ1DyT4stmT+hsaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490361; c=relaxed/simple;
	bh=IJjLgbgn//4EfLCgE7nZpttIonG4Wyqsc4cFA7lk0uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWtxia0yoNBc3x8QjNxkKmqxbiJWR/50fuDWQwgN5F24awcT2pwvMqLD8+zI3b1eN+midMlhGueZ2w9pAMlmJlzMxtZNqUVkfOSFV+nCVxWhyXwnFsnkfzk7az7hU7MUoUA/jTjbUkWo3ewv6jWwPxZwwBACE0+L5dc8dplkL9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=XyxCwvbk; arc=none smtp.client-ip=213.160.73.56
Received: by dvalin.narfation.org (Postfix) id A45DB202D1;
	Fri, 26 Jun 2026 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWrmmhMAjlB4HphxnAITfmyESt6WvrFoC3p9UvQyiyU=;
	b=XyxCwvbknj7GQPNS1pGZr7Bs4bdGg1au1uE18KDxE+u/4UeIhu4dPdJ6gRgrqRSusTq0gY
	GkReKGr6CaBGsoipau/oxXoa+aOgV9g9mNPHCdODEwlNxKfrMNtMDjrimz2XM/TiuVQw2S
	acM2slrPKxWqOg+Fbyi5gDitN2aptNo=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.0 21/26] batman-adv: tp_meter: handle overlapping packets
Date: Fri, 26 Jun 2026 18:12:20 +0200
Message-ID: <20260626161225.124839-22-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161225.124839-1-sven@narfation.org>
References: <20260626161225.124839-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269194-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sven@narfation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[narfation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,narfation.org:dkim,narfation.org:email,narfation.org:mid,narfation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D3F16CEFFF

commit cbde75c38b21f022891525078622587ad557b7c1 upstream.

If the size of the packets would change during the transmission, it could
happen that some retries of packets are overlapping. In this case, precise
comparisons of sequence numbers by the receiver would be wrong. It is then
necessary to check if the start sequence number to the end sequence number
("seqno + length") would contain a new range.

If this is the case then this is enough to accept this packet. In all other
cases, the packet still has to be dropped (and not acked).

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
[ Switch to pre-splitted tp_vars structure names ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 6a23050f03d89..dbaae33db0f1f 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1284,7 +1284,8 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
 /**
  * batadv_tp_handle_out_of_order() - store an out of order packet
  * @tp_vars: the private data of the current TP meter session
- * @skb: the buffer containing the received packet
+ * @seqno: sequence number of new received packet
+ * @payload_len: length of the received packet
  *
  * Store the out of order packet in the unacked list for late processing. This
  * packets are kept in this list so that they can be ACKed at once as soon as
@@ -1293,22 +1294,17 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
  * Return: true if the packed has been successfully processed, false otherwise
  */
 static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
-					  const struct sk_buff *skb)
+					  u32 seqno, u32 payload_len)
 	__must_hold(&tp_vars->unacked_lock)
 {
-	const struct batadv_icmp_tp_packet *icmp;
 	struct batadv_tp_unacked *un, *new;
-	u32 payload_len;
 	bool added = false;
 
 	new = kmalloc_obj(*new, GFP_ATOMIC);
 	if (unlikely(!new))
 		return false;
 
-	icmp = (struct batadv_icmp_tp_packet *)skb->data;
-
-	new->seqno = ntohl(icmp->seqno);
-	payload_len = skb->len - sizeof(struct batadv_unicast_packet);
+	new->seqno = seqno;
 	new->len = payload_len;
 
 	/* if the list is empty immediately attach this new object */
@@ -1476,7 +1472,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 {
 	const struct batadv_icmp_tp_packet *icmp;
 	struct batadv_tp_vars *tp_vars;
-	size_t packet_size;
+	u32 payload_len;
 	u32 to_ack;
 	u32 seqno;
 
@@ -1511,15 +1507,17 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 	/* if the packet is a duplicate, it may be the case that an ACK has been
 	 * lost. Resend the ACK
 	 */
-	if (batadv_seq_before(seqno, tp_vars->last_recv))
+	payload_len = skb->len - sizeof(struct batadv_unicast_packet);
+	to_ack = seqno + payload_len;
+	if (batadv_seq_before(to_ack, tp_vars->last_recv))
 		goto send_ack;
 
 	/* if the packet is out of order enqueue it */
-	if (ntohl(icmp->seqno) != tp_vars->last_recv) {
+	if (batadv_seq_before(tp_vars->last_recv, seqno)) {
 		/* exit immediately (and do not send any ACK) if the packet has
 		 * not been enqueued correctly
 		 */
-		if (!batadv_tp_handle_out_of_order(tp_vars, skb)) {
+		if (!batadv_tp_handle_out_of_order(tp_vars, seqno, payload_len)) {
 			spin_unlock_bh(&tp_vars->unacked_lock);
 			goto out;
 		}
@@ -1529,8 +1527,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 	}
 
 	/* if everything was fine count the ACKed bytes */
-	packet_size = skb->len - sizeof(struct batadv_unicast_packet);
-	tp_vars->last_recv += packet_size;
+	tp_vars->last_recv = to_ack;
 
 	/* check if this ordered message filled a gap.... */
 	batadv_tp_ack_unordered(tp_vars);
-- 
2.47.3


