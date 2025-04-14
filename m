Return-Path: <stable+bounces-132487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 749DEA8826E
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897FF1889F2A
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874B9289361;
	Mon, 14 Apr 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIKghjrY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30488289356;
	Mon, 14 Apr 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637246; cv=none; b=CBGE/sX/ZPzS+nEX4ztf2jbCanOsNTwMNJkR65ShUhxBd4BKD32iUqHcnaaLDrmK9x2KvR+aV0Gm9i4A+3koHIVJqV6+XLsuEf7HWMq4obYO5ZuQ0Iaytn9xadbfRIHuM3euh56DTOMJN1QdJlaCcTL9dM94y6UT4EK9VtrvSCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637246; c=relaxed/simple;
	bh=HWazVEnF+OZqb0LvjRvTdKq+u4+0/eh3TCOLdlukdWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jOTuIh+DmpTscQRG0TmrzN1CfPvY5wXITp96BaM9m8G/PEUVL1UKsgz1pTmPCKF+X9t7FAuiTUc8Mtb9DS7h4poayhlXp2hfcpQYz0dAVSpIvrnG/fL5pxlgiAnMv9vF7YQ4hyXkV4AGNa9Tbig/MhmXCo62Ui0BTMHCQPy+lwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIKghjrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD39C4CEEB;
	Mon, 14 Apr 2025 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637246;
	bh=HWazVEnF+OZqb0LvjRvTdKq+u4+0/eh3TCOLdlukdWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jIKghjrY6dn1hIIOqS8b18nOhYrAZ81ZmybLQt5hzHUmanMsnuGyAwiUr9LYPrJ7J
	 cPNTaBvcNsrXqLf3wLHtBnihS38djzEUAKHsAXE6/6EntoDxvq+M6C4emzo1jkC6Kn
	 4w2ytBCluG9w10T3bz8i/twF+lk2DJiPWrk5py/V2s9zIAa8jPACBN3mXUHNWvko51
	 kQr8NQURJb2EVgh8TlBu+ZhsGpfvvMeVvlndGNffTVWdaFBtTIHIYHBtvw5zWnXBHc
	 +OLRUuQ4ahTx1AnnDfHUzofLDNSbV6Y09p/QXOBo08MuaYh0BfoY3dKc+B9TwsyLvW
	 rLNshFOxLNSQQ==
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
Subject: [PATCH AUTOSEL 6.14 33/34] iommu: Clear iommu-dma ops on cleanup
Date: Mon, 14 Apr 2025 09:26:09 -0400
Message-Id: <20250414132610.677644-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132610.677644-1-sashal@kernel.org>
References: <20250414132610.677644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.2
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
index e3df1f06afbeb..1efe7cddb4fe3 100644
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


