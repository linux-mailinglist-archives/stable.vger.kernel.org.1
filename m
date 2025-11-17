Return-Path: <stable+bounces-194961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D9EC64B11
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 15:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB0B94E8FCB
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 14:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DBF3358BD;
	Mon, 17 Nov 2025 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJ05kkX2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F461248F68
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763390726; cv=none; b=my5euG/CJ7epFBz3prWgOPcEsjuGnOhAz4TOkK1kcB0PNLDTNOJTu4jCZ6lx8dvwwtnGE2sHrV2zkKiS7+wTMGprYuRp15L880Tuzob/mHJRvq/IH/blO5czX7egZIIXKSWwH1kXhDmPclph8CAEsj2SCdLMpcVXHgTyiPRnx3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763390726; c=relaxed/simple;
	bh=dK76Nyaf0ay/YG6KAgaeDEPEOr14TRNurEOcibI33/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c56kzyRq6RNa2nH1bANn5acTkVpvISOLdZoTh7HT0jwDx62SlaYwbwOW1NXqkGgHus+hcDzgk0aEXZ7BTvkNSZx7qC+7VjX2By3LRjDMGlTVuZBz0FrMqr60Ziz/70OpdNgVmckbDvnXKcZtOYSpaDTBeTpLi0KMaUDsG+kz2QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJ05kkX2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763390725; x=1794926725;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dK76Nyaf0ay/YG6KAgaeDEPEOr14TRNurEOcibI33/s=;
  b=kJ05kkX28FU3bsLiRQSBoCiAJOO0BCKfBwoYCPOnSvp5Z7IgtVkjU9dS
   Wj/aE2HhAr8Y9zBQMu7EPrn4w88WjfPal/EwzA3mwb2B713OTevhvkLY1
   Y739Llf6lP1eASGUZOgox1F98W4n+Qhd84a9BnzxfpRD8LL+eEV/mYlN+
   CcP+a3BKTCPXuauTrhQF5ZVsb4wn76w66c1n+bQgNvCi69RNrHHKRiCuS
   Cf9s0Fbzn/u9ME8Rfk8u0/XIe2K+uXv5wV9AewGvBpcrk+yN5cqfGsZur
   gch/y8vfxSY0f9EcoASvXsJ0n2QMTZEYxjxSv9tKh+651KMPj2KJU4yqH
   g==;
X-CSE-ConnectionGUID: Z0PdDKKxT0OPCH3/CScfJw==
X-CSE-MsgGUID: hF6EvfleST2CubfBBXZqNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="64594020"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="64594020"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 06:45:24 -0800
X-CSE-ConnectionGUID: y80klHGdSvmjAC9sP9mCCw==
X-CSE-MsgGUID: 72q87sJ3TJyhqWSA80jpqw==
X-ExtLoop1: 1
Received: from yadavs-z690i-a-ultra-plus.iind.intel.com ([10.190.216.90])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 06:45:22 -0800
From: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.auld@intel.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/oa: Fix potential UAF in xe_oa_add_config_ioctl()
Date: Mon, 17 Nov 2025 20:14:21 +0530
Message-ID: <20251117144420.2873155-2-sanjay.kumar.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In xe_oa_add_config_ioctl(), we accessed oa_config->id after dropping
metrics_lock. Since this lock protects the lifetime of oa_config, an
attacker could guess the id and call xe_oa_remove_config_ioctl() with
perfect timing, freeing oa_config before we dereference it, leading to
a potential use-after-free.

Fix this by caching the id in a local variable while holding the lock.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6614
Fixes: cdf02fe1a94a7 ("drm/xe/oa/uapi: Add/remove OA config perf ops")
Cc: <stable@vger.kernel.org> # v6.11+
Suggested-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_oa.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index 87a2bf53d661..8f954bc3eed5 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -2403,11 +2403,13 @@ int xe_oa_add_config_ioctl(struct drm_device *dev, u64 data, struct drm_file *fi
 		goto sysfs_err;
 	}
 
-	mutex_unlock(&oa->metrics_lock);
+	id = oa_config->id;
+
+	drm_dbg(&oa->xe->drm, "Added config %s id=%i\n", oa_config->uuid, id);
 
-	drm_dbg(&oa->xe->drm, "Added config %s id=%i\n", oa_config->uuid, oa_config->id);
+	mutex_unlock(&oa->metrics_lock);
 
-	return oa_config->id;
+	return id;
 
 sysfs_err:
 	mutex_unlock(&oa->metrics_lock);
@@ -2461,10 +2463,10 @@ int xe_oa_remove_config_ioctl(struct drm_device *dev, u64 data, struct drm_file
 	sysfs_remove_group(oa->metrics_kobj, &oa_config->sysfs_metric);
 	idr_remove(&oa->metrics_idr, arg);
 
-	mutex_unlock(&oa->metrics_lock);
-
 	drm_dbg(&oa->xe->drm, "Removed config %s id=%i\n", oa_config->uuid, oa_config->id);
 
+	mutex_unlock(&oa->metrics_lock);
+
 	xe_oa_config_put(oa_config);
 
 	return 0;
-- 
2.43.0


