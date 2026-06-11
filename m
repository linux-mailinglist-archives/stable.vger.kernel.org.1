Return-Path: <stable+bounces-262710-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pCskA2u7KmqavwMAu9opvQ
	(envelope-from <stable+bounces-262710-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 15:43:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D28672683
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 15:43:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=Tpn+O45j;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262710-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262710-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0246C30069A0
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 13:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAA23F788A;
	Thu, 11 Jun 2026 13:43:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEC030C158
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 13:43:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185381; cv=none; b=S+Sn7JfvVz6HoRo/K+vogsj/ZjpZ812wX+fKWmhUBJ9n6tderk5LOOz3QSDc5KFdQrMmC5Z8Xxoub0qRuEtxv2SigBPY3IAihESG5LohUFy5SrZ5V7r2tFwGpSNEGPmha5UpMv/RLtwv0t2H9brLO6NxFJLYhyn0wvPrTjUbMBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185381; c=relaxed/simple;
	bh=nI3M3F/Z7OeJ+WHtBA98VjZFnklMFmOzHjK2xkQdRKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VBDOhKnJkFXTzup1BnX7pnbo1i+xwrJI9i5jJkvBGaLKM1X7usqjluCxLa5Bv3+hGmgbFwzQ9RIx/PSL1sf3oslBvwPbvBsvEtYQ8IlOfWtJllAg3/VsWm3G5XXcfpYmXM5WkfE+Ei89VkoCn6x0CwJAIUBlNl8LB27bfl/PbR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Tpn+O45j; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD7211E2F;
	Thu, 11 Jun 2026 06:42:54 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E09173FAF5;
	Thu, 11 Jun 2026 06:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781185379; bh=nI3M3F/Z7OeJ+WHtBA98VjZFnklMFmOzHjK2xkQdRKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tpn+O45j47Jrswoo/Zdh0WqGmwY0uEow44LbwEedK9znMHqZqcCVdVho+YJuxu/tw
	 rbMIpOCLsPCvCpKZsUG69z6IFCIuD1PI6BAWlMnFoRPR6wN/91XiTpvpYqaApMKT1k
	 Qie24WJ6M33C5U6y4Gbz6bFJ8u+nhRnQ93K/xqwg=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	lee@kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	oupton@kernel.org,
	ryan.roberts@arm.com,
	will@kernel.org,
	yuzenghui@huawei.com
Subject: [PATCH 6.6.y 1/3] KVM: arm64: Remove VPIPT I-cache handling
Date: Thu, 11 Jun 2026 14:42:46 +0100
Message-Id: <20260611134248.1700496-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260611134248.1700496-1-mark.rutland@arm.com>
References: <20260611134248.1700496-1-mark.rutland@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:anshuman.khandual@arm.com,m:catalin.marinas@arm.com,m:gregkh@linuxfoundation.org,m:lee@kernel.org,m:mark.rutland@arm.com,m:maz@kernel.org,m:oupton@kernel.org,m:ryan.roberts@arm.com,m:will@kernel.org,m:yuzenghui@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262710-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,huawei.com:email,arm.com:dkim,arm.com:email,arm.com:mid,arm.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00D28672683

From: Marc Zyngier <maz@kernel.org>

commit ced242ba9d7cb3571f6e0f165f643cb832d52148 upstream.

We have some special handling for VPIPT I-cache in critical parts
of the cache and TLB maintenance. Remove it.

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20231204143606.1806432-2-maz@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
[Mark: Backport to v6.6.y. VPIPT HW was never built; this is all dead code]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/kvm_mmu.h |  5 ++-
 arch/arm64/kvm/hyp/nvhe/pkvm.c   |  2 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c    | 61 --------------------------------
 arch/arm64/kvm/hyp/vhe/tlb.c     | 13 -------
 4 files changed, 3 insertions(+), 78 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 96a80e8f62263..888c5f9020107 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -229,9 +229,8 @@ static inline void __invalidate_icache_guest_page(void *va, size_t size)
 	if (icache_is_aliasing()) {
 		/* any kind of VIPT cache */
 		icache_inval_all_pou();
-	} else if (read_sysreg(CurrentEL) != CurrentEL_EL1 ||
-		   !icache_is_vpipt()) {
-		/* PIPT or VPIPT at EL2 (see comment in __kvm_tlb_flush_vmid_ipa) */
+	} else {
+		/* PIPT */
 		icache_inval_pou((unsigned long)va, (unsigned long)va + size);
 	}
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 03acc8343c5d1..fd3e0b2891c60 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -12,7 +12,7 @@
 #include <nvhe/pkvm.h>
 #include <nvhe/trap_handler.h>
 
-/* Used by icache_is_vpipt(). */
+/* Used by icache_is_aliasing(). */
 unsigned long __icache_flags;
 
 /* Used by kvm_get_vttbr(). */
diff --git a/arch/arm64/kvm/hyp/nvhe/tlb.c b/arch/arm64/kvm/hyp/nvhe/tlb.c
index 1b265713d6bed..a60fb13e21924 100644
--- a/arch/arm64/kvm/hyp/nvhe/tlb.c
+++ b/arch/arm64/kvm/hyp/nvhe/tlb.c
@@ -105,28 +105,6 @@ void __kvm_tlb_flush_vmid_ipa(struct kvm_s2_mmu *mmu,
 	dsb(ish);
 	isb();
 
-	/*
-	 * If the host is running at EL1 and we have a VPIPT I-cache,
-	 * then we must perform I-cache maintenance at EL2 in order for
-	 * it to have an effect on the guest. Since the guest cannot hit
-	 * I-cache lines allocated with a different VMID, we don't need
-	 * to worry about junk out of guest reset (we nuke the I-cache on
-	 * VMID rollover), but we do need to be careful when remapping
-	 * executable pages for the same guest. This can happen when KSM
-	 * takes a CoW fault on an executable page, copies the page into
-	 * a page that was previously mapped in the guest and then needs
-	 * to invalidate the guest view of the I-cache for that page
-	 * from EL1. To solve this, we invalidate the entire I-cache when
-	 * unmapping a page from a guest if we have a VPIPT I-cache but
-	 * the host is running at EL1. As above, we could do better if
-	 * we had the VA.
-	 *
-	 * The moral of this story is: if you have a VPIPT I-cache, then
-	 * you should be running with VHE enabled.
-	 */
-	if (icache_is_vpipt())
-		icache_inval_all_pou();
-
 	__tlb_switch_to_host(&cxt);
 }
 
@@ -157,28 +135,6 @@ void __kvm_tlb_flush_vmid_ipa_nsh(struct kvm_s2_mmu *mmu,
 	dsb(nsh);
 	isb();
 
-	/*
-	 * If the host is running at EL1 and we have a VPIPT I-cache,
-	 * then we must perform I-cache maintenance at EL2 in order for
-	 * it to have an effect on the guest. Since the guest cannot hit
-	 * I-cache lines allocated with a different VMID, we don't need
-	 * to worry about junk out of guest reset (we nuke the I-cache on
-	 * VMID rollover), but we do need to be careful when remapping
-	 * executable pages for the same guest. This can happen when KSM
-	 * takes a CoW fault on an executable page, copies the page into
-	 * a page that was previously mapped in the guest and then needs
-	 * to invalidate the guest view of the I-cache for that page
-	 * from EL1. To solve this, we invalidate the entire I-cache when
-	 * unmapping a page from a guest if we have a VPIPT I-cache but
-	 * the host is running at EL1. As above, we could do better if
-	 * we had the VA.
-	 *
-	 * The moral of this story is: if you have a VPIPT I-cache, then
-	 * you should be running with VHE enabled.
-	 */
-	if (icache_is_vpipt())
-		icache_inval_all_pou();
-
 	__tlb_switch_to_host(&cxt);
 }
 
@@ -205,10 +161,6 @@ void __kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
 	dsb(ish);
 	isb();
 
-	/* See the comment in __kvm_tlb_flush_vmid_ipa() */
-	if (icache_is_vpipt())
-		icache_inval_all_pou();
-
 	__tlb_switch_to_host(&cxt);
 }
 
@@ -246,18 +198,5 @@ void __kvm_flush_vm_context(void)
 	/* Same remark as in __tlb_switch_to_guest() */
 	dsb(ish);
 	__tlbi(alle1is);
-
-	/*
-	 * VIPT and PIPT caches are not affected by VMID, so no maintenance
-	 * is necessary across a VMID rollover.
-	 *
-	 * VPIPT caches constrain lookup and maintenance to the active VMID,
-	 * so we need to invalidate lines with a stale VMID to avoid an ABA
-	 * race after multiple rollovers.
-	 *
-	 */
-	if (icache_is_vpipt())
-		asm volatile("ic ialluis");
-
 	dsb(ish);
 }
diff --git a/arch/arm64/kvm/hyp/vhe/tlb.c b/arch/arm64/kvm/hyp/vhe/tlb.c
index 46bd43f61d76f..23325e9f3cc38 100644
--- a/arch/arm64/kvm/hyp/vhe/tlb.c
+++ b/arch/arm64/kvm/hyp/vhe/tlb.c
@@ -206,18 +206,5 @@ void __kvm_flush_vm_context(void)
 {
 	dsb(ishst);
 	__tlbi(alle1is);
-
-	/*
-	 * VIPT and PIPT caches are not affected by VMID, so no maintenance
-	 * is necessary across a VMID rollover.
-	 *
-	 * VPIPT caches constrain lookup and maintenance to the active VMID,
-	 * so we need to invalidate lines with a stale VMID to avoid an ABA
-	 * race after multiple rollovers.
-	 *
-	 */
-	if (icache_is_vpipt())
-		asm volatile("ic ialluis");
-
 	dsb(ish);
 }
-- 
2.30.2


