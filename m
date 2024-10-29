Return-Path: <stable+bounces-89181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4696D9B46FF
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 11:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE509B213B3
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 10:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABFD204F80;
	Tue, 29 Oct 2024 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klg4rZU6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ED0204F6C
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198183; cv=none; b=VyVOEQJJcncOXoWr9EENevDUalqef/oeLaqkW5PgnC93HcM1vP8qJ9R09ptG6D0MNcEUDgi7CIWORUAUXmjuzJPdhPNbChg2f9+bDGWO+6L5rQ0IL6Q/aHZPXlNovU50vErIgbfqSy3Gv0V0fPtWsOc5KvW30HTittRKKdqFXZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198183; c=relaxed/simple;
	bh=vlKSY1y59Sqpv1vl/FPzCY5JNU57Elu0X3S9Izh3sMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sNvwQ36i28T4QEfoHMbOFdHL33ibCoFSAZw8FHsJU3ihVIQGXqEpDW25lLD+7vyr8Y3uvx3GIWP3ETjPhSt+iKhkCwLoWPhfEa2jyWpX1wrCRnv1b5VwCfTcD7xm1u4jyFNWMED9u6QhgnFO6fLN2H6MANmq5Qnf1yrQVSXO374=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klg4rZU6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730198181; x=1761734181;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vlKSY1y59Sqpv1vl/FPzCY5JNU57Elu0X3S9Izh3sMI=;
  b=klg4rZU6SiF4+WuzXahIjgzLuhZPJqtpWyhxE+Ca7Zh2YB48kkM23Xro
   w/aSoCK8oRIUH9zp9pE5wxKbctEFenMD/3xjRNb0Dv64wOJ9VD/UGfDsz
   DPQ5QwvdlY59dXtrc9OTVF8BzSifnZvJxwRoXzcrQQ5hZ+nvnUMGNLGn5
   Z9jw6F29/klTctJuftQwqlEfBkchlLDGdhEx515q5wQdoQvfu80k1TRyD
   VnCAELRg7QnVZttWJGe10VTt6yWAdHRYPH3yZhgrNWrpyM2f/fRKAQ/Cp
   mL1PAiuRe4P4y00fak7dTaWUHf40bpNuHSzN7/PGSwL04N3NCeG+DGGVr
   w==;
X-CSE-ConnectionGUID: 6MMQH9ExQCSLLFP3dmOQWQ==
X-CSE-MsgGUID: HlTu/06yTSC71r7ijjmtKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29937677"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29937677"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:36:20 -0700
X-CSE-ConnectionGUID: WKd3/ogXQouPzkF651AFWw==
X-CSE-MsgGUID: EqoNDcqTT4Kae4hwN0/LMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="105262786"
Received: from nirmoyda-desk.igk.intel.com ([10.102.138.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:36:18 -0700
From: Nirmoy Das <nirmoy.das@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Nirmoy Das <nirmoy.das@intel.com>,
	Badal Nilawar <badal.nilawar@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org,
	John Harrison <John.C.Harrison@Intel.com>
Subject: [PATCH v4 1/3] drm/xe: Move LNL scheduling WA to xe_device.h
Date: Tue, 29 Oct 2024 10:54:14 +0100
Message-ID: <20241029095416.3919218-1-nirmoy.das@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Deutschland GmbH, Registered Address: Am Campeon 10, 85579 Neubiberg, Germany, Commercial Register: Amtsgericht Muenchen HRB 186928
Content-Transfer-Encoding: 8bit

Move LNL scheduling WA to xe_device.h so this can be used in other
places without needing keep the same comment about removal of this WA
in the future. The WA, which flushes work or workqueues, is now wrapped
in macros and can be reused wherever needed.

Cc: Badal Nilawar <badal.nilawar@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
cc: <stable@vger.kernel.org> # v6.11+
Suggested-by: John Harrison <John.C.Harrison@Intel.com>
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
---
 drivers/gpu/drm/xe/xe_device.h | 14 ++++++++++++++
 drivers/gpu/drm/xe/xe_guc_ct.c | 11 +----------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
index 4c3f0ebe78a9..f1fbfe916867 100644
--- a/drivers/gpu/drm/xe/xe_device.h
+++ b/drivers/gpu/drm/xe/xe_device.h
@@ -191,4 +191,18 @@ void xe_device_declare_wedged(struct xe_device *xe);
 struct xe_file *xe_file_get(struct xe_file *xef);
 void xe_file_put(struct xe_file *xef);
 
+/*
+ * Occasionally it is seen that the G2H worker starts running after a delay of more than
+ * a second even after being queued and activated by the Linux workqueue subsystem. This
+ * leads to G2H timeout error. The root cause of issue lies with scheduling latency of
+ * Lunarlake Hybrid CPU. Issue disappears if we disable Lunarlake atom cores from BIOS
+ * and this is beyond xe kmd.
+ *
+ * TODO: Drop this change once workqueue scheduling delay issue is fixed on LNL Hybrid CPU.
+ */
+#define LNL_FLUSH_WORKQUEUE(wq__) \
+	flush_workqueue(wq__)
+#define LNL_FLUSH_WORK(wrk__) \
+	flush_work(wrk__)
+
 #endif
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index 1b5d8fb1033a..703b44b257a7 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -1018,17 +1018,8 @@ static int guc_ct_send_recv(struct xe_guc_ct *ct, const u32 *action, u32 len,
 
 	ret = wait_event_timeout(ct->g2h_fence_wq, g2h_fence.done, HZ);
 
-	/*
-	 * Occasionally it is seen that the G2H worker starts running after a delay of more than
-	 * a second even after being queued and activated by the Linux workqueue subsystem. This
-	 * leads to G2H timeout error. The root cause of issue lies with scheduling latency of
-	 * Lunarlake Hybrid CPU. Issue dissappears if we disable Lunarlake atom cores from BIOS
-	 * and this is beyond xe kmd.
-	 *
-	 * TODO: Drop this change once workqueue scheduling delay issue is fixed on LNL Hybrid CPU.
-	 */
 	if (!ret) {
-		flush_work(&ct->g2h_worker);
+		LNL_FLUSH_WORK(&ct->g2h_worker);
 		if (g2h_fence.done) {
 			xe_gt_warn(gt, "G2H fence %u, action %04x, done\n",
 				   g2h_fence.seqno, action[0]);
-- 
2.46.0


