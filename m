Return-Path: <stable+bounces-161710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75000B02B12
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 15:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1E2A44FD0
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 13:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855B5278753;
	Sat, 12 Jul 2025 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UGm9jUNn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444A4278750
	for <stable@vger.kernel.org>; Sat, 12 Jul 2025 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752328566; cv=none; b=b613IuzWdAfq9wl2zYVWMEQeq2zlUeyhpQPtXxSL62KHjRu4AnrY5VJ1mkGZ2ugfFs7P/KcKsglaVVxzyqc/r1JipwtW7Y7QpMikiSAcF+MWSDfUp3Vl287dAfMwk6md08hxJuoIha7ipXaBkk4lxT6uuB0UCjrG+8Ga7tgT7lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752328566; c=relaxed/simple;
	bh=jm6eslhs8EVCD85OovG796JKTCrNRX3x44LNCAnSZzQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V1DKGyHhO7yIX98TxxNzqRFF4LgLyHcZvNALtbXS1MQYcUdCMn+IO+ZOxOXJxCGa8LQFFvXn8OeHcc74bCinKr+Xgg/6qQXt0xkyfKcHsEAoL2CXTc3aEKs05snfxYDH/l0UTFuxDHxhZb4Aq3S4bFmfVaIevCSXGecIUM33ZMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UGm9jUNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CA6C4CEEF;
	Sat, 12 Jul 2025 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752328566;
	bh=jm6eslhs8EVCD85OovG796JKTCrNRX3x44LNCAnSZzQ=;
	h=Subject:To:Cc:From:Date:From;
	b=UGm9jUNn8rDhT1wMiphpgMh/hhwB0625Pd7O1f+jvTIcP1YE5/djwJraJG2pWWRoK
	 P4EcE0nyNz4J9gBmXsqvggHhs0j+vU0lgfHkNLK8z2zwJitJ/So6RdSZ5MexWZKAG1
	 Fbs/LwyqhpJ+t2FDpk25j6lt9fV6rAm4dpzYTBqk=
Subject: FAILED: patch "[PATCH] x86/sev: Use TSC_FACTOR for Secure TSC frequency calculation" failed to apply to 6.15-stable tree
To: nikunj@amd.com,bp@alien8.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 12 Jul 2025 15:56:03 +0200
Message-ID: <2025071203-dime-overcook-61dc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 52e1a03e6cf61ae165f59f41c44394a653a0a788
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071203-dime-overcook-61dc@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 52e1a03e6cf61ae165f59f41c44394a653a0a788 Mon Sep 17 00:00:00 2001
From: Nikunj A Dadhania <nikunj@amd.com>
Date: Mon, 30 Jun 2025 13:48:58 +0530
Subject: [PATCH] x86/sev: Use TSC_FACTOR for Secure TSC frequency calculation

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

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b6db4e0b936b..7543a8b52c67 100644
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
index 58e028d42e41..a631f7d7c0c0 100644
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


