Return-Path: <stable+bounces-119825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FD0A479E4
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 11:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2783E3A45ED
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 10:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21866227EA8;
	Thu, 27 Feb 2025 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="i47imt6/"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC021B9EE
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651199; cv=none; b=T+Ii++3zcn1aEmz6tkPNLj/x2hvvdirdpZkDPoYdZohPfHknfb1x9LaGvus8Omv2XcDRzKrefenoKekK1BaWOKAneTL1zeR0mN8YPlMjD7DBTtWYdhDbchLP8yDEv+oCj49Topxadr6zMtvLY+AN05pNkDPGO+C+DG13H0ZvgTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651199; c=relaxed/simple;
	bh=0/A6b87m5LKyyCeOX32OodEXm8zJ9st+hvPe9+Yr7ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcFRwdE+jJWlXLpSSmLAxC/8o6Pjtdyv41m43DL8FGRf4MO22d+GXILSmB4edkXTiKSeby8BLOfnvlXP1NZslYble6u/u4w6tj1ZoAYPqf549mI6c08FVch6FwDcG8OaPiVbbpC3Up6w1ubTraV1xf+vYbzYL5E1TRy53tfLgO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=i47imt6/; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=b5rjD/6rk3kLB1xTS7IjbgH0k4asvfCmUk0GKGIxGC0=; b=i47imt6/ZcxbhNbY+5TMxY+snT
	WQVTqzO1Se964bDbd5KHyYhybKhfGBH8FVyVInJRRktYlwwV2SzrVcVazuL91yigRVatbtPNI8/O2
	W/hulgTJRhXNTthbghNAyNAxRLs12YWh6ZBiQx/hUmTcCUxIVrawB91cxtHPMfQohHD10vMuO+aJU
	uUvkjBZT17vyAL+jrUJaTIYc52fAVSXvTweESP43y/hddIdM3TodaEhgrYX6zaObatCIPOLsCdd5L
	BY8Sy8/TzrtgPLccB61mD/pHgjHZoJhtAzgp8JvFM7eGTvXf2tZmtcF+Ew+izxe4RsKsmFmAhgGBc
	BH75v1cQ==;
Received: from [90.241.98.187] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tnat3-001XVh-HM; Thu, 27 Feb 2025 11:13:07 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: intel-xe@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] drm/xe: Fix GT "for each engine" workarounds
Date: Thu, 27 Feb 2025 10:13:00 +0000
Message-ID: <20250227101304.46660-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250227101304.46660-1-tvrtko.ursulin@igalia.com>
References: <20250227101304.46660-1-tvrtko.ursulin@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Any rules using engine matching are currently broken due RTP processing
happening too in early init, before the list of hardware engines has been
initialised.

Fix this by moving workaround processing to later in the driver probe
sequence, to just before the processed list is used for the first time.

Looking at the debugfs gt0/workarounds on ADL-P we notice 14011060649
should be present while we see, before:

 GT Workarounds
     14011059788
     14015795083

And with the patch:

 GT Workarounds
     14011060649
     14011059788
     14015795083

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: <stable@vger.kernel.org> # v6.11+
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_gt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 650a0ee56e97..d59c03bc05b7 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -361,9 +361,7 @@ int xe_gt_init_early(struct xe_gt *gt)
 	if (err)
 		return err;
 
-	xe_wa_process_gt(gt);
 	xe_wa_process_oob(gt);
-	xe_tuning_process_gt(gt);
 
 	xe_force_wake_init_gt(gt, gt_to_fw(gt));
 	spin_lock_init(&gt->global_invl_lock);
@@ -450,6 +448,8 @@ static int all_fw_domain_init(struct xe_gt *gt)
 	}
 
 	xe_gt_mcr_set_implicit_defaults(gt);
+	xe_wa_process_gt(gt);
+	xe_tuning_process_gt(gt);
 	xe_reg_sr_apply_mmio(&gt->reg_sr, gt);
 
 	err = xe_gt_clock_init(gt);
-- 
2.48.0


