Return-Path: <stable+bounces-103484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092B09EF7D3
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E52E189264D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2599A2210F1;
	Thu, 12 Dec 2024 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mfLgp3r4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67542153EC;
	Thu, 12 Dec 2024 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024708; cv=none; b=ak+w+RXfRUo/9pivuRg4THlxZcVCJDmbc6ysIuJdjGyaz2qvokW3u4H2mhkRDMZad0Lop1ljf+ZomyYO3Ypu3LPeJfgd+D/7vyqx56IX98P9BUdnC1B+97R6wo6gsJTNAjL4gRJ1Xzm14oeNw+zPMypbe715nlJ8wbROfL9DRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024708; c=relaxed/simple;
	bh=VKp2CRVCvpxsvsM3mGPfU0PohzOP7ME5FV6c7LPh0NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVUevZgML5L2WvemnV8axLgtG1+WlhfsjcQbVZxrDnP0TS85qdDJHOk6+TnIT2wDXKk+q8t9YozHGD85DSK/q7NuxQH5PsboQOAwfKPkpl2vJtbvptW2iwb//UbOqSb5goW5arK8qPc6nPIdcR8kTtXT1UyJUyzFbfKRa5y4SJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mfLgp3r4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DA2C4CECE;
	Thu, 12 Dec 2024 17:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024708;
	bh=VKp2CRVCvpxsvsM3mGPfU0PohzOP7ME5FV6c7LPh0NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mfLgp3r4lTkPTVV4YBJet+22aMhgbZIR3Olc3t2kW/rEvVPpI+7qtkpqXbGksMmYI
	 pzj0V2iqi2oIWArr/ADQK5eprk3xg18veWy+f47TTMiD/FjNb04StcnxOCiJRxvRBV
	 veq/zXIvDUHUdXy5Uxad401fznzifK614hg285PU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Prakash Gupta <quic_guptap@quicinc.com>,
	Pratyush Brahma <quic_pbrahma@quicinc.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 5.10 378/459] iommu/arm-smmu: Defer probe of clients after smmu device bound
Date: Thu, 12 Dec 2024 16:01:56 +0100
Message-ID: <20241212144308.598873005@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pratyush Brahma <quic_pbrahma@quicinc.com>

commit 229e6ee43d2a160a1592b83aad620d6027084aad upstream.

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
Cc: stable@vger.kernel.org
Co-developed-by: Prakash Gupta <quic_guptap@quicinc.com>
Signed-off-by: Prakash Gupta <quic_guptap@quicinc.com>
Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
Link: https://lore.kernel.org/r/20241004090428.2035-1-quic_pbrahma@quicinc.com
[will: Add comment]
Signed-off-by: Will Deacon <will@kernel.org>
[rm: backport for context conflict prior to 6.8]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1387,6 +1387,17 @@ static struct iommu_device *arm_smmu_pro
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



