Return-Path: <stable+bounces-147976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EA4AC6D16
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 17:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A185D3A2C43
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 15:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F01228C026;
	Wed, 28 May 2025 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dweNF/36"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF382882DE
	for <stable@vger.kernel.org>; Wed, 28 May 2025 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748446993; cv=none; b=FvcJ/Ficstaa4C9EiMTDW8JUlTlcswrh2lzrtirscDI4f08RCRL51spqOidyppUbZAzeuxR514z+VYLDPB1mzFnBbBsuge+eOJpyan+rNGiOSr2qdtbRf8SNqDOZ8rzWDxfbiL+sVHB8LfDXR4r+0yHGqYhadGT7nekwfdgKDJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748446993; c=relaxed/simple;
	bh=LT5sZcgWanipbC74Xj2ValyaujbUYodZaj1yLXjvPK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O81Z3eH07/RJbZr3Jfl+NPdEhpcUHvHaP47vxcI4k1r61Rb2bo2FxL5VoBolQUh1FNlKDtVGbYrQn5ieHXhCESUPG3TvxB/S7a1edRYp8yehwxW2mRDtadBsyWZE/trR/NbmdpDAh6mdAW2VtGi4gUegVcL7rbdmoSt6T8C17lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dweNF/36; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748446992; x=1779982992;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LT5sZcgWanipbC74Xj2ValyaujbUYodZaj1yLXjvPK0=;
  b=dweNF/36t+DppU1C8cZZlJ1yaRJz3hOJ98xCmg4GIlI907jWdJH2quXq
   IcebtND6Z4ghGDRKcPPAM56m+InW9LhKtIKua3o+WGiRHjKDRdJ900E7s
   HdsrsiLJzTqnNz/oIQEJC8QmdgZ9em8AtcykaumbG8hhGDbXViyhgBbvg
   FbwsbtxLrDKCUr+pejgM4Te+wuxTOjmkvDTyupz/JypC7hZijqWwTSP45
   zuGZ8yemVlFd4qb/zf9oi7jw66oeKyj9bMWM0PyO8kqWuTN2U9QpKuKHj
   41hMm8nCCEb89LA6oyWb2ernyKig9v3+rgaSgHNdwJjKsDYRCLETiU/kX
   A==;
X-CSE-ConnectionGUID: 08kLMRp0Rb29caGYZ5TWAg==
X-CSE-MsgGUID: J6Twj6osQEiCYPjLPUA1qA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="38105659"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="38105659"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 08:43:11 -0700
X-CSE-ConnectionGUID: 8BF1fk8GRz+JTiNwBoudOQ==
X-CSE-MsgGUID: ZGfro0/UQr64SyryR9dtzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="148409607"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 08:42:27 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: jeff.hugo@oss.qualcomm.com,
	lizhi.hou@amd.com,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] accel/ivpu: Fix warning in ivpu_gem_bo_free()
Date: Wed, 28 May 2025 17:42:25 +0200
Message-ID: <20250528154225.500394-1-jacek.lawrynowicz@linux.intel.com>
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
Cc: <stable@vger.kernel.org> # v6.3
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
index 5908268ca45e9..0371a8b4a474f 100644
--- a/drivers/accel/ivpu/ivpu_gem.c
+++ b/drivers/accel/ivpu/ivpu_gem.c
@@ -285,7 +285,8 @@ static void ivpu_gem_bo_free(struct drm_gem_object *obj)
 	list_del(&bo->bo_list_node);
 	mutex_unlock(&vdev->bo_list_lock);
 
-	drm_WARN_ON(&vdev->drm, !dma_resv_test_signaled(obj->resv, DMA_RESV_USAGE_READ));
+	drm_WARN_ON(&vdev->drm, !bo->base.base.import_attach &&
+		    !dma_resv_test_signaled(obj->resv, DMA_RESV_USAGE_READ));
 	drm_WARN_ON(&vdev->drm, ivpu_bo_size(bo) == 0);
 	drm_WARN_ON(&vdev->drm, bo->base.vaddr);
 
-- 
2.45.1


