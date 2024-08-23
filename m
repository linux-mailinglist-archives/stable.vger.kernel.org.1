Return-Path: <stable+bounces-70036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4D795CF7D
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942E61C221F4
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590C51A7AEE;
	Fri, 23 Aug 2024 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxNmCV8F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15312190675;
	Fri, 23 Aug 2024 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421951; cv=none; b=cP5JsPFnOoZAhj92/RtpHeuaHpJO/RZYcv7YqyYXonJlJQGARZFlN61ftg7ZblL5SG706Fuc5eBN85695pmFvmFi+M27X+5Lcr+3t+sDjj2OjFBqkegUB68h+E+jxDXSQ77pjnSASmP2YkdHdZBwIk7OVt+k8QSXuC0TRMPyOA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421951; c=relaxed/simple;
	bh=BBbpl+Jaz8owFH3li+2vNQMDyDDM8/Ufc4ojWTrHyJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGOYw9d8w1r95OjO+NgTnwj8Pg9+44Pew0PmoAzKGOFa/cFE/Y/1gwVs8HamRyLR2XJXQx3usea2/NABD6dYQ7u+Nz3hQWusbhLXhlpvKwC8bF9QXjyfWzFdl6qAzfXwoKU9ZBomB8Shn6WF0BcTsjDwkM7pwR++v1zfg0KaLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxNmCV8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9A9C32786;
	Fri, 23 Aug 2024 14:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421951;
	bh=BBbpl+Jaz8owFH3li+2vNQMDyDDM8/Ufc4ojWTrHyJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cxNmCV8Fm9gqeEydipI0l7Vqz66bhmGT2rqBPPh1D5FNVdd9bXZwUAf/MbCeoEJsS
	 zMOWsPcugm9Rc8yb083JuWrtI5g0V5gEbBRmmv6ep7W2+gwrXNWLCIGfuZFuoblhdu
	 iBXKmKPG89BzL2eK36JVHQb6xXZpg+9spCIH8aLN603vFXMVuJnRZYEYAZvu7Ag1CR
	 IOt4/HPGuQuGAxQDd0AgDOviSs8rCSSTI3Wp0KgYHsf4BDNgFYqDdKy1wHisnR2D84
	 vT37TTY5G1SjSVFVeDG7GsAVKe2U3mypcKq9awNGVGIrLFfqr/7Ml4taNWydDf+YQ2
	 u39JpO+Tz6nOQ==
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
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/9] net: ethernet: use ip_hdrlen() instead of bit shift
Date: Fri, 23 Aug 2024 10:05:23 -0400
Message-ID: <20240823140541.1975737-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140541.1975737-1-sashal@kernel.org>
References: <20240823140541.1975737-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.224
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
index e9efe074edc11..80858206c5147 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -947,15 +947,13 @@ jme_udpsum(struct sk_buff *skb)
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


