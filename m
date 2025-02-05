Return-Path: <stable+bounces-112342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD43A28C41
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9C61686C2
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245E0143759;
	Wed,  5 Feb 2025 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XIQy3oy8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D443C127E18;
	Wed,  5 Feb 2025 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763246; cv=none; b=H52gil/wiqK3YSgCne6AJ4vm+3yehTsRjClzPDhsCPH91RMWCdHoQWNUcEKgzhFD0ibIjOqxwy3ORbU+Mo1m2wb3jcNoJbY5Axh6x/HhSxChoAkpb6AVH6puEX0KNIPyncA0Z8PQQSQJps6CfDdQl2X3o9ZTUtG/a3SCCq8JRDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763246; c=relaxed/simple;
	bh=RoCYumhay88xy+XIRxGLvRC8x+lzZbuKFXj37k5UBfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVqiGRNpyjel77opUqLXS0EmDpiNBxW/telOnF3OLU7KnCyfHQV+u21xLW1BfPmMN80IcAD8A6OaowkURkOWa2CEaMDWAfTF4/AdC9LHzH5aX74Uu5TUWjYf80C6Yi/eCbgI6Ip2dgBQYI2HMj6A9hcRdSjWwTWFA+hUPIjfusI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XIQy3oy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CE9C4CEDD;
	Wed,  5 Feb 2025 13:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738763246;
	bh=RoCYumhay88xy+XIRxGLvRC8x+lzZbuKFXj37k5UBfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XIQy3oy892Wi0Im8PMqNziRg/eG2zJaAkDoolbLwTzTbkuPm07zpl4VawijTtE4Nn
	 967RyRboRPUq/c/tjwqnRKTyyY/NZgJdWFcRmw+VDYN+Mvle9LZoyFksGmKE/5kPId
	 E1siixUiXoJQXyTLe+zoH7jq298Cb8qFfr/W2mkQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 019/393] sched/topology: Rename DIE domain to PKG
Date: Wed,  5 Feb 2025 14:38:58 +0100
Message-ID: <20250205134421.033475781@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit f577cd57bfaa889cf0718e30e92c08c7f78c9d85 ]

While reworking the x86 topology code Thomas tripped over creating a 'DIE' domain
for the package mask. :-)

Since these names are CONFIG_SCHED_DEBUG=y only, rename them to make the
name less ambiguous.

[ Shrikanth Hegde: rename on s390 as well. ]
[ Valentin Schneider: also rename it in the comments. ]
[ mingo: port to recent kernels & find all remaining occurances. ]

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Valentin Schneider <vschneid@redhat.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20230712141056.GI3100107@hirez.programming.kicks-ass.net
Stable-dep-of: e1bc02646527 ("x86/topology: Use x86_sched_itmt_flags for PKG domain unconditionally")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/smp.c   | 4 ++--
 arch/s390/kernel/topology.c | 2 +-
 arch/x86/kernel/smpboot.c   | 4 ++--
 kernel/sched/fair.c         | 2 +-
 kernel/sched/topology.c     | 8 ++++----
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5826f5108a124..4e4870031265c 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1051,7 +1051,7 @@ static struct sched_domain_topology_level powerpc_topology[] = {
 #endif
 	{ shared_cache_mask, powerpc_shared_cache_flags, SD_INIT_NAME(CACHE) },
 	{ cpu_mc_mask, SD_INIT_NAME(MC) },
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ cpu_cpu_mask, SD_INIT_NAME(PKG) },
 	{ NULL, },
 };
 
@@ -1595,7 +1595,7 @@ static void add_cpu_to_masks(int cpu)
 	/* Skip all CPUs already part of current CPU core mask */
 	cpumask_andnot(mask, cpu_online_mask, cpu_core_mask(cpu));
 
-	/* If chip_id is -1; limit the cpu_core_mask to within DIE*/
+	/* If chip_id is -1; limit the cpu_core_mask to within PKG */
 	if (chip_id == -1)
 		cpumask_and(mask, mask, cpu_cpu_mask(cpu));
 
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 68adf1de8888b..66bda6a8f918c 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -522,7 +522,7 @@ static struct sched_domain_topology_level s390_topology[] = {
 	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
 	{ cpu_book_mask, SD_INIT_NAME(BOOK) },
 	{ cpu_drawer_mask, SD_INIT_NAME(DRAWER) },
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ cpu_cpu_mask, SD_INIT_NAME(PKG) },
 	{ NULL, },
 };
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ce77dac9a0202..e4781e7496f6f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -641,13 +641,13 @@ static void __init build_sched_topology(void)
 	};
 #endif
 	/*
-	 * When there is NUMA topology inside the package skip the DIE domain
+	 * When there is NUMA topology inside the package skip the PKG domain
 	 * since the NUMA domains will auto-magically create the right spanning
 	 * domains based on the SLIT.
 	 */
 	if (!x86_has_numa_in_package) {
 		x86_topology[i++] = (struct sched_domain_topology_level){
-			cpu_cpu_mask, x86_die_flags, SD_INIT_NAME(DIE)
+			cpu_cpu_mask, x86_die_flags, SD_INIT_NAME(PKG)
 		};
 	}
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cd9b411706b52..726fa69c4d88b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9782,7 +9782,7 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
  * can only do it if @group is an SMT group and has exactly on busy CPU. Larger
  * imbalances in the number of CPUS are dealt with in find_busiest_group().
  *
- * If we are balancing load within an SMT core, or at DIE domain level, always
+ * If we are balancing load within an SMT core, or at PKG domain level, always
  * proceed.
  *
  * Return: true if @env::dst_cpu can do with asym_packing load balance. False
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 3a13cecf17740..2ed884bb36213 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1117,7 +1117,7 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
  *
  *  - Simultaneous multithreading (SMT)
  *  - Multi-Core Cache (MC)
- *  - Package (DIE)
+ *  - Package (PKG)
  *
  * Where the last one more or less denotes everything up to a NUMA node.
  *
@@ -1139,13 +1139,13 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
  *
  * CPU   0   1   2   3   4   5   6   7
  *
- * DIE  [                             ]
+ * PKG  [                             ]
  * MC   [             ] [             ]
  * SMT  [     ] [     ] [     ] [     ]
  *
  *  - or -
  *
- * DIE  0-7 0-7 0-7 0-7 0-7 0-7 0-7 0-7
+ * PKG  0-7 0-7 0-7 0-7 0-7 0-7 0-7 0-7
  * MC	0-3 0-3 0-3 0-3 4-7 4-7 4-7 4-7
  * SMT  0-1 0-1 2-3 2-3 4-5 4-5 6-7 6-7
  *
@@ -1679,7 +1679,7 @@ static struct sched_domain_topology_level default_topology[] = {
 #ifdef CONFIG_SCHED_MC
 	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
 #endif
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ cpu_cpu_mask, SD_INIT_NAME(PKG) },
 	{ NULL, },
 };
 
-- 
2.39.5




