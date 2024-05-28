Return-Path: <stable+bounces-47538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E4B8D11D6
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 04:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F18D283B4B
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 02:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFD04F5FB;
	Tue, 28 May 2024 02:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+w/Z6Jp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DE44D59B;
	Tue, 28 May 2024 02:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862754; cv=none; b=Bl1M5vVWXdgsGyBCtFVXyyS8v7VTQe1qEOPR5l2fcO09sjFGNx+unRXtJoIiwTjmvpye1D7Svq4qVTbnabBx9ASbS8eOFU3Aw7Oo0gQAXAjGrH9Hq1l0Dy3tJFra9hj63huJp3W9dObdI+NpSfPpiiw7vzRs3M4Aeseyuv0jwwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862754; c=relaxed/simple;
	bh=Ai6O9eTJDkIJpA+tWGRVeg1IerME6NvfCXXrdyN+IMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y22fWyCo3tCD8u8NtsykH95gBkl7HxAqz/jnoR/lHXjVlWrRl/iHQzwu9mjnbd7in7rPNr5SzNFOM5XqmUhwnkCRO8BR9wIxYf4cJ7CMlaTEQa8wOD+yBuvjL8x7lv71DdFOVp3D2EGKoRhC9eWh5LfGvANTb83TirMOLmCAoMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+w/Z6Jp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7A5C32782;
	Tue, 28 May 2024 02:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716862754;
	bh=Ai6O9eTJDkIJpA+tWGRVeg1IerME6NvfCXXrdyN+IMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q+w/Z6JpuE209eFa5NNftiPXvA5uFt6zEQp9rqQBNKx0wAMinR+Faz9f6nRD62gW/
	 DnkqihegSACJ5KSp1nmvPuXeEdE+4wLPzQZDXMMHf/bl5X2tM+ib7COSxHKHtCuW9Q
	 2WaTiU6T+BjN1EpEflTBey8/8p0ixqmnVHFoDlP7H2KVS456fsJsANKM/M7xsYx7Wy
	 kMSzKtKQ9a5uAihAr6/WJtTMjoz8WkqRmI0BNotTJgJFG3jifJTk+FFU/D/SArJp8S
	 SI7nQnI4YBAyO56KxVdQ+r2MaSvUk9DJymRrdQ2g/GkA73R4bv7xd9qtH+z7gTrvM3
	 Al+QS+nSEmeDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksandr Aprelkov <aaprelkov@usergate.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 6.1 2/2] iommu/arm-smmu-v3: Free MSIs in case of ENOMEM
Date: Mon, 27 May 2024 22:19:08 -0400
Message-ID: <20240528021909.3905362-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528021909.3905362-1-sashal@kernel.org>
References: <20240528021909.3905362-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
Content-Transfer-Encoding: 8bit

From: Aleksandr Aprelkov <aaprelkov@usergate.com>

[ Upstream commit 80fea979dd9d48d67c5b48d2f690c5da3e543ebd ]

If devm_add_action() returns -ENOMEM, then MSIs are allocated but not
not freed on teardown. Use devm_add_action_or_reset() instead to keep
the static analyser happy.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
Link: https://lore.kernel.org/r/20240403053759.643164-1-aaprelkov@usergate.com
[will: Tweak commit message, remove warning message]
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 82f100e591b5a..45b43f729f895 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3199,7 +3199,7 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
 
 	/* Add callback to free MSIs on teardown */
-	devm_add_action(dev, arm_smmu_free_msis, dev);
+	devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);
 }
 
 static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
-- 
2.43.0


