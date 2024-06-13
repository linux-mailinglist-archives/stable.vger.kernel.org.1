Return-Path: <stable+bounces-50366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6265890601F
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 03:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043B51F222AA
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 01:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54377F7D5;
	Thu, 13 Jun 2024 01:02:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4606458ABC;
	Thu, 13 Jun 2024 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718240556; cv=none; b=GHOaW+5k5ecm6y/hgcHKCMOyl67MGBaNe6qRY4/2y90gPuA6KUb1tyF96fgptyL0mTvI7gjGBywqMXk5nU4CRsgzFHcLc81xR3IyQsp+amtctiICyJhjEKou9/syhCxlxaUUEu14F6AyJk5zOmzyGvEAfkm3mQH5nTnDjL0M404=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718240556; c=relaxed/simple;
	bh=E4v4G7XVfDSrYvJ8921/Kodk1LzLIxk7laHPCaXu9aA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h2nf20CpEgmyNMyPJJlL5BGyhsFkGubtYeKwtgwnl84hqCvW9l9mNR0r5coMk5fncPxVeZX+ajzD6ap1dmAMFBBNq2PuSthqv/UnBH9RiTTopdoLA12sH+LPMI9wMqYUZz7r30mvNbh8UH7PbBStkDW1wyybHZaBwN06UhSu66M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH -stable,4.19.x 26/40] netfilter: nf_tables: bogus EBUSY when deleting flowtable after flush (for 4.19)
Date: Thu, 13 Jun 2024 03:01:55 +0200
Message-Id: <20240613010209.104423-27-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240613010209.104423-1-pablo@netfilter.org>
References: <20240613010209.104423-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

3f0465a9ef02 ("netfilter: nf_tables: dynamically allocate hooks per
net_device in flowtables") reworks flowtable support to allow for
dynamic allocation of hooks, which implicitly fixes the following
bogus EBUSY in transaction:

  delete flowtable
  add flowtable # same flowtable with same devices, it hits EBUSY

This patch does not exist in any tree, but it fixes this issue for
-stable Linux kernel 4.19

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index d7993ac8222d..bac994847327 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5956,6 +5956,9 @@ static int nf_tables_newflowtable(struct net *net, struct sock *nlsk,
 			continue;
 
 		list_for_each_entry(ft, &table->flowtables, list) {
+			if (!nft_is_active_next(net, ft))
+				continue;
+
 			for (k = 0; k < ft->ops_len; k++) {
 				if (!ft->ops[k].dev)
 					continue;
-- 
2.30.2


