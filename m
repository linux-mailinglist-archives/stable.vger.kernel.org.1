Return-Path: <stable+bounces-90150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D96F59BE6F0
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7758FB25536
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217D41DF254;
	Wed,  6 Nov 2024 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MwktbXgB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E61DEFF4;
	Wed,  6 Nov 2024 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894921; cv=none; b=U/GMTEtqc3g3Xol/v6+iqvkKtUduVy3Y0ZlAWAzOmhZlCx/lwg9f7FW7BXoOgl4N03l3S36K9gOn/7mev8cvPCdtYLaSWey0GlthDrVxunm3vnrt0UC/AWlMtYlsPY0IgcV7d3lqcQktCgA7vn+JqsVuZl6i6yHwszOEeq2ZOss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894921; c=relaxed/simple;
	bh=HculaqOZCXPEqCQJpCR0vepg+opukch91pxKmaAZAXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdoFXKuSXUi+aUuaR3NOLOtoGn2TCClvbslbgoGxjnmnyN3dYV0embzbGbv4/VBR6XMEEleoyzNPhtQA9TgUQX+ftS21tVhd7MZ/AlOCAGYmYvSW20C8LMZ2ud5sMo3RfMyCP87tVPG1caXZ/75tRwrtKIW5CI6OeisRMF7cUBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MwktbXgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA703C4CECD;
	Wed,  6 Nov 2024 12:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730894921;
	bh=HculaqOZCXPEqCQJpCR0vepg+opukch91pxKmaAZAXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MwktbXgBzWBVq7Inw94/RoP1Jn0rrb3j+dcS60sI0fjJkYpxl3A/TgROxSJuSYlNh
	 LIbPP0b2qOT30AIvFNrVITJFZtyid30fTJGRRP4MNUlCqvpEpsZALHNuWXaVXqeQ/F
	 1vMyuFqLsbKrf1KBuvA4cVJvIFxxAbuZJQ0iDGl4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 043/350] reset: berlin: fix OF node leak in probe() error path
Date: Wed,  6 Nov 2024 12:59:31 +0100
Message-ID: <20241106120321.950791083@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 5f58a88cc91075be38cec69b7cb70aaa4ba69e8b ]

Driver is leaking OF node reference on memory allocation failure.
Acquire the OF node reference after memory allocation to fix this and
keep it simple.

Fixes: aed6f3cadc86 ("reset: berlin: convert to a platform driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20240825-reset-cleanup-scoped-v1-1-03f6d834f8c0@linaro.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/reset/reset-berlin.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-berlin.c b/drivers/reset/reset-berlin.c
index 371197bbd0556..542d32719b8ae 100644
--- a/drivers/reset/reset-berlin.c
+++ b/drivers/reset/reset-berlin.c
@@ -68,13 +68,14 @@ static int berlin_reset_xlate(struct reset_controller_dev *rcdev,
 
 static int berlin2_reset_probe(struct platform_device *pdev)
 {
-	struct device_node *parent_np = of_get_parent(pdev->dev.of_node);
+	struct device_node *parent_np;
 	struct berlin_reset_priv *priv;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	parent_np = of_get_parent(pdev->dev.of_node);
 	priv->regmap = syscon_node_to_regmap(parent_np);
 	of_node_put(parent_np);
 	if (IS_ERR(priv->regmap))
-- 
2.43.0




