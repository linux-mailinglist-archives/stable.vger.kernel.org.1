Return-Path: <stable+bounces-83062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3AC9953E5
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 17:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882BA286F09
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AECB1E0B68;
	Tue,  8 Oct 2024 15:59:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5472A1E04BA
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403146; cv=none; b=pic4sMVqt5/N3CMsH34cY16xPQWJiZjs9lDcX4FpmZpjh8I+tHEt11YSMipnE+VWc27awvQrKz3ph0SIvmM4oPhlVF0bVPksFA9yEpArcA8S64PriJw6CCfSDiSZepc4Ur6KE2LD/E4H0fAXMu4bzFUV13F9y2iNhg0lTvLRkao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403146; c=relaxed/simple;
	bh=qK2+Wd5iNOGvCpcNGc5EIiiM45FFaFPDmiSeTDi23/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=di3hzLkV4iDAggDQl5oY5F+Nb6f+5ni3k8bAnwwa26yzTe5tr6sNzp4abdYDJUA1VNZctbnBUo7NLewqlKqJl92zNZDOBRiT02qrOzuNhbH8xVhMSafHHOcQjLJ8vDLJdHnEiQcrh92Ge7Umxe8VSDqd/53tBBXsfoa/yV+45nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7E33FEC;
	Tue,  8 Oct 2024 08:59:34 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D7603F73F;
	Tue,  8 Oct 2024 08:59:04 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com,
	catalin.marnias@arm.com,
	mark.rutland@arm.com,
	stable@vger.kernel.org,
	will@kernel.org
Subject: [PATCH 4/6] arm64: probes: Move kprobes-specific fields
Date: Tue,  8 Oct 2024 16:58:49 +0100
Message-Id: <20241008155851.801546-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241008155851.801546-1-mark.rutland@arm.com>
References: <20241008155851.801546-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We share struct arch_probe_insn between krpboes and uprobes, but most of
its fields aren't necessary for uprobes:

* The 'insn' field is only used by kprobes as a pointer to the XOL slot.

* The 'restore' field is only used by probes as the PC to restore after
  stepping an instruction in the XOL slot.

* The 'pstate_cc' field isn't used by kprobes or uprobes, and seems to
  only exist as a result of copy-pasting the 32-bit arm implementation
  of kprobes.

As these fields live in struct arch_probe_insn they cannot use
definitions that only exist when CONFIG_KPROBES=y, such as the
kprobe_opcode_t typedef, which we'd like to use in subsequent patches.

Clean this up by removing the 'pstate_cc' field, and moving the
kprobes-specific fields into the kprobes-specific struct
arch_specific_insn. To make it clear that the fields are related to
stepping instructions in the XOL slot, 'insn' is renamed to 'xol_insn'
and 'restore' is renamed to 'xol_restore'

At the same time, remove the misleading and useless comment above struct
arch_probe_insn.

The should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/probes.h    |  8 +++-----
 arch/arm64/kernel/probes/kprobes.c | 30 +++++++++++++++---------------
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/probes.h b/arch/arm64/include/asm/probes.h
index 006946745352e..4aa54322794da 100644
--- a/arch/arm64/include/asm/probes.h
+++ b/arch/arm64/include/asm/probes.h
@@ -12,18 +12,16 @@
 typedef u32 probe_opcode_t;
 typedef void (probes_handler_t) (u32 opcode, long addr, struct pt_regs *);
 
-/* architecture specific copy of original instruction */
 struct arch_probe_insn {
-	probe_opcode_t *insn;
-	pstate_check_t *pstate_cc;
 	probes_handler_t *handler;
-	/* restore address after step xol */
-	unsigned long restore;
 };
 #ifdef CONFIG_KPROBES
 typedef u32 kprobe_opcode_t;
 struct arch_specific_insn {
 	struct arch_probe_insn api;
+	probe_opcode_t *xol_insn;
+	/* restore address after step xol */
+	unsigned long xol_restore;
 };
 #endif
 
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 4268678d0e86c..222419a41a400 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -43,7 +43,7 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
 
 static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 {
-	kprobe_opcode_t *addr = p->ainsn.api.insn;
+	kprobe_opcode_t *addr = p->ainsn.xol_insn;
 
 	/*
 	 * Prepare insn slot, Mark Rutland points out it depends on a coupe of
@@ -70,14 +70,14 @@ static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 	/*
 	 * Needs restoring of return address after stepping xol.
 	 */
-	p->ainsn.api.restore = (unsigned long) p->addr +
+	p->ainsn.xol_restore = (unsigned long) p->addr +
 	  sizeof(kprobe_opcode_t);
 }
 
 static void __kprobes arch_prepare_simulate(struct kprobe *p)
 {
 	/* This instructions is not executed xol. No need to adjust the PC */
-	p->ainsn.api.restore = 0;
+	p->ainsn.xol_restore = 0;
 }
 
 static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
@@ -110,18 +110,18 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 		return -EINVAL;
 
 	case INSN_GOOD_NO_SLOT:	/* insn need simulation */
-		p->ainsn.api.insn = NULL;
+		p->ainsn.xol_insn = NULL;
 		break;
 
 	case INSN_GOOD:	/* instruction uses slot */
-		p->ainsn.api.insn = get_insn_slot();
-		if (!p->ainsn.api.insn)
+		p->ainsn.xol_insn = get_insn_slot();
+		if (!p->ainsn.xol_insn)
 			return -ENOMEM;
 		break;
 	}
 
 	/* prepare the instruction */
-	if (p->ainsn.api.insn)
+	if (p->ainsn.xol_insn)
 		arch_prepare_ss_slot(p);
 	else
 		arch_prepare_simulate(p);
@@ -148,9 +148,9 @@ void __kprobes arch_disarm_kprobe(struct kprobe *p)
 
 void __kprobes arch_remove_kprobe(struct kprobe *p)
 {
-	if (p->ainsn.api.insn) {
-		free_insn_slot(p->ainsn.api.insn, 0);
-		p->ainsn.api.insn = NULL;
+	if (p->ainsn.xol_insn) {
+		free_insn_slot(p->ainsn.xol_insn, 0);
+		p->ainsn.xol_insn = NULL;
 	}
 }
 
@@ -205,9 +205,9 @@ static void __kprobes setup_singlestep(struct kprobe *p,
 	}
 
 
-	if (p->ainsn.api.insn) {
+	if (p->ainsn.xol_insn) {
 		/* prepare for single stepping */
-		slot = (unsigned long)p->ainsn.api.insn;
+		slot = (unsigned long)p->ainsn.xol_insn;
 
 		kprobes_save_local_irqflag(kcb, regs);
 		instruction_pointer_set(regs, slot);
@@ -245,8 +245,8 @@ static void __kprobes
 post_kprobe_handler(struct kprobe *cur, struct kprobe_ctlblk *kcb, struct pt_regs *regs)
 {
 	/* return addr restore if non-branching insn */
-	if (cur->ainsn.api.restore != 0)
-		instruction_pointer_set(regs, cur->ainsn.api.restore);
+	if (cur->ainsn.xol_restore != 0)
+		instruction_pointer_set(regs, cur->ainsn.xol_restore);
 
 	/* restore back original saved kprobe variables and continue */
 	if (kcb->kprobe_status == KPROBE_REENTER) {
@@ -348,7 +348,7 @@ kprobe_breakpoint_ss_handler(struct pt_regs *regs, unsigned long esr)
 	struct kprobe *cur = kprobe_running();
 
 	if (cur && (kcb->kprobe_status & (KPROBE_HIT_SS | KPROBE_REENTER)) &&
-	    ((unsigned long)&cur->ainsn.api.insn[1] == addr)) {
+	    ((unsigned long)&cur->ainsn.xol_insn[1] == addr)) {
 		kprobes_restore_local_irqflag(kcb, regs);
 		post_kprobe_handler(cur, kcb, regs);
 
-- 
2.30.2


