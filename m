Return-Path: <stable+bounces-110740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E83A1CBFF
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECD61883119
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DEA1F76D8;
	Sun, 26 Jan 2025 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL3cegW/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB21D1F76C5;
	Sun, 26 Jan 2025 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904060; cv=none; b=bjQ5slN8UVBLtoVRForwIqNr5bft5HhAp5DLPdDpaW3MH1X9JBOHjPCVRo+DfAf7kJ1bOsGQaf09uhtlUlK0XfIpNksjnuLO5eIm4qU7IOqv144jyvhJjJp32M9iBrdBCm3miVtRa8BybSM6IaVlNg2SbcIuPMljQCvwItHJ5Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904060; c=relaxed/simple;
	bh=wU4p/1jhFmOpkLwYEez7JQ4/M7aI4yao+Hq6x1njINs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ed/aOkR0YarwOnA0NZ4SjAfOj6CMQizs/bhInjsNBGdl1vt5hkQZRKeCJ3S9Vdtq69N2fbAYHQWOM4R4KeCWwxC30FOT5OAc5nml2W0T/jn61uM+NneEId1KU8Uyn1jmgw9t+drdMlvmhmLP55ZlxeP27AVzA8IY0MSEV0MJjFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mL3cegW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A570C4CED3;
	Sun, 26 Jan 2025 15:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904059;
	bh=wU4p/1jhFmOpkLwYEez7JQ4/M7aI4yao+Hq6x1njINs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mL3cegW/bXM2txhFZa7BL+PQ8WUt9Ew9W9xNTzcw9INy9UbyjbpB/Cbh5MOUG2Rkb
	 dkiUbz6HKIl4b0vM9dzno7RmdrlZDZsApA3hXOl1r2N/VRkGESPp7BL8bEelCtFeZs
	 4CmCST6js0faHpzQEw12CGIM0JOJkJ+bUxiEhBPhZ4ULhGYnMZ/NgNNR+2IXqxaXz5
	 5nZSTAM/2bUnad1rNpfcZTCP9wWG9rGT+bvE9iE7TUZWNbph3fD9htEaQK86VOW/Vs
	 pY37rEmvrakc0TrEtYfXDkQxGEFCWyQVOdZ7M+Pjj5Wj3pCq1P9tfYj9/ADjAlEci0
	 JVWXGUZcfTQAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Richard Acayan <mailingradian@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robdclark@gmail.com,
	joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 05/16] iommu/arm-smmu-qcom: add sdm670 adreno iommu compatible
Date: Sun, 26 Jan 2025 10:07:07 -0500
Message-Id: <20250126150720.961959-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150720.961959-1-sashal@kernel.org>
References: <20250126150720.961959-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Richard Acayan <mailingradian@gmail.com>

[ Upstream commit 42314738906380cbd3b6e9caf3ad34e1b2d66035 ]

Add the compatible for the separate IOMMU on SDM670 for the Adreno GPU.

This IOMMU has the compatible strings:

	"qcom,sdm670-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2"

While the SMMU 500 doesn't need an entry for this specific SoC, the
SMMU v2 compatible should have its own entry, as the fallback entry in
arm-smmu.c handles "qcom,smmu-v2" without per-process page table support
unless there is an entry here. This entry can't be the
"qcom,adreno-smmu" compatible because dedicated GPU IOMMUs can also be
SMMU 500 with different handling.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20241114004713.42404-6-mailingradian@gmail.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 6372f3e25c4bc..601fb878d0ef2 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -567,6 +567,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sc8180x-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_v2_data },
+	{ .compatible = "qcom,sdm670-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sdm845-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sdm845-smmu-500", .data = &sdm845_smmu_500_data },
 	{ .compatible = "qcom,sm6115-smmu-500", .data = &qcom_smmu_500_impl0_data},
-- 
2.39.5


