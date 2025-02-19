Return-Path: <stable+bounces-117006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0B6A3B3F0
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73512172A21
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950911AF0C8;
	Wed, 19 Feb 2025 08:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cMoi9/iG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300A1A841F;
	Wed, 19 Feb 2025 08:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953913; cv=none; b=RojgmRGUrVx2gnf8hbzLOBR3BKrPqcMkVMvquD9FUR54TT2mKmwq2I954BMtuE1ujJCexZFT8mGQoBX8COipHyr4i3D/hNMlRAKVHpCw5AxYnYy0tu6sGVWlXo9jb3tTwJGPwvrU2yJBFpv3joweUPdFn6sBXk/ik7tyK3Wz/uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953913; c=relaxed/simple;
	bh=xFzhKRHroCBuRK64INOfUvS+iUj6TWeB11eRtBL5qLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdqK1b2C90YE6FFxQZPDWwZiW0jR0ogSBANVb2/cZIG82Oe4rw2FfPyqCoo1jwFaCQO0FowG3GjlTG0Cn1GO/4dT5SqVof8k43+n3JXnx+kNBFI2zPY+VI6WuwjhRFkVqlcQ1K2A6DhEmEJZ51L7s2L7lk21QHe+T/htABTMWOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cMoi9/iG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42C9C4CEEB;
	Wed, 19 Feb 2025 08:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739953913;
	bh=xFzhKRHroCBuRK64INOfUvS+iUj6TWeB11eRtBL5qLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cMoi9/iGlBsOrEYpbCHn2N11eiqGEASqWv9C1sx5AiUP8LRfsssL+3raxcSQSf87n
	 SW3FHcrzm+276O3gIFEM9xw8rwAcMFNcEU1M8JKVHGImubdV/+iWLTDXGbEEJ/p1Rn
	 OYaUZg419v2ckfTCHLQ55sM39mTRMZOZBDx/uH1g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yosry Ahmed <yosryahmed@google.com>,
	Patrick Bellasi <derkling@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	stable@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.13 006/274] x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit
Date: Wed, 19 Feb 2025 09:24:20 +0100
Message-ID: <20250219082609.783754426@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082609.533585153@linuxfoundation.org>
References: <20250219082609.533585153@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrick Bellasi <derkling@google.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/Kconfig           |    3 ++-
 arch/x86/kernel/cpu/bugs.c |   21 ++++++++++++++-------
 2 files changed, 16 insertions(+), 8 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2593,7 +2593,8 @@ config MITIGATION_IBPB_ENTRY
 	depends on CPU_SUP_AMD && X86_64
 	default y
 	help
-	  Compile the kernel with support for the retbleed=ibpb mitigation.
+	  Compile the kernel with support for the retbleed=ibpb and
+	  spec_rstack_overflow={ibpb,ibpb-vmexit} mitigations.
 
 config MITIGATION_IBRS_ENTRY
 	bool "Enable IBRS on kernel entry"
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1115,6 +1115,8 @@ do_cmd_auto:
 
 	case RETBLEED_MITIGATION_IBPB:
 		setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
+		mitigate_smt = true;
 
 		/*
 		 * IBPB on entry already obviates the need for
@@ -1124,9 +1126,6 @@ do_cmd_auto:
 		setup_clear_cpu_cap(X86_FEATURE_UNRET);
 		setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
 
-		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
-		mitigate_smt = true;
-
 		/*
 		 * There is no need for RSB filling: entry_ibpb() ensures
 		 * all predictions, including the RSB, are invalidated,
@@ -2643,6 +2642,7 @@ static void __init srso_select_mitigatio
 		if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
 			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB;
 
 				/*
@@ -2652,6 +2652,13 @@ static void __init srso_select_mitigatio
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
 			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
@@ -2659,8 +2666,8 @@ static void __init srso_select_mitigatio
 		break;
 
 	case SRSO_CMD_IBPB_ON_VMEXIT:
-		if (IS_ENABLED(CONFIG_MITIGATION_SRSO)) {
-			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
+		if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
+			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
 
@@ -2672,8 +2679,8 @@ static void __init srso_select_mitigatio
 				setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
 			}
 		} else {
-			pr_err("WARNING: kernel not compiled with MITIGATION_SRSO.\n");
-                }
+			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
+		}
 		break;
 	default:
 		break;



