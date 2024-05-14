Return-Path: <stable+bounces-44169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D427F8C5190
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6032EB21B8D
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE52813A269;
	Tue, 14 May 2024 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xwe1zg40"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E39512BEA5;
	Tue, 14 May 2024 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684687; cv=none; b=MasI3E/aVNMOrIwzMrt/J8Op9bY8lnyN7iBkTBA0iAze6k0AysDncUYIlQVgfNz4VvYN2rua62ljyEmpbDA5hye1tJWW7sgJqKqRg+sLyJpeL9tFrbPO0GBM4TvHUgyRI2b8golfvXzsvc0tMd300ZNADw9b9AV5gH2xjZC/IHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684687; c=relaxed/simple;
	bh=f4NfT/S2k+R7NVstgKHntmdLSZdWsW9nq31DIz77TdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAX/8cyrvimUx106sWOCks1QYrW9rnq4BvzTImUINXguNbSzMm6uw815VjW4f/9GUXPfPw5qTbjq/0eiDQ9VFxkXoMPlh/TSkBcffx4wh7/5fds0H9eogeqycjQdXq51bBJ60tXpWCenHYjZUS+jG77nFd/gfbhlLk54WyDNM34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xwe1zg40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F30C2BD10;
	Tue, 14 May 2024 11:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715684687;
	bh=f4NfT/S2k+R7NVstgKHntmdLSZdWsW9nq31DIz77TdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xwe1zg40hH6yKtOzB0Kvp3HhNjbrU29Ts6Lss3MG02tSOjZaJvhqlCjIDSKkMrz9r
	 iVqOS8QRUAV8c9qQl4fbw/5mEdLjud8EnUYeleu9JQ/CuYFOPRQXm5k73oQThPUt94
	 Sj8UmfGQyR8IIPZAJTjc/uJeDuwzcZVpxFey1xy0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Fietkau <nbd@nbd.name>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 076/301] net: bridge: fix multicast-to-unicast with fraglist GSO
Date: Tue, 14 May 2024 12:15:47 +0200
Message-ID: <20240514101035.119114787@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 59c878cbcdd80ed39315573b3511d0acfd3501b5 ]

Calling skb_copy on a SKB_GSO_FRAGLIST skb is not valid, since it returns
an invalid linearized skb. This code only needs to change the ethernet
header, so pskb_copy is the right function to call here.

Fixes: 6db6f0eae605 ("bridge: multicast to unicast")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_forward.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 7431f89e897b9..d7c35f55bd69f 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -266,7 +266,7 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
 	if (skb->dev == p->dev && ether_addr_equal(src, addr))
 		return;
 
-	skb = skb_copy(skb, GFP_ATOMIC);
+	skb = pskb_copy(skb, GFP_ATOMIC);
 	if (!skb) {
 		DEV_STATS_INC(dev, tx_dropped);
 		return;
-- 
2.43.0




