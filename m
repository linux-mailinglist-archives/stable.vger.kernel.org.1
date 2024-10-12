Return-Path: <stable+bounces-83584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C0F99B458
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67678B215C8
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764B2204936;
	Sat, 12 Oct 2024 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ii9EdKjZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D78D204929;
	Sat, 12 Oct 2024 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732598; cv=none; b=NcGduQT6r46XrlZgQP91Y69c8Om328WP0VxnR+D74G74XaqcieejOeqyElJf+BtmRokF/e3xP2Dsa/tJvCN8n3wZuo1y3b0iRHlCFgkcxv/B2pmyR0S/vpOLCSdF0rzmAqYbtXs/Ju7vJf1W+9frkLABZUM2uUrVxdcfoiHlSn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732598; c=relaxed/simple;
	bh=rOWPAKO67xoaTevQ9uPSPkXjZCQIdgr3JwOF1JCIfUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkikUkzaEb5ofXY7gdqk98QU4hBlzEydLdv69xksE7c82eXVgiCUNHNW/04ZMVZjL7xCNdBQXd6dOaHzrXlLIAfYVqDUi5UXhaMGs1Hr+vWoievmp2y2Ko3Mp3DqWIOyPtGr9eNROvvrsdWgphH2ZUXbqAvNQeV9W6BBI8KzIIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ii9EdKjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1080DC4CECF;
	Sat, 12 Oct 2024 11:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732597;
	bh=rOWPAKO67xoaTevQ9uPSPkXjZCQIdgr3JwOF1JCIfUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ii9EdKjZiuhW6WcEpQQtRGzCrnQp/yPH+TPaL39tAT50u8YuS0zkLliI+y82UuMXN
	 bUmPTPAEFx3/YyO8X3wyfVu5Mnv2H1v6K3gopbvoaIUlQyBeyQZVPPAe29elMrCe4T
	 CTQaCLOhDjf3kKFuWSEV0X1CqJ1Rrx3GFap8yWzrvNrkdU+bD8M3M1ouoij03Hh7Ay
	 pWzDiveDOZDnYBTOIpsv2dJrd+d+CLVcXgQlaFbHiHX0O2CVM//zgKAwfDmMOF6Xzh
	 GoZVGud6Qelaxd7kQYkWbgzZ1b1akuLaQImeUt0VTxw5RvdpxpZo0vj+7OsHQ411r5
	 FmPEa7brnUVFw==
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
	horms@kernel.org,
	jacob.e.keller@intel.com,
	sd@queasysnail.net,
	shannon.nelson@amd.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/7] net: ethernet: use ip_hdrlen() instead of bit shift
Date: Sat, 12 Oct 2024 07:29:38 -0400
Message-ID: <20241012112948.1764454-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112948.1764454-1-sashal@kernel.org>
References: <20241012112948.1764454-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
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
index 25aa400e2e3c2..773ec50d515bc 100644
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


