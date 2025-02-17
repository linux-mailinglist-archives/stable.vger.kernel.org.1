Return-Path: <stable+bounces-116593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A97A38626
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 15:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016DC188F68C
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 14:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2772248B2;
	Mon, 17 Feb 2025 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yTQqH/Q7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4D621D00A
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802091; cv=none; b=U+44owEB/evyGQj6QWb5SXV0aVxg/kzVnvsXoPRa1M2X6Yz1f0igDD32EFnGpJahS5gbUYiEcaNAA3wf/X6zFQ1g4E3nT3sCMBHxN6TIoLbhE+BYigVkv9/Oo8jenejB/30ssBEl+O7obf/KOvVYRWr6/NUzzNDL0anDpeLTIlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802091; c=relaxed/simple;
	bh=BoQFm8Q60zW9MtZHQtqZObTn0SOZrMr9GoUmARwDKaM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BqNSgVKYos6ZB4JW1HXFVM9uWzV9kCtf6EjjAt/Vi5ChfKj4C6SxAHPEo98QQ8biU2y/pJO6NrWEymNTn3ypdhjCMNURm41QRjLTlrAVzQB7L8Vsh6l2h8BIRzsi+o88lXjOAwK5u130Im0Zz2qGpfmOhiDNLuU+hmNsfdCI0G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yTQqH/Q7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4F4C4CED1;
	Mon, 17 Feb 2025 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739802091;
	bh=BoQFm8Q60zW9MtZHQtqZObTn0SOZrMr9GoUmARwDKaM=;
	h=Subject:To:Cc:From:Date:From;
	b=yTQqH/Q7cf62bCcxIdnm+jHsO58llbl9i8B69LXZy47wSYQr4fWpQJ9R+LZZ27oxc
	 sv+vgY/BsQLKwP8GyfetdRXr1ZN24RxDjlhj4tg2HO1V4G0Azgzvvt7iAEjsAW7UNl
	 EVlBNh7GunG/41ZXrVazoYGq+mlvLS4wcNWyyxBo=
Subject: FAILED: patch "[PATCH] x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit" failed to apply to 5.10-stable tree
To: derkling@google.com,bp@alien8.de,torvalds@linux-foundation.org,yosryahmed@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Feb 2025 15:21:21 +0100
Message-ID: <2025021721-brunch-mankind-56c2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 318e8c339c9a0891c389298bb328ed0762a9935e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021721-brunch-mankind-56c2@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 318e8c339c9a0891c389298bb328ed0762a9935e Mon Sep 17 00:00:00 2001
From: Patrick Bellasi <derkling@google.com>
Date: Wed, 5 Feb 2025 14:04:41 +0000
Subject: [PATCH] x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit

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

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 87198d957e2f..be2c311f5118 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2599,7 +2599,8 @@ config MITIGATION_IBPB_ENTRY
 	depends on CPU_SUP_AMD && X86_64
 	default y
 	help
-	  Compile the kernel with support for the retbleed=ibpb mitigation.
+	  Compile the kernel with support for the retbleed=ibpb and
+	  spec_rstack_overflow={ibpb,ibpb-vmexit} mitigations.
 
 config MITIGATION_IBRS_ENTRY
 	bool "Enable IBRS on kernel entry"
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 5a505aa65489..a5d0998d7604 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1115,6 +1115,8 @@ static void __init retbleed_select_mitigation(void)
 
 	case RETBLEED_MITIGATION_IBPB:
 		setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
+		mitigate_smt = true;
 
 		/*
 		 * IBPB on entry already obviates the need for
@@ -1124,9 +1126,6 @@ static void __init retbleed_select_mitigation(void)
 		setup_clear_cpu_cap(X86_FEATURE_UNRET);
 		setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
 
-		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
-		mitigate_smt = true;
-
 		/*
 		 * There is no need for RSB filling: entry_ibpb() ensures
 		 * all predictions, including the RSB, are invalidated,
@@ -2646,6 +2645,7 @@ static void __init srso_select_mitigation(void)
 		if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
 			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB;
 
 				/*
@@ -2655,6 +2655,13 @@ static void __init srso_select_mitigation(void)
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
@@ -2663,8 +2670,8 @@ static void __init srso_select_mitigation(void)
 
 ibpb_on_vmexit:
 	case SRSO_CMD_IBPB_ON_VMEXIT:
-		if (IS_ENABLED(CONFIG_MITIGATION_SRSO)) {
-			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
+		if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
+			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
 
@@ -2676,8 +2683,8 @@ static void __init srso_select_mitigation(void)
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


