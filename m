Return-Path: <stable+bounces-159089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FACFAEEA84
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 00:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2443A2ED3
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 22:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A3B245033;
	Mon, 30 Jun 2025 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KIrvpHGQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6Ayu/pb7"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF9953365;
	Mon, 30 Jun 2025 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751322982; cv=none; b=GzXrfoiuYIN4s8+3M/Uspu8vxjXRLtP2ityLVH1b3nIRqG5nzx8WupKcDvKfLq6Uf/fJiFAaZJSbAylo2GqGxXNA+ULR0SA84agOVmudDC3LX2pqvCDvEMmasKb09MR3DMWnQgV5evB8gQVnOgYS6ubvuA/lw/rXT6oFti2xxRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751322982; c=relaxed/simple;
	bh=HMy/2bTDCDxJHYgG5atG/+KZlrtP7zOKegC7ge7E4nA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QTvsPcoozuquHT1R9VjLWK4Imo/niHq2CiEHoBlh2qgl7/Bzlsswp/2zIwGdOAgM5KMgjWLTpNdNpgaZi/mBRUZGbzphrf2pSe3BgIGBYg6dP/KH7k0ltdF3+fCrae4/ScB60cglUtzaep2B5xSucE1Lt75TVJxHHbaKgE+lOD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KIrvpHGQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6Ayu/pb7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Jun 2025 22:36:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751322977;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufhqaBIhxPaRx29lTLOc9AHC4bKR6eluN9he0ddA47w=;
	b=KIrvpHGQxz12tviOjO6chkvezsu53EygpbSN2f4JE0vhv46VQoc3YL8B/acGMtks3GlOaQ
	HJiOJP182RTq8oToqZ5SIKPcaXHiXln3oD0mvSzOCNKtZwfnEheKsmbT9lTqZptd8iG2wg
	AeOplo/Gz+sybSr/goJScBs/7uOhcaSRfMmHkXOK9IRhurfv6uOVW7IE+IxjwpaqCqr5SW
	E901Fs2BTKLfhSX0TupY2VZ3o5TpwYozZqNbHrRM0z4Um68QgC+fgCqhKE5e/cPxE/521s
	6s0lZCmH+s/seNdRKwdSo33t2Z4aMaqvKm55sOnmV4r8ZTfqLmxupC//h4P1CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751322977;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufhqaBIhxPaRx29lTLOc9AHC4bKR6eluN9he0ddA47w=;
	b=6Ayu/pb7y6kvhoUyyd+rG1fgX7b/3rAy+NzPOCR2rayHTxhumf0fW5ldSxSBLqFV2QJ77I
	WRmgaGpjH3vEupAg==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Use TSC_FACTOR for Secure TSC frequency
 calculation
Cc: Nikunj A Dadhania <nikunj@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250630081858.485187-1-nikunj@amd.com>
References: <20250630081858.485187-1-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175132297648.406.7975995047248838474.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     52e1a03e6cf61ae165f59f41c44394a653a0a788
Gitweb:        https://git.kernel.org/tip/52e1a03e6cf61ae165f59f41c44394a653a0a788
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Mon, 30 Jun 2025 13:48:58 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 01 Jul 2025 00:29:27 +02:00

x86/sev: Use TSC_FACTOR for Secure TSC frequency calculation

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
---
 arch/x86/coco/sev/core.c   | 22 +++++++++++++++++++---
 arch/x86/include/asm/sev.h | 17 ++++++++++++++++-
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b6db4e0..7543a8b 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -88,7 +88,7 @@ static const char * const sev_status_feat_names[] = {
  */
 static u64 snp_tsc_scale __ro_after_init;
 static u64 snp_tsc_offset __ro_after_init;
-static u64 snp_tsc_freq_khz __ro_after_init;
+static unsigned long snp_tsc_freq_khz __ro_after_init;
 
 DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
@@ -2167,15 +2167,31 @@ static unsigned long securetsc_get_tsc_khz(void)
 
 void __init snp_secure_tsc_init(void)
 {
-	unsigned long long tsc_freq_mhz;
+	struct snp_secrets_page *secrets;
+	unsigned long tsc_freq_mhz;
+	void *mem;
 
 	if (!cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
 		return;
 
+	mem = early_memremap_encrypted(sev_secrets_pa, PAGE_SIZE);
+	if (!mem) {
+		pr_err("Unable to get TSC_FACTOR: failed to map the SNP secrets page.\n");
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECURE_TSC);
+	}
+
+	secrets = (__force struct snp_secrets_page *)mem;
+
 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
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
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 58e028d..a631f7d 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -223,6 +223,18 @@ struct snp_tsc_info_resp {
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
@@ -282,8 +294,11 @@ struct snp_secrets_page {
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

