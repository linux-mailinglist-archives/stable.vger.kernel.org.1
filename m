Return-Path: <stable+bounces-2438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6D27F842E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C3ECB27E3A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB55735F1A;
	Fri, 24 Nov 2023 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JAI+8Djz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777DC3306F;
	Fri, 24 Nov 2023 19:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF76C433C8;
	Fri, 24 Nov 2023 19:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853883;
	bh=h3gBpVuvwkjoHC+7enurwbRag5mMGVElOiifT5Mpdfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JAI+8DjzFudF5aDbKRtQJYBMzZSYhSr8aTS1DGdvX7Hl/iraD7VGBQfSfEeWwPvZF
	 q0DPnYUhwg5c7ZtPvDALAUBSADFlfGM50gs6ANuYRMGy8T5YFGSg0FJb8udycAkfoF
	 B4RsgpQWLpwi2YY/8O6skNvea+46jpobW7YZukpM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kan Liang <kan.liang@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexey Budankov <alexey.budankov@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Namhyung Kim <namhyung@kernel.org>,
	Pavel Gerasimov <pavel.gerasimov@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
	Stephane Eranian <eranian@google.com>,
	Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 044/159] perf tools: Add hw_idx in struct branch_stack
Date: Fri, 24 Nov 2023 17:54:21 +0000
Message-ID: <20231124171943.771923658@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171941.909624388@linuxfoundation.org>
References: <20231124171941.909624388@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit 42bbabed09ce6208026648a71a45b4394c74585a ]

The low level index of raw branch records for the most recent branch can
be recorded in a sample with PERF_SAMPLE_BRANCH_HW_INDEX
branch_sample_type. Extend struct branch_stack to support it.

However, if the PERF_SAMPLE_BRANCH_HW_INDEX is not applied, only nr and
entries[] will be output by kernel. The pointer of entries[] could be
wrong, since the output format is different with new struct
branch_stack.  Add a variable no_hw_idx in struct perf_sample to
indicate whether the hw_idx is output.  Add get_branch_entry() to return
corresponding pointer of entries[0].

To make dummy branch sample consistent as new branch sample, add hw_idx
in struct dummy_branch_stack for cs-etm and intel-pt.

Apply the new struct branch_stack for synthetic events as well.

Extend test case sample-parsing to support new struct branch_stack.

Committer notes:

Renamed get_branch_entries() to perf_sample__branch_entries() to have
proper namespacing and pave the way for this to be moved to libperf,
eventually.

Add 'static' to that inline as it is in a header.

Add 'hw_idx' to 'struct dummy_branch_stack' in cs-etm.c to fix the build
on arm64.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pavel Gerasimov <pavel.gerasimov@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
Link: http://lore.kernel.org/lkml/20200228163011.19358-2-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: c1149037f65b ("perf hist: Add missing puts to hist__account_cycles")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-script.c                   | 70 ++++++++++---------
 tools/perf/tests/sample-parsing.c             |  7 +-
 tools/perf/util/branch.h                      | 22 ++++++
 tools/perf/util/cs-etm.c                      |  2 +
 tools/perf/util/event.h                       |  1 +
 tools/perf/util/evsel.c                       |  5 ++
 tools/perf/util/evsel.h                       |  5 ++
 tools/perf/util/hist.c                        |  3 +-
 tools/perf/util/intel-pt.c                    |  2 +
 tools/perf/util/machine.c                     | 35 +++++-----
 .../scripting-engines/trace-event-python.c    | 30 ++++----
 tools/perf/util/session.c                     |  8 ++-
 tools/perf/util/synthetic-events.c            |  6 +-
 13 files changed, 125 insertions(+), 71 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index bbf1f2d3387e3..bb64dbfe043a5 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -735,6 +735,7 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 					struct perf_event_attr *attr, FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	struct addr_location alf, alt;
 	u64 i, from, to;
 	int printed = 0;
@@ -743,8 +744,8 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 		return 0;
 
 	for (i = 0; i < br->nr; i++) {
-		from = br->entries[i].from;
-		to   = br->entries[i].to;
+		from = entries[i].from;
+		to   = entries[i].to;
 
 		if (PRINT_FIELD(DSO)) {
 			memset(&alf, 0, sizeof(alf));
@@ -768,10 +769,10 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 		}
 
 		printed += fprintf(fp, "/%c/%c/%c/%d ",
-			mispred_str( br->entries + i),
-			br->entries[i].flags.in_tx? 'X' : '-',
-			br->entries[i].flags.abort? 'A' : '-',
-			br->entries[i].flags.cycles);
+			mispred_str(entries + i),
+			entries[i].flags.in_tx ? 'X' : '-',
+			entries[i].flags.abort ? 'A' : '-',
+			entries[i].flags.cycles);
 	}
 
 	return printed;
@@ -782,6 +783,7 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
 					   struct perf_event_attr *attr, FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	struct addr_location alf, alt;
 	u64 i, from, to;
 	int printed = 0;
@@ -793,8 +795,8 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
 
 		memset(&alf, 0, sizeof(alf));
 		memset(&alt, 0, sizeof(alt));
-		from = br->entries[i].from;
-		to   = br->entries[i].to;
+		from = entries[i].from;
+		to   = entries[i].to;
 
 		thread__find_symbol_fb(thread, sample->cpumode, from, &alf);
 		thread__find_symbol_fb(thread, sample->cpumode, to, &alt);
@@ -813,10 +815,10 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
 			printed += fprintf(fp, ")");
 		}
 		printed += fprintf(fp, "/%c/%c/%c/%d ",
-			mispred_str( br->entries + i),
-			br->entries[i].flags.in_tx? 'X' : '-',
-			br->entries[i].flags.abort? 'A' : '-',
-			br->entries[i].flags.cycles);
+			mispred_str(entries + i),
+			entries[i].flags.in_tx ? 'X' : '-',
+			entries[i].flags.abort ? 'A' : '-',
+			entries[i].flags.cycles);
 	}
 
 	return printed;
@@ -827,6 +829,7 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 					   struct perf_event_attr *attr, FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	struct addr_location alf, alt;
 	u64 i, from, to;
 	int printed = 0;
@@ -838,8 +841,8 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 
 		memset(&alf, 0, sizeof(alf));
 		memset(&alt, 0, sizeof(alt));
-		from = br->entries[i].from;
-		to   = br->entries[i].to;
+		from = entries[i].from;
+		to   = entries[i].to;
 
 		if (thread__find_map_fb(thread, sample->cpumode, from, &alf) &&
 		    !alf.map->dso->adjust_symbols)
@@ -862,10 +865,10 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 			printed += fprintf(fp, ")");
 		}
 		printed += fprintf(fp, "/%c/%c/%c/%d ",
-			mispred_str(br->entries + i),
-			br->entries[i].flags.in_tx ? 'X' : '-',
-			br->entries[i].flags.abort ? 'A' : '-',
-			br->entries[i].flags.cycles);
+			mispred_str(entries + i),
+			entries[i].flags.in_tx ? 'X' : '-',
+			entries[i].flags.abort ? 'A' : '-',
+			entries[i].flags.cycles);
 	}
 
 	return printed;
@@ -1011,6 +1014,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 					    struct machine *machine, FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	u64 start, end;
 	int i, insn, len, nr, ilen, printed = 0;
 	struct perf_insn x;
@@ -1031,31 +1035,31 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 	printed += fprintf(fp, "%c", '\n');
 
 	/* Handle first from jump, of which we don't know the entry. */
-	len = grab_bb(buffer, br->entries[nr-1].from,
-			br->entries[nr-1].from,
+	len = grab_bb(buffer, entries[nr-1].from,
+			entries[nr-1].from,
 			machine, thread, &x.is64bit, &x.cpumode, false);
 	if (len > 0) {
-		printed += ip__fprintf_sym(br->entries[nr - 1].from, thread,
+		printed += ip__fprintf_sym(entries[nr - 1].from, thread,
 					   x.cpumode, x.cpu, &lastsym, attr, fp);
-		printed += ip__fprintf_jump(br->entries[nr - 1].from, &br->entries[nr - 1],
+		printed += ip__fprintf_jump(entries[nr - 1].from, &entries[nr - 1],
 					    &x, buffer, len, 0, fp, &total_cycles);
 		if (PRINT_FIELD(SRCCODE))
-			printed += print_srccode(thread, x.cpumode, br->entries[nr - 1].from);
+			printed += print_srccode(thread, x.cpumode, entries[nr - 1].from);
 	}
 
 	/* Print all blocks */
 	for (i = nr - 2; i >= 0; i--) {
-		if (br->entries[i].from || br->entries[i].to)
+		if (entries[i].from || entries[i].to)
 			pr_debug("%d: %" PRIx64 "-%" PRIx64 "\n", i,
-				 br->entries[i].from,
-				 br->entries[i].to);
-		start = br->entries[i + 1].to;
-		end   = br->entries[i].from;
+				 entries[i].from,
+				 entries[i].to);
+		start = entries[i + 1].to;
+		end   = entries[i].from;
 
 		len = grab_bb(buffer, start, end, machine, thread, &x.is64bit, &x.cpumode, false);
 		/* Patch up missing kernel transfers due to ring filters */
 		if (len == -ENXIO && i > 0) {
-			end = br->entries[--i].from;
+			end = entries[--i].from;
 			pr_debug("\tpatching up to %" PRIx64 "-%" PRIx64 "\n", start, end);
 			len = grab_bb(buffer, start, end, machine, thread, &x.is64bit, &x.cpumode, false);
 		}
@@ -1068,7 +1072,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 
 			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
 			if (ip == end) {
-				printed += ip__fprintf_jump(ip, &br->entries[i], &x, buffer + off, len - off, ++insn, fp,
+				printed += ip__fprintf_jump(ip, &entries[i], &x, buffer + off, len - off, ++insn, fp,
 							    &total_cycles);
 				if (PRINT_FIELD(SRCCODE))
 					printed += print_srccode(thread, x.cpumode, ip);
@@ -1092,9 +1096,9 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 	 * Hit the branch? In this case we are already done, and the target
 	 * has not been executed yet.
 	 */
-	if (br->entries[0].from == sample->ip)
+	if (entries[0].from == sample->ip)
 		goto out;
-	if (br->entries[0].flags.abort)
+	if (entries[0].flags.abort)
 		goto out;
 
 	/*
@@ -1105,7 +1109,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 	 * between final branch and sample. When this happens just
 	 * continue walking after the last TO until we hit a branch.
 	 */
-	start = br->entries[0].to;
+	start = entries[0].to;
 	end = sample->ip;
 	if (end < start) {
 		/* Missing jump. Scan 128 bytes for the next branch */
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 2f76d4a9de860..6da067d339429 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -99,6 +99,7 @@ static bool samples_same(const struct perf_sample *s1,
 
 	if (type & PERF_SAMPLE_BRANCH_STACK) {
 		COMP(branch_stack->nr);
+		COMP(branch_stack->hw_idx);
 		for (i = 0; i < s1->branch_stack->nr; i++)
 			MCOMP(branch_stack->entries[i]);
 	}
@@ -177,7 +178,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		u64 data[64];
 	} branch_stack = {
 		/* 1 branch_entry */
-		.data = {1, 211, 212, 213},
+		.data = {1, -1ULL, 211, 212, 213},
 	};
 	u64 regs[64];
 	const u32 raw_data[] = {0x12345678, 0x0a0b0c0d, 0x11020304, 0x05060708, 0 };
@@ -198,6 +199,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		.transaction	= 112,
 		.raw_data	= (void *)raw_data,
 		.callchain	= &callchain.callchain,
+		.no_hw_idx      = false,
 		.branch_stack	= &branch_stack.branch_stack,
 		.user_regs	= {
 			.abi	= PERF_SAMPLE_REGS_ABI_64,
@@ -230,6 +232,9 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 	if (sample_type & PERF_SAMPLE_REGS_INTR)
 		evsel.core.attr.sample_regs_intr = sample_regs;
 
+	if (sample_type & PERF_SAMPLE_BRANCH_STACK)
+		evsel.core.attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
+
 	for (i = 0; i < sizeof(regs); i++)
 		*(i + (u8 *)regs) = i & 0xfe;
 
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 88e00d268f6f2..154a05cd03af5 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -12,6 +12,7 @@
 #include <linux/stddef.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
+#include "event.h"
 
 struct branch_flags {
 	u64 mispred:1;
@@ -39,9 +40,30 @@ struct branch_entry {
 
 struct branch_stack {
 	u64			nr;
+	u64			hw_idx;
 	struct branch_entry	entries[0];
 };
 
+/*
+ * The hw_idx is only available when PERF_SAMPLE_BRANCH_HW_INDEX is applied.
+ * Otherwise, the output format of a sample with branch stack is
+ * struct branch_stack {
+ *	u64			nr;
+ *	struct branch_entry	entries[0];
+ * }
+ * Check whether the hw_idx is available,
+ * and return the corresponding pointer of entries[0].
+ */
+static inline struct branch_entry *perf_sample__branch_entries(struct perf_sample *sample)
+{
+	u64 *entry = (u64 *)sample->branch_stack;
+
+	entry++;
+	if (sample->no_hw_idx)
+		return (struct branch_entry *)entry;
+	return (struct branch_entry *)(++entry);
+}
+
 struct branch_type_stat {
 	bool	branch_to;
 	u64	counts[PERF_BR_MAX];
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f5a9cb4088080..f9cc15f93c4a7 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1192,6 +1192,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	union perf_event *event = tidq->event_buf;
 	struct dummy_branch_stack {
 		u64			nr;
+		u64			hw_idx;
 		struct branch_entry	entries;
 	} dummy_bs;
 	u64 ip;
@@ -1222,6 +1223,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	if (etm->synth_opts.last_branch) {
 		dummy_bs = (struct dummy_branch_stack){
 			.nr = 1,
+			.hw_idx = -1ULL,
 			.entries = {
 				.from = sample.ip,
 				.to = sample.addr,
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index a0a0c91cde4a6..47d1d0b78be10 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -134,6 +134,7 @@ struct perf_sample {
 	u16 insn_len;
 	u8  cpumode;
 	u16 misc;
+	bool no_hw_idx;		/* No hw_idx collected in branch_stack */
 	char insn[MAX_INSN];
 	void *raw_data;
 	struct ip_callchain *callchain;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9dd9e3f4ef591..ee0ed7067cdb0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2126,7 +2126,12 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 
 		if (data->branch_stack->nr > max_branch_nr)
 			return -EFAULT;
+
 		sz = data->branch_stack->nr * sizeof(struct branch_entry);
+		if (perf_evsel__has_branch_hw_idx(evsel))
+			sz += sizeof(u64);
+		else
+			data->no_hw_idx = true;
 		OVERFLOW_CHECK(array, sz, max_size);
 		array = (void *)array + sz;
 	}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ddc5ee6f6592b..ae2c5c22357ad 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -382,6 +382,11 @@ static inline bool perf_evsel__has_branch_callstack(const struct evsel *evsel)
 	return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK;
 }
 
+static inline bool perf_evsel__has_branch_hw_idx(const struct evsel *evsel)
+{
+	return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX;
+}
+
 static inline bool evsel__has_callchain(const struct evsel *evsel)
 {
 	return (evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN) != 0;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 7b6eaf5e0bda5..151b9e43c88f9 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2572,9 +2572,10 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			  struct perf_sample *sample, bool nonany_branch_mode)
 {
 	struct branch_info *bi;
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 
 	/* If we have branch cycles always annotate them. */
-	if (bs && bs->nr && bs->entries[0].flags.cycles) {
+	if (bs && bs->nr && entries[0].flags.cycles) {
 		int i;
 
 		bi = sample__resolve_bstack(sample, al);
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index b40832419a279..94f11cfe02364 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1278,6 +1278,7 @@ static int intel_pt_synth_branch_sample(struct intel_pt_queue *ptq)
 	struct perf_sample sample = { .ip = 0, };
 	struct dummy_branch_stack {
 		u64			nr;
+		u64			hw_idx;
 		struct branch_entry	entries;
 	} dummy_bs;
 
@@ -1299,6 +1300,7 @@ static int intel_pt_synth_branch_sample(struct intel_pt_queue *ptq)
 	if (pt->synth_opts.last_branch && sort__mode == SORT_MODE__BRANCH) {
 		dummy_bs = (struct dummy_branch_stack){
 			.nr = 1,
+			.hw_idx = -1ULL,
 			.entries = {
 				.from = sample.ip,
 				.to = sample.addr,
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8c3addc2e9e1e..0046ca19ca1a4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2082,15 +2082,16 @@ struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
 {
 	unsigned int i;
 	const struct branch_stack *bs = sample->branch_stack;
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	struct branch_info *bi = calloc(bs->nr, sizeof(struct branch_info));
 
 	if (!bi)
 		return NULL;
 
 	for (i = 0; i < bs->nr; i++) {
-		ip__resolve_ams(al->thread, &bi[i].to, bs->entries[i].to);
-		ip__resolve_ams(al->thread, &bi[i].from, bs->entries[i].from);
-		bi[i].flags = bs->entries[i].flags;
+		ip__resolve_ams(al->thread, &bi[i].to, entries[i].to);
+		ip__resolve_ams(al->thread, &bi[i].from, entries[i].from);
+		bi[i].flags = entries[i].flags;
 	}
 	return bi;
 }
@@ -2186,6 +2187,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	/* LBR only affects the user callchain */
 	if (i != chain_nr) {
 		struct branch_stack *lbr_stack = sample->branch_stack;
+		struct branch_entry *entries = perf_sample__branch_entries(sample);
 		int lbr_nr = lbr_stack->nr, j, k;
 		bool branch;
 		struct branch_flags *flags;
@@ -2211,31 +2213,29 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 					ip = chain->ips[j];
 				else if (j > i + 1) {
 					k = j - i - 2;
-					ip = lbr_stack->entries[k].from;
+					ip = entries[k].from;
 					branch = true;
-					flags = &lbr_stack->entries[k].flags;
+					flags = &entries[k].flags;
 				} else {
-					ip = lbr_stack->entries[0].to;
+					ip = entries[0].to;
 					branch = true;
-					flags = &lbr_stack->entries[0].flags;
-					branch_from =
-						lbr_stack->entries[0].from;
+					flags = &entries[0].flags;
+					branch_from = entries[0].from;
 				}
 			} else {
 				if (j < lbr_nr) {
 					k = lbr_nr - j - 1;
-					ip = lbr_stack->entries[k].from;
+					ip = entries[k].from;
 					branch = true;
-					flags = &lbr_stack->entries[k].flags;
+					flags = &entries[k].flags;
 				}
 				else if (j > lbr_nr)
 					ip = chain->ips[i + 1 - (j - lbr_nr)];
 				else {
-					ip = lbr_stack->entries[0].to;
+					ip = entries[0].to;
 					branch = true;
-					flags = &lbr_stack->entries[0].flags;
-					branch_from =
-						lbr_stack->entries[0].from;
+					flags = &entries[0].flags;
+					branch_from = entries[0].from;
 				}
 			}
 
@@ -2282,6 +2282,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 					    int max_stack)
 {
 	struct branch_stack *branch = sample->branch_stack;
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	struct ip_callchain *chain = sample->callchain;
 	int chain_nr = 0;
 	u8 cpumode = PERF_RECORD_MISC_USER;
@@ -2329,7 +2330,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 
 		for (i = 0; i < nr; i++) {
 			if (callchain_param.order == ORDER_CALLEE) {
-				be[i] = branch->entries[i];
+				be[i] = entries[i];
 
 				if (chain == NULL)
 					continue;
@@ -2348,7 +2349,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 				    be[i].from >= chain->ips[first_call] - 8)
 					first_call++;
 			} else
-				be[i] = branch->entries[branch->nr - i - 1];
+				be[i] = entries[branch->nr - i - 1];
 		}
 
 		memset(iter, 0, sizeof(struct iterations) * nr);
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 3b02c3f1b2895..2bdd10c4c2460 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -464,6 +464,7 @@ static PyObject *python_process_brstack(struct perf_sample *sample,
 					struct thread *thread)
 {
 	struct branch_stack *br = sample->branch_stack;
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	PyObject *pylist;
 	u64 i;
 
@@ -484,28 +485,28 @@ static PyObject *python_process_brstack(struct perf_sample *sample,
 			Py_FatalError("couldn't create Python dictionary");
 
 		pydict_set_item_string_decref(pyelem, "from",
-		    PyLong_FromUnsignedLongLong(br->entries[i].from));
+		    PyLong_FromUnsignedLongLong(entries[i].from));
 		pydict_set_item_string_decref(pyelem, "to",
-		    PyLong_FromUnsignedLongLong(br->entries[i].to));
+		    PyLong_FromUnsignedLongLong(entries[i].to));
 		pydict_set_item_string_decref(pyelem, "mispred",
-		    PyBool_FromLong(br->entries[i].flags.mispred));
+		    PyBool_FromLong(entries[i].flags.mispred));
 		pydict_set_item_string_decref(pyelem, "predicted",
-		    PyBool_FromLong(br->entries[i].flags.predicted));
+		    PyBool_FromLong(entries[i].flags.predicted));
 		pydict_set_item_string_decref(pyelem, "in_tx",
-		    PyBool_FromLong(br->entries[i].flags.in_tx));
+		    PyBool_FromLong(entries[i].flags.in_tx));
 		pydict_set_item_string_decref(pyelem, "abort",
-		    PyBool_FromLong(br->entries[i].flags.abort));
+		    PyBool_FromLong(entries[i].flags.abort));
 		pydict_set_item_string_decref(pyelem, "cycles",
-		    PyLong_FromUnsignedLongLong(br->entries[i].flags.cycles));
+		    PyLong_FromUnsignedLongLong(entries[i].flags.cycles));
 
 		thread__find_map_fb(thread, sample->cpumode,
-				    br->entries[i].from, &al);
+				    entries[i].from, &al);
 		dsoname = get_dsoname(al.map);
 		pydict_set_item_string_decref(pyelem, "from_dsoname",
 					      _PyUnicode_FromString(dsoname));
 
 		thread__find_map_fb(thread, sample->cpumode,
-				    br->entries[i].to, &al);
+				    entries[i].to, &al);
 		dsoname = get_dsoname(al.map);
 		pydict_set_item_string_decref(pyelem, "to_dsoname",
 					      _PyUnicode_FromString(dsoname));
@@ -561,6 +562,7 @@ static PyObject *python_process_brstacksym(struct perf_sample *sample,
 					   struct thread *thread)
 {
 	struct branch_stack *br = sample->branch_stack;
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	PyObject *pylist;
 	u64 i;
 	char bf[512];
@@ -581,22 +583,22 @@ static PyObject *python_process_brstacksym(struct perf_sample *sample,
 			Py_FatalError("couldn't create Python dictionary");
 
 		thread__find_symbol_fb(thread, sample->cpumode,
-				       br->entries[i].from, &al);
+				       entries[i].from, &al);
 		get_symoff(al.sym, &al, true, bf, sizeof(bf));
 		pydict_set_item_string_decref(pyelem, "from",
 					      _PyUnicode_FromString(bf));
 
 		thread__find_symbol_fb(thread, sample->cpumode,
-				       br->entries[i].to, &al);
+				       entries[i].to, &al);
 		get_symoff(al.sym, &al, true, bf, sizeof(bf));
 		pydict_set_item_string_decref(pyelem, "to",
 					      _PyUnicode_FromString(bf));
 
-		get_br_mspred(&br->entries[i].flags, bf, sizeof(bf));
+		get_br_mspred(&entries[i].flags, bf, sizeof(bf));
 		pydict_set_item_string_decref(pyelem, "pred",
 					      _PyUnicode_FromString(bf));
 
-		if (br->entries[i].flags.in_tx) {
+		if (entries[i].flags.in_tx) {
 			pydict_set_item_string_decref(pyelem, "in_tx",
 					      _PyUnicode_FromString("X"));
 		} else {
@@ -604,7 +606,7 @@ static PyObject *python_process_brstacksym(struct perf_sample *sample,
 					      _PyUnicode_FromString("-"));
 		}
 
-		if (br->entries[i].flags.abort) {
+		if (entries[i].flags.abort) {
 			pydict_set_item_string_decref(pyelem, "abort",
 					      _PyUnicode_FromString("A"));
 		} else {
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 01e15b445cb58..2f08e590c03b1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1003,6 +1003,7 @@ static void callchain__lbr_callstack_printf(struct perf_sample *sample)
 {
 	struct ip_callchain *callchain = sample->callchain;
 	struct branch_stack *lbr_stack = sample->branch_stack;
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	u64 kernel_callchain_nr = callchain->nr;
 	unsigned int i;
 
@@ -1039,10 +1040,10 @@ static void callchain__lbr_callstack_printf(struct perf_sample *sample)
 			       i, callchain->ips[i]);
 
 		printf("..... %2d: %016" PRIx64 "\n",
-		       (int)(kernel_callchain_nr), lbr_stack->entries[0].to);
+		       (int)(kernel_callchain_nr), entries[0].to);
 		for (i = 0; i < lbr_stack->nr; i++)
 			printf("..... %2d: %016" PRIx64 "\n",
-			       (int)(i + kernel_callchain_nr + 1), lbr_stack->entries[i].from);
+			       (int)(i + kernel_callchain_nr + 1), entries[i].from);
 	}
 }
 
@@ -1064,6 +1065,7 @@ static void callchain__printf(struct evsel *evsel,
 
 static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 {
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	uint64_t i;
 
 	printf("%s: nr:%" PRIu64 "\n",
@@ -1071,7 +1073,7 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 		sample->branch_stack->nr);
 
 	for (i = 0; i < sample->branch_stack->nr; i++) {
-		struct branch_entry *e = &sample->branch_stack->entries[i];
+		struct branch_entry *e = &entries[i];
 
 		if (!callstack) {
 			printf("..... %2"PRIu64": %016" PRIx64 " -> %016" PRIx64 " %hu cycles %s%s%s%s %x\n",
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 807cbca403a7d..e5fbece642d3c 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1183,7 +1183,8 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 
 	if (type & PERF_SAMPLE_BRANCH_STACK) {
 		sz = sample->branch_stack->nr * sizeof(struct branch_entry);
-		sz += sizeof(u64);
+		/* nr, hw_idx */
+		sz += 2 * sizeof(u64);
 		result += sz;
 	}
 
@@ -1339,7 +1340,8 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 
 	if (type & PERF_SAMPLE_BRANCH_STACK) {
 		sz = sample->branch_stack->nr * sizeof(struct branch_entry);
-		sz += sizeof(u64);
+		/* nr, hw_idx */
+		sz += 2 * sizeof(u64);
 		memcpy(array, sample->branch_stack, sz);
 		array = (void *)array + sz;
 	}
-- 
2.42.0




