Return-Path: <stable+bounces-5559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC66C80D560
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 317A3B20E31
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ABD5101B;
	Mon, 11 Dec 2023 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mTHG/Bzv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61F14F212;
	Mon, 11 Dec 2023 18:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CACDC433C7;
	Mon, 11 Dec 2023 18:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319044;
	bh=4YhG+oOOoS5URxtcMOQn5Q9srTGpyFxfKd08z9b63WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mTHG/BzvkprS44lAPunk/DjnR31MybzQDfT825/uDBiEiaIpdoS4MAjTUR2HtcThn
	 CiR/S02DUy16dNU4mpo4O3xZ1DFGnJ30ryFfRM96S5fBuDZapqtUZoWJPC/B3IZHVw
	 jI4dN/cM1KYYeeP0mTft+uW3+xSv8J/X0dc4WNpg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shigeru Yoshida <syoshida@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Suman Ghosh <sumang@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 18/55] ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()
Date: Mon, 11 Dec 2023 19:21:28 +0100
Message-ID: <20231211182012.904867943@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182012.263036284@linuxfoundation.org>
References: <20231211182012.263036284@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shigeru Yoshida <syoshida@redhat.com>

[ Upstream commit 80d875cfc9d3711a029f234ef7d680db79e8fa4b ]

In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() returns
true. For example, applications can use PF_PACKET to create a malformed
packet with no IP header. This type of packet causes a problem such as
uninit-value access.

This patch ensures that skb_pull() can pull the required size by checking
the skb with pskb_network_may_pull() before skb_pull().

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Suman Ghosh <sumang@marvell.com>
Link: https://lore.kernel.org/r/20231202161441.221135-1-syoshida@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_gre.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index e16373640f4c2..38c8db78cda19 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -683,15 +683,18 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 	}
 
 	if (dev->header_ops) {
+		int pull_len = tunnel->hlen + sizeof(struct iphdr);
+
 		if (skb_cow_head(skb, 0))
 			goto free_skb;
 
 		tnl_params = (const struct iphdr *)skb->data;
 
-		/* Pull skb since ip_tunnel_xmit() needs skb->data pointing
-		 * to gre header.
-		 */
-		skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
+		if (!pskb_network_may_pull(skb, pull_len))
+			goto free_skb;
+
+		/* ip_tunnel_xmit() needs skb->data pointing to gre header. */
+		skb_pull(skb, pull_len);
 		skb_reset_mac_header(skb);
 
 		if (skb->ip_summed == CHECKSUM_PARTIAL &&
-- 
2.42.0




