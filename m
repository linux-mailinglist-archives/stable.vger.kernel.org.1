Return-Path: <stable+bounces-165053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF325B14CB5
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 13:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F48A544683
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 11:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08E828C01F;
	Tue, 29 Jul 2025 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+J6+4T8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5322328C013
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787150; cv=none; b=HabC+o8+PRqiALmdHODKEsW/dKO3fiPuoIkp3/zL8jLR7fIJBtoY6KE0Z5wV0aOfBG5tpT7qX7KZDzpu1OC1gBIA0c2CKxEy8czwmRIFwUafea1URfaudEURv5RWHpdl/2WOaUx2VA2V3tLvJscOtrIc+mgLTTowc/2XUwI8boY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787150; c=relaxed/simple;
	bh=ufUHz5HjnYcAPdVseWcB8Hd339clsIv0cEij1cUa714=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQscrJV9hm+fTk6evEPI94wscXKy2/y6Zd5wzhrqj45WMmHQRV0XyPV+CmK+eDPEX2uacCw6gY6svcLzMkwPtg2djdT1SARw6WYvAZNm1YPo5FoagyA1R7pMCybS9g72yahsMcyRqCajmsExhQWSSHs8Xt+IT/nvgmZg0Mm4f34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+J6+4T8; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2405c0c431cso11827155ad.1
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 04:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753787148; x=1754391948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+z1GJYGgZbGmNmxr40mc+R8tUL34OBBz9k67nPl2iXE=;
        b=V+J6+4T8aDThfuc/26WXR8E1Dbfl4hhDgXgJCa2N6jIgRBUZ59FuXQytw7cMz9RrUL
         G71ViBT/K5XcNjBlOffoaV1rzLV4mI4yzEmzRJGH15gPsKJCT6kpFPoN86d8e8iL0ux+
         J5k00nXWnTMxZIQMLNrTxVNwPfhA4/QczrVgHT4X6wcZPxOKcskwtzvx46NLB/Gzk4XO
         qurz9Lf4opG5Xgk5QRbuxAlwIZClLzyGLYDeyIz1WXTaZxI16sAwzZa0OysKBglM3MT6
         SHK5QLhVPgT3d+Cf15I8sdfQ9FrzU3E0ROrHEP9esQcCwq3azNLp/InnOIVwlNb6IzYb
         jiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753787148; x=1754391948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+z1GJYGgZbGmNmxr40mc+R8tUL34OBBz9k67nPl2iXE=;
        b=HQjS+HaxUAIlQG2jQtUA/pzy0/oTY2sZ3UPZoLqt/ESr80mOWCspze8d2vMajosv5/
         yI3Pwlu9cVQExMXFX4jXH+hKYpY///Vq12x6KZzicgc3B/fCWfi0SEm339l13yZiajmi
         K2VcI0dWoicefFVrhiyOPcKofpxSqRW7p24yAqhXTuBvSqCAj0XczvTwfDURZCTdK/Zm
         KAkkaA7Uut+E8T3fZdZTj0yZddS+w0zK1hzt2fhLK+MPuQZUQcWgH0kqblV4nlGJZN3/
         34ma/2CJwakFHETeYdqOY8XdOYBri0U/CqPM+IRa42jZ3G4pXk1HbFV96JgZ7sXVOv50
         buIA==
X-Forwarded-Encrypted: i=1; AJvYcCUKTXcYreNC9jxI2Gtr5HUuPpxwfxmOhhO1+SitPW5C5hG4f9PxT6BDA5quMQGuAAT97JtXADI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwVRazlLEQ6Op7iEMhor4+3qBOvu/1e5bM5+/KGK1p/rNknyyv
	N9ZE8lcnSnjLA1BBpNsYfZjdZw/fsYobEjS4JrCIwZRqmP509WeUv2E=
X-Gm-Gg: ASbGncuWVmiWrnH+s4qi8BvKitKfFd4sZKH0dLbocoy4yqGRk8i30TfMbTnxdCgz6k/
	HZ7tSkM9CMCkOs34ss/6jiNPLUOgVh/BpBDD4ft0DwyiTRr7xknjxmfS/TgNYIbHGz5lczKIF+b
	BiaCydk7ypmMpjvZgoyChKcmZ4dEJbXY/nHyA5yRD7HmsbxkxGNiwu06VZFbwmUfYWi10yYay4i
	BRmB2jfT6MOILEnT40oUibRDwp/qn7uSfqhb4wq/s146MAM8SIW5SFO2Qt6KKl+6zGTP4SP/QZV
	7fLFi5cozJhWbK2IImtb9EgnWjz2Pyk5yKlTtASZsjQU4osJsROQIrsMO+vLCTnTo+ZR2QIIDpB
	F1p5UdoXCFbEEwezoKnjOiS+o/viMnNF+6ZDsUy8=
X-Google-Smtp-Source: AGHT+IGF1UKSZVQ0ItcsqlqVAid8KL6y4wHnZzHTY3t6sZcczT8WTs89cnUpCbDJ6Z6TJ+zCeH+9Lg==
X-Received: by 2002:a17:903:2655:b0:23f:cf96:3071 with SMTP id d9443c01a7336-23fcf963dccmr141597945ad.49.1753787148106;
        Tue, 29 Jul 2025 04:05:48 -0700 (PDT)
Received: from git-send-email.moeko.lan ([139.227.17.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30bc1fsm75929025ad.5.2025.07.29.04.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 04:05:47 -0700 (PDT)
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
Subject: [PATCH 6.12 2/4] Revert "drm/xe/tests/mocs: Update xe_force_wake_get() return handling"
Date: Tue, 29 Jul 2025 19:05:23 +0800
Message-ID: <20250729110525.49838-3-tomitamoeko@gmail.com>
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

This reverts commit 95a75ed2b005447f96fbd4ac61758ccda44069d1.

The reverted commit updated the handling of xe_force_wake_get to match
the new "return refcounted domain mask" semantics introduced in commit
a7ddcea1f5ac ("drm/xe: Error handling in xe_force_wake_get()"). However,
that API change only exists in 6.13 and later.

In 6.12 stable kernel, xe_force_wake_get still returns a status code.
The update incorrectly treats the return value as a mask, causing the
return value of 0 to be misinterpreted as an error.

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: Badal Nilawar <badal.nilawar@intel.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 drivers/gpu/drm/xe/tests/xe_mocs.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_mocs.c b/drivers/gpu/drm/xe/tests/xe_mocs.c
index 61a7d20ce42b..bf3f97d0c9c7 100644
--- a/drivers/gpu/drm/xe/tests/xe_mocs.c
+++ b/drivers/gpu/drm/xe/tests/xe_mocs.c
@@ -43,14 +43,12 @@ static void read_l3cc_table(struct xe_gt *gt,
 {
 	struct kunit *test = kunit_get_current_test();
 	u32 l3cc, l3cc_expected;
-	unsigned int fw_ref, i;
+	unsigned int i;
 	u32 reg_val;
+	u32 ret;
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL)) {
-		xe_force_wake_put(gt_to_fw(gt), fw_ref);
-		KUNIT_ASSERT_TRUE_MSG(test, true, "Forcewake Failed.\n");
-	}
+	ret = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	KUNIT_ASSERT_EQ_MSG(test, ret, 0, "Forcewake Failed.\n");
 
 	for (i = 0; i < info->num_mocs_regs; i++) {
 		if (!(i & 1)) {
@@ -74,7 +72,7 @@ static void read_l3cc_table(struct xe_gt *gt,
 		KUNIT_EXPECT_EQ_MSG(test, l3cc_expected, l3cc,
 				    "l3cc idx=%u has incorrect val.\n", i);
 	}
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
 }
 
 static void read_mocs_table(struct xe_gt *gt,
@@ -82,14 +80,15 @@ static void read_mocs_table(struct xe_gt *gt,
 {
 	struct kunit *test = kunit_get_current_test();
 	u32 mocs, mocs_expected;
-	unsigned int fw_ref, i;
+	unsigned int i;
 	u32 reg_val;
+	u32 ret;
 
 	KUNIT_EXPECT_TRUE_MSG(test, info->unused_entries_index,
 			      "Unused entries index should have been defined\n");
 
-	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	KUNIT_ASSERT_NE_MSG(test, fw_ref, 0, "Forcewake Failed.\n");
+	ret = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	KUNIT_ASSERT_EQ_MSG(test, ret, 0, "Forcewake Failed.\n");
 
 	for (i = 0; i < info->num_mocs_regs; i++) {
 		if (regs_are_mcr(gt))
@@ -107,7 +106,7 @@ static void read_mocs_table(struct xe_gt *gt,
 				    "mocs reg 0x%x has incorrect val.\n", i);
 	}
 
-	xe_force_wake_put(gt_to_fw(gt), fw_ref);
+	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
 }
 
 static int mocs_kernel_test_run_device(struct xe_device *xe)
-- 
2.47.2


