Return-Path: <stable+bounces-70027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD6695CF64
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5824B1F2AB48
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0683F188924;
	Fri, 23 Aug 2024 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQDKHsOR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41D21A257D;
	Fri, 23 Aug 2024 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421917; cv=none; b=FaIgFgBjk+Hn+sblhDWVtJ8xh5KWo82b0Kvzx+S9a55Uz/lhG/9C13+0/cFfXexWPSJFLRuXg/QPjRkNl3JEgQ3sn6GJaXVFMFC5EaDRp5ogBAJdAW7qFiystg2e97LdSy3u0vctfcpftkVV9bu8Kkm80leKcVjEXfefpcS8kbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421917; c=relaxed/simple;
	bh=R43+CoaWsWEVWoLHesWvTZ7ddgaI1Mm3eKkjbHixtnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=st+HKBfwL1V6PKr4mv73aeYjNvYLgptSP2+EQzT++3bHTniBEK6Rpp/vYYo2oVKupCE63eGDJqONYX5KjZvV7b3Criwkp2brrYMgP5q8LSU9muSl2xDAMG3ZLWHjT0S5faOcmf3YQo0FJsdIlfMX5agxdsZin8+hsuUNsgdc/m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQDKHsOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EA6C4AF0B;
	Fri, 23 Aug 2024 14:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421917;
	bh=R43+CoaWsWEVWoLHesWvTZ7ddgaI1Mm3eKkjbHixtnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BQDKHsORo37u1I8OELY3WYZ+ooMZGIhFJdJUqPemymo1tDaYBzxfvQo5cex8BB5Db
	 0a7XXKAbrba0H/hvYi4l/8bcaKmjqEGgvfRDwEBb/sydKRELBOqX6FvCL0KmjHbeGz
	 5famcwg1yZg5ng0k1RpEmOUtt+83y039LE9NeMYa5cW6vmFe4LM84kDbYVuRCAaJYp
	 4efzxzJxbhbqQ9zONzqFv2oPLKfejCtjh5vceNpOnZhZtdxx3s3BpLermUpk2xuArE
	 JDB7u+EmzGPC6L/inIzUN0x4YBNMiZJ1kjDHnbVpDAL0qeLA1Iy7O+LmF277bq3ouJ
	 YH6VdnTTPwoeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Moon Yeounsu <yyyynoom@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	cooldavid@cooldavid.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shannon.nelson@amd.com,
	sd@queasysnail.net,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/9] net: ethernet: use ip_hdrlen() instead of bit shift
Date: Fri, 23 Aug 2024 10:04:50 -0400
Message-ID: <20240823140507.1975524-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140507.1975524-1-sashal@kernel.org>
References: <20240823140507.1975524-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.165
Content-Transfer-Encoding: 8bit

From: Moon Yeounsu <yyyynoom@gmail.com>

[ Upstream commit 9a039eeb71a42c8b13408a1976e300f3898e1be0 ]

`ip_hdr(skb)->ihl << 2` is the same as `ip_hdrlen(skb)`
Therefore, we should use a well-defined function not a bit shift
to find the header length.

It also compresses two lines to a single line.

Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/jme.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index 1bdc4f23e1e57..06890993662ad 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -945,15 +945,13 @@ jme_udpsum(struct sk_buff *skb)
 	if (skb->protocol != htons(ETH_P_IP))
 		return csum;
 	skb_set_network_header(skb, ETH_HLEN);
-	if ((ip_hdr(skb)->protocol != IPPROTO_UDP) ||
-	    (skb->len < (ETH_HLEN +
-			(ip_hdr(skb)->ihl << 2) +
-			sizeof(struct udphdr)))) {
+
+	if (ip_hdr(skb)->protocol != IPPROTO_UDP ||
+	    skb->len < (ETH_HLEN + ip_hdrlen(skb) + sizeof(struct udphdr))) {
 		skb_reset_network_header(skb);
 		return csum;
 	}
-	skb_set_transport_header(skb,
-			ETH_HLEN + (ip_hdr(skb)->ihl << 2));
+	skb_set_transport_header(skb, ETH_HLEN + ip_hdrlen(skb));
 	csum = udp_hdr(skb)->check;
 	skb_reset_transport_header(skb);
 	skb_reset_network_header(skb);
-- 
2.43.0


