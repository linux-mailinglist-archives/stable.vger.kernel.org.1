Return-Path: <stable+bounces-101128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A139EEAE5
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E24F16A59F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FD921764F;
	Thu, 12 Dec 2024 15:14:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FE421660B
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016457; cv=none; b=uwqAvlG6G2igQLDP5ptecAtjva45+ZAsc9uUyWElt1vn3nsqPAPY3xVk/G1SV/llOQpNa2Stu+3L7bTiEoNnZmnLHF/eJm+cg6iNg/bSW9W/KFRfOfgFu7r82BymWIMxeWUi1bAVjrEg/3SnDFhlxvMCpggfAShXkOI/m0LYdDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016457; c=relaxed/simple;
	bh=aXuxiHH97Dt1pne7PboneSqViqy4zgKlX18/6Q533UY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FrahQ+XzCgUxmk99SSWw1yU2GadYgd1m3lse7q5H86sd89tvOadNt3L6H7oOY67H3I6VcyOPI7fSRLId4m+RwEe8VQ1QKVs24zqQoTK5/broxMMeaEseraK8ECdTBZPKEo+JUaSQ6J/eYh6Dct1Z81wtKJIPnFYW3YdSilsnyMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D68F6169E;
	Thu, 12 Dec 2024 07:14:41 -0800 (PST)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EB9E3F720;
	Thu, 12 Dec 2024 07:14:11 -0800 (PST)
From: Joey Gouly <joey.gouly@arm.com>
To: stable@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	gshan@redhat.com,
	james.morse@arm.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	shameerali.kolothum.thodi@huawei.com,
	vt@altlinux.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Jing Zhang <jingzhangos@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.6 v1] KVM: arm64: Disable MPAM visibility by default and ignore VMM writes
Date: Thu, 12 Dec 2024 15:14:06 +0000
Message-Id: <20241212151406.1436382-1-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

commit 6685f5d572c22e1003e7c0d089afe1c64340ab1f upstream.

commit 011e5f5bf529f ("arm64/cpufeature: Add remaining feature bits in
ID_AA64PFR0 register") exposed the MPAM field of AA64PFR0_EL1 to guests,
but didn't add trap handling. A previous patch supplied the missing trap
handling.

Existing VMs that have the MPAM field of ID_AA64PFR0_EL1 set need to
be migratable, but there is little point enabling the MPAM CPU
interface on new VMs until there is something a guest can do with it.

Clear the MPAM field from the guest's ID_AA64PFR0_EL1 and on hardware
that supports MPAM, politely ignore the VMMs attempts to set this bit.

Guests exposed to this bug have the sanitised value of the MPAM field,
so only the correct value needs to be ignored. This means the field
can continue to be used to block migration to incompatible hardware
(between MPAM=1 and MPAM=5), and the VMM can't rely on the field
being ignored.

Signed-off-by: James Morse <james.morse@arm.com>
Co-developed-by: Joey Gouly <joey.gouly@arm.com>
Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20241030160317.2528209-7-joey.gouly@arm.com
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
[ joey: fixed up merge conflict, no ID_FILTERED macro in 6.6 ]
Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: stable@vger.kernel.org # 6.6.x
Cc: Vitaly Chikunov <vt@altlinux.org>
Link: https://lore.kernel.org/linux-arm-kernel/20241202045830.e4yy3nkvxtzaybxk@altlinux.org/
---

This fixes an issue seen when using KVM with a 6.6 host kernel, and
newer (6.13+) kernels in the guest.

Tested with a stripped down version of set_id_regs from the original
patch series.

 arch/arm64/kvm/sys_regs.c | 52 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 370a1a7bd369..2031703424ea 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1330,6 +1330,7 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE);
 
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_SME);
+		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MPAM_frac);
 		break;
 	case SYS_ID_AA64ISAR1_EL1:
 		if (!vcpu_has_ptrauth(vcpu))
@@ -1472,6 +1473,13 @@ static u64 read_sanitised_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
 
 	val &= ~ID_AA64PFR0_EL1_AMU_MASK;
 
+	/*
+	 * MPAM is disabled by default as KVM also needs a set of PARTID to
+	 * program the MPAMVPMx_EL2 PARTID remapping registers with. But some
+	 * older kernels let the guest see the ID bit.
+	 */
+	val &= ~ID_AA64PFR0_EL1_MPAM_MASK;
+
 	return val;
 }
 
@@ -1560,6 +1568,42 @@ static int set_id_dfr0_el1(struct kvm_vcpu *vcpu,
 	return set_id_reg(vcpu, rd, val);
 }
 
+static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
+			       const struct sys_reg_desc *rd, u64 user_val)
+{
+	u64 hw_val = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
+	u64 mpam_mask = ID_AA64PFR0_EL1_MPAM_MASK;
+
+	/*
+	 * Commit 011e5f5bf529f ("arm64/cpufeature: Add remaining feature bits
+	 * in ID_AA64PFR0 register") exposed the MPAM field of AA64PFR0_EL1 to
+	 * guests, but didn't add trap handling. KVM doesn't support MPAM and
+	 * always returns an UNDEF for these registers. The guest must see 0
+	 * for this field.
+	 *
+	 * But KVM must also accept values from user-space that were provided
+	 * by KVM. On CPUs that support MPAM, permit user-space to write
+	 * the sanitizied value to ID_AA64PFR0_EL1.MPAM, but ignore this field.
+	 */
+	if ((hw_val & mpam_mask) == (user_val & mpam_mask))
+		user_val &= ~ID_AA64PFR0_EL1_MPAM_MASK;
+
+	return set_id_reg(vcpu, rd, user_val);
+}
+
+static int set_id_aa64pfr1_el1(struct kvm_vcpu *vcpu,
+			       const struct sys_reg_desc *rd, u64 user_val)
+{
+	u64 hw_val = read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1);
+	u64 mpam_mask = ID_AA64PFR1_EL1_MPAM_frac_MASK;
+
+	/* See set_id_aa64pfr0_el1 for comment about MPAM */
+	if ((hw_val & mpam_mask) == (user_val & mpam_mask))
+		user_val &= ~ID_AA64PFR1_EL1_MPAM_frac_MASK;
+
+	return set_id_reg(vcpu, rd, user_val);
+}
+
 /*
  * cpufeature ID register user accessors
  *
@@ -2018,10 +2062,14 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_ID_AA64PFR0_EL1),
 	  .access = access_id_reg,
 	  .get_user = get_id_reg,
-	  .set_user = set_id_reg,
+	  .set_user = set_id_aa64pfr0_el1,
 	  .reset = read_sanitised_id_aa64pfr0_el1,
 	  .val = ID_AA64PFR0_EL1_CSV2_MASK | ID_AA64PFR0_EL1_CSV3_MASK, },
-	ID_SANITISED(ID_AA64PFR1_EL1),
+	{ SYS_DESC(SYS_ID_AA64PFR1_EL1),
+	  .access = access_id_reg,
+	  .get_user = get_id_reg,
+	  .set_user = set_id_aa64pfr1_el1,
+	  .reset = kvm_read_sanitised_id_reg, },
 	ID_UNALLOCATED(4,2),
 	ID_UNALLOCATED(4,3),
 	ID_SANITISED(ID_AA64ZFR0_EL1),
-- 
2.25.1


