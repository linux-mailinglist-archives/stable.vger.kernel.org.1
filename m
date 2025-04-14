Return-Path: <stable+bounces-132589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0D7A883CE
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FBB58040B
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BD7274FDF;
	Mon, 14 Apr 2025 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf2dg4RO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B1A2D7FEE;
	Mon, 14 Apr 2025 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637479; cv=none; b=kefTayNzeD/ZI1a3qzg1UiNvNRjKYOPyZmkd2RSotW4eO83FmAW0H1a/T+Ltw2shioQXm8D4cXY7Ks73Z9WA170Fpc2++8AEOuK6mEeim/rf8Fvm1OEgKjQxBFanAxJ8Kfi8D8ctUGnj36+1x0iAllbnJEIN+mBQqgmYyDY12xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637479; c=relaxed/simple;
	bh=bGmUMddhxyjpgJG+ZNf7mpDiIWiXjexyBCbdzeGhEnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jdrdW29htH1ZTQDy8N0uZJhQiGbNfsd2AZcvcKH5n5WZyrJba/u+UaYeo2ZiiDWQmElZV8JCAxmIWX91YlmnppV+BSq1YrjAXDsq92EZtfGK6mDK6itKR0HwguWodTnyiOK+SdYeKPWSaSO/xyB6NadMa4JHXJG+/C+5rrKg90U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf2dg4RO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3A1C4CEE9;
	Mon, 14 Apr 2025 13:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637477;
	bh=bGmUMddhxyjpgJG+ZNf7mpDiIWiXjexyBCbdzeGhEnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hf2dg4ROZhp9C+f3HomsqOTfojTVjEygnP64qKxHDmGiz2CaN1i4wYC7C0LPm80NI
	 wqm3KVel3WYiUbTnLmQvYpZMk7o5Ug3q2NyMjgwDdPxI1hE97JLoZbkiOX22slGSOF
	 sfp3bf394+xo2fRBDHhV8DtJgJXBtgpuuMZs/PIdSSk+jXNL2DVgNcurX8UEZ9U/4k
	 2a9hkDXM2DLSIQBUURO3pN1rjf/vd7CPI/i51lKPgieXbfOSn+Lu0x3k5F7BkDKhUO
	 vz7fHo383s2YDxNrfh5G9TBnR99v93rYnFWPrficT8g3wF/w7kvifPoVlBvWFeBCdK
	 /wF+13jWCy5/w==
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
Subject: [PATCH AUTOSEL 6.1 13/17] x86/bugs: Don't fill RSB on context switch with eIBRS
Date: Mon, 14 Apr 2025 09:30:44 -0400
Message-Id: <20250414133048.680608-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133048.680608-1-sashal@kernel.org>
References: <20250414133048.680608-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.134
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
index f0f184afa44f3..0be0edb07a2a9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1553,7 +1553,7 @@ static void __init spec_ctrl_disable_kernel_rrsba(void)
 	rrsba_disabled = true;
 }
 
-static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_mitigation mode)
+static void __init spectre_v2_select_rsb_mitigation(enum spectre_v2_mitigation mode)
 {
 	/*
 	 * Similar to context switches, there are two types of RSB attacks
@@ -1577,7 +1577,7 @@ static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_
 	 */
 	switch (mode) {
 	case SPECTRE_V2_NONE:
-		return;
+		break;
 
 	case SPECTRE_V2_EIBRS:
 	case SPECTRE_V2_EIBRS_LFENCE:
@@ -1586,18 +1586,21 @@ static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_
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
@@ -1822,10 +1825,7 @@ static void __init spectre_v2_select_mitigation(void)
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
index b07e2167fcebf..8d46b9c0e9204 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -385,9 +385,9 @@ static void cond_mitigation(struct task_struct *next)
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


