Return-Path: <stable+bounces-155271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB94AE3339
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 03:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3578116D3BA
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 01:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609138BEE;
	Mon, 23 Jun 2025 01:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="HcUQYdC1"
X-Original-To: stable@vger.kernel.org
Received: from mail-m19731118.qiye.163.com (mail-m19731118.qiye.163.com [220.197.31.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAFB4A1A;
	Mon, 23 Jun 2025 01:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750641061; cv=none; b=JCaHf+cZXYGS+YDBICkcOpYDHNDNHXYoJX33NISxUMGRpcy3jWgwU1WyBon5BNtWHZ48BZkKs3mwMcG/pR++zuYn23a05fqUTcgfUrllg70dj+kYzQVDLTNt5U9oQMFwVt71hB9ei451Bq7+wKC6zcrvR+pboFy2J/tbrHmHk3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750641061; c=relaxed/simple;
	bh=rwqqDu0KtBplQp8EOinHmccqzODA49z/gqlStx52Hzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WR9lNbMpRkfqjVR4yEDu2faqt4uVMhtgVv6qXT7WXAAt9kU/kJRK0lDs6Xqn8PBYOooDr0REjADJUE5PNWc61+VJGHcQLB4KjvsNeP0FdlDCogjoqYzwUj/Z1I6oAWgP5UqYgOUxlGOuhYvWTExQMJqa09Uxi5cN37weIeEdT/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=HcUQYdC1; arc=none smtp.client-ip=220.197.31.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from xxm-vm.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1988856fd;
	Mon, 23 Jun 2025 09:05:38 +0800 (GMT+08:00)
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
Subject: [PATCH v2] iommu/rockchip: prevent iommus dead loop when two masters share one IOMMU
Date: Mon, 23 Jun 2025 09:05:32 +0800
Message-Id: <20250623010532.584409-1-xxm@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620073945.572523-1-xxm@rock-chips.com>
References: <20250620073945.572523-1-xxm@rock-chips.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR9KHlZLTkNPSE4ZTExPHktWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a979a51c11e03ackunmb9b4d7f71b74391
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nj46Agw5NjEwSy45CB0hHgki
	Ey0aCRdVSlVKTE5LTU9LTEhCQ0lJVTMWGhIXVQMDFjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lBWU5D
	VUlJVUxVSkpPWVdZCAFZQUlKTkg3Bg++
DKIM-Signature:a=rsa-sha256;
	b=HcUQYdC1n/fdfPwVzWQh5u9nT6IAJItWvktXDa+TMc5smGT+z3y3P+xgxIedR+wOHJy4zDL+gnyEikwHSvyT3oerFWtW+N7XEHoZG/IGDlWMN1id+/67ObSAEIbLcgToHcdUhKq8fLnWSgbgfKEtLNvq8Cry/gPy1kS8SZSimg0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=j/L7z1+3IqwV7z6y8V8VJRap9OXNheZ0n7phc+aB5uM=;
	h=date:mime-version:subject:message-id:from;

When two masters share an IOMMU, calling ops->of_xlate during
the second master's driver init may overwrite iommu->domain set
by the first. This causes the check if (iommu->domain == domain)
in rk_iommu_attach_device() to fail, resulting in the same
iommu->node being added twice to &rk_domain->iommus, which can
lead to an infinite loop in subsequent &rk_domain->iommus operations.

Fixes: 25c2325575cc ("iommu/rockchip: Add missing set_platform_dma_ops callback")

Signed-off-by: Simon Xue <xxm@rock-chips.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>

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


