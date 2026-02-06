Return-Path: <stable+bounces-214702-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMplFz04hmmcLAQAu9opvQ
	(envelope-from <stable+bounces-214702-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 19:51:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DBE10243F
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 19:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEF633005AA1
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 18:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41623A0B29;
	Fri,  6 Feb 2026 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DtqhpcwX"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BC23101DC;
	Fri,  6 Feb 2026 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770403898; cv=none; b=Yv0MxqL471w5bK9ebv8eLUzhZH+2jiqWvC8Ys7mSOQq+Nvdi00I7U0O45NWY9xemfnzCDz3Fz9tDHIDCLmMTUg7u2PhfF/reUXcUo99V1WSo5Xn0wM13TKGPMGsiydKUWTncw5r37f7BnzQuxKavL/Zr781BIX6c7gc7vdi+k5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770403898; c=relaxed/simple;
	bh=WcW+kqmX5k6Pm4mmyc/pUIUS2/g78RBN7sQFQMjuFbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ndK+gGN3lvDApRNgUiCyf+lfwv6sJgRJYZPOSfPucrbmJwrJh0UzXZP2YrRMHeDeavQ2+gqz0dcqqvA/f1KDNNhkcTV48hSprtrK0BjqztCOL6hV6pEFAOS+8cB7rif6KpkrMeVxTGPMcPUQIKjdyZk0836GBjgZ89vvQOYLnok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=DtqhpcwX; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 616Ioa9C1250588
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 6 Feb 2026 10:50:39 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 616Ioa9C1250588
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770403840;
	bh=J5EM3zSkZdoMeuw8sDMQfujDhPy4L7pIjUd/qwJmq2w=;
	h=From:To:Cc:Subject:Date:From;
	b=DtqhpcwXStOkfSJk0QnZfSJ3vWvbN8NPI4Kah0Ljo55M8W+TY09SlySystxZn8U66
	 GHOUhBQ0G7T79IIhyq1vZgzwOtEylvPmEdhUTweiSbe/M5Oyu+tTORDk29QqR03DVd
	 w4xfvlOkTOJbFDOt/7LvYDSugH60Soda8294oGOnXzQnTzVY2ORHO2FliJbax5wzyy
	 5H6DXJN8KvVA7LkmXCgoHSb9X31y26eQ+hfKf9WVwrbpRnMk+99W/dvP4+kmSabDdp
	 /mInXC3DjmvKrbW8Zu3PtdFSuUSvH02WM4Tbmgk0piGKJQ0AmiDpsVNw/5BGGGYgat
	 DKcizUhd7VxRg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        xin@zytor.com, peterz@infradead.org, andrew.cooper3@citrix.com,
        sohil.mehta@intel.com, nikunj@amd.com, thomas.lendacky@amd.com,
        seanjc@google.com, stable@vger.kernel.org
Subject: [PATCH v1] x86/smp: Set up exception handling before cr4_init()
Date: Fri,  6 Feb 2026 10:50:35 -0800
Message-ID: <20260206185035.1250577-1-xin@zytor.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214702-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[xin@zytor.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[zytor.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email]
X-Rspamd-Queue-Id: A9DBE10243F
X-Rspamd-Action: no action

The current AP boot sequence initializes CR4 before setting up
exception handling.  With FRED enabled, however, CR4.FRED is set
prior to initializing the FRED configuration MSRs, introducing a
brief window where a triple fault could occur.  This wasn't
considered a problem, as the early boot code was carefully designed
to avoid triggering exceptions.  Moreover, if an exception does
occur at this stage, it's preferable for the CPU to triple fault
rather than risk a potential exploit.

However, under TDX or SEV-ES/SNP, printk() triggers a #VE or #VC,
so any logging during this small window results in a triple fault.

Swap the order of cr4_init() and cpu_init_exception_handling(),
since cr4_init() only involves reading from and writing to CR4,
and setting up exception handling does not depend on any specific
CR4 bits being set (Arguably CR4.PAE, CR4.PSE and CR4.PGE are
related but they are already set before start_secondary() anyway).

Notably, this triple fault can still occur before FRED is enabled,
while the bringup IDT is in use, since it lacks a #VE handler for
TDX.

BTW, on 32-bit systems, loading CR3 with swapper_pg_dir is moved
ahead of cr4_init(), which appears to be harmless.

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Reported-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Cc: stable@vger.kernel.org # 6.9+
---
 arch/x86/kernel/smpboot.c | 41 ++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 5cd6950ab672..d2bf1acddb86 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -228,13 +228,6 @@ static void ap_calibrate_delay(void)
  */
 static void notrace __noendbr start_secondary(void *unused)
 {
-	/*
-	 * Don't put *anything* except direct CPU state initialization
-	 * before cpu_init(), SMP booting is too fragile that we want to
-	 * limit the things done here to the most necessary things.
-	 */
-	cr4_init();
-
 	/*
 	 * 32-bit specific. 64-bit reaches this code with the correct page
 	 * table established. Yet another historical divergence.
@@ -245,8 +238,37 @@ static void notrace __noendbr start_secondary(void *unused)
 		__flush_tlb_all();
 	}
 
+	/*
+	 * AP startup assembly code has setup the following before calling
+	 * start_secondary() on 64-bit:
+	 *
+	 * 1) CS set to __KERNEL_CS.
+	 * 2) CR3 switched to the init_top_pgt.
+	 * 3) CR4.PAE, CR4.PSE and CR4.PGE are set.
+	 * 4) GDT set to per-CPU gdt_page.
+	 * 5) ALL data segments set to the NULL descriptor.
+	 * 6) MSR_GS_BASE set to per-CPU offset.
+	 * 7) IDT set to bringup IDT.
+	 * 8) CR0 set to CR0_STATE.
+	 *
+	 * So it's ready to setup exception handling.
+	 */
 	cpu_init_exception_handling(false);
 
+	/*
+	 * Ensure bits set in cr4_pinned_bits are set in CR4.
+	 *
+	 * cr4_pinned_bits is a subset of cr4_pinned_mask, which includes
+	 * the following bits:
+	 *         X86_CR4_SMEP
+	 *         X86_CR4_SMAP
+	 *         X86_CR4_UMIP
+	 *         X86_CR4_FSGSBASE
+	 *         X86_CR4_CET
+	 *         X86_CR4_FRED
+	 */
+	cr4_init();
+
 	/*
 	 * Load the microcode before reaching the AP alive synchronization
 	 * point below so it is not part of the full per CPU serialized
@@ -272,6 +294,11 @@ static void notrace __noendbr start_secondary(void *unused)
 	 */
 	cpuhp_ap_sync_alive();
 
+	/*
+	 * Don't put *anything* except direct CPU state initialization
+	 * before cpu_init(), SMP booting is too fragile that we want to
+	 * limit the things done here to the most necessary things.
+	 */
 	cpu_init();
 	fpu__init_cpu();
 	rcutree_report_cpu_starting(raw_smp_processor_id());
-- 
2.52.0


