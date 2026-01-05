Return-Path: <stable+bounces-204842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D89CCF4E3D
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 18:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C95731FA9C1
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 16:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1D13358A8;
	Mon,  5 Jan 2026 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+e9nCj+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D05C309EE7
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627897; cv=none; b=PQe1E0xrg54Dk5nJ5BU0YzdivRaqA8huMqOOkrCayxTSs1dYjBjGOgn9aSi80WpxqFJz6Vw2WAYrbFBes9KOR7CCKIg5CxkigND2eUKxOT4l6PY7pIm0qTtOX73RplvhjImEXky+aFoHQIS7rY33cm3H6HcX+W7Ui44tcc5hfwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627897; c=relaxed/simple;
	bh=ZoY5uE1GXsrj+iLy9y64UiywNs+xqgxaF7UZKXPJA7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBqgfA0zHn2BZe7TE2fCZzTuzlGuvvzUToSaeF48TDC1OqFOS5pRNPIfOyBEi2O72qFXp4bqo9YS7dlquClYLnBf8KbDk5EzSmR5Hkhy9OXqobp+hcsnG9JqWhPTJOj5JD462fcFipJNQrJomFhMdpjAvSAE4b9rAcP/iLePYjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+e9nCj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB9CC116D0;
	Mon,  5 Jan 2026 15:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767627897;
	bh=ZoY5uE1GXsrj+iLy9y64UiywNs+xqgxaF7UZKXPJA7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j+e9nCj+NMRy8ARF3cPGqKFyzo42iLox7kTbmwMDLQseNpedUyeQKQ9s+VWQ/M/Lb
	 JqeXOPBZCK6l0CRHyIrcocaWPLIWuShc4Wnooi4SWL+2++0whlNOXKy2IwHSmotywR
	 G2tclWd4t2SD1s+pOeubgs1xDc4W1/+YKXsTiJezkOdPMC5O0POfqcD0mBhg9q85ci
	 iL7N4ixsb2B72NeMzJm0Diaa4aGor+5WTvIyEAx4lREh1itS+JKpI5XGRl7YJ4mkQM
	 lCDb25JTUGo+oRU/Jorl6p07CQBUa8Bvf+cdSjnc9S94VZwkxhYoKOkhZgEinWd7uu
	 iw2nKrUrU4YlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] iommu/qcom: Use the asid read from device-tree if specified
Date: Mon,  5 Jan 2026 10:44:51 -0500
Message-ID: <20260105154453.2644685-3-sashal@kernel.org>
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

[ Upstream commit fcf226f1f7083cba76af47bf8dd764b68b149cd2 ]

As specified in this driver, the context banks are 0x1000 apart but
on some SoCs the context number does not necessarily match this
logic, hence we end up using the wrong ASID: keeping in mind that
this IOMMU implementation relies heavily on SCM (TZ) calls, it is
mandatory that we communicate the right context number.

Since this is all about how context banks are mapped in firmware,
which may be board dependent (as a different firmware version may
eventually change the expected context bank numbers), introduce a
new property "qcom,ctx-asid": when found, the ASID will be forced
as read from the devicetree.

When "qcom,ctx-asid" is not found, this driver retains the previous
behavior as to avoid breaking older devicetrees or systems that do
not require forcing ASID numbers.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
[Marijn: Rebased over next-20221111]
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230622092742.74819-3-angelogioacchino.delregno@collabora.com
Signed-off-by: Will Deacon <will@kernel.org>
Stable-dep-of: 6a3908ce56e6 ("iommu/qcom: fix device leak on of_xlate()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 72cc66ffab67..dd8d5e2f3c08 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -563,7 +563,8 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	 * index into qcom_iommu->ctxs:
 	 */
 	if (WARN_ON(asid < 1) ||
-	    WARN_ON(asid > qcom_iommu->num_ctxs)) {
+	    WARN_ON(asid > qcom_iommu->num_ctxs) ||
+	    WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL)) {
 		put_device(&iommu_pdev->dev);
 		return -EINVAL;
 	}
@@ -650,7 +651,8 @@ static int qcom_iommu_sec_ptbl_init(struct device *dev)
 
 static int get_asid(const struct device_node *np)
 {
-	u32 reg;
+	u32 reg, val;
+	int asid;
 
 	/* read the "reg" property directly to get the relative address
 	 * of the context bank, and calculate the asid from that:
@@ -658,7 +660,17 @@ static int get_asid(const struct device_node *np)
 	if (of_property_read_u32_index(np, "reg", 0, &reg))
 		return -ENODEV;
 
-	return reg / 0x1000;      /* context banks are 0x1000 apart */
+	/*
+	 * Context banks are 0x1000 apart but, in some cases, the ASID
+	 * number doesn't match to this logic and needs to be passed
+	 * from the DT configuration explicitly.
+	 */
+	if (!of_property_read_u32(np, "qcom,ctx-asid", &val))
+		asid = val;
+	else
+		asid = reg / 0x1000;
+
+	return asid;
 }
 
 static int qcom_iommu_ctx_probe(struct platform_device *pdev)
-- 
2.51.0


