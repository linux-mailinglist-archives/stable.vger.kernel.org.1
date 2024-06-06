Return-Path: <stable+bounces-49436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F448FED3F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFD13B21CE0
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AE41B582C;
	Thu,  6 Jun 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kFB3cLY7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07584198E79;
	Thu,  6 Jun 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683465; cv=none; b=eADYkMTWgKmKnUB9c70SS/JkYbr5A5YYTbiW45SSet934Xn9JBgqQn6W1DxFAI2UhWKNpJ2jCCGIXLAFhs0TLg9RpVezbHkSThwPTO1Qb3M7ihcWsxffLyvZUme2WqrOfEoX0uckpaKLWgR+JkGFut2lao5Ms+ZyfuC/vwelGNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683465; c=relaxed/simple;
	bh=lSlSXUodPOAt1UKmIkccRwxAKlgmqw6omH0Iz9nkzrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3AimE9tbB//8ENhXbs77xbYR0Iv30ur+nGsOjVrpntIpOafl5Nd1IFJ72segPiRibXf4e8sGvwUE6qZNWsDrf473/NNqa46Boe4rnEq3ZoEYnOIXxwJAn9pTMhp0vtxL6n0haA46720TUegznV8tgS+Wzu8FUuIRAPqVAtEZgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kFB3cLY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D942AC2BD10;
	Thu,  6 Jun 2024 14:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683464;
	bh=lSlSXUodPOAt1UKmIkccRwxAKlgmqw6omH0Iz9nkzrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFB3cLY7wI/SOqWqHS/hXaQR1Kh+wbfrK6CIIaFPcq5T19hUrM/Pkw0JlfYMThHeb
	 4LsUnrs3VZeM1cbI0ZBDaVOU8gTJJmnq1qdPUKmPv8kRKPvAcqV38Jq3ns9NqdYUPF
	 AVBy8v2x4AGPAj8hg23yuaZlatWAJIAo6XyEgV0s=
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
Subject: [PATCH 6.6 409/744] perf annotate: Split branch stack cycles information out of struct annotation_line
Date: Thu,  6 Jun 2024 16:01:21 +0200
Message-ID: <20240606131745.584697534@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

[ Upstream commit de2c7eb59c342d1a61124caaf2993e325a9becb7 ]

The cycles info is used only when branch stack is provided.  Separate
them from 'struct annotation_line' into a separate struct and lazy
allocate them to save some memory.

Committer notes:

Make annotation__compute_ipc() check if the lazy allocation works,
bailing out if so, its callers already do error checking and
propagation.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20231103191907.54531-2-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: aaf494cf483a ("perf annotate: Fix annotation_calc_lines() to pass correct address to get_srcline()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/ui/browsers/annotate.c |  2 +-
 tools/perf/util/annotate.c        | 61 ++++++++++++++++++++++---------
 tools/perf/util/annotate.h        | 15 +++++---
 3 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ccdb2cd11fbf0..d2470f87344d0 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -337,7 +337,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 				max_percent = percent;
 		}
 
-		if (max_percent < 0.01 && pos->al.ipc == 0) {
+		if (max_percent < 0.01 && (!pos->al.cycles || pos->al.cycles->ipc == 0)) {
 			RB_CLEAR_NODE(&pos->al.rb_node);
 			continue;
 		}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 82956adf99632..99ff3bb9cad8d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1100,8 +1100,8 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
 		for (offset = start; offset <= end; offset++) {
 			struct annotation_line *al = notes->offsets[offset];
 
-			if (al && al->ipc == 0.0) {
-				al->ipc = ipc;
+			if (al && al->cycles && al->cycles->ipc == 0.0) {
+				al->cycles->ipc = ipc;
 				cover_insn++;
 			}
 		}
@@ -1114,12 +1114,13 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
 	}
 }
 
-void annotation__compute_ipc(struct annotation *notes, size_t size)
+static int annotation__compute_ipc(struct annotation *notes, size_t size)
 {
+	int err = 0;
 	s64 offset;
 
 	if (!notes->src || !notes->src->cycles_hist)
-		return;
+		return 0;
 
 	notes->total_insn = annotation__count_insn(notes, 0, size - 1);
 	notes->hit_cycles = 0;
@@ -1134,18 +1135,39 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 		if (ch && ch->cycles) {
 			struct annotation_line *al;
 
+			al = notes->offsets[offset];
+			if (al && al->cycles == NULL) {
+				al->cycles = zalloc(sizeof(*al->cycles));
+				if (al->cycles == NULL) {
+					err = ENOMEM;
+					break;
+				}
+			}
 			if (ch->have_start)
 				annotation__count_and_fill(notes, ch->start, offset, ch);
-			al = notes->offsets[offset];
 			if (al && ch->num_aggr) {
-				al->cycles = ch->cycles_aggr / ch->num_aggr;
-				al->cycles_max = ch->cycles_max;
-				al->cycles_min = ch->cycles_min;
+				al->cycles->avg = ch->cycles_aggr / ch->num_aggr;
+				al->cycles->max = ch->cycles_max;
+				al->cycles->min = ch->cycles_min;
 			}
 			notes->have_cycles = true;
 		}
 	}
+
+	if (err) {
+		while (++offset < (s64)size) {
+			struct cyc_hist *ch = &notes->src->cycles_hist[offset];
+
+			if (ch && ch->cycles) {
+				struct annotation_line *al = notes->offsets[offset];
+				if (al)
+					zfree(&al->cycles);
+			}
+		}
+	}
+
 	annotation__unlock(notes);
+	return 0;
 }
 
 int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
@@ -1225,6 +1247,7 @@ static void annotation_line__exit(struct annotation_line *al)
 {
 	zfree_srcline(&al->path);
 	zfree(&al->line);
+	zfree(&al->cycles);
 }
 
 static size_t disasm_line_size(int nr)
@@ -3083,8 +3106,8 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 	int printed;
 
 	if (first_line && (al->offset == -1 || percent_max == 0.0)) {
-		if (notes->have_cycles) {
-			if (al->ipc == 0.0 && al->cycles == 0)
+		if (notes->have_cycles && al->cycles) {
+			if (al->cycles->ipc == 0.0 && al->cycles->avg == 0)
 				show_title = true;
 		} else
 			show_title = true;
@@ -3121,17 +3144,17 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 	}
 
 	if (notes->have_cycles) {
-		if (al->ipc)
-			obj__printf(obj, "%*.2f ", ANNOTATION__IPC_WIDTH - 1, al->ipc);
+		if (al->cycles && al->cycles->ipc)
+			obj__printf(obj, "%*.2f ", ANNOTATION__IPC_WIDTH - 1, al->cycles->ipc);
 		else if (!show_title)
 			obj__printf(obj, "%*s", ANNOTATION__IPC_WIDTH, " ");
 		else
 			obj__printf(obj, "%*s ", ANNOTATION__IPC_WIDTH - 1, "IPC");
 
 		if (!notes->options->show_minmax_cycle) {
-			if (al->cycles)
+			if (al->cycles && al->cycles->avg)
 				obj__printf(obj, "%*" PRIu64 " ",
-					   ANNOTATION__CYCLES_WIDTH - 1, al->cycles);
+					   ANNOTATION__CYCLES_WIDTH - 1, al->cycles->avg);
 			else if (!show_title)
 				obj__printf(obj, "%*s",
 					    ANNOTATION__CYCLES_WIDTH, " ");
@@ -3145,8 +3168,8 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 
 				scnprintf(str, sizeof(str),
 					"%" PRIu64 "(%" PRIu64 "/%" PRIu64 ")",
-					al->cycles, al->cycles_min,
-					al->cycles_max);
+					al->cycles->avg, al->cycles->min,
+					al->cycles->max);
 
 				obj__printf(obj, "%*s ",
 					    ANNOTATION__MINMAX_CYCLES_WIDTH - 1,
@@ -3264,7 +3287,11 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 
 	annotation__set_offsets(notes, size);
 	annotation__mark_jump_targets(notes, sym);
-	annotation__compute_ipc(notes, size);
+
+	err = annotation__compute_ipc(notes, size);
+	if (err)
+		goto out_free_offsets;
+
 	annotation__init_column_widths(notes, sym);
 	notes->nr_events = nr_pcnt;
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 9627805591760..19bc2f0391757 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -130,6 +130,13 @@ struct annotation_data {
 	struct sym_hist_entry	 he;
 };
 
+struct cycles_info {
+	float			 ipc;
+	u64			 avg;
+	u64			 max;
+	u64			 min;
+};
+
 struct annotation_line {
 	struct list_head	 node;
 	struct rb_node		 rb_node;
@@ -137,12 +144,9 @@ struct annotation_line {
 	char			*line;
 	int			 line_nr;
 	char			*fileloc;
-	int			 jump_sources;
-	float			 ipc;
-	u64			 cycles;
-	u64			 cycles_max;
-	u64			 cycles_min;
 	char			*path;
+	struct cycles_info	*cycles;
+	int			 jump_sources;
 	u32			 idx;
 	int			 idx_asm;
 	int			 data_nr;
@@ -325,7 +329,6 @@ static inline bool annotation_line__filter(struct annotation_line *al, struct an
 }
 
 void annotation__set_offsets(struct annotation *notes, s64 size);
-void annotation__compute_ipc(struct annotation *notes, size_t size);
 void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym);
 void annotation__update_column_widths(struct annotation *notes);
 void annotation__init_column_widths(struct annotation *notes, struct symbol *sym);
-- 
2.43.0




