Return-Path: <stable+bounces-191677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16E9C1D95A
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 23:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07811893752
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 22:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9755E31961E;
	Wed, 29 Oct 2025 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=waldn.net header.i=@waldn.net header.b="Zyi2SSgn"
X-Original-To: stable@vger.kernel.org
Received: from mail.waldn.net (mail.waldn.net [216.66.77.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9D120010A
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 22:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.66.77.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776759; cv=none; b=XoYdNrowpwL0BAISxeAFxLxvsrut21rpKD8SZkyYCgJTztCmFWaBE7fjo0bdmj4LZjTE8Cc6LwCM02hTSVd/a6vHQfouiNVMgWHIEvbiF1opkrwRJ90ZK9DRUZJaCQpep0zILmOxEUxrR880Gf6uCX6pe7Qt5SyGbBWl/gLzZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776759; c=relaxed/simple;
	bh=QRyqS16rRrdEEjGZwHCU/CCwep7PKxu16BOnIK5Mbs0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y0RYfKof7lmTzjnC82Lo1yONXmBPNaXPQdKSl9Lm+2LRr91fTeOCZxM+WDivsHGj3uaRI7/AsNg9dKKnAr30I5F6tnVIPAJKw0h1VsdI2p6XMrgJ8+XIbEcVE6qtot3ei4rhxB+fr/XqlH77cfC6TQhivilkvkfH91xE9V9Vsf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waldn.net; spf=pass smtp.mailfrom=waldn.net; dkim=pass (1024-bit key) header.d=waldn.net header.i=@waldn.net header.b=Zyi2SSgn; arc=none smtp.client-ip=216.66.77.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waldn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldn.net
Message-ID: <645ca90a-0f5d-44a0-985e-aa84a18c2fd1@waldn.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waldn.net; s=mail;
	t=1761776756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRyqS16rRrdEEjGZwHCU/CCwep7PKxu16BOnIK5Mbs0=;
	b=Zyi2SSgnpTIOeDz+AUpUN1cVL10brsHIlXY4iZPXLHd0ztJHVMrXOKin+9hoidyWfe99V7
	fm6AddxgQM1TQo7kk87k4cXW2kNOA36w9bc9AGnpF34wDl+cUBxSYDaxpQQSU3Fq9vXIWy
	TcaAsrm0Qa66s7e2aSo7JU4taEaqrRE=
Date: Wed, 29 Oct 2025 17:25:55 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH 1/4] iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE
From: Amelia Crate <acrate@waldn.net>
To: stable@vger.kernel.org
Cc: dimitri.ledkov@surgut.co.uk, baolu.lu@linux.intel.com, kees@ijzerbout.nl
References: <79b19099-3791-4690-8729-de15128d79b7@waldn.net>
Content-Language: en-US
In-Reply-To: <79b19099-3791-4690-8729-de15128d79b7@waldn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From f1cefc290c20c30c37b01d44b42ca5c9b6d32913 Mon Sep 17 00:00:00 2001
From: Kees Bakker <kees@ijzerbout.nl>
Date: Tue, 7 Jan 2025 10:17:42 +0800
Subject: [PATCH 1/4] iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE

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
-    WARN_ON_ONCE(!dev_pasid);
     spin_unlock_irqrestore(&dmar_domain->lock, flags);

     cache_tag_unassign_domain(dmar_domain, dev, pasid);
     domain_detach_iommu(dmar_domain, iommu);
-    intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
-    kfree(dev_pasid);
+    if (!WARN_ON_ONCE(!dev_pasid)) {
+        intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
+        kfree(dev_pasid);
+    }
     intel_pasid_tear_down_entry(iommu, dev, pasid, false);
     intel_drain_pasid_prq(dev, pasid);
 }
--
2.50.1

