Return-Path: <stable+bounces-162631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A829B05EC1
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00114502DB2
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929032E719B;
	Tue, 15 Jul 2025 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cX7i9uhQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520712E62B4;
	Tue, 15 Jul 2025 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587063; cv=none; b=JID7q5oaFxX5CxCzhIvOuKl57JTBcSirXCHI5eDkAzJs3rrLDjrCZTqnru6hAEKRWRr8m3soGEW5CvbX6LzkqSvP5t0XFHA2OnBFKQ5GF+YI+90goaKaMyV5YuoyIld4ebMAjm4UOYxbzbbCuq72nOOBtMfD1i1xKFlPbf/JDUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587063; c=relaxed/simple;
	bh=akD/2XaOd43ymWU7XLHzC7xilnKb64i13YCXe9YVr5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OidWQqlIcihjfMcA8XrcmXZpzGys4wn4kpLH2rMB12oBj9p8x5BnBu+z84KYzN1sWEiLEwH4iv9CmNuBdNswI8vjM5UuMyWerxkzd+9VlyXSeDAW+0hBuBqbQYcvv3am/591Xq26Xw7RjS9aST3fwO+LiIrY6YrYmhAkNquqIV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cX7i9uhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF7AC4CEE3;
	Tue, 15 Jul 2025 13:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587063;
	bh=akD/2XaOd43ymWU7XLHzC7xilnKb64i13YCXe9YVr5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cX7i9uhQAIAQ+o4AL3e+20B3SSaF0rb9ljnsVb6L+kDtFTyAVvlKAx+0vEg/qljFw
	 AD0tMQdXUwOAk+H3XczD5wi5BZ68e6ZA5yRcWzbyw03MCDcjfwq1rVjZIiYBFxeUMS
	 LQmiX1siEwFyuTJr0apwA57+CZjMFySEn6wly1/g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+bf6ed459397e307c3ad2@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 151/192] netfilter: flowtable: account for Ethernet header in nf_flow_pppoe_proto()
Date: Tue, 15 Jul 2025 15:14:06 +0200
Message-ID: <20250715130820.970870126@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
References: <20250715130814.854109770@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 18cdb3d982da8976b28d57691eb256ec5688fad2 ]

syzbot found a potential access to uninit-value in nf_flow_pppoe_proto()

Blamed commit forgot the Ethernet header.

BUG: KMSAN: uninit-value in nf_flow_offload_inet_hook+0x7e4/0x940 net/netfilter/nf_flow_table_inet.c:27
  nf_flow_offload_inet_hook+0x7e4/0x940 net/netfilter/nf_flow_table_inet.c:27
  nf_hook_entry_hookfn include/linux/netfilter.h:157 [inline]
  nf_hook_slow+0xe1/0x3d0 net/netfilter/core.c:623
  nf_hook_ingress include/linux/netfilter_netdev.h:34 [inline]
  nf_ingress net/core/dev.c:5742 [inline]
  __netif_receive_skb_core+0x4aff/0x70c0 net/core/dev.c:5837
  __netif_receive_skb_one_core net/core/dev.c:5975 [inline]
  __netif_receive_skb+0xcc/0xac0 net/core/dev.c:6090
  netif_receive_skb_internal net/core/dev.c:6176 [inline]
  netif_receive_skb+0x57/0x630 net/core/dev.c:6235
  tun_rx_batched+0x1df/0x980 drivers/net/tun.c:1485
  tun_get_user+0x4ee0/0x6b40 drivers/net/tun.c:1938
  tun_chr_write_iter+0x3e9/0x5c0 drivers/net/tun.c:1984
  new_sync_write fs/read_write.c:593 [inline]
  vfs_write+0xb4b/0x1580 fs/read_write.c:686
  ksys_write fs/read_write.c:738 [inline]
  __do_sys_write fs/read_write.c:749 [inline]

Reported-by: syzbot+bf6ed459397e307c3ad2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/686bc073.a00a0220.c7b3.0086.GAE@google.com/T/#u
Fixes: 87b3593bed18 ("netfilter: flowtable: validate pppoe header")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>
Link: https://patch.msgid.link/20250707124517.614489-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_flow_table.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index d711642e78b57..c003cd194fa2a 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -370,7 +370,7 @@ static inline __be16 __nf_flow_pppoe_proto(const struct sk_buff *skb)
 
 static inline bool nf_flow_pppoe_proto(struct sk_buff *skb, __be16 *inner_proto)
 {
-	if (!pskb_may_pull(skb, PPPOE_SES_HLEN))
+	if (!pskb_may_pull(skb, ETH_HLEN + PPPOE_SES_HLEN))
 		return false;
 
 	*inner_proto = __nf_flow_pppoe_proto(skb);
-- 
2.39.5




