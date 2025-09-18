Return-Path: <stable+bounces-170582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6924B2A53F
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47131724C5
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EE832A3DD;
	Mon, 18 Aug 2025 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cvtMYV2c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35D3320CDB;
	Mon, 18 Aug 2025 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523106; cv=none; b=TuVwyIVy1zev3Zq/p/uq1n+nM2tvnWDCmrzcL497e//vRYqSMeQqWbJxHFA+Q6TCoICgqXBoZ7pj6sqViktv8MlnDCpOUz6/xR9ZEkoKKHX204Lx1mT/+PEw0tJsQgaWRWv71SMvV0IuLgeOyCuhCLVJ1dnVgv9/P+EBlnwHbRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523106; c=relaxed/simple;
	bh=r1N6/R4aS3qvKKmtkluduwUolH3SAGvsH9ACfc0/X9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lO6CGiNNmpgzfMsyD+IT1dgXVmhfsxio6NtciFtioRJCOgR7/+kywLJAfG67nisKkpW8uXR5YSHkTYaoD7aVY8eRXNNyqobQgPSjor3Dqb4/3ebUzg9/hgNjE4yblgFijY06zV+GrelwOA6q7rEQLkIrSdzVNPxhOO8DOaADqbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cvtMYV2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107C3C4CEEB;
	Mon, 18 Aug 2025 13:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755523106;
	bh=r1N6/R4aS3qvKKmtkluduwUolH3SAGvsH9ACfc0/X9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cvtMYV2ckBHP4NsBUsCq+og8b2VarLIHvy3E4RO98nLAua5ypiYNa4qnjse8OAMfn
	 I13nqL9Tx9YGm8Q+o8H7o3KpdrRZ2EBsjeqmgCEwba7mQlJYfsHVfUipAS7PAgoGLO
	 qRRYa8FOxfPx6Fl+mPxT0hdBivmIfC2aqIizOtYk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yao Zi <ziyao@disroot.org>,
	Drew Fustini <fustini@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 072/515] net: stmmac: thead: Get and enable APB clock on initialization
Date: Mon, 18 Aug 2025 14:40:58 +0200
Message-ID: <20250818124501.161782129@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yao Zi <ziyao@disroot.org>

[ Upstream commit 4cc339ce482ba78589a2d5cbe1c84b735d263383 ]

It's necessary to adjust the MAC TX clock when the linkspeed changes,
but it's noted such adjustment always fails on TH1520 SoC, and reading
back from APB glue registers that control clock generation results in
garbage, causing broken link.

With some testing, it's found a clock must be ungated for access to APB
glue registers. Without any consumer, the clock is automatically
disabled during late kernel startup. Let's get and enable it if it's
described in devicetree.

For backward compatibility with older devicetrees, probing won't fail if
the APB clock isn't found. In this case, we emit a warning since the
link will break if the speed changes.

Fixes: 33a1a01e3afa ("net: stmmac: Add glue layer for T-HEAD TH1520 SoC")
Signed-off-by: Yao Zi <ziyao@disroot.org>
Tested-by: Drew Fustini <fustini@kernel.org>
Reviewed-by: Drew Fustini <fustini@kernel.org>
Link: https://patch.msgid.link/20250808093655.48074-4-ziyao@disroot.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
index c72ee759aae5..f2946bea0bc2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
@@ -211,6 +211,7 @@ static int thead_dwmac_probe(struct platform_device *pdev)
 	struct stmmac_resources stmmac_res;
 	struct plat_stmmacenet_data *plat;
 	struct thead_dwmac *dwmac;
+	struct clk *apb_clk;
 	void __iomem *apb;
 	int ret;
 
@@ -224,6 +225,19 @@ static int thead_dwmac_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(plat),
 				     "dt configuration failed\n");
 
+	/*
+	 * The APB clock is essential for accessing glue registers. However,
+	 * old devicetrees don't describe it correctly. We continue to probe
+	 * and emit a warning if it isn't present.
+	 */
+	apb_clk = devm_clk_get_enabled(&pdev->dev, "apb");
+	if (PTR_ERR(apb_clk) == -ENOENT)
+		dev_warn(&pdev->dev,
+			 "cannot get apb clock, link may break after speed changes\n");
+	else if (IS_ERR(apb_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(apb_clk),
+				     "failed to get apb clock\n");
+
 	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
 	if (!dwmac)
 		return -ENOMEM;
-- 
2.50.1




