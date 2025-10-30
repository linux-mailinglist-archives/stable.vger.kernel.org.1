Return-Path: <stable+bounces-191750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DB4C211BC
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 17:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2C514ED601
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 16:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9573655EB;
	Thu, 30 Oct 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=waldn.net header.i=@waldn.net header.b="V3OcPvvm"
X-Original-To: stable@vger.kernel.org
Received: from mail.waldn.net (mail.waldn.net [216.66.77.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795CB18859B
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.66.77.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840658; cv=none; b=rAt5Nn6mcwiHfYcFO2zunJ9z1LP4X4uK9S4WcGzd2pluMRgaRXLWVIEsXdi9l/+TLCXUumMDJCqAWydfVsck1Hla/i/pFILBK1uTYy/NDc09avh+Gof/raEtq8YAVW3yLgE+sHtWpFkoOSG+C9qqpbA65chXTAcOhqTcIz8yoig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840658; c=relaxed/simple;
	bh=8uxsv+t33cV9CK+6CUTE5y3ueIo1n9hZdqwNFfII1fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQnusaJ3xmSDUWm4rxdZBiSdUZtTB553OhGhn6LTS7KaA9uTN6duasZMiaiYUsMkaGak1P4dRSnVgJHmmQkKAGMDRHLfEZeNH05Va0CeGSUaW9Xwf0cJfpr9NV/hWiwWaOqKtai6+UJmBFkLcCPvUBQaUgM/uh6wxlqvmURXrT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waldn.net; spf=pass smtp.mailfrom=waldn.net; dkim=pass (1024-bit key) header.d=waldn.net header.i=@waldn.net header.b=V3OcPvvm; arc=none smtp.client-ip=216.66.77.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waldn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldn.net
From: Amelia Crate <acrate@waldn.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waldn.net; s=mail;
	t=1761840655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TMzz1lvEpq7fbxUpqz+xVOi/1cADxKyqsa9OI0HJkk=;
	b=V3OcPvvm/BS/c0Ui9/GaC2FbFMEF7A+N9OtRBf+wySDr1l+H2ZTBrmOoclJR5ptvZEuNTv
	cPdScemgfRe/hLaEKHIoecM6DiNtffHggmxu80UukMkhkbX0Bwr0e9GQutTETO5N4pyftM
	3eQKR4DzOfhB7bwPr0U5/6yOzEquXak=
To: gregkh@linuxfoundation.org
Cc: dimitri.ledkov@surgut.co.uk,
	stable@vger.kernel.org,
	Kees Bakker <kees@ijzerbout.nl>,
	Amelia Crate <acrate@waldn.net>
Subject: [PATCH v2 1/4] iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE
Date: Thu, 30 Oct 2025 11:08:31 -0500
Message-ID: <20251030160942.19490-2-acrate@waldn.net>
In-Reply-To: <20251030160942.19490-1-acrate@waldn.net>
References: <2025103043-refinish-preformed-280e@gregkh>
 <20251030160942.19490-1-acrate@waldn.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kees Bakker <kees@ijzerbout.nl>

[ Upstream commit 60f030f7418d3f1d94f2fb207fe3080e1844630b ]

There is a WARN_ON_ONCE to catch an unlikely situation when
domain_remove_dev_pasid can't find the `pasid`. In case it nevertheless
happens we must avoid using a NULL pointer.

Signed-off-by: Kees Bakker <kees@ijzerbout.nl>
Link: https://lore.kernel.org/r/20241218201048.E544818E57E@bout3.ijzerbout.nl
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Amelia Crate <acrate@waldn.net>
---
 drivers/iommu/intel/iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 667407974e23..c799cc67db34 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4328,13 +4328,14 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 			break;
 		}
 	}
-	WARN_ON_ONCE(!dev_pasid);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
 	cache_tag_unassign_domain(dmar_domain, dev, pasid);
 	domain_detach_iommu(dmar_domain, iommu);
-	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
-	kfree(dev_pasid);
+	if (!WARN_ON_ONCE(!dev_pasid)) {
+		intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
+		kfree(dev_pasid);
+	}
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
 	intel_drain_pasid_prq(dev, pasid);
 }
-- 
2.50.1


