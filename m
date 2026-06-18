Return-Path: <stable+bounces-267140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1ENTNqD3M2qnJwYAu9opvQ
	(envelope-from <stable+bounces-267140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 15:50:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 471F16A0B59
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 15:50:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="TNrRV/J6";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267140-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267140-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1BB5309B563
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 13:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2E82D8DDF;
	Thu, 18 Jun 2026 13:48:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86D63112A5
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 13:48:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790513; cv=none; b=rbW+ojUBET/hRTi+08mos6Wwh4BNQYC9F9VqXOS4lr5wmiXjLDUN6hKPmCEB2VS/kzXIbGMnhPzMoYSENcbkH+pF+S0uO7If3xtHNKan5b/pSoSCq7iXnVODCT3HU4XkuwYs1RwNWhffzi3aLIGqouCqThuhuvs7vIJ8qCqU8sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790513; c=relaxed/simple;
	bh=P1I+KWbK76llHaE2wH3T1Kgg++GDTr9b0M+6bQ/aXrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bh2aHzzsns3Kufz/wbDEBln+ybF4gdIyyHgoki8/2ty44hzQd0brZ1kejgjL2k/t9KczzSjh1bKb4mZTJbYat8l55MdGuL85nQOcAnBAQFOj/wcp0tQyt08mooUGVZuD86y7hxusep5iNjbXwF9BQwvtc+YsBfvUy8P56L3q6zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNrRV/J6; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781790510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZ6shKU2Olrq5XLk9VR7nCy5qua26jmULBJsUITnQx4=;
	b=TNrRV/J6MqH0Xsv/w0iFOdl5PsHODMeJMjtfO6Vk19olcqjr5SiA6t9ocIsIqNWS16i78r
	hBakb3R8/+ZF2MHdqEVS5G0fdJ0anJVmv8DofA0N97eEsNZzHj2TqnEOj+7OO400eIna1G
	9LhLK0ao3hd6o360wWuBQdsz92D0Vxo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-6JVXqKUHMc2u0MXzeQltBQ-1; Thu,
 18 Jun 2026 09:48:25 -0400
X-MC-Unique: 6JVXqKUHMc2u0MXzeQltBQ-1
X-Mimecast-MFC-AGG-ID: 6JVXqKUHMc2u0MXzeQltBQ_1781790503
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 925B5189F3BC;
	Thu, 18 Jun 2026 13:48:16 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D04D618001D2;
	Thu, 18 Jun 2026 13:48:10 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	stable@vger.kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Zhengchuan Liang <zcliangcn@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>
Subject: [PATCH net v2 01/10] rxrpc: input: reject ACKALL outside transmit phase
Date: Thu, 18 Jun 2026 14:47:52 +0100
Message-ID: <20260618134802.2477777-2-dhowells@redhat.com>
In-Reply-To: <20260618134802.2477777-1-dhowells@redhat.com>
References: <20260618134802.2477777-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org,icloud.com,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-267140-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:bronzed_45_vested@icloud.com,m:stable@vger.kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,infradead.org:email,vger.kernel.org:from_smtp,icloud.com:email,auristor.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 471F16A0B59

From: Wyatt Feng <bronzed_45_vested@icloud.com>

rxrpc_input_ackall() accepts ACKALL packets without checking whether
the call is in a state that can legitimately have outstanding transmit
buffers.  A forged ACKALL can therefore reach a new service call in
RXRPC_CALL_SERVER_RECV_REQUEST before any reply packets have been
queued.

In that state call->tx_top is zero and call->tx_queue is NULL, so
rxrpc_rotate_tx_window() dereferences a NULL txqueue and triggers a
null-pointer dereference.

Fix rxrpc_input_ackall() to mirror the transmit-state gating already
used for normal ACK processing, and ignore ACKALL when there is no
outstanding transmit window to rotate.

Fixes: b341a0263b1b ("rxrpc: Implement progressive transmission queue struct")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 net/rxrpc/input.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index ce761466b02d..37881dffa898 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1214,8 +1214,22 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 static void rxrpc_input_ackall(struct rxrpc_call *call, struct sk_buff *skb)
 {
 	struct rxrpc_ack_summary summary = { 0 };
+	rxrpc_seq_t top = READ_ONCE(call->tx_top);
+
+	switch (__rxrpc_call_state(call)) {
+	case RXRPC_CALL_CLIENT_SEND_REQUEST:
+	case RXRPC_CALL_CLIENT_AWAIT_REPLY:
+	case RXRPC_CALL_SERVER_SEND_REPLY:
+	case RXRPC_CALL_SERVER_AWAIT_ACK:
+		break;
+	default:
+		return;
+	}
+
+	if (call->tx_bottom == top)
+		return;
 
-	if (rxrpc_rotate_tx_window(call, call->tx_top, &summary))
+	if (rxrpc_rotate_tx_window(call, top, &summary))
 		rxrpc_end_tx_phase(call, false, rxrpc_eproto_unexpected_ackall);
 }
 


