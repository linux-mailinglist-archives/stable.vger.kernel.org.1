Return-Path: <stable+bounces-261923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kk6bDV2wJWoGKgIAu9opvQ
	(envelope-from <stable+bounces-261923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 19:54:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E06651232
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 19:54:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZhFqd5BH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261923-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261923-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C7E83010BA1
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 17:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F012313527;
	Sun,  7 Jun 2026 17:54:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6572E7370;
	Sun,  7 Jun 2026 17:54:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780854871; cv=none; b=ZbQ6Qz52SJW+RtbmUcABHAdZjjEvCAD1It458WjNxbrLNsV1dWyydASJpGGOh9SYRSvkqO9SLHuubQlRuCsHNf0bBYHPfDvzn1Sw0IEJJ7aFw3TkqYh8PR1Z/NsFHc/pyfhDNJRnSCF7QTJfIEvPPBCnS2rbKev5seWbegkcVFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780854871; c=relaxed/simple;
	bh=mm4MjDD2y7Q9vjEOaHrtM+wJ1gl3ZTThUXK6Z/XNjjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SGtEWypSGsGu/GCyoqy4SjzB6GdwJsANYWQJfstOI9ejLfuKCamd+t3Zar91jexybYzrVMLrJme4NfPCj6/cr2PO5Yc31alfC4yflC9YCVh857LFijgoObeUzuIow9oEVsfnwN35c1vyKPIsx4Wl4ACCrahJXXZ3jZrYYcRUfjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhFqd5BH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E359D1F00893;
	Sun,  7 Jun 2026 17:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780854869;
	bh=liDRSDovqjC0vV1eIvbY6OQvKsCHLQ2zJENAx8zcP+E=;
	h=From:To:Cc:Subject:Date;
	b=ZhFqd5BHcwUXOAeElcxo7M70LA2umMvTU/cov7hrXSDkHSVhnKtdkxGWjWfh4apGT
	 6Sk92b254fjJtxFb5jFGqv+9JiO8Ntf4vkBVajWB38GTFdceM2A4z1387ecyhJSzpO
	 eKVIWHECpORpfo3Mj6+GD8sf4GHq+jykDnZcBB5RtFYOXgj7RIInnTOCLEUDjZVFGA
	 A6oPu0Hiv1PlVL4Wg/KfOve92tYHTmWuu1e3i385ozOIwpwVbPuQuI3+VPiMivpdYV
	 HGQFDo9EvAdO9nTG5bdcWtW72KNegB0yIhtVtz2WRolqNCXO9TB6nr/1XMcT2dxrb/
	 xOGNH3cSNXQgg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=lobster-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wWHhb-0000000AEMz-3IMj;
	Sun, 07 Jun 2026 17:54:27 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: arm64: Add kvm_for_each_vncr_tlb() helper
Date: Sun,  7 Jun 2026 18:57:45 +0100
Message-ID: <20260607175745.297793-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, seiden@linux.ibm.com, joey.gouly@arm.com, suzuki.poulose@arm.com, oupton@kernel.org, yuzenghui@huawei.com, imv4bel@gmail.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261923-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,arm.com,kernel.org,huawei.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[maz@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kvmarm@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:seiden@linux.ibm.com,m:joey.gouly@arm.com,m:suzuki.poulose@arm.com,m:oupton@kernel.org,m:yuzenghui@huawei.com,m:imv4bel@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maz@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83E06651232

VNCR TLB invalidation occurs from MMU notifiers or TLBI instructions,
and either can race against a vcpu not being onlined yet (no pseudo-TLB
allocated). Similarly, the TLB might be invalid, and the invalidation
should be skipped in this case.

Both kvm_invalidate_vncr_ipa() and kvm_invalidate_vncr_va() are
expected to perform the same checks, except that the latter doesn't
check for the allocation and blindly dereferences the pointer.

Solve this by introducing a new iterator built on top of the usual
kvm_for_each_vcpu() that checks for both of the above conditions,
and convert the two users to it.

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/aiUvSbrWndQeUPc8@v4bel
Fixes: 4ffa72ad8f37 ("KVM: arm64: nv: Add S1 TLB invalidation primitive for VNCR_EL2")
Cc: stable@vger.kernel.org
---
 arch/arm64/kvm/nested.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index f8d3f3a723282..690b8e8564166 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -908,9 +908,21 @@ static void invalidate_vncr(struct vncr_tlb *vt)
 		clear_fixmap(vncr_fixmap(vt->cpu));
 }
 
+/*
+ * VNCR TLB invalidation occurs from MMU notifiers or TLBI instructions, and
+ * either can race against a vcpu not being onlined yet (no pseudo-TLB
+ * allocated). Similarly, the TLB might be invalid.  Skip those, as they
+ * obviously don't participate in the invalidation at this stage.
+ */
+#define kvm_for_each_vncr_tlb(idx, vcpup, tlbp, kvm)	\
+	kvm_for_each_vcpu(idx, vcpup, kvm)		\
+		if (((tlbp) = vcpup->arch.vncr_tlb) &&	\
+		    (tlbp)->valid)
+
 static void kvm_invalidate_vncr_ipa(struct kvm *kvm, u64 start, u64 end)
 {
 	struct kvm_vcpu *vcpu;
+	struct vncr_tlb *vt;
 	unsigned long i;
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
@@ -918,24 +930,9 @@ static void kvm_invalidate_vncr_ipa(struct kvm *kvm, u64 start, u64 end)
 	if (!kvm_has_feat(kvm, ID_AA64MMFR4_EL1, NV_frac, NV2_ONLY))
 		return;
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		struct vncr_tlb *vt = vcpu->arch.vncr_tlb;
+	kvm_for_each_vncr_tlb(i, vcpu, vt, kvm) {
 		u64 ipa_start, ipa_end, ipa_size;
 
-		/*
-		 * Careful here: We end-up here from an MMU notifier,
-		 * and this can race against a vcpu not being onlined
-		 * yet, without the pseudo-TLB being allocated.
-		 *
-		 * Skip those, as they obviously don't participate in
-		 * the invalidation at this stage.
-		 */
-		if (!vt)
-			continue;
-
-		if (!vt->valid)
-			continue;
-
 		ipa_size = ttl_to_size(pgshift_level_to_ttl(vt->wi.pgshift,
 							    vt->wr.level));
 		ipa_start = vt->wr.pa & ~(ipa_size - 1);
@@ -965,17 +962,14 @@ static void invalidate_vncr_va(struct kvm *kvm,
 			       struct s1e2_tlbi_scope *scope)
 {
 	struct kvm_vcpu *vcpu;
+	struct vncr_tlb *vt;
 	unsigned long i;
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		struct vncr_tlb *vt = vcpu->arch.vncr_tlb;
+	kvm_for_each_vncr_tlb(i, vcpu, vt, kvm) {
 		u64 va_start, va_end, va_size;
 
-		if (!vt->valid)
-			continue;
-
 		va_size = ttl_to_size(pgshift_level_to_ttl(vt->wi.pgshift,
 							   vt->wr.level));
 		va_start = vt->gva & ~(va_size - 1);
-- 
2.47.3


