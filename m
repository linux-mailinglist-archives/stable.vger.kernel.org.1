Return-Path: <stable+bounces-165054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6722AB14CB6
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 13:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1834F543FEE
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 11:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F329289E0B;
	Tue, 29 Jul 2025 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsP5PvAW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E9A28C00D
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787155; cv=none; b=NnD5SL/x3rTs9+CjfnCst6ymsLumYIF7E5QYPyxQeRCXn+TK39qGFSUvvUpVY5G9BJmutel3SUX9sI/JgIZHjEFHSQwASgfDIBgIYEI/dT12/OK3vzfpqK5JXGLs4DJOtxuS4hBmK1+9gsqmZ6jnJ3sUeZu/15Ezx0tIueM8O+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787155; c=relaxed/simple;
	bh=6Qwbh70YvCoeJ933nIk/MNE00C6dK8YWAshoBGija90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=In7bGrVvLhwsFQyBm/DAjyDasgKEOJ1Br0QbQCmAOYvLQrNWU7L9kZ+HHqGcOlSUzX+1wdbwQ5BocsM+erF12OGM9hUcAYqRDxoWcWAcvPxi0kEHBQxzmTKW0EEIDjUpDzmTuZfU+YPUNCrIqmaoAKLLsgvxbdffAE9QSyZ4c1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsP5PvAW; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2405c0c431cso11827805ad.1
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 04:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753787153; x=1754391953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Abt8vstZAPNZDXKA1xlNOuo3fzYB7imYoFribfPOwfM=;
        b=VsP5PvAW0JdeZvmVPc8045hwmmDHrYQZnuu7NEjWA8sITm51rAZLotQLodyisBMzDu
         O1XEOBZHtnVlYIr1vtby11rnOnssdVt8/s2tGjjTxPWYHB/BxXSp+SyWJ4asohg39FIw
         UV6KXB5sdLmApMBgu9xBkiXaDWcjzUtq0sglGSYvQgUnYMmI2sQY+8zqpO7Fc9f6J6A/
         mtBORTw3FeTXZo1BnaZ5TyvaXb6K4p0NEvqJETG56uS6NTKTHE6kHhxL9AiZuFx09SBh
         hbejQjKdNGHaBtDtTOhXOi/ZdFNNPHQp17pKkPPiCXt73aD7NgIohGUXrYm1GcbpMA0S
         fZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753787153; x=1754391953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Abt8vstZAPNZDXKA1xlNOuo3fzYB7imYoFribfPOwfM=;
        b=e3L+rFJbtATOMEqmaXbTJd5ncNeztMjCCEArEgpQUPwVCOy0elDMAYCFHm1S9NNKFi
         +c8FOHUl6xOBaRHki/u7s48PWY3W7nXK4XwzVHaETSNURcMgITMLD7Idwx1drKNlJbKO
         K0p1RrmA4jdnrYT4eEoTZn3xyv0EU4d0wJhVSzRFXDhjAka01uxIA5SO1iIuwfx/5I/G
         w6n9WclYBOMK+caHkRhLPAwt+Asn1C/ax58tYZP55P5fXv+i+PwPoFng5FoepVBD5SGN
         iwhHOzqoKuk6/J172cw2n9mhwzmjz2BhtXlMqfzIef429PlhlbkhWekMCvFMee+22aQL
         nD9g==
X-Forwarded-Encrypted: i=1; AJvYcCUoHrgLh6JW9shYj7Iass034VPJjnizU9/U1AeTdNc43V3AHp6k9KNoouhEPevKSEB99ksv9tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdt89ystxLj6dHfMggtubdPeWtZfxMdTbGANIxqsJVvRHlgcXD
	CFAtDu+cbLXxXygBQRIYL8BynoCGRbODcw8Hvf/8MBbCPyqj3PeFqc4=
X-Gm-Gg: ASbGncv8m7Jl4D9uOpG6aNhjOS2qi/MF2JlNvwTdF0hPhy1LnI8Qth1oYfWNlNek59T
	W5g7m8/lCwphCx1x0N21+7OLr0F5uozPFIAYcPCBr2McojiQiFkpZoVH1I/QSQceaLPXyPYmo05
	G711Hgmp5f8sO7vhoDRsbbhXtBm7GNpvYx0oBfKBBQ6qlH7Jf3khHvZ5/NutVH5MvJSnPfkTuCF
	k3EUfs8ILocrmkk/obeJXM8q6CbHHM5tkU9TlaBYMPiz3cumKGaI1D2sFaD7dtgFWCctQFbspDh
	oBi6I0u0vQu3dDtNSLTFnJ9hWKVJgp9S31gOI1CBIuOPtJgNV+JOgXgZB9OdBomex/1X0I40caz
	Z7V9RRUVhc6bvanJz0jnucl5TLqO4B5FNGOE6wis=
X-Google-Smtp-Source: AGHT+IHAQn5G/9G5dVp6WunIHeCfG5Ftkh0IQEMUb3fjgxxrqRXsfHaPCtjrK9gLf0XgoJ/tEmN9YQ==
X-Received: by 2002:a17:902:cec7:b0:235:6aa:1675 with SMTP id d9443c01a7336-23fb315611bmr180795215ad.52.1753787153068;
        Tue, 29 Jul 2025 04:05:53 -0700 (PDT)
Received: from git-send-email.moeko.lan ([139.227.17.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30bc1fsm75929025ad.5.2025.07.29.04.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 04:05:52 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Badal Nilawar <badal.nilawar@intel.com>
Subject: [PATCH 6.12 3/4] Revert "drm/xe/devcoredump: Update handling of xe_force_wake_get return"
Date: Tue, 29 Jul 2025 19:05:24 +0800
Message-ID: <20250729110525.49838-4-tomitamoeko@gmail.com>
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

This reverts commit 9ffd6ec2de08ef4ac5f17f6131d1db57613493f9.

The reverted commit updated the handling of xe_force_wake_get to match
the new "return refcounted domain mask" semantics introduced in commit
a7ddcea1f5ac ("drm/xe: Error handling in xe_force_wake_get()"). However,
that API change only exists in 6.13 and later.

In 6.12 stable kernel, xe_force_wake_get still returns a status code.
The update incorrectly treats the return value as a mask, causing the
return value of 0 to be misinterpreted as an error

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: Badal Nilawar <badal.nilawar@intel.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 drivers/gpu/drm/xe/xe_devcoredump.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 8050938389b6..e412a70323cc 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -197,7 +197,6 @@ static void xe_devcoredump_deferred_snap_work(struct work_struct *work)
 	struct xe_devcoredump_snapshot *ss = container_of(work, typeof(*ss), work);
 	struct xe_devcoredump *coredump = container_of(ss, typeof(*coredump), snapshot);
 	struct xe_device *xe = coredump_to_xe(coredump);
-	unsigned int fw_ref;
 
 	/*
 	 * NB: Despite passing a GFP_ flags parameter here, more allocations are done
@@ -211,12 +210,11 @@ static void xe_devcoredump_deferred_snap_work(struct work_struct *work)
 	xe_pm_runtime_get(xe);
 
 	/* keep going if fw fails as we still want to save the memory and SW data */
-	fw_ref = xe_force_wake_get(gt_to_fw(ss->gt), XE_FORCEWAKE_ALL);
-	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL))
+	if (xe_force_wake_get(gt_to_fw(ss->gt), XE_FORCEWAKE_ALL))
 		xe_gt_info(ss->gt, "failed to get forcewake for coredump capture\n");
 	xe_vm_snapshot_capture_delayed(ss->vm);
 	xe_guc_exec_queue_snapshot_capture_delayed(ss->ge);
-	xe_force_wake_put(gt_to_fw(ss->gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(ss->gt), XE_FORCEWAKE_ALL);
 
 	xe_pm_runtime_put(xe);
 
@@ -243,9 +241,8 @@ static void devcoredump_snapshot(struct xe_devcoredump *coredump,
 	u32 width_mask = (0x1 << q->width) - 1;
 	const char *process_name = "no process";
 
-	unsigned int fw_ref;
-	bool cookie;
 	int i;
+	bool cookie;
 
 	ss->snapshot_time = ktime_get_real();
 	ss->boot_time = ktime_get_boottime();
@@ -268,7 +265,8 @@ static void devcoredump_snapshot(struct xe_devcoredump *coredump,
 	}
 
 	/* keep going if fw fails as we still want to save the memory and SW data */
-	fw_ref = xe_force_wake_get(gt_to_fw(q->gt), XE_FORCEWAKE_ALL);
+	if (xe_force_wake_get(gt_to_fw(q->gt), XE_FORCEWAKE_ALL))
+		xe_gt_info(ss->gt, "failed to get forcewake for coredump capture\n");
 
 	ss->ct = xe_guc_ct_snapshot_capture(&guc->ct, true);
 	ss->ge = xe_guc_exec_queue_snapshot_capture(q);
@@ -286,7 +284,7 @@ static void devcoredump_snapshot(struct xe_devcoredump *coredump,
 
 	queue_work(system_unbound_wq, &ss->work);
 
-	xe_force_wake_put(gt_to_fw(q->gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(q->gt), XE_FORCEWAKE_ALL);
 	dma_fence_end_signalling(cookie);
 }
 
-- 
2.47.2


