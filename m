Return-Path: <stable+bounces-47771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6748D5CBE
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 10:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1710E1F21B3D
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 08:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E762A14F9F2;
	Fri, 31 May 2024 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rSJBv/ls";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lOo9+g6/"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA2114F9E0;
	Fri, 31 May 2024 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144398; cv=none; b=SUOQj7R0NOXsso++YcColWzdi8ZyaETdyTtD8z8nHAkaYqqrq8OpJ0ZLkChMB6oq+k/D2zLtV/pUrOJpPF1CnEbkLDY2TQAJGLdT9ZHLzEzk5OskmYbYfz80+ySFFgJrcZT6UmycJwmq3fjvUzovQFZGYw5Dgdand4cUSd3QTaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144398; c=relaxed/simple;
	bh=njIJoFbUM8tjWR9wdSeunyUj5PTFVaktdfIPubrxOgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ekYxRZm3WHwb7VqsZQ0z3UaCvUO34L9SwrVaGhehyqr4lNEhP619LaC5t7NBDZQgRs1DnXbC/0rAT3IKNgtKxoUFplNzBldb3sPhScW+trhiL0q7TM3OwhvhBTYjlOkDgmFakAGNUP3CICukF8ORTvxB7UKa8eyJUrdDMDalGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rSJBv/ls; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lOo9+g6/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717144395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVzSKxLXKf68zlDN1BzEQlzWkxBMa+E5lMwzFjhWKJM=;
	b=rSJBv/lsdimuSQWEldf9g+/kIfgE9+MCjk6m2QHnIo8eA02I52T5CYOebUkOBlzyobPapt
	hA7hdIGaRk8AUEdhE+kDXxf6g5N8SZdLhn8Omtysq7kdR72VmmzHO3SJj9261lal0m96ob
	ljLpAXjUjd2Lf1C4gV4dH6eFyg0xf/m5AGlrW1w0pV2DMhJSrOy7rvg+x4arFbUyHRY+ye
	Ss67cx+PE2kaZKRUNVUWeJ6XccOO4ldjzzYBFBcGuxFH3uvIMhDE8ttTVNIXrWHbjw/mBM
	0Nc4Wq+bPzd+Z8E/EGBHpYYdJzepSEE0aiXGjOSe0LzSi6NnninLHlutohRUxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717144395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVzSKxLXKf68zlDN1BzEQlzWkxBMa+E5lMwzFjhWKJM=;
	b=lOo9+g6/gYv2KqK0kFmabK/mdKyOj187rsSHi9ZexJVZvASqsNzrq67sb945s+UKrubjbL
	2ROFuizn0DHBoPCg==
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
 stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Kernel 6.9 regression: X86: Bogus messages from topology detection
In-Reply-To: <bd7ff2f3-bf2c-4431-9848-8eb41e7422c6@googlemail.com>
References: <877cffcs7h.ffs@tglx>
 <16cd76b1-a512-4a7b-a304-5e4e31af3c8a@googlemail.com>
 <ce3abe01-4c37-416e-a5ed-25703318318a@googlemail.com>
 <87zfs78zxq.ffs@tglx>
 <76b1e0b9-26ae-4915-920d-9093f057796b@googlemail.com>
 <87r0dj8ls4.ffs@tglx> <87o78n8fe2.ffs@tglx> <87le3r8dyw.ffs@tglx>
 <bd7ff2f3-bf2c-4431-9848-8eb41e7422c6@googlemail.com>
Date: Fri, 31 May 2024 10:33:11 +0200
Message-ID: <87ikyu8jp4.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Peter!

On Fri, May 31 2024 at 08:52, Peter Schneider wrote:
> Am 30.05.2024 um 18:24 schrieb Thomas Gleixner:
> With that patch applied, I now get a build error:
>
> arch/x86/xen/enlighten_pv.c: In Funktion =C2=BBxen_start_kernel=C2=AB:
> arch/x86/xen/enlighten_pv.c:1388:9: Fehler: Implizite Deklaration der Fun=
ktion=20
> =C2=BBget_cpu_cap=C2=AB; meinten Sie =C2=BBset_cpu_cap=C2=AB? [-Werror=3D=
implicit-function-declaration]
>   1388 |         get_cpu_cap(&boot_cpu_data);

Bah. Updated patch below.

Thanks,

        tglx
---
Subject: x86/topology/intel: Unlock CPUID before evaluating anything
From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 30 May 2024 17:29:18 +0200

Intel CPUs have a MSR bit to limit CPUID enumeration to leaf two. If this
bit is set by the BIOS then CPUID evaluation including topology enumeration
does not work correctly as the evaluation code does not try to analyze any
leaf greater than two.

This went unnoticed before because the original topology code just repeated
evaluation several times and managed to overwrite the initial limited
information with the correct one later. The new evaluation code does it
once and therefore ends up with the limited and wrong information.

Cure this by unlocking CPUID right before evaluating anything which depends
on the maximum CPUID leaf being greater than two instead of rereading stuff
after unlock.

Fixes: 22d63660c35e ("x86/cpu: Use common topology code for Intel")
Reported-by: Peter Schneider <pschneider1968@googlemail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/common.c |    3 ++-
 arch/x86/kernel/cpu/intel.c  |   25 ++++++++++++++++---------
 2 files changed, 18 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1585,6 +1585,7 @@ static void __init early_identify_cpu(st
 	if (have_cpuid_p()) {
 		cpu_detect(c);
 		get_cpu_vendor(c);
+		intel_unlock_cpuid_leafs(c);
 		get_cpu_cap(c);
 		setup_force_cpu_cap(X86_FEATURE_CPUID);
 		get_cpu_address_sizes(c);
@@ -1744,7 +1745,7 @@ static void generic_identify(struct cpui
 	cpu_detect(c);
=20
 	get_cpu_vendor(c);
-
+	intel_unlock_cpuid_leafs(c);
 	get_cpu_cap(c);
=20
 	get_cpu_address_sizes(c);
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -269,19 +269,26 @@ static void detect_tme_early(struct cpui
 	c->x86_phys_bits -=3D keyid_bits;
 }
=20
+void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c)
+{
+	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_INTEL)
+		return;
+
+	if (c->x86 < 6 || (c->x86 =3D=3D 6 && c->x86_model < 0xd))
+		return;
+
+	/*
+	 * The BIOS can have limited CPUID to leaf 2, which breaks feature
+	 * enumeration. Unlock it and update the maximum leaf info.
+	 */
+	if (msr_clear_bit(MSR_IA32_MISC_ENABLE, MSR_IA32_MISC_ENABLE_LIMIT_CPUID_=
BIT) > 0)
+		c->cpuid_level =3D cpuid_eax(0);
+}
+
 static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
=20
-	/* Unmask CPUID levels if masked: */
-	if (c->x86 > 6 || (c->x86 =3D=3D 6 && c->x86_model >=3D 0xd)) {
-		if (msr_clear_bit(MSR_IA32_MISC_ENABLE,
-				  MSR_IA32_MISC_ENABLE_LIMIT_CPUID_BIT) > 0) {
-			c->cpuid_level =3D cpuid_eax(0);
-			get_cpu_cap(c);
-		}
-	}
-
 	if ((c->x86 =3D=3D 0xf && c->x86_model >=3D 0x03) ||
 		(c->x86 =3D=3D 0x6 && c->x86_model >=3D 0x0e))
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);

