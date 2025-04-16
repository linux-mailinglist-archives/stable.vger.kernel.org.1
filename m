Return-Path: <stable+bounces-132873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8590CA90833
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 18:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48D118886AB
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E4121146F;
	Wed, 16 Apr 2025 16:01:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78741C1AB4
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819301; cv=none; b=gxkSl0i50gw6xxvD5xohREvxbDIdkdBn5mfmIILrcByJDgpV3E0NkxXWrJISuDpzcGYgGeEm6gMbpBWw38jUCRtm3EbzIEZnmVySSaGsqizG61aYJHfbK32snBGUcd5SkXoM/asE0oM+QfN8CPDSLylb/QL8V1jogXuREs8UO6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819301; c=relaxed/simple;
	bh=zkeuqcHTaXh8e07BhXhQC4nCiGMSr4a3k1xy1bL+/UA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h8jmZXrJzSEZHS6rbVjuB2v5FguVoPW3i5RcOMo4z2+xphfvNeBDYD/b2X63JPVwo5sppvnNbRWevShLbAqSDCzyWl1/IUpvguQ9PIcswL4JeMMvfSs1bnmJ23R8JXi2lUXsqcZDkbg4+CTVKtZEkrh5hys3rGIKbosYuGCqheg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u55Ca-0005My-6K; Wed, 16 Apr 2025 18:01:28 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u55CY-000bs2-38;
	Wed, 16 Apr 2025 18:01:26 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u55CY-00CEFz-2s;
	Wed, 16 Apr 2025 18:01:26 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net v1 1/1] net: selftests: initialize TCP header and skb payload with zero
Date: Wed, 16 Apr 2025 18:01:25 +0200
Message-Id: <20250416160125.2914724-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Zero-initialize TCP header via memset() to avoid garbage values that
may affect checksum or behavior during test transmission.

Also zero-fill allocated payload and padding regions using memset()
after skb_put(), ensuring deterministic content for all outgoing
test packets.

Fixes: 3e1e58d64c3d ("net: add generic selftest support")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: stable@vger.kernel.org
---
 net/core/selftests.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/core/selftests.c b/net/core/selftests.c
index e99ae983fca9..35f807ea9952 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -100,10 +100,10 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 	ehdr->h_proto = htons(ETH_P_IP);
 
 	if (attr->tcp) {
+		memset(thdr, 0, sizeof(*thdr));
 		thdr->source = htons(attr->sport);
 		thdr->dest = htons(attr->dport);
 		thdr->doff = sizeof(struct tcphdr) / 4;
-		thdr->check = 0;
 	} else {
 		uhdr->source = htons(attr->sport);
 		uhdr->dest = htons(attr->dport);
@@ -144,10 +144,18 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 	attr->id = net_test_next_id;
 	shdr->id = net_test_next_id++;
 
-	if (attr->size)
-		skb_put(skb, attr->size);
-	if (attr->max_size && attr->max_size > skb->len)
-		skb_put(skb, attr->max_size - skb->len);
+	if (attr->size) {
+		void *payload = skb_put(skb, attr->size);
+
+		memset(payload, 0, attr->size);
+	}
+
+	if (attr->max_size && attr->max_size > skb->len) {
+		size_t pad_len = attr->max_size - skb->len;
+		void *pad = skb_put(skb, pad_len);
+
+		memset(pad, 0, pad_len);
+	}
 
 	skb->csum = 0;
 	skb->ip_summed = CHECKSUM_PARTIAL;
-- 
2.39.5


