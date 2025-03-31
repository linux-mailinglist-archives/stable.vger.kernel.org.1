Return-Path: <stable+bounces-127240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B28A76A30
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 181E57A2A4A
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA2124C068;
	Mon, 31 Mar 2025 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1ZFcJ5S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0896E24BD1A;
	Mon, 31 Mar 2025 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433017; cv=none; b=Uywlr81nOtXYxKMnKVFUExMvJvD7eyFYWR7Phoh/hjxpkD3svcAY6PRCCkDyAtco9MaH9m9eIlQQ444FJ4+uPwmqToMiiAUtN7bWPr/369TPLEhk0dMvRIgXi9eQgaVfBQBtPLUaB8WmGFHbLZYMDvtNVOn4nhJTSVUyBbcRaSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433017; c=relaxed/simple;
	bh=Cm1Em4GVh5UN3KC7kQilCOySbGi3rdIYc+i4/iSCYXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fSrYaTfS2UicKdY4Xc+HDLb01R0zSdOVy3mBnEmzgBvJ6lF8KJY9kJYD5rYz89xcIYzqSMDnXziLbeks7mBKH7vy6Y4knEmoo7v6dSUTdSpCYP35Fx0fopuqqDsd0MpzUzpEEjqKvJv0tL1IQII4rgJc7aS+T+9pasou1uPIPcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1ZFcJ5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D434C4CEE9;
	Mon, 31 Mar 2025 14:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743433016;
	bh=Cm1Em4GVh5UN3KC7kQilCOySbGi3rdIYc+i4/iSCYXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S1ZFcJ5SD66wA5lwxt/Mke2xihUTvVhzi5lTxYGwCj/Yq0lHiu1TkCE7uvLSyhRJ+
	 EefeokeNPLqwMTDFUkSiRNhqLk9zSfjR5kK5QM6DMboc1zNzJWiGzEjx7qh+4TJkvv
	 Pu6O9XQrjnP1kDjRFnMUuDrFYdzMY4BRGRbc2e2SmRDVXLqgfBCDKuybm1nExzgRZa
	 VeToPEj8sISu1C0OvL8llQzcuQiLKu91dB/Gc73I51NQsHGgV6ykKYPYpfByQC4b4k
	 wAu6XNrU2l5Q4Bu2SL/4xtZ98PpyuskrhR5CVMisjQU2G6TrbuHdjvFUUH3bC+7tr/
	 SyLjDvs5aEy4g==
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
Subject: [PATCH AUTOSEL 6.1 6/9] ASoC: fsl_audmix: register card device depends on 'dais' property
Date: Mon, 31 Mar 2025 10:56:39 -0400
Message-Id: <20250331145642.1706037-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145642.1706037-1-sashal@kernel.org>
References: <20250331145642.1706037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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
index 672148dd4b234..acb499a5043c8 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -492,11 +492,17 @@ static int fsl_audmix_probe(struct platform_device *pdev)
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


