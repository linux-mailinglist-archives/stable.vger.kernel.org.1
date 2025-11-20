Return-Path: <stable+bounces-195282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DA8C75455
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B97534F365A
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC3034D91A;
	Thu, 20 Nov 2025 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HMvt/aGG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB162328611
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653824; cv=none; b=sglTalPxVW7lE3Ofc84GlwR1nYY+3Jf14j3xnGl4f7vuAtW7xZLxIQcIEc94gWkDmP6xIoHqQgWLFFVLhVGrzT4B/F0HmsGHE78M5F5NedYbm8r8bZthqUK+uin9JHuS/4TnO8siBXrWMA8HEyNGTzRhYuEbu5rKHDJYoVBYGEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653824; c=relaxed/simple;
	bh=6WVos+nlmP7MhtdXF89/TNzsAzvbcFjgaldIHR7478U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YaRyFpNycD0Qiss0ar+9RRU7SPMtbDHq/GrxyAMlyezOidFP0nL4HC6AJIRa8KgjZGW2F/ZsaM5FGayA4Do8kemx3HbkJ0/9+OB9MIJ0UKHX3VjklVYIFWuoVuvEZxJi+1X7xj9dduq4+aEQCHqndciYy8numr4fJ122FYy2tXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HMvt/aGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7E1C4CEF1;
	Thu, 20 Nov 2025 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763653824;
	bh=6WVos+nlmP7MhtdXF89/TNzsAzvbcFjgaldIHR7478U=;
	h=Subject:To:Cc:From:Date:From;
	b=HMvt/aGGd9Jez/3Riak33S5WgBdS7mugSELFLru3JN59M+QkGZLiRLtx2iao6UZEn
	 ZQ8KyHVo8Nnx7Mr2ZssGCdo7/eouvWotroLC5Y10dr/xaGHfL1NU6S0SOHBQ4E34eD
	 8xdzL7p064lPD6wzQyhno85xXSR0yIl8IhmeY9DQ=
Subject: FAILED: patch "[PATCH] KVM: arm64: Make all 32bit ID registers fully writable" failed to apply to 6.12-stable tree
To: maz@kernel.org,oupton@kernel.org,peter.maydell@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 16:50:21 +0100
Message-ID: <2025112021-arrest-chip-7336@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 3f9eacf4f0705876a5d6526d7d320ca91d7d7a16
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112021-arrest-chip-7336@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3f9eacf4f0705876a5d6526d7d320ca91d7d7a16 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Thu, 30 Oct 2025 12:27:05 +0000
Subject: [PATCH] KVM: arm64: Make all 32bit ID registers fully writable

32bit ID registers aren't getting much love these days, and are
often missed in updates. One of these updates broke restoring
a GICv2 guest on a GICv3 machine.

Instead of performing a piecemeal fix, just bite the bullet
and make all 32bit ID regs fully writable. KVM itself never
relies on them for anything, and if the VMM wants to mess up
the guest, so be it.

Fixes: 5cb57a1aff755 ("KVM: arm64: Zero ID_AA64PFR0_EL1.GIC when no GICv3 is presented to the guest")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Cc: stable@vger.kernel.org
Reviewed-by: Oliver Upton <oupton@kernel.org>
Link: https://patch.msgid.link/20251030122707.2033690-2-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index e67eb39ddc11..ad82264c6cbe 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2595,19 +2595,23 @@ static bool bad_redir_trap(struct kvm_vcpu *vcpu,
 	.val = 0,				\
 }
 
-/* sys_reg_desc initialiser for known cpufeature ID registers */
-#define AA32_ID_SANITISED(name) {		\
-	ID_DESC(name),				\
-	.visibility = aa32_id_visibility,	\
-	.val = 0,				\
-}
-
 /* sys_reg_desc initialiser for writable ID registers */
 #define ID_WRITABLE(name, mask) {		\
 	ID_DESC(name),				\
 	.val = mask,				\
 }
 
+/*
+ * 32bit ID regs are fully writable when the guest is 32bit
+ * capable. Nothing in the KVM code should rely on 32bit features
+ * anyway, only 64bit, so let the VMM do its worse.
+ */
+#define AA32_ID_WRITABLE(name) {		\
+	ID_DESC(name),				\
+	.visibility = aa32_id_visibility,	\
+	.val = GENMASK(31, 0),			\
+}
+
 /* sys_reg_desc initialiser for cpufeature ID registers that need filtering */
 #define ID_FILTERED(sysreg, name, mask) {	\
 	ID_DESC(sysreg),				\
@@ -3128,40 +3132,39 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	/* AArch64 mappings of the AArch32 ID registers */
 	/* CRm=1 */
-	AA32_ID_SANITISED(ID_PFR0_EL1),
-	AA32_ID_SANITISED(ID_PFR1_EL1),
+	AA32_ID_WRITABLE(ID_PFR0_EL1),
+	AA32_ID_WRITABLE(ID_PFR1_EL1),
 	{ SYS_DESC(SYS_ID_DFR0_EL1),
 	  .access = access_id_reg,
 	  .get_user = get_id_reg,
 	  .set_user = set_id_dfr0_el1,
 	  .visibility = aa32_id_visibility,
 	  .reset = read_sanitised_id_dfr0_el1,
-	  .val = ID_DFR0_EL1_PerfMon_MASK |
-		 ID_DFR0_EL1_CopDbg_MASK, },
+	  .val = GENMASK(31, 0) },
 	ID_HIDDEN(ID_AFR0_EL1),
-	AA32_ID_SANITISED(ID_MMFR0_EL1),
-	AA32_ID_SANITISED(ID_MMFR1_EL1),
-	AA32_ID_SANITISED(ID_MMFR2_EL1),
-	AA32_ID_SANITISED(ID_MMFR3_EL1),
+	AA32_ID_WRITABLE(ID_MMFR0_EL1),
+	AA32_ID_WRITABLE(ID_MMFR1_EL1),
+	AA32_ID_WRITABLE(ID_MMFR2_EL1),
+	AA32_ID_WRITABLE(ID_MMFR3_EL1),
 
 	/* CRm=2 */
-	AA32_ID_SANITISED(ID_ISAR0_EL1),
-	AA32_ID_SANITISED(ID_ISAR1_EL1),
-	AA32_ID_SANITISED(ID_ISAR2_EL1),
-	AA32_ID_SANITISED(ID_ISAR3_EL1),
-	AA32_ID_SANITISED(ID_ISAR4_EL1),
-	AA32_ID_SANITISED(ID_ISAR5_EL1),
-	AA32_ID_SANITISED(ID_MMFR4_EL1),
-	AA32_ID_SANITISED(ID_ISAR6_EL1),
+	AA32_ID_WRITABLE(ID_ISAR0_EL1),
+	AA32_ID_WRITABLE(ID_ISAR1_EL1),
+	AA32_ID_WRITABLE(ID_ISAR2_EL1),
+	AA32_ID_WRITABLE(ID_ISAR3_EL1),
+	AA32_ID_WRITABLE(ID_ISAR4_EL1),
+	AA32_ID_WRITABLE(ID_ISAR5_EL1),
+	AA32_ID_WRITABLE(ID_MMFR4_EL1),
+	AA32_ID_WRITABLE(ID_ISAR6_EL1),
 
 	/* CRm=3 */
-	AA32_ID_SANITISED(MVFR0_EL1),
-	AA32_ID_SANITISED(MVFR1_EL1),
-	AA32_ID_SANITISED(MVFR2_EL1),
+	AA32_ID_WRITABLE(MVFR0_EL1),
+	AA32_ID_WRITABLE(MVFR1_EL1),
+	AA32_ID_WRITABLE(MVFR2_EL1),
 	ID_UNALLOCATED(3,3),
-	AA32_ID_SANITISED(ID_PFR2_EL1),
+	AA32_ID_WRITABLE(ID_PFR2_EL1),
 	ID_HIDDEN(ID_DFR1_EL1),
-	AA32_ID_SANITISED(ID_MMFR5_EL1),
+	AA32_ID_WRITABLE(ID_MMFR5_EL1),
 	ID_UNALLOCATED(3,7),
 
 	/* AArch64 ID registers */


