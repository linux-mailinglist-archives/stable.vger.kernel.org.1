Return-Path: <stable+bounces-132513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE4BA882C0
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C68189BAB6
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C94423D2AE;
	Mon, 14 Apr 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcJAWdC0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B5029219C;
	Mon, 14 Apr 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637309; cv=none; b=grTfmVC2rMc0KsBntcvlMHVxUWzKszFkeUwr1jeviHzStcQgZTaUJ3rg8SOl/FgraYLBnF+RQSEv8m9OayLj4Ogawj7ZfqzgfTzzZgdm5dUUpaIbIkkUGaSC61i+O1XkJvu7/RcECXLpzUkg6sAjcKSBmGAAwqczBldT28/3YCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637309; c=relaxed/simple;
	bh=BU6btFF+WtYDzw10dnMWnp2cVfDbDrMvDZ1JXuP0gaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G4CZ4B4AyZN2XxXWxv5zqBGFpkgZmriQe59o6ejJjkzTQsnZ9n/Lv2YwhvcKK0PpnmZb7BbFmGEt4wbBVNECzG6PyAwkNuiTSpaiS76mD1qVz+fIKTO7xzYYz0g/yC3Why2Ljve5bj1LUMi3J3j/3tCr4jCJM2X22f01ykuhVYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcJAWdC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED8EC4CEE2;
	Mon, 14 Apr 2025 13:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637308;
	bh=BU6btFF+WtYDzw10dnMWnp2cVfDbDrMvDZ1JXuP0gaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UcJAWdC0tFDypNh4DGvV3TK6dF6wCcdvwXgSSBPMA3AKxIaHmquHJvCOqH+mkYGfD
	 tc0pogzl61pRTF38w6NnSRGmwxk/NtKKwUqf6qD7z0ViNSO/Z+k3OOkR6gOf932322
	 Y66HYQ783YcjO/huzvgkMseTw6niJLvH6hWFT4F/BAOpgECue2FBkWqt/1dkkW436W
	 Jp8hMCulsAEu6ruXCMwhlmc5H9Iuj/bSZd3G8DmmfCGt2o3qtzw0XTvSTUhKXyPfka
	 VO0tt1M9pNK7/9MtlPGEKMcUMcAISw7sBNYTysy9wDMca1TL7z82udm8MsOSL/vhlz
	 aH1rvvCtQ1eEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Amit Shah <amit.shah@amd.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	bp@alien8.de,
	peterz@infradead.org,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org
Subject: [PATCH AUTOSEL 6.13 25/34] x86/bugs: Don't fill RSB on context switch with eIBRS
Date: Mon, 14 Apr 2025 09:27:19 -0400
Message-Id: <20250414132729.679254-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132729.679254-1-sashal@kernel.org>
References: <20250414132729.679254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.11
Content-Transfer-Encoding: 8bit

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 27ce8299bc1ec6df8306073785ff82b30b3cc5ee ]

User->user Spectre v2 attacks (including RSB) across context switches
are already mitigated by IBPB in cond_mitigation(), if enabled globally
or if either the prev or the next task has opted in to protection.  RSB
filling without IBPB serves no purpose for protecting user space, as
indirect branches are still vulnerable.

User->kernel RSB attacks are mitigated by eIBRS.  In which case the RSB
filling on context switch isn't needed, so remove it.

Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Reviewed-by: Amit Shah <amit.shah@amd.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/98cdefe42180358efebf78e3b80752850c7a3e1b.1744148254.git.jpoimboe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 24 ++++++++++++------------
 arch/x86/mm/tlb.c          |  6 +++---
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 589e34c0b70b5..46bddb5bb15ff 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1578,7 +1578,7 @@ static void __init spec_ctrl_disable_kernel_rrsba(void)
 	rrsba_disabled = true;
 }
 
-static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_mitigation mode)
+static void __init spectre_v2_select_rsb_mitigation(enum spectre_v2_mitigation mode)
 {
 	/*
 	 * Similar to context switches, there are two types of RSB attacks
@@ -1602,7 +1602,7 @@ static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_
 	 */
 	switch (mode) {
 	case SPECTRE_V2_NONE:
-		return;
+		break;
 
 	case SPECTRE_V2_EIBRS:
 	case SPECTRE_V2_EIBRS_LFENCE:
@@ -1611,18 +1611,21 @@ static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_
 			pr_info("Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT\n");
 			setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT_LITE);
 		}
-		return;
+		break;
 
 	case SPECTRE_V2_RETPOLINE:
 	case SPECTRE_V2_LFENCE:
 	case SPECTRE_V2_IBRS:
-		pr_info("Spectre v2 / SpectreRSB : Filling RSB on VMEXIT\n");
+		pr_info("Spectre v2 / SpectreRSB: Filling RSB on context switch and VMEXIT\n");
+		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
 		setup_force_cpu_cap(X86_FEATURE_RSB_VMEXIT);
-		return;
-	}
+		break;
 
-	pr_warn_once("Unknown Spectre v2 mode, disabling RSB mitigation at VM exit");
-	dump_stack();
+	default:
+		pr_warn_once("Unknown Spectre v2 mode, disabling RSB mitigation\n");
+		dump_stack();
+		break;
+	}
 }
 
 /*
@@ -1854,10 +1857,7 @@ static void __init spectre_v2_select_mitigation(void)
 	 *
 	 * FIXME: Is this pointless for retbleed-affected AMD?
 	 */
-	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
-	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
-
-	spectre_v2_determine_rsb_fill_type_at_vmexit(mode);
+	spectre_v2_select_rsb_mitigation(mode);
 
 	/*
 	 * Retpoline protects the kernel, but doesn't protect firmware.  IBRS
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 90a9e47409131..5bd6c3ba9af7d 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -389,9 +389,9 @@ static void cond_mitigation(struct task_struct *next)
 	prev_mm = this_cpu_read(cpu_tlbstate.last_user_mm_spec);
 
 	/*
-	 * Avoid user/user BTB poisoning by flushing the branch predictor
-	 * when switching between processes. This stops one process from
-	 * doing Spectre-v2 attacks on another.
+	 * Avoid user->user BTB/RSB poisoning by flushing them when switching
+	 * between processes. This stops one process from doing Spectre-v2
+	 * attacks on another.
 	 *
 	 * Both, the conditional and the always IBPB mode use the mm
 	 * pointer to avoid the IBPB when switching between tasks of the
-- 
2.39.5


