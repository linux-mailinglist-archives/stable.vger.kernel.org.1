Return-Path: <stable+bounces-133204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5736BA92024
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 16:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98B719E707B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D95F2528F2;
	Thu, 17 Apr 2025 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Yjg5SSfw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Yjg5SSfw"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9DA2517BE
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901295; cv=none; b=NG36DLyfkTRMfqFwQQkaKooj0o2RtqlJUloud5Wz2lj/z8153N9CtZ33y8ePYcTcR/COqV+QqSi/m8VXIftL4NNXPLzjix19DZDMdhhgLRkoTSMfcubwxT3V6qpG8MRXYhQYQvg8GA3rPRKbWBCd9wxeLtfJFxQrXXnwOUMvNOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901295; c=relaxed/simple;
	bh=RY5mdWHGD5kfzWhvtf5E8Sp/to3iuvXGYpo1Vpthnn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YGHC894dNmHLSOsl/V/z7PBIbW6AtUOuM3a18QHIzq0WpqVRobuFORs2emiz/1yDlV6Z04MrHQ3KqLHZHCXRW4pb7HMeRxtwlWJHInRrBcbZJ4m9jew8H/2j9oQHxi+HnStsEPDMqNK5nc/KRpjzr7+jnM2gsJBXj8jMgDpOvUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Yjg5SSfw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Yjg5SSfw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71F7A2116B;
	Thu, 17 Apr 2025 14:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744901291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=URyoU8ysBuk6krIvolEQ5LBEHfOYYs9TThhoUc7ox78=;
	b=Yjg5SSfw++a9DxyJ9eE+LRLtw2f2jldBH7kwe0Lj8DyyBj4pXJ3S3tg2yXEiSaZnJ7u5SQ
	cgiglz969Lm0kvpv2bY119Q0s4lLv8jZ/+lK7QxwUBWmEM91vPNiMdvnNDsJy238foJ8ds
	7MiBgJmCfmr7vKFsdwwjpK1rr2pj+7Y=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744901291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=URyoU8ysBuk6krIvolEQ5LBEHfOYYs9TThhoUc7ox78=;
	b=Yjg5SSfw++a9DxyJ9eE+LRLtw2f2jldBH7kwe0Lj8DyyBj4pXJ3S3tg2yXEiSaZnJ7u5SQ
	cgiglz969Lm0kvpv2bY119Q0s4lLv8jZ/+lK7QxwUBWmEM91vPNiMdvnNDsJy238foJ8ds
	7MiBgJmCfmr7vKFsdwwjpK1rr2pj+7Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F5F8137CF;
	Thu, 17 Apr 2025 14:48:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 36JCAqsUAWjaWQAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 17 Apr 2025 14:48:11 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	=?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>,
	stable@vger.kernel.org
Subject: [PATCH] x86/mm: fix _pgd_alloc() for Xen PV mode
Date: Thu, 17 Apr 2025 16:48:08 +0200
Message-ID: <20250417144808.22589-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Flag: NO

Recently _pgd_alloc() was switched from using __get_free_pages() to
pagetable_alloc_noprof(), which might return a compound page in case
the allocation order is larger than 0.

On x86 this will be the case if CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
is set, even if PTI has been disabled at runtime.

When running as a Xen PV guest (this will always disable PTI), using
a compound page for a PGD will result in VM_BUG_ON_PGFLAGS being
triggered when the Xen code tries to pin the PGD.

Fix the Xen issue together with the not needed 8k allocation for a
PGD with PTI disabled by using a variable holding the PGD allocation
order in case CONFIG_MITIGATION_PAGE_TABLE_ISOLATION is set.

Reported-by: Petr Vaněk <arkamar@atlas.cz>
Fixes: a9b3c355c2e6 ("asm-generic: pgalloc: provide generic __pgd_{alloc,free}")
Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/pgalloc.h | 7 ++++++-
 arch/x86/mm/pgtable.c          | 4 ++++
 arch/x86/mm/pti.c              | 3 +++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index a33147520044..754f95bddf98 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -34,8 +34,13 @@ static inline void paravirt_release_p4d(unsigned long pfn) {}
  * Instead of one PGD, we acquire two PGDs.  Being order-1, it is
  * both 8k in size and 8k-aligned.  That lets us just flip bit 12
  * in a pointer to swap between the two 4k halves.
+ *
+ * As PTI can be runtime disabled (either via boot parameter or due to
+ * running as a Xen PV guest), store the actually needed allocation
+ * order in a global variable.
  */
-#define PGD_ALLOCATION_ORDER 1
+#define PGD_ALLOCATION_ORDER pgd_allocation_order
+extern unsigned int pgd_allocation_order;
 #else
 #define PGD_ALLOCATION_ORDER 0
 #endif
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index a05fcddfc811..f61b2d6be311 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -12,6 +12,10 @@ phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
 EXPORT_SYMBOL(physical_mask);
 #endif
 
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
+unsigned int pgd_allocation_order = 0;
+#endif
+
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
 	return __pte_alloc_one(mm, GFP_PGTABLE_USER);
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 5f0d579932c6..44b7120c63e3 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -38,6 +38,7 @@
 #include <asm/desc.h>
 #include <asm/sections.h>
 #include <asm/set_memory.h>
+#include <asm/pgalloc.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)     "Kernel/User page tables isolation: " fmt
@@ -97,6 +98,8 @@ void __init pti_check_boottime_disable(void)
 	if (pti_mode == PTI_AUTO && !boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
 		return;
 
+	pgd_allocation_order = 1;
+
 	setup_force_cpu_cap(X86_FEATURE_PTI);
 }
 
-- 
2.43.0


