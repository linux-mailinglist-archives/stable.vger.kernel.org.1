Return-Path: <stable+bounces-101928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA2D9EF01D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C560E174159
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E26229696;
	Thu, 12 Dec 2024 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nqrVpqoi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19FB211A34;
	Thu, 12 Dec 2024 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019313; cv=none; b=eF/vzx/lGt3InL7OJcVLMvKcwSbjKAcvWSQIV05p19OS6VpeVweb761rB/MxT9wlnHP8PJaag3O1Q3ZF/wz8ZpWw2QrvDDkZBqfHCUsAyK/W/J31t18Ri9VBrKViFYIsSugIcmYQdcAd6Vjg1eavfQ0uS7NrIgWC5Z/OYV94vQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019313; c=relaxed/simple;
	bh=7jtSoSlongbxXnhDb8CVoJOc4nlLy8bCs0FnBkAEy1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RH+x6Hr0Ji1mM1gy3X32e/v/j5v85fWzHiRKXqoi7RvIIu1uUDwjHdStIdA7WyZYUodHpaqykZ9rYpUL4F0hhdtBF8w7wRo61UIrBr33WI0NLwWmj3soXlb0YbGE95C6QzS4oH1Hdv0fheAOwEdMpNMmRkMa8N1MaOPf7RVqvrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nqrVpqoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA40DC4CED0;
	Thu, 12 Dec 2024 16:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734019313;
	bh=7jtSoSlongbxXnhDb8CVoJOc4nlLy8bCs0FnBkAEy1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nqrVpqoiYUHA5fAl0a5653OHddHTjFigID4ZMGSMZU0S7nloYj0d2r/kFOVgJhUs9
	 oDxUt5jJPshQGaRzE3Nu57XCyxuHvR9WctICap26eP/nfUdEAG+CqJ0VQaXsYNLK/N
	 i2gkE4+0f6YRUtEI+9Ab+8rWHmEX/2qX/7x1tnvQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 175/772] netfilter: nf_tables: skip transaction if update object is not implemented
Date: Thu, 12 Dec 2024 15:52:00 +0100
Message-ID: <20241212144357.175057896@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 84b1a0c0140a9a92ea108576c0002210f224ce59 ]

Turn update into noop as a follow up for:

  9fedd894b4e1 ("netfilter: nf_tables: fix unexpected EOPNOTSUPP error")

instead of adding a transaction object which is simply discarded at a
later stage of the commit protocol.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: cddc04275f95 ("netfilter: nf_tables: must hold rcu read lock while iterating object type list")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index ed09b1fdda16e..d7a628e2c2493 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7313,6 +7313,9 @@ static int nf_tables_newobj(struct sk_buff *skb, const struct nfnl_info *info,
 		if (WARN_ON_ONCE(!type))
 			return -ENOENT;
 
+		if (!obj->ops->update)
+			return 0;
+
 		nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
 
 		return nf_tables_updobj(&ctx, type, nla[NFTA_OBJ_DATA], obj);
@@ -8972,9 +8975,10 @@ static void nft_obj_commit_update(struct nft_trans *trans)
 	obj = nft_trans_obj(trans);
 	newobj = nft_trans_obj_newobj(trans);
 
-	if (obj->ops->update)
-		obj->ops->update(obj, newobj);
+	if (WARN_ON_ONCE(!obj->ops->update))
+		return;
 
+	obj->ops->update(obj, newobj);
 	nft_obj_destroy(&trans->ctx, newobj);
 }
 
-- 
2.43.0




