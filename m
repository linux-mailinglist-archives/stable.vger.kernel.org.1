Return-Path: <stable+bounces-88091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ADF9AEA94
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 17:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC939282E04
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 15:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378491E1A1D;
	Thu, 24 Oct 2024 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ly4TswQj"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D58154420
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784068; cv=none; b=U2VagVw30WaQnatS8qL3ePmsdL7kWxlEJOmmH71JGDYgDYHnoV+894mt3hHf1S+lvVRmieAloOkpLmA5puiQ4HmnuBbBB6MhBi9ntWfpoRTWo5iV7fSZA9Zde+N0USlJhgWLUWHDrUrxcNdZ48MVLX43LmlhI4dmQdJUqmQmGUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784068; c=relaxed/simple;
	bh=DmaNumx1B9Ch/TRtvCjSsjZvuo2pfUkSNhQa17xSru8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XlzGuDPPcQkOxPXsadD75NaPZB/Y1v/YkldzwqAuFWE9reWxwjHbbLxQnPwULHHGIpFRJ9vgNmbDBsVrlY4YEHMs3bmthHIl86xOyJm8XjBOXO5r9mOPfHbhS6W5qEP5oZV/C5cdQLWaDSCoBB/meAE93jjmSy17c4FzTdeXm0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ly4TswQj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729784064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cXUUAup2BSwJWOmEG3JvcIkWwS4Ltp5hO2So1hfEC/o=;
	b=Ly4TswQjUigPdDyQpOnyiLkp647XrzN//peO3MQn1/FRUR4QtvtIvxsfQfL3jE3sSRCuDu
	z7xMythkCxyPl227uVSuK/kl1GWwqM/GpL3mB0Kc9NZkECxBeAzgLNYEnyOkkz7jrWToba
	P8pIew0D+zI3vkXn95P+pZsUBlFYXi0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-Pkhxl-hhPlWK5XtZSJRhmA-1; Thu,
 24 Oct 2024 11:34:21 -0400
X-MC-Unique: Pkhxl-hhPlWK5XtZSJRhmA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF16C1955D50;
	Thu, 24 Oct 2024 15:34:19 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.144.217])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 287D73000198;
	Thu, 24 Oct 2024 15:34:17 +0000 (UTC)
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] iommu/dma: Reserve iova ranges for reserved regions of all devices
Date: Thu, 24 Oct 2024 08:34:12 -0700
Message-ID: <20241024153412.141765-1-jsnitsel@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Only the first device that is passed when the domain is set up will
have its reserved regions reserved in the iova address space.  So if
there are other devices in the group with unique reserved regions,
those regions will not get reserved in the iova address space.  All of
the ranges do get set up in the iopagetables via calls to
iommu_create_device_direct_mappings for all devices in a group.

In the case of vt-d system this resulted in messages like the following:

[ 1632.693264] DMAR: ERROR: DMA PTE for vPFN 0xf1f7e already set (to f1f7e003 not 173025001)

To make sure iova ranges are reserved for the reserved regions all of
the devices, call iova_reserve_iommu_regions in iommu_dma_init_domain
prior to exiting in the case where the domain is already initialized.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: 7c1b058c8b5a ("iommu/dma: Handle IOMMU API reserved regions")
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
Robin: I wasn't positive if this is the correct solution, or if it should be
       done for the entire group at once.

 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2a9fa0c8cc00..5fd3cccbb233 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -707,7 +707,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
 			goto done_unlock;
 		}
 
-		ret = 0;
+		ret = iova_reserve_iommu_regions(dev, domain);
 		goto done_unlock;
 	}
 
-- 
2.44.0


