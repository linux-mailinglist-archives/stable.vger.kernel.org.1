Return-Path: <stable+bounces-89191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6909B49EE
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 13:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718BF2842B1
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 12:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094C218871A;
	Tue, 29 Oct 2024 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XXXo9dbm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4488C2C6
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205805; cv=none; b=CcGZdRQnufAknOEz48zGfuqRnUxO6SU6gbJpuNmTAhGlurAea2SYyXi5I0HFOiv6Uk5B0z2Kj2vRebeOevrfG/Au/Bt4/jNdAGldmZ5hWZHBuP92sH3MmTdKb9TuPMeP3E/BtutJ6dflXNUZSLgbEpwZqViIcppTktnodFpCPYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205805; c=relaxed/simple;
	bh=+c7uqtwM0LtCVyXtTwKf77mzC8r+EFwaFYB6Ujodsbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEyP2U0mRwSpBUbae6xoe0ZVFDfODKdjrJ6glH4jOZ2JNA6Rvh/ClBDoJdIqNyR762FNr96o557iMQHg5/RZDbx0iCe2eOQzpQGb25+K0tT5RPXcZ8o9ak/OrFMJsnJ9EYRPk+9vPHgRI8zzs9UHCoSY7n0AUxEdEY5RHd1EYJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XXXo9dbm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730205804; x=1761741804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+c7uqtwM0LtCVyXtTwKf77mzC8r+EFwaFYB6Ujodsbc=;
  b=XXXo9dbmfh663SCDFCaUI+ANKoFuNSChbx6DhKoiHd4HR7UovtG8cV4n
   vKsa2QLHpqODdG2yhUgRz4Wn2imYTIcAEorEC8zxpx8e/JBhCf7K/2mDB
   C8XFmp8ZirSsrFrjUcFs0IwLG3E7tEvlP4kWSaxZvtY10kRgyEp1JGSvw
   vgFjfWVfi6JkGcwY4rCrMhmI8100p0N1Mv+SXG1+eJYNIGlyj6s+Zwjf2
   cN2PqTM7K3FZizjTBAghuMxhFp3PfSVq1qRcjuVGVaFPQYdOjWQ24kMtR
   9A+idsEPSA7/h+7A8TmjOF2S63N5TD6gwRi1ZtpQpHlYNA52pKaifXHRj
   g==;
X-CSE-ConnectionGUID: vovtP1kDR6GNwnFUz0GdWw==
X-CSE-MsgGUID: 4TgKT+EWTu6m7pVDNp304w==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29950444"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29950444"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 05:43:23 -0700
X-CSE-ConnectionGUID: cQzMpvw5SfqdyVvUDlfTNA==
X-CSE-MsgGUID: 6p8GlB13TJeH2su0r5eOyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82021954"
Received: from nirmoyda-desk.igk.intel.com ([10.102.138.190])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 05:43:21 -0700
From: Nirmoy Das <nirmoy.das@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nirmoy Das <nirmoy.das@intel.com>,
	Badal Nilawar <badal.nilawar@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v5 2/3] drm/xe/ufence: Flush xe ordered_wq in case of ufence timeout
Date: Tue, 29 Oct 2024 13:01:16 +0100
Message-ID: <20241029120117.449694-2-nirmoy.das@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241029120117.449694-1-nirmoy.das@intel.com>
References: <20241029120117.449694-1-nirmoy.das@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Deutschland GmbH, Registered Address: Am Campeon 10, 85579 Neubiberg, Germany, Commercial Register: Amtsgericht Muenchen HRB 186928
Content-Transfer-Encoding: 8bit

Flush xe ordered_wq in case of ufence timeout which is observed
on LNL and that points to recent scheduling issue with E-cores.

This is similar to the recent fix:
commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
response timeout") and should be removed once there is a E-core
scheduling fix for LNL.

v2: Add platform check(Himal)
    s/__flush_workqueue/flush_workqueue(Jani)
v3: Remove gfx platform check as the issue related to cpu
    platform(John)
v4: Use the Common macro(John) and print when the flush resolves
    timeout(Matt B)

Cc: Badal Nilawar <badal.nilawar@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <stable@vger.kernel.org> # v6.11+
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
---
 drivers/gpu/drm/xe/xe_wait_user_fence.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
index f5deb81eba01..5b4264ea38bd 100644
--- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
+++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
@@ -155,6 +155,13 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
 		}
 
 		if (!timeout) {
+			LNL_FLUSH_WORKQUEUE(xe->ordered_wq);
+			err = do_compare(addr, args->value, args->mask,
+					 args->op);
+			if (err <= 0) {
+				drm_dbg(&xe->drm, "LNL_FLUSH_WORKQUEUE resolved ufence timeout\n");
+				break;
+			}
 			err = -ETIME;
 			break;
 		}
-- 
2.46.0


