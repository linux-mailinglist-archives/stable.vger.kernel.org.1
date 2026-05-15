Return-Path: <stable+bounces-248950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iODZJqGpB2pTBQMAu9opvQ
	(envelope-from <stable+bounces-248950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 01:17:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 626BB5594E2
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 01:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD3303008C33
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 23:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26DD3E9C3C;
	Fri, 15 May 2026 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0U8no50"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AF035E1A2
	for <stable@vger.kernel.org>; Fri, 15 May 2026 23:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778887071; cv=none; b=U3OFM4/fXXkAs4UoTJGi2LKuQ2c2BdGAmxkskeyyHFETY+avOBLpz12IL5pvuPOi96Ck/78I6J1kecqBZVrAnQo1R17kI1UDh/k5txsuqLCFzTWFemIfG7KvRufqg6dO8OnN4KVXqoL7j/63LpT1rTDUmaQgLDaGO02dncFU6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778887071; c=relaxed/simple;
	bh=MJA8hjHPUAnSq/UXi6jEhlken4B5C2PMU8buW7eSk9U=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=QbV3lE0KRylK1PjaJ2b47UkMHcl8EkIM1ab5liz8wmTQaMsJFTpn61XjBa98FHs/HvBOeZAhHViMejXrs3FAUqORHAbPMmleusCxYPJ5aQ7sa6WDP2xe7LvD6QYDYAHIDcxcGxx2VPJKkrwPX9UTdqeHlH67Z+4kWSUOd9yxUWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0U8no50; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778887069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IOf8cp7Ny9rpdzICKLelpYU/6Xa9mH94tlaYVPb3mo0=;
	b=A0U8no50qjS+sy3Lusr6uVjbeNAqcAh8SGabUF7yqsQ9hr1bThEsY5YsKF9RSVq9vjnOXD
	LUiqVX8ejCLWnYLqSGm4Kh2I4L5ZdFt0W1w+DsGhYb7TJchgOM+baKVMR83ihk+sID6AMG
	ybKoO5tqNNPQmDzXn7TnYZoZ1DhRff8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-IOuWP3LCM7STCuW2CV8jRg-1; Fri,
 15 May 2026 19:17:44 -0400
X-MC-Unique: IOuWP3LCM7STCuW2CV8jRg-1
X-Mimecast-MFC-AGG-ID: IOuWP3LCM7STCuW2CV8jRg_1778887063
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42BFB180035D;
	Fri, 15 May 2026 23:17:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.83])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B23D41956053;
	Fri, 15 May 2026 23:17:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <140786c6-e788-4860-95fc-7dbaf30eb51f@auristor.com>
References: <140786c6-e788-4860-95fc-7dbaf30eb51f@auristor.com> <20260513180907.2061972-1-michael.bommarito@gmail.com>
To: Jeffrey E Altman <jaltman@auristor.com>
Cc: dhowells@redhat.com, Michael Bommarito <michael.bommarito@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    "David S .
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    linux-afs@lists.infradead.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rxrpc: Fix read+write past skb_headlen in soft-ACK parser
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2718935.1778887058.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 00:17:38 +0100
Message-ID: <2718936.1778887058@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 626BB5594E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-248950-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,auristor.com,davemloft.net,google.com,kernel.org,lists.infradead.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,auristor.com:email]
X-Rspamd-Action: no action

Jeffrey E Altman <jaltman@auristor.com> wrote:

> Aborting the call because skb_condense() was unable to consolidate the r=
x ack
> packet data is an unfriendly thing to do.
> =

> As suggested by the commit message, copying the data before processing w=
ould
> be a friendlier solution to the identified problem.

Agreed.  Something along the lines of the attached.  It still needs a bit =
more
polishing, though.

David
---
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 24aceb183c2c..dde87b058a23 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -963,21 +963,30 @@ static void rxrpc_input_soft_acks(struct rxrpc_call =
*call,
 	struct rxrpc_skb_priv *sp =3D rxrpc_skb(skb);
 	struct rxrpc_txqueue *tq =3D call->tx_queue;
 	unsigned long extracted =3D ~0UL;
-	unsigned int nr =3D 0;
+	unsigned int nr =3D 0, nsack;
 	rxrpc_seq_t seq =3D call->acks_hard_ack + 1;
 	rxrpc_seq_t lowest_nak =3D seq + sp->ack.nr_acks;
-	u8 *acks =3D skb->data + sizeof(struct rxrpc_wire_header) + sizeof(struc=
t rxrpc_ackpacket);
+	u8 sack[256] __aligned(sizeof(unsigned long));
+	u8 *acks =3D sack;
 =

 	_enter("%x,%x,%u", tq->qbase, seq, sp->ack.nr_acks);
 =

 	while (after(seq, tq->qbase + RXRPC_NR_TXQUEUE - 1))
 		tq =3D tq->next;
 =

+	/* Extract a SACK table.  A SACK table can hold up to 256*8 ACK bits. */
+	memset(sack, 0, sizeof(sack));
+	nsack =3D umin(sp->ack.nr_acks, 256);
+	if (skb_copy_bits(skb,
+			  sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket),
+			  sack, nsack) < 0)
+		return;
+
 	for (unsigned int i =3D 0; i < sp->ack.nr_acks; i++) {
 		/* Decant ACKs until we hit a txqueue boundary. */
 		shiftr_adv_rotr(acks, extracted);
 		if (i =3D=3D 256) {
-			acks -=3D i;
+			acks =3D sack;
 			i =3D 0;
 		}
 		seq++;


