Return-Path: <stable+bounces-49446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A998FED48
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD3C1C22A5E
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A7119D08F;
	Thu,  6 Jun 2024 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tjhX6Iok"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB02919D07B;
	Thu,  6 Jun 2024 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683470; cv=none; b=l8WvYx9DksumzIxUwQUneGYFlPnw3YimU0pm3R8ur1kw5HZfN0LXGgqBcHkwR5+aQzPvZC0VtXiJcJ+pPEButZMkE+nJOkoEYjli114hCdQ/uFzOKb5+u0x2EGmGnZ6yUCpAjq2+8T3fU5Zsg+4vcf/Thv45SjAd/vX2KV478yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683470; c=relaxed/simple;
	bh=FLzc/M3ySvnyEQ13RfP0Ewcyi+h1jraEFRyakkW4Dd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYbET/dWiBXDBGpVr8+MfK8qHm/JUc3yqJG5GFSUpogbCpAORsF6Qs9udGdqifdfja0Vaj7vlxs9W/aDPBjAr1FmYvKGM7YGFjIAq2cI4HuTSs1s2VS5nAV/Oab8Y/IKFsERMTJ+Jk20q1JKbiJpNW/+OvyCLQtYxh1yR2UNah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tjhX6Iok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BDAC2BD10;
	Thu,  6 Jun 2024 14:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683469;
	bh=FLzc/M3ySvnyEQ13RfP0Ewcyi+h1jraEFRyakkW4Dd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tjhX6Iok9ah85/CdsW7K0zcoHcQ/lVE6s5CCne7YBiHpy++UMHx9oEXt7G3T/HsgH
	 eE2329G92LWUqe2Yrm6P0YdSAC3EwdL1yQnFu8dFFQBohrlMwm4gMMYLGCYNWc/gBn
	 2+YieCphSnt32NwxDIv7XSiRUWYMBJaeduubd5K8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 413/744] perf annotate: Use global annotation_options
Date: Thu,  6 Jun 2024 16:01:25 +0200
Message-ID: <20240606131745.723858002@linuxfoundation.org>
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

[ Upstream commit 41fd3cacd29f47f6b9c6474b27c5b0513786c4e9 ]

Now it can directly use the global options and no need to pass it as an
argument.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20231128175441.721579-5-namhyung@kernel.org
[ Fixup build with GTK2=1 ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: aaf494cf483a ("perf annotate: Fix annotation_calc_lines() to pass correct address to get_srcline()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-annotate.c     |   7 +-
 tools/perf/builtin-report.c       |   2 +-
 tools/perf/builtin-top.c          |   4 +-
 tools/perf/ui/browsers/annotate.c |   6 +-
 tools/perf/ui/gtk/annotate.c      |   6 +-
 tools/perf/ui/gtk/gtk.h           |   2 -
 tools/perf/util/annotate.c        | 118 ++++++++++++++----------------
 tools/perf/util/annotate.h        |  15 ++--
 8 files changed, 71 insertions(+), 89 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index d3d410cdd9ba5..92973420c0a5a 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -314,9 +314,9 @@ static int hist_entry__tty_annotate(struct hist_entry *he,
 				    struct perf_annotate *ann)
 {
 	if (!ann->use_stdio2)
-		return symbol__tty_annotate(&he->ms, evsel, &annotate_opts);
+		return symbol__tty_annotate(&he->ms, evsel);
 
-	return symbol__tty_annotate2(&he->ms, evsel, &annotate_opts);
+	return symbol__tty_annotate2(&he->ms, evsel);
 }
 
 static void hists__find_annotations(struct hists *hists,
@@ -362,7 +362,6 @@ static void hists__find_annotations(struct hists *hists,
 			int ret;
 			int (*annotate)(struct hist_entry *he,
 					struct evsel *evsel,
-					struct annotation_options *options,
 					struct hist_browser_timer *hbt);
 
 			annotate = dlsym(perf_gtk_handle,
@@ -372,7 +371,7 @@ static void hists__find_annotations(struct hists *hists,
 				return;
 			}
 
-			ret = annotate(he, evsel, &annotate_opts, NULL);
+			ret = annotate(he, evsel, NULL);
 			if (!ret || !ann->skip_missing)
 				return;
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 00354d16adb43..169c64e9a01a8 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -729,7 +729,7 @@ static int hists__resort_cb(struct hist_entry *he, void *arg)
 	if (rep->symbol_ipc && sym && !sym->annotate2) {
 		struct evsel *evsel = hists_to_evsel(he->hists);
 
-		symbol__annotate2(&he->ms, evsel, &annotate_opts, NULL);
+		symbol__annotate2(&he->ms, evsel, NULL);
 	}
 
 	return 0;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ecf98169fd8fd..6ac17763de0e0 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -147,7 +147,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		return err;
 	}
 
-	err = symbol__annotate(&he->ms, evsel, &annotate_opts, NULL);
+	err = symbol__annotate(&he->ms, evsel, NULL);
 	if (err == 0) {
 		top->sym_filter_entry = he;
 	} else {
@@ -263,7 +263,7 @@ static void perf_top__show_details(struct perf_top *top)
 	printf("Showing %s for %s\n", evsel__name(top->sym_evsel), symbol->name);
 	printf("  Events  Pcnt (>=%d%%)\n", annotate_opts.min_pcnt);
 
-	more = symbol__annotate_printf(&he->ms, top->sym_evsel, &annotate_opts);
+	more = symbol__annotate_printf(&he->ms, top->sym_evsel);
 
 	if (top->evlist->enabled) {
 		if (top->zero)
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index d2470f87344d0..d9f9fa254a71f 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -114,7 +114,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	if (!browser->navkeypressed)
 		ops.width += 1;
 
-	annotation_line__write(al, notes, &ops, ab->opts);
+	annotation_line__write(al, notes, &ops);
 
 	if (ops.current_entry)
 		ab->selection = al;
@@ -884,7 +884,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			continue;
 		}
 		case 'P':
-			map_symbol__annotation_dump(ms, evsel, browser->opts);
+			map_symbol__annotation_dump(ms, evsel);
 			continue;
 		case 't':
 			if (symbol_conf.show_total_period) {
@@ -979,7 +979,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 		return -1;
 
 	if (not_annotated) {
-		err = symbol__annotate2(ms, evsel, opts, &browser.arch);
+		err = symbol__annotate2(ms, evsel, &browser.arch);
 		if (err) {
 			char msg[BUFSIZ];
 			dso->annotate_warned = true;
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 2effac77ca8c6..394861245fd3e 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -162,7 +162,6 @@ static int perf_gtk__annotate_symbol(GtkWidget *window, struct map_symbol *ms,
 }
 
 static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
-				struct annotation_options *options,
 				struct hist_browser_timer *hbt)
 {
 	struct dso *dso = map__dso(ms->map);
@@ -176,7 +175,7 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
 	if (dso->annotate_warned)
 		return -1;
 
-	err = symbol__annotate(ms, evsel, options, NULL);
+	err = symbol__annotate(ms, evsel, NULL);
 	if (err) {
 		char msg[BUFSIZ];
 		dso->annotate_warned = true;
@@ -244,10 +243,9 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
 
 int hist_entry__gtk_annotate(struct hist_entry *he,
 			     struct evsel *evsel,
-			     struct annotation_options *options,
 			     struct hist_browser_timer *hbt)
 {
-	return symbol__gtk_annotate(&he->ms, evsel, options, hbt);
+	return symbol__gtk_annotate(&he->ms, evsel, hbt);
 }
 
 void perf_gtk__show_annotations(void)
diff --git a/tools/perf/ui/gtk/gtk.h b/tools/perf/ui/gtk/gtk.h
index 1e84dceb52671..a2b497f03fd6e 100644
--- a/tools/perf/ui/gtk/gtk.h
+++ b/tools/perf/ui/gtk/gtk.h
@@ -56,13 +56,11 @@ struct evsel;
 struct evlist;
 struct hist_entry;
 struct hist_browser_timer;
-struct annotation_options;
 
 int evlist__gtk_browse_hists(struct evlist *evlist, const char *help,
 			     struct hist_browser_timer *hbt, float min_pcnt);
 int hist_entry__gtk_annotate(struct hist_entry *he,
 			     struct evsel *evsel,
-			     struct annotation_options *options,
 			     struct hist_browser_timer *hbt);
 void perf_gtk__show_annotations(void);
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2a22bd30a98b7..5fa4831631140 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1843,7 +1843,6 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 				   struct annotate_args *args)
 {
 	struct annotation *notes = symbol__annotation(sym);
-	struct annotation_options *opts = args->options;
 	struct bpf_prog_linfo *prog_linfo = NULL;
 	struct bpf_prog_info_node *info_node;
 	int len = sym->end - sym->start;
@@ -1953,7 +1952,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 		prev_buf_size = buf_size;
 		fflush(s);
 
-		if (!opts->hide_src_code && srcline) {
+		if (!annotate_opts.hide_src_code && srcline) {
 			args->offset = -1;
 			args->line = strdup(srcline);
 			args->line_nr = 0;
@@ -2076,7 +2075,7 @@ static char *expand_tabs(char *line, char **storage, size_t *storage_len)
 
 static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 {
-	struct annotation_options *opts = args->options;
+	struct annotation_options *opts = &annotate_opts;
 	struct map *map = args->ms.map;
 	struct dso *dso = map__dso(map);
 	char *command;
@@ -2326,13 +2325,13 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
 }
 
 int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
-		     struct annotation_options *options, struct arch **parch)
+		     struct arch **parch)
 {
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotate_args args = {
 		.evsel		= evsel,
-		.options	= options,
+		.options	= &annotate_opts,
 	};
 	struct perf_env *env = evsel__env(evsel);
 	const char *arch_name = perf_env__arch(env);
@@ -2360,7 +2359,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	}
 
 	args.ms = *ms;
-	if (notes->options && notes->options->full_addr)
+	if (annotate_opts.full_addr)
 		notes->start = map__objdump_2mem(ms->map, ms->sym->start);
 	else
 		notes->start = map__rip_2objdump(ms->map, ms->sym->start);
@@ -2368,12 +2367,12 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	return symbol__disassemble(sym, &args);
 }
 
-static void insert_source_line(struct rb_root *root, struct annotation_line *al,
-			       struct annotation_options *opts)
+static void insert_source_line(struct rb_root *root, struct annotation_line *al)
 {
 	struct annotation_line *iter;
 	struct rb_node **p = &root->rb_node;
 	struct rb_node *parent = NULL;
+	unsigned int percent_type = annotate_opts.percent_type;
 	int i, ret;
 
 	while (*p != NULL) {
@@ -2384,7 +2383,7 @@ static void insert_source_line(struct rb_root *root, struct annotation_line *al,
 		if (ret == 0) {
 			for (i = 0; i < al->data_nr; i++) {
 				iter->data[i].percent_sum += annotation_data__percent(&al->data[i],
-										      opts->percent_type);
+										      percent_type);
 			}
 			return;
 		}
@@ -2397,7 +2396,7 @@ static void insert_source_line(struct rb_root *root, struct annotation_line *al,
 
 	for (i = 0; i < al->data_nr; i++) {
 		al->data[i].percent_sum = annotation_data__percent(&al->data[i],
-								   opts->percent_type);
+								   percent_type);
 	}
 
 	rb_link_node(&al->rb_node, parent, p);
@@ -2519,8 +2518,7 @@ static int annotated_source__addr_fmt_width(struct list_head *lines, u64 start)
 	return 0;
 }
 
-int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel,
-			    struct annotation_options *opts)
+int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel)
 {
 	struct map *map = ms->map;
 	struct symbol *sym = ms->sym;
@@ -2531,6 +2529,7 @@ int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel,
 	struct annotation *notes = symbol__annotation(sym);
 	struct sym_hist *h = annotation__histogram(notes, evsel->core.idx);
 	struct annotation_line *pos, *queue = NULL;
+	struct annotation_options *opts = &annotate_opts;
 	u64 start = map__rip_2objdump(map, sym->start);
 	int printed = 2, queue_len = 0, addr_fmt_width;
 	int more = 0;
@@ -2659,8 +2658,7 @@ static void FILE__write_graph(void *fp, int graph)
 	fputs(s, fp);
 }
 
-static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
-				     struct annotation_options *opts)
+static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotation_write_ops wops = {
@@ -2677,7 +2675,7 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
 	list_for_each_entry(al, &notes->src->source, node) {
 		if (annotation_line__filter(al, notes))
 			continue;
-		annotation_line__write(al, notes, &wops, opts);
+		annotation_line__write(al, notes, &wops);
 		fputc('\n', fp);
 		wops.first_line = false;
 	}
@@ -2685,8 +2683,7 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
 	return 0;
 }
 
-int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
-				struct annotation_options *opts)
+int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel)
 {
 	const char *ev_name = evsel__name(evsel);
 	char buf[1024];
@@ -2708,7 +2705,7 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
 
 	fprintf(fp, "%s() %s\nEvent: %s\n\n",
 		ms->sym->name, map__dso(ms->map)->long_name, ev_name);
-	symbol__annotate_fprintf2(ms->sym, fp, opts);
+	symbol__annotate_fprintf2(ms->sym, fp);
 
 	fclose(fp);
 	err = 0;
@@ -2884,24 +2881,24 @@ void annotation__init_column_widths(struct annotation *notes, struct symbol *sym
 
 void annotation__update_column_widths(struct annotation *notes)
 {
-	if (notes->options->use_offset)
+	if (annotate_opts.use_offset)
 		notes->widths.target = notes->widths.min_addr;
-	else if (notes->options->full_addr)
+	else if (annotate_opts.full_addr)
 		notes->widths.target = BITS_PER_LONG / 4;
 	else
 		notes->widths.target = notes->widths.max_addr;
 
 	notes->widths.addr = notes->widths.target;
 
-	if (notes->options->show_nr_jumps)
+	if (annotate_opts.show_nr_jumps)
 		notes->widths.addr += notes->widths.jumps + 1;
 }
 
 void annotation__toggle_full_addr(struct annotation *notes, struct map_symbol *ms)
 {
-	notes->options->full_addr = !notes->options->full_addr;
+	annotate_opts.full_addr = !annotate_opts.full_addr;
 
-	if (notes->options->full_addr)
+	if (annotate_opts.full_addr)
 		notes->start = map__objdump_2mem(ms->map, ms->sym->start);
 	else
 		notes->start = map__rip_2objdump(ms->map, ms->sym->start);
@@ -2910,8 +2907,7 @@ void annotation__toggle_full_addr(struct annotation *notes, struct map_symbol *m
 }
 
 static void annotation__calc_lines(struct annotation *notes, struct map *map,
-				   struct rb_root *root,
-				   struct annotation_options *opts)
+				   struct rb_root *root)
 {
 	struct annotation_line *al;
 	struct rb_root tmp_root = RB_ROOT;
@@ -2924,7 +2920,7 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 			double percent;
 
 			percent = annotation_data__percent(&al->data[i],
-							   opts->percent_type);
+							   annotate_opts.percent_type);
 
 			if (percent > percent_max)
 				percent_max = percent;
@@ -2935,22 +2931,20 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 
 		al->path = get_srcline(map__dso(map), notes->start + al->offset, NULL,
 				       false, true, notes->start + al->offset);
-		insert_source_line(&tmp_root, al, opts);
+		insert_source_line(&tmp_root, al);
 	}
 
 	resort_source_line(root, &tmp_root);
 }
 
-static void symbol__calc_lines(struct map_symbol *ms, struct rb_root *root,
-			       struct annotation_options *opts)
+static void symbol__calc_lines(struct map_symbol *ms, struct rb_root *root)
 {
 	struct annotation *notes = symbol__annotation(ms->sym);
 
-	annotation__calc_lines(notes, ms->map, root, opts);
+	annotation__calc_lines(notes, ms->map, root);
 }
 
-int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel,
-			  struct annotation_options *opts)
+int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel)
 {
 	struct dso *dso = map__dso(ms->map);
 	struct symbol *sym = ms->sym;
@@ -2959,7 +2953,7 @@ int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel,
 	char buf[1024];
 	int err;
 
-	err = symbol__annotate2(ms, evsel, opts, NULL);
+	err = symbol__annotate2(ms, evsel, NULL);
 	if (err) {
 		char msg[BUFSIZ];
 
@@ -2969,31 +2963,31 @@ int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel,
 		return -1;
 	}
 
-	if (opts->print_lines) {
-		srcline_full_filename = opts->full_path;
-		symbol__calc_lines(ms, &source_line, opts);
+	if (annotate_opts.print_lines) {
+		srcline_full_filename = annotate_opts.full_path;
+		symbol__calc_lines(ms, &source_line);
 		print_summary(&source_line, dso->long_name);
 	}
 
 	hists__scnprintf_title(hists, buf, sizeof(buf));
 	fprintf(stdout, "%s, [percent: %s]\n%s() %s\n",
-		buf, percent_type_str(opts->percent_type), sym->name, dso->long_name);
-	symbol__annotate_fprintf2(sym, stdout, opts);
+		buf, percent_type_str(annotate_opts.percent_type), sym->name,
+		dso->long_name);
+	symbol__annotate_fprintf2(sym, stdout);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
 
 	return 0;
 }
 
-int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel,
-			 struct annotation_options *opts)
+int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel)
 {
 	struct dso *dso = map__dso(ms->map);
 	struct symbol *sym = ms->sym;
 	struct rb_root source_line = RB_ROOT;
 	int err;
 
-	err = symbol__annotate(ms, evsel, opts, NULL);
+	err = symbol__annotate(ms, evsel, NULL);
 	if (err) {
 		char msg[BUFSIZ];
 
@@ -3005,13 +2999,13 @@ int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel,
 
 	symbol__calc_percent(sym, evsel);
 
-	if (opts->print_lines) {
-		srcline_full_filename = opts->full_path;
-		symbol__calc_lines(ms, &source_line, opts);
+	if (annotate_opts.print_lines) {
+		srcline_full_filename = annotate_opts.full_path;
+		symbol__calc_lines(ms, &source_line);
 		print_summary(&source_line, dso->long_name);
 	}
 
-	symbol__annotate_printf(ms, evsel, opts);
+	symbol__annotate_printf(ms, evsel);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
 
@@ -3072,7 +3066,7 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
 		obj__printf(obj, "  ");
 	}
 
-	disasm_line__scnprintf(dl, bf, size, !notes->options->use_offset, notes->widths.max_ins_name);
+	disasm_line__scnprintf(dl, bf, size, !annotate_opts.use_offset, notes->widths.max_ins_name);
 }
 
 static void ipc_coverage_string(char *bf, int size, struct annotation *notes)
@@ -3154,7 +3148,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		else
 			obj__printf(obj, "%*s ", ANNOTATION__IPC_WIDTH - 1, "IPC");
 
-		if (!notes->options->show_minmax_cycle) {
+		if (!annotate_opts.show_minmax_cycle) {
 			if (al->cycles && al->cycles->avg)
 				obj__printf(obj, "%*" PRIu64 " ",
 					   ANNOTATION__CYCLES_WIDTH - 1, al->cycles->avg);
@@ -3198,7 +3192,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 	if (!*al->line)
 		obj__printf(obj, "%-*s", width - pcnt_width - cycles_width, " ");
 	else if (al->offset == -1) {
-		if (al->line_nr && notes->options->show_linenr)
+		if (al->line_nr && annotate_opts.show_linenr)
 			printed = scnprintf(bf, sizeof(bf), "%-*d ", notes->widths.addr + 1, al->line_nr);
 		else
 			printed = scnprintf(bf, sizeof(bf), "%-*s  ", notes->widths.addr, " ");
@@ -3208,15 +3202,15 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		u64 addr = al->offset;
 		int color = -1;
 
-		if (!notes->options->use_offset)
+		if (!annotate_opts.use_offset)
 			addr += notes->start;
 
-		if (!notes->options->use_offset) {
+		if (!annotate_opts.use_offset) {
 			printed = scnprintf(bf, sizeof(bf), "%" PRIx64 ": ", addr);
 		} else {
 			if (al->jump_sources &&
-			    notes->options->offset_level >= ANNOTATION__OFFSET_JUMP_TARGETS) {
-				if (notes->options->show_nr_jumps) {
+			    annotate_opts.offset_level >= ANNOTATION__OFFSET_JUMP_TARGETS) {
+				if (annotate_opts.show_nr_jumps) {
 					int prev;
 					printed = scnprintf(bf, sizeof(bf), "%*d ",
 							    notes->widths.jumps,
@@ -3230,9 +3224,9 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 				printed = scnprintf(bf, sizeof(bf), "%*" PRIx64 ": ",
 						    notes->widths.target, addr);
 			} else if (ins__is_call(&disasm_line(al)->ins) &&
-				   notes->options->offset_level >= ANNOTATION__OFFSET_CALL) {
+				   annotate_opts.offset_level >= ANNOTATION__OFFSET_CALL) {
 				goto print_addr;
-			} else if (notes->options->offset_level == ANNOTATION__MAX_OFFSET_LEVEL) {
+			} else if (annotate_opts.offset_level == ANNOTATION__MAX_OFFSET_LEVEL) {
 				goto print_addr;
 			} else {
 				printed = scnprintf(bf, sizeof(bf), "%-*s  ",
@@ -3254,19 +3248,18 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 }
 
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
-			    struct annotation_write_ops *wops,
-			    struct annotation_options *opts)
+			    struct annotation_write_ops *wops)
 {
 	__annotation_line__write(al, notes, wops->first_line, wops->current_entry,
 				 wops->change_color, wops->width, wops->obj,
-				 opts->percent_type,
+				 annotate_opts.percent_type,
 				 wops->set_color, wops->set_percent_color,
 				 wops->set_jumps_percent_color, wops->printf,
 				 wops->write_graph);
 }
 
 int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
-		      struct annotation_options *options, struct arch **parch)
+		      struct arch **parch)
 {
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
@@ -3280,11 +3273,11 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 	if (evsel__is_group_event(evsel))
 		nr_pcnt = evsel->core.nr_members;
 
-	err = symbol__annotate(ms, evsel, options, parch);
+	err = symbol__annotate(ms, evsel, parch);
 	if (err)
 		goto out_free_offsets;
 
-	notes->options = options;
+	notes->options = &annotate_opts;
 
 	symbol__calc_percent(sym, evsel);
 
@@ -3412,10 +3405,9 @@ static unsigned int parse_percent_type(char *str1, char *str2)
 	return type;
 }
 
-int annotate_parse_percent_type(const struct option *opt, const char *_str,
+int annotate_parse_percent_type(const struct option *opt __maybe_unused, const char *_str,
 				int unset __maybe_unused)
 {
-	struct annotation_options *opts = opt->value;
 	unsigned int type;
 	char *str1, *str2;
 	int err = -1;
@@ -3434,7 +3426,7 @@ int annotate_parse_percent_type(const struct option *opt, const char *_str,
 	if (type == (unsigned int) -1)
 		type = parse_percent_type(str2, str1);
 	if (type != (unsigned int) -1) {
-		opts->percent_type = type;
+		annotate_opts.percent_type = type;
 		err = 0;
 	}
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index d45a777f7229b..0fa72eb559ac4 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -220,8 +220,7 @@ struct annotation_write_ops {
 };
 
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
-			    struct annotation_write_ops *ops,
-			    struct annotation_options *opts);
+			    struct annotation_write_ops *ops);
 
 int __annotation__scnprintf_samples_period(struct annotation *notes,
 					   char *bf, size_t size,
@@ -366,11 +365,9 @@ void symbol__annotate_zero_histograms(struct symbol *sym);
 
 int symbol__annotate(struct map_symbol *ms,
 		     struct evsel *evsel,
-		     struct annotation_options *options,
 		     struct arch **parch);
 int symbol__annotate2(struct map_symbol *ms,
 		      struct evsel *evsel,
-		      struct annotation_options *options,
 		      struct arch **parch);
 
 enum symbol_disassemble_errno {
@@ -397,20 +394,18 @@ enum symbol_disassemble_errno {
 
 int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, size_t buflen);
 
-int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel,
-			    struct annotation_options *options);
+int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel);
 void symbol__annotate_zero_histogram(struct symbol *sym, int evidx);
 void symbol__annotate_decay_histogram(struct symbol *sym, int evidx);
 void annotated_source__purge(struct annotated_source *as);
 
-int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
-				struct annotation_options *opts);
+int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel);
 
 bool ui__has_annotation(void);
 
-int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel, struct annotation_options *opts);
+int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel);
 
-int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel, struct annotation_options *opts);
+int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel);
 
 #ifdef HAVE_SLANG_SUPPORT
 int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
-- 
2.43.0




