Return-Path: <stable+bounces-262367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id isdXDAhhKGrlCwMAu9opvQ
	(envelope-from <stable+bounces-262367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 20:52:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7521E6636E7
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 20:52:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=glJzGbgq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262367-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262367-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3CEC3029ACD
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 18:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142BB4C77CE;
	Tue,  9 Jun 2026 18:52:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D668436680F;
	Tue,  9 Jun 2026 18:52:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031127; cv=none; b=IyY8t0iyxqdR3KQAFbStTpMjrXwqwuy4fmhmkZc86F/S75VGGnF68R68dnXden10uOS4Hlhr2QrLVDM+2qK3q0tv1/xPTY+Wdnij00PrxKqvRKtwqBFHhjnDQ9fBV8yeB+PCVIV/WuapDqZKHctRDBbIFjA62J5zkM4CGQhCwEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031127; c=relaxed/simple;
	bh=/4VD6gymm7tNUsfQN03hq2UYGx2mPBKT8a3q/XSkB7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhYRlMvz9xv2xj+yShlkW5KegC8Ie69Zp5wDmNqGJsOZqChzW7r45JNEyV9+FDf127XmrIwC7evUputUKmr3NMtICe+3DsFE3SIrPecRNeG28zQWwQGsiQ07QVAPVC0+4xblSOSBKHp6HauaqrOZgbzDwfXeQsNBP/mQAh51BTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glJzGbgq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22881F0089D;
	Tue,  9 Jun 2026 18:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781031126;
	bh=F4EUtdDFE/vWqgAiim3ZPYaYTdzc/s+LN3L2eOa/2ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=glJzGbgqYhGixwP/rc7LxRmRENbpUlLSvvmmXgzNM7hugKa4HlMCH8dKOxstZpf6m
	 hPql1BYJF+2UzZeEiJaSppQ7oyU8oThNJ0s199CkcDjdWT1ghmALUq6oH0BQWu0Bk1
	 7lWxfzEUNdj8jGZwkbgclgA4Eoch/cL6Kpv43fcIje5YxdIzA1QPTyA2b/h0+EfU7C
	 XLblfuJM7AV2X5Ozl8xNz0LbWSzZ0FqZYSx7iBKmxWz+2AyVn7gL0i2e9a7bCkfWMU
	 75XMHe60eMDGSNTMyq/esXnIsnW812w+Yg0xUd2CxrtX/qHEPdrDoAo8N8zIoFmx/C
	 AKO+RyQLoiM4w==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] KVM: arm64: nv: Inject SEA if kvm_translate_vncr() can't resolve PFN
Date: Tue,  9 Jun 2026 11:51:58 -0700
Message-ID: <20260609185204.745929-3-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609185204.745929-1-oupton@kernel.org>
References: <20260609185204.745929-1-oupton@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kvmarm@lists.linux.dev,m:maz@kernel.org,m:joey.gouly@arm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:weilin.chang@arm.com,m:oupton@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262367-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[oupton@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oupton@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7521E6636E7

kvm_handle_vncr_abort() assumes that s1_walk_result conveys an abort
when kvm_translate_vncr() returns -EFAULT. This is not always the case
as it's possible to encounter 'late' failures on the output of S1
translation, e.g. a GFN outside of the memslots.

Fix it by preparing an external abort before returning from
kvm_translate_vncr().

Cc: stable@vger.kernel.org
Fixes: b55d3bd1e0b7 ("KVM: arm64: nv: Inject SEA if kvm_translate_vncr() can't resolve PFN")
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 arch/arm64/include/asm/kvm_nested.h | 8 ++++++++
 arch/arm64/kvm/at.c                 | 8 --------
 arch/arm64/kvm/nested.c             | 8 ++++++--
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index dc2957662ff2..cbdaaa2a2903 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -388,6 +388,14 @@ struct s1_walk_result {
 	bool	failed;
 };
 
+static inline void fail_s1_walk(struct s1_walk_result *wr, u8 fst, bool s1ptw)
+{
+	wr->fst		= fst;
+	wr->ptw		= s1ptw;
+	wr->s2		= s1ptw;
+	wr->failed	= true;
+}
+
 int __kvm_translate_va(struct kvm_vcpu *vcpu, struct s1_walk_info *wi,
 		       struct s1_walk_result *wr, u64 va);
 int __kvm_find_s1_desc_level(struct kvm_vcpu *vcpu, u64 va, u64 ipa,
diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
index 30e6fa8ac07c..8263c648207b 100644
--- a/arch/arm64/kvm/at.c
+++ b/arch/arm64/kvm/at.c
@@ -11,14 +11,6 @@
 #include <asm/kvm_mmu.h>
 #include <asm/lsui.h>
 
-static void fail_s1_walk(struct s1_walk_result *wr, u8 fst, bool s1ptw)
-{
-	wr->fst		= fst;
-	wr->ptw		= s1ptw;
-	wr->s2		= s1ptw;
-	wr->failed	= true;
-}
-
 #define S1_MMU_DISABLED		(-127)
 
 static int get_ia_size(struct s1_walk_info *wi)
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index cdbdf47fa6a2..940247b3530b 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1389,15 +1389,19 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 
 	gfn = vt->wr.pa >> PAGE_SHIFT;
 	memslot = gfn_to_memslot(vcpu->kvm, gfn);
-	if (!memslot)
+	if (!memslot) {
+		fail_s1_walk(&vt->wr, ESR_ELx_FSC_EXTABT, false);
 		return -EFAULT;
+	}
 
 	*is_gmem = kvm_slot_has_gmem(memslot);
 	if (!*is_gmem) {
 		pfn = __kvm_faultin_pfn(memslot, gfn, write_fault ? FOLL_WRITE : 0,
 					&writable, &page);
-		if (is_error_noslot_pfn(pfn))
+		if (is_error_noslot_pfn(pfn)) {
+			fail_s1_walk(&vt->wr, ESR_ELx_FSC_EXTABT, false);
 			return -EFAULT;
+		}
 	} else {
 		ret = kvm_gmem_get_pfn(vcpu->kvm, memslot, gfn, &pfn, &page, NULL);
 		if (ret) {
-- 
2.47.3


