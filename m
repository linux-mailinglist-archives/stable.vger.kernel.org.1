Return-Path: <stable+bounces-174988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2190B3669D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AB71744F0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEE32BF019;
	Tue, 26 Aug 2025 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="USiMs1jh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16772FDC5C;
	Tue, 26 Aug 2025 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215845; cv=none; b=EVFCJJiY5FpexMkbOwtqPndShVmn/tYaSXNPap2RpgeQ4mdAzaftI7LYJKgIamv8C2e436TATFNr0tkzs0qCpa4frmHzeMfWegNNMw1zLVGtewRhjU+uPvjWzghfM8CCCySG8TIEA/6iWpVX6pUMATPEy9f1OYzkhLMMhY35xPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215845; c=relaxed/simple;
	bh=N75kTO/57jUPD7suIaVEv7E2XAIEjwfwlAduqjavVvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvDabpXofLDCQEbqcgC7JuBWDDJUTYjdVj3eKcMWTAtJA2erLbBxLOzr2DjUtDbV1TyV/sXFRnWR5YYimqVfYmnwK5req+mTN+avHlCfrtxX5dTlc0Aytizo0XKl8ZClFBJdCEBjhGEb8DSjcUm2m/rAhTmjqS3izfdWnGCw7bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=USiMs1jh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454D4C4CEF1;
	Tue, 26 Aug 2025 13:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756215844;
	bh=N75kTO/57jUPD7suIaVEv7E2XAIEjwfwlAduqjavVvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=USiMs1jhQM1usJ8+Czq+54GMPiRsbIOG7Oq71gTLjrHWql7yZvg0R/bMLWOWoPW82
	 ntyKdHhIfLD3DkgtXxwUwVyyZhUwDroH4U0JepkJz0SwwVehPYEwrThwkeriArnW1O
	 /mgkchYKJH4f72TRsgeJYvlcREIuxYPoRK1kmv4c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ovidiu Panait <ovidiu.panait.oss@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 187/644] hwrng: mtk - handle devm_pm_runtime_enable errors
Date: Tue, 26 Aug 2025 13:04:38 +0200
Message-ID: <20250826110951.095161067@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>

[ Upstream commit 522a242a18adc5c63a24836715dbeec4dc3faee1 ]

Although unlikely, devm_pm_runtime_enable() call might fail, so handle
the return value.

Fixes: 78cb66caa6ab ("hwrng: mtk - Use devm_pm_runtime_enable")
Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/mtk-rng.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/mtk-rng.c b/drivers/char/hw_random/mtk-rng.c
index 3e00506543b6..72269d0f2a4e 100644
--- a/drivers/char/hw_random/mtk-rng.c
+++ b/drivers/char/hw_random/mtk-rng.c
@@ -142,7 +142,9 @@ static int mtk_rng_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, priv);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, RNG_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
-	devm_pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
 
 	dev_info(&pdev->dev, "registered RNG driver\n");
 
-- 
2.39.5




