Return-Path: <stable+bounces-180655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB73BB896C9
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 14:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A809C1C879A9
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 12:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C38130FF3A;
	Fri, 19 Sep 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jk0hLOvy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A2B30FF2B
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284485; cv=none; b=HtMoxPZ0L/lbbav+KyJ3WT4KA7kPwDUoIV00X4Po967m3CC/UkfsaPcDm7c04z90kkTHAS83zlTZo8w1DUY3skBY9K1oQZiKp1OwtJIaY6GPBLWN5pkXM/UOzkm7riupWt4FncbGInC1XgmpGxwtGpFPiBq4P7ue88nYCTYE+3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284485; c=relaxed/simple;
	bh=CtLde+7URGIHYifQpHPiGY5XpB+j9DfJisqjZxT834c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T1/mESz1gLEEH+GcgNhUUEvB0DVDWX79GR14jSwZPQFqBeFOQx+atU08p4WyeTJ0Xw3TlRztXEwzI3Lc3iixqivmTLUIhD/ttsaDgZVJuOuEUXIBwaDh04swhHK4YYh0DTJIIw5UxdccD9gQ8GUtp0YKsWlRucR9OawL3q8SYhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jk0hLOvy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758284483; x=1789820483;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CtLde+7URGIHYifQpHPiGY5XpB+j9DfJisqjZxT834c=;
  b=Jk0hLOvyCliWOpWKdEaWWUypnWw/ulYCzRuukg3vzULS6CEGsgdmavXB
   zmiNwpFftmoE02d4KCBz+ouEnDIxCNo9kLTTT2RhPl5DbwRFkiOCIvwVm
   RpB/WqJpUJy7M1v9kmyPl3TF2d6Sjez/rFpCzSewJ0qvfBsWo+Q4BcOAU
   G4J9Gq55Jo/OVKbtyxmFqN2+DPy46XjRx2vEPJJ4xlRX6MF2FlCGuxPgZ
   ypjrwxb9wrokRGgYkdHYGzmhDqwaxD9NQdABUPUghsz5BWaMNO3PhsNM8
   fbUeprgeip4JtlDGaA1xs0e8OgRtU8j5BCkp6ENF42IsRUvx5diDotsvK
   g==;
X-CSE-ConnectionGUID: eoKvm8L3ThCa8FVjL9nywg==
X-CSE-MsgGUID: AoA/KegMQ3+9UPpwd1p7VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60517453"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="60517453"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 05:21:23 -0700
X-CSE-ConnectionGUID: Sr+nJhESTj2lq2m9TMWH+Q==
X-CSE-MsgGUID: xsPPbWPiR2mYDC2Awlm+5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="206766345"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.133])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 05:21:20 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Joshua Santosh <joshua.santosh.ranjan@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/uapi: loosen used tracking restriction
Date: Fri, 19 Sep 2025 13:20:53 +0100
Message-ID: <20250919122052.420979-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently this is hidden behind perfmon_capable() since this is
technically an info leak, given that this is a system wide metric.
However the granularity reported here is always PAGE_SIZE aligned, which
matches what the core kernel is already willing to expose to userspace
if querying how many free RAM pages there are on the system, and that
doesn't need any special privileges. In addition other drm drivers seem
happy to expose this.

The motivation here if with oneAPI where they want to use the system
wide 'used' reporting here, so not the per-client fdinfo stats. This has
also come up with some perf overlay applications wanting this
information.

Fixes: 1105ac15d2a1 ("drm/xe/uapi: restrict system wide accounting")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Joshua Santosh <joshua.santosh.ranjan@intel.com>
Cc: José Roberto de Souza <jose.souza@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_query.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
index e1b603aba61b..2e9ff33ed2fe 100644
--- a/drivers/gpu/drm/xe/xe_query.c
+++ b/drivers/gpu/drm/xe/xe_query.c
@@ -276,8 +276,7 @@ static int query_mem_regions(struct xe_device *xe,
 	mem_regions->mem_regions[0].instance = 0;
 	mem_regions->mem_regions[0].min_page_size = PAGE_SIZE;
 	mem_regions->mem_regions[0].total_size = man->size << PAGE_SHIFT;
-	if (perfmon_capable())
-		mem_regions->mem_regions[0].used = ttm_resource_manager_usage(man);
+	mem_regions->mem_regions[0].used = ttm_resource_manager_usage(man);
 	mem_regions->num_mem_regions = 1;
 
 	for (i = XE_PL_VRAM0; i <= XE_PL_VRAM1; ++i) {
@@ -293,13 +292,11 @@ static int query_mem_regions(struct xe_device *xe,
 			mem_regions->mem_regions[mem_regions->num_mem_regions].total_size =
 				man->size;
 
-			if (perfmon_capable()) {
-				xe_ttm_vram_get_used(man,
-					&mem_regions->mem_regions
-					[mem_regions->num_mem_regions].used,
-					&mem_regions->mem_regions
-					[mem_regions->num_mem_regions].cpu_visible_used);
-			}
+			xe_ttm_vram_get_used(man,
+					     &mem_regions->mem_regions
+					     [mem_regions->num_mem_regions].used,
+					     &mem_regions->mem_regions
+					     [mem_regions->num_mem_regions].cpu_visible_used);
 
 			mem_regions->mem_regions[mem_regions->num_mem_regions].cpu_visible_size =
 				xe_ttm_vram_get_cpu_visible_size(man);
-- 
2.51.0


