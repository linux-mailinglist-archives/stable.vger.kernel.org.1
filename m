Return-Path: <stable+bounces-118597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4D2A3F749
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 15:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733F68632AA
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 14:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC891D5146;
	Fri, 21 Feb 2025 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XpbYtsM+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791B32BD04
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148265; cv=none; b=AnEvbNBOXUHusZWK9+EycqIFqQWv3KeL+w4AMz70duI3zD/+0g4QhuCXtWjXLvEtstGEn4K3aFprnpRXn38RViwzeoRouRcYR62FUARSXUh5781wp1zeS3ZLpDhEUfqYmwiKG9GM8qTghlHdyLvvKfMqxsk3OCVwmkygD4Rmvrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148265; c=relaxed/simple;
	bh=OXOS/+rmht491HT7vYQuTBtWV+4wAVuMUGedjiWsvoM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nUry8Mj9whzc59S7VqtOJDDCBq8vwI+ScAcMkM7fHzBhpKsPWXVXWKtZs5NI6xmSQla3gWMn647Hcj31UVEohJlyOPhqLFqyHkar7N3X0UBzxuoXajNRWd0AisSY5fEbHfOiv/qkdTUozP71q6pX6qZtNUB8PfIqOyXdHewqUuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--derkling.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XpbYtsM+; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--derkling.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38f394f6d84so2506507f8f.1
        for <stable@vger.kernel.org>; Fri, 21 Feb 2025 06:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740148262; x=1740753062; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d6lHGB4RW+fUm+w8DCgpzh+6Wzc49VTdZcnDOzB17rM=;
        b=XpbYtsM+ZE3pTD8u/KQ+JBuIvBfDim361fn1fdjeoWSFKoX+HLJBnJC9OaeVMGhKxS
         FIibLxInk1LupJJ0VRBKyIyFI/EpUyRiNUlMD1QX6PJHray5y8fjF49Q8rinzuhzb+DL
         nzwRqj7xSzasxA9Qg8uFDg9sYFRnDBPO5DUi+XmUdxkHLvZ9HvSTVqUXK/6SLkNU20FS
         c9UOzkrt/dO8FspLRIFdlBjiaX5/3aQ3WEslmHMiOwtEdbfWoe+82kN42S0GV4wqG1o3
         d7wY7siax7nJLINfysfoE51iUe+Hi0HkTgVUy7ksoluN+t+it5koEC7DwG1eE8ZuOpMR
         6x+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740148262; x=1740753062;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d6lHGB4RW+fUm+w8DCgpzh+6Wzc49VTdZcnDOzB17rM=;
        b=WTLSBZJbqIY8udD3S++h5WhBkK9ZZsVUJtX9mj2xhKBfHqtDKrE/Qi9ks9LcZFbJxi
         MJG3orbNXt5tFcIh2ycJAL98LM8Gv/0re2H5FrMpB/ePvMkFII3zTTjPH90GEilo496i
         dDM3a0G3gGclBnUxcoEzocyGQ466X1tR64REIXlZEsR2KKwwXSU76swGO5piSOidO99R
         3cXNGM/B0Y7jgXPoN7r/LG2Z0ugNy/nwEfiN5DuJy8Z8SkHXHfBfZhWqGnAGRfN85y8h
         i9H7EPqq1nEdzsoxqo+Qs38VENKA6Dt8lhqun53jzo+cwAoeSVZnGFFAk5dZ35znAXjx
         h/UA==
X-Gm-Message-State: AOJu0YxeE/5pJhJaaCc/m1G81agm4lqRx1w/Wky1LNXOWJXP/MdpElpZ
	Dd1XqT18YzNwVm770GI+pzDtI5VRvNqlFTRyfem5f/06wfyd7B7kGstikJut1XA1BuEPiT4yZbx
	7UM5+6zWq6hqbJ0gqU3/XftmbocmW98kJlnDnwOCPIvDFvQ/dykmtcIdxmyO5BnZsUWc3fWC23g
	0R4riNWofVy/WOPUDo2TZw8RlItC9SE0Zp00l1nQNrePw=
X-Google-Smtp-Source: AGHT+IHp9KpPqihhkAMCoq7AJPuOMZlSKfO7K/P7TqXNdVLdlMAnTqXOd4eugadlp0OBHoJR/g4/4JhJ/pRKdA==
X-Received: from wmsp4.prod.google.com ([2002:a05:600c:1d84:b0:439:942c:b180])
 (user=derkling job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:6da5:0:b0:38d:cf33:31a1 with SMTP id ffacd0b85a97d-38f707afc79mr2963941f8f.23.1740148261904;
 Fri, 21 Feb 2025 06:31:01 -0800 (PST)
Date: Fri, 21 Feb 2025 14:30:51 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250221143051.23140-1-derkling@google.com>
Subject: [PATCH 6.1] x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit
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
index 49cea5b81649d..ca8dd7e5585f0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2506,7 +2506,8 @@ config CPU_IBPB_ENTRY
 	depends on CPU_SUP_AMD && X86_64
 	default y
 	help
-	  Compile the kernel with support for the retbleed=ibpb mitigation.
+	  Compile the kernel with support for the retbleed=ibpb and
+	  spec_rstack_overflow={ibpb,ibpb-vmexit} mitigations.
 
 config CPU_IBRS_ENTRY
 	bool "Enable IBRS on kernel entry"
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index fa2045ad408a7..03221a060ae77 100644
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


