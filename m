Return-Path: <stable+bounces-47718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9E28D4DC3
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 16:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130E928459F
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 14:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B0C176245;
	Thu, 30 May 2024 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k8XiSSZW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EQ+qXVOy"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E9E16F0E8;
	Thu, 30 May 2024 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078991; cv=none; b=SEigUmNf/Ne5Ygtnsfd3RKIc1BGKp/Choj/Y12gEP5TQscd4wGj449Z7nFITcP36+d5HZYnFaqAhy1WiYhs+/As1+TeeFHMyOWPVMOIz1O994ZLS/TSUFRgIFJKNjXfTq3PeKc2OsZbF4DWDTUj8pwjoOUG93Yv4MVUprDOd7tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078991; c=relaxed/simple;
	bh=Ma2+AjcMTkp5RLd/ciOGT8prx/Hs5elb2xMQ7KCXs0w=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=d5eOVxLNFIVlynF2hWC1cKOckpj4npB8Qp1Sc6yT3RPuPTKUKB3T6BR3wZ5gd4kLZmjvMWk5zzFnxOfKXxDW1tCyCKWRO/dyVPOIgvLgAaz9F+qsHBIPM8u42k2NucMaoEpgPW1t+lIdEcn+tUC9mkmrThLvUgaCGCsTmM9DV9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k8XiSSZW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EQ+qXVOy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 30 May 2024 14:23:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717078988;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vV/t6fERSzKTZ1gs6ufW5FSStbU7Wr1/KJqbwL6JUuo=;
	b=k8XiSSZWrClnkmcAPNM5LkIB/G0rTppK5txjMp4knRF2eiJWtei0mn+WjzFyiWggBwpvOR
	JANQ28DnZJlBTvK0O9dyeqR8iZkv/CU1kF85QvUIHdGzH9lvj5pWvKnO3sZFc+nFtbaMtQ
	f0MxZA1ulKCGgFsHXPFaD/34vbabBCenmMJ8YaDQ/42zTD7vUEFeiy7I5U736lZLjGXfBZ
	/MF0XtORaeAcK7h9Far2PZgTsw1m350cIGgTIQm2fyrlX+DOyczihU4m+5kgZeIUVHEiBq
	eghs2/yV/zDSu3Hy5iw3l2YFWZBymGNxABrxYEdZyutbIg+x/xfOSAPhjyrNVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717078988;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vV/t6fERSzKTZ1gs6ufW5FSStbU7Wr1/KJqbwL6JUuo=;
	b=EQ+qXVOy09/t5qsR1C3X8uAUOKhw6nHO1IUOrbPbzLlrpsxr0KKdva7JOV3A0FJKcNMYqM
	egU4bZ+JLhmfxJDg==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/cpu: Provide default cache line size if not enumerated
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, osmanx@heusipp.de,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171707898810.10875.17950546903678321366.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b9210e56d71d9deb1ad692e405f6b2394f7baa4d
Gitweb:        https://git.kernel.org/tip/b9210e56d71d9deb1ad692e405f6b2394f7=
baa4d
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 17 May 2024 13:05:34 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 30 May 2024 07:14:27 -07:00

x86/cpu: Provide default cache line size if not enumerated

tl;dr: CPUs with CPUID.80000008H but without CPUID.01H:EDX[CLFSH]
will end up reporting cache_line_size()=3D=3D0 and bad things happen.
Fill in a default on those to avoid the problem.

Long Story:

The kernel dies a horrible death if c->x86_cache_alignment (aka.
cache_line_size() is 0.  Normally, this value is populated from
c->x86_clflush_size.

Right now the code is set up to get c->x86_clflush_size from two
places.  First, modern CPUs get it from CPUID.  Old CPUs that don't
have leaf 0x80000008 (or CPUID at all) just get some sane defaults
from the kernel in get_cpu_address_sizes().

The vast majority of CPUs that have leaf 0x80000008 also get
->x86_clflush_size from CPUID.  But there are oddballs.

Intel Quark CPUs[1] and others[2] have leaf 0x80000008 but don't set
CPUID.01H:EDX[CLFSH], so they skip over filling in ->x86_clflush_size:

	cpuid(0x00000001, &tfms, &misc, &junk, &cap0);
	if (cap0 & (1<<19))
		c->x86_clflush_size =3D ((misc >> 8) & 0xff) * 8;

So they: land in get_cpu_address_sizes() and see that CPUID has level
0x80000008 and jump into the side of the if() that does not fill in
c->x86_clflush_size.  That assigns a 0 to c->x86_cache_alignment, and
hilarity ensues in code like:

        buffer =3D kzalloc(ALIGN(sizeof(*buffer), cache_line_size()),
                         GFP_KERNEL);

To fix this, always provide a sane value for ->x86_clflush_size.

Big thanks to Andy Shevchenko for finding and reporting this and also
providing a first pass at a fix. But his fix was only partial and only
worked on the Quark CPUs.  It would not, for instance, have worked on
the QEMU config.

1. https://raw.githubusercontent.com/InstLatx64/InstLatx64/master/GenuineInte=
l/GenuineIntel0000590_Clanton_03_CPUID.txt
2. You can also get this behavior if you use "-cpu 486,+clzero"
   in QEMU.

[ dhansen: remove 'vp_bits_from_cpuid' reference in changelog
	   because bpetkov brutally murdered it recently. ]

Fixes: fbf6449f84bf ("x86/sev-es: Set x86_virt_bits to the correct value stra=
ight away, instead of a two-phase approach")
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: J=C3=B6rn Heusipp <osmanx@heusipp.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240516173928.3960193-1-andriy.shevchenko@=
linux.intel.com/
Link: https://lore.kernel.org/lkml/5e31cad3-ad4d-493e-ab07-724cfbfaba44@heusi=
pp.de/
Link: https://lore.kernel.org/all/20240517200534.8EC5F33E%40davehans-spike.os=
tc.intel.com
---
 arch/x86/kernel/cpu/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2b170da..373b16b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1070,6 +1070,10 @@ void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 			    cpu_has(c, X86_FEATURE_PSE36))
 				c->x86_phys_bits =3D 36;
 		}
+
+		/* Provide a sane default if not enumerated: */
+		if (!c->x86_clflush_size)
+			c->x86_clflush_size =3D 32;
 	} else {
 		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
=20

