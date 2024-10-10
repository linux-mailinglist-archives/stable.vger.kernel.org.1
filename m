Return-Path: <stable+bounces-83406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF35A9995E2
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 01:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B007284805
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 23:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE491CF5C3;
	Thu, 10 Oct 2024 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eD7QHdQ9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911D41C9B93
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604709; cv=none; b=HwulfHN/1N9p8p42gZmiE+YteBKx0b8WddtugQ6Xvsn8z6vhjRlQROMJm1aqIK6uNLQn1iWJzKa4Mf2ifok7bHiEP1xPLnY0SHyEWZ61+7BoTFr1uVyU77Q7EwYr2+C6WXhLnMH8k6bd8KJWFzqHqLiJpHdP0va42F0bcsiIX3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604709; c=relaxed/simple;
	bh=G1QqrAj2olhu9EGBEQJEbfv0Osn+9IOanCWYAuC+Tbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sc++mmRkfV572gAIU8vEjjTG8ZTrmJ2WaWJdHXACMMuCTOg5BjsIwlQy1PCLbFbeqhRIvZ74kxGdEN22nLo+ILGpsYShKHhJtfhA8axdbD+GOqt9XnddLmTrW3LWoOWXXCtIy4w2CH4HZ5wBHk0ax/2E70LCW+ugDA8f0dvdBrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eD7QHdQ9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71dfe07489dso1252042b3a.3
        for <stable@vger.kernel.org>; Thu, 10 Oct 2024 16:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728604706; x=1729209506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5Eor/lXdsrMQiNQ8VDsC5vCLxBQGoEuzevbVvC8lEg=;
        b=eD7QHdQ9lPNLwg/qP1jA5ZVI9kKjRP4mllNs2J8+HKf0pnhV/rzzsUoXR9uGNS5oQh
         ALeTmEDYUiA2++cDZsBJB12tF7FCkKPh/twtjCRepBFDgrf0nxQne8bBflbkIoy76Xha
         qwIik+Eumw2m8Sk0KU5KrnujnGy5BSQEivaPMaVDicwZW8Z853AZD2p9niC2kd6TsEu+
         j7nhWOTeJMm2p494QSkzwNuzu/uzXRZQkMzdt8kbyKx18bvpfGGa75LnjzkE8GAw+dSY
         wd6urgfPOOFE81iaExsistn+lhfhMvML91vJS6/D3XwABdS81zcnMvrMeel41+cAkMc+
         qAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728604706; x=1729209506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5Eor/lXdsrMQiNQ8VDsC5vCLxBQGoEuzevbVvC8lEg=;
        b=grwlWnXQdYIVm6LtR66ZdzqGAbCzxZmMTPuHLL4oZFs4YMiQzEj5m1nAzLvKDsP7u9
         ggj0E2zY2ggISqTPrdwEcdcfScvmHo6zMV/mtrU4KK0ohbIXPEBByYlOQ/5Xzs6SZu7Y
         m83fYdl4tZt1c5OjMsc1hQe2eHMf7waG4VGUkiITl86plnl+JvqvcyUm3RBikEq8o2hE
         FgQ1rvUYRdEqkF83vk6WEYnARSNov2JNWetsVPKYhgQTbclxQyBqBrakEFwBDXOkXLUU
         jJbHWb0Biy0mgvcJ/8dbalaNgSApRaI62EKss2ywD/Z07Mo5xnEuJddlCrMHRKygO6HU
         w+BA==
X-Gm-Message-State: AOJu0YwCl+9xV7n7DSrJlntp4QPxbbhWe3OwfLhRpNU8QIlxB9SQZ6rO
	Qoio6OqgpHhswZd8K5wnwxeDPAH1CY3EXHF22sTGEK1/EXGmwXLcjtHEsw==
X-Google-Smtp-Source: AGHT+IH8nYTxwgeIzv2/oPJjnjMpR/2RQgoTeQJea7aozDk3b0TlWinoc9xonVbQqwFEQMnLNKUMZQ==
X-Received: by 2002:aa7:81c2:0:b0:71e:3b51:e856 with SMTP id d2e1a72fcca58-71e3b51e94cmr367615b3a.1.1728604706350;
        Thu, 10 Oct 2024 16:58:26 -0700 (PDT)
Received: from localhost.localdomain (88.sub-174-204-69.myvzw.com. [174.204.69.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9eb274sm1600485b3a.32.2024.10.10.16.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 16:58:25 -0700 (PDT)
From: Mitchell Levy <levymitchell0@gmail.com>
To: stable@vger.kernel.org
Cc: Mitchell Levy <levymitchell0@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.15.y] x86/fpu: Avoid writing LBR bit to IA32_XSS unless supported
Date: Thu, 10 Oct 2024 16:57:31 -0700
Message-Id: <20241010235731.10876-1-levymitchell0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024090809-plaything-sash-1d57@gregkh>
References: <2024090809-plaything-sash-1d57@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two distinct CPU features related to the use of XSAVES and LBR:
whether LBR is itself supported and whether XSAVES supports LBR. The LBR
subsystem correctly checks both in intel_pmu_arch_lbr_init(), but the
XSTATE subsystem does not.

The LBR bit is only removed from xfeatures_mask_independent when LBR is not
supported by the CPU, but there is no validation of XSTATE support.
If XSAVES does not support LBR the write to IA32_XSS causes a #GP fault,
leaving the state of IA32_XSS unchanged, i.e. zero. The fault is handled
with a warning and the boot continues.

Consequently the next XRSTORS which tries to restore supervisor state fails
with #GP because the RFBM has zero for all supervisor features, which does
not match the XCOMP_BV field.

As XFEATURE_MASK_FPSTATE includes supervisor features setting up the FPU
causes a #GP, which ends up in fpu_reset_from_exception_fixup(). That fails
due to the same problem resulting in recursive #GPs until the kernel runs
out of stack space and double faults.

Prevent this by storing the supported independent features in
fpu_kernel_cfg during XSTATE initialization and use that cached value for
retrieving the independent feature bits to be written into IA32_XSS.

[ tglx: Massaged change log ]

Fixes: f0dccc9da4c0 ("x86/fpu/xstate: Support dynamic supervisor feature for LBR")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
[ Mitchell Levy: Backport to 5.15, since struct fpu_config is not
  introduced until 578971f4e228 and feature masks are not included in
  said struct until 1c253ff2287f ]
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240812-xsave-lbr-fix-v3-1-95bac1bf62f4@gmail.com
---
 arch/x86/include/asm/fpu/xstate.h | 5 +++--
 arch/x86/kernel/fpu/xstate.c      | 7 +++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index d91df71f60fb..3bc08b5313b0 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -85,6 +85,7 @@
 #endif
 
 extern u64 xfeatures_mask_all;
+extern u64 xfeatures_mask_indep;
 
 static inline u64 xfeatures_mask_supervisor(void)
 {
@@ -124,9 +125,9 @@ static inline u64 xfeatures_mask_fpstate(void)
 static inline u64 xfeatures_mask_independent(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_ARCH_LBR))
-		return XFEATURE_MASK_INDEPENDENT & ~XFEATURE_MASK_LBR;
+		return xfeatures_mask_indep & ~XFEATURE_MASK_LBR;
 
-	return XFEATURE_MASK_INDEPENDENT;
+	return xfeatures_mask_indep;
 }
 
 extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 81891f0fff6f..3772577462a0 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -60,6 +60,11 @@ static short xsave_cpuid_features[] __initdata = {
  * XSAVE buffer, both supervisor and user xstates.
  */
 u64 xfeatures_mask_all __ro_after_init;
+/*
+ * This represents the "independent" xfeatures that are supported by XSAVES, but not managed as part
+ * of the FPU core, such as LBR.
+ */
+u64 xfeatures_mask_indep __ro_after_init;
 EXPORT_SYMBOL_GPL(xfeatures_mask_all);
 
 static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
@@ -768,6 +773,8 @@ void __init fpu__init_system_xstate(void)
 		goto out_disable;
 	}
 
+	xfeatures_mask_indep = xfeatures_mask_all & XFEATURE_MASK_INDEPENDENT;
+
 	/*
 	 * Clear XSAVE features that are disabled in the normal CPUID.
 	 */
-- 
2.34.1


