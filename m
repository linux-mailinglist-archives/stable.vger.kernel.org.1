Return-Path: <stable+bounces-80250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01C598DCA1
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3697F1F27DF9
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CAB1D1E77;
	Wed,  2 Oct 2024 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y6hZl5Vx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86D41D04A8;
	Wed,  2 Oct 2024 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879819; cv=none; b=ElpfEwyH1MjJsFLEue0QLTybNpavbuQ8kqTufJLaUYfHbDOUPk8SYW1tu09+ufPBPDJPIwBmt0cSUYlc1IoxlaJd9gf34wMEKLBkdCREoM/APg6ev/IgJDOXvH6fGHQF/kDXBbVq81qGeo3GJ6Emi1BRXTHB9Gd+4zzKK2xHufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879819; c=relaxed/simple;
	bh=zSHAftuH6+M4p/3McgMg+lIXLbuEf4tUsmIMFqOLubs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/78Wz7P7P1AKS1Gvh5fzJe7a92IeHpM+CEidpRTViaxFjeO3gbM0tXJZ/OThk5pU4WZd+eWQjbItb9RlX9yLp5ZE5xHzd6psxT4yu/cU7alIrlJgNeNvn/j7HAJGmPRJBSRTPDuqqvwQgnGAN4L1khuYhj1ZUE1L/wfJbjraP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y6hZl5Vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60091C4CEC5;
	Wed,  2 Oct 2024 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879819;
	bh=zSHAftuH6+M4p/3McgMg+lIXLbuEf4tUsmIMFqOLubs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6hZl5VxbloOnJxAB7q/O/e+i4YdQ5jM7hHlqeqL1Q4QTa5xL/GXXYR+4c05r5Hjl
	 jTU4WLJKebbRgbhM17Sx161lDm2vqbGcPteeQBlmSCD/Jb/aiF28I9sdmypg89wZCK
	 WssHl1wHF/p0W4CS//0AWSgWOL/Alv7zKLrLYuqs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 249/538] perf annotate: Split branch stack cycles info from struct annotation
Date: Wed,  2 Oct 2024 14:58:08 +0200
Message-ID: <20241002125802.083131570@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit b7f87e32590bf48eca84f729d3422be7b8dc22d3 ]

The cycles info is only meaningful when sample has branch stacks.  To
save the memory for normal cases, move those fields to a new 'struct
annotated_branch' and dynamically allocate it when needed.  Also move
cycles_hist from annotated_source as it's related here.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20231103191907.54531-3-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: 3ef44458071a ("perf report: Fix --total-cycles --stdio output error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/annotate.c   | 99 ++++++++++++++++++++----------------
 tools/perf/util/annotate.h   | 17 ++++---
 tools/perf/util/block-info.c |  4 +-
 tools/perf/util/sort.c       | 14 ++---
 4 files changed, 73 insertions(+), 61 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 83da2bceb5959..e594be2b71340 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -813,7 +813,6 @@ static __maybe_unused void annotated_source__delete(struct annotated_source *src
 	if (src == NULL)
 		return;
 	zfree(&src->histograms);
-	zfree(&src->cycles_hist);
 	free(src);
 }
 
@@ -848,18 +847,6 @@ static int annotated_source__alloc_histograms(struct annotated_source *src,
 	return src->histograms ? 0 : -1;
 }
 
-/* The cycles histogram is lazily allocated. */
-static int symbol__alloc_hist_cycles(struct symbol *sym)
-{
-	struct annotation *notes = symbol__annotation(sym);
-	const size_t size = symbol__size(sym);
-
-	notes->src->cycles_hist = calloc(size, sizeof(struct cyc_hist));
-	if (notes->src->cycles_hist == NULL)
-		return -1;
-	return 0;
-}
-
 void symbol__annotate_zero_histograms(struct symbol *sym)
 {
 	struct annotation *notes = symbol__annotation(sym);
@@ -868,9 +855,10 @@ void symbol__annotate_zero_histograms(struct symbol *sym)
 	if (notes->src != NULL) {
 		memset(notes->src->histograms, 0,
 		       notes->src->nr_histograms * notes->src->sizeof_sym_hist);
-		if (notes->src->cycles_hist)
-			memset(notes->src->cycles_hist, 0,
-				symbol__size(sym) * sizeof(struct cyc_hist));
+	}
+	if (notes->branch && notes->branch->cycles_hist) {
+		memset(notes->branch->cycles_hist, 0,
+		       symbol__size(sym) * sizeof(struct cyc_hist));
 	}
 	annotation__unlock(notes);
 }
@@ -961,23 +949,33 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
 	return 0;
 }
 
+static struct annotated_branch *annotation__get_branch(struct annotation *notes)
+{
+	if (notes == NULL)
+		return NULL;
+
+	if (notes->branch == NULL)
+		notes->branch = zalloc(sizeof(*notes->branch));
+
+	return notes->branch;
+}
+
 static struct cyc_hist *symbol__cycles_hist(struct symbol *sym)
 {
 	struct annotation *notes = symbol__annotation(sym);
+	struct annotated_branch *branch;
 
-	if (notes->src == NULL) {
-		notes->src = annotated_source__new();
-		if (notes->src == NULL)
-			return NULL;
-		goto alloc_cycles_hist;
-	}
+	branch = annotation__get_branch(notes);
+	if (branch == NULL)
+		return NULL;
+
+	if (branch->cycles_hist == NULL) {
+		const size_t size = symbol__size(sym);
 
-	if (!notes->src->cycles_hist) {
-alloc_cycles_hist:
-		symbol__alloc_hist_cycles(sym);
+		branch->cycles_hist = calloc(size, sizeof(struct cyc_hist));
 	}
 
-	return notes->src->cycles_hist;
+	return branch->cycles_hist;
 }
 
 struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
@@ -1086,6 +1084,14 @@ static unsigned annotation__count_insn(struct annotation *notes, u64 start, u64
 	return n_insn;
 }
 
+static void annotated_branch__delete(struct annotated_branch *branch)
+{
+	if (branch) {
+		zfree(&branch->cycles_hist);
+		free(branch);
+	}
+}
+
 static void annotation__count_and_fill(struct annotation *notes, u64 start, u64 end, struct cyc_hist *ch)
 {
 	unsigned n_insn;
@@ -1094,6 +1100,7 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
 
 	n_insn = annotation__count_insn(notes, start, end);
 	if (n_insn && ch->num && ch->cycles) {
+		struct annotated_branch *branch;
 		float ipc = n_insn / ((double)ch->cycles / (double)ch->num);
 
 		/* Hide data when there are too many overlaps. */
@@ -1109,10 +1116,11 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
 			}
 		}
 
-		if (cover_insn) {
-			notes->hit_cycles += ch->cycles;
-			notes->hit_insn += n_insn * ch->num;
-			notes->cover_insn += cover_insn;
+		branch = annotation__get_branch(notes);
+		if (cover_insn && branch) {
+			branch->hit_cycles += ch->cycles;
+			branch->hit_insn += n_insn * ch->num;
+			branch->cover_insn += cover_insn;
 		}
 	}
 }
@@ -1122,19 +1130,19 @@ static int annotation__compute_ipc(struct annotation *notes, size_t size)
 	int err = 0;
 	s64 offset;
 
-	if (!notes->src || !notes->src->cycles_hist)
+	if (!notes->branch || !notes->branch->cycles_hist)
 		return 0;
 
-	notes->total_insn = annotation__count_insn(notes, 0, size - 1);
-	notes->hit_cycles = 0;
-	notes->hit_insn = 0;
-	notes->cover_insn = 0;
+	notes->branch->total_insn = annotation__count_insn(notes, 0, size - 1);
+	notes->branch->hit_cycles = 0;
+	notes->branch->hit_insn = 0;
+	notes->branch->cover_insn = 0;
 
 	annotation__lock(notes);
 	for (offset = size - 1; offset >= 0; --offset) {
 		struct cyc_hist *ch;
 
-		ch = &notes->src->cycles_hist[offset];
+		ch = &notes->branch->cycles_hist[offset];
 		if (ch && ch->cycles) {
 			struct annotation_line *al;
 
@@ -1153,13 +1161,12 @@ static int annotation__compute_ipc(struct annotation *notes, size_t size)
 				al->cycles->max = ch->cycles_max;
 				al->cycles->min = ch->cycles_min;
 			}
-			notes->have_cycles = true;
 		}
 	}
 
 	if (err) {
 		while (++offset < (s64)size) {
-			struct cyc_hist *ch = &notes->src->cycles_hist[offset];
+			struct cyc_hist *ch = &notes->branch->cycles_hist[offset];
 
 			if (ch && ch->cycles) {
 				struct annotation_line *al = notes->offsets[offset];
@@ -1325,6 +1332,7 @@ int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool r
 void annotation__exit(struct annotation *notes)
 {
 	annotated_source__delete(notes->src);
+	annotated_branch__delete(notes->branch);
 }
 
 static struct sharded_mutex *sharded_mutex;
@@ -3074,13 +3082,14 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
 static void ipc_coverage_string(char *bf, int size, struct annotation *notes)
 {
 	double ipc = 0.0, coverage = 0.0;
+	struct annotated_branch *branch = annotation__get_branch(notes);
 
-	if (notes->hit_cycles)
-		ipc = notes->hit_insn / ((double)notes->hit_cycles);
+	if (branch && branch->hit_cycles)
+		ipc = branch->hit_insn / ((double)branch->hit_cycles);
 
-	if (notes->total_insn) {
-		coverage = notes->cover_insn * 100.0 /
-			((double)notes->total_insn);
+	if (branch && branch->total_insn) {
+		coverage = branch->cover_insn * 100.0 /
+			((double)branch->total_insn);
 	}
 
 	scnprintf(bf, size, "(Average IPC: %.2f, IPC Coverage: %.1f%%)",
@@ -3105,7 +3114,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 	int printed;
 
 	if (first_line && (al->offset == -1 || percent_max == 0.0)) {
-		if (notes->have_cycles && al->cycles) {
+		if (notes->branch && al->cycles) {
 			if (al->cycles->ipc == 0.0 && al->cycles->avg == 0)
 				show_title = true;
 		} else
@@ -3142,7 +3151,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		}
 	}
 
-	if (notes->have_cycles) {
+	if (notes->branch) {
 		if (al->cycles && al->cycles->ipc)
 			obj__printf(obj, "%*.2f ", ANNOTATION__IPC_WIDTH - 1, al->cycles->ipc);
 		else if (!show_title)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 0fa72eb559ac4..dd612f9f04c98 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -272,17 +272,20 @@ struct annotated_source {
 	struct list_head   source;
 	int    		   nr_histograms;
 	size_t		   sizeof_sym_hist;
-	struct cyc_hist	   *cycles_hist;
 	struct sym_hist	   *histograms;
 };
 
-struct LOCKABLE annotation {
-	u64			max_coverage;
-	u64			start;
+struct annotated_branch {
 	u64			hit_cycles;
 	u64			hit_insn;
 	unsigned int		total_insn;
 	unsigned int		cover_insn;
+	struct cyc_hist		*cycles_hist;
+};
+
+struct LOCKABLE annotation {
+	u64			max_coverage;
+	u64			start;
 	struct annotation_options *options;
 	struct annotation_line	**offsets;
 	int			nr_events;
@@ -298,8 +301,8 @@ struct LOCKABLE annotation {
 		u8		max_addr;
 		u8		max_ins_name;
 	} widths;
-	bool			have_cycles;
 	struct annotated_source *src;
+	struct annotated_branch *branch;
 };
 
 static inline void annotation__init(struct annotation *notes __maybe_unused)
@@ -313,10 +316,10 @@ bool annotation__trylock(struct annotation *notes) EXCLUSIVE_TRYLOCK_FUNCTION(tr
 
 static inline int annotation__cycles_width(struct annotation *notes)
 {
-	if (notes->have_cycles && notes->options->show_minmax_cycle)
+	if (notes->branch && notes->options->show_minmax_cycle)
 		return ANNOTATION__IPC_WIDTH + ANNOTATION__MINMAX_CYCLES_WIDTH;
 
-	return notes->have_cycles ? ANNOTATION__IPC_WIDTH + ANNOTATION__CYCLES_WIDTH : 0;
+	return notes->branch ? ANNOTATION__IPC_WIDTH + ANNOTATION__CYCLES_WIDTH : 0;
 }
 
 static inline int annotation__pcnt_width(struct annotation *notes)
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 591fc1edd385c..08f82c1f166c3 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -129,9 +129,9 @@ int block_info__process_sym(struct hist_entry *he, struct block_hist *bh,
 	al.sym = he->ms.sym;
 
 	notes = symbol__annotation(he->ms.sym);
-	if (!notes || !notes->src || !notes->src->cycles_hist)
+	if (!notes || !notes->branch || !notes->branch->cycles_hist)
 		return 0;
-	ch = notes->src->cycles_hist;
+	ch = notes->branch->cycles_hist;
 	for (unsigned int i = 0; i < symbol__size(he->ms.sym); i++) {
 		if (ch[i].num_aggr) {
 			struct block_info *bi;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 6ab8147a3f870..b80349ca21997 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -583,21 +583,21 @@ static int hist_entry__sym_ipc_snprintf(struct hist_entry *he, char *bf,
 {
 
 	struct symbol *sym = he->ms.sym;
-	struct annotation *notes;
+	struct annotated_branch *branch;
 	double ipc = 0.0, coverage = 0.0;
 	char tmp[64];
 
 	if (!sym)
 		return repsep_snprintf(bf, size, "%-*s", width, "-");
 
-	notes = symbol__annotation(sym);
+	branch = symbol__annotation(sym)->branch;
 
-	if (notes->hit_cycles)
-		ipc = notes->hit_insn / ((double)notes->hit_cycles);
+	if (branch && branch->hit_cycles)
+		ipc = branch->hit_insn / ((double)branch->hit_cycles);
 
-	if (notes->total_insn) {
-		coverage = notes->cover_insn * 100.0 /
-			((double)notes->total_insn);
+	if (branch && branch->total_insn) {
+		coverage = branch->cover_insn * 100.0 /
+			((double)branch->total_insn);
 	}
 
 	snprintf(tmp, sizeof(tmp), "%-5.2f [%5.1f%%]", ipc, coverage);
-- 
2.43.0




