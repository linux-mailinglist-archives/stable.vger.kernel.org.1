Return-Path: <stable+bounces-38597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCCE8A0F74
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6201C215AF
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9833146A70;
	Thu, 11 Apr 2024 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hnTN2JiC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AC81465A5;
	Thu, 11 Apr 2024 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831040; cv=none; b=EpzXT5NvXOLl6UqESDL4kg6tVnFgjbZIHwIUvRET0llLCYfUgoEE74x1XulgKTgprMchEt/PGifTelSp7DAPr2icLfQAYMrqaBxlnUCBO3tJGrrPanZxQbg9Ve9Qnaukz8HsVbJRi/h/XuMOmlC0LcEOP713Ie8XvPFYDYcJoAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831040; c=relaxed/simple;
	bh=yR0mqjTbMa8XtYw7O2eVn3PnEGUmm3QtF5KOI9e5wyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Obu29QlawofKf1kLSkIqr1BrSsAXV/yzh6xP24XkXD3r6tViNWG0QAsCezT4EjaA/NLQ4dJ6cQalUuegEjvuaE0gc9gjX5Zfy6cPk2ACTEq0gBX6cJGWTHLnGCWlzpWto5+3Sr7rThA/ZyrIj5G8einrOHXC89w1Pq9goTWWVkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hnTN2JiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBF3C433F1;
	Thu, 11 Apr 2024 10:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831040;
	bh=yR0mqjTbMa8XtYw7O2eVn3PnEGUmm3QtF5KOI9e5wyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hnTN2JiCH5TMO7drmTZ5iE3BMSwzxiSggpO11Jw9RwoUrrkHEqMheuQ7qoZQJ5M0E
	 PFqagvpl5ktDHbg4KdPwb8dmVTCTh347zSCQjMJvK7USkMUDVCnD6ykAVAUVNXZ1SG
	 Yye7/7ktJZ915Q9Azlyxed+alurshBIewv/NSluk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 204/215] netfilter: nf_tables: discard table flag update with pending basechain deletion
Date: Thu, 11 Apr 2024 11:56:53 +0200
Message-ID: <20240411095430.987606918@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
References: <20240411095424.875421572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 1bc83a019bbe268be3526406245ec28c2458a518 upstream.

Hook unregistration is deferred to the commit phase, same occurs with
hook updates triggered by the table dormant flag. When both commands are
combined, this results in deleting a basechain while leaving its hook
still registered in the core.

Fixes: 179d9ba5559a ("netfilter: nf_tables: fix table flag updates")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8dd7efb3b8f7b..b4bb93b9aafc7 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -903,6 +903,24 @@ static void nf_tables_table_disable(struct net *net, struct nft_table *table)
 #define __NFT_TABLE_F_UPDATE		(__NFT_TABLE_F_WAS_DORMANT | \
 					 __NFT_TABLE_F_WAS_AWAKEN)
 
+static bool nft_table_pending_update(const struct nft_ctx *ctx)
+{
+	struct nftables_pernet *nft_net = net_generic(ctx->net, nf_tables_net_id);
+	struct nft_trans *trans;
+
+	if (ctx->table->flags & __NFT_TABLE_F_UPDATE)
+		return true;
+
+	list_for_each_entry(trans, &nft_net->commit_list, list) {
+		if (trans->ctx.table == ctx->table &&
+		    trans->msg_type == NFT_MSG_DELCHAIN &&
+		    nft_is_base_chain(trans->ctx.chain))
+			return true;
+	}
+
+	return false;
+}
+
 static int nf_tables_updtable(struct nft_ctx *ctx)
 {
 	struct nft_trans *trans;
@@ -920,7 +938,7 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 		return 0;
 
 	/* No dormant off/on/off/on games in single transaction */
-	if (ctx->table->flags & __NFT_TABLE_F_UPDATE)
+	if (nft_table_pending_update(ctx))
 		return -EINVAL;
 
 	trans = nft_trans_alloc(ctx, NFT_MSG_NEWTABLE,
-- 
2.43.0




