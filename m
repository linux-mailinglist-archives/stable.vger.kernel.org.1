Return-Path: <stable+bounces-30302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D811A888AAE
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 04:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9251D28AFBD
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 03:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B6717D223;
	Sun, 24 Mar 2024 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfLZ9LYx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B8156C49;
	Sun, 24 Mar 2024 23:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321897; cv=none; b=Sqz1Ik5h4ZD09W3sRY/Mp6iaHPLwrUYQcSBYjU3ZxnWRQ8/JI/iuEO4LiTfibQ0ooEGWfG0TC1w2/+GaaQJajEe1q45CiyLG7fSLH7UiMXf0laGUGpfNino8HmQPNDNS1JbMgxo2mmdAdTqkNzMXXqiyBOCEBjBFTTO0hcPBIoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321897; c=relaxed/simple;
	bh=QtPeuKSCloDhnaL1gJF50s6+yRvjF257YTBkRXOS2A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aj1q3umvq3QcT/HfZpZ0UUlbe89mfmwk6f7EtWwwZHeA+lgpMgp5RAMxRs3EmBIMc411azO8Yr7HPq9ErhtJW1rSBXxTKqvMA9XxpFHl1pGkwEfTllm/gA6irGuTBRRSCkIyvS66SSNqeeYzmffJEocIl469m9vHCkmB9BnlS88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfLZ9LYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42D9C43390;
	Sun, 24 Mar 2024 23:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321896;
	bh=QtPeuKSCloDhnaL1gJF50s6+yRvjF257YTBkRXOS2A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HfLZ9LYxWIwcEq2B7wQC5VOuQkX3d8/gWEkIDukmp5J9iy1SU7Q8sgAy/Ur5FKvno
	 nWTKKUoqTTvViQzcGd56CLdwuZCCvdTEPsAFbLH9Kp4W8z6q4rvkHB08zdzDsdIw2a
	 AQk/j1ForM0hybkm6XLSdgaK6EYYolFEhoJSsjMzazhB/rZRgBPZ27zxm1FuHy/R3M
	 LPm2hPMiIwe5x20MZfa9sKdDJOYePbL6r/uh7biEsL/d1osueTMpuf8EJ/ho5L65AQ
	 XVivAh4yT2gpDx+pChUOVKFoYjzG22XM9Vny2c83aObrw6P+pZmQe+RSEuq9mrmvQ0
	 Dax51umM6KYog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 625/638] netfilter: nf_tables: do not compare internal table flags on updates
Date: Sun, 24 Mar 2024 19:01:02 -0400
Message-ID: <20240324230116.1348576-626-sashal@kernel.org>
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

[ Upstream commit 4a0e7f2decbf9bd72461226f1f5f7dcc4b08f139 ]

Restore skipping transaction if table update does not modify flags.

Fixes: 179d9ba5559a ("netfilter: nf_tables: fix table flag updates")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8808d78d65235..a7f10941a935a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1213,7 +1213,7 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 	if (flags & ~NFT_TABLE_F_MASK)
 		return -EOPNOTSUPP;
 
-	if (flags == ctx->table->flags)
+	if (flags == (ctx->table->flags & NFT_TABLE_F_MASK))
 		return 0;
 
 	if ((nft_table_has_owner(ctx->table) &&
-- 
2.43.0


