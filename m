Return-Path: <stable+bounces-118602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EE8A3F7BF
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 15:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2738D1893CBD
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C14B20E6E6;
	Fri, 21 Feb 2025 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHfu3m8E"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E52E20E70E
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149559; cv=none; b=b7Pm1angh5JD16sh0IfoajvMjMx0ZYez+WScQpyLal7P5y5iQu0fNP6MOcmjNGPkMM557CRGoHt9CwgsSEcqvGrRRsIxuEhMmeoqZCU6usbTAzHq3bXO6Xw+LbdQL5XMKPTNcw3/GWYt4EE/iDJYDwCHx+LmNBf43OFczuCCl/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149559; c=relaxed/simple;
	bh=VWMhrPMtisJb4hIm7Q7em7/129wWiVmvlzMbHR8p3mI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LmrL52Ois/aUnSYBUu1TLXM7v36WHm0Wlm4cQ7xPorgECkIWQbq/tu7SvlwyOAzbHCSI2adNsz+VAhEmuec/nC5KdsNZ3UxzYJmlXe7/2yn2xcWcMGX1E3tjJjdgxjQKKqpQf1jZ2BNu1hfwXOV7DwqYsgbFDNaWLMbY6GgQf9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--derkling.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SHfu3m8E; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--derkling.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38f36fcf4b3so1324751f8f.1
        for <stable@vger.kernel.org>; Fri, 21 Feb 2025 06:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740149556; x=1740754356; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PJklh7u9DqRRvWHRSedTQSVAJYR9DI+wbKJuVOJ/zZU=;
        b=SHfu3m8EzlyymUDhGMP1jxOTKIftEITksjridHQpLcLUafOjg+N3nNlMQAVVNYJcNd
         0GCM5Vu93TeUF4z55KLtrJzZODHh6TSwAJTBoVR+uU0IgNHdNqjF5Qn0KhvoqxbBVE4k
         FxCmuYD1ZNWLqXnqVLNGUEqSk6KUzQh0eRh1/phqobjaFM/iIClBPOyN2zelaW3Kl/Or
         AkvlrDQpaeuSRXQZJKqkwq4Z+XIE8mWdgp18PKHr8NHNFVwNK0SbsVX3gpC20J7S16wp
         2xfhwAQoPC1KSdhZKpngzHkjao68WSEizNe1lPxVsz+TXtW7g6qfYd/+K4bh/BuNYRir
         g7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149556; x=1740754356;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJklh7u9DqRRvWHRSedTQSVAJYR9DI+wbKJuVOJ/zZU=;
        b=Shgu1xYwKypH2Oq6kG4R04Mq2bnbXxQp84FwSqkADINq0lm2mGcc8krNrMSmk/v5K5
         DG2Iwit0PdJSq3PzT0TNKqBpp+FRtDKSGtyIKawiDaDCu9kpdoHSCGNP2masV3TpEJRL
         s9WXUkpRynMzplyzRHFI1EgC6867Vv0rzo4drK6AWC/bmlbtNCoGpR+zsF4M1YAighY3
         0vAqmQ9cD0UG9JNNlJdeMMHcEDIeqi5pI8rUsMJeSAmIT8uXIwMm6vSkAv05lQnWon2f
         cPoiSaJCZIChS5slzqEEjZs5IVrSkYGljg+cXt90kYfk/j4/29ifbOke+q97Qq011YX+
         puHA==
X-Gm-Message-State: AOJu0Yxun1KInG1oRTlLwv4MBIfl+Ig6fDypZN28zY6V2G1Rro75pseH
	1KDdfhu2CDBW3rX3R61T4dM1MQNiswoEFi9W7HTatOC50QYOm8ObPiOViXTWPrblxwtgMR1XZih
	AuKvjHz0FQL8cPXiRnxSBZESWZhPAzzogCrF5cjkF65DDBZFD7PDffbMNKmGiEBujGE3LQd7/P0
	sV41sNz+ZXyZm7b2YPlVcZgJ3H4or/S3x3f56koo+mYYA=
X-Google-Smtp-Source: AGHT+IEwZvTcD91+iLHw+VrVG2ux5qKn48gbc83ImXS9beNu4zdCBswbeRoOKzBIt4Xn/WEPEMWSlmskee/ysg==
X-Received: from wmbfk14.prod.google.com ([2002:a05:600c:cce:b0:439:7d73:d8fc])
 (user=derkling job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:6d0a:0:b0:38d:dd70:d70d with SMTP id ffacd0b85a97d-38f6e947399mr3767006f8f.18.1740149555851;
 Fri, 21 Feb 2025 06:52:35 -0800 (PST)
Date: Fri, 21 Feb 2025 14:51:56 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250221145156.195014-1-derkling@google.com>
Subject: [PATCH 5.10] x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit
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
 arch/x86/kernel/cpu/bugs.c | 20 ++++++++++++++------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0c802ade80406..00ae2e2adcadb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2463,7 +2463,8 @@ config CPU_IBPB_ENTRY
 	depends on CPU_SUP_AMD && X86_64
 	default y
 	help
-	  Compile the kernel with support for the retbleed=ibpb mitigation.
+	  Compile the kernel with support for the retbleed=ibpb and
+	  spec_rstack_overflow={ibpb,ibpb-vmexit} mitigations.
 
 config CPU_IBRS_ENTRY
 	bool "Enable IBRS on kernel entry"
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0b7f6bcbb8ea9..725f827718a71 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1061,6 +1061,8 @@ static void __init retbleed_select_mitigation(void)
 
 	case RETBLEED_MITIGATION_IBPB:
 		setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
+		mitigate_smt = true;
 
 		/*
 		 * IBPB on entry already obviates the need for
@@ -1070,8 +1072,6 @@ static void __init retbleed_select_mitigation(void)
 		setup_clear_cpu_cap(X86_FEATURE_UNRET);
 		setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
 
-		mitigate_smt = true;
-
 		/*
 		 * There is no need for RSB filling: entry_ibpb() ensures
 		 * all predictions, including the RSB, are invalidated,
@@ -2469,6 +2469,7 @@ static void __init srso_select_mitigation(void)
 		if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY)) {
 			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB;
 
 				/*
@@ -2478,6 +2479,13 @@ static void __init srso_select_mitigation(void)
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
@@ -2486,8 +2494,8 @@ static void __init srso_select_mitigation(void)
 		break;
 
 	case SRSO_CMD_IBPB_ON_VMEXIT:
-		if (IS_ENABLED(CONFIG_CPU_SRSO)) {
-			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
+		if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY)) {
+			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
 
@@ -2499,9 +2507,9 @@ static void __init srso_select_mitigation(void)
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


