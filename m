Return-Path: <stable+bounces-87847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B3B9ACC78
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13412846B0
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A9C1CEAAD;
	Wed, 23 Oct 2024 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZZGLJl+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD6A1CEAA0;
	Wed, 23 Oct 2024 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693832; cv=none; b=HGlBLcLQErNJ6cHi+zk3ZPsUHGr3pOJe6h5PCgm7yjecEty7ZpNtOwRSohmNIC/emf3fbim20I5LifXmBlI0xnbvX9c87kPJJ0OHJ+UWaFxPwPLzY2QRjkTX+M48Yzqf1yXIVS8v4JHwjhfkm67vcLtpVEmrQtlwwKzQ6o34H0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693832; c=relaxed/simple;
	bh=DTPT4zl44npMYzjERrEH9EvBCMsinVpzO0mfU1W/K+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sve7XZpwVkpb0b7cADg8jEQx4c++gre19nYJoY1+2+5lvspUWUFxqMZEJmXf6cPiCWT33BgoYxpOU0ln8Kybq++CGUE0Q0+9QN0eSt3mpKJGa+Xw3MIHpYP8zAwkN0kVn0bDv5Qo5oWUAcxfVlmokPavfYF3fSh+90KL/mAXIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZZGLJl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5EAC4CEC6;
	Wed, 23 Oct 2024 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693832;
	bh=DTPT4zl44npMYzjERrEH9EvBCMsinVpzO0mfU1W/K+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gZZGLJl+iG9JdNz/tDltYSPBH+P1BzVIeOb+X5mKKGdkSzWrFAIDwkXVngoUfzLxe
	 Txo7XVFgUlnmwc4msYAbE94uBGxmYdHMhO4Qx+psH5nrx8ZAM0PBGGCY+tLvvgULSx
	 VBCfOWwe4kx8U2ICOoQus9DH0OBEc7L+k02XMaA9UBKX4PeyTDqihClw36LggcEoYt
	 RlJbMeDI2IdI4oxEy+mstaLK57kwSWlxi5qnzHMfhOAbl20aMkKJQuIuKhxOcD2ah4
	 Xk6GdgIBTT74600jLyBof/AxR2HNo+cud8fpLegrixWTzdJFo+/VZWRnYoCb4ypW5x
	 inqT+FU0B23ig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 12/30] iommu/arm-smmu: Clarify MMU-500 CPRE workaround
Date: Wed, 23 Oct 2024 10:29:37 -0400
Message-ID: <20241023143012.2980728-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143012.2980728-1-sashal@kernel.org>
References: <20241023143012.2980728-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 0dfe314cdd0d378f96bb9c6bdc05c8120f48606d ]

CPRE workarounds are implicated in at least 5 MMU-500 errata, some of
which remain unfixed. The comment and warning message have proven to be
unhelpfully misleading about this scope, so reword them to get the point
across with less risk of going out of date or confusing users.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/dfa82171b5248ad7cf1f25592101a6eec36b8c9a.1728400877.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index 9dc772f2cbb27..99030e6b16e7a 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -130,7 +130,7 @@ int arm_mmu500_reset(struct arm_smmu_device *smmu)
 
 	/*
 	 * Disable MMU-500's not-particularly-beneficial next-page
-	 * prefetcher for the sake of errata #841119 and #826419.
+	 * prefetcher for the sake of at least 5 known errata.
 	 */
 	for (i = 0; i < smmu->num_context_banks; ++i) {
 		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
@@ -138,7 +138,7 @@ int arm_mmu500_reset(struct arm_smmu_device *smmu)
 		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
 		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
 		if (reg & ARM_MMU500_ACTLR_CPRE)
-			dev_warn_once(smmu->dev, "Failed to disable prefetcher [errata #841119 and #826419], check ACR.CACHE_LOCK\n");
+			dev_warn_once(smmu->dev, "Failed to disable prefetcher for errata workarounds, check SACR.CACHE_LOCK\n");
 	}
 
 	return 0;
-- 
2.43.0


