Return-Path: <stable+bounces-218907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJXFBXZWnmnyUgQAu9opvQ
	(envelope-from <stable+bounces-218907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F9F1902EC
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2DC032F153C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57562848A8;
	Wed, 25 Feb 2026 01:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mb5DUsv9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983B026158C;
	Wed, 25 Feb 2026 01:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983799; cv=none; b=rm4+qJs5u7vDrSox0zmmW2zyB3n+nVvXaB0PTKnAjsEh7H3yawSxyDLPtFBqOGzNX7u7tpnZmeZP5TxfcdoyB4fpEVbWU4qHAwQokCUcLkpUsk5KocDoPRulHdF56Itzy3m+S5rspzfWXlSBuPABwNr2xdjxdp4LUwl/2FdRgkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983799; c=relaxed/simple;
	bh=Ykp9gsiTethrN6RcNJ/qsjPtT3JfwP4ZYpq1jE0/Ur8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epAFLlSr058o+73YBhVsGhlczW0H4i9aNZemYz4I4HUBCZhHsJTsAaabdi/q8k2lf05z9RDEe5nulqx11INb9Aoi9/l1ROsxrGSd3eewP/O+9nS5t9VhmbhtcSrsFPWsLHtwZ+Hec9x/iJWaIx6mWncEg8nFd9BOmBY21M/Fp7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mb5DUsv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57612C116D0;
	Wed, 25 Feb 2026 01:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983799;
	bh=Ykp9gsiTethrN6RcNJ/qsjPtT3JfwP4ZYpq1jE0/Ur8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mb5DUsv9RNGzGozvX1twFBe09RlPxvSibrfvdn5lftVOQQiPAMDMbpNYK2sNmaFf6
	 8c3sPd0MOz5n9R4IHuAoug9+NFBSwTHL2xqhT3/O9RFAubSIxO4BBhafOXesFSKyNi
	 m0i9DsHU0nfJBwSwrPknJWsraFYZNsTmdt72h/Y8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chenghai Huang <huangchenghai2@huawei.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 083/641] crypto: hisilicon/sgl - fix inconsistent map/unmap direction issue
Date: Tue, 24 Feb 2026 17:16:49 -0800
Message-ID: <20260225012351.099087937@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218907-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,huawei.com:email]
X-Rspamd-Queue-Id: 84F9F1902EC
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chenghai Huang <huangchenghai2@huawei.com>

[ Upstream commit 4154f7d3b1c133b909d20c44ecb8277e8482aa6b ]

Ensure that the direction for dma_map_sg and dma_unmap_sg is
consistent.

Fixes: 2566de3e06a3 ("crypto: hisilicon - Use fine grained DMA mapping direction")
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/sgl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
index 7a9ef2a9972a2..848ad7b101d93 100644
--- a/drivers/crypto/hisilicon/sgl.c
+++ b/drivers/crypto/hisilicon/sgl.c
@@ -265,7 +265,7 @@ hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev, struct scatterlist *sgl,
 	return curr_hw_sgl;
 
 err_unmap:
-	dma_unmap_sg(dev, sgl, sg_n, DMA_BIDIRECTIONAL);
+	dma_unmap_sg(dev, sgl, sg_n, dir);
 
 	return ERR_PTR(ret);
 }
-- 
2.51.0




