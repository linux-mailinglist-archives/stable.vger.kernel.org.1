Return-Path: <stable+bounces-195416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EDDC76225
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 331E4359DAC
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4535304BBD;
	Thu, 20 Nov 2025 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr6CoPO0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F0285073
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763668620; cv=none; b=BA49NleT80yuwoyoIFqc/KCCy0zBhGf3SdvbynNt6HTLSZZGJfGq4s1d087fJddbBe/QxZke37xYFzv/bbZOj3J/heeS4aZ8u9TAEj++N7OcQoLKp6eJ6X1LJsa4ye4r+RjfuDYwhvLOLdsSVCNNpk4LJJM+OCH0aPQkG7bsMm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763668620; c=relaxed/simple;
	bh=UiLIWPKiEV0ugqJTY9cXGKKSvjfi/OBL4iA2qvY2GAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjJbLz4+7L3zHNE7Aq314pm1mUZOYJBCBQdf5TIfHYw+qagBZSXX3RS9P0H7vuQo0ta5MHhYWDiFPU1WakRkQjeDvCOhzNg8/qkoIkKEv/SSdv5FhsZjDpntFFwUOEhoZBzHcy6u88mdQd0bOVwRD9/Xsf8Ife0qmp0czbndyps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr6CoPO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9403C19422;
	Thu, 20 Nov 2025 19:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763668620;
	bh=UiLIWPKiEV0ugqJTY9cXGKKSvjfi/OBL4iA2qvY2GAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lr6CoPO0bSVXuApjtHksrSpy7feXG3PdJJILLwDzkRIJVY827rM/xpqQ4JRuJxfAl
	 5cD4boZgY+a8ch9VkO+7IeSlGM0QcCDsH4JHppZ72p6A0qf8flbuNB8aGiPxXNunlM
	 Stm7Cyz93vJnXvJYWnuBtqQDJArnZQyRphGsT6QHKBSz1gTMj0lQg1vJSLgmEYOQvC
	 GsFl+qzExAZcgBt+YVxSTbz1lLJsRHVPPTc0DYC5M1H6ZRK1nJaPEdv8tx0xSP3SW9
	 dSJ8UT+nmT3IlUvHQRlrUKd8jJ0PcYiEwJopjQsOfEmVOvWVsfKj6UW0mBIvWe3zOZ
	 j1w6oeBBSlPTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] net: netpoll: flush skb pool during cleanup
Date: Thu, 20 Nov 2025 14:56:55 -0500
Message-ID: <20251120195656.2297634-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120195656.2297634-1-sashal@kernel.org>
References: <2025112006-author-harmony-d5f7@gregkh>
 <20251120195656.2297634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 6c59f16f1770481a6ee684720ec55b1e38b3a4b2 ]

The netpoll subsystem maintains a pool of 32 pre-allocated SKBs per
instance, but these SKBs are not freed when the netpoll user is brought
down. This leads to memory waste as these buffers remain allocated but
unused.

Add skb_pool_flush() to properly clean up these SKBs when netconsole is
terminated, improving memory efficiency.

Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20241114-skb_buffers_v2-v3-2-9be9f52a8b69@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 49c8d2c1f94c ("net: netpoll: fix incorrect refcount handling causing incorrect cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/netpoll.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index ee7af71b7b102..f053141b88968 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -538,6 +538,14 @@ static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
 	return -1;
 }
 
+static void skb_pool_flush(struct netpoll *np)
+{
+	struct sk_buff_head *skb_pool;
+
+	skb_pool = &np->skb_pool;
+	skb_queue_purge_reason(skb_pool, SKB_CONSUMED);
+}
+
 int netpoll_parse_options(struct netpoll *np, char *opt)
 {
 	char *cur=opt, *delim;
@@ -786,7 +794,7 @@ int netpoll_setup(struct netpoll *np)
 
 	err = __netpoll_setup(np, ndev);
 	if (err)
-		goto put;
+		goto flush;
 	rtnl_unlock();
 
 	/* Make sure all NAPI polls which started before dev->npinfo
@@ -797,6 +805,8 @@ int netpoll_setup(struct netpoll *np)
 
 	return 0;
 
+flush:
+	skb_pool_flush(np);
 put:
 	DEBUG_NET_WARN_ON_ONCE(np->dev);
 	if (ip_overwritten)
@@ -844,6 +854,8 @@ void __netpoll_cleanup(struct netpoll *np)
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
 	} else
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+
+	skb_pool_flush(np);
 }
 EXPORT_SYMBOL_GPL(__netpoll_cleanup);
 
-- 
2.51.0


