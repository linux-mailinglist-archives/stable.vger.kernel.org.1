Return-Path: <stable+bounces-36315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D1F89B7F3
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 08:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1E728294B
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 06:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F2D225CF;
	Mon,  8 Apr 2024 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHros5G4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92121373
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 06:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558993; cv=none; b=dea87+QkJYBcsNneUUKRHw8co/+WZkgPcdMTWnzTrjd8HTccptWhNUNGn00RUrN8VhNygfpBdc/77Ct3Q/QwXD/7G6BLlwj6Qu75jQKJBOKTomPJqXF9irgiGpKey9NA+rp4d7qoW9RYDRaaEn4ZF0husKQe81Hqs5mCcDLkO2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558993; c=relaxed/simple;
	bh=ELdQUSm9LN3suXNCaLwf/xXSTQLNSKYgjFoQ5p6Rq94=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dnh/v8mucjgG5TG895MJ492rIFMOIyuMeJ5geLSYAsu6t3fmgBlrMmMPGYjxlfc6sg5A7vac283rAdgbC1zvTxaCMd7BK9xtsRR8UiWbsBMhzTu1Ju9KgnJO4xjnZd/6h5SSKJ9iSLR50tT7dXmbD7BwzURO8ppGm62yKhFiKfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vHros5G4; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-343efa26688so1490598f8f.3
        for <stable@vger.kernel.org>; Sun, 07 Apr 2024 23:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712558989; x=1713163789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DEeBAav2REkFK2prDi2rT/O9lHmknwfgFH26yGQZOH8=;
        b=vHros5G4So1oeUbiIkiPhpuD8H9aRMcpID+LdEf3ld/9guwMWES4+v3/TIz+jtJorK
         S5DLHJU0xEnrxNut0rUwiQ9QG7LDBHkIBaxcty7Dg6fd1FaENHWIilAoGPI1r678QM8B
         T5b2uHnF92fs0MD69VqJQ11gRtPBuwKUuriIhMC72CVTlZeg268NriiVh8enR7URyQzo
         UgtfLP4LpGTRYw6ODQcTHOo36ldhd3yQCw+PNrqjMiFmX8se7pHydWhQCZw7Zfyt/hTY
         NLDisVT6PmNTGyENxbaTNpIbSLxhYBoAfcsnNMtV22TpUgXVxxW7PFeSKl87OZe/XY0F
         oaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712558989; x=1713163789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEeBAav2REkFK2prDi2rT/O9lHmknwfgFH26yGQZOH8=;
        b=itAgbYOFgwnyu8Xp4C7TjizhLWD8FgoF32RWgmmCfL2nTiffy5HlNdl4XqQrqk1At7
         hKtLu/tyxxru+FCiRaPXhQkraiUGYevGSky8yIeRjx65+ep2so+bITmGvfbJTG7gOEVv
         SZJkbPd8FDWS8zToYavj7KtkrPOzYcLMMJ/h5uEJszzl6pYT1uc5BEP5y37PinKZPBEl
         l1RYp9b0pM7Jcn7PwQ66KYUn5rv7vXZUoMkjqGP/AvveWWfnpMMSuC5I+3D2tV3qUS4O
         MDyYdv/QtHv0noSYwm2jyVUDNfJaRHbSEOfH+eWpSuuCEzaMhKA9qOuXPVxHBvfvpP6g
         WcAg==
X-Gm-Message-State: AOJu0YxyxgfpVV6DdgCJje0C8v+fSFPzpVvt9UWW2xyGiLHzdOlaZ9Sh
	Vtma5coDqi+/xo8yN9RZi//LV2dUMAc4/b/FL3aVl9l2eCfLiFIk6sxhDF3W1YMmaHBevTSwKfv
	Y8p+weuyzJaNA7soAN65NxQznmx9TNk2jtNJ8y5Erv/X6EGd4fcWStzFGyTPaM6jge7LFV/p4QM
	wy2mSd5YTXOvQGG/7VICHbhg==
X-Google-Smtp-Source: AGHT+IHGs67DGqesm9GfAx1JIkQZWv1YwrFEsrMEfxZ27xeM/3iLCiS41GuSI3SYniXJDGto43eRBQHz
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:9cca:0:b0:343:de7b:c72b with SMTP id
 h10-20020adf9cca000000b00343de7bc72bmr18059wre.3.1712558989243; Sun, 07 Apr
 2024 23:49:49 -0700 (PDT)
Date: Mon,  8 Apr 2024 08:49:23 +0200
In-Reply-To: <20240408064917.3391405-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240408064917.3391405-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7564; i=ardb@kernel.org;
 h=from:subject; bh=3MpwnNMEDQAW924vu7kdEqcdJUOAfOgeITG1R7HeCHs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU14crGTp8nqZG73k5Nn32npDi6P1D3iuPnq2qCjrzaZB
 My5v/lnRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjItBJGhhn6qt8WLr7ae6qh
 tvUTP1eQib83J+d+lol3UuVV3J7oGjD8095xX1Cj69XmLadjQ2ZsLbz5W4P1VZKD0Jl5Gkqy60q X8gIA
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408064917.3391405-13-ardb+git@google.com>
Subject: [PATCH -for-stable-v6.6+ 5/6] x86/sev: Move early startup code into
 .head.text section
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
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
 arch/x86/kernel/sev.c          | 14 +++++++-----
 4 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 80d76aea1f7b..0a49218a516a 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -116,6 +116,9 @@ static bool fault_in_kernel_space(unsigned long address)
 #undef __init
 #define __init
 
+#undef __head
+#define __head
+
 #define __BOOT_COMPRESSED
 
 /* Basic instruction decoding support needed */
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 36f905797075..75a5388d4068 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -199,15 +199,15 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
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
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 466fe09898cc..acbec4de3ec3 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -89,7 +89,8 @@ static bool __init sev_es_check_cpu_features(void)
 	return true;
 }
 
-static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
+static void __head __noreturn
+sev_es_terminate(unsigned int set, unsigned int reason)
 {
 	u64 val = GHCB_MSR_TERM_REQ;
 
@@ -326,13 +327,7 @@ static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid
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
@@ -391,7 +386,7 @@ static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
 	return xsave_size;
 }
 
-static bool
+static bool __head
 snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
@@ -528,7 +523,8 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
  * should be treated as fatal by caller.
  */
-static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+static int __head
+snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
@@ -570,7 +566,7 @@ static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_le
  * page yet, so it only supports the MSR based communication with the
  * hypervisor and only the CPUID exit-code.
  */
-void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
+void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int subfn = lower_bits(regs->cx, 32);
 	unsigned int fn = lower_bits(regs->ax, 32);
@@ -1016,7 +1012,8 @@ struct cc_setup_data {
  * Search for a Confidential Computing blob passed in as a setup_data entry
  * via the Linux Boot Protocol.
  */
-static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
+static __head
+struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
 {
 	struct cc_setup_data *sd = NULL;
 	struct setup_data *hdr;
@@ -1043,7 +1040,7 @@ static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
  * mapping needs to be updated in sync with all the changes to virtual memory
  * layout and related mapping facilities throughout the boot process.
  */
-static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
+static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 {
 	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
 	int i;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a8db68a063c4..9905dc0e0b09 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -26,6 +26,7 @@
 #include <linux/dmi.h>
 #include <uapi/linux/sev-guest.h>
 
+#include <asm/init.h>
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
 #include <asm/sev.h>
@@ -683,8 +684,9 @@ static u64 __init get_jump_table_addr(void)
 	return ret;
 }
 
-static void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
-				  unsigned long npages, enum psc_op op)
+static void __head
+early_set_pages_state(unsigned long vaddr, unsigned long paddr,
+		      unsigned long npages, enum psc_op op)
 {
 	unsigned long paddr_end;
 	u64 val;
@@ -740,7 +742,7 @@ static void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 }
 
-void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
+void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
 					 unsigned long npages)
 {
 	/*
@@ -2045,7 +2047,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
  *
  * Scan for the blob in that order.
  */
-static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
+static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
@@ -2071,7 +2073,7 @@ static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 	return cc_info;
 }
 
-bool __init snp_init(struct boot_params *bp)
+bool __head snp_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
@@ -2093,7 +2095,7 @@ bool __init snp_init(struct boot_params *bp)
 	return true;
 }
 
-void __init __noreturn snp_abort(void)
+void __head __noreturn snp_abort(void)
 {
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
-- 
2.44.0.478.gd926399ef9-goog


