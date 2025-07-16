Return-Path: <stable+bounces-163132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313F3B07518
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 13:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22DFB7A9561
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 11:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D192F530E;
	Wed, 16 Jul 2025 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/s+UOpr"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F89C2F5327
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666825; cv=none; b=VDd3dmaridMkuJG5w+86gIFLCn1/lDV8TYI8ffBaOq0ZOZB18L4uT1bJu9gbiL1mR7dn9W5C06/ceku9wjA3WONnxlnL2g8k/JTc1Z8KJNI+WsqrQIwM+VX0hlH7h+qMz6qAarmQDP3eiI+Xe8dnBOsxXR2ZELSCnWpzwvS9fxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666825; c=relaxed/simple;
	bh=VqkAKQ06zuDBxT1InigwkYWey8fIft48GLNxeyinELw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIZUifQ+49rXweBODyGKOmqMa0nbpSn2jnYUUnHxPrInhTsBxlWSd9RQR804wOjdFiRiUf1HY6NxW4PjwkI0Xr91jeSv5LIN2NnksCwM2lbUOISdXPcxhGbZgeQJ5AATzPs6c94qweSuQB9FBz8kFTBAEuHtjgGp/h/KGRjC0KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/s+UOpr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752666822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAficW741eLddPXCBV20kWATJLxNZFQgJW7lDxysDlw=;
	b=L/s+UOprPSgfPBK1kq3xZVeI81bO99ky4bQlRwXPg34Kkvx4yJZuv8KGrDtXi9wZg4q6fq
	DQQPY0UetfPgNV4p+3X4Vi7fxTmUF6kh25cfivTz7XAPnKB0rRwhlmP55c65SqGMstVrM1
	4bGHf3HaTqz+OUhinfP8yz026ysKcCI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-9ovwdBxtMwCuI_sE_bpvEg-1; Wed,
 16 Jul 2025 07:53:39 -0400
X-MC-Unique: 9ovwdBxtMwCuI_sE_bpvEg-1
X-Mimecast-MFC-AGG-ID: 9ovwdBxtMwCuI_sE_bpvEg_1752666817
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EFE81800291;
	Wed, 16 Jul 2025 11:53:36 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 395D11800D82;
	Wed, 16 Jul 2025 11:53:32 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	"Junvyyang, Tencent Zhuque Lab" <zhuque@tencent.com>,
	LePremierHomme <kwqcheii@proton.me>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net 4/5] rxrpc: Fix transmission of an abort in response to an abort
Date: Wed, 16 Jul 2025 12:53:03 +0100
Message-ID: <20250716115307.3572606-5-dhowells@redhat.com>
In-Reply-To: <20250716115307.3572606-1-dhowells@redhat.com>
References: <20250716115307.3572606-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Under some circumstances, such as when a server socket is closing, ABORT
packets will be generated in response to incoming packets.  Unfortunately,
this also may include generating aborts in response to incoming aborts -
which may cause a cycle.  It appears this may be made possible by giving
the client a multicast address.

Fix this such that rxrpc_reject_packet() will refuse to generate aborts in
response to aborts.

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Junvyyang, Tencent Zhuque Lab <zhuque@tencent.com>
cc: LePremierHomme <kwqcheii@proton.me>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@vger.kernel.org
---
 net/rxrpc/output.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index ef7b3096c95e..17c33b5cf7dd 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -814,6 +814,9 @@ void rxrpc_reject_packet(struct rxrpc_local *local, struct sk_buff *skb)
 	__be32 code;
 	int ret, ioc;
 
+	if (sp->hdr.type == RXRPC_PACKET_TYPE_ABORT)
+		return; /* Never abort an abort. */
+
 	rxrpc_see_skb(skb, rxrpc_skb_see_reject);
 
 	iov[0].iov_base = &whdr;


