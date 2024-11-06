Return-Path: <stable+bounces-91021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B214A9BEC13
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4751F23F8E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEE91F4280;
	Wed,  6 Nov 2024 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MQJXJZqK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA0D1EF93D;
	Wed,  6 Nov 2024 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897506; cv=none; b=V/UfAObELo9WH/50Xz/2qOQucB2FCh7USdVUblpnIyigpQaWcGfeJnqAtw80DJ5R61aNHEdVDDNIdwZpAI60vUI7jEClW+Bec+U2PyI3CMHvMg4uLhNN7vwXQrnRAKwrZs2OL3vpcdmbFkhotwS9qCvGXXXGSWgbwBLjsiiUsf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897506; c=relaxed/simple;
	bh=NxuZVE83TgD+jAbhRt/j+UzqklMHCC42rICin3IzjLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxhygG3enrjvSfFmWeUnE4AbvTBRj+SGtKXDHD5ZA2FRC67eNsvnjPSHuoQVBRkIKGvfelxHmt0lLjVusjcSDRfRe/PCeqzgEKQywoWg7lEwTvjhPmZaLzgtfBxJXUpv3fg71nIfoE8b7k03d8Z+LdiwFScW1TpEUmoJU/NWndI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MQJXJZqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F687C4CECD;
	Wed,  6 Nov 2024 12:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897506;
	bh=NxuZVE83TgD+jAbhRt/j+UzqklMHCC42rICin3IzjLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQJXJZqKPkJ6lJbsvtCckozgdN+eaOFKnv++a9SvN9xnG+25FgHMvcghlaFjt+txW
	 71CmMorqeoW+cqu+JhTu3l0xnU5p5hy9awB0kThnk5hRO0Qtc6lDP2OXXcS7DQ1Ugi
	 nqTduqo6pqL9wWstW2rIMwv/nvYuPrsHgpFl/qPk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Slavin Liu <slavin-ayu@qq.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 039/151] netfilter: nft_payload: sanitize offset and length before calling skb_checksum()
Date: Wed,  6 Nov 2024 13:03:47 +0100
Message-ID: <20241106120309.909167342@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
References: <20241106120308.841299741@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit d5953d680f7e96208c29ce4139a0e38de87a57fe ]

If access to offset + length is larger than the skbuff length, then
skb_checksum() triggers BUG_ON().

skb_checksum() internally subtracts the length parameter while iterating
over skbuff, BUG_ON(len) at the end of it checks that the expected
length to be included in the checksum calculation is fully consumed.

Fixes: 7ec3f7b47b8d ("netfilter: nft_payload: add packet mangling support")
Reported-by: Slavin Liu <slavin-ayu@qq.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_payload.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 50429cbd42da4..2db38c06bedeb 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -904,6 +904,9 @@ static void nft_payload_set_eval(const struct nft_expr *expr,
 	    ((priv->base != NFT_PAYLOAD_TRANSPORT_HEADER &&
 	      priv->base != NFT_PAYLOAD_INNER_HEADER) ||
 	     skb->ip_summed != CHECKSUM_PARTIAL)) {
+		if (offset + priv->len > skb->len)
+			goto err;
+
 		fsum = skb_checksum(skb, offset, priv->len, 0);
 		tsum = csum_partial(src, priv->len, 0);
 
-- 
2.43.0




