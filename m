Return-Path: <stable+bounces-266865-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /FU3HJ/XMmpc6AUAu9opvQ
	(envelope-from <stable+bounces-266865-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 19:21:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFD469BA61
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 19:21:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gueEKs+6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266865-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266865-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B06AF30A0124
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 17:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3609330B29;
	Wed, 17 Jun 2026 17:21:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8390F18871F;
	Wed, 17 Jun 2026 17:21:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716890; cv=none; b=lKDGIihXqXaiQzYTdfrEqq0jONNiM0Gf7hRlQsUc8GFz8XArElBOZa1C1aiY/iBYi8VsTIg2oAQPmF4xjuWzr9Qh9dcETQluWkgu4RNC3xxDB20wC068SAnPRZmYwbp+uPOmEUvNZrIHP805QOIzQzeKToEuC5gdmE7eLwKqHa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716890; c=relaxed/simple;
	bh=kVDNp51YB0ng9achNZzOxO46fgXV3Q14haQANYibHXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpWEBjG7UPpEA3nKhFE4qVebIhje8ADwxj2E/FNDSQwxCmpBwFDESTuiYplcgC0gG8K2yKm7pCI8e4krMT7lEPafRtinTFnVl1CfZSO2FFkU/vURrPmi+vuJpbKWLiwMdqtgNGRkvNs0er5SLKuQRfM6ZJU3bRr5gYzC5E8wt6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gueEKs+6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C711F000E9;
	Wed, 17 Jun 2026 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781716889;
	bh=KfnhS7WTKpzUl3Tl7krUqui9szDDKpDSk9N6PJMNTKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gueEKs+6NDlUQ0QVOV8TIyV5Wkrd/+NLJ2QTQscSTkDxTic0fAAXSKJQwwb5wTUuq
	 QVICFuPYH5835YK5GZovJYpKYhKQfZ7n3qYgVVMKYKHPfCDFUIy9W2tHzfrF8LEzwC
	 9Cmp3tFolP9ZtKQfxfdP/JMhPOCSKUhVs+orysTaoXspQ98vRlsxxonXhJF6R2M7U9
	 j+cEYGDi5NNskUmyVmfHtnZC3d/W5x4Wlm+yWSkeN/CpHyXjsLgTF2SK+dCiGhewMA
	 I+F+RS3rLpoAJkzEN8drjb5OqFgA0UIzMEAONy0Lfoxv5bOmb9B/R6K2/dl3msUCSx
	 Wjmv8QKKrR5fA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] rxrpc: Fix the ACK parser to extract the SACK table for parsing
Date: Wed, 17 Jun 2026 13:21:26 -0400
Message-ID: <20260617172126.254222-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061541-settle-letdown-ad0c@gregkh>
References: <2026061541-settle-letdown-ad0c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266865-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:dhowells@redhat.com,m:michael.bommarito@gmail.com,m:marc.dionne@auristor.com,m:jaltman@auristor.com,m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:netdev@vger.kernel.org,m:stable@kernel.org,m:sashal@kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,auristor.com,google.com,davemloft.net,kernel.org,lists.infradead.org,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,davemloft.net:email,msgid.link:url,auristor.com:email,infradead.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2AFD469BA61

From: David Howells <dhowells@redhat.com>

[ Upstream commit 333b6d5bb9f87827ac2639c737bf9613dbae7253 ]

Fix modification of the received skbuff in rxrpc_input_soft_acks() and a
potential incorrect access of the buffer in a fragmented UDP packet (the
packet would probably have to be deliberately pre-generated as fragmented)
when AF_RXRPC tries to extract the contents of the SACK table by copying
out the contents of the SACK table into a buffer before attempting to parse

AF_RXRPC assumes that it can just call skb_condense() and then validly
access the SACK table from skb->data and that it will be a flat buffer -
but skb_condense() can silently fail to do anything under some
circumstances.

Note that whilst rxrpc_input_soft_acks() should be able to parse extended
ACKs, the rest of AF_RXRPC doesn't currently support that.

Further, there's then no need to call skb_condense() in rxrpc_input_ack(),
so don't.

Fixes: d57a3a151660 ("rxrpc: Save last ACK's SACK table rather than marking txbufs")
Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
Link: https://lore.kernel.org/r/20260513180907.2061972-1-michael.bommarito@gmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
Link: https://patch.msgid.link/105362.1780573560@warthog.procyon.org.uk
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/input.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 6a075a7c190db3..ca2d40ba7098f5 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -775,9 +775,23 @@ static void rxrpc_input_soft_acks(struct rxrpc_call *call,
 				  rxrpc_seq_t since)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-	unsigned int i, old_nacks = 0;
+	unsigned int i, old_nacks = 0, nsack;
 	rxrpc_seq_t lowest_nak = seq + sp->ack.nr_acks;
-	u8 *acks = skb->data + sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket);
+	u8 sack[256] __aligned(sizeof(unsigned long));
+	u8 *acks = sack;
+
+	/* AF_RXRPC assumes that it can access the SACK table directly from
+	 * skb->data as a flat buffer, but the skb may be non-linear (e.g. a
+	 * fragmented UDP packet) and skb_condense() can silently fail to
+	 * linearise it.  Copy the SACK table out into a local buffer before
+	 * parsing it.
+	 */
+	memset(sack, 0, sizeof(sack));
+	nsack = umin(sp->ack.nr_acks, 256);
+	if (skb_copy_bits(skb,
+			  sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket),
+			  sack, nsack) < 0)
+		return;
 
 	for (i = 0; i < sp->ack.nr_acks; i++) {
 		if (acks[i] == RXRPC_ACK_TYPE_ACK) {
@@ -934,9 +948,6 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	    skb_copy_bits(skb, ioffset, &trailer, sizeof(trailer)) < 0)
 		return rxrpc_proto_abort(call, 0, rxrpc_badmsg_short_ack_trailer);
 
-	if (nr_acks > 0)
-		skb_condense(skb);
-
 	if (call->cong_last_nack) {
 		since = rxrpc_input_check_prev_ack(call, &summary, first_soft_ack);
 		rxrpc_free_skb(call->cong_last_nack, rxrpc_skb_put_last_nack);
-- 
2.53.0


