Return-Path: <stable+bounces-30304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ECB88900C
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 07:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576911F2FA7B
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 06:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40702853F1;
	Sun, 24 Mar 2024 23:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lp6Kxfl6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900AC1428E3;
	Sun, 24 Mar 2024 23:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321896; cv=none; b=LwlpwKG6crt90GjxnKQpwmdJ9asBK1XFFGgIJ4AUBiKq3g9Z6CZyRPxWZt8jCY2yiX7zV6JQPdRua++MEg0L1yUJUIcVgwYsInJgiW9CAZZtAiLLUrBnBcEbjyYgabODSG1tUGw+Nrp39PZR7g+1LGs5RkfpeBY/QmnHrKS1j/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321896; c=relaxed/simple;
	bh=MsB8TBSpDG7QfiXn9KQIA9KjjIcJdCytaPbpxU8XlMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5F3hkqMKlIWoD6Rpb0EbJxra38cm7+MSogPhXIAHxtdBsR7nCXw96AhhiJ+C4Wm501INFiurmW/+lLegpyh97DLOyVLqu9oubWRYuMqdUSpR5SHqp5PX1zkcgCDiqAJppG6vepa5Cx3qrfkc4VCGBXJUhYvHmhPSNAx5uo+EHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lp6Kxfl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A1EC433F1;
	Sun, 24 Mar 2024 23:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321895;
	bh=MsB8TBSpDG7QfiXn9KQIA9KjjIcJdCytaPbpxU8XlMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lp6Kxfl6BrlFNOaXdLO2yE/1B8iFbR+IAfEZ8jS7e4RE8W7EGzoUE4nHc1rVYbUT2
	 EkPjsw/Ct5jSPWVsd6iR42op26Mc1odaTQgefQTNiMC5wWSI6WGfSC0jXfsr7sFDud
	 ZNX1VonEBB8HeniXjaugrug6WAp4f4lWIbnNbuc2w2lBQsPB299q1Q249ZzwhRNy6c
	 eqOhsyLJeIwMJJO4i28N82HIPPKcxPKEy3MWMjalIfGIOY0lvpbUYt8KCYEnLK9sgf
	 Kk3McuWyK9DWLy8LS++Gf5273ACiEL8I3Y/vyPKkpuIVILvZ2JWYknOqpWMx0LYEwN
	 Dfz5mFUaYrXXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 624/638] netfilter: nft_set_pipapo: release elements in clone only from destroy path
Date: Sun, 24 Mar 2024 19:01:01 -0400
Message-ID: <20240324230116.1348576-625-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit b0e256f3dd2ba6532f37c5c22e07cb07a36031ee ]

Clone already always provides a current view of the lookup table, use it
to destroy the set, otherwise it is possible to destroy elements twice.

This fix requires:

 212ed75dc5fb ("netfilter: nf_tables: integrate pipapo into commit protocol")

which came after:

 9827a0e6e23b ("netfilter: nft_set_pipapo: release elements in clone from abort path").

Fixes: 9827a0e6e23b ("netfilter: nft_set_pipapo: release elements in clone from abort path")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 8e9b200779666..a890aa0abad58 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -2238,8 +2238,6 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 	if (m) {
 		rcu_barrier();
 
-		nft_set_pipapo_match_destroy(ctx, set, m);
-
 		for_each_possible_cpu(cpu)
 			pipapo_free_scratch(m, cpu);
 		free_percpu(m->scratch);
@@ -2251,8 +2249,7 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 	if (priv->clone) {
 		m = priv->clone;
 
-		if (priv->dirty)
-			nft_set_pipapo_match_destroy(ctx, set, m);
+		nft_set_pipapo_match_destroy(ctx, set, m);
 
 		for_each_possible_cpu(cpu)
 			pipapo_free_scratch(priv->clone, cpu);
-- 
2.43.0


