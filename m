Return-Path: <stable+bounces-206025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE96CFA8F6
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 20:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 316DD31F20A2
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A52E27586C;
	Tue,  6 Jan 2026 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icCZzMHs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E718B225791
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767724023; cv=none; b=ePHR1HNuAoaACBS66qThP6EcGWjjJkWr+oA2WkykZOCzlZ5HToBQbuLDSM1+a+OdbFT+yzyddo4BGoHSzaNcBYnfCIFFq/xtr5CUEmrZrAvKC3bIwQwBNmeWXFRY0MRGICU/6/HxSbE+69dnGziz0kkRrmqWtwKKHSjVtsX1Uuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767724023; c=relaxed/simple;
	bh=mkbG6+SAMqt4o1H84ykdfkdcOSRDbglrpabALzmTI64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYA+MW6Cjnl0qNgz4mOGBHD9PS5XhnFwTxwVMax8YKcCaRdhO+Fd1+vxMPEYiZ/ukJF7brMUfQoq43Ehr/s0F7s5G1cKV36lNm7mo/wvH+KtM4fZFgOKQWohUbzxZyudPs0sTOGmSy0ucG5Ilz5HF/n+Z6SS1W1P1P1y5mZYjBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icCZzMHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B591EC16AAE;
	Tue,  6 Jan 2026 18:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767724020;
	bh=mkbG6+SAMqt4o1H84ykdfkdcOSRDbglrpabALzmTI64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=icCZzMHsm7Gd68irjfOAbJTlKyq9lH/4sXchYKoB8qGzCnftXhDM40D6D/v+STcmy
	 adgvXXCpA0rn5EacXeTjfwaBISf+vndSPReXoJcFOCw6de2NaCFEJBB5pFEUzPzdDd
	 EYwR9b89OFf2yj5GaVqt0WQRWBIFVtgyHcFGp+f+15iN5C3vcnTtK3xFNo3P+wUL3+
	 RulwSNkLOVuT2hD1b+a4HdbDMUFX22FFO56GwrerSNYiMOcyiy47xpLfF1NwQHV85k
	 mxHMuq20xsXssT8YsWREp3hfsQj0i4t3/HjQN4uDd2Zrp3ChxeMrso1d+SWCWRTxGq
	 hukkIYNdkjhRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Frank Li <Frank.Li@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] pmdomain: imx: Fix reference count leak in imx_gpc_probe()
Date: Tue,  6 Jan 2026 13:26:54 -0500
Message-ID: <20260106182656.3115094-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106182656.3115094-1-sashal@kernel.org>
References: <2026010515-quaking-outlook-7f2c@gregkh>
 <20260106182656.3115094-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 73cb5f6eafb0ac7aea8cdeb8ff12981aa741d8fb ]

of_get_child_by_name() returns a node pointer with refcount incremented.
Use the __free() attribute to manage the pgc_node reference, ensuring
automatic of_node_put() cleanup when pgc_node goes out of scope.

This eliminates the need for explicit error handling paths and avoids
reference count leaks.

Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/imx/gpc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 18f58e321ea8..fa5006aa2120 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -405,13 +405,12 @@ static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap,
 static int imx_gpc_probe(struct platform_device *pdev)
 {
 	const struct imx_gpc_dt_data *of_id_data = device_get_match_data(&pdev->dev);
-	struct device_node *pgc_node;
+	struct device_node *pgc_node __free(device_node)
+		= of_get_child_by_name(pdev->dev.of_node, "pgc");
 	struct regmap *regmap;
 	void __iomem *base;
 	int ret;
 
-	pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
-
 	/* bail out if DT too old and doesn't provide the necessary info */
 	if (!of_property_read_bool(pdev->dev.of_node, "#power-domain-cells") &&
 	    !pgc_node)
-- 
2.51.0


