Return-Path: <stable+bounces-47534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2B08D11C9
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 04:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5BB2847F4
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECC845025;
	Tue, 28 May 2024 02:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlBX++05"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B7A45014;
	Tue, 28 May 2024 02:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862740; cv=none; b=M20MCHz1Z8Tki81FZWf5KRIgcflQ5wXxi7//hR7wFBuC0OUjYlup8gxxBO+ZtWlDP2XefUNgS0S4PVvM07j60k4kUzqa+eOzUCoSMhCMLQji9MSXWOMe2sxei6YP31U3SV10KcRDt5fT13D6NsT2kVM/0R/RQrGcJvmk0h0URwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862740; c=relaxed/simple;
	bh=FkF55kAlBFnm9+dFSHTksJBVZbfvnY9pVa58m7DS6DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ehvguj4OqrK28IwKLUbIJB6ViLxfEPo5e3eDEoatneWoFBWRQQlHnNHLbr3PnahGNVzTKJVTn1cChXEKL3TV6dTd1ngnTgNxMBjTdmp9v3wkRthqTyyKVe5C1wG+kgT90k8obL6rlvgAKZsESH5MuHN9M7jJJz76LGZLWbWbN+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlBX++05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DABC4AF07;
	Tue, 28 May 2024 02:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716862740;
	bh=FkF55kAlBFnm9+dFSHTksJBVZbfvnY9pVa58m7DS6DY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SlBX++05iuPLN3XquCkczYtNfuo9QI0Ts+A/wdGDpW14AX+TG05DVbSzB2mQLo5aa
	 4gspa60iiz2owfbFc5mr8VVkMFOehi8BUejP9MTHp2wclz9qkGeHlOZ40Jl24zU19B
	 Ii1pE+KR4gJLz+qrTpcf1V17EAwKhvRqgypISFZx6dSjS8zm6XYuUQgoWLEkwz5C+e
	 WDJlAFBqXH7vUA89u2vwt67UxghSsVmd5sjP2jb0I2eKE9jvR0gtghl0er93SBdR+k
	 A5HRWonmmSbE2MbIBurOqMc6tHn6t/BGGv3B584o/kpy4lO1vbhFKZ8ejcjFDE13TA
	 ag0m6L7fLpEOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksandr Aprelkov <aaprelkov@usergate.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 6.6 2/4] iommu/arm-smmu-v3: Free MSIs in case of ENOMEM
Date: Mon, 27 May 2024 22:18:51 -0400
Message-ID: <20240528021854.3905245-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528021854.3905245-1-sashal@kernel.org>
References: <20240528021854.3905245-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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
index bd0a596f9863a..68b81f9c2f4b1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3193,7 +3193,7 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
 
 	/* Add callback to free MSIs on teardown */
-	devm_add_action(dev, arm_smmu_free_msis, dev);
+	devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);
 }
 
 static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
-- 
2.43.0


