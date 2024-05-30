Return-Path: <stable+bounces-47711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCC08D4CDF
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 15:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65559282FE4
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 13:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E69D17CA16;
	Thu, 30 May 2024 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mXRaK+dv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AKSEw11s"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4821617107B;
	Thu, 30 May 2024 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076166; cv=none; b=ETEx4w/H7E2e/0/NfVuT9AQiFZEkYoN59V/ZPUimW+XP84FdwURkZ2EdeP6V7z5NiU+7Tcp9LgEX+XchKE6LyR7Xc7zDFUXU4qW6WAfVaq698/F9cSZvZIn+FQII5pMXHmOyWjrzVHLAfZuSNkop4ArmoYUjdSRH2sV4FBGCSZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076166; c=relaxed/simple;
	bh=HTcEgZPhvNIqb5QSFsqU4J//bVvYGx934btYPhodD+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H9u3MlFMSks+I4HcpHuDuPuFhENWGt9d3EMXO5kMe4apY9xl2LDXYNumbegOx1IQii0Phstxhlsotd6L8/Wz5n4xacnXxARYad51wgZ55421Au5P+6Us9sSvdIsZLwdTszX+hJiPcZq5fpzEG/2B+W9nyVfS97llf8OZWSMF5ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mXRaK+dv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AKSEw11s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717076157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UKb7c3hZZ1sIQ6Jxj+rYmCRbrY2s6dn/gQHDJs1x228=;
	b=mXRaK+dvM0pd+6847+YJ2bz6M7XvyjYbBWAiMhE/x3zeStW2CtVORfRkhiabrKeoVBbVk7
	94eQB/gcL0mlrd7jp4aOdo6e7KuZQ17YJcNXjarAOzXUfzdymzK/zkU/4ho/9e8Vgreve9
	/+LyRoRYg4BFRProroyS85/VTwuQfkRtk0zMinXT1ksDLFO3G0P4UC5eBLCHS9tae5X2bm
	z0ZjPY96JiciZbVv+pFiD5fNjyWvqCVMCCmjckTH0AW0af/A7ZieysMWr7O4dNAlESop1N
	5YbRu2d+Z7FSe7SPUFkyz5a3Iq9laWk+JRlj9S3/uRD1v3Sio/spr3OrFifdkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717076157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UKb7c3hZZ1sIQ6Jxj+rYmCRbrY2s6dn/gQHDJs1x228=;
	b=AKSEw11srme/Q7fBd1EHmHjfHHOeDEnQwOkN40pAnYODx2auL9TKjHTN6XrLd8lz26a4Bh
	zw3AQrK9lhlRpyCQ==
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
 stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Kernel 6.9 regression: X86: Bogus messages from topology detection
In-Reply-To: <76b1e0b9-26ae-4915-920d-9093f057796b@googlemail.com>
References: <877cffcs7h.ffs@tglx>
 <16cd76b1-a512-4a7b-a304-5e4e31af3c8a@googlemail.com>
 <ce3abe01-4c37-416e-a5ed-25703318318a@googlemail.com>
 <87zfs78zxq.ffs@tglx>
 <76b1e0b9-26ae-4915-920d-9093f057796b@googlemail.com>
Date: Thu, 30 May 2024 15:35:55 +0200
Message-ID: <87r0dj8ls4.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Peter!

On Thu, May 30 2024 at 12:06, Peter Schneider wrote:
> Am 30.05.24 um 10:30 schrieb Thomas Gleixner:
>
>> Can you please apply the debug patch below ad provide the full dmesg
>> after boot?
>
> Here you go... The patch applied cleanly against 6.9.3, which I saw
> was just released by Greg, so I used that. If you want, I can repeat
> the test against 6.9.2, too.

.3 is fine

> Please note: to be able to boot any kernel >= 6.8.4 on my machine, I also had to apply 
> this patch by Martin Petersen, fixing another (unrelated SCSI) regression I reported some 
> time ago, see here:
>
> https://lore.kernel.org/all/20240521023040.2703884-1-martin.petersen@oracle.com/
>
> But I think these two issues are not connected in any way. It was during testing the above 
> patch by Martin that I noticed this new issue in 6.9 BTW.

Right. It's a seperate problem.

> I have attached resulting file dmesg_6.9.3-dirty_Bad_wDebugInfo.txt,
> and I hope you can make some sense of it.

It's exactly what I expected but it does not make any sense at all.

>     [    0.000000] Legacy: 2 5 5

So that means that during early boot where the topology parameters are
decoded from CPUID the CPUID evaluation code sees that the maximum
supported CPUID leaf is 0x02 and it therefore reads complete non-sense.

Later on when the full CPUID evaluation happens it sees the full space
and uses leaf 0xb.

>     [    1.687649] L:b 0 0 S:1 N:2 T:1
>     [    1.687652] D: 0
>     [    1.687653] L:b 1 1 S:5 N:24 T:2
>     [    1.687655] D: 1
>     [    1.687656] L:b 2 2 S:0 N:0 T:0
>     [    1.687658] [Firmware Bug]: CPU0: Topology domain 0 shift 1 != 5

And this obviously sees the proper numbers and complains about the
inconsistency.

So something on this CPU is broken. The same problem exists on all APs:

>     [    1.790035] .... node  #0, CPUs:        #4
>     [    1.790312] .... node  #1, CPUs:   #12 #16
>     [    0.011992] Legacy: 2 5 5
>     [    0.011992] Legacy: 2 5 5
>     [    0.011992] Legacy: 2 5 5
>     [    0.011992] Legacy: 2 5 5
      .....

Now the million-dollar question is what unlocks CPUID to read the proper
value of EAX of leaf 0. All I could come up with is to sprinkle a dozen
of printks into that code. Updated debug patch below.

Thanks,

        tglx
---
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -65,6 +65,7 @@ static void parse_legacy(struct topo_sca
 		cores <<= smt_shift;
 	}
 
+	pr_info("Legacy: %u %u %u\n", c->cpuid_level, smt_shift, core_shift);
 	topology_set_dom(tscan, TOPO_SMT_DOMAIN, smt_shift, 1U << smt_shift);
 	topology_set_dom(tscan, TOPO_CORE_DOMAIN, core_shift, cores);
 }
--- a/arch/x86/kernel/cpu/topology_ext.c
+++ b/arch/x86/kernel/cpu/topology_ext.c
@@ -72,6 +72,9 @@ static inline bool topo_subleaf(struct t
 
 	cpuid_subleaf(leaf, subleaf, &sl);
 
+	pr_info("L:%0x %0x %0x S:%u N:%u T:%u\n", leaf, subleaf, sl.level, sl.x2apic_shift,
+		sl.num_processors, sl.type);
+
 	if (!sl.num_processors || sl.type == INVALID_TYPE)
 		return false;
 
@@ -97,6 +100,7 @@ static inline bool topo_subleaf(struct t
 			     leaf, subleaf, tscan->c->topo.initial_apicid, sl.x2apic_id);
 	}
 
+	pr_info("D: %u\n", dom);
 	topology_set_dom(tscan, dom, sl.x2apic_shift, sl.num_processors);
 	return true;
 }
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1584,22 +1584,30 @@ static void __init early_identify_cpu(st
 	/* cyrix could have cpuid enabled via c_identify()*/
 	if (have_cpuid_p()) {
 		cpu_detect(c);
+		pr_info("MAXL1: %x\n", cpuid_eax(0));
 		get_cpu_vendor(c);
+		pr_info("MAXL2: %x\n", cpuid_eax(0));
 		get_cpu_cap(c);
+		pr_info("MAXL3: %x\n", cpuid_eax(0));
 		setup_force_cpu_cap(X86_FEATURE_CPUID);
 		get_cpu_address_sizes(c);
+		pr_info("MAXL4: %x\n", cpuid_eax(0));
 		cpu_parse_early_param();
+		pr_info("MAXL5: %x\n", cpuid_eax(0));
 
 		cpu_init_topology(c);
+		pr_info("MAXL6: %x\n", cpuid_eax(0));
 
 		if (this_cpu->c_early_init)
 			this_cpu->c_early_init(c);
+		pr_info("MAXL7: %x\n", cpuid_eax(0));
 
 		c->cpu_index = 0;
 		filter_cpuid_features(c, false);
 
 		if (this_cpu->c_bsp_init)
 			this_cpu->c_bsp_init(c);
+		pr_info("MAXL8: %x\n", cpuid_eax(0));
 	} else {
 		setup_clear_cpu_cap(X86_FEATURE_CPUID);
 		get_cpu_address_sizes(c);
@@ -1797,9 +1805,12 @@ static void identify_cpu(struct cpuinfo_
 #ifdef CONFIG_X86_VMX_FEATURE_NAMES
 	memset(&c->vmx_capability, 0, sizeof(c->vmx_capability));
 #endif
+	pr_info("MAXLG1: %x\n", cpuid_eax(0));
 
 	generic_identify(c);
 
+	pr_info("MAXLG2: %x\n", cpuid_eax(0));
+
 	cpu_parse_topology(c);
 
 	if (this_cpu->c_identify)

