Return-Path: <stable+bounces-140800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F0AAAAF66
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A57A3A9A47
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D641E220F4E;
	Mon,  5 May 2025 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfhAuRdg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14737AACB;
	Mon,  5 May 2025 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486292; cv=none; b=hrOqvzFtZ7VZTF2P8kV+rlMSCt69kN6vE/rL/1M9HyOI78nc+f/QAP2mYQYEf64N6zlSb+bXlSDNJha5Uutns8cGEpcfWi84PPIyg0Ss6kmPzm0QJS4V7/DPsG/rI9ntWujbrXCeEe0P5M+bHlRRF7Kz3WXQj+q7s3oyZINnV5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486292; c=relaxed/simple;
	bh=nGuTksRyk8SNbNMoyJtl3SqnGwxC7KZdWOb2kpuzg3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abUzbO3I4U+6HmlikblDMw8SNOHJAtz3NOH3fkIvxXqziy4bXj/8CZFHAv30+0xbj8Vl+I8ciSF36fWqSZbfZl5EJ4Vd9IPpvn5EycIKu5A76ttdfX3GPjoUQLl0tfW54IYoi6RGRXry0yO5zjoSrSpFwVfA7jyvN6AH6RNJjsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfhAuRdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CE9C4CEE4;
	Mon,  5 May 2025 23:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486291;
	bh=nGuTksRyk8SNbNMoyJtl3SqnGwxC7KZdWOb2kpuzg3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pfhAuRdglhQP8RZqR0zM6N/duDTsacGGGaOd29n00wdpN+wnYekYFvm4uAnz3Tdb+
	 Hxr2s6SjEAONwqglW7bHuI9sfrFE85HTaDt2sirckox0eRGihVT1//FdWjbptwuKAK
	 3zOQFAaQp852iBGozXqhGW8l2NzM9FMsFH2IJLrU38fWTo5VdAuX7AQ/lvonAQcSUU
	 QOQhu9/lQ8cT4HmFizqoZZjNKkWfS06LSOkchCCZR64mkQtAWEbpCbYv574MSi5X2B
	 Z0VCwzZc7dBUMcN8zs6DKZQj/hMcY/hyThqnoZL3m7+z5oEkby7vQ19Ru8EzMNg17X
	 d2Iw2dBB5v/vw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Disha Goel <disgoel@linux.vnet.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	mpe@ellerman.id.au,
	kan.liang@linux.intel.com,
	peterz@infradead.org,
	arnd@arndb.de,
	rppt@kernel.org,
	anjalik@linux.ibm.com,
	coltonlewis@google.com,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.6 241/294] arch/powerpc/perf: Check the instruction type before creating sample with perf_mem_data_src
Date: Mon,  5 May 2025 18:55:41 -0400
Message-Id: <20250505225634.2688578-241-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 10b946e9c6e75..4bb84dc4393fc 100644
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


