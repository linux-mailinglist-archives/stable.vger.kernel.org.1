Return-Path: <stable+bounces-136712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172ADA9CBA5
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 16:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73B03B7F82
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD61255E30;
	Fri, 25 Apr 2025 14:26:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793002701B7
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745591214; cv=none; b=jfbHdyHFLnx5AIAVeR7h9ZLCBc2oWKSE0Z8GpYHMafs4fJKyvvq3LiounXGPQXm+B6QmYLaxdDKlbLynsrDm6scrRroVW8Y4ePyxOEzjloN5wP2zfSstbRfHyFo0hpTbVp4MzEe45ZN36jwkT8arfQppjd31zvCMe82O1Kp86nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745591214; c=relaxed/simple;
	bh=HzaG7NmIo55by25RWysIaLWUIiQ9ND8dVgq2+IMRbxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jGqg4gmh+OTTnsOaMe4Xkq0bs1ewLdVJY9M2gSDELzDYDDzLJ1RaZLAwuDY0RzKOdAZst85n6GVyNSDZ6UJTaz7a2qBIqImE6l3fKXRFc/a4os4TLm8vOgDF+U+bTYFfvHaggmdIUm0BZIlRqI3ocSiNwVT9INR+qB+jom9JuRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3602D106F;
	Fri, 25 Apr 2025 07:26:45 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 22BD33F66E;
	Fri, 25 Apr 2025 07:26:50 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: stable@vger.kernel.org
Cc: Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH 6.6 v2] iommu: Handle race with default domain setup
Date: Fri, 25 Apr 2025 15:26:44 +0100
Message-Id: <e1e5d56a9821b3428c561cf4b3c5017a9c41b0b5.1739903836.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit b46064a18810bad3aea089a79993ca5ea7a3d2b2 ]

It turns out that deferred default domain creation leaves a subtle
race window during iommu_device_register() wherein a client driver may
asynchronously probe in parallel and get as far as performing DMA API
operations with dma-direct, only to be switched to iommu-dma underfoot
once the default domain attachment finally happens, with obviously
disastrous consequences. Even the wonky of_iommu_configure() path is at
risk, since iommu_fwspec_init() will no longer defer client probe as the
instance ops are (necessarily) already registered, and the "replay"
iommu_probe_device() call can see dev->iommu_group already set and so
think there's nothing to do either.

Fortunately we already have the right tool in the right place in the
form of iommu_device_use_default_domain(), which just needs to ensure
that said default domain is actually ready to *be* used. Deferring the
client probe shouldn't have too much impact, given that this only
happens while the IOMMU driver is probing, and thus due to kick the
deferred probe list again once it finishes.

[ Backport: The above is true for mainline, but here we still have
arch_setup_dma_ops() to worry about, which is not replayed if the
default domain happens to be allocated *between* that call and
subsequently reaching iommu_device_use_default_domain(), so we need an
additional earlier check to cover that case. Also we're now back before
the nominal commit 98ac73f99bc4 so we need to tweak the logic to depend
on IOMMU_DMA as well, to avoid falsely deferring on architectures not
using default domains. This then serves us back as far as f188056352bc,
where this specific form of the problem first arises. ]

Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
Fixes: 98ac73f99bc4 ("iommu: Require a default_domain for all iommu drivers")
Fixes: f188056352bc ("iommu: Avoid locking/unlocking for iommu_probe_device()")
Link: https://lore.kernel.org/r/e88b94c9b575034a2c98a48b3d383654cbda7902.1740753261.git.robin.murphy@arm.com
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Aargh! Sorry, just realised I sent a stale patch from an old version
missing one of the IS_ENABLED() checks - this one has the correct diff.

 drivers/iommu/iommu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3f1029c0825e..29b48a6a0275 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -566,6 +566,17 @@ int iommu_probe_device(struct device *dev)
 	mutex_lock(&iommu_probe_device_lock);
 	ret = __iommu_probe_device(dev, NULL);
 	mutex_unlock(&iommu_probe_device_lock);
+
+	/*
+	 * The dma_configure replay paths need bus_iommu_probe() to
+	 * finish before they can call arch_setup_dma_ops()
+	 */
+	if (IS_ENABLED(CONFIG_IOMMU_DMA) && !ret && dev->iommu_group) {
+		mutex_lock(&dev->iommu_group->mutex);
+		if (!dev->iommu_group->default_domain)
+			ret = -EPROBE_DEFER;
+		mutex_unlock(&dev->iommu_group->mutex);
+	}
 	if (ret)
 		return ret;
 
@@ -3149,6 +3160,11 @@ int iommu_device_use_default_domain(struct device *dev)
 		return 0;
 
 	mutex_lock(&group->mutex);
+	/* We may race against bus_iommu_probe() finalising groups here */
+	if (IS_ENABLED(CONFIG_IOMMU_DMA) && !group->default_domain) {
+		ret = -EPROBE_DEFER;
+		goto unlock_out;
+	}
 	if (group->owner_cnt) {
 		if (group->owner || !iommu_is_default_domain(group) ||
 		    !xa_empty(&group->pasid_array)) {
-- 
2.39.2.101.g768bb238c484.dirty

