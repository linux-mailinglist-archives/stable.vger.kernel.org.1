Return-Path: <stable+bounces-262911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e0ThEzjqK2rKHgQAu9opvQ
	(envelope-from <stable+bounces-262911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 13:15:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4033678E78
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 13:15:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.de header.s=amazoncorp2 header.b="Azm3/R+j";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262911-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262911-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 088B732DC571
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 11:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF78037BE6B;
	Fri, 12 Jun 2026 11:14:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4411F38E8B9;
	Fri, 12 Jun 2026 11:14:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262846; cv=none; b=CM2gm67vUphj7HWwgh1mT6P6Qq/Z8GnhkyWHXpIYHp/2abJfyhojWUKAiOzcsH7E+xcWmWlrrTVQIaa0/MFNbz19NtRoD1pl0ft9IGjVOuumwKz9iPlPhnPiSxo7iRfRbUW4SZJN37TcyGe+aO08NJHnu23DajcRsR6+qnmH4QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262846; c=relaxed/simple;
	bh=lwS2mjjyvfL7Y/vGlE1qGvD5gNcwfMRdzcY1tSMInTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rcj8/LmzdCIwjlA/FKNXx3Lr+k08C3svyXSqjw6YILZnZnYdTfFFV/d4266DGeZewkklR9zYNl3CL7sgiAcH01305PyuB9JdRtX4MWP3FbC737dxM84jhaq443+e3JswsAvqk5V/BtmgrLDiSUY1N+CYcY7VlW7ZxQ5zPkVHDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=Azm3/R+j; arc=none smtp.client-ip=44.246.77.92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781262845; x=1812798845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6PqwA+LVbzNoMXoTYlcrxI8UCkT/UlPNaW7bamovlak=;
  b=Azm3/R+j5Rxexeu5dAX19KCsPSapm+krYapJjBFGzCKPyYYmb5yDU9XL
   jo5kglClbe4mR/QB3kwBt+xTYuYv7tQZVgD03yRrA/OXyDpjTPhcipa6k
   wp247RXpYbfLnxEFFdl80F0fBVj5KNcOWlE+1RGJ/6IXvbt/+saTsQA9J
   WmDYyiVOpmzxiN1x+ph3Gi3edUTSHuWCYol7+/ftKMj4ddV03CvMqtDQ9
   odrLQkEe5Hcz0s6oD4tEKMuD6hP3u7VIXM9owMcsIU/ZZN8yEQnsQbaOH
   Wpl9J4TcW+u4EfivNvl4k5zBrX6W6PV84rCzgrDqYzCszkeGZTJouLcRs
   A==;
X-CSE-ConnectionGUID: CQbufAqLTbWeszMkZ8BP1Q==
X-CSE-MsgGUID: p6kQN4RtTG+XfCYIQr7SEA==
X-IronPort-AV: E=Sophos;i="6.24,200,1774310400"; 
   d="scan'208";a="21622854"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 11:14:02 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:3594]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.226:2525] with esmtp (Farcaster)
 id 665a0bd8-382b-40a7-8335-41d6ad9abb96; Fri, 12 Jun 2026 11:14:02 +0000 (UTC)
X-Farcaster-Flow-ID: 665a0bd8-382b-40a7-8335-41d6ad9abb96
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 12 Jun 2026 11:14:02 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Fri, 12 Jun 2026
 11:13:59 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Simon Liebold <lieboldsimonpaul@gmail.com>,
	<sashal@kernel.org>
CC: Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, "Simon
 Liebold" <simonlie@amazon.de>
Subject: [PATCH 6.12.y v3 1/2] xfrm: hold device only for the asynchronous decryption
Date: Fri, 12 Jun 2026 11:13:26 +0000
Message-ID: <20260612111327.1613710-2-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260612111327.1613710-1-simonlie@amazon.de>
References: <20260612111327.1613710-1-simonlie@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[amazon.de:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:lieboldsimonpaul@gmail.com,m:sashal@kernel.org,m:jianbol@nvidia.com,m:cratiu@nvidia.com,m:simonlie@amazon.de,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amazon.de:dkim,amazon.de:email,amazon.de:mid,amazon.de:from_mime,secunet.com:email,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[simonlie@amazon.de,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262911-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[amazon.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simonlie@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4033678E78

From: Jianbo Liu <jianbol@nvidia.com>

[ Upstream commit b05d42eefac737ce3cd80114d3579111023941b8 ]

The dev_hold() on skb->dev during packet reception was originally
added to prevent the device from being released prematurely during
asynchronous decryption operations.

As current hardware can offload decryption, this asynchronous path is
not always utilized. This often results in a pattern of dev_hold()
immediately followed by dev_put() for each packet, creating
unnecessary reference counting overhead detrimental to performance.

This patch optimizes this by skipping the dev_hold() and subsequent
dev_put() when asynchronous decryption is not being performed.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Stable-dep-of: 1c428b038400 ("xfrm: hold dev ref until after transport_finish NF_HOOK")
Signed-off-by: Simon Liebold <simonlie@amazon.de>
---
 net/xfrm/xfrm_input.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 8edcb32735e59..90a79558dca25 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -492,6 +492,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		/* An encap_type of -1 indicates async resumption. */
 		if (encap_type == -1) {
 			async = 1;
+			dev_put(skb->dev);
 			seq = XFRM_SKB_CB(skb)->seq.input.low;
 			goto resume;
 		}
@@ -638,18 +639,18 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		XFRM_SKB_CB(skb)->seq.input.low = seq;
 		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;
 
-		dev_hold(skb->dev);
-
-		if (crypto_done)
+		if (crypto_done) {
 			nexthdr = x->type_offload->input_tail(x, skb);
-		else
+		} else {
+			dev_hold(skb->dev);
+
 			nexthdr = x->type->input(x, skb);
+			if (nexthdr == -EINPROGRESS)
+				return 0;
 
-		if (nexthdr == -EINPROGRESS)
-			return 0;
+			dev_put(skb->dev);
+		}
 resume:
-		dev_put(skb->dev);
-
 		spin_lock(&x->lock);
 		if (nexthdr < 0) {
 			if (nexthdr == -EBADMSG) {
-- 
2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


