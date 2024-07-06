Return-Path: <stable+bounces-58172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8599294A4
	for <lists+stable@lfdr.de>; Sat,  6 Jul 2024 17:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CDC1C2176C
	for <lists+stable@lfdr.de>; Sat,  6 Jul 2024 15:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9823482D3;
	Sat,  6 Jul 2024 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KNCGaxOo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VTYZRjwp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56141E877
	for <stable@vger.kernel.org>; Sat,  6 Jul 2024 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720280774; cv=none; b=kVB19uE8oUojRjvJv8G+8tMim3Pe7d/LClSvIcZ9ngILrl/LF7fAJSNaeQd7vowarO+6KspDSnz1S99+IqLhHt9GIC/53bk9CwZeBN1paiNLazkDxhpzR2REwE5Lgd09S5Ei11oJI0wfMfMfclzNxjbVwTgZtHyunDshf99PqJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720280774; c=relaxed/simple;
	bh=qUxYaiHBLpTy4rar3gA/XUsfMiAvBFJfdRdLmQ1ZLcM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qu7ljYBa2VfkTurCQ8+1a3OnXI2Y89bHEf+uShG3ZmQf509rZjqhOLvdOjYqiNvgRjYXXbyjk9AVU47SjgljB/hvahKCAQnV4HjY5CH4CQmKRMjKAhanGpWTPPsfG7rfpavscSn65t8SvbE//z5NvcZVJyOKOnYgxA+FqxYoNM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KNCGaxOo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VTYZRjwp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720280770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2GRlsmaFx99DhQFyXRIB/LXolfTscbRNazCBWesbME0=;
	b=KNCGaxOo0aNvQLcQ6iwSbft1UWFr2YnFsgjqe5a3D1jx7utN7Jhm7p9PEMpdVwgJt/orXb
	u864LTusAFoKuW7DFV05lb9eQOhqOalbk95P75Upj3m9fWy0L21N2dxTkI4YoWA5hqqqaE
	s+oSa3BK/XhOF9S1W5qeH2bP3Xaa5D42oNveYiPX9K6mkj0uA2ZF6NQMfVh0wadodNmVyh
	FJQe5qUeZkdN4VqSkRfigmdmS/a253RKHFA7I7XXMSqcSmFC/rtXhZV/xOWEv4PPvjho08
	8bmRijdD7+fely1ecIdafeHGosq5yuGAlrOSTf3iu3mbEbdjOx+8rkwJeyEXQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720280770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2GRlsmaFx99DhQFyXRIB/LXolfTscbRNazCBWesbME0=;
	b=VTYZRjwp1I/dhbhgxeIFcnb5QKa7Cf/M4vSho3ruOeGG7d52lZ0xQ5agl7xeLzRaNy2MCg
	ighAbojOsL4ZisCw==
To: gregkh@linuxfoundation.org, chenhuacai@kernel.org, chenhuacai@loongson.cn
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6.y] cpu: Fix broken cmdline "nosmp" and "maxcpus=0"
In-Reply-To: <2024070154-legged-throwaway-bd6a@gregkh>
References: <2024070154-legged-throwaway-bd6a@gregkh>
Date: Sat, 06 Jul 2024 17:46:08 +0200
Message-ID: <87sewmwmkf.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


From: Huacai Chen <chenhuacai@kernel.org>

commit 6ef8eb5125722c241fd60d7b0c872d5c2e5dd4ca upstream.

After the rework of "Parallel CPU bringup", the cmdline "nosmp" and
"maxcpus=0" parameters are not working anymore. These parameters set
setup_max_cpus to zero and that's handed to bringup_nonboot_cpus().

The code there does a decrement before checking for zero, which brings it
into the negative space and brings up all CPUs.

Add a zero check at the beginning of the function to prevent this.

[ tglx: Massaged change log ]

Fixes: 18415f33e2ac4ab382 ("cpu/hotplug: Allow "parallel" bringup up to CPUHP_BP_KICK_AP_STATE")
Fixes: 06c6796e0304234da6 ("cpu/hotplug: Fix off by one in cpuhp_bringup_mask()")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240618081336.3996825-1-chenhuacai@loongson.cn
---
 kernel/cpu.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1907,6 +1907,9 @@ static inline bool cpuhp_bringup_cpus_pa
 
 void __init bringup_nonboot_cpus(unsigned int setup_max_cpus)
 {
+	if (!setup_max_cpus)
+		return;
+
 	/* Try parallel bringup optimization if enabled */
 	if (cpuhp_bringup_cpus_parallel(setup_max_cpus))
 		return;

