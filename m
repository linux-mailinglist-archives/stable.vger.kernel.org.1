Return-Path: <stable+bounces-147987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E689DAC6ED3
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 19:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46294A23F70
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 17:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2E128D8D6;
	Wed, 28 May 2025 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mw6cMTAO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3C928B7E4
	for <stable@vger.kernel.org>; Wed, 28 May 2025 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452346; cv=none; b=CK+kimJqUtkml/eTJfYEP67sxGZerPxcfPgBAKSwZWSWXyN1a7hYeF1Mb7p7fN557wyh5yKTyzgcN+uZiY+HcPaGA23wi1tGPLIfdlfeg+S7Yt21OXF/7vXpFmDL334vJ479CP3O+7S2MKMr5vE6KT0xw+wnJN4qFP67XQykHT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452346; c=relaxed/simple;
	bh=2c7x03kSgZrXkfgGKN8R6F2Vjctj1uciiV21QqHMOS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQg76fW8bW5cf1t9YK1JQ/AE+oI07BBcz18aVpxmPfdqk3ESFQOCarisXMfIwmX4ejkxbf8p6zUNQHqggM/O/nB45UfqCFvVth/0TKa/dDmayV2UEez9X5P23dYqSkto+GJj/TYuf1JOithqz6hdZX7quG9vTYJ8CZdc9Ur4Zz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mw6cMTAO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748452345; x=1779988345;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2c7x03kSgZrXkfgGKN8R6F2Vjctj1uciiV21QqHMOS8=;
  b=Mw6cMTAOP57ka9gE+OffsxPwAtcZo99T6+TiJf2uujkV+HbrtgECZbW9
   ogqIluVpjZ7PlOgFC3Ib4dMYlzYHZNYDEwuCweoU3Mx4s184XHyl3K6v0
   FB0oFVp+us7TlDxqWn/JYNm3Jwsa5mtBofW8DX6jJDoewUUSwcWROtjD8
   Qqoijm9nUqax2wKmrNRgrQCYWIfelO/RBuVJqLQOh/LJ+8OSkI95+oDdO
   iyjgTNE67q1NLg00W+INResMsadimISsnsAuaUXpTh6Ij6ViJhplFpiRj
   uFxcKc419fUy7INvkZJBsQCGHctyuLb5+eukQhXZm5sncGgibqm7jjx2i
   Q==;
X-CSE-ConnectionGUID: OdMimvwHTbuCCEmHgEmxXQ==
X-CSE-MsgGUID: RnLye8qpTVOeaNicd3Dohw==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50490109"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="50490109"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 10:12:24 -0700
X-CSE-ConnectionGUID: gWwUbxDYRNOK/TYtykp2Dw==
X-CSE-MsgGUID: 5GPj5DWzSoeTDRitdy35wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="144274808"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 10:12:22 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: jeff.hugo@oss.qualcomm.com,
	lizhi.hou@amd.com,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] accel/ivpu: Fix warning in ivpu_gem_bo_free()
Date: Wed, 28 May 2025 19:12:20 +0200
Message-ID: <20250528171220.513225-1-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't WARN if imported buffers are in use in ivpu_gem_bo_free() as they
can be indeed used in the original context/driver.

Fixes: 647371a6609d ("accel/ivpu: Add GEM buffer object management")
Cc: stable@vger.kernel.org # v6.3
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
v2: Use drm_gem_is_imported() to check if the buffer is imported.
---
 drivers/accel/ivpu/ivpu_gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
index c193a80241f5f..5ff0bac739fc9 100644
--- a/drivers/accel/ivpu/ivpu_gem.c
+++ b/drivers/accel/ivpu/ivpu_gem.c
@@ -278,7 +278,8 @@ static void ivpu_gem_bo_free(struct drm_gem_object *obj)
 	list_del(&bo->bo_list_node);
 	mutex_unlock(&vdev->bo_list_lock);
 
-	drm_WARN_ON(&vdev->drm, !dma_resv_test_signaled(obj->resv, DMA_RESV_USAGE_READ));
+	drm_WARN_ON(&vdev->drm, !drm_gem_is_imported(&bo->base.base) &&
+		    !dma_resv_test_signaled(obj->resv, DMA_RESV_USAGE_READ));
 	drm_WARN_ON(&vdev->drm, ivpu_bo_size(bo) == 0);
 	drm_WARN_ON(&vdev->drm, bo->base.vaddr);
 
-- 
2.45.1

