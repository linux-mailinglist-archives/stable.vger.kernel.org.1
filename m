Return-Path: <stable+bounces-240876-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPa+M3h062kQNAAAu9opvQ
	(envelope-from <stable+bounces-240876-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:47:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F17145FA23
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1337F30BAEF9
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E126F3D5236;
	Fri, 24 Apr 2026 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bIBH78in"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A540F3563D4;
	Fri, 24 Apr 2026 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038068; cv=none; b=roAXPjcAhMeHZLyMg3gzy0hqxmURLsP1H2yNiolHoiUudFGFdjLx3EylG0gzvUmPMP+Yljzpw1QaGryJ2tbOdp8w/fCtKQi4dDSEsIG0bFDcUpkx6GQeD8lQrK3tr5zGeqOX2/Yf9siuj5t2ZPJmbsvlYqNZoa93yDzLVPK9PIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038068; c=relaxed/simple;
	bh=sweKG5cu9UsJ/Sjg8S9Eoz04auMckpE/eY2DNkAmy6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYG1yA2QKhb73aGm/5RqaEhmw++U+me18vOd9eqA3iqbaH4P/fJfY37azytXlfdL4tgscFiircjajqvnIWAibg9+hHfuVEtipEMzpS2ZaJUCwifMhkplWE1QpeNBwv8v3A6SmL/al/zNJaAqeY7gt8Yp73XOt16mFq+1vVc4HM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bIBH78in; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF99C2BCB2;
	Fri, 24 Apr 2026 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777038068;
	bh=sweKG5cu9UsJ/Sjg8S9Eoz04auMckpE/eY2DNkAmy6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIBH78in+fKx3gh1PTNcCB+Iok+Tz+PYSwLo7zDg+b7FAJKdlPA6GV4hQv6RSwcoJ
	 F2ZZDKKUYRWodEEsLH6ctajN+2sqSha5GBD65tAXx2/fEWPrwvBFh27u1VgqZPS88U
	 h6rCuZieISgH7XolaMTZnJ6EiUUun7u0yzrw9Kjg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.18 12/55] arm64: tlb: Introduce __tlbi_sync_s1ish_{kernel,batch}() for TLB maintenance
Date: Fri, 24 Apr 2026 15:30:51 +0200
Message-ID: <20260424132432.689558760@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132430.006424517@linuxfoundation.org>
References: <20260424132430.006424517@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7F17145FA23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240876-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Catalin Marinas <catalin.marinas@arm.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/tlbflush.h |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -191,6 +191,18 @@ static inline void __tlbi_sync_s1ish(voi
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
 
@@ -345,7 +357,7 @@ static inline bool arch_tlbbatch_should_
  */
 static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
-	__tlbi_sync_s1ish();
+	__tlbi_sync_s1ish_batch();
 }
 
 /*
@@ -512,7 +524,7 @@ static inline void flush_tlb_kernel_rang
 	dsb(ishst);
 	__flush_tlb_range_op(vaale1is, start, pages, stride, 0,
 			     TLBI_TTL_UNKNOWN, false, lpa2_is_enabled());
-	__tlbi_sync_s1ish();
+	__tlbi_sync_s1ish_kernel();
 	isb();
 }
 
@@ -526,7 +538,7 @@ static inline void __flush_tlb_kernel_pg
 
 	dsb(ishst);
 	__tlbi(vaae1is, addr);
-	__tlbi_sync_s1ish();
+	__tlbi_sync_s1ish_kernel();
 	isb();
 }
 



