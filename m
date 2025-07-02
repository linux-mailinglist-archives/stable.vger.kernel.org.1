Return-Path: <stable+bounces-159181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2790AF08A9
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 04:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0233178361
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 02:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B9272604;
	Wed,  2 Jul 2025 02:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=engineer.com header.i=rajanikantha@engineer.com header.b="iYQkf8rV"
X-Original-To: stable@vger.kernel.org
Received: from mout.mail.com (mout.mail.com [74.208.4.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFF3B663
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 02:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751424451; cv=none; b=LBYilkcd6gCAGQjh95yC9pX9BwMVummkeh/HcFKiGgXqQuZf6lpj60YqntmgW2NoAIvx9nxn/mhoqpDHCwvy1rHiqy8m3YtiNZUFJt5EaIOAlxAiMD7fs+65DCcjty4pliybjvz1h8387++obuANvHNjMocVbZlaxpFYLtYfVM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751424451; c=relaxed/simple;
	bh=O58UjhHMfD+rNIQ+gv4LJT9rLwhfRhBHWPCQO97Itbw=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=X6NXB7QwL3hfOrqc6oadtVAiFv8NGlOcOxbvBB7/U7/nyZOAZlc8RaQ9Jv4ECUFgOIZa76uGrCiC6zLYNtLcyTZBq8YGxO/GEAN66UauXMctK444m4fiaaox1H2knqySYYOaOsooVyVa6/Cia1nPmSguzLgotY9MeDhkoIUoP8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=engineer.com; spf=pass smtp.mailfrom=engineer.com; dkim=pass (2048-bit key) header.d=engineer.com header.i=rajanikantha@engineer.com header.b=iYQkf8rV; arc=none smtp.client-ip=74.208.4.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=engineer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engineer.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=engineer.com;
	s=s1089575; t=1751424446; x=1752029246;
	i=rajanikantha@engineer.com;
	bh=wUJm3pY/9/lRXRA3SGxJx7ficG2CJmPkatB+u6FaWKI=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:cc:content-transfer-encoding:content-type:date:
	 from:message-id:mime-version:reply-to:subject:to;
	b=iYQkf8rVO7KNFIbYdJtJzj3GWHq8taiEcMRwpdk0xiLtt1nFBFLf8/2LWtWMCZg2
	 kPj/8C8Zox5Grxu9SqCwGHoVzR4PZ7iUdVKSqilcYSiNbfc6trv7VRWjlQXNOoTtN
	 TEVHwqZVFZjyjDZEEC2s7FPnioaPBYQdNre+YC3jH9JBmRycfBI+LA9dpHKSKeeEk
	 zS1IZK2rOR7FW2EWuHGORWqXNgY/dSFxmOGjfigy6g3y0s3fSEgYurrgWtIQ/4nd3
	 jl5Pwuq+YPRRCAhx3Y+Ft5jj7lErpFyrLCgva8afHCjpAf36kFbQRijnGJRiq7fvC
	 yBCvzVq/PCWzJra9Cw==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [147.11.252.42] ([147.11.252.42]) by web-mail.mail.com
 (3c-app-mailcom-lxa07.server.lan [10.76.45.8]) (via HTTP); Wed, 2 Jul 2025
 04:47:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-5b3af13a-3731-4b47-80a1-8ac7af67791f-1751424444098@3c-app-mailcom-lxa07>
From: Rajani kantha <rajanikantha@engineer.com>
To: kees@ijzerbout.nl, baolu.lu@linux.intel.com, jroedel@suse.de
Cc: stable@vger.kernel.org
Subject: [PATCH 6.12.y] iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE
Content-Type: text/plain; charset=UTF-8
Date: Wed, 2 Jul 2025 04:47:24 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:H9DvUc7UACdydBNVRo/m2HsuMOM/o/BXc3PakBpU+qZbppyFeipMLq9IcwedWsr9CXNQU
 Ir5ZfFv1Dmv4t7wY/WLJFgWDvUjKXE3HYbgI9K4aNij5q8bi+ukkU4/wtfdW/oD+tAUA11e9LFKD
 4fDWl912yi58wBcsN1XhvVlOXJNSWnwa1tC+H3YGeuYrtqYpfUtJYSN2kGRaRXFfYJM/5S4Eimvr
 W0jgVsvDxhr6e1Vd8Aq05F8omWEsqomxQ9pNDCnJOFMlCvENhqhqFRiIlJdbEVYVSA0bJaQbENMO
 w4=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EatKTg9TXPk=;kILkd3GiCiw6U0nxI0KHF96Tujs
 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

From: Kees Bakker <kees@ijzerbout.nl>

[ Upstream commit 60f030f7418d3f1d94f2fb207fe3080e1844630b ]

There is a WARN_ON_ONCE to catch an unlikely situation when
domain_remove_dev_pasid can't find the `pasid`. In case it nevertheless
happens we must avoid using a NULL pointer.

Signed-off-by: Kees Bakker <kees@ijzerbout.nl>
Link: https://lore.kernel.org/r/20241218201048.E544818E57E@bout3.ijzerbout.nl
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Rajani Kantha <rajanikantha@engineer.com>
---
 drivers/iommu/intel/iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 56e9f125cda9..7c351274d004 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4306,13 +4306,14 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
                        break;
                }
        }
-       WARN_ON_ONCE(!dev_pasid);
        spin_unlock_irqrestore(&dmar_domain->lock, flags);

        cache_tag_unassign_domain(dmar_domain, dev, pasid);
        domain_detach_iommu(dmar_domain, iommu);
-       intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
-       kfree(dev_pasid);
+       if (!WARN_ON_ONCE(!dev_pasid)) {
+               intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
+               kfree(dev_pasid);
+       }
        intel_pasid_tear_down_entry(iommu, dev, pasid, false);
        intel_drain_pasid_prq(dev, pasid);
 }
--
2.34.1

