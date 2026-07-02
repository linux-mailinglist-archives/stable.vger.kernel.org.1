Return-Path: <stable+bounces-271381-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T47vOHGaRmqAZwsAu9opvQ
	(envelope-from <stable+bounces-271381-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:05:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BB06FAF8F
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:05:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=fzh3VojN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271381-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271381-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41A4630FAD8E
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEBA33BBB9;
	Thu,  2 Jul 2026 16:56:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84982FFF9D;
	Thu,  2 Jul 2026 16:56:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011395; cv=none; b=juIlX8KuxmgZsSAGJBkd6ehlF4hFGqJd+CuOoQZuv5yncVNgE4udxfkg+x1nwUXIYrsGvEG+z/T4IUR/z/9HGdCgkeIWaC89fYnrfjR9/95bR+f/ENCDAUzIj6sR6ml0vTat5xgiubzpIWFLM3GT8EaLMgZq3EWeKSlBvA1BekU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011395; c=relaxed/simple;
	bh=SJxjYD4k1SRCBQ//EshooLADk+6fNYPN24jv7QHAfK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIKW3e9PBzqP1jt6APvxGul6hyayOOLBCWAWxhlXlgU6QLR7dYtnwi437Evg2JbPiwq8VrKu9QUnCyn4lq0Zl/OonMEOTR1+VnFwXy0doa81fgGdZmhdQA2RalRHdSNK2PWUwyoupbtve1pK/Is+ep5F1SGZWhFRCW2I8vqULl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fzh3VojN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0101F000E9;
	Thu,  2 Jul 2026 16:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011393;
	bh=zneNHN+n24toqdm2Ge1soEr7mAqSmga86ITqZHMQD1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fzh3VojNPKC2RBaehfKfWx68NK527HMhVg76UxeaKXgRWcPIDokA2ekrLPhAnjlya
	 fsZKZ/bRIENUPi+pAjQQdSBoebNmIqEosDe/5wT5PhPg9VtuhS8HWTj9LQbbMFMawm
	 5FqNXES/qiFBn9GdKNcp01b4etmmzhoCx0AABDUA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yanko Kaneti <yaneti@declera.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Paul Walmsley <pjw@kernel.org>
Subject: [PATCH 6.18 090/108] riscv: kfence: Call mark_new_valid_map() for kfence_unprotect()
Date: Thu,  2 Jul 2026 18:21:27 +0200
Message-ID: <20260702155113.976085199@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.110058792@linuxfoundation.org>
References: <20260702155112.110058792@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271381-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:yaneti@declera.com,m:wangruikang@iscas.ac.cn,m:pjw@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,iscas.ac.cn:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,declera.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78BB06FAF8F

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vivian Wang <wangruikang@iscas.ac.cn>

commit 8d6c8c40e733b3fcaf92fed0a078bba2f6941a3b upstream.

In kfence_protect_page(), which kfence_unprotect() calls, we cannot send
IPIs to other CPUs to ask them to flush TLB. This may lead to those CPUs
spuriously faulting on a recently allocated kfence object despite it
being valid, leading to false positive use-after-free reports.

Fix this by calling mark_new_valid_map() so that the page fault handling
code path notices the spurious fault and flushes TLB then retries the
access.

Update the comment in handle_exception to indicate that
new_valid_map_cpus_check also handles kfence_unprotect() spurious
faults.

Note that kfence_protect() has the same stale TLB entries problem, but
that leads to false negatives, which is fine with kfence.

Cc: stable@vger.kernel.org
Reported-by: Yanko Kaneti <yaneti@declera.com>
Fixes: b3431a8bb336 ("riscv: Fix IPIs usage in kfence_protect_page()")
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
Link: https://patch.msgid.link/20260303-handle-kfence-protect-spurious-fault-v2-2-f80d8354d79d@iscas.ac.cn
Signed-off-by: Paul Walmsley <pjw@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/include/asm/kfence.h |    7 +++++--
 arch/riscv/kernel/entry.S       |    6 ++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

--- a/arch/riscv/include/asm/kfence.h
+++ b/arch/riscv/include/asm/kfence.h
@@ -6,6 +6,7 @@
 #include <linux/kfence.h>
 #include <linux/pfn.h>
 #include <asm-generic/pgalloc.h>
+#include <asm/cacheflush.h>
 #include <asm/pgtable.h>
 
 static inline bool arch_kfence_init_pool(void)
@@ -17,10 +18,12 @@ static inline bool kfence_protect_page(u
 {
 	pte_t *pte = virt_to_kpte(addr);
 
-	if (protect)
+	if (protect) {
 		set_pte(pte, __pte(pte_val(ptep_get(pte)) & ~_PAGE_PRESENT));
-	else
+	} else {
 		set_pte(pte, __pte(pte_val(ptep_get(pte)) | _PAGE_PRESENT));
+		mark_new_valid_map();
+	}
 
 	preempt_disable();
 	local_flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -107,8 +107,10 @@ SYM_CODE_START(handle_exception)
 
 #ifdef CONFIG_64BIT
 	/*
-	 * The RISC-V kernel does not eagerly emit a sfence.vma after each
-	 * new vmalloc mapping, which may result in exceptions:
+	 * The RISC-V kernel does not flush TLBs on all CPUS after each new
+	 * vmalloc mapping or kfence_unprotect(), which may result in
+	 * exceptions:
+	 *
 	 * - if the uarch caches invalid entries, the new mapping would not be
 	 *   observed by the page table walker and an invalidation is needed.
 	 * - if the uarch does not cache invalid entries, a reordered access



