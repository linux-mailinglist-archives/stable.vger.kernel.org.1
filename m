Return-Path: <stable+bounces-50372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0956A90602B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 03:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4721C21367
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 01:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDAE84D35;
	Thu, 13 Jun 2024 01:02:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CF9EAD0;
	Thu, 13 Jun 2024 01:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718240560; cv=none; b=tCXXmI2xdfwBPJwAWnSL3/9u7p/kxqpq56+2rMDo8Gt7WGNAi06+sv/GrwGLuSgkq3sXtlRTU2898RHAfChk6F8wzyjmSVv4fk9qIi6Vzw/0X44HxRpJX4jf6P1MYgPGCHb07zqRaRM7bRGpPmDKRPYzh/pYxDxsfSxZ1LF0c+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718240560; c=relaxed/simple;
	bh=X6F2+0anYVbFj7zs657WcuHSj7ZM4LPdZL0Iasy9sNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FlNKuGSn8TSFkJty6JCBwk/h+T4cilw8niM0LpI3O1Me+Zrh6nuW/n7Rc/u99P3Z26qnFakUQePMNNSjZkpTYxyrMrHWjyFJJpGUxN3gyLPVqhomMPUi9t/7YIQ43iL0rHMy2yMfuSAAgZSJKhOsbaG2HGZIqczNwxkcDvjk+uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH -stable,4.19.x 32/40] netfilter: nf_tables: skip dead set elements in netlink dump
Date: Thu, 13 Jun 2024 03:02:01 +0200
Message-Id: <20240613010209.104423-33-pablo@netfilter.org>
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

[ Upstream commit 6b1ca88e4bb63673dc9f9c7f23c899f22c3cb17a ]

Delete from packet path relies on the garbage collector to purge
elements with NFT_SET_ELEM_DEAD_BIT on.

Skip these dead elements from nf_tables_dump_setelem() path, I very
rarely see tests/shell/testcases/maps/typeof_maps_add_delete reports
[DUMP FAILED] showing a mismatch in the expected output with an element
that should not be there.

If the netlink dump happens before GC worker run, it might show dead
elements in the ruleset listing.

nft_rhash_get() already skips dead elements in nft_rhash_cmp(),
therefore, it already does not show the element when getting a single
element via netlink control plane.

Fixes: 5f68718b34a5 ("netfilter: nf_tables: GC transaction API to avoid race with control plane")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 29a782e9ad07..8045eefc99e1 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4200,7 +4200,7 @@ static int nf_tables_dump_setelem(const struct nft_ctx *ctx,
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 	struct nft_set_dump_args *args;
 
-	if (nft_set_elem_expired(ext))
+	if (nft_set_elem_expired(ext) || nft_set_elem_is_dead(ext))
 		return 0;
 
 	args = container_of(iter, struct nft_set_dump_args, iter);
-- 
2.30.2


