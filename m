Return-Path: <stable+bounces-100354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B919EABEC
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E571690BA
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63D4233D70;
	Tue, 10 Dec 2024 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F9lphSr7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6680C233D90
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822832; cv=none; b=rzqWmiT9uFEsohbAK06LnQb5RGswsFQQTrqxl6Fz2h9eqhlCuFf/3m5HVC2jb+8TaIlbJCUpPwKK7k19HKehLiWQZsFVOSIc8Naz8HVQRGXDvN+z+72kE0ghNlxsu1aJdeDR02Fm31JE2PplRJ/11/Aj30P350rOraU5Gy/0fBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822832; c=relaxed/simple;
	bh=mtgNRHzcAeYBtkHcp0Zfu2vOuW6psvKCa56rwu+8xZA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pSeplTiZnasoAX8gc27DEcFGtGjNKeud0L6xMnWMnxxsJ2w2Jh6TyM6IkYz7XEVf2D9WD8pmJEoe2JDiXZbmgjExKZkpHtbkRt4C827VETFQC+t9b7dFjGMf1Whfy4QITdz3uttflCfMyi6EY3DzcrtAqx/XuTjCriI5TY0HQfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F9lphSr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2785C4CEDD;
	Tue, 10 Dec 2024 09:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733822832;
	bh=mtgNRHzcAeYBtkHcp0Zfu2vOuW6psvKCa56rwu+8xZA=;
	h=Subject:To:Cc:From:Date:From;
	b=F9lphSr7oj4e7g5tfOw+y0eAqN33yxWAp0TEq9PMoIJnI7E7+8tgtV6VWmK5QLbux
	 fuh8bbdG7DoKLavEpf8aS5OG1kUI5F11O4dp+/54zDmpAfSt9hwvB9FSl7GvvmrfYD
	 U6gTP782TvyrGcYwEe0TAa0PL2HRcLAk5fasz7JE=
Subject: FAILED: patch "[PATCH] x86/cacheinfo: Delete global num_cache_leaves" failed to apply to 6.6-stable tree
To: ricardo.neri-calderon@linux.intel.com,bp@alien8.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:26:35 +0100
Message-ID: <2024121035-bruising-embody-acc8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9677be09e5e4fbe48aeccb06ae3063c5eba331c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121035-bruising-embody-acc8@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9677be09e5e4fbe48aeccb06ae3063c5eba331c3 Mon Sep 17 00:00:00 2001
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 27 Nov 2024 16:22:47 -0800
Subject: [PATCH] x86/cacheinfo: Delete global num_cache_leaves

Linux remembers cpu_cachinfo::num_leaves per CPU, but x86 initializes all
CPUs from the same global "num_cache_leaves".

This is erroneous on systems such as Meteor Lake, where each CPU has a
distinct num_leaves value. Delete the global "num_cache_leaves" and
initialize num_leaves on each CPU.

init_cache_level() no longer needs to set num_leaves. Also, it never had to
set num_levels as it is unnecessary in x86. Keep checking for zero cache
leaves. Such condition indicates a bug.

  [ bp: Cleanup. ]

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org # 6.3+
Link: https://lore.kernel.org/r/20241128002247.26726-3-ricardo.neri-calderon@linux.intel.com

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 392d09c936d6..e6fa03ed9172 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -178,8 +178,6 @@ struct _cpuid4_info_regs {
 	struct amd_northbridge *nb;
 };
 
-static unsigned short num_cache_leaves;
-
 /* AMD doesn't have CPUID4. Emulate it here to report the same
    information to the user.  This makes some assumptions about the machine:
    L2 not shared, no SMT etc. that is currently true on AMD CPUs.
@@ -717,20 +715,23 @@ void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c)
 
 void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 {
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
 
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
-		num_cache_leaves = find_num_cache_leaves(c);
+		ci->num_leaves = find_num_cache_leaves(c);
 	} else if (c->extended_cpuid_level >= 0x80000006) {
 		if (cpuid_edx(0x80000006) & 0xf000)
-			num_cache_leaves = 4;
+			ci->num_leaves = 4;
 		else
-			num_cache_leaves = 3;
+			ci->num_leaves = 3;
 	}
 }
 
 void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 {
-	num_cache_leaves = find_num_cache_leaves(c);
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
+
+	ci->num_leaves = find_num_cache_leaves(c);
 }
 
 void init_intel_cacheinfo(struct cpuinfo_x86 *c)
@@ -740,21 +741,21 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 	unsigned int new_l1d = 0, new_l1i = 0; /* Cache sizes from cpuid(4) */
 	unsigned int new_l2 = 0, new_l3 = 0, i; /* Cache sizes from cpuid(4) */
 	unsigned int l2_id = 0, l3_id = 0, num_threads_sharing, index_msb;
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
 
 	if (c->cpuid_level > 3) {
-		static int is_initialized;
-
-		if (is_initialized == 0) {
-			/* Init num_cache_leaves from boot CPU */
-			num_cache_leaves = find_num_cache_leaves(c);
-			is_initialized++;
-		}
+		/*
+		 * There should be at least one leaf. A non-zero value means
+		 * that the number of leaves has been initialized.
+		 */
+		if (!ci->num_leaves)
+			ci->num_leaves = find_num_cache_leaves(c);
 
 		/*
 		 * Whenever possible use cpuid(4), deterministic cache
 		 * parameters cpuid leaf to find the cache details
 		 */
-		for (i = 0; i < num_cache_leaves; i++) {
+		for (i = 0; i < ci->num_leaves; i++) {
 			struct _cpuid4_info_regs this_leaf = {};
 			int retval;
 
@@ -790,14 +791,14 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 	 * Don't use cpuid2 if cpuid4 is supported. For P4, we use cpuid2 for
 	 * trace cache
 	 */
-	if ((num_cache_leaves == 0 || c->x86 == 15) && c->cpuid_level > 1) {
+	if ((!ci->num_leaves || c->x86 == 15) && c->cpuid_level > 1) {
 		/* supports eax=2  call */
 		int j, n;
 		unsigned int regs[4];
 		unsigned char *dp = (unsigned char *)regs;
 		int only_trace = 0;
 
-		if (num_cache_leaves != 0 && c->x86 == 15)
+		if (ci->num_leaves && c->x86 == 15)
 			only_trace = 1;
 
 		/* Number of times to iterate */
@@ -991,14 +992,12 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 
 int init_cache_level(unsigned int cpu)
 {
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
 
-	if (!num_cache_leaves)
+	/* There should be at least one leaf. */
+	if (!ci->num_leaves)
 		return -ENOENT;
-	if (!this_cpu_ci)
-		return -EINVAL;
-	this_cpu_ci->num_levels = 3;
-	this_cpu_ci->num_leaves = num_cache_leaves;
+
 	return 0;
 }
 


