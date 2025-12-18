Return-Path: <stable+bounces-203016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E569CCCBDD
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 17:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB0923011416
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 16:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3A036D4F3;
	Thu, 18 Dec 2025 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aja0b9fZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECF132C933
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766074898; cv=none; b=SuxQh4vol9ag+zLAZSyLijOSD6865jja6RGSR0v+3KkkmKEeNWW3+D5wV+JsZ/u93OL5TMGZgpE8XAsMLanm55+VAIUfV9+CICV5s2Izw23aXbWsNTuZvTXIdCCt8s4Nd6feQyPAl4qaGmpZ3IUucApokS0OjnOTsLxO+IF3cGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766074898; c=relaxed/simple;
	bh=4bv3Gk1Rp61YDnZYdNpxoF/HsUv0eSFoQ9vGbwmYIKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoczvNtw/DugBZ0y637nfyYBgJs1b9QHcQUhGlDAlH5CTHj7dN23LE6hJwlspumk95uwCUbRVXwVySvfDPNXP7mpTbf2vztu8+7YrbI2PBBAYofNdaRIX1bEn4R4msl1joiRERCkTs2urey19mvDQq9udGQnIzC4fIuFI0fCv68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aja0b9fZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766074897; x=1797610897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4bv3Gk1Rp61YDnZYdNpxoF/HsUv0eSFoQ9vGbwmYIKg=;
  b=aja0b9fZ+b1kLR8dPq0NrIOLEp+12ERBPtXytSj/ws5Tzatvw/3n6eJ6
   eJ3SshWhgIYQAZxlhLtcs5CwbONHvbJ+9U4GURHO8F9NrxC36AIk1Uz1J
   8uEIJVRYozF/ZqIJUfh2WWgMVviX0aKapREK8mcjUVid/367GwiREMyxH
   gwKa0vf+JdLcgmwypNnfZ7tFSleh+g9yQ/wLHbXsYfhB3fywF+pQUVtec
   WOkpjcQANrImf+Aoq9w0vI3Ss6nXLS8WdeaBHqUfamVx5AYwjVv+optfg
   4PLY8SXHIiSPCKwdND1TAacxZcD3w+qqMhQdX/1iqDGBftPoF61ATt7ak
   g==;
X-CSE-ConnectionGUID: Sa7+oTWqQ5mEZi5Pbrqoyw==
X-CSE-MsgGUID: NLoO0jNLTW6DebWv31VAIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="70607538"
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="70607538"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 08:21:37 -0800
X-CSE-ConnectionGUID: sKcbm9hASBWrsGAQiZo6/Q==
X-CSE-MsgGUID: BnAcDUpOSlucwR+uW3AKyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="203705525"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO fedora) ([10.245.244.93])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 08:21:33 -0800
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
Subject: [PATCH v5 01/24] drm/xe/svm: Fix a debug printout
Date: Thu, 18 Dec 2025 17:20:38 +0100
Message-ID: <20251218162101.605379-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251218162101.605379-1-thomas.hellstrom@linux.intel.com>
References: <20251218162101.605379-1-thomas.hellstrom@linux.intel.com>
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
index 93550c7c84ac..bab8e6cbe53d 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -937,7 +937,7 @@ bool xe_svm_range_needs_migrate_to_vram(struct xe_svm_range *range, struct xe_vm
 	xe_assert(vm->xe, IS_DGFX(vm->xe));
 
 	if (xe_svm_range_in_vram(range)) {
-		drm_info(&vm->xe->drm, "Range is already in VRAM\n");
+		drm_dbg(&vm->xe->drm, "Range is already in VRAM\n");
 		return false;
 	}
 
-- 
2.51.1


