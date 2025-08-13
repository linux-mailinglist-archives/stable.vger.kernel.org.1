Return-Path: <stable+bounces-169481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868A6B2588E
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 02:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833785885DC
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 00:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47E58634A;
	Thu, 14 Aug 2025 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iITrVck4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D442FF66A
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755132518; cv=none; b=UWZJYO9I/ZukYiFe5vsmd7wU+Tx8fqf7cmvoK2/u0MKlLsMCI5UySpv/y5Raq2zNICSJabEN/6Ei67CezvEXyUDfClI3s62toZY5Qc4DAc7ez/Dl7MNnQc1AKHoKG9qLgw0mtmFroKRbHyR8cjtApffbw5JC9YnkL5ZtCwymZTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755132518; c=relaxed/simple;
	bh=Z6nWmLOEQtV+K0zSq4zwbaOpll6GZLokaVhTnK4vEHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jvbsfcmmfb2am45A7Uw696ds1bAFnK0+p9kZq0ca/RikPb94ik04qAx/SA0eqLplg8pMnYC1zmVYM6Jcij7887M9Q4FZlw8pORdA2hrA/n4i4IrjStlNbEBTBe3gzYbK2txenk85+Ki26rGSmMqLF/hZlaH7Bo3IhM0Y0vfCXSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iITrVck4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852EAC4CEF8;
	Thu, 14 Aug 2025 00:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755132518;
	bh=Z6nWmLOEQtV+K0zSq4zwbaOpll6GZLokaVhTnK4vEHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iITrVck4+Nk787189hyjcOtF+6jNeR0kVWqvceCOR8qJXi4xS6KoFphvKHZDlajc2
	 ZT+AyXvgwbnkc4akHXstdqRC938BpS8xsmTIHIHZJslZRq2vCcJV0E/viHknIjjgHG
	 urhQJW2UoFRpOe28dZK3BBWvYkg4nAm/hoUJtWqO4EIKWs00YpNC2s86XhbntWK7sq
	 N+C/Pd0A/iwJczc6+95TAVrsJ6z9tPDLrZvsj9SveNYBBI4MaI/5ryH+uhPACiuaOw
	 Zik9//XexiF2m2amDn0JVkXCvrs7Ysz8PGmfdLUi/h6aLXoKsg5kK2vlvoxE3yokeW
	 V79BX/lf83DTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 5/5] KVM: arm64: Check for SYSREGS_ON_CPU before accessing the CPU state
Date: Wed, 13 Aug 2025 17:18:20 -0400
Message-Id: <20250813211820.2074887-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813211820.2074887-1-sashal@kernel.org>
References: <2025081248-omission-talisman-0619@gregkh>
 <20250813211820.2074887-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit c6e35dff58d348c1a9489e9b3b62b3721e62631d ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 4 ++++
 arch/arm64/kvm/hyp/exception.c    | 6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 12628bce1acd..cc4c7c15015d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1081,6 +1081,8 @@ static inline bool __vcpu_read_sys_reg_from_cpu(int reg, u64 *val)
 	 * System registers listed in the switch are not saved on every
 	 * exit from the guest but are only saved on vcpu_put.
 	 *
+	 * SYSREGS_ON_CPU *MUST* be checked before using this helper.
+	 *
 	 * Note that MPIDR_EL1 for the guest is set by KVM via VMPIDR_EL2 but
 	 * should never be listed below, because the guest cannot modify its
 	 * own MPIDR_EL1 and MPIDR_EL1 is accessed for VCPU A from VCPU B's
@@ -1132,6 +1134,8 @@ static inline bool __vcpu_write_sys_reg_to_cpu(u64 val, int reg)
 	 * System registers listed in the switch are not restored on every
 	 * entry to the guest but are only restored on vcpu_load.
 	 *
+	 * SYSREGS_ON_CPU *MUST* be checked before using this helper.
+	 *
 	 * Note that MPIDR_EL1 for the guest is set by KVM via VMPIDR_EL2 but
 	 * should never be listed below, because the MPIDR should only be set
 	 * once, before running the VCPU, and never changed later.
diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
index 6a2a899a344e..9f5d837cc03f 100644
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
 
-- 
2.39.5


