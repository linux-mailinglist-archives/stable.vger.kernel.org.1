Return-Path: <stable+bounces-40258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB988AA9E0
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDA01C21406
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824484D59F;
	Fri, 19 Apr 2024 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DKpmzLJk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D09A55
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514338; cv=none; b=SOAGrRi43VRsfQhnhZqL6x4KE2gDqit5WyUGU+RtFo8TEnkxvYq5pR4aExefOTuijDu1CHQcvvmpE/SmdtgpE+LJWp1r1kYtDIdzKNAtOsl8+OgEcHc8ySjkTnAhspDs+d9rlMBs9UdjgciWfuFWh+TLnAycLkukev7KBPMwb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514338; c=relaxed/simple;
	bh=YN+rd0+WdgMQJ9nY2RLnHL4anejDF8DWm6TrNIw/E3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cEjbQm7yEIUIZXorm2ldbpXDCb8rn44SAEU7FG1aJNL5hEYCSMzjaoV3SwaYPKVji70rrZ3w2hftmRqN9M4gI0Rrwvnand4583Fy6rogYOZTvOU+L45zJ1SmaUd3Kr17gm0tA8zkjEVtI++jgRRWSJqYihmH+HbdBLzZQxRzoIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DKpmzLJk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-41485831b2dso14555515e9.3
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514335; x=1714119135; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wj5hoGIx4KIQ7BVcRmLPom0DjwK13UJ1lGrv7E+eOHY=;
        b=DKpmzLJkn4Hep4uZLdtsgOsiMSpgCDYkyGHCvcfgrCKZUWTSG5kulB+hrhm+quLeoE
         m2k7N1iGtxfgCcCJZ/iw0HfTsUSvjM8GIGFMEYU5gOD3FnGCJ+zr2qbHGHUDDV1YTIwe
         /k4UbN90AJQvfFpi9nrZsBgYw9W7OhoVQCr/odzEoCvB5zI8cGhXxkB8GDsAezgYFtC1
         rZm4Sf0w735mtPWaCeHGqxZyeRKyWZVi/5cXMecNjA7btDpyzJli6QK46bdOBph+Dwsw
         CKYAp21Pacspej+HFQ38rI2pY4YORjihMmq4iCdiW1XZruplpnDli4VIhVYJ6GSfgmLO
         InNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514335; x=1714119135;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wj5hoGIx4KIQ7BVcRmLPom0DjwK13UJ1lGrv7E+eOHY=;
        b=mB4N/Q1Os6iSyMSpHF5rO0RXGe8UgWMb5gj0QnT0lZs22BFvmsFkw7gxy9MqRzUH0T
         S1P5NCH3XyqT4o2RnvuU3Gor4q4MG7k504FWbpHVxty4cgkpW1LqQ8SQr0xFGiEyLWmE
         lgsFsal+iCMSfecBtVBJwBj9yj+sjjBYutNdEdsLxbpqxGA5jRDsRWMupnx268MQonon
         tKkX8kD6qokis9DJ+Fi/NMHw001TOPN+t1JF+jJZPDrxdUZTojNyqEfzXBRUsNzH+bVU
         5VQO61K68JEaVT+N8lG19k5YxKqoNTSrcQNVBfJa1iilnZVl+lKNt02+keXaeAwEqozN
         ZVpA==
X-Gm-Message-State: AOJu0YxTtl9La37LxP9qaVUn9T7Clz7o6N3YjWsk6axTmdcSrs4FevVT
	hopBx4k+tsAjtabFgEjTV7BfEYE1L2bWPcZhPUDHlXAz3P1XO+wACIsFjjgoCjXljLDFj33F7NH
	OOgCjqistzwk1hyeS813VDKkuf2zvCG/liL5/jizVSL1tyeUsFFYB4ug5sU2zw6x8J0EhxkbmzA
	9Fh7chJc+z+ADrnS1pfA93Jg==
X-Google-Smtp-Source: AGHT+IF65UtwzMbZI1jwv6ortmgVm6jf6st7e8XEWtB3mSQ/G7OrdPbYbZM61ukKBHg2nE4WjrajYTzt
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1d1d:b0:418:394c:e4dc with SMTP id
 l29-20020a05600c1d1d00b00418394ce4dcmr9404wms.3.1713514335106; Fri, 19 Apr
 2024 01:12:15 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:28 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7548; i=ardb@kernel.org;
 h=from:subject; bh=OBRO+pXmVjNip+25crpcl7mm7NT+rKRn9okuqDSc7XQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXUu29Wh5Q8G2ZOEXDXdPm947YnlLTvWH+ctTRmtuN
 ht6Ox3vKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNxMGD4Z8o4eUfBLZmXZY/S
 M6pusm3I1viZLJx3jPX2Cq57MrNU5Bj+B8q+mcXDbdJV+S/RVav8XZzxvo2fLUwMd5YIS9y+oOz JCQA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-47-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 22/23] x86/sev: Move early startup code into
 .head.text section
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 428080c9b19bfda37c478cd626dbd3851db1aff9 upstream ]

In preparation for implementing rigorous build time checks to enforce
that only code that can support it will be called from the early 1:1
mapping of memory, move SEV init code that is called in this manner to
the .head.text section.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20240227151907.387873-19-ardb+git@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c |  3 +++
 arch/x86/include/asm/sev.h     | 10 ++++-----
 arch/x86/kernel/sev-shared.c   | 23 +++++++++-----------
 arch/x86/kernel/sev.c          | 11 +++++-----
 4 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index d07e665bb265..3c5d5c97f8f7 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -118,6 +118,9 @@ static bool fault_in_kernel_space(unsigned long address)
 #define __init
 #define __pa(x)	((unsigned long)(x))
 
+#undef __head
+#define __head
+
 #define __BOOT_COMPRESSED
 
 /* Basic instruction decoding support needed */
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index c57dd21155bd..bcac2e53d50b 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -192,15 +192,15 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 struct snp_guest_request_ioctl;
 
 void setup_ghcb(void);
-void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
-					 unsigned long npages);
-void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
-					unsigned long npages);
+void early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
+				  unsigned long npages);
+void early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+				 unsigned long npages);
 void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
-void __init __noreturn snp_abort(void);
+void __noreturn snp_abort(void);
 void snp_dmi_setup(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
 u64 snp_get_unsupported_features(u64 status);
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 271e70d5748e..3fe76bf17d95 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -86,7 +86,8 @@ static bool __init sev_es_check_cpu_features(void)
 	return true;
 }
 
-static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
+static void __head __noreturn
+sev_es_terminate(unsigned int set, unsigned int reason)
 {
 	u64 val = GHCB_MSR_TERM_REQ;
 
@@ -323,13 +324,7 @@ static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid
  */
 static const struct snp_cpuid_table *snp_cpuid_get_table(void)
 {
-	void *ptr;
-
-	asm ("lea cpuid_table_copy(%%rip), %0"
-	     : "=r" (ptr)
-	     : "p" (&cpuid_table_copy));
-
-	return ptr;
+	return &RIP_REL_REF(cpuid_table_copy);
 }
 
 /*
@@ -388,7 +383,7 @@ static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
 	return xsave_size;
 }
 
-static bool
+static bool __head
 snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
@@ -525,7 +520,8 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
  * should be treated as fatal by caller.
  */
-static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+static int __head
+snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
@@ -567,7 +563,7 @@ static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_le
  * page yet, so it only supports the MSR based communication with the
  * hypervisor and only the CPUID exit-code.
  */
-void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
+void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int subfn = lower_bits(regs->cx, 32);
 	unsigned int fn = lower_bits(regs->ax, 32);
@@ -1013,7 +1009,8 @@ struct cc_setup_data {
  * Search for a Confidential Computing blob passed in as a setup_data entry
  * via the Linux Boot Protocol.
  */
-static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
+static __head
+struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
 {
 	struct cc_setup_data *sd = NULL;
 	struct setup_data *hdr;
@@ -1040,7 +1037,7 @@ static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
  * mapping needs to be updated in sync with all the changes to virtual memory
  * layout and related mapping facilities throughout the boot process.
  */
-static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
+static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 {
 	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
 	int i;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index e35fcc8d4bae..f8a8249ae117 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -26,6 +26,7 @@
 #include <linux/dmi.h>
 #include <uapi/linux/sev-guest.h>
 
+#include <asm/init.h>
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
 #include <asm/sev.h>
@@ -690,7 +691,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned long npages, bool vali
 	}
 }
 
-static void __init early_set_pages_state(unsigned long paddr, unsigned long npages, enum psc_op op)
+static void __head early_set_pages_state(unsigned long paddr, unsigned long npages, enum psc_op op)
 {
 	unsigned long paddr_end;
 	u64 val;
@@ -728,7 +729,7 @@ static void __init early_set_pages_state(unsigned long paddr, unsigned long npag
 	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 }
 
-void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
+void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
 					 unsigned long npages)
 {
 	/*
@@ -2085,7 +2086,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
  *
  * Scan for the blob in that order.
  */
-static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
+static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
@@ -2111,7 +2112,7 @@ static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 	return cc_info;
 }
 
-bool __init snp_init(struct boot_params *bp)
+bool __head snp_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
@@ -2133,7 +2134,7 @@ bool __init snp_init(struct boot_params *bp)
 	return true;
 }
 
-void __init __noreturn snp_abort(void)
+void __head __noreturn snp_abort(void)
 {
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
-- 
2.44.0.769.g3c40516874-goog


