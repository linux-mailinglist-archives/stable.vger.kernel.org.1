Return-Path: <stable+bounces-204837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 966C7CF4AAE
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 17:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C03B9300C99C
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 16:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A85307AE4;
	Mon,  5 Jan 2026 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="do4RK277"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225F73148DF
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627144; cv=none; b=TdqzOYGWxYclSHa+OKIcbFlzDJWOG8NlqIyPeyfDzrGU+k74x5egXPmo+V+/EwD0IQsy44Jl+8wuWZAcT7P6ICG5MkfsnnwbkEURPtX6uTSrK8AixJlCvKpDr4sb992rew2um7yu4u2MOMBlbutyy31Jt3vfDnIlC6f8nwcrGfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627144; c=relaxed/simple;
	bh=lJN0MaZckvYdamk5cskCDMG5Jeb9pK4RrBv4F4ivbC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ES42HUYBrGhtl0N5HQXvlnPIczIdXJjSArgQJa0rqtqLut0GklkP0DueMAMDvndNXwiKXROKGpj1qKR1P52fg09nRuw68HGWYgz4B0fi1qEZVuMwzGBKNnM+j1DARDmpB5ZXFox1P3A/tABFukd79rxDv76jkwG9OSjULx4HD94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=do4RK277; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCCEC116D0;
	Mon,  5 Jan 2026 15:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767627143;
	bh=lJN0MaZckvYdamk5cskCDMG5Jeb9pK4RrBv4F4ivbC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=do4RK277Jz7W9439wzC6JofEp8WkQ50cLmc4mCUN5A0SF9WntibwW6yIeCjFD66eW
	 Ffg+YNvwSEovUtiRdJY4xoIcnSRxygxlkjg4uJVYXsYddyD/tXCC/PcRjTSa+IcER+
	 i/4KigyejO3iq+B0FEjeliTK2+f9SogSLGsvNS7Roav45GJ1XBgbcpbO2Wp4bSdXxd
	 +Ddp1IqQAqeVivrSejjCVFeYwpbv3i540/ny5fgKQFFJsC+eDp/2dmMXAc+HTLvZdS
	 yQoxE8EqRYc63qTe3osSmCauTs4iz3p2b0hyzWmfDz/EVTZqKp2uNJ18r6p3O2cd4m
	 w0STjBYZwd/fA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] iommu/mtk_iommu_v1: Convert to platform remove callback returning void
Date: Mon,  5 Jan 2026 10:32:19 -0500
Message-ID: <20260105153220.2637603-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010545-bleak-stingily-e2a3@gregkh>
References: <2026010545-bleak-stingily-e2a3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 85e1049e50da9409678fc247ebad4c019d68041f ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230321084125.337021-9-u.kleine-koenig@pengutronix.de
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Stable-dep-of: 46207625c9f3 ("iommu/mediatek-v1: fix device leaks on probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/mtk_iommu_v1.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 5dd06bcb507f..47334c3d41e6 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -706,7 +706,7 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mtk_iommu_v1_remove(struct platform_device *pdev)
+static void mtk_iommu_v1_remove(struct platform_device *pdev)
 {
 	struct mtk_iommu_v1_data *data = platform_get_drvdata(pdev);
 
@@ -716,7 +716,6 @@ static int mtk_iommu_v1_remove(struct platform_device *pdev)
 	clk_disable_unprepare(data->bclk);
 	devm_free_irq(&pdev->dev, data->irq, data);
 	component_master_del(&pdev->dev, &mtk_iommu_v1_com_ops);
-	return 0;
 }
 
 static int __maybe_unused mtk_iommu_v1_suspend(struct device *dev)
@@ -755,7 +754,7 @@ static const struct dev_pm_ops mtk_iommu_v1_pm_ops = {
 
 static struct platform_driver mtk_iommu_v1_driver = {
 	.probe	= mtk_iommu_v1_probe,
-	.remove	= mtk_iommu_v1_remove,
+	.remove_new = mtk_iommu_v1_remove,
 	.driver	= {
 		.name = "mtk-iommu-v1",
 		.of_match_table = mtk_iommu_v1_of_ids,
-- 
2.51.0


