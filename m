Return-Path: <stable+bounces-151451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1065ACE438
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 20:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E273A6981
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 18:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88967149C55;
	Wed,  4 Jun 2025 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PeJnMTFs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A625F139D
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 18:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749060934; cv=none; b=GzvU1K8NnN5mmvOQuZUiMUiXqw1Gdmq87nrV1tFhBxs+LsWAVWGt5TCW9PCKLYRgAhfiecBcZ3hITXPkFGPers2hrdOkjSin1rNefpCDcJW2xorr+YSmVseXVOKPX2k2HPBsAEHn2zpPjAqzObrqsZv6qjCJC4Mixx9wruYsJ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749060934; c=relaxed/simple;
	bh=948vh3L8Tx7Qm7lhprg157od+0HlbEqVHoTeogZvXGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f4P8aPJ3k4Mx38chdxXojHIWOazsXVSPvW/askBXmnIPZvbOKH4keFh+eT/vRkSHmvglhDIhccvtiIY3q+HQj//esWM/+xLw9RgMw0h58mIHiyEV0QCcoYge1T3lyyVs8ADeI26HpcNuQo6Ij56xIY+cXSoc9sgXyLwMCy/qQ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PeJnMTFs; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749060933; x=1780596933;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=948vh3L8Tx7Qm7lhprg157od+0HlbEqVHoTeogZvXGA=;
  b=PeJnMTFsmPwc7hR6/9Vnqgk2YWbzxbcfWte7HXHonijtFN7LufeFpebl
   3myWsDWT6dj6UakW/MYnNCZPabNl9be4s5FdgghTMKgSwteCEolJX3eDx
   fNLjb5zFeztV64zhb79zGqSUMIV8xs2LPmAX2lpG38mvpEMMfN2XqpCZr
   UmG+dMKUpN3n0q7ZXbQiBEvHam1e/CuAl7N81U1cDCS4mxKzgy2Q2WozZ
   Q40XTWfT7dF1tSU30cYeH8knT9tj9An0rSaEikmrcgNFLxSja4ZmgSsIF
   ZlyPQyoWvlgh8Ng4hcmbk+srCWY7KEyL/SE8KC0gnUgBUcQFfOWxd/QnJ
   Q==;
X-CSE-ConnectionGUID: sJPbPXlgRIighSbJth4mIg==
X-CSE-MsgGUID: awfot2pLSPiCTIp9VIQqOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51078795"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="51078795"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 11:15:32 -0700
X-CSE-ConnectionGUID: Ljzs93qnTGS/CVtExD4NXA==
X-CSE-MsgGUID: 1NIBJ8F1T4SMxFzULJnegw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="145863800"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.107])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 11:15:31 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Akshata Jahagirdar <akshata.jahagirdar@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/bmg: fix compressed VRAM handling
Date: Wed,  4 Jun 2025 19:15:12 +0100
Message-ID: <20250604181511.1629551-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There looks to be an issue in our compression handling when the BO pages
are very fragmented, where we choose to skip the identity map and
instead fall back to emitting the PTEs by hand when migrating memory,
such that we can hopefully do more work per blit operation. However in
such a case we need to ensure the src PTEs are correctly tagged with a
compression enabled PAT index on dgpu xe2+, otherwise the copy will
simply treat the src memory as uncompressed, leading to corruption if
the memory was compressed by the user.

To fix this it looks like we can pass use_comp_pat into emit_pte() on
the src side.

There are reports of VRAM corruption in some heavy user workloads, which
might be related: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4495

Fixes: 523f191cc0c7 ("drm/xe/xe_migrate: Handle migration logic for xe2+ dgfx")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
---
 drivers/gpu/drm/xe/xe_migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index 8f8e9fdfb2a8..16788ecf924a 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -863,7 +863,7 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
 		if (src_is_vram && xe_migrate_allow_identity(src_L0, &src_it))
 			xe_res_next(&src_it, src_L0);
 		else
-			emit_pte(m, bb, src_L0_pt, src_is_vram, copy_system_ccs,
+			emit_pte(m, bb, src_L0_pt, src_is_vram, copy_system_ccs || use_comp_pat,
 				 &src_it, src_L0, src);
 
 		if (dst_is_vram && xe_migrate_allow_identity(src_L0, &dst_it))
-- 
2.49.0


