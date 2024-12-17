Return-Path: <stable+bounces-105002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAEC9F5482
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399C91888B77
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ECD1F9A8C;
	Tue, 17 Dec 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KRrvX2su"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146D61F943F;
	Tue, 17 Dec 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456787; cv=none; b=LlrTGWOpxeeMUoaoWW+3U8AjX9toH58E6Ful3PKip2J8vb8jFI9xIRb+EIUTvTKhtUziKC9x5ovRNTPq8PHuV6mRrWX3C8GMZ2juAw62RxcDKq24e/w/v/i+xbiQGW6CNIk4mde7rVazLIngyt91TjWPebcQneW/u9NPFIG8YHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456787; c=relaxed/simple;
	bh=OnNupL93NxJd4F1z0oFx7T9LBi96pOZtRiAz4EV9Bfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5uz+qLsGw4G5SJbBPWM/+R3CsEnFDvdbeh1PeDhVP2tOCXua3ydvkBFQk2WvX+OzhEsu76RkwaYU4ErW3v+pvsbXJzr3YQWQ2nilDDCnAsvDDR3ZfsLC8apE6hQMpcHOFZRI7F11lWm6hncKMyExtPg7NNjwScGKllX2bRyefY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KRrvX2su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7560CC4CED3;
	Tue, 17 Dec 2024 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734456786;
	bh=OnNupL93NxJd4F1z0oFx7T9LBi96pOZtRiAz4EV9Bfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KRrvX2suLkDAdGosXQB9i28tlrcefM/jDPEPo8FcsmM+uZxXaP5k+0/aqYhTZy6jE
	 iA3kQoY541oUorwzTOuQeJtkOZLrXPLkk2j7Vbc9w6dZ467QWw19IBddGVHhPwX53h
	 DnGg2l23jn8f+5MEb+6Oh3POwzMwDxklun/G6luY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	James Morse <james.morse@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Gavin Shan <gshan@redhat.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 6.12 164/172] KVM: arm64: Disable MPAM visibility by default and ignore VMM writes
Date: Tue, 17 Dec 2024 18:08:40 +0100
Message-ID: <20241217170553.134121713@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>
References: <20241217170546.209657098@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
[maz: adapted to lack of ID_FILTERED()]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/sys_regs.c |   55 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1535,6 +1535,7 @@ static u64 __kvm_read_sanitised_id_reg(c
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTEX);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_DF2);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_PFAR);
+		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MPAM_frac);
 		break;
 	case SYS_ID_AA64PFR2_EL1:
 		/* We only expose FPMR */
@@ -1724,6 +1725,13 @@ static u64 read_sanitised_id_aa64pfr0_el
 
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
 
@@ -1834,6 +1842,42 @@ static int set_id_dfr0_el1(struct kvm_vc
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
@@ -2377,7 +2421,7 @@ static const struct sys_reg_desc sys_reg
 	{ SYS_DESC(SYS_ID_AA64PFR0_EL1),
 	  .access = access_id_reg,
 	  .get_user = get_id_reg,
-	  .set_user = set_id_reg,
+	  .set_user = set_id_aa64pfr0_el1,
 	  .reset = read_sanitised_id_aa64pfr0_el1,
 	  .val = ~(ID_AA64PFR0_EL1_AMU |
 		   ID_AA64PFR0_EL1_MPAM |
@@ -2385,7 +2429,12 @@ static const struct sys_reg_desc sys_reg
 		   ID_AA64PFR0_EL1_RAS |
 		   ID_AA64PFR0_EL1_AdvSIMD |
 		   ID_AA64PFR0_EL1_FP), },
-	ID_WRITABLE(ID_AA64PFR1_EL1, ~(ID_AA64PFR1_EL1_PFAR |
+	{ SYS_DESC(SYS_ID_AA64PFR1_EL1),
+	  .access	= access_id_reg,
+	  .get_user	= get_id_reg,
+	  .set_user	= set_id_aa64pfr1_el1,
+	  .reset	= kvm_read_sanitised_id_reg,
+	  .val		=	     ~(ID_AA64PFR1_EL1_PFAR |
 				       ID_AA64PFR1_EL1_DF2 |
 				       ID_AA64PFR1_EL1_MTEX |
 				       ID_AA64PFR1_EL1_THE |
@@ -2397,7 +2446,7 @@ static const struct sys_reg_desc sys_reg
 				       ID_AA64PFR1_EL1_RES0 |
 				       ID_AA64PFR1_EL1_MPAM_frac |
 				       ID_AA64PFR1_EL1_RAS_frac |
-				       ID_AA64PFR1_EL1_MTE)),
+				       ID_AA64PFR1_EL1_MTE), },
 	ID_WRITABLE(ID_AA64PFR2_EL1, ID_AA64PFR2_EL1_FPMR),
 	ID_UNALLOCATED(4,3),
 	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),



