Return-Path: <stable+bounces-260036-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lkBbCeYMIGpZvAAAu9opvQ
	(envelope-from <stable+bounces-260036-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 13:15:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D34636EE3
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 13:15:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=gK72p6Dr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260036-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-260036-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B0A33058A12
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 11:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8D445BD6F;
	Wed,  3 Jun 2026 11:06:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412DB43CEF2
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:06:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484814; cv=none; b=iZeDcV6ENpPdDsfH0dkFXJPn0Im7/PZ9m4tM9orMNmLdvR7Q4RakLEkYE5s1lBh37TwhShrkXH2704r9D/xRxDHsTWPJCdLisVYNpboINwm/lDY/OaG5FMS6oU8inTAEvTnx1t9fvHBio3wsbKVlPj7Q/aIxbkSZ+1tUXjfvw/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484814; c=relaxed/simple;
	bh=gQVxDLObpHw6ZNtfscQf7cTegZZAwSB0BoSq1y5HiHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TL2FOI0A6R9wdSAvUhLYUuduTfK5oBneCxNXU8w5F6OcdKefNw2PSTchkHVNqfVzum3rpRUKNZ/CYS0g5nIfgaisg48vh+njpYbK6mrs1KXLeV2Sm6MAqUCFf8joZ7l3mOhnkZSbDaT1rBh9aCO3ki1pOqMgzeUy4WFsgLbxQu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gK72p6Dr; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5D3A32E4;
	Wed,  3 Jun 2026 04:06:47 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0CB9D3F86F;
	Wed,  3 Jun 2026 04:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780484812; bh=gQVxDLObpHw6ZNtfscQf7cTegZZAwSB0BoSq1y5HiHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gK72p6Dra4ZytoEpuGIomZ4ZFkXUAHl9CFInGv2hZhf1EmiU7VhAVbc54IZe2akM4
	 KUNzqZD/xkYVLoUclCWCzfNxkZ7kTN+hLdB3xAdljmdWQxt0VrJNu4nzKyv1xJPla5
	 pVSCdZ7MblkxT+4hHKnz8L7Yb4oBv/cCEIP8caro=
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Cc: broonie@kernel.org,
	catalin.marinas@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	maz@kernel.org,
	oupton@kernel.org,
	stable@vger.kernel.org,
	tabba@google.com,
	vladimir.murzin@arm.com,
	will@kernel.org
Subject: [PATCH v4 05/20] KVM: arm64: pkvm: Save host FPMR in host cpu context
Date: Wed,  3 Jun 2026 12:06:15 +0100
Message-Id: <20260603110630.1027435-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260603110630.1027435-1-mark.rutland@arm.com>
References: <20260603110630.1027435-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-260036-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:broonie@kernel.org,m:catalin.marinas@arm.com,m:james.morse@arm.com,m:mark.rutland@arm.com,m:maz@kernel.org,m:oupton@kernel.org,m:stable@vger.kernel.org,m:tabba@google.com,m:vladimir.murzin@arm.com,m:will@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:mid,arm.com:dkim,arm.com:from_mime,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1D34636EE3

Protected KVM stores most of the host's system register state in
kvm_host_data::host_ctxt, which is an instance of struct
kvm_cpu_context. As kvm_cpu_context::sys_regs[] has a slot for FPMR, we
can store the host's FPMR there.

Do so, and remove kvm_host_data::fpmr.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h       | 3 ---
 arch/arm64/kvm/hyp/include/hyp/switch.h | 6 ++++--
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      | 5 +++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 65eead8362e0b..42b1c4764a4bf 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -775,9 +775,6 @@ struct kvm_host_data {
 	 */
 	struct cpu_sve_state *sve_state;
 
-	/* Used by pKVM only. */
-	u64	fpmr;
-
 	/* Ownership of the FP regs */
 	enum {
 		FP_STATE_FREE,
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 98b2976837b11..cc4d011a2b380 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -554,6 +554,8 @@ static inline void fpsimd_lazy_switch_to_host(struct kvm_vcpu *vcpu)
 
 static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu)
 {
+	struct kvm_cpu_context *hctxt = host_data_ptr(host_ctxt);
+
 	/*
 	 * Non-protected kvm relies on the host restoring its sve state.
 	 * Protected kvm restores the host's sve state as not to reveal that
@@ -562,11 +564,11 @@ static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu)
 	if (system_supports_sve()) {
 		__hyp_sve_save_host();
 	} else {
-		__fpsimd_save_state(host_data_ptr(host_ctxt.fp_regs));
+		__fpsimd_save_state(&hctxt->fp_regs);
 	}
 
 	if (kvm_has_fpmr(kern_hyp_va(vcpu->kvm)))
-		*host_data_ptr(fpmr) = read_sysreg_s(SYS_FPMR);
+		ctxt_sys_reg(hctxt, FPMR) = read_sysreg_s(SYS_FPMR);
 }
 
 
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 06db299c37a89..db60f770060e5 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -66,6 +66,7 @@ static void fpsimd_sve_flush(void)
 
 static void fpsimd_sve_sync(struct kvm_vcpu *vcpu)
 {
+	struct kvm_cpu_context *hctxt = host_data_ptr(host_ctxt);
 	bool has_fpmr;
 
 	if (!guest_owns_fp_regs())
@@ -89,10 +90,10 @@ static void fpsimd_sve_sync(struct kvm_vcpu *vcpu)
 	if (system_supports_sve())
 		__hyp_sve_restore_host();
 	else
-		__fpsimd_restore_state(host_data_ptr(host_ctxt.fp_regs));
+		__fpsimd_restore_state(&hctxt->fp_regs);
 
 	if (has_fpmr)
-		write_sysreg_s(*host_data_ptr(fpmr), SYS_FPMR);
+		write_sysreg_s(ctxt_sys_reg(hctxt, FPMR), SYS_FPMR);
 
 	*host_data_ptr(fp_owner) = FP_STATE_HOST_OWNED;
 }
-- 
2.30.2


