Return-Path: <stable+bounces-192704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E73C3F590
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 11:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 359F84EA544
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 10:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF48E302142;
	Fri,  7 Nov 2025 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="VnU5ZO1p"
X-Original-To: stable@vger.kernel.org
Received: from out30-84.freemail.mail.aliyun.com (out30-84.freemail.mail.aliyun.com [115.124.30.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BD02DC33D
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510281; cv=none; b=I2hqjGQaurmOygo7YfQbJZ49hCjq8eFRcZXp3FRTdli93oGngEi1f7qQ8SqjLApHTYdH5nJr5+rIMkVzCvG5fNT5JfIXgbmUver/u1HjrYUGAGqBHVBAETPiQ6d4gsJ2vcEYLdmfyASihkZ94UyCdkEqpUkSXiWt234s8vkZub8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510281; c=relaxed/simple;
	bh=yT9nuihvJknAzZYJaTFCSDupEvsjRgON1aE/eRr2QHg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t/zKl+68yhnt7WwRIgUXkmg9nPugINaG74NXTygU0kUSbmFc0d+bGon9ZKJa0PGO0HS1fNhzolJaoQq6PQ99uViQqMwde94qthm+eb6+nuqu2YICfUgFjIoyE7Yj1ZqYf14x8ABokxJGqGa3as9B0Txt4LJbarpTPcj4ofQcceg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=VnU5ZO1p; arc=none smtp.client-ip=115.124.30.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1762510277; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=cwwidkgGvAouO41YOuGUVCjBpbHey39Jel4rP+gZbb0=;
	b=VnU5ZO1pdyxlsA2UhBL0wcyQHkeo8Z7tUcM6iwwZNDngSebIpfOFBf4UV9gHX/MEAwpI1bVmLROcskHQaXfl1XaSBWpEBERgPPZqYtKcD5mN5sRTgpwc3ghW0GYHEZd3cNtaYD/7tiisHMYO6daYHVsU9NMjVntiNKSWx4V395E=
Received: from pek-blan-cn-l1.corp.ad.wrs.com(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0WrsfSqc_1762510261 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Nov 2025 18:11:16 +0800
From: ruohanlan@aliyun.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 6.6.y] espintcp: fix skb leaks
Date: Fri,  7 Nov 2025 18:11:00 +0800
Message-Id: <20251107101100.1336-1-ruohanlan@aliyun.com>
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
index 49fd664f50fc..2caf6a2a819b 100644
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
index 7e4c8628cf98..2caaab61b996 100644
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
index d3b3f9e720b3..427072285b8c 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -169,8 +169,10 @@ int espintcp_queue_out(struct sock *sk, struct sk_buff *skb)
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


