Return-Path: <stable+bounces-22788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E13385DDDA
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1AB61F21C78
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDCA7C09C;
	Wed, 21 Feb 2024 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QANHmhKm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2C53CF42;
	Wed, 21 Feb 2024 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524513; cv=none; b=ct1rF2XOvhsC/YSA7rTe81qN3oilBDOupK05cDj9jnEpVDR5gqDbNVqPAnwz44O2F8BQMrtq2HPy1pF3+mIKynu4VpECu8Lh3egw6EJUNqCE0aGrj1w5/xlAoF6uZbCW4KP81j5D1XJXLj4U2sD0UQMYCC9eL4QY9AqS9E5uhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524513; c=relaxed/simple;
	bh=IkJMriH7RVh9HlaRMsKPlYNEcnJJhgll06OZotIcChI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtDDCWBr/zv6LQc7tVuNigCuQ3txoiuNqJAK/xGlKHRR4l1QrR6j6NvSIVtAG6e06pEfaKDb3uJS+uvfSs8vX3BBL2Axc+8kyK5aOD88WcTMT5HZbmwAucXtZQvC893Ellburf1AqHpQX11+p8/5XISt1FMOjXnDP4iycrCGhfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QANHmhKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FB7C433A6;
	Wed, 21 Feb 2024 14:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708524513;
	bh=IkJMriH7RVh9HlaRMsKPlYNEcnJJhgll06OZotIcChI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QANHmhKmzKhUZFxsXCqYtQATs7n3Gv/xhhr2xdHENtMikgPtov/P50jcywqzG81IH
	 mAjCd085Z1uQC9J3lG0eoPbyCLX+xaQW+uX7gFVyS4faHcztjw+EGhprOIPzjd+Z0Q
	 xOyZSUXHFoc9VQK9A0IpotO9I4ZElbjZqltcMNok=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 267/379] netfilter: nft_ct: reject direction for ct id
Date: Wed, 21 Feb 2024 14:07:26 +0100
Message-ID: <20240221130002.809428006@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
References: <20240221125954.917878865@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 5b16161526e7..2b15dbbca98b 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -482,6 +482,9 @@ static int nft_ct_get_init(const struct nft_ctx *ctx,
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




