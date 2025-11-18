Return-Path: <stable+bounces-195100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87555C69383
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 12:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72DC1343ED4
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 11:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ADE286A7;
	Tue, 18 Nov 2025 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AFpw+bD7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2BD347BD3
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763466609; cv=none; b=uXtpGXKzk+G8S6Y3tZjL4COPB92e6aO4RsBi+Oh0c+3la011iN/+sYpZz2XLSzDgoan4IfwoCnY/pAhzGqkN6YHsfEE99zcavtkS0fn5Dx7Xzdro+khwsDzIbhINdKq8seNn+ylJ/GOiB0ZPlfKLlQb6qCDzOziPG2R8G/H3pAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763466609; c=relaxed/simple;
	bh=pGtZMTRa56pMWjqr2HMIYai2lstNx/fgk+tjegNe5Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MA7eJm5Qyf6mlQvt8EPybT8hC87juOYnePXc+IjoT4h2l8uX2F191umJONyv0PXOD8diNiKgTaeNWxl30g3E5oGRL3oeRjEUEBDpBCd008NMER29TS0zCbpUGrKiLIgMN+Nl+g+THPzQGYR50lqM+gf1jOd3xp+Q0T7czxGEJYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AFpw+bD7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763466608; x=1795002608;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pGtZMTRa56pMWjqr2HMIYai2lstNx/fgk+tjegNe5Ok=;
  b=AFpw+bD7Uiaex91+WC4/oMVDvKr/tc6IPQbaNmFZlXSC33oERBruXrhC
   /hi+K8eXw4jsy0Wy+J0hoLsxjEAo63PXeBv5vqvxSa7eqWvyP5+Mb63xf
   UVkVaGeJUJNcNA1Q4EDOnCpcOCYbn3QXuZGVYamFh3wNHGZEvzjt1tiIr
   nXBMKKhQolTdoTKHBPb66So1CvkSMGmSTTY5zvi9UzbLraHLGQv50irLh
   tdn655y66ZyBqKQzVLcOz9bSuyIq2xNZfsXiAsBIwSTXpVBC7860wM1OO
   8fGfJvRdCxT9/DzyM0fBiPb6ILtfdHSSh65PTlbLXYk4W6zd2Ad6mUrYe
   g==;
X-CSE-ConnectionGUID: 8DT2SRKXSZGpGY7Z7c8k4Q==
X-CSE-MsgGUID: eM1dp21gStGcq90v1j6DAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="53055053"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="53055053"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 03:50:07 -0800
X-CSE-ConnectionGUID: UAz/HxPmTySJ+TDTlbIhUQ==
X-CSE-MsgGUID: O/6ip3shTFOaQBbpkUVY2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190003504"
Received: from yadavs-z690i-a-ultra-plus.iind.intel.com ([10.190.216.90])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 03:50:06 -0800
From: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.auld@intel.com,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/xe/oa: Fix potential UAF in xe_oa_add_config_ioctl()
Date: Tue, 18 Nov 2025 17:19:00 +0530
Message-ID: <20251118114859.3379952-2-sanjay.kumar.yadav@intel.com>
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

v2: (Matt A)
- Dropped mutex_unlock(&oa->metrics_lock) ordering change from
  xe_oa_remove_config_ioctl()

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6614
Fixes: cdf02fe1a94a7 ("drm/xe/oa/uapi: Add/remove OA config perf ops")
Cc: <stable@vger.kernel.org> # v6.11+
Suggested-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_oa.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index 87a2bf53d661..890c363282ae 100644
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
-- 
2.43.0


