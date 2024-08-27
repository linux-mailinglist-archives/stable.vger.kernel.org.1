Return-Path: <stable+bounces-71291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E84339612FC
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D790B2B288
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CBA1CDA37;
	Tue, 27 Aug 2024 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jzb5/j9B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24C01CDA12;
	Tue, 27 Aug 2024 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772728; cv=none; b=Bcxf2DGLrz8pDS4MNOpLA4S2UkcYM44xj42Dqb4inkl7wmTe5Q4BApvi94f//CpNmWrcvaz+XVZLyVlrog48cyrbTYoJp5BBZusHMsrV7yMPz33IL5PAynkj6ic9FOU6WZwMP+vYcRrnEs0j9tSHPiTpCffvJ79rTWTWspLlKA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772728; c=relaxed/simple;
	bh=kIE21Nfgll4A2jmqdoii6I8kKHzuHvhbBr00zALZkP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXwG7Y4Z0W52bX4LmcHcRuK9sI7DzggcgIieEvlMiK+pauJDLLoPrMf20q24bJX9Y561s28mR7V+DqyBXSKja03vckVYLTZPHo4Cn9N0QRclISbisBTjIS+g+hs61hXN3rFMPig7JgOhDSKwMiFq/GLuMDrM0bIJ5a6B7weUGO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jzb5/j9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C46C4DDFC;
	Tue, 27 Aug 2024 15:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772728;
	bh=kIE21Nfgll4A2jmqdoii6I8kKHzuHvhbBr00zALZkP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jzb5/j9BRveNsJ5hHAUM+/MZ9zEcsHf0AHf4k3DpiQjsWs3KzDeaw3FihsismxyeV
	 rH6qDD5ONAlbD5EmZ9CkKbeO1ksw97re8/Gj0aFJxsHM7WhR8vDx3hqfso1UcRI7gm
	 DxgYBwEslEwx07DBmzaKyPpIClxNc8OZO/y002Us=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 300/321] udp: allow header check for dodgy GSO_UDP_L4 packets.
Date: Tue, 27 Aug 2024 16:40:08 +0200
Message-ID: <20240827143849.676481831@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Melnychenko <andrew@daynix.com>

commit 1fd54773c26787b9aea80e2f62c7d0780ea444d0 upstream.

Allow UDP_L4 for robust packets.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/udp_offload.c |    3 ++-
 net/ipv6/udp_offload.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -387,7 +387,8 @@ static struct sk_buff *udp4_ufo_fragment
 	if (!pskb_may_pull(skb, sizeof(struct udphdr)))
 		goto out;
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
+	    !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
 		return __udp_gso_segment(skb, features, false);
 
 	mss = skb_shinfo(skb)->gso_size;
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -42,7 +42,8 @@ static struct sk_buff *udp6_ufo_fragment
 		if (!pskb_may_pull(skb, sizeof(struct udphdr)))
 			goto out;
 
-		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
+		    !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
 			return __udp_gso_segment(skb, features, true);
 
 		mss = skb_shinfo(skb)->gso_size;



