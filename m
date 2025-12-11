Return-Path: <stable+bounces-200810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C21ECB698A
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 18:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE6E730142F3
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 16:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BBE28CF66;
	Thu, 11 Dec 2025 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZa4sc/w"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C7280A51
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765472383; cv=none; b=FDs4+oUfSGSUhAMoZJ4dEM0qCL9SlWCMKrYyQI3uocDgKvcBKZ9QO0lJUf/FLkkbMr1tUaoeKh3abyMeleoGUVD8EiONCE59rPkC93e8YHAbJ1dTDaQt7gc0gDfebrtO8n4wnadcDljnCtLUFl1buei6w4Nwl0T2hoBWFXfbTTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765472383; c=relaxed/simple;
	bh=QXDhClxx77FjRlfoI7lh96LeNFyEQPM7TrkQFQa4Q8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DmGhsX+T9pwopwZipYKUkcGMZfp2yS/PezAiP2klwNQCrouSHxLElHxz7JlCG8EuTObnur2nsb3PE6OoO3+k0Q0PxKPeOr25FkVI3CxhKbHKyGLR6u/I4uLyPTM36fcqh10q13UxiEt4RjBz1nGUEYCooyWyyZAdGPOF1Kpglq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZa4sc/w; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765472381; x=1797008381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QXDhClxx77FjRlfoI7lh96LeNFyEQPM7TrkQFQa4Q8I=;
  b=XZa4sc/w6uiMb7E215HDRHSQ/DQr/TChN/akPYm5rGTah4DsDnEZM7O1
   jJr8SQFKFbH4oxk4s05AWa8sIUoZFgw6IBB9pt4gQ5TqoRunOAeE1IJ4w
   B08V9fhHJphjGN5dDkyu6qzKNKUWJeGLokZs4jnslSQtVOrhI88wxZAqG
   1JqAQ5NM6975p/lnp5OYF6+K5HTJhBu/GeQy+/xM+UMQP915Y7bHJcudm
   Tzh8Z4FACd7FyPSQY2QJEk+qJVxbpLJbgcpryX9CIvwi65U5PPn5xdsEp
   krj/cXKVB1nwBvZ8s5EprnkLehV9wBAgXt5VW9yRLsFG3W3BlCCubItTt
   w==;
X-CSE-ConnectionGUID: xIF4SMF/SvSzEqqKXugP+Q==
X-CSE-MsgGUID: o7CGkmYbSvGskmg+gQ62/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="71083000"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="71083000"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 08:59:41 -0800
X-CSE-ConnectionGUID: PpqvRteySrmo/BUzFWQkUg==
X-CSE-MsgGUID: Z+DoleCgRD2tLoVyXI/9CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="196849431"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO fedora) ([10.245.244.197])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 08:59:38 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	apopple@nvidia.com,
	airlied@gmail.com,
	Simona Vetter <simona.vetter@ffwll.ch>,
	felix.kuehling@amd.com,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	dakr@kernel.org,
	"Mrozek, Michal" <michal.mrozek@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH v4 01/22] drm/xe/svm: Fix a debug printout
Date: Thu, 11 Dec 2025 17:58:48 +0100
Message-ID: <20251211165909.219710-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251211165909.219710-1-thomas.hellstrom@linux.intel.com>
References: <20251211165909.219710-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Avoid spamming the log with drm_info(). Use drm_dbg() instead.

Fixes: cc795e041034 ("drm/xe/svm: Make xe_svm_range_needs_migrate_to_vram() public")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: <stable@vger.kernel.org> # v6.17+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 drivers/gpu/drm/xe/xe_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 46977ec1e0de..36634c84d148 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -948,7 +948,7 @@ bool xe_svm_range_needs_migrate_to_vram(struct xe_svm_range *range, struct xe_vm
 	xe_assert(vm->xe, IS_DGFX(vm->xe));
 
 	if (xe_svm_range_in_vram(range)) {
-		drm_info(&vm->xe->drm, "Range is already in VRAM\n");
+		drm_dbg(&vm->xe->drm, "Range is already in VRAM\n");
 		return false;
 	}
 
-- 
2.51.1


