Return-Path: <stable+bounces-76611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CFD97B49E
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 22:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9543A1C222CC
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 20:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AFC18E05B;
	Tue, 17 Sep 2024 20:25:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD128188A13;
	Tue, 17 Sep 2024 20:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726604711; cv=none; b=Xj4pQ9/Txylrbnw91BKFgkl9K3fhJhFcPh+v+DJMBN5JpRCsBE0hIbt0BgmXkyV4xyFJk/BbDR0TSXiDwLT2470QTw6k2j8NtyO0BWiwfa0xmSOVzTsP3gAZPl9GS6P+70mMGJaqkq8WrlcBe8Ikg0T/GvalLtCpXtC60eb9DL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726604711; c=relaxed/simple;
	bh=GQTKXw2Dt8tQ7qGbOc14G83unSK/xuy2z76gVBzEvHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bokYcF4RRonyTJwMSoByK5AndKTevzTKEK7Hi+uVidVioT1xIgIT9X6emMVcVeplZOIMQp3QnDASUsc5JSgNuRjogUAsZVrNMJZc3HTD5zfW2s+CG9Ci2NbP7+BVxc/SDWbIXOq+Q8VwrVaH2ruEcuS2OAorZ00TYefofevR/G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH -stable,6.1 2/2] netfilter: nf_tables: missing iterator type in lookup walk
Date: Tue, 17 Sep 2024 22:25:04 +0200
Message-Id: <20240917202504.176664-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240917202504.176664-1-pablo@netfilter.org>
References: <20240917202504.176664-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit efefd4f00c967d00ad7abe092554ffbb70c1a793 upstream.

Add missing decorator type to lookup expression and tighten WARN_ON_ONCE
check in pipapo to spot earlier that this is unset.

Fixes: 29b359cf6d95 ("netfilter: nft_set_pipapo: walk over current view on netlink dump")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_lookup.c     | 1 +
 net/netfilter/nft_set_pipapo.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index 33daee2e54c5..fc0ac535d0d8 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -211,6 +211,7 @@ static int nft_lookup_validate(const struct nft_ctx *ctx,
 		return 0;
 
 	iter.genmask	= nft_genmask_next(ctx->net);
+	iter.type	= NFT_ITER_UPDATE;
 	iter.skip	= 0;
 	iter.count	= 0;
 	iter.err	= 0;
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 8cce39411619..8336f2052f22 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -2046,7 +2046,8 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 	const struct nft_pipapo_field *f;
 	int i, r;
 
-	WARN_ON_ONCE(iter->type == NFT_ITER_UNSPEC);
+	WARN_ON_ONCE(iter->type != NFT_ITER_READ &&
+		     iter->type != NFT_ITER_UPDATE);
 
 	rcu_read_lock();
 	if (iter->type == NFT_ITER_READ)
-- 
2.30.2


