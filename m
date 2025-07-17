Return-Path: <stable+bounces-163225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7EFB0874B
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 09:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A481AA20C4
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 07:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FE72586C7;
	Thu, 17 Jul 2025 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpjavzbQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47E2550D2
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738282; cv=none; b=QKF7DtTGx6BRUZH0mbDw/29dvuP4d28nUFVBP+Hz2tDss7Tmr4oZXPOS/loznuuYld2w3f5xDbpNxfsy2PEkxsSZ49Y8N8ZbVW4WW2au5Q8b1l2/irQoWhDStrFPesAt/8roZb+tW3G/wT4gynoGDug7SjH3SONVrUoswh6PFu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738282; c=relaxed/simple;
	bh=VqkAKQ06zuDBxT1InigwkYWey8fIft48GLNxeyinELw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkyHw6bZZD6mhHcj7lBBXvGKp4jPtmEsHf2pvs0C9vuk9Z2+g0/+nZpQ/XPWYWXf7Q/7vzw1qhyaCYoylFk4DsxfQkxjt2nIAFG0UVIbsEzOhwtC2J2xo3WMo/X8Zd+Q8esgtQBAjGce18/31MRIPeJ9KbywSswDhCi/PNmNFW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpjavzbQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752738279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAficW741eLddPXCBV20kWATJLxNZFQgJW7lDxysDlw=;
	b=dpjavzbQYg418FLCqGDBveQptsANh0gjY5uSa0933U8CtXHUqsDJrpwkCnLtKx2I3gfoBr
	jGP5xNI4XxzZ2IDS6umwj6/WmTAjXPH3EqMgJBkb6MiKuiosDSMDG0m6waB1V6HM/0YA7H
	T7cnsPKpRTSzdHWryq/XyVzRbXxPaYw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-RlCiFFR5PBmjpEHwfb0agA-1; Thu,
 17 Jul 2025 03:44:37 -0400
X-MC-Unique: RlCiFFR5PBmjpEHwfb0agA-1
X-Mimecast-MFC-AGG-ID: RlCiFFR5PBmjpEHwfb0agA_1752738276
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8468319560B4;
	Thu, 17 Jul 2025 07:44:30 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E074C18016F9;
	Thu, 17 Jul 2025 07:44:25 +0000 (UTC)
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
Subject: [PATCH net v2 4/5] rxrpc: Fix transmission of an abort in response to an abort
Date: Thu, 17 Jul 2025 08:43:44 +0100
Message-ID: <20250717074350.3767366-5-dhowells@redhat.com>
In-Reply-To: <20250717074350.3767366-1-dhowells@redhat.com>
References: <20250717074350.3767366-1-dhowells@redhat.com>
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


