Return-Path: <stable+bounces-167186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C15B6B22CE7
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C577A1BC3
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364DA2C327A;
	Tue, 12 Aug 2025 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pot+hnlD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E816A274FC6
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015297; cv=none; b=gIzilGKLDjoPRvThyOxIclsj/IVWYonnsrisFHHC3T3hGOgy59elLife6KkXpbBGCXXyBi5dxC8UcA7O5mjNd3BZeD2IOwKriyIodHD9arKIs5n3adJLHs2FA13UrVAhlSsDtRKrk+XPm6sXC8g3a8q86aWoisSzkC/NM52wR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015297; c=relaxed/simple;
	bh=aJDbXf1WiDS/pXiOBfUFu5fiCqDVtFAPPDZoZeGQL7I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oOrA8dS7LV3j/3SbcJDWNwr+VE43Zeuu5YPZZMY4f5JNS36R3iGKfSOqqGCyazP9K7448ujhxbjue5w0eTe9r5Ops2YVvdAp4hJ8nVBlQMLf+1LcXOTbntfYQ9it1eFPrZoj36n2v7Ekl7AjD9QUwmen8Xz7kP1dk+/TTubk55A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pot+hnlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2300C4CEF0;
	Tue, 12 Aug 2025 16:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755015296;
	bh=aJDbXf1WiDS/pXiOBfUFu5fiCqDVtFAPPDZoZeGQL7I=;
	h=Subject:To:Cc:From:Date:From;
	b=Pot+hnlDIUwkaZnaT67EHwWGP5o7cjYWnAAe4jrOax8TLyLcjV9jYpAGy9n+oZjsv
	 UyvAUS+/hRU8vG1g+d3aF3tVwp8FpMNRluCQ0XNMEMibmYXUqCYkEgHUfPKBRZZ+ur
	 TQqagjIYnlUA5EwARLflxsep/ZAinkNiTZ8opbZE=
Subject: FAILED: patch "[PATCH] KVM: arm64: Check for SYSREGS_ON_CPU before accessing the CPU" failed to apply to 6.15-stable tree
To: maz@kernel.org,broonie@kernel.org,oliver.upton@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 18:14:48 +0200
Message-ID: <2025081248-omission-talisman-0619@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x c6e35dff58d348c1a9489e9b3b62b3721e62631d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081248-omission-talisman-0619@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c6e35dff58d348c1a9489e9b3b62b3721e62631d Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Sun, 20 Jul 2025 11:22:29 +0100
Subject: [PATCH] KVM: arm64: Check for SYSREGS_ON_CPU before accessing the CPU
 state

Mark Brown reports that since we commit to making exceptions
visible without the vcpu being loaded, the external abort selftest
fails.

Upon investigation, it turns out that the code that makes registers
affected by an exception visible to the guest is completely broken
on VHE, as we don't check whether the system registers are loaded
on the CPU at this point. We managed to get away with this so far,
but that's obviously as bad as it gets,

Add the required checksm and document the absolute need to check
for the SYSREGS_ON_CPU flag before calling into any of the
__vcpu_write_sys_reg_to_cpu()__vcpu_read_sys_reg_from_cpu() helpers.

Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/18535df8-e647-4643-af9a-bb780af03a70@sirena.org.uk
Link: https://lore.kernel.org/r/20250720102229.179114-1-maz@kernel.org
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e54d29feb469..d373d555a69b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1169,6 +1169,8 @@ static inline bool __vcpu_read_sys_reg_from_cpu(int reg, u64 *val)
 	 * System registers listed in the switch are not saved on every
 	 * exit from the guest but are only saved on vcpu_put.
 	 *
+	 * SYSREGS_ON_CPU *MUST* be checked before using this helper.
+	 *
 	 * Note that MPIDR_EL1 for the guest is set by KVM via VMPIDR_EL2 but
 	 * should never be listed below, because the guest cannot modify its
 	 * own MPIDR_EL1 and MPIDR_EL1 is accessed for VCPU A from VCPU B's
@@ -1221,6 +1223,8 @@ static inline bool __vcpu_write_sys_reg_to_cpu(u64 val, int reg)
 	 * System registers listed in the switch are not restored on every
 	 * entry to the guest but are only restored on vcpu_load.
 	 *
+	 * SYSREGS_ON_CPU *MUST* be checked before using this helper.
+	 *
 	 * Note that MPIDR_EL1 for the guest is set by KVM via VMPIDR_EL2 but
 	 * should never be listed below, because the MPIDR should only be set
 	 * once, before running the VCPU, and never changed later.
diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
index 7dafd10e52e8..95d186e0bf54 100644
--- a/arch/arm64/kvm/hyp/exception.c
+++ b/arch/arm64/kvm/hyp/exception.c
@@ -26,7 +26,8 @@ static inline u64 __vcpu_read_sys_reg(const struct kvm_vcpu *vcpu, int reg)
 
 	if (unlikely(vcpu_has_nv(vcpu)))
 		return vcpu_read_sys_reg(vcpu, reg);
-	else if (__vcpu_read_sys_reg_from_cpu(reg, &val))
+	else if (vcpu_get_flag(vcpu, SYSREGS_ON_CPU) &&
+		 __vcpu_read_sys_reg_from_cpu(reg, &val))
 		return val;
 
 	return __vcpu_sys_reg(vcpu, reg);
@@ -36,7 +37,8 @@ static inline void __vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
 {
 	if (unlikely(vcpu_has_nv(vcpu)))
 		vcpu_write_sys_reg(vcpu, val, reg);
-	else if (!__vcpu_write_sys_reg_to_cpu(val, reg))
+	else if (!vcpu_get_flag(vcpu, SYSREGS_ON_CPU) ||
+		 !__vcpu_write_sys_reg_to_cpu(val, reg))
 		__vcpu_assign_sys_reg(vcpu, reg, val);
 }
 


