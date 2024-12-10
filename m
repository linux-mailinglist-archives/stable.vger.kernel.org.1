Return-Path: <stable+bounces-100421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DAE9EB10B
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 13:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98FA16AD94
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 12:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3AC1A704B;
	Tue, 10 Dec 2024 12:42:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4DE1CD15
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733834550; cv=none; b=sRea56C2sW3YUGOD+BpEK1kmIdRm00kEmUe9vSFC8i7pN09H0ensWcXqz3IH7RRskuIjrFn9ZiwAZKmyctN/ixKdTUuV9yRgeJMEYo5nCRmAFe9nwBFOaToNK7FDg9ieoMyJs9OsK1qTu6yFfFOC220BdHT+QkYZKng9cyz+XCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733834550; c=relaxed/simple;
	bh=HY5qPnvmHAweit9LBS7RWv2hkt1myWDIVfznj4ZlsRo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=suVU1NsUJfRdmTr1ZCs7ZOjRS8plHlyj/e72ENpf/7lnQK98oj63r11F0SR6BQbJxvjvmmVyWDXq9rfMITF4YF3Q//X7oIHWzNaz0tS8gLTEC36zVAlcDYsiKbl1bQ+LcQhYdfKGKecGu3QrR1t5puL+XyLZCFnepB/f8MMwDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36353106F;
	Tue, 10 Dec 2024 04:42:54 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 628FD3F5A1;
	Tue, 10 Dec 2024 04:42:25 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: stable@vger.kernel.org
Cc: Pratyush Brahma <quic_pbrahma@quicinc.com>,
	Prakash Gupta <quic_guptap@quicinc.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.6.y] iommu/arm-smmu: Defer probe of clients after smmu device bound
Date: Tue, 10 Dec 2024 12:42:16 +0000
Message-Id: <acd8068372673fb881aa9e13531470669c985519.1733834302.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Brahma <quic_pbrahma@quicinc.com>

[ Upstream commit 229e6ee43d2a160a1592b83aad620d6027084aad ]

Null pointer dereference occurs due to a race between smmu
driver probe and client driver probe, when of_dma_configure()
for client is called after the iommu_device_register() for smmu driver
probe has executed but before the driver_bound() for smmu driver
has been called.

Following is how the race occurs:

T1:Smmu device probe		T2: Client device probe

really_probe()
arm_smmu_device_probe()
iommu_device_register()
					really_probe()
					platform_dma_configure()
					of_dma_configure()
					of_dma_configure_id()
					of_iommu_configure()
					iommu_probe_device()
					iommu_init_device()
					arm_smmu_probe_device()
					arm_smmu_get_by_fwnode()
						driver_find_device_by_fwnode()
						driver_find_device()
						next_device()
						klist_next()
						    /* null ptr
						       assigned to smmu */
					/* null ptr dereference
					   while smmu->streamid_mask */
driver_bound()
	klist_add_tail()

When this null smmu pointer is dereferenced later in
arm_smmu_probe_device, the device crashes.

Fix this by deferring the probe of the client device
until the smmu device has bound to the arm smmu driver.

Fixes: 021bb8420d44 ("iommu/arm-smmu: Wire up generic configuration support")
Cc: stable@vger.kernel.org # 6.6
Co-developed-by: Prakash Gupta <quic_guptap@quicinc.com>
Signed-off-by: Prakash Gupta <quic_guptap@quicinc.com>
Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
Link: https://lore.kernel.org/r/20241004090428.2035-1-quic_pbrahma@quicinc.com
[will: Add comment]
Signed-off-by: Will Deacon <will@kernel.org>
[rm: backport for context conflict prior to 6.8]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index d6d1a2a55cc0..42c5012ba8aa 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1359,6 +1359,17 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 			goto out_free;
 	} else if (fwspec && fwspec->ops == &arm_smmu_ops) {
 		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
+
+		/*
+		 * Defer probe if the relevant SMMU instance hasn't finished
+		 * probing yet. This is a fragile hack and we'd ideally
+		 * avoid this race in the core code. Until that's ironed
+		 * out, however, this is the most pragmatic option on the
+		 * table.
+		 */
+		if (!smmu)
+			return ERR_PTR(dev_err_probe(dev, -EPROBE_DEFER,
+						"smmu dev has not bound yet\n"));
 	} else {
 		return ERR_PTR(-ENODEV);
 	}
-- 
2.39.2.101.g768bb238c484.dirty


