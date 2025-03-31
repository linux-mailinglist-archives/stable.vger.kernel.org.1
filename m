Return-Path: <stable+bounces-127158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFA7A7695C
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A781891803
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AF622655E;
	Mon, 31 Mar 2025 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppbbQCfZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A7C226527;
	Mon, 31 Mar 2025 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432820; cv=none; b=uSinbttQXtKnn6MsJuEfjHGogYg2s6etlUovdbI4JWnXlTwMP/MySEZ6l16qflClDjG7N+USDmkLQoZiyCl+Q4637gcOJ3GYuam+XiDbQxhWfHY0cyDWoNxAdJ4WGFnMkcuufzciFl01Vhee/udCAi8TWsrMWU2mQ4TCsVA+tcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432820; c=relaxed/simple;
	bh=DofeCn7+p+C7HWB7rPQvFmfiOTP/DSvjSaOvKewTANA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ufGBVfc69tC6YnhU0ZiADvFp4mXcWm9emLyVo5j7gzr/gmpquUcZKda93NNvKseERRiJN85LPl8io5CYPyLc1gfeKWF/Uwv/mwMKvnL7rBJb1khvqkxLbdUz+pbjCfrgztGKDZbGm+RBVCgx8saXzQmPS8vbmTUtGjIVVTWR/tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppbbQCfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0935C4CEE3;
	Mon, 31 Mar 2025 14:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432820;
	bh=DofeCn7+p+C7HWB7rPQvFmfiOTP/DSvjSaOvKewTANA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ppbbQCfZ8FoMwSG+keIfQ1s+9qKb65G/Fb+eqT1EmnK3mauJORmUbO2XFzR7taq/M
	 ORSYzdfPpTQpyJVYQvmjnrMAz3RUFS8OrOhMnWmSspiVAzxLFnUr+l5kC51k6tCWwf
	 jp3ntyeDETPguSeYlv1Btyq/MtOEmsH4CDqIKLcvP4f8CtzsVY6hmHqk8RnKPi4dCq
	 kW9HioM6Bmh9MPAuTMnaG7nCMF59OvjZxWI4VJkXkR3AdrN2u3qR2Vhd9cz4TO91sD
	 xm80222POndyuMn07Xac4uoS4UxpZuqvbpe4w0wh/AC2CnLJgqK8SSNY29uJaPeE5p
	 Q8RFn3kJElUOw==
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
Subject: [PATCH AUTOSEL 6.14 17/27] ASoC: fsl_audmix: register card device depends on 'dais' property
Date: Mon, 31 Mar 2025 10:52:35 -0400
Message-Id: <20250331145245.1704714-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145245.1704714-1-sashal@kernel.org>
References: <20250331145245.1704714-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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
index 3cd9a66b70a15..7981d598ba139 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -488,11 +488,17 @@ static int fsl_audmix_probe(struct platform_device *pdev)
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


