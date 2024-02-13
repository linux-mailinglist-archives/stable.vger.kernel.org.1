Return-Path: <stable+bounces-19947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A89C853807
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3061C2222A
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0E75FF0A;
	Tue, 13 Feb 2024 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hFkuonZT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6145F54E;
	Tue, 13 Feb 2024 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845541; cv=none; b=vBj2TXOPivimOcXHct/xPbQhE0aSMg7lMesRMEjbiQgGmm31d0GKZNmdsP4FFPfBNMCwiVSs/nbwWyQU/SkVKUHPc80rQUZvmT1IE3R/p6Orvr4hEIevm7KCE648B00ozlhLS7OvgtO95aJCSf0hAl5pnPJ2dhavA2OL7U+NJ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845541; c=relaxed/simple;
	bh=FALcH2lUK6qibfuIJkhAB9pM7phb9TlMx7Lnnge654Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvhgaWgsOKLKJbdRbGIr3y747mAJX5FxCxc2wOLwxs+JWuFpcQHXdUvEUEnROXtiRuGj8Qx6XDfWWV3gXhJWMyOqBMs3WUnFKA2XI55WqJhwNzeisxQzVRQNheFnHOjAx3OKdofTQn/VQmRCmSzZucKINGCO2nTsUqF36z3IYdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hFkuonZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334C2C433F1;
	Tue, 13 Feb 2024 17:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707845541;
	bh=FALcH2lUK6qibfuIJkhAB9pM7phb9TlMx7Lnnge654Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hFkuonZTlFDip6dt1mkgRwJ0j/f6rCqX7YQXTCx4zFwtcZqJDE2+HitY2hCJk7ZHO
	 Y7ynPQHG+cIvsm7maUzFQB3GVJn4u7sBjB310J09Jqh32UqXauzzZ3hyhLMKCavrxR
	 dCPGd3sGOMvHFDb/G6u4k7I6ygUpDgfQR7TimLXU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 080/121] netfilter: nft_ct: reject direction for ct id
Date: Tue, 13 Feb 2024 18:21:29 +0100
Message-ID: <20240213171855.326959680@linuxfoundation.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213171852.948844634@linuxfoundation.org>
References: <20240213171852.948844634@linuxfoundation.org>
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

[ Upstream commit 38ed1c7062ada30d7c11e7a7acc749bf27aa14aa ]

Direction attribute is ignored, reject it in case this ever needs to be
supported

Fixes: 3087c3f7c23b ("netfilter: nft_ct: Add ct id support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_ct.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index aac98a3c966e..bfd3e5a14dab 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -476,6 +476,9 @@ static int nft_ct_get_init(const struct nft_ctx *ctx,
 		break;
 #endif
 	case NFT_CT_ID:
+		if (tb[NFTA_CT_DIRECTION])
+			return -EINVAL;
+
 		len = sizeof(u32);
 		break;
 	default:
-- 
2.43.0




