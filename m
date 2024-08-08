Return-Path: <stable+bounces-66101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D67D94C75F
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 01:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDF41F23990
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 23:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6172E15B111;
	Thu,  8 Aug 2024 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1oo1bUE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C46E55769;
	Thu,  8 Aug 2024 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723159817; cv=none; b=OU7fJqcELmKziNYYChSjTFcaAFvjViE6Cc12ufTHuDI4AhLFbkML4pN4UR3pzrpulGOB4Gyo8E+qDWSG5BtuoOtGA12BXpbBNG0QUwdzmbapVK6Ce0+yZcERtwKRUshY4roTw+vOSoC6FG3SUsyzao0YNcS0BEg7VZWtnb6qmtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723159817; c=relaxed/simple;
	bh=rK4tB4WPJfLPrcZ+F5Fbbqix6Gv+OfmlxqJkua2A56E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eRONa2+ADb3mYL0FDfxaHZ4qurzvmw62bWgh7jnNf3c7O/AeFiXYd/biV9PrYT7B/B7KkjpSKeUbfNPUN9MhWPiW/7GlDGGHHLWpwyj3xA2xQsgJ5HWAU3gWSB56xBCEHpJFi4wyR+zDRCokrCKIHgRlY5k89rI165mVlisgxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1oo1bUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CAC9C32782;
	Thu,  8 Aug 2024 23:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723159816;
	bh=rK4tB4WPJfLPrcZ+F5Fbbqix6Gv+OfmlxqJkua2A56E=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=k1oo1bUE2xX0PrC20hKap0i825/r4wc0SQTeDnfIvu2QBCWJIWNXlud7Ri8yOezFW
	 8t4TRtWopwdF6heZ81JMKn5owSDSIQnytwzyw1bQhU23WxDUg3wdQplRLSsorJ3uuc
	 vom0f8XL/6IgY64uQvd3I45P75INHY0lX6F7ocgeU/THFuBCV0E/ed3VMWitMt524Y
	 AZHlgZ8TI1wU0Ozp5kZWd82HdGq5yrEe6KMyYutQj76GcG7U0m/TpI+Or+3kwh/CxP
	 oWO+eRqvQbvTY43gCvR5DaoPcbUNiowTDPzrflUozA2WWsbtZ6PI6Ge4Gj2Pw1+vIR
	 sO37x0woLt15g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C160C3DA4A;
	Thu,  8 Aug 2024 23:30:16 +0000 (UTC)
From: Mitchell Levy via B4 Relay <devnull+levymitchell0.gmail.com@kernel.org>
Date: Thu, 08 Aug 2024 16:30:10 -0700
Subject: [PATCH] x86/fpu: Avoid writing LBR bit to IA32_XSS unless
 supported
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-xsave-lbr-fix-v1-1-a223806c83e7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAFVtWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwNz3YrixLJU3ZykIt20zApdA6MUU6M0MxNDM1NjJaCegqJUoDDYvOj
 Y2loA3RILWF8AAAA=
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: stable@vger.kernel.org, Borislav Petkov <bp@suse.de>, 
 linux-kernel@vger.kernel.org, Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723159817; l=2576;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=aD/HH3dzvhy4muD2Cy5M+AM0El/r97xW+eGKYw26zH0=;
 b=8zO+Sr3nZNkO0VBtBSMe+DEVkhL/JnpFkIRgRz9xwiRA3wosgdPgOjDqT7Jax6ZpKs639xRMp
 aN2VKMIWN6UDdqZWgjibE8iMOvub2REaomBJsAf1tRvpBT4MRsZaxem
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=
X-Endpoint-Received: by B4 Relay for levymitchell0@gmail.com/20240719 with
 auth_id=188
X-Original-From: Mitchell Levy <levymitchell0@gmail.com>
Reply-To: levymitchell0@gmail.com

From: Mitchell Levy <levymitchell0@gmail.com>

When computing which xfeatures are available, make sure that LBR is only
present if both LBR is supported in general, as well as by XSAVES.

There are two distinct CPU features related to the use of XSAVES as it
applies to LBR: whether LBR is itself supported (strictly speaking, I'm
not sure that this is necessary to check though it's certainly a good
sanity check), and whether XSAVES supports LBR (see sections 13.2 and
13.5.12 of the Intel 64 and IA-32 Architectures Software Developer's
Manual, Volume 1). Currently, the LBR subsystem correctly checks both
(see intel_pmu_arch_lbr_init), however the xstate initialization
subsystem does not.

When calculating what value to place in the IA32_XSS MSR,
xfeatures_mask_independent only checks whether LBR support is present,
not whether XSAVES supports LBR. If XSAVES does not support LBR, this
write causes #GP, leaving the state of IA32_XSS unchanged (i.e., set to
zero, as its not written with other values, and its default value is
zero out of RESET per section 13.3 of the arch manual).

Then, the next time XRSTORS is used to restore supervisor state, it will
fail with #GP (because the RFBM has zero for all supervisor features,
which does not match the XCOMP_BV field). In particular,
XFEATURE_MASK_FPSTATE includes supervisor features, so setting up the FPU
will cause a #GP. This results in a call to fpu_reset_from_exception_fixup,
which by the same process results in another #GP. Eventually this causes
the kernel to run out of stack space and #DF.

Fixes: d72c87018d00 ("x86/fpu/xstate: Move remaining xfeature helpers to core")
Cc: stable@vger.kernel.org

Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
 arch/x86/kernel/fpu/xstate.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 2ee0b9c53dcc..574d2c2ea227 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -61,7 +61,8 @@ static inline u64 xfeatures_mask_supervisor(void)
 
 static inline u64 xfeatures_mask_independent(void)
 {
-	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR))
+	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR) ||
+	    (fpu_kernel_cfg.max_features & XFEATURE_MASK_LBR) != XFEATURE_MASK_LBR)
 		return XFEATURE_MASK_INDEPENDENT & ~XFEATURE_MASK_LBR;
 
 	return XFEATURE_MASK_INDEPENDENT;

---
base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
change-id: 20240807-xsave-lbr-fix-02d52f641653

Best regards,
-- 
Mitchell Levy <levymitchell0@gmail.com>



