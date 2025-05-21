Return-Path: <stable+bounces-145788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8C5ABEEE8
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 11:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52654E3F72
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 09:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A95F239E78;
	Wed, 21 May 2025 09:01:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8F3238D56
	for <stable@vger.kernel.org>; Wed, 21 May 2025 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747818096; cv=none; b=O8jrmmaQEUn5vsJZPxg91JTmsqJAkdfVN/Z7krJO4why5ECehNAPUb00JELWh8NWU3OJNldacRRsI4YTJHVMvzxkGM/ny2Q8hOVBccZileSsTywSXkV90W0X/EXTNijv70KhSve/724dXH5BkdhR6ZzFUmxoNiaBrQhVxd0u4+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747818096; c=relaxed/simple;
	bh=mwyD8Vk6eL2whh1xiD7nyf4HCpxkD4XoxRIhnI/DMhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FkDPMBgmrvIEBDfOY2DTaGI6yq0Tg2OhrUMRy8lJdwhk9P1ReRz8UOMSYEDs7ydTnaXpX7j0oh6vjnnL7WXxgmrhVMSTf7Aa0FP4Pwc8Mv5rJqcamKsUFD/jj95FQ2Uhfdm1kqgGIKxd1HHt2R++JzFTLeAt+saSezbiXW6/V+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se; spf=none smtp.mailfrom=mblankhorst.nl; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mblankhorst.nl
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-xe@lists.freedesktop.org
Cc: Maarten Lankhorst <dev@lankhorst.se>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Subject: [PATCH] drm/xe/svm: Fix regression disallowing 64K SVM migration
Date: Wed, 21 May 2025 11:01:02 +0200
Message-ID: <20250521090102.2965100-1-dev@lankhorst.se>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When changing the condition from >= SZ_64K, it was changed to <= SZ_64K.
This disallows migration of 64K, which is the exact minimum allowed.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5057
Fixes: a9ac0fa455b0 ("drm/xe: Strict migration policy for atomic SVM faults")
Cc: stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/xe/xe_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 4432685936ed4..a7386334d48c4 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -820,7 +820,7 @@ bool xe_svm_range_needs_migrate_to_vram(struct xe_svm_range *range, struct xe_vm
 		return false;
 	}
 
-	if (preferred_region_is_vram && range_size <= SZ_64K && !supports_4K_migration(vm->xe)) {
+	if (preferred_region_is_vram && range_size < SZ_64K && !supports_4K_migration(vm->xe)) {
 		drm_warn(&vm->xe->drm, "Platform doesn't support SZ_4K range migration\n");
 		return false;
 	}
-- 
2.45.2


