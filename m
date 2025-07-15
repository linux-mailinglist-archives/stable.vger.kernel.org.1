Return-Path: <stable+bounces-162677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E526BB05F69
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226E61C40ABE
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA4C2ECEA7;
	Tue, 15 Jul 2025 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j8aVkj/D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD522D6402;
	Tue, 15 Jul 2025 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587184; cv=none; b=hZ82psb/RWDG2f2xJNlFnO80kFs39GuFQnSaKOxACo4iHjmkA+LLlmKqTBO28eOBwqCV+2TCS+BhwZ3PJ0XjyMihdzO/TVXx7APzWetlJV/TW+6KdUi7x7lWr14XOT1lh/mptGOsNKTTWJhG+d4+qOHuW8wvYw/HAQhMxb2oQWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587184; c=relaxed/simple;
	bh=GwA6r6h7IleKfqpErlRrSBQC+LRBqHt6kOIvAEz5DQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeU2WYgB5a7hlkKixVRSn/0y4twOOWp56HBxrnylJBu3jk5ypgFH9agclrkUy3x1snRWpZi2bzTpaOkqiVyM5q5NEAhvflAFYqAs9xGzYCuZf5U3AKJZJsT0LqkEifF4WTEDRzcanm5K04jZyuZM+cqaOAFHibyDf4lAOp8eO6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j8aVkj/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5D8C4CEE3;
	Tue, 15 Jul 2025 13:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587184;
	bh=GwA6r6h7IleKfqpErlRrSBQC+LRBqHt6kOIvAEz5DQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8aVkj/Dod0OeZw0tbj8GzaMLYo3DoOl/cWfXEXREJWfWH8dOsr2rHbEm3vbi2QU8
	 kt3TLFqQvOREPc1EIR+CuU6Nxcf7l/sltgkk5iK+YWeIeIYznCKS2uMQjHPk/Bh50H
	 FQF8mytxgZBh1rs1GYN7wm0THXqve2T+BIaKLxgc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikunj A Dadhania <nikunj@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.15 191/192] x86/sev: Use TSC_FACTOR for Secure TSC frequency calculation
Date: Tue, 15 Jul 2025 15:14:46 +0200
Message-ID: <20250715130822.590138652@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
References: <20250715130814.854109770@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikunj A Dadhania <nikunj@amd.com>

commit 52e1a03e6cf61ae165f59f41c44394a653a0a788 upstream.

When using Secure TSC, the GUEST_TSC_FREQ MSR reports a frequency based on
the nominal P0 frequency, which deviates slightly (typically ~0.2%) from
the actual mean TSC frequency due to clocking parameters.

Over extended VM uptime, this discrepancy accumulates, causing clock skew
between the hypervisor and a SEV-SNP VM, leading to early timer interrupts as
perceived by the guest.

The guest kernel relies on the reported nominal frequency for TSC-based
timekeeping, while the actual frequency set during SNP_LAUNCH_START may
differ. This mismatch results in inaccurate time calculations, causing the
guest to perceive hrtimers as firing earlier than expected.

Utilize the TSC_FACTOR from the SEV firmware's secrets page (see "Secrets
Page Format" in the SNP Firmware ABI Specification) to calculate the mean
TSC frequency, ensuring accurate timekeeping and mitigating clock skew in
SEV-SNP VMs.

Use early_ioremap_encrypted() to map the secrets page as
ioremap_encrypted() uses kmalloc() which is not available during early TSC
initialization and causes a panic.

  [ bp: Drop the silly dummy var:
    https://lore.kernel.org/r/20250630192726.GBaGLlHl84xIopx4Pt@fat_crate.local ]

Fixes: 73bbf3b0fbba ("x86/tsc: Init the TSC for Secure TSC guests")
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250630081858.485187-1-nikunj@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/coco/sev/core.c   |   22 +++++++++++++++++++---
 arch/x86/include/asm/sev.h |   17 ++++++++++++++++-
 2 files changed, 35 insertions(+), 4 deletions(-)

--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -103,7 +103,7 @@ static u64 secrets_pa __ro_after_init;
  */
 static u64 snp_tsc_scale __ro_after_init;
 static u64 snp_tsc_offset __ro_after_init;
-static u64 snp_tsc_freq_khz __ro_after_init;
+static unsigned long snp_tsc_freq_khz __ro_after_init;
 
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
@@ -3347,15 +3347,31 @@ static unsigned long securetsc_get_tsc_k
 
 void __init snp_secure_tsc_init(void)
 {
-	unsigned long long tsc_freq_mhz;
+	struct snp_secrets_page *secrets;
+	unsigned long tsc_freq_mhz;
+	void *mem;
 
 	if (!cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
 		return;
 
+	mem = early_memremap_encrypted(secrets_pa, PAGE_SIZE);
+	if (!mem) {
+		pr_err("Unable to get TSC_FACTOR: failed to map the SNP secrets page.\n");
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECURE_TSC);
+	}
+
+	secrets = (__force struct snp_secrets_page *)mem;
+
 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	rdmsrl(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
-	snp_tsc_freq_khz = (unsigned long)(tsc_freq_mhz * 1000);
+
+	/* Extract the GUEST TSC MHZ from BIT[17:0], rest is reserved space */
+	tsc_freq_mhz &= GENMASK_ULL(17, 0);
+
+	snp_tsc_freq_khz = SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->tsc_factor);
 
 	x86_platform.calibrate_cpu = securetsc_get_tsc_khz;
 	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
+
+	early_memunmap(mem, PAGE_SIZE);
 }
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -192,6 +192,18 @@ struct snp_tsc_info_resp {
 	u8 rsvd2[100];
 } __packed;
 
+/*
+ * Obtain the mean TSC frequency by decreasing the nominal TSC frequency with
+ * TSC_FACTOR as documented in the SNP Firmware ABI specification:
+ *
+ * GUEST_TSC_FREQ * (1 - (TSC_FACTOR * 0.00001))
+ *
+ * which is equivalent to:
+ *
+ * GUEST_TSC_FREQ -= (GUEST_TSC_FREQ * TSC_FACTOR) / 100000;
+ */
+#define SNP_SCALE_TSC_FREQ(freq, factor) ((freq) - (freq) * (factor) / 100000)
+
 struct snp_guest_req {
 	void *req_buf;
 	size_t req_sz;
@@ -251,8 +263,11 @@ struct snp_secrets_page {
 	u8 svsm_guest_vmpl;
 	u8 rsvd3[3];
 
+	/* The percentage decrease from nominal to mean TSC frequency. */
+	u32 tsc_factor;
+
 	/* Remainder of page */
-	u8 rsvd4[3744];
+	u8 rsvd4[3740];
 } __packed;
 
 struct snp_msg_desc {



