Return-Path: <stable+bounces-129534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481DEA80063
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE1F44214E
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CC42676C9;
	Tue,  8 Apr 2025 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ScutrL0Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7DF266EFC;
	Tue,  8 Apr 2025 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111290; cv=none; b=hi5TWrLWhKn+vBeoh4DT0wrBsNqgQ31dA3yCt5Lf2pKAKbEPD7S7BZLw0/CnTvbma7choDKtnWidrIcC1m7LvLeYK6lRErZ+T1LI14LXZZvLlumC05Xm4fC54MjHYdY30xslMY26yqUC3XpBSgiFVUR873vz9kzmGFy47p/3eyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111290; c=relaxed/simple;
	bh=yFj/6Aq8iQ0RTnGQEYgIqjvP+s4Ph/rOFS3Tlmvd2XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2T+kMIgHDelvXviLhbuULQr6xj7qvopUa3EirscRmrYf1FL84EsuFc8i4RN+u1JKYJXNujR4TRZr7uXKct1q3jtje+hZKVF7+f1p8wRFyG4Zo+6XbhnpHiRRBOS3STjqe8R9okES4LrfMJwwc2SEXqmogpObCTUYNa8sfiypkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ScutrL0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC74C4CEE5;
	Tue,  8 Apr 2025 11:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111290;
	bh=yFj/6Aq8iQ0RTnGQEYgIqjvP+s4Ph/rOFS3Tlmvd2XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ScutrL0QeWHqlH7pV4oEekloif8/2fBroWz1YBmcs30wUADi1CEsWWw5WYxxeSbRL
	 jrnvCSrlW6NXl9QvtpLg1S0C7SuXOGEjeGTiEuDfp1pQgu3+XQpt6Yfbwaa7MSShYu
	 lbt375uDzQCBIwc5e5T1LixOv5Ya3lb433rrUh70=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Akhil R <akhilrajeev@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 376/731] crypto: tegra - Fix CMAC intermediate result handling
Date: Tue,  8 Apr 2025 12:44:33 +0200
Message-ID: <20250408104923.023058613@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akhil R <akhilrajeev@nvidia.com>

[ Upstream commit ce390d6c2675d2e24d798169a1a0e3cdbc076907 ]

Saving and restoring of the intermediate results are needed if there is
context switch caused by another ongoing request on the same engine.
This is therefore not only to support import/export functionality.
Hence, save and restore the intermediate result for every non-first task.

Fixes: 0880bb3b00c8 ("crypto: tegra - Add Tegra Security Engine driver")
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/tegra/tegra-se-aes.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/tegra/tegra-se-aes.c b/drivers/crypto/tegra/tegra-se-aes.c
index 5d8237cda58f0..cdcf05e235cad 100644
--- a/drivers/crypto/tegra/tegra-se-aes.c
+++ b/drivers/crypto/tegra/tegra-se-aes.c
@@ -1541,9 +1541,8 @@ static int tegra_cmac_do_update(struct ahash_request *req)
 	rctx->residue.size = nresidue;
 
 	/*
-	 * If this is not the first 'update' call, paste the previous copied
+	 * If this is not the first task, paste the previous copied
 	 * intermediate results to the registers so that it gets picked up.
-	 * This is to support the import/export functionality.
 	 */
 	if (!(rctx->task & SHA_FIRST))
 		tegra_cmac_paste_result(ctx->se, rctx);
@@ -1551,13 +1550,7 @@ static int tegra_cmac_do_update(struct ahash_request *req)
 	cmdlen = tegra_cmac_prep_cmd(ctx, rctx);
 	ret = tegra_se_host1x_submit(se, se->cmdbuf, cmdlen);
 
-	/*
-	 * If this is not the final update, copy the intermediate results
-	 * from the registers so that it can be used in the next 'update'
-	 * call. This is to support the import/export functionality.
-	 */
-	if (!(rctx->task & SHA_FINAL))
-		tegra_cmac_copy_result(ctx->se, rctx);
+	tegra_cmac_copy_result(ctx->se, rctx);
 
 	dma_free_coherent(ctx->se->dev, rctx->datbuf.size,
 			  rctx->datbuf.buf, rctx->datbuf.addr);
@@ -1594,6 +1587,13 @@ static int tegra_cmac_do_final(struct ahash_request *req)
 	rctx->total_len += rctx->residue.size;
 	rctx->config = tegra234_aes_cfg(SE_ALG_CMAC, 0);
 
+	/*
+	 * If this is not the first task, paste the previous copied
+	 * intermediate results to the registers so that it gets picked up.
+	 */
+	if (!(rctx->task & SHA_FIRST))
+		tegra_cmac_paste_result(ctx->se, rctx);
+
 	/* Prepare command and submit */
 	cmdlen = tegra_cmac_prep_cmd(ctx, rctx);
 	ret = tegra_se_host1x_submit(se, se->cmdbuf, cmdlen);
-- 
2.39.5




