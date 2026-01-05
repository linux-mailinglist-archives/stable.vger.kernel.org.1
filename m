Return-Path: <stable+bounces-204841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA73CF4D3F
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 17:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB482304D48B
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E440D313557;
	Mon,  5 Jan 2026 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMbKwi8F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58F2309EE7
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627896; cv=none; b=NbpSNs9421yksKzVphByu9ebmrVMTnpsCx8IfRdwYGkhvDpC4Cc1ai4t28nYmJFj/vANWYXqmGS0QS59yuMEgwuBOpV7l9hekkHQZAlEApySClXUZ2IhxgDByZ1jCx98i8dSqls4daTyABPQnRkCdAbv/aAdtXVM15eybIl2vc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627896; c=relaxed/simple;
	bh=KkcpFw0MzrkSQu3RYVYJRVKln69xoRBjlifiHXpbHPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNN3WHreUrvnqs+g2cPbq5pOmSUHdWTCXgewy8KrS29pWxDZ+q/wyM6Tgy/3T+WamPJ4tBDzGjHg09388ds2RkzA+q19/HRwxpYmBJksqO2UVH27uqm65QvYIUzEkV5qhgfe0wCfZZkZ6evBa+iNSqxPVS/e1VFB03rSh7y3Mak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMbKwi8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94B3C19421;
	Mon,  5 Jan 2026 15:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767627896;
	bh=KkcpFw0MzrkSQu3RYVYJRVKln69xoRBjlifiHXpbHPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GMbKwi8Fzvd9S+jg3iU5MpORCQ9voXzVlkoLS2Ml/GDC81KSd48aWuP678NmLl/ne
	 IgKwgYcknVeJaY+sXhiAMHy5Sh/l6JJGJ6K5foIKSbHH+ipc9C5QLr2FLjVl22ym5u
	 jq0Q8yXWkIE/5C1Uo80gC9qpTm7RUIAwk+6xJkZjUnWlrvbPUmms+nhQ1XkrQ+jRfK
	 ZGFlzayXEElRb/5/IGnHawh6pTxYrQeglfeSMC+G9Wpo0AJFXsf1zAwgolY+6nqKdL
	 mH8NyCdVrLRdl1kuTges6gbZxWkfV3z69Bs3AYLp3eZWdTij7MfcI+WjDbTDl6TDqn
	 vO8M7W2OSzwdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] iommu/arm-smmu: Convert to platform remove callback returning void
Date: Mon,  5 Jan 2026 10:44:50 -0500
Message-ID: <20260105154453.2644685-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105154453.2644685-1-sashal@kernel.org>
References: <2026010519-padlock-footman-35a7@gregkh>
 <20260105154453.2644685-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 62565a77c2323d32f2be737455729ac7d3efe6ad ]

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
Link: https://lore.kernel.org/r/20230321084125.337021-5-u.kleine-koenig@pengutronix.de
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Stable-dep-of: 6a3908ce56e6 ("iommu/qcom: fix device leak on of_xlate()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c   |  6 ++----
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 12 ++++--------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index fcd2cfd12e7f..96a4ae3fc778 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2225,7 +2225,7 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
 }
 
-static int arm_smmu_device_remove(struct platform_device *pdev)
+static void arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
@@ -2233,8 +2233,6 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&smmu->iommu);
 
 	arm_smmu_device_shutdown(pdev);
-
-	return 0;
 }
 
 static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
@@ -2310,7 +2308,7 @@ static struct platform_driver arm_smmu_driver = {
 		.suppress_bind_attrs    = true,
 	},
 	.probe	= arm_smmu_device_probe,
-	.remove	= arm_smmu_device_remove,
+	.remove_new = arm_smmu_device_remove,
 	.shutdown = arm_smmu_device_shutdown,
 };
 module_platform_driver(arm_smmu_driver);
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 5b9cb9fcc352..72cc66ffab67 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -715,7 +715,7 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int qcom_iommu_ctx_remove(struct platform_device *pdev)
+static void qcom_iommu_ctx_remove(struct platform_device *pdev)
 {
 	struct qcom_iommu_dev *qcom_iommu = dev_get_drvdata(pdev->dev.parent);
 	struct qcom_iommu_ctx *ctx = platform_get_drvdata(pdev);
@@ -723,8 +723,6 @@ static int qcom_iommu_ctx_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 
 	qcom_iommu->ctxs[ctx->asid - 1] = NULL;
-
-	return 0;
 }
 
 static const struct of_device_id ctx_of_match[] = {
@@ -739,7 +737,7 @@ static struct platform_driver qcom_iommu_ctx_driver = {
 		.of_match_table	= ctx_of_match,
 	},
 	.probe	= qcom_iommu_ctx_probe,
-	.remove = qcom_iommu_ctx_remove,
+	.remove_new = qcom_iommu_ctx_remove,
 };
 
 static bool qcom_iommu_has_secure_context(struct qcom_iommu_dev *qcom_iommu)
@@ -857,7 +855,7 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_iommu_device_remove(struct platform_device *pdev)
+static void qcom_iommu_device_remove(struct platform_device *pdev)
 {
 	struct qcom_iommu_dev *qcom_iommu = platform_get_drvdata(pdev);
 
@@ -865,8 +863,6 @@ static int qcom_iommu_device_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 	iommu_device_sysfs_remove(&qcom_iommu->iommu);
 	iommu_device_unregister(&qcom_iommu->iommu);
-
-	return 0;
 }
 
 static int __maybe_unused qcom_iommu_resume(struct device *dev)
@@ -903,7 +899,7 @@ static struct platform_driver qcom_iommu_driver = {
 		.pm		= &qcom_iommu_pm_ops,
 	},
 	.probe	= qcom_iommu_device_probe,
-	.remove	= qcom_iommu_device_remove,
+	.remove_new = qcom_iommu_device_remove,
 };
 
 static int __init qcom_iommu_init(void)
-- 
2.51.0


