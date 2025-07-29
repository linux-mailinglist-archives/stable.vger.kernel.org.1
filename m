Return-Path: <stable+bounces-165052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 681D7B14CB3
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 13:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8948E18A33FC
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 11:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E8A28C01D;
	Tue, 29 Jul 2025 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hcv/N2i0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C109528C01C
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787145; cv=none; b=pbjyNwtbX0YOFQzo1GAdToTrytIsYU2TaYwRsScADNFztL/s4DsRUcsZiJ6NKxLnwqtZDxG0QLVKjHxmnw4ggNwwJu+opbgzrB87k7CPDDc/3EpvkZEaubkrtRAudl72oOFeVlv06Z6udxC1vNDaYjmJl3ArXelM07eej0T7omc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787145; c=relaxed/simple;
	bh=ZG8kGse2whHP9PqZXpU6b3iax/1dBw6gnWuyw33UELY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBRRF4MKmcK2QHq4oJ7edFAJfoz2zCzjDA5JNEFYngxrtQmIw9RHC9G6DTSREuWESGzX/oSn1/ZqH6Qx9ceieNna+lrCycdcN5lQyL4eVSAQFq57ciFynxNbtGzhvNLfL3jItla3IM0mG24s5j2FLoX7YCSohK5QV6MOowEPq9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hcv/N2i0; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2402bbb4bf3so23920985ad.2
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 04:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753787143; x=1754391943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjEVdBGPxD0W8El7dN3HXrDfs2OHok0DDlSf5KiXk5Y=;
        b=Hcv/N2i0mKUd1CjkE3CfdPzQ9Hc0sNEWkZXGnCk1XlQrGLbwPqP0LmXZX1fG1mJUg9
         wmHWyEQoFk534BidL/oDWTnMOj2VH76tR5NmONsPLRNd8Ezg4Tza+u3ryMnG4oxxDKQh
         WB1mdxqhPoIzNT3txXFWcsPN/w/A8lUf5hZ+8BmzL6IGjnWjGcrTSZZEuzpTJnVRB4q5
         2ChYMIf7q0ERwRbOkl1GXrH8NbEJt1KmoxVVxLUzHneJivpVR++Ogq39cLh7eaMbDIIN
         RJe9VL6RaIV76HVEcAdPBijbr2CJUp9z+j7Mj9JJagrtQH4D44mafEQKW32MLesvgPpx
         KQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753787143; x=1754391943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjEVdBGPxD0W8El7dN3HXrDfs2OHok0DDlSf5KiXk5Y=;
        b=rmZrmuyYhjjUOa4UkYR2WBcsHNb13+F3V/SuROHITdG3aY9Ypcvp9m1PpGwTJ/07d/
         jI+BuCr+dkUc4F84vtRe7Srsd6dhZtP8EI1QPPHWXLH2wJw/IiOGSV/Jm1cy8dmieV3+
         I4SgUIIByRbm1cUhAsLObSpqvWhAVjQn0d54C6Tbnou/HkJKFsXDqZJs9HuFJaEL0Mvr
         1bhvvR1G8+3BPI27XJQi4Ja23QDAtaqZnNQyBjTpTaHyVbF/IZbywAyR7Xl+YVIOwFiC
         OIw72crICLC0o3pCmOpf0GU29zl7IiYqfArunVGFOVzhXVHkYJZIxNS36I8XK+dsBNgx
         dDoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3Xlyp3DrKYlP/J55ZXrarunQ4XPEJ59DTJrT3U6FFyB3koILHJ7yrhwWbER3aqhJnJr+S6MM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEpwCScalfzldvqPKU/NsG2/9ovd/lwIS6iqzwWq6lbnB8YvV
	ylSNvhMLi+Sgrsi/+XafWZKxVy3s9nI5DTQC4P0Gdjf/vEx+5xooaGk=
X-Gm-Gg: ASbGncty/HvKD+XBxobgtGxHP4tf0yXZcq8Xr5nT+qQf1vSLoPOcqnrpfjw/0nLe3cv
	Iubvk3FK1KWQb7lA3YwQYVMQtg9vUlqd8tJ3AOIRg3GNPw7mhVGzOQQZ/2M6XxGcvmGh0t/04cd
	TDKSldsGrYDGbtlimVuLek7Jw1HvZZr+u8mkGQ/bRG4DyNAqwcWVxhCBPsneBPnGphbkg38w0Yg
	KFUUjhB+fvicTvsLCARMHFqfkTIeAvbeKvrLHa4W4C9KbeCRFNO6qBkYvrkcm4qlWrCyUyr10Rb
	9eOUYuhiYTeQTIPAOEAw057F8B3M32MQgJIsc91en2hl3N9p9uhDN/h8prQtmIHRCjjwHjK0G4P
	Nvw6WLuQAQG2jxrJiRv5dUIHrG7dyMrMAdN5xgsPtgbhR2KwTCw==
X-Google-Smtp-Source: AGHT+IE/mo09xg1yVjETfxMDbiA4eaf9wMWWRdhI63ktdWg4p6m1+uKCAXUvOj4aHehwKxFNnXRsaw==
X-Received: by 2002:a17:903:3d05:b0:240:80f:228e with SMTP id d9443c01a7336-240080f2441mr120392335ad.52.1753787142745;
        Tue, 29 Jul 2025 04:05:42 -0700 (PDT)
Received: from git-send-email.moeko.lan ([139.227.17.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30bc1fsm75929025ad.5.2025.07.29.04.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 04:05:42 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Badal Nilawar <badal.nilawar@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>
Subject: [PATCH 6.12 1/4] Revert "drm/xe/gt: Update handling of xe_force_wake_get return"
Date: Tue, 29 Jul 2025 19:05:22 +0800
Message-ID: <20250729110525.49838-2-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250729110525.49838-1-tomitamoeko@gmail.com>
References: <20250729110525.49838-1-tomitamoeko@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit d42b44736ea29fa6d0c3cb9c75569314134b7732.

The reverted commit updated the handling of xe_force_wake_get to match
the new "return refcounted domain mask" semantics introduced in commit
a7ddcea1f5ac ("drm/xe: Error handling in xe_force_wake_get()"). However,
that API change only exists in 6.13 and later.

In 6.12 stable kernel, xe_force_wake_get still returns a status code.
The update incorrectly treats the return value as a mask, causing the
return value of 0 to be misinterpreted as an error. As a result, the
driver probe fails with -ETIMEDOUT in xe_pci_probe -> xe_device_probe
-> xe_gt_init_hwconfig -> xe_force_wake_get.

[ 1254.323172] xe 0000:00:02.0: [drm] Found ALDERLAKE_P (device ID 46a6) display version 13.00 stepping D0
[ 1254.323175] xe 0000:00:02.0: [drm:xe_pci_probe [xe]] ALDERLAKE_P  46a6:000c dgfx:0 gfx:Xe_LP (12.00) media:Xe_M (12.00) display:yes dma_m_s:39 tc:1 gscfi:0 cscfi:0
[ 1254.323275] xe 0000:00:02.0: [drm:xe_pci_probe [xe]] Stepping = (G:C0, M:C0, B:**)
[ 1254.323328] xe 0000:00:02.0: [drm:xe_pci_probe [xe]] SR-IOV support: no (mode: none)
[ 1254.323379] xe 0000:00:02.0: [drm:intel_pch_type [xe]] Found Alder Lake PCH
[ 1254.323475] xe 0000:00:02.0: probe with driver xe failed with error -110

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5373
Cc: Badal Nilawar <badal.nilawar@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 drivers/gpu/drm/xe/xe_gt.c | 105 +++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 30ec13cb5b6d..3b53d46aad54 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -98,14 +98,14 @@ void xe_gt_sanitize(struct xe_gt *gt)
 
 static void xe_gt_enable_host_l2_vram(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	u32 reg;
+	int err;
 
 	if (!XE_WA(gt, 16023588340))
 		return;
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	if (!fw_ref)
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	if (WARN_ON(err))
 		return;
 
 	if (!xe_gt_is_media_type(gt)) {
@@ -115,13 +115,13 @@ static void xe_gt_enable_host_l2_vram(struct xe_gt *gt)
 	}
 
 	xe_gt_mcr_multicast_write(gt, XEHPC_L3CLOS_MASK(3), 0xF);
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
 }
 
 static void xe_gt_disable_host_l2_vram(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	u32 reg;
+	int err;
 
 	if (!XE_WA(gt, 16023588340))
 		return;
@@ -129,15 +129,15 @@ static void xe_gt_disable_host_l2_vram(struct xe_gt *gt)
 	if (xe_gt_is_media_type(gt))
 		return;
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	if (!fw_ref)
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	if (WARN_ON(err))
 		return;
 
 	reg = xe_gt_mcr_unicast_read_any(gt, XE2_GAMREQSTRM_CTRL);
 	reg &= ~CG_DIS_CNTLBUS;
 	xe_gt_mcr_multicast_write(gt, XE2_GAMREQSTRM_CTRL, reg);
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
 }
 
 /**
@@ -407,14 +407,11 @@ static void dump_pat_on_error(struct xe_gt *gt)
 
 static int gt_fw_domain_init(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	int err, i;
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	if (!fw_ref) {
-		err = -ETIMEDOUT;
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	if (err)
 		goto err_hw_fence_irq;
-	}
 
 	if (!xe_gt_is_media_type(gt)) {
 		err = xe_ggtt_init(gt_to_tile(gt)->mem.ggtt);
@@ -449,12 +446,14 @@ static int gt_fw_domain_init(struct xe_gt *gt)
 	 */
 	gt->info.gmdid = xe_mmio_read32(gt, GMD_ID);
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	err = xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
+	XE_WARN_ON(err);
+
 	return 0;
 
 err_force_wake:
 	dump_pat_on_error(gt);
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
 err_hw_fence_irq:
 	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i)
 		xe_hw_fence_irq_finish(&gt->fence_irq[i]);
@@ -464,14 +463,11 @@ static int gt_fw_domain_init(struct xe_gt *gt)
 
 static int all_fw_domain_init(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	int err, i;
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL)) {
-		err = -ETIMEDOUT;
-		goto err_force_wake;
-	}
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	if (err)
+		goto err_hw_fence_irq;
 
 	xe_gt_mcr_set_implicit_defaults(gt);
 	xe_wa_process_gt(gt);
@@ -537,12 +533,14 @@ static int all_fw_domain_init(struct xe_gt *gt)
 	if (IS_SRIOV_PF(gt_to_xe(gt)))
 		xe_gt_sriov_pf_init_hw(gt);
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	err = xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	XE_WARN_ON(err);
 
 	return 0;
 
 err_force_wake:
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+err_hw_fence_irq:
 	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i)
 		xe_hw_fence_irq_finish(&gt->fence_irq[i]);
 
@@ -555,12 +553,11 @@ static int all_fw_domain_init(struct xe_gt *gt)
  */
 int xe_gt_init_hwconfig(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	int err;
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	if (!fw_ref)
-		return -ETIMEDOUT;
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	if (err)
+		goto out;
 
 	xe_gt_mcr_init_early(gt);
 	xe_pat_init(gt);
@@ -578,7 +575,8 @@ int xe_gt_init_hwconfig(struct xe_gt *gt)
 	xe_gt_enable_host_l2_vram(gt);
 
 out_fw:
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
+out:
 	return err;
 }
 
@@ -746,7 +744,6 @@ static int do_gt_restart(struct xe_gt *gt)
 
 static int gt_reset(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	int err;
 
 	if (xe_device_wedged(gt_to_xe(gt)))
@@ -767,11 +764,9 @@ static int gt_reset(struct xe_gt *gt)
 
 	xe_gt_sanitize(gt);
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL)) {
-		err = -ETIMEDOUT;
-		goto err_out;
-	}
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	if (err)
+		goto err_msg;
 
 	if (IS_SRIOV_PF(gt_to_xe(gt)))
 		xe_gt_sriov_pf_stop_prepare(gt);
@@ -792,7 +787,8 @@ static int gt_reset(struct xe_gt *gt)
 	if (err)
 		goto err_out;
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	err = xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	XE_WARN_ON(err);
 	xe_pm_runtime_put(gt_to_xe(gt));
 
 	xe_gt_info(gt, "reset done\n");
@@ -800,7 +796,8 @@ static int gt_reset(struct xe_gt *gt)
 	return 0;
 
 err_out:
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
+err_msg:
 	XE_WARN_ON(xe_uc_start(&gt->uc));
 err_fail:
 	xe_gt_err(gt, "reset failed (%pe)\n", ERR_PTR(err));
@@ -832,25 +829,22 @@ void xe_gt_reset_async(struct xe_gt *gt)
 
 void xe_gt_suspend_prepare(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
-
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	XE_WARN_ON(xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 
 	xe_uc_suspend_prepare(&gt->uc);
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 }
 
 int xe_gt_suspend(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	int err;
 
 	xe_gt_dbg(gt, "suspending\n");
 	xe_gt_sanitize(gt);
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL))
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	if (err)
 		goto err_msg;
 
 	err = xe_uc_suspend(&gt->uc);
@@ -861,15 +855,14 @@ int xe_gt_suspend(struct xe_gt *gt)
 
 	xe_gt_disable_host_l2_vram(gt);
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 	xe_gt_dbg(gt, "suspended\n");
 
 	return 0;
 
-err_msg:
-	err = -ETIMEDOUT;
 err_force_wake:
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
+err_msg:
 	xe_gt_err(gt, "suspend failed (%pe)\n", ERR_PTR(err));
 
 	return err;
@@ -877,11 +870,9 @@ int xe_gt_suspend(struct xe_gt *gt)
 
 void xe_gt_shutdown(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
-
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
 	do_gt_reset(gt);
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
 }
 
 /**
@@ -906,12 +897,11 @@ int xe_gt_sanitize_freq(struct xe_gt *gt)
 
 int xe_gt_resume(struct xe_gt *gt)
 {
-	unsigned int fw_ref;
 	int err;
 
 	xe_gt_dbg(gt, "resuming\n");
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL))
+	err = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	if (err)
 		goto err_msg;
 
 	err = do_gt_restart(gt);
@@ -920,15 +910,14 @@ int xe_gt_resume(struct xe_gt *gt)
 
 	xe_gt_idle_enable_pg(gt);
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 	xe_gt_dbg(gt, "resumed\n");
 
 	return 0;
 
-err_msg:
-	err = -ETIMEDOUT;
 err_force_wake:
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
+err_msg:
 	xe_gt_err(gt, "resume failed (%pe)\n", ERR_PTR(err));
 
 	return err;
-- 
2.47.2


