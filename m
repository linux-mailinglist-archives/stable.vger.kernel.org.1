Return-Path: <stable+bounces-217089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKF8AW/UlGnHIAIAu9opvQ
	(envelope-from <stable+bounces-217089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:49:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 809BA1505C1
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C01E63044B5E
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C742773E4;
	Tue, 17 Feb 2026 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CrLdjjVg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA6B29A1;
	Tue, 17 Feb 2026 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361386; cv=none; b=qaFCVGT3YLMlADn4TXvwGWW0F/ZbAm21NJAoCMTl+lS13Hn6kSSLic5fZDezs9Sv4W3ELxRlS1FF9br34gcVZq0A/NdqB4C7HQabwTqqXmarQlh++UibkUu1J/5ysZ+CMtl6gbjIZ6rGhsriOIOSgZqXd377jRTEy8Qps2Kg078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361386; c=relaxed/simple;
	bh=sHpfHglLGAhbPrgGcnj1rwN9fTS+Z7+8l3IKcFofwuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPS9XpViej7nKduh3Rjz4GoCsRJEOopfUCUdQ+aA0gE30oVC3M0Xd+Jm65qGsQXbbhHtgNXP3oe0EhA9FEKN9EHfKTGkdu1apDZHCAiWzr4WTPXwT16H1hg4sueaT0sSVnkqTts/+1Ny+7cubLMKFTVzaHKzFF9EKDs62LeaCiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CrLdjjVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD81C4CEF7;
	Tue, 17 Feb 2026 20:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361386;
	bh=sHpfHglLGAhbPrgGcnj1rwN9fTS+Z7+8l3IKcFofwuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CrLdjjVgV8ByorduQA4hkN7CCmJPqmocbZqvPLuDTaNzbUVswHu64sQsIch346D2S
	 /LE9P/TjjzzMCZLG8Goh/+foaeuiPXA6ALyl5naP+pMa/7AJknKLWTYiN6Md8t4I2/
	 roDOhnodQtuDujIFOs57GPpD0WIlgE/07wfh5fS0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.19 03/18] LoongArch: Rework KASAN initialization for PTW-enabled systems
Date: Tue, 17 Feb 2026 21:31:59 +0100
Message-ID: <20260217200002.819494249@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200002.683975158@linuxfoundation.org>
References: <20260217200002.683975158@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217089-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,loongson.cn:email]
X-Rspamd-Queue-Id: 809BA1505C1
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiezhu Yang <yangtiezhu@loongson.cn>

commit 5ec5ac4ca27e4daa234540ac32f9fc5219377d53 upstream.

kasan_init_generic() indicates that kasan is fully initialized, so it
should be put at end of kasan_init().

Otherwise bringing up the primary CPU failed when CONFIG_KASAN is set
on PTW-enabled systems, here are the call chains:

    kernel_entry()
      start_kernel()
        setup_arch()
          kasan_init()
            kasan_init_generic()

The reason is PTW-enabled systems have speculative accesses which means
memory accesses to the shadow memory after kasan_init() may be executed
by hardware before. However, accessing shadow memory is safe only after
kasan fully initialized because kasan_init() uses a temporary PGD table
until we have populated all levels of shadow page tables and writen the
PGD register. Moving kasan_init_generic() later can defer the occasion
of kasan_enabled(), so as to avoid speculative accesses on shadow pages.

After moving kasan_init_generic() to the end, kasan_init() can no longer
call kasan_mem_to_shadow() for shadow address conversion because it will
always return kasan_early_shadow_page. On the other hand, we should keep
the current logic of kasan_mem_to_shadow() for both the early and final
stage because there may be instrumentation before kasan_init().

To solve this, we factor out a new mem_to_shadow() function from current
kasan_mem_to_shadow() for the shadow address conversion in kasan_init().

Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/mm/kasan_init.c |   78 +++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 38 deletions(-)

--- a/arch/loongarch/mm/kasan_init.c
+++ b/arch/loongarch/mm/kasan_init.c
@@ -40,39 +40,43 @@ static pgd_t kasan_pg_dir[PTRS_PER_PGD]
 #define __pte_none(early, pte) (early ? pte_none(pte) : \
 ((pte_val(pte) & _PFN_MASK) == (unsigned long)__pa(kasan_early_shadow_page)))
 
-void *kasan_mem_to_shadow(const void *addr)
+static void *mem_to_shadow(const void *addr)
 {
-	if (!kasan_enabled()) {
+	unsigned long offset = 0;
+	unsigned long maddr = (unsigned long)addr;
+	unsigned long xrange = (maddr >> XRANGE_SHIFT) & 0xffff;
+
+	if (maddr >= FIXADDR_START)
 		return (void *)(kasan_early_shadow_page);
-	} else {
-		unsigned long maddr = (unsigned long)addr;
-		unsigned long xrange = (maddr >> XRANGE_SHIFT) & 0xffff;
-		unsigned long offset = 0;
-
-		if (maddr >= FIXADDR_START)
-			return (void *)(kasan_early_shadow_page);
-
-		maddr &= XRANGE_SHADOW_MASK;
-		switch (xrange) {
-		case XKPRANGE_CC_SEG:
-			offset = XKPRANGE_CC_SHADOW_OFFSET;
-			break;
-		case XKPRANGE_UC_SEG:
-			offset = XKPRANGE_UC_SHADOW_OFFSET;
-			break;
-		case XKPRANGE_WC_SEG:
-			offset = XKPRANGE_WC_SHADOW_OFFSET;
-			break;
-		case XKVRANGE_VC_SEG:
-			offset = XKVRANGE_VC_SHADOW_OFFSET;
-			break;
-		default:
-			WARN_ON(1);
-			return NULL;
-		}
 
-		return (void *)((maddr >> KASAN_SHADOW_SCALE_SHIFT) + offset);
+	maddr &= XRANGE_SHADOW_MASK;
+	switch (xrange) {
+	case XKPRANGE_CC_SEG:
+		offset = XKPRANGE_CC_SHADOW_OFFSET;
+		break;
+	case XKPRANGE_UC_SEG:
+		offset = XKPRANGE_UC_SHADOW_OFFSET;
+		break;
+	case XKPRANGE_WC_SEG:
+		offset = XKPRANGE_WC_SHADOW_OFFSET;
+		break;
+	case XKVRANGE_VC_SEG:
+		offset = XKVRANGE_VC_SHADOW_OFFSET;
+		break;
+	default:
+		WARN_ON(1);
+		return NULL;
 	}
+
+	return (void *)((maddr >> KASAN_SHADOW_SCALE_SHIFT) + offset);
+}
+
+void *kasan_mem_to_shadow(const void *addr)
+{
+	if (kasan_enabled())
+		return mem_to_shadow(addr);
+	else
+		return (void *)(kasan_early_shadow_page);
 }
 
 const void *kasan_shadow_to_mem(const void *shadow_addr)
@@ -293,11 +297,8 @@ void __init kasan_init(void)
 	/* Maps everything to a single page of zeroes */
 	kasan_pgd_populate(KASAN_SHADOW_START, KASAN_SHADOW_END, NUMA_NO_NODE, true);
 
-	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
-					kasan_mem_to_shadow((void *)KFENCE_AREA_END));
-
-	/* Enable KASAN here before kasan_mem_to_shadow(). */
-	kasan_init_generic();
+	kasan_populate_early_shadow(mem_to_shadow((void *)VMALLOC_START),
+					mem_to_shadow((void *)KFENCE_AREA_END));
 
 	/* Populate the linear mapping */
 	for_each_mem_range(i, &pa_start, &pa_end) {
@@ -307,13 +308,13 @@ void __init kasan_init(void)
 		if (start >= end)
 			break;
 
-		kasan_map_populate((unsigned long)kasan_mem_to_shadow(start),
-			(unsigned long)kasan_mem_to_shadow(end), NUMA_NO_NODE);
+		kasan_map_populate((unsigned long)mem_to_shadow(start),
+			(unsigned long)mem_to_shadow(end), NUMA_NO_NODE);
 	}
 
 	/* Populate modules mapping */
-	kasan_map_populate((unsigned long)kasan_mem_to_shadow((void *)MODULES_VADDR),
-		(unsigned long)kasan_mem_to_shadow((void *)MODULES_END), NUMA_NO_NODE);
+	kasan_map_populate((unsigned long)mem_to_shadow((void *)MODULES_VADDR),
+		(unsigned long)mem_to_shadow((void *)MODULES_END), NUMA_NO_NODE);
 	/*
 	 * KAsan may reuse the contents of kasan_early_shadow_pte directly, so we
 	 * should make sure that it maps the zero page read-only.
@@ -328,4 +329,5 @@ void __init kasan_init(void)
 
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
+	kasan_init_generic();
 }



