Return-Path: <stable+bounces-134578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E88DEA93739
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 14:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389173ABF30
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 12:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3603127510A;
	Fri, 18 Apr 2025 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ltXLxE1A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8GxKLqlU"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4B6274FE5;
	Fri, 18 Apr 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979830; cv=none; b=Bsd0omRqueEUWV7S9Qm6SRU2RXpx8qwD6C5Np0OV9qajRp1VeNUSwyupk/AmWrGQAAfPBy41WL9LsCfxakfA8YxfFhlj4hOjUuDsrAG3aRKuHemL7wBw5eK7FvHQMnGD5+epdoHL1EnkPadOkmJrMNg7qYFB2kPRyu8PGgBkYt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979830; c=relaxed/simple;
	bh=QuK+H8LiBQrEyydEBFp62iodAsr7LMQoSGLpn5mNhlk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lYKBPZdtoIL6L354WJsCL+9wF05BKjVdCmJBKOLvPV9vxrllnfVjZc9wpOgACAM7WCSBbRYorYYToARFvgEyQUmxrrP2GoDU0shZwGopI50ZokwbJYIcsa0oFk+pkyV/QqeTOgzIlSHBs/eGRJlkaqP3PgTCkjvjwoVwfAxnrTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ltXLxE1A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8GxKLqlU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Apr 2025 12:37:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744979826;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQAYJveHr4JuUDw+7ee0ikdP/Zwdf/ok0dtSCvmTmmA=;
	b=ltXLxE1AeB/odTdtuZd3zd7Bj6MttjSZbJ0ubF/SATaeC7Zc6ILijXhm+0y6/PPYRJ9V/u
	e2AC5mPMgy5AEMJtpgLQycGZZkrBbeh4G9x0IEvS1OkVirYoIyaNbnMudktpSqztk5OU3X
	9Fy5k4EPhI9YCQC5khtk7i/2zmw4R22hEFgFm252p6CPlQie2OjuZWxzByIzVSLZNIk3c3
	r9AsrF9WJf9V3pGEtvDMNwfD0PWleghQSzYXL2DhQRaydzkW/f8VJkUCicLdFYKstMQR6Q
	iqtkqcPvXgOq4McNg70xODiXqusCYQ6btmvtyG8jB6X5avieRs3bhv6Jg1oGQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744979826;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQAYJveHr4JuUDw+7ee0ikdP/Zwdf/ok0dtSCvmTmmA=;
	b=8GxKLqlU2TQNnGHIqicrxaDkH1fve+U4IWBW2sKqOThuIeNzc0Coqx6+MXf5StFlAWNDkm
	JIzjC7xjxKRMQdAg==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu/amd: Fix workaround for erratum 1054
Cc: Sandipan Das <sandipan.das@amd.com>, Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ccaa057a9d6f8ad579e2f1abaa71efbd5bd4eaf6d=2E17449?=
 =?utf-8?q?56467=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Ccaa057a9d6f8ad579e2f1abaa71efbd5bd4eaf6d=2E174495?=
 =?utf-8?q?6467=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174497982594.31282.14063656434033140928.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     263e55949d8902a6a09bdb92a1ab6a3f67231abe
Gitweb:        https://git.kernel.org/tip/263e55949d8902a6a09bdb92a1ab6a3f67231abe
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Fri, 18 Apr 2025 11:49:40 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 18 Apr 2025 14:29:47 +02:00

x86/cpu/amd: Fix workaround for erratum 1054

Erratum 1054 affects AMD Zen processors that are a part of Family 17h
Models 00-2Fh and the workaround is to not set HWCR[IRPerfEn]. However,
when X86_FEATURE_ZEN1 was introduced, the condition to detect unaffected
processors was incorrectly changed in a way that the IRPerfEn bit gets
set only for unaffected Zen 1 processors.

Ensure that HWCR[IRPerfEn] is set for all unaffected processors. This
includes a subset of Zen 1 (Family 17h Models 30h and above) and all
later processors. Also clear X86_FEATURE_IRPERF on affected processors
so that the IRPerfCount register is not used by other entities like the
MSR PMU driver.

Fixes: 232afb557835 ("x86/CPU/AMD: Add X86_FEATURE_ZEN1")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/caa057a9d6f8ad579e2f1abaa71efbd5bd4eaf6d.1744956467.git.sandipan.das@amd.com
---
 arch/x86/kernel/cpu/amd.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index a839ff5..2b36379 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -869,6 +869,16 @@ static void init_amd_zen1(struct cpuinfo_x86 *c)
 
 	pr_notice_once("AMD Zen1 DIV0 bug detected. Disable SMT for full protection.\n");
 	setup_force_cpu_bug(X86_BUG_DIV0);
+
+	/*
+	 * Turn off the Instructions Retired free counter on machines that are
+	 * susceptible to erratum #1054 "Instructions Retired Performance
+	 * Counter May Be Inaccurate".
+	 */
+	if (c->x86_model < 0x30) {
+		msr_clear_bit(MSR_K7_HWCR, MSR_K7_HWCR_IRPERF_EN_BIT);
+		clear_cpu_cap(c, X86_FEATURE_IRPERF);
+	}
 }
 
 static bool cpu_has_zenbleed_microcode(void)
@@ -1052,13 +1062,8 @@ static void init_amd(struct cpuinfo_x86 *c)
 	if (!cpu_feature_enabled(X86_FEATURE_XENPV))
 		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
 
-	/*
-	 * Turn on the Instructions Retired free counter on machines not
-	 * susceptible to erratum #1054 "Instructions Retired Performance
-	 * Counter May Be Inaccurate".
-	 */
-	if (cpu_has(c, X86_FEATURE_IRPERF) &&
-	    (boot_cpu_has(X86_FEATURE_ZEN1) && c->x86_model > 0x2f))
+	/* Enable the Instructions Retired free counter */
+	if (cpu_has(c, X86_FEATURE_IRPERF))
 		msr_set_bit(MSR_K7_HWCR, MSR_K7_HWCR_IRPERF_EN_BIT);
 
 	check_null_seg_clears_base(c);

