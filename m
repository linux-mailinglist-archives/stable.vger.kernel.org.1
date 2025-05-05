Return-Path: <stable+bounces-141655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF34AAB54D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF70188C6ED
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796293A8C24;
	Tue,  6 May 2025 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9tJw32k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A472E6865;
	Mon,  5 May 2025 23:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487053; cv=none; b=C1JMzbFeaFFiSIH6STzx805ZMqIeJ399nGv/5tKu15VLXsL40Aq5XqFs+eb1PkKPoXbQyHOHFe5PwCwAemfXc9hTxLe85OQptNqfE/Kr/Q8ny/1jQu01xYdzjIXiAiawY0ahAC7EfwJLw4WxPps4RGCbDcJ7c+1rbD8n+fgWSiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487053; c=relaxed/simple;
	bh=57lNnKX9xIGUDNrKMw/o8hk/hDUT/qHG4RjOCX3uFHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E9Em6MQY4gJNQmSEoc8tk4h+9af73qi/QeZXTsA6GAZb0Xg79uQiIVOu9laZcVZnA9EuslAcbM3BB5hktsZI2cJw7niLmRFH8eZmo2jQ3KZe/5IohhVyHiGt20veJWSEEitJX77dMnbh3kobiSJz0MWYuVScFuQ4uSxz7M/spjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9tJw32k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00539C4CEE4;
	Mon,  5 May 2025 23:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487052;
	bh=57lNnKX9xIGUDNrKMw/o8hk/hDUT/qHG4RjOCX3uFHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m9tJw32k8Laza5bc13rk0HohHYiSuq+wME5CiQFu56aYpZqrlKF6V/h+MY2Qc1vS/
	 pPtHlS6tUnYHl1r1Tmkl3bAdUnl0ru9AuOoP/lq557KhESlFb/SA8GYdRGX5lBTNo2
	 AK75TbDs9+p8zW3cz5jMQU5Napiby3fw4G+S5EghyPcBy0k1KIJZB3PpXHHpxowi4x
	 BJve1n1/MOl/N4KRey3b/QzZsy+5ZQvctyNB1mCbwuGfNoZjWVnvI7iZtG+D+q/5Eo
	 t0zIb3/IntMZ/IBwayGs9B02btswx99kLtPRG67hUzMH/z1lxtKpEUoGQCrE/ym8yU
	 2SqeoKnk5hDUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Disha Goel <disgoel@linux.vnet.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	mpe@ellerman.id.au,
	kan.liang@linux.intel.com,
	mcgrof@kernel.org,
	peterz@infradead.org,
	coltonlewis@google.com,
	rppt@kernel.org,
	anjalik@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.15 128/153] arch/powerpc/perf: Check the instruction type before creating sample with perf_mem_data_src
Date: Mon,  5 May 2025 19:12:55 -0400
Message-Id: <20250505231320.2695319-128-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index c9fc0edf56b1c..c6d083a82d80a 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2183,6 +2183,10 @@ static struct pmu power_pmu = {
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
@@ -2251,6 +2255,22 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
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
index 027a2add780e8..9ffe3106c9b10 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -275,8 +275,10 @@ void isa207_get_mem_data_src(union perf_mem_data_src *dsrc, u32 flags,
 
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


