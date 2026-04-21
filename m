Return-Path: <stable+bounces-240111-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I+0ETpL52lW6QEAu9opvQ
	(envelope-from <stable+bounces-240111-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:02:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD93B439449
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F566300955E
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BE53A63E3;
	Tue, 21 Apr 2026 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hozG5qLU"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12403B19C2
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765629; cv=none; b=uUXbTuoRp4tVDDGu2SyX6ASmTm3ywBKVZhSNPN39BrSppZTvAjL2kMaWgDGwKoFlSc1//KZtyk8CH9/Dy4nx9ZQdQ3daNtAPNK94gIsQxao7AYVX8pn1c2a5ZEVRdzR9Ir4K6/LrcyTiNC7DvMGHdREayJ46524yLGEQkmKg6QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765629; c=relaxed/simple;
	bh=p90basbuAqk6MT2r9VyRSm6WE7j2SMi5ZXXTNvRCow0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doS3hb96d+ehDplhsGMblE20ZdWnJSw7TVjDTJbMZZl+zWQbX91198XHNb1YG/m3E41839Ms4FJhBEBXd+/jHlsZwZZxeFCllnm1wBrxjLoR16/n6CvspfC8l6NyTSF3LqbeQOC219XYSGILj0Q1KYx6Dj03SsZ77fsLuzzcbzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hozG5qLU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A6C73024;
	Tue, 21 Apr 2026 03:00:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.89.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC4943FBCB;
	Tue, 21 Apr 2026 03:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776765627; bh=p90basbuAqk6MT2r9VyRSm6WE7j2SMi5ZXXTNvRCow0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hozG5qLUVKRm5oTJBycHggig7nC9xnWoUwXXIM87WkbO2lrTxUS5f4ULP9qtVfhQp
	 bdG69rgqROkIfM/u0kS6jg5lJ5AVwtWhK4K4Tl6uqDW1KwOJ8UpkPsQzjXOAJl+Jmh
	 7Qdm5QDGZ3Be6d4fNn22A0Be4ovnTJj2cyqM0g0A=
From: Catalin Marinas <catalin.marinas@arm.com>
To: stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6.18.y 3/6] arm64: tlb: Introduce __tlbi_sync_s1ish_{kernel,batch}() for TLB maintenance
Date: Tue, 21 Apr 2026 11:00:14 +0100
Message-ID: <20260421100018.335793-4-catalin.marinas@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240111-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email,arm.com:dkim,arm.com:mid]
X-Rspamd-Queue-Id: DD93B439449
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 6bfbf574a39139da11af9fdf6e8d56fe1989cd3e upstream.

Add __tlbi_sync_s1ish_kernel() similar to __tlbi_sync_s1ish() and use it
for kernel TLB maintenance. Also use this function in flush_tlb_all()
which is only used in relation to kernel mappings. Subsequent patches
can differentiate between workarounds that apply to user only or both
user and kernel.

A subsequent patch will add mm_struct to __tlbi_sync_s1ish(). Since
arch_tlbbatch_flush() is not specific to an mm, add a corresponding
__tlbi_sync_s1ish_batch() helper.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Will Deacon <will@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index c87d13bee37d..387bd86af702 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -191,6 +191,18 @@ static inline void __tlbi_sync_s1ish(void)
 	__repeat_tlbi_sync(vale1is, 0);
 }
 
+static inline void __tlbi_sync_s1ish_batch(void)
+{
+	dsb(ish);
+	__repeat_tlbi_sync(vale1is, 0);
+}
+
+static inline void __tlbi_sync_s1ish_kernel(void)
+{
+	dsb(ish);
+	__repeat_tlbi_sync(vale1is, 0);
+}
+
 /*
  * Complete broadcast TLB maintenance issued by hyp code which invalidates
  * stage 1 translation information in any translation regime.
@@ -286,7 +298,7 @@ static inline void flush_tlb_all(void)
 {
 	dsb(ishst);
 	__tlbi(vmalle1is);
-	__tlbi_sync_s1ish();
+	__tlbi_sync_s1ish_kernel();
 	isb();
 }
 
@@ -345,7 +357,7 @@ static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
  */
 static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
-	__tlbi_sync_s1ish();
+	__tlbi_sync_s1ish_batch();
 }
 
 /*
@@ -512,7 +524,7 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
 	dsb(ishst);
 	__flush_tlb_range_op(vaale1is, start, pages, stride, 0,
 			     TLBI_TTL_UNKNOWN, false, lpa2_is_enabled());
-	__tlbi_sync_s1ish();
+	__tlbi_sync_s1ish_kernel();
 	isb();
 }
 
@@ -526,7 +538,7 @@ static inline void __flush_tlb_kernel_pgtable(unsigned long kaddr)
 
 	dsb(ishst);
 	__tlbi(vaae1is, addr);
-	__tlbi_sync_s1ish();
+	__tlbi_sync_s1ish_kernel();
 	isb();
 }
 

