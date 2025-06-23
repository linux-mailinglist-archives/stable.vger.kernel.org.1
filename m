Return-Path: <stable+bounces-155273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE4AAE337D
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 04:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA820188FCD5
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 02:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180F928E3F;
	Mon, 23 Jun 2025 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="MAHilJEr"
X-Original-To: stable@vger.kernel.org
Received: from mail-m3297.qiye.163.com (mail-m3297.qiye.163.com [220.197.32.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36BC2F43;
	Mon, 23 Jun 2025 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750644038; cv=none; b=lmpArbOfFiavwnIIzcXVdgziPVg5ZU6beEAgR/QoGX0NyHOaEvPqSDMJpSsmZX9MJQT8ApocZ5H3SRxaW/P0ySufnTQ5csujwvcnRr6rmJWdn9D4zo7hPuRm4MY6C82d3EIalatMGoINZXLlCitrH1e4f4r3ecwYnDwQaIhd7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750644038; c=relaxed/simple;
	bh=VwxSivKjwjgOA47M6Wx0M5ZKoTQcPBr4YKOf2YuUhDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mkni2UuNlKlwz0kdanUDWU9U4U3fnG0dDnrrmD8zEDAkOP7JrT29llbEbpCFb+iCXtMyGL/x1/6Tl+JPU708/qyF57bqZuySk0GKrBqNnbRet3DaA/DTwlWHfJzhsRZUwY8ZLsfCtxlfnrgDw6qwecyHVRVJ26jl16MvZvQy2do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=MAHilJEr; arc=none smtp.client-ip=220.197.32.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from xxm-vm.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 198a76e7e;
	Mon, 23 Jun 2025 10:00:24 +0800 (GMT+08:00)
From: Simon Xue <xxm@rock-chips.com>
To: joro@8bytes.org,
	will@kernel.org,
	heiko@sntech.de
Cc: robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Simon Xue <xxm@rock-chips.com>
Subject: [PATCH v3] iommu/rockchip: prevent iommus dead loop when two masters share one IOMMU
Date: Mon, 23 Jun 2025 10:00:18 +0800
Message-Id: <20250623020018.584802-1-xxm@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623010532.584409-1-xxm@rock-chips.com>
References: <20250623010532.584409-1-xxm@rock-chips.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0tMHVZMSkxNS01DSBgYSBlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a979a83e4cd03ackunm95adb0ad1ba41a5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K1E6SSo*FjE9Hi0jOBIhATkI
	PQ9PCz9VSlVKTE5LTU9PS0lOQkxOVTMWGhIXVQMDFjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lBWU5D
	VUlJVUxVSkpPWVdZCAFZQUlJTEw3Bg++
DKIM-Signature:a=rsa-sha256;
	b=MAHilJErUTQVecZJVotp/gw1fDA3axTx5qvIuwytoEuMZgBrHlkowpBfFodv0JzuAfkP/sqEvjMHB4pJArwoPlpg8uzZz8xWGdOpPdCklp1vfV0UKwdMuFEz6SjmH5glGyfGlY5BUcBmuo4pm2Ou+2SWAm3+T/J6EHZZoLpYV5E=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=NmfePvVvj/IGwECh3d25BxV8sGg50mGiW3x9goEC7jY=;
	h=date:mime-version:subject:message-id:from;

When two masters share an IOMMU, calling ops->of_xlate during
the second master's driver init may overwrite iommu->domain set
by the first. This causes the check if (iommu->domain == domain)
in rk_iommu_attach_device() to fail, resulting in the same
iommu->node being added twice to &rk_domain->iommus, which can
lead to an infinite loop in subsequent &rk_domain->iommus operations.

Cc: <stable@vger.kernel.org>
Fixes: 25c2325575cc ("iommu/rockchip: Add missing set_platform_dma_ops callback")
Signed-off-by: Simon Xue <xxm@rock-chips.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>

v3:
   Add missing `Cc: stable@vger.kernel.org` in commit message.
   No functional changes.
v2:
   No functional changes.
---
 drivers/iommu/rockchip-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 22f74ba33a0e..e6bb3c784017 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1157,7 +1157,6 @@ static int rk_iommu_of_xlate(struct device *dev,
 		return -ENOMEM;
 
 	data->iommu = platform_get_drvdata(iommu_dev);
-	data->iommu->domain = &rk_identity_domain;
 	dev_iommu_priv_set(dev, data);
 
 	platform_device_put(iommu_dev);
@@ -1195,6 +1194,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (!iommu)
 		return -ENOMEM;
 
+	iommu->domain = &rk_identity_domain;
+
 	platform_set_drvdata(pdev, iommu);
 	iommu->dev = dev;
 	iommu->num_mmu = 0;
-- 
2.34.1


