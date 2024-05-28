Return-Path: <stable+bounces-47525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2934A8D11AD
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 04:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D945E2839E2
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 02:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2939710A3E;
	Tue, 28 May 2024 02:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3VEKN7V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA696107A0;
	Tue, 28 May 2024 02:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862710; cv=none; b=qmRAf1ZtU30w/4AGoddWafPQV/B3XxSIFyxPNw8tONjHK4k1bAJNAAjotqlUtYmB2IPGxXxDAYOb0qH60oAkpF49pM5AcRxx7H0EJ/Q1XefI6b7IXTSx62IH8rBAIXRmUo78xQL+tBnTvce3V9a96FZd6MX5ipSCaV7h2OoN4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862710; c=relaxed/simple;
	bh=vUMgBBUvWuqa6iM8yrXvGGZkqKIAFZID/blyKqHOIQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAz18JiJ5hRca6hhjg8fx++kaW5kugkfPdnaSvcZcW3FdugwG4QVROADnYG4zGkWPzbDgzCHFLugqVlWirtR42AWJXrT6YOE5jyU1aRuqISM5M4PGcb5tPmx2po6+ilKpygFndF2GOcn9AmK10aqKdnB7oP46rhHKGhonhREY7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3VEKN7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F22FC32782;
	Tue, 28 May 2024 02:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716862709;
	bh=vUMgBBUvWuqa6iM8yrXvGGZkqKIAFZID/blyKqHOIQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G3VEKN7VQX5etZiaO/fOQzquHd4O9r19fbBA4CTBDPrjcqHK9+UTqjoB/VnlRhVtc
	 QuPbzyfSzrAwFF7XFrDSABkDJkdwZHngLGAc7UhowXPH8/MhTplQUaE5cLJ7fXv9cg
	 +WfsGjpoRn+m7l0u6o8wztL4DWVsST3ykYjSgGkW24SK0upwEk9f4Y3siFeA+kyELX
	 JXanShnY5L17/fQXgaFG88X3Y4DItXjHgB6Fj3CUqFVHURa3HXC/0AsxUDepi1TTr5
	 ExgfwelAnL7ApkuC0SQATvnjlO4FGlAfHgc+TppFlac9QuXdFeupCqSdAj15/rqXtW
	 Fk0ZQsvphkMNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksandr Aprelkov <aaprelkov@usergate.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 6.9 2/5] iommu/arm-smmu-v3: Free MSIs in case of ENOMEM
Date: Mon, 27 May 2024 22:18:18 -0400
Message-ID: <20240528021823.3904980-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528021823.3904980-1-sashal@kernel.org>
References: <20240528021823.3904980-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
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
index 41f93c3ab160d..3afec8714cf28 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3402,7 +3402,7 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
 
 	/* Add callback to free MSIs on teardown */
-	devm_add_action(dev, arm_smmu_free_msis, dev);
+	devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);
 }
 
 static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
-- 
2.43.0


