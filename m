Return-Path: <stable+bounces-48298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A362C8FE731
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 15:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01301C24AFE
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 13:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDCB195F2B;
	Thu,  6 Jun 2024 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0GviR2A5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0510153821
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679379; cv=none; b=iGTvPTkPYYb6YxctUjOEjV6R39AhuismNKpuStkmBfOn52Awdhz7MeXpy16blNueTkDtIPwy/hezbgF/RZ6IiwOx7E+t4W97udR/os+lmBVcKZ8C5QBTzDSH1XkahSpzor9rZvlPTvlAS+JoZkMHgtReAKbUJ+uD0NoO+bDajVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679379; c=relaxed/simple;
	bh=yvoVg+WE5HnW2Fk8NgOvSkEQSPdOGdZZ23HCXg9Kjho=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FojoSnXi++82lhibU2XluTzCfqpCvfUQV59KQs060nOkm5zN4SAesYRIuXmTQgeyNofIyuza5Q3qnfdVGzysQdX9A3WAb64/D5UNtbK4uHOiyQnoS/FUbylHq9uVyIYYkGw3djZk2v06qxLLpV8MeiBUluUiLOMEWZ5tCGQyQjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0GviR2A5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A34FC3277B;
	Thu,  6 Jun 2024 13:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717679379;
	bh=yvoVg+WE5HnW2Fk8NgOvSkEQSPdOGdZZ23HCXg9Kjho=;
	h=Subject:To:Cc:From:Date:From;
	b=0GviR2A5otmfRaSs7mGc4+CkSdDK5RdQxBpvpuQ5UTVFHxHUoNoGnuXYs7Bg6tjei
	 neCrGQvWYPYIg+fkOT8kd7F2DQVe7DVk7GhQizv02QUluBu0CUkf6BulK2bKSw8mYC
	 D2a6uWhJDyK2TprO6JRB/BjHBcBuSZDvtMuZODlE=
Subject: FAILED: patch "[PATCH] x86/cpu: Provide default cache line size if not enumerated" failed to apply to 6.9-stable tree
To: dave.hansen@linux.intel.com,andriy.shevchenko@linux.intel.com,osmanx@heusipp.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 06 Jun 2024 15:09:38 +0200
Message-ID: <2024060638-unenvied-immovably-70e4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x 2a38e4ca302280fdcce370ba2bee79bac16c4587
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024060638-unenvied-immovably-70e4@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

2a38e4ca3022 ("x86/cpu: Provide default cache line size if not enumerated")
95bfb35269b2 ("x86/cpu: Get rid of an unnecessary local variable in get_cpu_address_sizes()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2a38e4ca302280fdcce370ba2bee79bac16c4587 Mon Sep 17 00:00:00 2001
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 17 May 2024 13:05:34 -0700
Subject: [PATCH] x86/cpu: Provide default cache line size if not enumerated
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

tl;dr: CPUs with CPUID.80000008H but without CPUID.01H:EDX[CLFSH]
will end up reporting cache_line_size()==0 and bad things happen.
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
		c->x86_clflush_size = ((misc >> 8) & 0xff) * 8;

So they: land in get_cpu_address_sizes() and see that CPUID has level
0x80000008 and jump into the side of the if() that does not fill in
c->x86_clflush_size.  That assigns a 0 to c->x86_cache_alignment, and
hilarity ensues in code like:

        buffer = kzalloc(ALIGN(sizeof(*buffer), cache_line_size()),
                         GFP_KERNEL);

To fix this, always provide a sane value for ->x86_clflush_size.

Big thanks to Andy Shevchenko for finding and reporting this and also
providing a first pass at a fix. But his fix was only partial and only
worked on the Quark CPUs.  It would not, for instance, have worked on
the QEMU config.

1. https://raw.githubusercontent.com/InstLatx64/InstLatx64/master/GenuineIntel/GenuineIntel0000590_Clanton_03_CPUID.txt
2. You can also get this behavior if you use "-cpu 486,+clzero"
   in QEMU.

[ dhansen: remove 'vp_bits_from_cpuid' reference in changelog
	   because bpetkov brutally murdered it recently. ]

Fixes: fbf6449f84bf ("x86/sev-es: Set x86_virt_bits to the correct value straight away, instead of a two-phase approach")
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Jörn Heusipp <osmanx@heusipp.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240516173928.3960193-1-andriy.shevchenko@linux.intel.com/
Link: https://lore.kernel.org/lkml/5e31cad3-ad4d-493e-ab07-724cfbfaba44@heusipp.de/
Link: https://lore.kernel.org/all/20240517200534.8EC5F33E%40davehans-spike.ostc.intel.com

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2b170da84f97..e31293c9609f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1075,6 +1075,10 @@ void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 
 		c->x86_virt_bits = (eax >> 8) & 0xff;
 		c->x86_phys_bits = eax & 0xff;
+
+		/* Provide a sane default if not enumerated: */
+		if (!c->x86_clflush_size)
+			c->x86_clflush_size = 32;
 	}
 
 	c->x86_cache_bits = c->x86_phys_bits;


