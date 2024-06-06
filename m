Return-Path: <stable+bounces-49649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A968FEE46
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA5E1C216F0
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A2D1C224B;
	Thu,  6 Jun 2024 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TtreMkys"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512251C2246;
	Thu,  6 Jun 2024 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683640; cv=none; b=bXfQONhGw+ScH3D9QcgBPAjHBcnx8RbYpXt7wjBDdI5nQQ3kcqhNKoC55maHluXGmFGzr8JlTdCY1eooS3JCdKf0iUb/HMRcN8fhQsFZ7xFck8h6dWHdFhlUEoOVVc+VVubA88VViTeYGTuX2W4/RGZD/BMQC0X8P7a6a+24EdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683640; c=relaxed/simple;
	bh=Wn+X8f8BUlGn7Zegdm+H6c0ua2f2trgbTPmEdNavBPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pr6xwY1MoTfdUWfBiMJMbgdXUt2xmpKnOU18cfyANz1kDcH0oWF+A3v3iFh9PC9lY1J7dFD5UiZhvfaRHJUatUU5JCPwMtz4dKvIBWmkBS4a3n7Q6LNN3MtbpVp3JTlVlDHI/yQNOsj2gIBkwW4En8hHSf7vxfY83EahUYY/PYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TtreMkys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28068C2BD10;
	Thu,  6 Jun 2024 14:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683640;
	bh=Wn+X8f8BUlGn7Zegdm+H6c0ua2f2trgbTPmEdNavBPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TtreMkysdnROwkObWNIPSx1BRda8o8wWfPNkAnMvZym/yAtN+K/WBiNwTmLXkyN+t
	 LE9U2/COghu8iHuwPHumrmQlXIhXWUdcjPlUFtAc5uAXFANJLvu+JlAarb3BhD9tfr
	 Y5MB29s9Xu0yGu+nhXiXuyevLYZk2p9ZxGO2t46M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Garver <eric@garver.life>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 460/473] netfilter: nft_fib: allow from forward/input without iif selector
Date: Thu,  6 Jun 2024 16:06:29 +0200
Message-ID: <20240606131714.892965660@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
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

From: Eric Garver <eric@garver.life>

[ Upstream commit e8ded22ef0f4831279c363c264cd41cd9d59ca9e ]

This removes the restriction of needing iif selector in the
forward/input hooks for fib lookups when requested result is
oif/oifname.

Removing this restriction allows "loose" lookups from the forward hooks.

Fixes: be8be04e5ddb ("netfilter: nft_fib: reverse path filter for policy-based routing on iif")
Signed-off-by: Eric Garver <eric@garver.life>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_fib.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 5748415f74d0b..0f17ace972276 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -34,11 +34,9 @@ int nft_fib_validate(const struct nft_ctx *ctx, const struct nft_expr *expr,
 	switch (priv->result) {
 	case NFT_FIB_RESULT_OIF:
 	case NFT_FIB_RESULT_OIFNAME:
-		hooks = (1 << NF_INET_PRE_ROUTING);
-		if (priv->flags & NFTA_FIB_F_IIF) {
-			hooks |= (1 << NF_INET_LOCAL_IN) |
-				 (1 << NF_INET_FORWARD);
-		}
+		hooks = (1 << NF_INET_PRE_ROUTING) |
+			(1 << NF_INET_LOCAL_IN) |
+			(1 << NF_INET_FORWARD);
 		break;
 	case NFT_FIB_RESULT_ADDRTYPE:
 		if (priv->flags & NFTA_FIB_F_IIF)
-- 
2.43.0




