Return-Path: <stable+bounces-118601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1023AA3F782
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 15:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC831894D8A
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7170E20FA90;
	Fri, 21 Feb 2025 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3hGvtbmP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6365620D4E4
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148941; cv=none; b=cD9LHnicXZGLXEZE7Wr8eazjSQkiiZs/FgvIiHuFULG4hLRH0e5600sNwXRl5slQF+i6dH5X70rpgFQRIUzWLIC9YljvJB3YK9IBuUfbzu9+uWpTZ2bJNOC6veaZdbZz7HhyYfcUSczpXY072Nf8Y2xxax8BnxbKBp3VqU0QoUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148941; c=relaxed/simple;
	bh=AFjIBXObHULWwBBeti/UQ9IenIPyekvwF6dd/WNVR1k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qVsfqrZMDRAtqcBI/QK4H/7vVnihV87iKiscFG+gD0+d6cCjWU+Ffq+SJo1MPkfhs98VnousZ+WTzBIQNEfnRfZZplhbCDoIMZAQ2DA3HXhyXD6KsJXSw7HjR9IJutaYN+m1+oFceEaHpsBzBPzl7P2dajGKuwSNZW/Oi7AQ+xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--derkling.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3hGvtbmP; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--derkling.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-438e180821aso11446325e9.1
        for <stable@vger.kernel.org>; Fri, 21 Feb 2025 06:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740148938; x=1740753738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nkqxYFvP1YOYc3/mGAzLSNb9s+ekzsxk4Sz8UsgdvTg=;
        b=3hGvtbmPVHtiHyEhwtkKt0rrL4vpDTh5u8cUsj8m+jjxdwnkoNG33kb5HepmrXCo8s
         78T7gocD7OMCIad/YmhqNW4XdR0+C8a/LhqjqW5UyNhezqPrWDgEnqa4b+PD8GRCGbNK
         QKsJJYU/rQ0ANTJ91RegifkA+7SspNFwXXCCY/bsIn3W3a3+tqiT/hyh3RABmjRBDlV3
         VTTtItj0Sj9b1FxF/V2uWD8IWZFgNWff1rv2yOSyXlz8pJA6INi4HsJW2cydWLBZO6IA
         SWxPfuJcu9bvh/kZUdKEkPJMWfllF+ApVIjX4q0txSbpLlYyE5Y5Bltxa2mGCanG4V1I
         D5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740148938; x=1740753738;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nkqxYFvP1YOYc3/mGAzLSNb9s+ekzsxk4Sz8UsgdvTg=;
        b=KBrVxzd+8mRQLEhdlbg/+/0JLU8qSnm/ne78+gslubT907N7qHkXZ6l5s9YMRiLFLy
         TGri5hqfEOxKCRk/PXI8TgdgBpkFACRLeOj0G/sRrtebe4Qd0I+afPBta+GHLHyxn+5V
         eWAQ13/JZes6GXM5RM0cbHzT8hmakJO5KfWFJGV4+RlX6mzyV9uOofOjT5lWqCP8NJUL
         hB1jkP8PJzv8b2M+Ac/86MK9TYzFjNGUGdIyFGtoZKByXTTYJWrgTf80pqO+EhAKWhAD
         xqKrwUeELDTyd3SY13LNGAZlLdaertAefqtl6g5lgPXGuyM22CRXD4xLlBWOY40/CIsq
         dufw==
X-Gm-Message-State: AOJu0Yz6dh/5+Q2nXTgT/+70KoHu5XhYfJ3S4xM7ctWYTnLQlnamZEKn
	bMXYLAV+DVi/2tUG8Iz9UZyQLKBBubM00b7DRbrCDcx5PeogxbMleWKqgyGEViRzNao3dcGtjUJ
	OP5Dm8/0viH1965dmQJ+I/VxFcB5vHCja15KARu3t0JaniY2FLRR3etRgjj84kaZ889MA0BKBO/
	8b6z5lMTnVuVx0I02FtFimTgP4GTXz5IGZaAZ3bxO6LVk=
X-Google-Smtp-Source: AGHT+IF3X1+pcfYXoY0cCWqu4lNatPIFh55YyQdIDckUD8if227AnRzs56DLXcCjuXNi/nuuw+YQUa8szzXjQg==
X-Received: from wmsd12.prod.google.com ([2002:a05:600c:3acc:b0:439:80fc:8bb2])
 (user=derkling job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5108:b0:439:9898:f18c with SMTP id 5b1f17b1804b1-439b5b3dbbcmr11992165e9.26.1740148937808;
 Fri, 21 Feb 2025 06:42:17 -0800 (PST)
Date: Fri, 21 Feb 2025 14:42:09 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250221144209.135763-1-derkling@google.com>
Subject: [PATCH 5.15] x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit
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
index 2f6312e7ce81f..90ac8d84389cf 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2449,7 +2449,8 @@ config CPU_IBPB_ENTRY
 	depends on CPU_SUP_AMD && X86_64
 	default y
 	help
-	  Compile the kernel with support for the retbleed=ibpb mitigation.
+	  Compile the kernel with support for the retbleed=ibpb and
+	  spec_rstack_overflow={ibpb,ibpb-vmexit} mitigations.
 
 config CPU_IBRS_ENTRY
 	bool "Enable IBRS on kernel entry"
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f84d59cd180b3..dfc02fb32375c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1092,6 +1092,8 @@ static void __init retbleed_select_mitigation(void)
 
 	case RETBLEED_MITIGATION_IBPB:
 		setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
+		mitigate_smt = true;
 
 		/*
 		 * IBPB on entry already obviates the need for
@@ -1101,8 +1103,6 @@ static void __init retbleed_select_mitigation(void)
 		setup_clear_cpu_cap(X86_FEATURE_UNRET);
 		setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
 
-		mitigate_smt = true;
-
 		/*
 		 * There is no need for RSB filling: entry_ibpb() ensures
 		 * all predictions, including the RSB, are invalidated,
@@ -2607,6 +2607,7 @@ static void __init srso_select_mitigation(void)
 		if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY)) {
 			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB;
 
 				/*
@@ -2616,6 +2617,13 @@ static void __init srso_select_mitigation(void)
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
@@ -2624,8 +2632,8 @@ static void __init srso_select_mitigation(void)
 		break;
 
 	case SRSO_CMD_IBPB_ON_VMEXIT:
-		if (IS_ENABLED(CONFIG_CPU_SRSO)) {
-			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
+		if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY)) {
+			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
 
@@ -2637,9 +2645,9 @@ static void __init srso_select_mitigation(void)
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


