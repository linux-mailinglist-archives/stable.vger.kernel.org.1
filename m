Return-Path: <stable+bounces-57725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A978925DB7
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91DE1F218BF
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC04191F70;
	Wed,  3 Jul 2024 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2gohlg/U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B827191F6B;
	Wed,  3 Jul 2024 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005745; cv=none; b=XNGUoWhGJs4iVYe5Mi/O2ztp0O+vd3DvksmBl0FUsdLTZs7JsRm+kzikOBgcgnhlYaZbkF9AUxsC27ri5VZHKQwp6ZphmIO/DMMX/zO+Nxri4KdzsEYUAh9a2yrW4hBQ+DA8Lax4+vDzXyGcrK0NKJy+LZK0ucxQPyXno138Mbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005745; c=relaxed/simple;
	bh=Opit10aO9kyIW3pJvHnWUGZ1S9fowPWJpnHaT5jfkdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTaZzGJ5S/wInFcd0nd+JhNM+Ynp73JQC31OS85Kv30p+Myeh1IyPk1dmwsbUgeJZpX88EFlUpINfbvx3NENE5gd9kpvnP+9rGVqlQiCdh484eL55d6LN2vEATPhq1BJBVnFAn2CLkzR+dOLbQueD+icVYg0d9PCcHMGzeapHu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2gohlg/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE5AC2BD10;
	Wed,  3 Jul 2024 11:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005745;
	bh=Opit10aO9kyIW3pJvHnWUGZ1S9fowPWJpnHaT5jfkdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2gohlg/UdHYzThPSIOqpj/Cq0tnTLXJg7yI2shpbK1hHf2cqf3EPVFdhzlq/XX18O
	 6NgiJ0xKQLYi3XBkZdkqvFnacetEoHTpevbQp7NNCRYKk9ghkv4Skfk9fRoW3X6kSo
	 Pz8U8AcAkejSNP9Z9GzJQ7mmuZmM74xu63lG+b9Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chenghai Huang <huangchenghai2@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 151/356] crypto: hisilicon/sec - Fix memory leak for sec resource release
Date: Wed,  3 Jul 2024 12:38:07 +0200
Message-ID: <20240703102918.816118386@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chenghai Huang <huangchenghai2@huawei.com>

[ Upstream commit bba4250757b4ae1680fea435a358d8093f254094 ]

The AIV is one of the SEC resources. When releasing resources,
it need to release the AIV resources at the same time.
Otherwise, memory leakage occurs.

The aiv resource release is added to the sec resource release
function.

Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 0d26eda36a526..28c167e1be426 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -463,8 +463,10 @@ static void sec_alg_resource_free(struct sec_ctx *ctx,
 
 	if (ctx->pbuf_supported)
 		sec_free_pbuf_resource(dev, qp_ctx->res);
-	if (ctx->alg_type == SEC_AEAD)
+	if (ctx->alg_type == SEC_AEAD) {
 		sec_free_mac_resource(dev, qp_ctx->res);
+		sec_free_aiv_resource(dev, qp_ctx->res);
+	}
 }
 
 static int sec_create_qp_ctx(struct hisi_qm *qm, struct sec_ctx *ctx,
-- 
2.43.0




