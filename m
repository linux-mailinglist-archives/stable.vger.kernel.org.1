Return-Path: <stable+bounces-176634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C17B3A4C2
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 17:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A619E987D3B
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B5F23F422;
	Thu, 28 Aug 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WsxkujFi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C41C5499
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756395770; cv=none; b=Pe0L4m5COCcI6Ycc/+wk009C8kaOq11lh/7tLdhOlTVCPP3ra99Hh2IXFcT8UU5tGi89uKRqUqxRUvcuTHGh60ENc9tEXYaMB5dKQlAYjPyYiyZJ90vOu58oQEdTF3k4t2cPKirxrzl1YS3xDiXrBwnHLUyfvV1uVWBPrhtEBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756395770; c=relaxed/simple;
	bh=qprB/o4Qkb2sysLdY6jjSZz/BY9rfxYAbw4wHDuVqUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cHZ04ZjWWMK4xTotUp5h6I7VHCgiVxrKLdpsv+1tNX7SQ5NsJtM4mlvxG5TLlfd5pdmnKAdDlXG0JEbr8H67LiaTWtgt/mIbsg4Dw/nRh/o1emnErPifez354vN7LBlwDgq8YX1B3yN2ZM92ADNDZsHgUxZ2ozPGOm0nDl7OzVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WsxkujFi; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756395770; x=1787931770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qprB/o4Qkb2sysLdY6jjSZz/BY9rfxYAbw4wHDuVqUE=;
  b=WsxkujFi33x18pP/rQu9EB8ITH6+x/B4psUBZaj/XAvM3N5cXNIL7apv
   9PwPiVo4GhnOk0iAjlNtK/u41PIqtyjP6Dc1VLnU3C+JsZzWPEoBpSmHc
   1YhD/JIqtLmCPhs+t15hybkgMKxgTnrvPac7BL2bCZmJrsmj36xjacGRy
   ur8VUSMDUEt81pYm0ioqf7OuE+p8yEz5FYaaDGmdd285C02t7d2weT6Rr
   VcNMI9m9NysE1e9X/NjOFJDzdiYnyGnJRv5AgXKYckPq1+EZMAoxiJCNh
   Sbn6SE7FDTjhEaILm1CNnzJV/oaBlEfXF188Jq2cuysXxhhhcM4UpwwZn
   Q==;
X-CSE-ConnectionGUID: BBrWQd2XQMaD4meQcPBcAw==
X-CSE-MsgGUID: rycSPq5MSdaAf/xtV0E2dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58736226"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58736226"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 08:42:47 -0700
X-CSE-ConnectionGUID: /+2DW8wZQkytX9+27IPMzw==
X-CSE-MsgGUID: szpwvT95Q/qPXASOs5XJAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="207289109"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fedora) ([10.245.245.28])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 08:42:44 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Attempt to bring bos back to VRAM after eviction
Date: Thu, 28 Aug 2025 17:42:19 +0200
Message-ID: <20250828154219.4889-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

VRAM+TT bos that are evicted from VRAM to TT may remain in
TT also after a revalidation following eviction or suspend.

This manifests itself as applications becoming sluggish
after buffer objects get evicted or after a resume from
suspend or hibernation.

If the bo supports placement in both VRAM and TT, and
we are on DGFX, mark the TT placement as fallback. This means
that it is tried only after VRAM + eviction.

This flaw has probably been present since the xe module was
upstreamed but use a Fixes: commit below where backporting is
likely to be simple. For earlier versions we need to open-
code the fallback algorithm in the driver.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5995
Fixes: a78a8da51b36 ("drm/ttm: replace busy placement with flags v6")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.9+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 4faf15d5fa6d..64dea4e478bd 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -188,6 +188,8 @@ static void try_add_system(struct xe_device *xe, struct xe_bo *bo,
 
 		bo->placements[*c] = (struct ttm_place) {
 			.mem_type = XE_PL_TT,
+			.flags = (IS_DGFX(xe) && (bo_flags & XE_BO_FLAG_VRAM_MASK)) ?
+			TTM_PL_FLAG_FALLBACK : 0,
 		};
 		*c += 1;
 	}
-- 
2.50.1


