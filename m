Return-Path: <stable+bounces-118596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFF0A3F710
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 15:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0F019C4E71
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 14:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5B120F08B;
	Fri, 21 Feb 2025 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hIjtwLHy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CAB20F085
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147641; cv=none; b=EyOYqaApi7t5wMlPmDzyQgxJyC0JyZbT/O/MNjiSitpK5ODtH/aEk3Nx3EOPW85LGXq0ehv1jo2W0ynS0IPo+X8jND5Zr7G+9YWBgk9HLeAYXtz+D+vh0qfgBq1GdUYdU2Gl0/uljYT5UbWneTGkNO2zXhuvRl3pRBPjVtATUI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147641; c=relaxed/simple;
	bh=GWlurt06QDhPiSWaPjMSrBRcLwFlXoXALEmItpHXRwg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UTtaPxyOTFNMQ3bdXvRm90Tt1Pex8IOD6L5KExE6GE5OAQ5j+wtXToTeiBCTx0ZHF/ayc+XSihqq0THYDE4jC7oDjFGJj11JNjKnd47HL12P/ABcf+MJfvT2xnPRmMJZts7Y6CB+seCQKbWWmEqVRMEMuLaPbGEoxMPRnNojm+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--derkling.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hIjtwLHy; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--derkling.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38f28a4647eso1073687f8f.1
        for <stable@vger.kernel.org>; Fri, 21 Feb 2025 06:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740147638; x=1740752438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gAN4vizlfThj3/spjFigcf7y4206n2EgGnYQHkF382M=;
        b=hIjtwLHy5jd9/tItTuw+PWXVfDS+g1iTMaxH+sNlImWJuQMvr0gwPCzcva59n/1vUv
         +Y+1+8GOvLJHMHSg2gKep3Fl3ERdf8A2+dLQ9WK3w+FG8EpD95gvqsYcX0y1uzes2weA
         +cneAvMNfW2DIS77w21l/Mmez0pmunM/8pdQ4aVluHf2gp+YcMHygBPwwcsm4ODjiCPo
         jH4ZkqbjzA6ALPq/3mflrQ134LIBEEIm1YwetdCdfbaCdwBMVdPmoULJH1vukQbv8k2N
         XsG7p6Ai8nJXiuV2aHj9wi/m1AlWE0lyyjeSd4hjtNH6DtlS9+MFxAV6iDqsP/jE7qTr
         psIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740147638; x=1740752438;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gAN4vizlfThj3/spjFigcf7y4206n2EgGnYQHkF382M=;
        b=kv8ACjHffmLWePRfV0N+exksaX66zPhM3szklRvWlTBvNuPhKe/8XRWOfc3OU5f29L
         FEcYvUi6h2kkCpPiDIEh0tFhgL079p7ufaDyC0AWlqPF1VTIzvClhpaQPb7v2DkWjSct
         Hyd6xxbYQwlczznLvsSTEMZfRfYLKP/9OY3sKSp48EiBEbsxn8C3XoS79cJDITbBIynz
         hB4qMHAwbR+HT8LJmryPR88EpxHkuQF2t/BHTxr1+GClwI57aHXXCiEFnXHWUJPVn0wd
         bTD/XnMVRw3ujKvQCpz3WJymneU+CytR5CCwoUFnpIhk1RhqQt9Kc0dyXN8l4rK3ttvX
         q1BQ==
X-Gm-Message-State: AOJu0YxphalmIGMDjBielwjanjHugyp/72/HD0lOvoFbTBwRLw20kmjm
	XBgIjBJ7jvHw9M5RGhg/Ha2CJC1QUqOs7wd/NgDh5ogHO+owcEz0qx+2skBHhOs5t0eOG0hq4o+
	8BTl77IzTjBhWl3iFAHOXjEJSAbTy08Vw0AmAxcMmGk890V4vQVUV0JIt/TT7rlumF6tfMBE0Ys
	9UGpWNE2EGzbbanZUMHqiKsQjOei2Tse3raIltGrp20C0=
X-Google-Smtp-Source: AGHT+IH0boqnUtNJDnNpCgtZHuh2dD37zGiE7VV1gYmY0oLj/YDEXi+H9uvRRXJRzLv9+vDrYYowHY6OLX2sWQ==
X-Received: from wrbhb24.prod.google.com ([2002:a05:6000:4918:b0:38f:40d1:8309])
 (user=derkling job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:6e8a:0:b0:38d:e378:20f7 with SMTP id ffacd0b85a97d-38f6f09749emr2344534f8f.41.1740147637844;
 Fri, 21 Feb 2025 06:20:37 -0800 (PST)
Date: Fri, 21 Feb 2025 14:20:02 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250221142002.4136456-1-derkling@google.com>
Subject: [PATCH 6.6] x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit
From: Patrick Bellasi <derkling@google.com>
To: stable@vger.kernel.org
Cc: patches@lists.linux.dev, Borislav Petkov <bp@alien8.de>, 
	Patrick Bellasi <derkling@matbug.net>, Brendan Jackman <jackmanb@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

commit 318e8c339c9a0891c389298bb328ed0762a9935e upstream.

In [1] the meaning of the synthetic IBPB flags has been redefined for a
better separation of concerns:
 - ENTRY_IBPB     -- issue IBPB on entry only
 - IBPB_ON_VMEXIT -- issue IBPB on VM-Exit only
and the Retbleed mitigations have been updated to match this new
semantics.

Commit [2] was merged shortly before [1], and their interaction was not
handled properly. This resulted in IBPB not being triggered on VM-Exit
in all SRSO mitigation configs requesting an IBPB there.

Specifically, an IBPB on VM-Exit is triggered only when
X86_FEATURE_IBPB_ON_VMEXIT is set. However:

 - X86_FEATURE_IBPB_ON_VMEXIT is not set for "spec_rstack_overflow=ibpb",
   because before [1] having X86_FEATURE_ENTRY_IBPB was enough. Hence,
   an IBPB is triggered on entry but the expected IBPB on VM-exit is
   not.

 - X86_FEATURE_IBPB_ON_VMEXIT is not set also when
   "spec_rstack_overflow=ibpb-vmexit" if X86_FEATURE_ENTRY_IBPB is
   already set.

   That's because before [1] this was effectively redundant. Hence, e.g.
   a "retbleed=ibpb spec_rstack_overflow=bpb-vmexit" config mistakenly
   reports the machine still vulnerable to SRSO, despite an IBPB being
   triggered both on entry and VM-Exit, because of the Retbleed selected
   mitigation config.

 - UNTRAIN_RET_VM won't still actually do anything unless
   CONFIG_MITIGATION_IBPB_ENTRY is set.

For "spec_rstack_overflow=ibpb", enable IBPB on both entry and VM-Exit
and clear X86_FEATURE_RSB_VMEXIT which is made superfluous by
X86_FEATURE_IBPB_ON_VMEXIT. This effectively makes this mitigation
option similar to the one for 'retbleed=ibpb', thus re-order the code
for the RETBLEED_MITIGATION_IBPB option to be less confusing by having
all features enabling before the disabling of the not needed ones.

For "spec_rstack_overflow=ibpb-vmexit", guard this mitigation setting
with CONFIG_MITIGATION_IBPB_ENTRY to ensure UNTRAIN_RET_VM sequence is
effectively compiled in. Drop instead the CONFIG_MITIGATION_SRSO guard,
since none of the SRSO compile cruft is required in this configuration.
Also, check only that the required microcode is present to effectively
enabled the IBPB on VM-Exit.

Finally, update the KConfig description for CONFIG_MITIGATION_IBPB_ENTRY
to list also all SRSO config settings enabled by this guard.

Fixes: 864bcaa38ee4 ("x86/cpu/kvm: Provide UNTRAIN_RET_VM") [1]
Fixes: d893832d0e1e ("x86/srso: Add IBPB on VMEXIT") [2]
Reported-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Patrick Bellasi <derkling@google.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/Kconfig           |  3 ++-
 arch/x86/kernel/cpu/bugs.c | 21 ++++++++++++++-------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 05c82fd5d0f60..989d432b58345 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2514,7 +2514,8 @@ config CPU_IBPB_ENTRY
 	depends on CPU_SUP_AMD && X86_64
 	default y
 	help
-	  Compile the kernel with support for the retbleed=ibpb mitigation.
+	  Compile the kernel with support for the retbleed=ibpb and
+	  spec_rstack_overflow={ibpb,ibpb-vmexit} mitigations.
 
 config CPU_IBRS_ENTRY
 	bool "Enable IBRS on kernel entry"
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 7b5ba5b8592a2..7df458a6553eb 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1113,6 +1113,8 @@ static void __init retbleed_select_mitigation(void)
 
 	case RETBLEED_MITIGATION_IBPB:
 		setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
+		mitigate_smt = true;
 
 		/*
 		 * IBPB on entry already obviates the need for
@@ -1122,9 +1124,6 @@ static void __init retbleed_select_mitigation(void)
 		setup_clear_cpu_cap(X86_FEATURE_UNRET);
 		setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
 
-		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
-		mitigate_smt = true;
-
 		/*
 		 * There is no need for RSB filling: entry_ibpb() ensures
 		 * all predictions, including the RSB, are invalidated,
@@ -2626,6 +2625,7 @@ static void __init srso_select_mitigation(void)
 		if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY)) {
 			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB;
 
 				/*
@@ -2635,6 +2635,13 @@ static void __init srso_select_mitigation(void)
 				 */
 				setup_clear_cpu_cap(X86_FEATURE_UNRET);
 				setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
+
+				/*
+				 * There is no need for RSB filling: entry_ibpb() ensures
+				 * all predictions, including the RSB, are invalidated,
+				 * regardless of IBPB implementation.
+				 */
+				setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
 			}
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_IBPB_ENTRY.\n");
@@ -2643,8 +2650,8 @@ static void __init srso_select_mitigation(void)
 		break;
 
 	case SRSO_CMD_IBPB_ON_VMEXIT:
-		if (IS_ENABLED(CONFIG_CPU_SRSO)) {
-			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
+		if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY)) {
+			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
 
@@ -2656,9 +2663,9 @@ static void __init srso_select_mitigation(void)
 				setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
 			}
 		} else {
-			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
+			pr_err("WARNING: kernel not compiled with CPU_IBPB_ENTRY.\n");
 			goto pred_cmd;
-                }
+		}
 		break;
 
 	default:
-- 
2.48.1.601.g30ceb7b040-goog


