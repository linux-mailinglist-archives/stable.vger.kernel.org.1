Return-Path: <stable+bounces-102397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A359EF319
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1106C177E20
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3B1232377;
	Thu, 12 Dec 2024 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wiQ5Y/RQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D0F223E71;
	Thu, 12 Dec 2024 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021083; cv=none; b=DgBfFTuohwolXZCttqWWg6/yKYdq5tab1I5pR/d7DyK4+OIq+kqrOCjPikdWtAqhGovRuIEmZaReDdCY9PARAc5QX91Hjw5cn0EmyXiRkenfWow9JsX6mwMmao1TB0Ej4cyUhfUWj/hgWBY8nCU5cL1PoH7Zm4R+wT7pcnB4Ikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021083; c=relaxed/simple;
	bh=gllV5/YkJQrqTvug+6HvCNVEAAuUwANpATpTkoOkvbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rv36Ql7Zlm2avRGtAPxdegl+2S3suZ9lKZjXY3bt7XGe+kX9MrdBvWEoHfpAwTyGWTicQdi8trE5PWcCuWXpZoNZanhezxfP6xu7apbrBAqXSf12tzkvK/Utlk+0ujffLE4ivFn+1zm8z40AwJd22Q0wXIO2DIJIH/Tpy3WSXPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wiQ5Y/RQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E3CC4CECE;
	Thu, 12 Dec 2024 16:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021083;
	bh=gllV5/YkJQrqTvug+6HvCNVEAAuUwANpATpTkoOkvbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wiQ5Y/RQcnuxQmnGiWB0Ql+slygOgWL+rEhD8I84LgdFXamyRClsEWfjlJoCqnhnu
	 aPWgIJWGd3DZpPPIHhFuZyJOs+Slc7e34ry/ENB3GV2kNf9VzlJBCbkdqJoNOwIa/D
	 wWqF/ldc0hwbJtdEywJaezbNnQSRFlOg6m6Dd5ww=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Prakash Gupta <quic_guptap@quicinc.com>,
	Pratyush Brahma <quic_pbrahma@quicinc.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 6.1 640/772] iommu/arm-smmu: Defer probe of clients after smmu device bound
Date: Thu, 12 Dec 2024 15:59:45 +0100
Message-ID: <20241212144416.377889099@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1363,6 +1363,17 @@ static struct iommu_device *arm_smmu_pro
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



