Return-Path: <stable+bounces-46639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDAD8D0AA0
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71631B21F9A
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA911607B0;
	Mon, 27 May 2024 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WLTqZwQ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88E15FA9F;
	Mon, 27 May 2024 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836472; cv=none; b=eGxCFGwGpX3gIZ3/Wrt97wLM4Sq6KKlKYKrUzuyt9VEJTqljwzJ2oAAFvHSVRyIWRfGROvkxgrI2Q97BaAUnXKwYN1QZ0hPtn0/ptdkzXkcAe5NuuCdj36Wth54S2ASqfi7doFxAHVxZxQ29zdoOfuIgL/Gwqu5wRsTBLHFhMvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836472; c=relaxed/simple;
	bh=rTjxTAwL1edMQUttAsuR9x2FrpP3Tp+vM/O43kaa+U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4i7rF16h2AR5EtaFCOnzu4hYejg30I96C2n8ZBWpta5rhPnBjLaAcx/q3u0LqNy1sArTFQgs9GOJ0V8vi4u5sFNI8hKoqC6jbr4e6UWZCLaOFa+bYHMIQfL4SeHtaoAlS0kvY4eoXcMByx5bmA7XjBek/kPGi8zmNMRY6kN7kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WLTqZwQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436B1C2BBFC;
	Mon, 27 May 2024 19:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836472;
	bh=rTjxTAwL1edMQUttAsuR9x2FrpP3Tp+vM/O43kaa+U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WLTqZwQ/NENuKsTfhjEsXg5Qd7dL++jfUw3FUbkrf7hUbPDexJrSCzxn0vXUIvxxe
	 6+KmqRCMplGiG4C/36luJdiI+0jztFi5aAL2RchlGiTgj+ABfG1YUbZ+i5nFwMEOxK
	 xeoDeVbrb7RjEbHxTVSCyvPL6xujA/86Z2MUQdgs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 067/427] crypto: octeontx2 - add missing check for dma_map_single
Date: Mon, 27 May 2024 20:51:54 +0200
Message-ID: <20240527185608.103985545@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 6a6d6a3a328a59ed0d8ae2e65696ef38e49133a0 ]

Add check for dma_map_single() and return error if it fails in order
to avoid invalid dma address.

Fixes: e92971117c2c ("crypto: octeontx2 - add ctx_val workaround")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/marvell/octeontx2/cn10k_cpt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/marvell/octeontx2/cn10k_cpt.c b/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
index 79b4e74804f6d..6bfc59e677478 100644
--- a/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
+++ b/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
@@ -138,6 +138,10 @@ int cn10k_cpt_hw_ctx_init(struct pci_dev *pdev,
 		return -ENOMEM;
 	cptr_dma = dma_map_single(&pdev->dev, hctx, CN10K_CPT_HW_CTX_SIZE,
 				  DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(&pdev->dev, cptr_dma)) {
+		kfree(hctx);
+		return -ENOMEM;
+	}
 
 	cn10k_cpt_hw_ctx_set(hctx, 1);
 	er_ctx->hw_ctx = hctx;
-- 
2.43.0




