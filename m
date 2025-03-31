Return-Path: <stable+bounces-127248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DAEA76A46
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DCAE7A13F4
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E51724EF7D;
	Mon, 31 Mar 2025 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvuMym4U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A9924EF72;
	Mon, 31 Mar 2025 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433034; cv=none; b=fES6SAOGwDVS3LHoH0xCSKhUBh1jTLRGKrwDKPvKjo5jWdbf4J7bvtkLPRjSKNS49inVf4xxucEb9VGSGE719reolXj6j7pxiOUhNtiBiqMJwlR7ILZ8pjqUT1mwy0WZVR4ly0YrzpBzWXtZLJnkG1oZBfaXv/YTYTwQm0an1yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433034; c=relaxed/simple;
	bh=wH6f4F38u0npLk501yQtj1sSIBotIvDuvAx2q/Ip+sU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qi23ao5aQh6BE8aYt4ch6THA4rjyj62wru2LZ01UrELAj35d552EDNwXum0O5CPyP9vC1AHfKzPMvwkQlujcm3t2PHJNDrbvlHqr0uoX+gztMElEnv963edgaziUA9I2j8VwmgpJ4QGoHuKHD5auGFhzCVrgwGJVHbf/P2JHCsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvuMym4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BA5C4CEE3;
	Mon, 31 Mar 2025 14:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743433034;
	bh=wH6f4F38u0npLk501yQtj1sSIBotIvDuvAx2q/Ip+sU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VvuMym4Uck6F55xT8LrL9/BlKd7DEzCVSRDAJ7fOe0KP2NX3tpyUD2mAhigsuxNZt
	 PfP4/1IUvz4jVRYh92yt3L5xgUTO9uJfRt+v7vSUggIa89MXRE28q647PZY37d5mtw
	 DWc03GCT3gg1WC4IZa92cMp+QbGlqtpLY/JKg0YuZ4iMOGG+5zd38jcf4AYW8cfHRE
	 KW87cPJoSJb88JeJ/D6xRbnzM3AlNfeR2VHppMUs3SkQAB2a+MlSo/Xhai2QaRCnOL
	 2NoGAQJW0wOTbSXGzFVdy5HUQ4z9y1d/NQa77xC5fWpEHjiQ8VKGnV/9MlRYoY+rDv
	 U9QF8gTybyX1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.15 5/6] ASoC: fsl_audmix: register card device depends on 'dais' property
Date: Mon, 31 Mar 2025 10:57:02 -0400
Message-Id: <20250331145703.1706165-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145703.1706165-1-sashal@kernel.org>
References: <20250331145703.1706165-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
Content-Transfer-Encoding: 8bit

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 294a60e5e9830045c161181286d44ce669f88833 ]

In order to make the audmix device linked by audio graph card, make
'dais' property to be optional.

If 'dais' property exists, then register the imx-audmix card driver.
otherwise, it should be linked by audio graph card.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://patch.msgid.link/20250226100508.2352568-5-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_audmix.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index f931288e256ca..9c46b25cc6541 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -500,11 +500,17 @@ static int fsl_audmix_probe(struct platform_device *pdev)
 		goto err_disable_pm;
 	}
 
-	priv->pdev = platform_device_register_data(dev, "imx-audmix", 0, NULL, 0);
-	if (IS_ERR(priv->pdev)) {
-		ret = PTR_ERR(priv->pdev);
-		dev_err(dev, "failed to register platform: %d\n", ret);
-		goto err_disable_pm;
+	/*
+	 * If dais property exist, then register the imx-audmix card driver.
+	 * otherwise, it should be linked by audio graph card.
+	 */
+	if (of_find_property(pdev->dev.of_node, "dais", NULL)) {
+		priv->pdev = platform_device_register_data(dev, "imx-audmix", 0, NULL, 0);
+		if (IS_ERR(priv->pdev)) {
+			ret = PTR_ERR(priv->pdev);
+			dev_err(dev, "failed to register platform: %d\n", ret);
+			goto err_disable_pm;
+		}
 	}
 
 	return 0;
-- 
2.39.5


