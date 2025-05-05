Return-Path: <stable+bounces-141569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB25AAB76A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF3C1C26687
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F18247DCC7;
	Tue,  6 May 2025 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gwy/OXNH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F513881DD;
	Mon,  5 May 2025 23:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486742; cv=none; b=C8VQk7WA/N8Pwu9Rkn2eEDLJpgK2cku+1kD/TrjQLI4xykFNaxLuDkA9EaQXq2JF8r0a4zF+nc+K0op7ZfmMYjoCV8D/4FHUg4UTbC2sQAq5C27lbwzHcHpAVnHxdXoAx6M0dwLEhMaN8ztXdqG3OGk+z0E/WkhEiw+y3lSLne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486742; c=relaxed/simple;
	bh=yev//LYn1mTeuMs8geXcTVKFvfyOrETa2JJGkBS9DsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j6w2rm6HzJjjeinm9ZNUcvoxsxZ0p5cUEaB3lKJEekor7prGRH5U7xdzSbLFcXwk7FXqKzKLHPvaNojF9HN+cxJM+FSoY6Po/PGLg/w6/W2GLTd1iPuMdf5TvHoOSuv5JdygqvGIlqETkOSMOOHNeGo19X2AuN7OpnwftAD+3Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gwy/OXNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF51C4CEE4;
	Mon,  5 May 2025 23:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486742;
	bh=yev//LYn1mTeuMs8geXcTVKFvfyOrETa2JJGkBS9DsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gwy/OXNHvuKm99v7q/5DuJzS1I5vDrHRZF2rkbIMSaDyWCODZC05qnFpIPdwfIi3M
	 3gWD4wgb/LbEP0tYJTyhkIaDP+w6TGMVnC/wefMYba86TynHuds6mZebOfeAK5nruk
	 LehfADRvSYqbnyH1PTc+1mZ3e2NEEH+RD4oZ3HlLiygE1qDZkVUve/QJxLuzmPnkp5
	 3/i+6NRdUpXgcOwcf+HuzCQ6MABTdwR2+fJtPfck4RHPNNN+RJCeigl4jf7j+v+Z2q
	 djGjzk/qpN6nM2rBmNJPyO61b1QkGqBLcXgamXrHXNnL6QdRVLP3S+rkDdP1tVlvfj
	 O6KgRiEA5xqBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Disha Goel <disgoel@linux.vnet.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	mpe@ellerman.id.au,
	kan.liang@linux.intel.com,
	anjalik@linux.ibm.com,
	coltonlewis@google.com,
	rppt@kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.1 179/212] arch/powerpc/perf: Check the instruction type before creating sample with perf_mem_data_src
Date: Mon,  5 May 2025 19:05:51 -0400
Message-Id: <20250505230624.2692522-179-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

[ Upstream commit 2ffb26afa64261139e608bf087a0c1fe24d76d4d ]

perf mem report aborts as below sometimes (during some corner
case) in powerpc:

   # ./perf mem report 1>out
   *** stack smashing detected ***: terminated
   Aborted (core dumped)

The backtrace is as below:
   __pthread_kill_implementation ()
   raise ()
   abort ()
   __libc_message
   __fortify_fail
   __stack_chk_fail
   hist_entry.lvl_snprintf
   __sort__hpp_entry
   __hist_entry__snprintf
   hists.fprintf
   cmd_report
   cmd_mem

Snippet of code which triggers the issue
from tools/perf/util/sort.c

   static int hist_entry__lvl_snprintf(struct hist_entry *he, char *bf,
                                    size_t size, unsigned int width)
   {
        char out[64];

        perf_mem__lvl_scnprintf(out, sizeof(out), he->mem_info);
        return repsep_snprintf(bf, size, "%-*s", width, out);
   }

The value of "out" is filled from perf_mem_data_src value.
Debugging this further showed that for some corner cases, the
value of "data_src" was pointing to wrong value. This resulted
in bigger size of string and causing stack check fail.

The perf mem data source values are captured in the sample via
isa207_get_mem_data_src function. The initial check is to fetch
the type of sampled instruction. If the type of instruction is
not valid (not a load/store instruction), the function returns.

Since 'commit e16fd7f2cb1a ("perf: Use sample_flags for data_src")',
data_src field is not initialized by the perf_sample_data_init()
function. If the PMU driver doesn't set the data_src value to zero if
type is not valid, this will result in uninitailised value for data_src.
The uninitailised value of data_src resulted in stack check fail
followed by abort for "perf mem report".

When requesting for data source information in the sample, the
instruction type is expected to be load or store instruction.
In ISA v3.0, due to hardware limitation, there are corner cases
where the instruction type other than load or store is observed.
In ISA v3.0 and before values "0" and "7" are considered reserved.
In ISA v3.1, value "7" has been used to indicate "larx/stcx".
Drop the sample if instruction type has reserved values for this
field with a ISA version check. Initialize data_src to zero in
isa207_get_mem_data_src if the instruction type is not load/store.

Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20250121131621.39054-1-atrajeev@linux.vnet.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/perf/core-book3s.c   | 20 ++++++++++++++++++++
 arch/powerpc/perf/isa207-common.c |  4 +++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index e3c31c771ce91..470d7715ecf4b 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2229,6 +2229,10 @@ static struct pmu power_pmu = {
 #define PERF_SAMPLE_ADDR_TYPE  (PERF_SAMPLE_ADDR |		\
 				PERF_SAMPLE_PHYS_ADDR |		\
 				PERF_SAMPLE_DATA_PAGE_SIZE)
+
+#define SIER_TYPE_SHIFT	15
+#define SIER_TYPE_MASK	(0x7ull << SIER_TYPE_SHIFT)
+
 /*
  * A counter has overflowed; update its count and record
  * things if requested.  Note that interrupts are hard-disabled
@@ -2297,6 +2301,22 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 	    is_kernel_addr(mfspr(SPRN_SIAR)))
 		record = 0;
 
+	/*
+	 * SIER[46-48] presents instruction type of the sampled instruction.
+	 * In ISA v3.0 and before values "0" and "7" are considered reserved.
+	 * In ISA v3.1, value "7" has been used to indicate "larx/stcx".
+	 * Drop the sample if "type" has reserved values for this field with a
+	 * ISA version check.
+	 */
+	if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
+			ppmu->get_mem_data_src) {
+		val = (regs->dar & SIER_TYPE_MASK) >> SIER_TYPE_SHIFT;
+		if (val == 0 || (val == 7 && !cpu_has_feature(CPU_FTR_ARCH_31))) {
+			record = 0;
+			atomic64_inc(&event->lost_samples);
+		}
+	}
+
 	/*
 	 * Finally record data if requested.
 	 */
diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 56301b2bc8ae8..031a2b63c171d 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -321,8 +321,10 @@ void isa207_get_mem_data_src(union perf_mem_data_src *dsrc, u32 flags,
 
 	sier = mfspr(SPRN_SIER);
 	val = (sier & ISA207_SIER_TYPE_MASK) >> ISA207_SIER_TYPE_SHIFT;
-	if (val != 1 && val != 2 && !(val == 7 && cpu_has_feature(CPU_FTR_ARCH_31)))
+	if (val != 1 && val != 2 && !(val == 7 && cpu_has_feature(CPU_FTR_ARCH_31))) {
+		dsrc->val = 0;
 		return;
+	}
 
 	idx = (sier & ISA207_SIER_LDST_MASK) >> ISA207_SIER_LDST_SHIFT;
 	sub_idx = (sier & ISA207_SIER_DATA_SRC_MASK) >> ISA207_SIER_DATA_SRC_SHIFT;
-- 
2.39.5


