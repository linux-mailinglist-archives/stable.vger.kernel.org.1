Return-Path: <stable+bounces-94668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B6C9D6535
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF3CB234D3
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852E31DFDBF;
	Fri, 22 Nov 2024 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lua+aeC1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED581DF72C
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309677; cv=none; b=QTqYE3AQM2/EfBKkFkCE1FKwIXBge5utgbpW4McFpn4KBgI0bQnDjtVERFThNTdzSEhaPh5+mXaEM5csQUKyS7Wbb3szEzNygfofvZMhOXdhmmKrP20XYpmu17ZkN3ed9hRvZO1IJmnEY7P2IW7H+meVZwYhEmlrFl/SRgqRj58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309677; c=relaxed/simple;
	bh=h1vRU+qpHrwSjwl9f1Uoup+Ovj+610GKA0CqaxXmkZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLdIjrFTClHwdFypBxFK678C41hvyncf7gKuBa65sIKlsVAfAlZ1E74PfyFi/3BBBrvFpZmDRk4+78Ql4zCLnFO/hrBQ1VR5J5qDXaWn0KUYcyxk/r3IPYI9JeEfOrjX6OjHEO64v6+RCieJ8h41OGDMZ2DWncM7JQSmKacgWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lua+aeC1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309675; x=1763845675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h1vRU+qpHrwSjwl9f1Uoup+Ovj+610GKA0CqaxXmkZ0=;
  b=Lua+aeC1q1qYG3xLjHp48p8/7ywEZYCXkOkL6f6pZBqWoaRj/TYmtHQW
   llYeplEFbCUYDjJiHEbBUxkYkGXc4Az53ylkz9RCPrA6aCSUtDMV30j3c
   JzKgDsYpiqRFhh45OnxEfohizHm+Lb/kGPaK9lBY/AdiuivblpRrPsC3t
   Vml/gn+86HxQ2qB6BKFmvHg3tc7jLdYBQMRXcSlwmoBvatSbmS0uz2ssv
   AEVG69BU63XKPRmRzxVud4TixGuuOQOQulJM5BWwawFoZLG8f3wfOv38z
   Q24yBNlJVpfJh19fdoPsrVP5m49hL021zA/nW4va07zbEhcUfPb/g2HiB
   g==;
X-CSE-ConnectionGUID: 7vlRwUL7QIWuTiXKhShJ0g==
X-CSE-MsgGUID: iU2e44UdQl6jWlMZKY4HjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878288"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878288"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:44 -0800
X-CSE-ConnectionGUID: vtCNgEd2TfC/Z8SaashT0Q==
X-CSE-MsgGUID: 02UPNTM9TVqpQhgHCdtJCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457303"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:44 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	He Lugang <helugang@uniontech.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 31/31] drm/xe: use devm_add_action_or_reset() helper
Date: Fri, 22 Nov 2024 13:07:19 -0800
Message-ID: <20241122210719.213373-32-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122210719.213373-1-lucas.demarchi@intel.com>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: He Lugang <helugang@uniontech.com>

commit cb58977016d1b25781743e5fbe6a545493785e37 upstream.

Use devm_add_action_or_reset() to release resources in case of failure,
because the cleanup function will be automatically called.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: He Lugang <helugang@uniontech.com>
Link: https://patchwork.freedesktop.org/patch/msgid/9631BC17D1E028A2+20240911102215.84865-1-helugang@uniontech.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit fdc81c43f0c14ace6383024a02585e3fcbd1ceba)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_gt_freq.c  | 4 ++--
 drivers/gpu/drm/xe/xe_gt_sysfs.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_freq.c b/drivers/gpu/drm/xe/xe_gt_freq.c
index 68a5778b4319f..ab76973f3e1e6 100644
--- a/drivers/gpu/drm/xe/xe_gt_freq.c
+++ b/drivers/gpu/drm/xe/xe_gt_freq.c
@@ -237,11 +237,11 @@ int xe_gt_freq_init(struct xe_gt *gt)
 	if (!gt->freq)
 		return -ENOMEM;
 
-	err = devm_add_action(xe->drm.dev, freq_fini, gt->freq);
+	err = sysfs_create_files(gt->freq, freq_attrs);
 	if (err)
 		return err;
 
-	err = sysfs_create_files(gt->freq, freq_attrs);
+	err = devm_add_action_or_reset(xe->drm.dev, freq_fini, gt->freq);
 	if (err)
 		return err;
 
diff --git a/drivers/gpu/drm/xe/xe_gt_sysfs.c b/drivers/gpu/drm/xe/xe_gt_sysfs.c
index a05c3699e8b91..ec2b8246204b8 100644
--- a/drivers/gpu/drm/xe/xe_gt_sysfs.c
+++ b/drivers/gpu/drm/xe/xe_gt_sysfs.c
@@ -51,5 +51,5 @@ int xe_gt_sysfs_init(struct xe_gt *gt)
 
 	gt->sysfs = &kg->base;
 
-	return devm_add_action(xe->drm.dev, gt_sysfs_fini, gt);
+	return devm_add_action_or_reset(xe->drm.dev, gt_sysfs_fini, gt);
 }
-- 
2.47.0


