Return-Path: <stable+bounces-204843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F3CCF4E37
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 18:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6B8E31C20C0
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF483375D0;
	Mon,  5 Jan 2026 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugdK3pM3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72A3064AA
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627898; cv=none; b=sCk4ew6rwlpf+pHBH2HSTSHQ/mRX2GjIno7JLBtofZefISvBxRHfR8Ckpl+cAlAPPgey2QZFvWPxylSj/RJK8s0zSZ7g4/Y1biDBmWrTIRJiK5qli3jK1ZhRIjY1/0A5CmJEZ1YAvnHKN5HbsNbp39T4/awsWNxMlBvTdUhF7/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627898; c=relaxed/simple;
	bh=5CjqN1D8OV8gtJ+CnwZ9ZBqtYbeRCWqAfruI3GCaGB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i71y/6qgcRc0Ueks4tFGWOIYDfaVMXjwX5qukgcE0bEiNmm6LY/jjrMxL/FB5GB3KG0kNXSoWw8wJXQwSF+jfqdFULZgONx5GMbtBdhvhRSiyOH6OnPZcteSFTlNt5PWEny97Bafvs/vG91c/Ct6XpOxyiWpSjE2/caLp2+zhgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugdK3pM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEB6C19421;
	Mon,  5 Jan 2026 15:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767627898;
	bh=5CjqN1D8OV8gtJ+CnwZ9ZBqtYbeRCWqAfruI3GCaGB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ugdK3pM3dg0MH0XamuSsN0/aCwAUTPst6oXW7iOKMsqTvUZ8q1G/6M0go1yLZAQC4
	 +fjCtLZwKvEw1mkB24omNC67WQX7DtcpPCHuV9DAwCALCQHqKRd/NTw1hj08lP9N/j
	 Dnfpt8dnHCBd0DzjbrwcQ8rltaitVD9WBMdZCdMSsh0bA4vMZoJhSRksZ60AtbuOsg
	 PAnELj0ygdFci/ZDpyzeHPITLqMBwuzf/tmqr/01c27eWvO0YxqEEnOc0PRp+wHyVP
	 RazRO0YUT8sRXJiEXODWaenCYOGNwu6NllKDql0BF/WbNJFmrvGaZnLR3TvxLujp4R
	 IKrgMEDZnVHcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] iommu/qcom: Index contexts by asid number to allow asid 0
Date: Mon,  5 Jan 2026 10:44:52 -0500
Message-ID: <20260105154453.2644685-4-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit ec5601661bfcdc206e6ceba1b97837e763dab1ba ]

This driver was indexing the contexts by asid-1, which is probably
done under the assumption that the first ASID is always 1.
Unfortunately this is not always true: at least for MSM8956 and
MSM8976's GPU IOMMU, the gpu_user context's ASID number is zero.
To allow using a zero asid number, index the contexts by `asid`
instead of by `asid - 1`.

While at it, also enhance human readability by renaming the
`num_ctxs` member of struct qcom_iommu_dev to `max_asid`.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230622092742.74819-5-angelogioacchino.delregno@collabora.com
Signed-off-by: Will Deacon <will@kernel.org>
Stable-dep-of: 6a3908ce56e6 ("iommu/qcom: fix device leak on of_xlate()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index dd8d5e2f3c08..0c27de3fd2f6 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -51,8 +51,8 @@ struct qcom_iommu_dev {
 	struct clk_bulk_data clks[CLK_NUM];
 	void __iomem		*local_base;
 	u32			 sec_id;
-	u8			 num_ctxs;
-	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid-1 */
+	u8			 max_asid;
+	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid */
 };
 
 struct qcom_iommu_ctx {
@@ -94,7 +94,7 @@ static struct qcom_iommu_ctx * to_ctx(struct qcom_iommu_domain *d, unsigned asid
 	struct qcom_iommu_dev *qcom_iommu = d->iommu;
 	if (!qcom_iommu)
 		return NULL;
-	return qcom_iommu->ctxs[asid - 1];
+	return qcom_iommu->ctxs[asid];
 }
 
 static inline void
@@ -559,12 +559,10 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	qcom_iommu = platform_get_drvdata(iommu_pdev);
 
 	/* make sure the asid specified in dt is valid, so we don't have
-	 * to sanity check this elsewhere, since 'asid - 1' is used to
-	 * index into qcom_iommu->ctxs:
+	 * to sanity check this elsewhere:
 	 */
-	if (WARN_ON(asid < 1) ||
-	    WARN_ON(asid > qcom_iommu->num_ctxs) ||
-	    WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL)) {
+	if (WARN_ON(asid > qcom_iommu->max_asid) ||
+	    WARN_ON(qcom_iommu->ctxs[asid] == NULL)) {
 		put_device(&iommu_pdev->dev);
 		return -EINVAL;
 	}
@@ -722,7 +720,7 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
 
 	dev_dbg(dev, "found asid %u\n", ctx->asid);
 
-	qcom_iommu->ctxs[ctx->asid - 1] = ctx;
+	qcom_iommu->ctxs[ctx->asid] = ctx;
 
 	return 0;
 }
@@ -734,7 +732,7 @@ static void qcom_iommu_ctx_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 
-	qcom_iommu->ctxs[ctx->asid - 1] = NULL;
+	qcom_iommu->ctxs[ctx->asid] = NULL;
 }
 
 static const struct of_device_id ctx_of_match[] = {
@@ -781,11 +779,11 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	for_each_child_of_node(dev->of_node, child)
 		max_asid = max(max_asid, get_asid(child));
 
-	qcom_iommu = devm_kzalloc(dev, struct_size(qcom_iommu, ctxs, max_asid),
+	qcom_iommu = devm_kzalloc(dev, struct_size(qcom_iommu, ctxs, max_asid + 1),
 				  GFP_KERNEL);
 	if (!qcom_iommu)
 		return -ENOMEM;
-	qcom_iommu->num_ctxs = max_asid;
+	qcom_iommu->max_asid = max_asid;
 	qcom_iommu->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.51.0


