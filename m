Return-Path: <stable+bounces-55895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9635A919BD6
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 02:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E461F22F87
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 00:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53D92139BC;
	Thu, 27 Jun 2024 00:41:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14C317F3;
	Thu, 27 Jun 2024 00:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719448886; cv=none; b=OE0ouYq6ib/CehtpADgoHoDYF6W8QCrEuDndPu83M8D6YteQg1hYRuazH/UohgfB5CQrtsJfY2F4WgKji+TStQOQW1ecbRLhojJf00Y1Vvyf5+Y6+OZH0hKGbCNLyR8Im0qiCXx0Fp3R1HNEmrWHkZMs/R697lQ4BP5Ep/Phd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719448886; c=relaxed/simple;
	bh=0ugcYokPHB0D4OEM7Cw5s43v53SiC+dFhxfp6PuPYP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QFJ5G4Lt2KEoeimpzNSVuuE6nBY8/ruEUbnHhHJZ39mBAG4lwEhmN06JpQqqzGdT4wh4N3JVpM8ln70dpRK1+fWsN9SrFoGU9VZyp+p5G7b0LqF+uh5UzjBeIQE2vjm/31nxAZuH183ygs7Y2Ij4uNoubPgQhzOzxQwP2St5epY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	torvalds@linuxfoundation.org
Subject: [PATCH -stable,5.4.x] netfilter: nf_tables: validate family when identifying table via handle
Date: Thu, 27 Jun 2024 02:41:12 +0200
Message-Id: <20240627004113.150349-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240627004113.150349-1-pablo@netfilter.org>
References: <20240627004113.150349-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit f6e1532a2697b81da00bfb184e99d15e01e9d98c ]

Validate table family when looking up for it via NFTA_TABLE_HANDLE.

Fixes: 3ecbfd65f50e ("netfilter: nf_tables: allocate handle and delete objects via handle")
Reported-by: Xingyuan Mo <hdthky0@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8131d858f38d..44d4d97b45d1 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -553,7 +553,7 @@ static struct nft_table *nft_table_lookup(const struct net *net,
 
 static struct nft_table *nft_table_lookup_byhandle(const struct net *net,
 						   const struct nlattr *nla,
-						   u8 genmask)
+						   int family, u8 genmask)
 {
 	struct nftables_pernet *nft_net;
 	struct nft_table *table;
@@ -561,6 +561,7 @@ static struct nft_table *nft_table_lookup_byhandle(const struct net *net,
 	nft_net = net_generic(net, nf_tables_net_id);
 	list_for_each_entry(table, &nft_net->tables, list) {
 		if (be64_to_cpu(nla_get_be64(nla)) == table->handle &&
+		    table->family == family &&
 		    nft_active_genmask(table, genmask))
 			return table;
 	}
@@ -1243,7 +1244,7 @@ static int nf_tables_deltable(struct net *net, struct sock *nlsk,
 
 	if (nla[NFTA_TABLE_HANDLE]) {
 		attr = nla[NFTA_TABLE_HANDLE];
-		table = nft_table_lookup_byhandle(net, attr, genmask);
+		table = nft_table_lookup_byhandle(net, attr, family, genmask);
 	} else {
 		attr = nla[NFTA_TABLE_NAME];
 		table = nft_table_lookup(net, attr, family, genmask);
-- 
2.30.2


