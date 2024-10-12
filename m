Return-Path: <stable+bounces-83510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 390F399B05C
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 05:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3B31F21C46
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 03:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F9B84A27;
	Sat, 12 Oct 2024 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BD+0rAkO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A950C83A09;
	Sat, 12 Oct 2024 03:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728702726; cv=none; b=uPfHTRJ1sgO5ytPO6Ju75vlSC0YbFAymZ23j+xm/YcYKptisW2jVKtfFySqvADie8g7ZMEaBp3pEAurdgVrJU6m98gcg/BmPwKPDGkO34511I3nU27zoHcZlCkA702Q0ZQAtqwZKqMQM5nvJ0qY+pWrLMaKWT9v+C69HUf7ivew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728702726; c=relaxed/simple;
	bh=N6QnKyCgH86gZ1rm4E6UpKa9Rp30p/4gvNo01+zrWLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VhzmzutwJj47WYXyZo5g4U99FdxR4PEzLcw2VaoTIdt11L3FitAIkE9WWXqOI6nBDcd1OQL2My46sFAeDIukj6SQDArGWA8gpbuhgwn2UID3TP42XhXckvLnfAz+3yBtWhtZpTk/+/nfcPE9ogeJGAFyZ1Ugg+cmkw8G9xhVJ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BD+0rAkO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728702725; x=1760238725;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N6QnKyCgH86gZ1rm4E6UpKa9Rp30p/4gvNo01+zrWLU=;
  b=BD+0rAkO121UOxcydhP8RBIFYet/L8217N2Ji+xs/4E8Xma51dzVExyu
   WY1BfM3v8y67T408jqC4GKqEJHmvPnDWi44EzzcZSM7BZqTEp5WbhG1Fs
   0h3pNyo8lJoH01WcmeQJkzX2ykQ2wZFw7V24iF1XnAst42wH6EoEXVdW1
   Hxn1eIfHnVvh9zBNyCIaQCAfMk2msXMvbf2J8G+bRFGs3HF/3fPAbhOPG
   ypEJVPL+r0MYeov7db9EN+WrHOPUo+W8+bfY+x/wjJE7Y0EsAjKKKOCSt
   CqNwZWtvHwOhsq6c0Bf9oLmJpuRFL5epJ2VzS7NcSeDwvHWeMH3bCA6qA
   w==;
X-CSE-ConnectionGUID: HUbSiW75QMur1aOsMRQqjQ==
X-CSE-MsgGUID: CL1Y7wfwQd2eeZEsrbkXCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53538813"
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="53538813"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 20:12:04 -0700
X-CSE-ConnectionGUID: 6oBZTLuaRVOQ+Xz/37utTw==
X-CSE-MsgGUID: OWcJ48xrQy2eGmlBYI3UuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="76707677"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa006.fm.intel.com with ESMTP; 11 Oct 2024 20:12:02 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Todd Brandt <todd.e.brandt@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Fix incorrect pci_for_each_dma_alias() for non-PCI devices
Date: Sat, 12 Oct 2024 11:07:20 +0800
Message-ID: <20241012030720.90218-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the domain_context_clear() function incorrectly called
pci_for_each_dma_alias() to set up context entries for non-PCI devices.
This could lead to kernel hangs or other unexpected behavior.

Add a check to only call pci_for_each_dma_alias() for PCI devices. For
non-PCI devices, domain_context_clear_one() is called directly.

Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219363
Fixes: 9a16ab9d6402 ("iommu/vt-d: Make context clearing consistent with context mapping")
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9f6b0780f2ef..e860bc9439a2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3340,8 +3340,10 @@ static int domain_context_clear_one_cb(struct pci_dev *pdev, u16 alias, void *op
  */
 static void domain_context_clear(struct device_domain_info *info)
 {
-	if (!dev_is_pci(info->dev))
+	if (!dev_is_pci(info->dev)) {
 		domain_context_clear_one(info, info->bus, info->devfn);
+		return;
+	}
 
 	pci_for_each_dma_alias(to_pci_dev(info->dev),
 			       &domain_context_clear_one_cb, info);
-- 
2.43.0


