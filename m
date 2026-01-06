Return-Path: <stable+bounces-206021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C8ACFA76F
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 20:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33EA234A110B
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E99361DDF;
	Tue,  6 Jan 2026 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9oAmI7A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4A31E531
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767723027; cv=none; b=YsTOJ8gqgCvCuFvvdWgfToe+cwwbbvUuOBwxWP3hRgDDlWzN/v0I87KtlJesIA4mzpqlCD8k79Jk53vZVvmhmDT4h687908rhhJ+/q+K1zjvMu6F/d6MLbMUMI1cSrb8jJFHyrlAedLk9+ylT7VmBMSwyY3qzMB/jzO635UJKTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767723027; c=relaxed/simple;
	bh=mkbG6+SAMqt4o1H84ykdfkdcOSRDbglrpabALzmTI64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYD1nWNqxfcG1cm27OscAxECp04k++hkmP49CrXtxMYy3XFl5fsIJOHacFdSl9EQ+Ylz3aQemSTyB9rYj01A4huxci5G5vUWqNHtnkw+uks3F67QMUOtqnHmWwAK+G/FUuj0OXBtQck+zsN4E7g4DsZjN0nxKWVmbiag1ibXwks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9oAmI7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E20C19423;
	Tue,  6 Jan 2026 18:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767723026;
	bh=mkbG6+SAMqt4o1H84ykdfkdcOSRDbglrpabALzmTI64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D9oAmI7A5oDcbMKSxySYYum7/dXUy4Rf7euOUSuGpqEhRkdg/zRAl/v8COVfUldLA
	 2o4m7PAfmxbpeRE9ZJ+cBdclnsDNDa1FURVMU726c+DfYB/NZLBCWeyuBu6X3L6sQ4
	 /mhEOg8LCmisEMaGKNg7wqQFOG+a3lFg7/JSi/ZUCzt208mQdIeEep92UXZjlz2u3Y
	 5anzGRQ+gjIprbb6TXwbXrx0qXq1tx24gcF1FFKiui1KD/7CzfYTUJj1t3TNUG9hqL
	 WiWjM0BqyY6FD2PYi94IPfHWWYZAX+elDeVxwex3hrhuGAJbuBryQxswm67EMmuPFb
	 SWdpK2srcaeWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Frank Li <Frank.Li@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] pmdomain: imx: Fix reference count leak in imx_gpc_probe()
Date: Tue,  6 Jan 2026 13:10:16 -0500
Message-ID: <20260106181021.3109327-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106181021.3109327-1-sashal@kernel.org>
References: <2026010515-dragonish-pelican-5b3c@gregkh>
 <20260106181021.3109327-1-sashal@kernel.org>
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


