Return-Path: <stable+bounces-176609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FB8B39F55
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 15:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE72E1C20784
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 13:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD9220469E;
	Thu, 28 Aug 2025 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SW+TH2qm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318C1C7013
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388969; cv=none; b=DHBRA7zio5szl1egNYLTiBWKn7Po0yoPkuK5TEQcaj9Kdc8TKmX6P8WoPIKqsSYZaKGaulj6z129OcznGtknA9OEgXcJVRoJGcBGsKw5aE8uBj6IPJF4GjyTtoUuX6kAxJVVa1INL/X/UpeNj8LhSQAKe4otjOji9Wj4TOrbbvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388969; c=relaxed/simple;
	bh=uNqMlwNAprobxNq2xZjNObxF1fqLB1cBb3OHEgjv02I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IQgeWDIJmKchh4hzUkMMARKNLczJZonScj0pF87jOMXWneSmiHhp/MgrkUNXcwyjDEs8MfHekPbKNLxA4J8OwPRmrwuHJuTSFQiA9kfat6W+UCeBlNdHqWxH71ND5swJjhSYNgNoDJ/G1ktKiTd65SO1dKZxGi2lLSrpyn9Kg3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SW+TH2qm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756388967; x=1787924967;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uNqMlwNAprobxNq2xZjNObxF1fqLB1cBb3OHEgjv02I=;
  b=SW+TH2qmdxrNOCNECbnsqgh5WIagWW0AGxmlH48AHEaacdPzAwpAEL8D
   Z3eSZnnG2vgyHR8f5jEWQIDhig/MB/Qz9K9uiYxW9uTTEr1BNSQdH0XtK
   ZCXa7fDd/s4YJ/zBw8ekuPy8/0qGmfWVynJwV49G3RelIKsJ0ai3vFBo6
   41zPT/ibJdAYaFMrNnAxWPVoz/Kdelc6a1O7DjD1RfAEI7IqWBNke8qVc
   PtOGqxCvNa74D1dZ2BjNvYiVey7sSgbrRyax1jeVnSrBYlfCVwmFyhIxJ
   8o86cYuQFWzH02EqWzRzWJm3fnl5vjcq37KIJ4FQgOZD4JRKBOi6/qlNY
   w==;
X-CSE-ConnectionGUID: nl53yfcmTqayZ3UpE2gHBg==
X-CSE-MsgGUID: RvsDBV3MSSiCJW/l37Pmiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="62480622"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="62480622"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 06:49:26 -0700
X-CSE-ConnectionGUID: BgWa5zq+Sxy8wzo9iwGOOA==
X-CSE-MsgGUID: k+3pSTYBS2eTJBYButisOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169363730"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fedora) ([10.245.245.28])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 06:49:25 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Fix incorrect migration of backed-up object to VRAM
Date: Thu, 28 Aug 2025 15:48:37 +0200
Message-ID: <20250828134837.5709-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If an object is backed up to shmem it is incorrectly identified
as not having valid data by the move code. This means moving
to VRAM skips the -EMULTIHOP step and the bo is cleared. This
causes all sorts of weird behaviour on DGFX if an already evicted
object is targeted by the shrinker.

Fix this by using ttm_tt_is_swapped() to identify backed-up
objects.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5996
Fixes: 00c8efc3180f ("drm/xe: Add a shrinker for xe bos")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.15+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 7d1ff642b02a..4faf15d5fa6d 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -823,8 +823,7 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 		return ret;
 	}
 
-	tt_has_data = ttm && (ttm_tt_is_populated(ttm) ||
-			      (ttm->page_flags & TTM_TT_FLAG_SWAPPED));
+	tt_has_data = ttm && (ttm_tt_is_populated(ttm) || ttm_tt_is_swapped(ttm));
 
 	move_lacks_source = !old_mem || (handle_system_ccs ? (!bo->ccs_cleared) :
 					 (!mem_type_is_vram(old_mem_type) && !tt_has_data));
-- 
2.50.1


