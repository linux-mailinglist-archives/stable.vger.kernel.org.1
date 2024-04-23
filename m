Return-Path: <stable+bounces-41115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2258E8AFA63
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F3A2883E0
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BAA149C4E;
	Tue, 23 Apr 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MYGclpkJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B121E146D6D;
	Tue, 23 Apr 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908687; cv=none; b=nQ/xZFrWhuBTBNJqFZfZkGfuDGYCPCQ7ERKa8r5ebMUZBf3VEUiZaxBaqNGyWnUmrRe13waMv699Wztjrg0pRQI/I2S10Fz/25zFh0w1YFjXrO/zV9gllRj/tuh3LcK9JxezZIMP+wKzYg1eLFg1eAYMyFF2Q9vbH+IbyzmrRog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908687; c=relaxed/simple;
	bh=PT6TjXZ0mdOmQChCjY8Svm7sDis8OE3cPTp7k7vJK5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uqg4yar3fY2ONAC6nQNFOBkHlKIBX0qY27QVS7KRiN7rP8PiabZbVJY7g4h9WDkn4lg3aLCQlgiAk8Kin+/+M6H1Tiw08104loQrXA1Sw0ivVTP/Mz2Dx2dY0yjr/2IcHeWTFbHhRSH6Mf0PItmMV6iPPjNjMQjqRW8b4QP1dLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MYGclpkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82412C116B1;
	Tue, 23 Apr 2024 21:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908687;
	bh=PT6TjXZ0mdOmQChCjY8Svm7sDis8OE3cPTp7k7vJK5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MYGclpkJkIfMUuFDopbDpf2Gqjgtbp7bQoseAuflRcPke6f8Nqk+OAs9oI1mVdTXl
	 N4F4HBt6JXeLujG7+j1MPFJNvEIspmw/69/2VtcIPscYmkFHcKyJRRsKVySkS+yqWd
	 M5bN00gjN08FQlIfwcC9kRW8gKwXJAUVI/CVkfFM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 034/141] netfilter: nf_tables: Fix potential data-race in __nft_expr_type_get()
Date: Tue, 23 Apr 2024 14:38:22 -0700
Message-ID: <20240423213854.411688737@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
References: <20240423213853.356988651@linuxfoundation.org>
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

From: Ziyang Xuan <william.xuanziyang@huawei.com>

[ Upstream commit f969eb84ce482331a991079ab7a5c4dc3b7f89bf ]

nft_unregister_expr() can concurrent with __nft_expr_type_get(),
and there is not any protection when iterate over nf_tables_expressions
list in __nft_expr_type_get(). Therefore, there is potential data-race
of nf_tables_expressions list entry.

Use list_for_each_entry_rcu() to iterate over nf_tables_expressions
list in __nft_expr_type_get(), and use rcu_read_lock() in the caller
nft_expr_type_get() to protect the entire type query process.

Fixes: ef1f7df9170d ("netfilter: nf_tables: expression ops overloading")
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8152a69d82681..ba63866914f18 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2891,7 +2891,7 @@ static const struct nft_expr_type *__nft_expr_type_get(u8 family,
 {
 	const struct nft_expr_type *type, *candidate = NULL;
 
-	list_for_each_entry(type, &nf_tables_expressions, list) {
+	list_for_each_entry_rcu(type, &nf_tables_expressions, list) {
 		if (!nla_strcmp(nla, type->name)) {
 			if (!type->family && !candidate)
 				candidate = type;
@@ -2923,9 +2923,13 @@ static const struct nft_expr_type *nft_expr_type_get(struct net *net,
 	if (nla == NULL)
 		return ERR_PTR(-EINVAL);
 
+	rcu_read_lock();
 	type = __nft_expr_type_get(family, nla);
-	if (type != NULL && try_module_get(type->owner))
+	if (type != NULL && try_module_get(type->owner)) {
+		rcu_read_unlock();
 		return type;
+	}
+	rcu_read_unlock();
 
 	lockdep_nfnl_nft_mutex_not_held();
 #ifdef CONFIG_MODULES
-- 
2.43.0




