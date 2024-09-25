Return-Path: <stable+bounces-77141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A020A9858F0
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C3DFB242D1
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4976B192D83;
	Wed, 25 Sep 2024 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAUbRg6W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0287419259B;
	Wed, 25 Sep 2024 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264294; cv=none; b=NdtbXYGcAABloePCfcyHIRs6fIW1XbnqdhGL2mjvNdpGK9QX1y1DRFG4qky815jq+Q+89Z4cbtx3mGMQbjeciYcCj4ZOVRP+PDpfWUvssE1AtK6sbFuWCcCuRb9OQXit2N4dujhxR7YlHeP//prl/NiqCXw0qIncC3oFFbUfyFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264294; c=relaxed/simple;
	bh=99xJ4NyRMEs2/5u6Lk55kVSZFinGZvr9bsh/6t6RxRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZJbq6+W1pty31iRPPFcD/CeitlATUFO5vwzEHAoLAQgrLU3sO5pyOT1By3PSfthVtJ5VRbZwWNb1LNz0zJ5rfa7h1HJfAZdvv/dckovgI/66eOljbvfFGUsXRgCUu9BJGY3icPlDiqyA58nagNrBlIckQ+/mq+SFpOiNebkfQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAUbRg6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E09FC4CEC3;
	Wed, 25 Sep 2024 11:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264293;
	bh=99xJ4NyRMEs2/5u6Lk55kVSZFinGZvr9bsh/6t6RxRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jAUbRg6WnvPgKSXN1LEIv8tiZ/LKxrKhoOH5/9EW2vn4pNBw0YVo8SCwYzX20TJVw
	 sXcbMt2yReiC2vbqeXjryi+V9+iMOO4vl5jOEqkHn4tMZkwaL6VWxKkLu4dPwZgy71
	 JSOPQA5cgFhLfeE36/fMr9jyWTHg2AogNNnM6dB9+jJtMP9k99fPFQf9t8YvbkRIz/
	 UQAkADDimNaamUqjIzKsNQM+Gr921e8lH38DoOhe1fcyZQMDpqFx/Ynd0ACACh703O
	 rJ+XsG/8Qe2Vohr983cvcUgtYOO0hTnq3hU1Vvhdvt9OL2/qSxdD7097lnhBHJ2YJN
	 cZyUIIkoIF3SA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	pabeni@redhat.com,
	almasrymina@google.com,
	asml.silence@gmail.com,
	lorenzo@kernel.org,
	bigeasy@linutronix.de,
	dhowells@redhat.com,
	liangchen.linux@gmail.com,
	aleksander.lobakin@intel.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 043/244] net: skbuff: sprinkle more __GFP_NOWARN on ingress allocs
Date: Wed, 25 Sep 2024 07:24:24 -0400
Message-ID: <20240925113641.1297102-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit c89cca307b20917da739567a255a68a0798ee129 ]

build_skb() and frag allocations done with GFP_ATOMIC will
fail in real life, when system is under memory pressure,
and there's nothing we can do about that. So no point
printing warnings.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skbuff.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 83f8cd8aa2d16..de2a044cc6656 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -314,8 +314,8 @@ void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 	fragsz = SKB_DATA_ALIGN(fragsz);
 
 	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
-	data = __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC,
-				       align_mask);
+	data = __page_frag_alloc_align(&nc->page, fragsz,
+				       GFP_ATOMIC | __GFP_NOWARN, align_mask);
 	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 	return data;
 
@@ -330,7 +330,8 @@ void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 		struct page_frag_cache *nc = this_cpu_ptr(&netdev_alloc_cache);
 
 		fragsz = SKB_DATA_ALIGN(fragsz);
-		data = __page_frag_alloc_align(nc, fragsz, GFP_ATOMIC,
+		data = __page_frag_alloc_align(nc, fragsz,
+					       GFP_ATOMIC | __GFP_NOWARN,
 					       align_mask);
 	} else {
 		local_bh_disable();
@@ -349,7 +350,7 @@ static struct sk_buff *napi_skb_cache_get(void)
 	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
 	if (unlikely(!nc->skb_count)) {
 		nc->skb_count = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
-						      GFP_ATOMIC,
+						      GFP_ATOMIC | __GFP_NOWARN,
 						      NAPI_SKB_CACHE_BULK,
 						      nc->skb_cache);
 		if (unlikely(!nc->skb_count)) {
@@ -418,7 +419,8 @@ struct sk_buff *slab_build_skb(void *data)
 	struct sk_buff *skb;
 	unsigned int size;
 
-	skb = kmem_cache_alloc(net_hotdata.skbuff_cache, GFP_ATOMIC);
+	skb = kmem_cache_alloc(net_hotdata.skbuff_cache,
+			       GFP_ATOMIC | __GFP_NOWARN);
 	if (unlikely(!skb))
 		return NULL;
 
@@ -469,7 +471,8 @@ struct sk_buff *__build_skb(void *data, unsigned int frag_size)
 {
 	struct sk_buff *skb;
 
-	skb = kmem_cache_alloc(net_hotdata.skbuff_cache, GFP_ATOMIC);
+	skb = kmem_cache_alloc(net_hotdata.skbuff_cache,
+			       GFP_ATOMIC | __GFP_NOWARN);
 	if (unlikely(!skb))
 		return NULL;
 
-- 
2.43.0


