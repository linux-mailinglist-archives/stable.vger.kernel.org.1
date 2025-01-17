Return-Path: <stable+bounces-109332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA5DA14955
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 06:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2517D3AA571
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 05:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B837A1F75A5;
	Fri, 17 Jan 2025 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTFtUjYO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC701F63DA;
	Fri, 17 Jan 2025 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737093489; cv=none; b=JUqRxTUE2rd8aoKdZmXVlj1mV18JfPCOQql4wrUQ/9WFpTy87YCRPBfHtodN7LGFWAW3HA4irj6/Tb36VhHe6HuQasZOkCM35SjakGNKIjBdb8DjX+mZy6RTP289rHlKm6npsRWdr4umb/T1gYqMRd0BD7Voays7Y7UhPr3PI2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737093489; c=relaxed/simple;
	bh=+kcoySkgROkhJ4tv29JfS+a6mLoaYbXqsYJmh8hg158=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ie667m7IDI3JXlb/ayGhfLfn9Tj58KODXr4EhA8ipV/sRFNmCfbeOjSQegScfSvsuPlfuOGVQT09JEV3vuimFotMIxmVY9y69LA0sDD4gqqJbvWngiSt5j5ayMT/dxbCbCktuN77/euT5BYEfTxk0STNBjzIo3/hbOrgsHuVa9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTFtUjYO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737093488; x=1768629488;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+kcoySkgROkhJ4tv29JfS+a6mLoaYbXqsYJmh8hg158=;
  b=DTFtUjYO4i7F1e/JPl2oAmk7jEDspZMJJiLTdWfVhNx7LO8lZDfwjWV8
   jyLKkthiSaSMI0xwtKhqavH3HsuwAJU8KcvZJD21hItcuN6r73lx8n7aR
   Tn7ycMs6o97Yv99b5ngfZB8/y/DOjhtNgyGxAwVUtGy004a7tISD++RXK
   208nIUncnjtZ7YBZOv2RhSBmjeAuU0AO55rvmWHf0e8pZsCQvAcmeI+NI
   tY7G13ydT/UM0OO9K+rVfB13+OuZcNGEP1gK/9pnM85XWPEPvqlTaDFa+
   Px3h+tLQA54KzYAwwJ2YYT/axv/wQAU3+pAL9zzW4x5pXXX7Wsmf+J8kt
   Q==;
X-CSE-ConnectionGUID: pT9K1YGQRlCFO1/yo/o5Mg==
X-CSE-MsgGUID: u+YWNkFXSHikoxxohoG/KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37208545"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="37208545"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 21:58:08 -0800
X-CSE-ConnectionGUID: kX3c7vIqS5amtb1bYzcWnw==
X-CSE-MsgGUID: M2U8d5+7Tpu0UxpHQix4cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105554768"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa010.jf.intel.com with ESMTP; 16 Jan 2025 21:58:05 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] iommu: Fix potential memory leak in iopf_queue_remove_device()
Date: Fri, 17 Jan 2025 13:58:00 +0800
Message-ID: <20250117055800.782462-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iopf_queue_remove_device() helper removes a device from the per-iommu
iopf queue when PRI is disabled on the device. It responds to all
outstanding iopf's with an IOMMU_PAGE_RESP_INVALID code and detaches the
device from the queue.

However, it fails to release the group structure that represents a group
of iopf's awaiting for a response after responding to the hardware. This
can cause a memory leak if iopf_queue_remove_device() is called with
pending iopf's.

Fix it by calling iopf_free_group() after the iopf group is responded.

Fixes: 199112327135 ("iommu: Track iopf group instead of last fault")
Cc: stable@vger.kernel.org
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/io-pgfault.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 4674e618797c..8b5926c1452e 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -478,6 +478,7 @@ void iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 
 		ops->page_response(dev, iopf, &resp);
 		list_del_init(&group->pending_node);
+		iopf_free_group(group);
 	}
 	mutex_unlock(&fault_param->lock);
 
-- 
2.43.0


