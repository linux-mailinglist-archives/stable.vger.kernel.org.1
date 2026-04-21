Return-Path: <stable+bounces-240112-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEw1AENL52lW6QEAu9opvQ
	(envelope-from <stable+bounces-240112-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:02:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C52439451
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFD53300A5B7
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910333A5E9E;
	Tue, 21 Apr 2026 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FGyXEpRM"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AE03A4F27
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765630; cv=none; b=mGrZbGxUtHhXPkANamccR9rw80ZLBwqRcM63AFpojUJiuxbZxHH4b4Iyh2EFx8/H/VxDaa4xvjwMSTxLdr4Ioz/ZikF7AW2zR1AEAu+5F1ymwFcL1bgeEbMgVCHreQodLZ6DAdXryUzwgZErRZobd+ymt7JFcUiT4U9TAfpHTWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765630; c=relaxed/simple;
	bh=EcTNGzHdHBi2cf4To1CwO4uoUFlIH4PpaV+wukCR4pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzgPFCwW4xkZnsZmj18o9VXpngMjtRCy1zbYenyNVaOPf5CemvOpmcH0jLErFcY+L3Yriu3ZZICyx5LLQW6wWVSHU4VAP4rclxeq7MRE8rVn8hx5E2l3tndbLq6lxAHEF2VNHcJCkJbUuEQuoGdh12fnYg82RS1idRJwvi0NELg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FGyXEpRM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DE423025;
	Tue, 21 Apr 2026 03:00:23 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.89.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F07D43FBCB;
	Tue, 21 Apr 2026 03:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776765628; bh=EcTNGzHdHBi2cf4To1CwO4uoUFlIH4PpaV+wukCR4pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGyXEpRMyPJQYr/DY+ArC7uqtZGUttfaeRO7DqOnhA1PgFGrZxuM6JWNQc0C3XCSK
	 owEbolGv1QbV8Mvva4z2OihzjcluLXkNb4TXI0iMV0Z5Fii69p4y7S3piqPzu5/+v+
	 v+XIGUOtxJEXmbP+UDQfs22jqBz9v09+Rt6b6QGQ=
From: Catalin Marinas <catalin.marinas@arm.com>
To: stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6.18.y 4/6] arm64: tlb: Pass the corresponding mm to __tlbi_sync_s1ish()
Date: Tue, 21 Apr 2026 11:00:15 +0100
Message-ID: <20260421100018.335793-5-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421100018.335793-1-catalin.marinas@arm.com>
References: <20260421100018.335793-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240112-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[arm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:dkim,arm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55C52439451
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit d9fb08ba946a6190c371dcd9f9e465d0d52c5021 upstream.

The mm structure will be used for workarounds that need limiting to
specific tasks.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Will Deacon <will@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 8 ++++----
 arch/arm64/kernel/sys_compat.c    | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 387bd86af702..ba36e91aefb8 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -185,7 +185,7 @@ do {										\
  * Complete broadcast TLB maintenance issued by the host which invalidates
  * stage 1 information in the host's own translation regime.
  */
-static inline void __tlbi_sync_s1ish(void)
+static inline void __tlbi_sync_s1ish(struct mm_struct *mm)
 {
 	dsb(ish);
 	__repeat_tlbi_sync(vale1is, 0);
@@ -310,7 +310,7 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 	asid = __TLBI_VADDR(0, ASID(mm));
 	__tlbi(aside1is, asid);
 	__tlbi_user(aside1is, asid);
-	__tlbi_sync_s1ish();
+	__tlbi_sync_s1ish(mm);
 	mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
 }
 
@@ -337,7 +337,7 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
 				  unsigned long uaddr)
 {
 	flush_tlb_page_nosync(vma, uaddr);
-	__tlbi_sync_s1ish();
+	__tlbi_sync_s1ish(vma->vm_mm);
 }
 
 static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
@@ -492,7 +492,7 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 {
 	__flush_tlb_range_nosync(vma->vm_mm, start, end, stride,
 				 last_level, tlb_level);
-	__tlbi_sync_s1ish();
+	__tlbi_sync_s1ish(vma->vm_mm);
 }
 
 static inline void flush_tlb_range(struct vm_area_struct *vma,
diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
index b9d4998c97ef..03fde2677d5b 100644
--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -37,7 +37,7 @@ __do_compat_cache_op(unsigned long start, unsigned long end)
 			 * We pick the reserved-ASID to minimise the impact.
 			 */
 			__tlbi(aside1is, __TLBI_VADDR(0, 0));
-			__tlbi_sync_s1ish();
+			__tlbi_sync_s1ish(current->mm);
 		}
 
 		ret = caches_clean_inval_user_pou(start, start + chunk);

