Return-Path: <stable+bounces-246854-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDAGNSiABGrVKwIAu9opvQ
	(envelope-from <stable+bounces-246854-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:44:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 600B453444F
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA02232CB53E
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A32B44BCB5;
	Wed, 13 May 2026 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpekMORj"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52AC3191CA
	for <stable@vger.kernel.org>; Wed, 13 May 2026 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778678408; cv=none; b=CmbRG7HeoBpUc6WF+zJWHyo380s3aJPz0cmQLrDPMIQO9IDuTtIaxwDKvv7Vzp7BC/7qm9Ba9qA2i21sc/kM7XaaHh+9nd299lihDKKUNNP+zvnlXS5/Me42vsXk+erxK1lk/T8M3ID8YlCyDIYUCuMSz/eVkUKkm8R3Vi0Oq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778678408; c=relaxed/simple;
	bh=1wq79D3nGKTkntZMC8CN/zaZhTAXBHzvHtt1uRyz3zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQ4O/ffGtbHevlas8KNmXWjoajamKwbuySp5eUvAKvWYwbpHixx6gWfSZI5fxW1A9BgEWrCvQn30/CbcvkWUjbtjCA/BbOv7enC3WrHGZBSunDD4S0aoRM+Z3DYDpn0vCCVQrDlhrOFNJ++ld5DTfzkFDk8QrKWM1MlVD4Gz/DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MpekMORj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778678405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7MoziXQG2WA4V1u57xoCOqMWqJeGYIoOZWsTFA5qkY=;
	b=MpekMORjhd8Oj3rYUVRII4J2xlr+Ei8uNajjE5cA0dnKR8laTtITh7yDvxOQVNcPiLCHE1
	o2tM78LrYb0k+DWqWTenIhO1VGnBcaYD5m0xd/qctjkSHvAsTQGdrmqVjHx3LwxxJchdEg
	26TYfD1OF9Pr0ttDsiRZZYSo5B/NeB4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-WRlZzm9EOHGcMHeRZwi5oA-1; Wed,
 13 May 2026 09:20:00 -0400
X-MC-Unique: WRlZzm9EOHGcMHeRZwi5oA-1
X-Mimecast-MFC-AGG-ID: WRlZzm9EOHGcMHeRZwi5oA_1778678395
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A4C518005B9;
	Wed, 13 May 2026 13:19:55 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.83])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D9DD41800347;
	Wed, 13 May 2026 13:19:51 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/4] rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present
Date: Wed, 13 May 2026 14:19:37 +0100
Message-ID: <20260513131941.1439155-2-dhowells@redhat.com>
In-Reply-To: <20260513131941.1439155-1-dhowells@redhat.com>
References: <20260513131941.1439155-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 600B453444F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246854-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Hyunwoo Kim <imv4bel@gmail.com>

The DATA-packet handler in rxrpc_input_call_event() and the RESPONSE
handler in rxrpc_verify_response() copy the skb to a linear one before
calling into the security ops only when skb_cloned() is true.  An skb
that is not cloned but still carries externally-owned paged fragments
(e.g. SKBFL_SHARED_FRAG set by splice() into a UDP socket via
__ip_append_data, or a chained skb_has_frag_list()) falls through to
the in-place decryption path, which binds the frag pages directly into
the AEAD/skcipher SGL via skb_to_sgvec().

Extend the gate to also unshare when skb_has_frag_list() or
skb_has_shared_frag() is true.  This catches the splice-loopback vector
and other externally-shared frag sources while preserving the
zero-copy fast path for skbs whose frags are kernel-private (e.g. NIC
page_pool RX, GRO).  The OOM/trace handling already in place is reused.

Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/rxrpc/call_event.c | 4 +++-
 net/rxrpc/conn_event.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index fdd683261226..2b19b252225e 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -334,7 +334,9 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 
 			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
 			    sp->hdr.securityIndex != 0 &&
-			    skb_cloned(skb)) {
+			    (skb_cloned(skb) ||
+			     skb_has_frag_list(skb) ||
+			     skb_has_shared_frag(skb))) {
 				/* Unshare the packet so that it can be
 				 * modified by in-place decryption.
 				 */
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index a2130d25aaa9..442414d90ba1 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -245,7 +245,8 @@ static int rxrpc_verify_response(struct rxrpc_connection *conn,
 {
 	int ret;
 
-	if (skb_cloned(skb)) {
+	if (skb_cloned(skb) || skb_has_frag_list(skb) ||
+	    skb_has_shared_frag(skb)) {
 		/* Copy the packet if shared so that we can do in-place
 		 * decryption.
 		 */


