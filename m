Return-Path: <stable+bounces-192839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E43C4C43DD4
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 13:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A850C1881DC3
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 12:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A704B2E975A;
	Sun,  9 Nov 2025 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="pBDK//sH"
X-Original-To: stable@vger.kernel.org
Received: from out30-77.freemail.mail.aliyun.com (out30-77.freemail.mail.aliyun.com [115.124.30.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7B51FF1B5
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762691979; cv=none; b=LRtI9SVg2ExWHVcNhaNnplMji69iPg9GNCaKXSoGwsEDiIfYzXiINaootyvk7WnSl17LOwXe3C1bbEv1XMcW9HqXdXbg0axGyo0aUH8MIvjD3grufJzvO6+vpUwqJfCHDS7SOE7xSE2fSCT/PHCgquFhKPNmcNC5MeJ514Gav1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762691979; c=relaxed/simple;
	bh=tgaJipRxzgSlf8d/QzOrKvDBYhmAcCFCzqYrEdF6GyE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HetumnmtxaKXSYa04aHesPhdEvXBKuvocJuUuw7uaEJzplWXh7QyZ+oy/QLepLBOkvJgrZC7mBrWsrWveT3J5dMuIZ5QyO9q2PmURKMMzBmpxk+1TemMW59CF9e9ZFv57PH9p/Wnfja2BW9RTU4erAkedMbD2F9QddOGZrnj0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=pBDK//sH; arc=none smtp.client-ip=115.124.30.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1762691973; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ULl9qOeeg7YVsoGH+dDc81qoeYuBgl6Nonyl6XZ+6Qk=;
	b=pBDK//sHffaPuUXQWpW8JF89hRA4/etRcmBU2x7CwBZNSg3a96E3qK2UKnfRugBPBZ5RfB7M3BEc3uUTlu5TmcvQxLifrNCWBdHy/HSVk4rWRfXLNlMxnMxpUo6zVHADtdKRwFH4oeb0ANTNxIab/UReliPT4sY0Ez3SDDzD/AY=
Received: from pek-blan-cn-l1.corp.ad.wrs.com(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0WryB6fk_1762691957 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 09 Nov 2025 20:39:32 +0800
From: ruohanlan@aliyun.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 6.1.y] espintcp: fix skb leaks
Date: Sun,  9 Nov 2025 20:39:15 +0800
Message-Id: <20251109123915.789-1-ruohanlan@aliyun.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 63c1f19a3be3169e51a5812d22a6d0c879414076 ]

A few error paths are missing a kfree_skb.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
[ Minor context change fixed. ]
Signed-off-by: Ruohan Lan <ruohanlan@aliyun.com>
---
 net/ipv4/esp4.c     | 4 +++-
 net/ipv6/esp6.c     | 4 +++-
 net/xfrm/espintcp.c | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 8f5417ff355d..a40f78a6474c 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -152,8 +152,10 @@ static int esp_output_tcp_finish(struct xfrm_state *x, struct sk_buff *skb)
 
 	sk = esp_find_tcp_sk(x);
 	err = PTR_ERR_OR_ZERO(sk);
-	if (err)
+	if (err) {
+		kfree_skb(skb);
 		goto out;
+	}
 
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk))
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 085a83b807af..48963fc9057b 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -169,8 +169,10 @@ static int esp_output_tcp_finish(struct xfrm_state *x, struct sk_buff *skb)
 
 	sk = esp6_find_tcp_sk(x);
 	err = PTR_ERR_OR_ZERO(sk);
-	if (err)
+	if (err) {
+		kfree_skb(skb);
 		goto out;
+	}
 
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk))
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index d6fece1ed982..b26fbaead7a5 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -168,8 +168,10 @@ int espintcp_queue_out(struct sock *sk, struct sk_buff *skb)
 {
 	struct espintcp_ctx *ctx = espintcp_getctx(sk);
 
-	if (skb_queue_len(&ctx->out_queue) >= READ_ONCE(netdev_max_backlog))
+	if (skb_queue_len(&ctx->out_queue) >= READ_ONCE(netdev_max_backlog)) {
+		kfree_skb(skb);
 		return -ENOBUFS;
+	}
 
 	__skb_queue_tail(&ctx->out_queue, skb);
 
-- 
2.43.0


