Return-Path: <stable+bounces-132521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1BAA882B6
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B027A6529
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882902951AB;
	Mon, 14 Apr 2025 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp668Arl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4125F2BF3E1;
	Mon, 14 Apr 2025 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637325; cv=none; b=NQpLSMNuELIMiV/1S9wVLxjgYGc82M4dIBet20hTD14TW9tPglkob5+LFBFZqaqjL3IgHcExRdh8i2o+6xiC6RhpoH72dcfl6T8dsooqsb2kCKBuHaKnkSuI+uxw4nna92GTinj27QR710h5cqIJKQhgnlCdvsqMQjytKbrQkl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637325; c=relaxed/simple;
	bh=n84S1QE6kVvWUC0rKRfdAoFhRE/FBltF/gdyikDbI5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsOFTCVn307tYywHSzEH/FEcpw8Rzx5mYplmv2qe5fqfJRmYO5AaqqEV8qYRpZXsJNHqjdnL3pQmGvsqkrmGcVs7J64U4OmrNwupppl23NsNo20G7t4WJMMIwS2vfV7IN6UO0spOQ/m8/YAT2FzvcfIJ2K3+8ghDCE2sRT10q7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp668Arl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACDAC4CEEB;
	Mon, 14 Apr 2025 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637325;
	bh=n84S1QE6kVvWUC0rKRfdAoFhRE/FBltF/gdyikDbI5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gp668ArlbTwCvH+G03a1gTfuCUY2xEORm8BzINoRa8A4rj2WV8NeckRoxWrydvpjM
	 ONjbK+YbDP0KKberWoyYMP31n+YPzWlu+imYXHFWBVWJcPh2h21aSpAWbxTjYC9Jhr
	 eUk4kN9j8QtJoNVR7yj1Y7DkmyLJLt27l0Pu4seD2taTGhomQ3Ah4926ytAbQXSiOI
	 85y2vZ2BI6Gp4PSSVevE4nEhmGjMrCXiiKt/krpBFvm+N1Je8fAluMNLaDJ3eYImku
	 L3wgRCGwon3sXeaxNNI6P115Tn26DHmyZgMJoJkIyvsZTG3/UhYT/tybRqnlLE7MMH
	 UHaXZDlvUsgTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.13 33/34] iommu: Clear iommu-dma ops on cleanup
Date: Mon, 14 Apr 2025 09:27:27 -0400
Message-Id: <20250414132729.679254-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132729.679254-1-sashal@kernel.org>
References: <20250414132729.679254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.11
Content-Transfer-Encoding: 8bit

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 280e5a30100578106a4305ce0118e0aa9b866f12 ]

If iommu_device_register() encounters an error, it can end up tearing
down already-configured groups and default domains, however this
currently still leaves devices hooked up to iommu-dma (and even
historically the behaviour in this area was at best inconsistent across
architectures/drivers...) Although in the case that an IOMMU is present
whose driver has failed to probe, users cannot necessarily expect DMA to
work anyway, it's still arguable that we should do our best to put
things back as if the IOMMU driver was never there at all, and certainly
the potential for crashing in iommu-dma itself is undesirable. Make sure
we clean up the dev->dma_iommu flag along with everything else.

Reported-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Closes: https://lore.kernel.org/all/CAGXv+5HJpTYmQ2h-GD7GjyeYT7bL9EBCvu0mz5LgpzJZtzfW0w@mail.gmail.com/
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/e788aa927f6d827dd4ea1ed608fada79f2bab030.1744284228.git.robin.murphy@arm.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 599030e1e890b..1c566675281e5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -508,6 +508,9 @@ static void iommu_deinit_device(struct device *dev)
 	dev->iommu_group = NULL;
 	module_put(ops->owner);
 	dev_iommu_free(dev);
+#ifdef CONFIG_IOMMU_DMA
+	dev->dma_iommu = false;
+#endif
 }
 
 DEFINE_MUTEX(iommu_probe_device_lock);
-- 
2.39.5


