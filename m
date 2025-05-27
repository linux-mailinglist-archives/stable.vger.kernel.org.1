Return-Path: <stable+bounces-147379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D874AC5767
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F05166171
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83DE27BF79;
	Tue, 27 May 2025 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ltklNOQ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A12110E;
	Tue, 27 May 2025 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367160; cv=none; b=J+65MJ/aanqV7OjY0htxqIfUygk9r8HWvD7HI2xSXWROly0Q72sSiIWu3et8rphLjNTAJpe8onxcE1qjnyGZkBjYy3zhXFU23oJi6tMbmZnqhd2C+0aZ6nAochw8QqNwoezjF/lwFjGs+TlcARNPsIiRl7dmnzp3lUGLzaykp1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367160; c=relaxed/simple;
	bh=djhe2v6jUxwHModoGlzFGwcHxHGe+UaKGtFGzjK2Otw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAwfkyQDOcGnupEd3bZOQAX9NWrZ/TpcNqwZKl7Xn9hXKRY81d8XLtulty9k8SLXAoa4n8SviYnIiKoXnwtpAJDD4MgN7vDKADZ9uO4VbwTQNglByI4yKj3tC3Kyoh7gSAGyhfePkfEqsOGz3g+t8ITEwDRe8Vg9yRCS8kf4Q1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ltklNOQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88F3C4CEE9;
	Tue, 27 May 2025 17:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367160;
	bh=djhe2v6jUxwHModoGlzFGwcHxHGe+UaKGtFGzjK2Otw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ltklNOQ6JCpHZx70XWBOdomSk2e4WJAhGCOm8wnS9lkpAQ98igUpcGXeB0/V531gp
	 jlZhXlP9yp8rE5v3OV2LyuJkb2J7n6UppqwRtzOW2RiSnQn6d2lV8/2JK6VG75nnMz
	 g6wkKAy/ZlQDm18Z1lvfcw6JCFBov6DTqK6Q45p8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 298/783] iommufd: Disallow allocating nested parent domain with fault ID
Date: Tue, 27 May 2025 18:21:35 +0200
Message-ID: <20250527162525.212126922@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yi Liu <yi.l.liu@intel.com>

[ Upstream commit 1062d81086156e42878d701b816d2f368b53a77c ]

Allocating a domain with a fault ID indicates that the domain is faultable.
However, there is a gap for the nested parent domain to support PRI. Some
hardware lacks the capability to distinguish whether PRI occurs at stage 1
or stage 2. This limitation may require software-based page table walking
to resolve. Since no in-tree IOMMU driver currently supports this
functionality, it is disallowed. For more details, refer to the related
discussion at [1].

[1] https://lore.kernel.org/linux-iommu/bd1655c6-8b2f-4cfa-adb1-badc00d01811@intel.com/

Link: https://patch.msgid.link/r/20250226104012.82079-1-yi.l.liu@intel.com
Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 3 +++
 tools/testing/selftests/iommu/iommufd.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 598be26a14e28..9b5b0b8522299 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -126,6 +126,9 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
 	    !device_iommu_capable(idev->dev, IOMMU_CAP_DIRTY_TRACKING))
 		return ERR_PTR(-EOPNOTSUPP);
+	if ((flags & IOMMU_HWPT_FAULT_ID_VALID) &&
+	    (flags & IOMMU_HWPT_ALLOC_NEST_PARENT))
+		return ERR_PTR(-EOPNOTSUPP);
 
 	hwpt_paging = __iommufd_object_alloc(
 		ictx, hwpt_paging, IOMMUFD_OBJ_HWPT_PAGING, common.obj);
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index a1b2b657999dc..618c03bb6509b 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -439,6 +439,10 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 				    &test_hwpt_id);
 		test_err_hwpt_alloc(EINVAL, self->device_id, self->device_id, 0,
 				    &test_hwpt_id);
+		test_err_hwpt_alloc(EOPNOTSUPP, self->device_id, self->ioas_id,
+				    IOMMU_HWPT_ALLOC_NEST_PARENT |
+						IOMMU_HWPT_FAULT_ID_VALID,
+				    &test_hwpt_id);
 
 		test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
 				    IOMMU_HWPT_ALLOC_NEST_PARENT,
-- 
2.39.5




