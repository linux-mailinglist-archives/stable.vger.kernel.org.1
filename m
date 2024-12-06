Return-Path: <stable+bounces-99047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C86D9E6E09
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94ADC1882F5D
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C019520103E;
	Fri,  6 Dec 2024 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="itY1J7/b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m5GU1OWQ"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA5201012;
	Fri,  6 Dec 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487851; cv=none; b=sO9whN52F1HA2FNIKCcpebRWJm2oIzGFagBSEUdV7822ctVo8zwfuqkPrD+e0kHGC0UHn0B13rC0nCovkr7cKLWenHKrj2BpLgMUtFhdbUU3NyZPSwsLqqPgT453clbEgdgKABZIBOMLBpnHjs/8g2xG0U7lro0tHRCAttsEeIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487851; c=relaxed/simple;
	bh=Oimg2Lwl9iazcpBkgAjuxoI32E56zVULC+saQMsi2EI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NCq12btkn+HkXMTD3WCgzsex3LmInro2apjWYmx+7gKWuJV6CuQ3AQndUYKotdxBl52Nr3bh+zhAP2SEItuvG/RNUhCB92/zkBvudXMRAV/ZupSDQEURZlkfBle+LzsLvNSCwJI2og9RqAQTGG3jKaXCUOtDuD0tRkjOtp19uSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=itY1J7/b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m5GU1OWQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 12:24:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733487847;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOGkw6kysRZDHPO+Z1CkU1cj3iULhLAIpmaX20abSqw=;
	b=itY1J7/bTKFiDFYXY6SS/rq8tBqgNGkv4Wq+k3xyuwowfsf6onVdHTYXBy51sMCaUGfxOs
	04pS6JQJ55A15IxqnpEymwZ62cBBWKVgQ04pGzKYhZIP6+YStCPiU+Pmj6J4nQmnm76w2l
	JDEnuiZ69wHS0cPCv2rlzu5loBCeFUHioUJXPfIvhSvOtDMaVlDxaN7OPym8use2TuliNb
	N7c1EJebTU7SqH/IV2P/Vyyk9I0RuqTMx0Baaaa50YuyFJllWXR+0d/P0L6h/b7Asthyiw
	3gvS3eF7/ZPidv1mEKV2JGX74o0Mtt0NRiW/T/qvaoOUmx0tlSRokoFQrGvUzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733487847;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOGkw6kysRZDHPO+Z1CkU1cj3iULhLAIpmaX20abSqw=;
	b=m5GU1OWQlFU5G5bchFgzK+E91LtgA7GmCx54kZ8FvDlgrC8wi2YKY8tKgFqPOgeLiMXObY
	Qi7ls8RmejgBCsBQ==
From: "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cacheinfo: Delete global num_cache_leaves
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, 6.3+@tip-bot2.tec.linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241128002247.26726-3-ricardo.neri-calderon@linux.intel.com>
References: <20241128002247.26726-3-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173348784662.412.18271610759755604157.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9677be09e5e4fbe48aeccb06ae3063c5eba331c3
Gitweb:        https://git.kernel.org/tip/9677be09e5e4fbe48aeccb06ae3063c5eba331c3
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Wed, 27 Nov 2024 16:22:47 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 06 Dec 2024 13:13:36 +01:00

x86/cacheinfo: Delete global num_cache_leaves

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
---
 arch/x86/kernel/cpu/cacheinfo.c | 43 +++++++++++++++-----------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 392d09c..e6fa03e 100644
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
 

