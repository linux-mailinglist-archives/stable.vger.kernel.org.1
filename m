Return-Path: <stable+bounces-79010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8966E98D616
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFD75B2305B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDF41D0490;
	Wed,  2 Oct 2024 13:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kvTeteKS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ACA1D0412;
	Wed,  2 Oct 2024 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876177; cv=none; b=IaodWpGWlJdyMhndH/mMObUfaC3lzoEjHRcKwBH8tb8lih5jxicInJlQdS1Db0GukUVB0/QTZvyH8pljd/j4dmVapV0H3cTMGvUzBsZiZB7Q+Y0koM2AsBB5c18DOttoebm/QDUWHn35IQE1G8s0eyM/o29DfdfQjdLZYV2MXAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876177; c=relaxed/simple;
	bh=BsplhSWHTUbbVV3Solq/F/wEika2Y37/JH/ivnFwCQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qy7l0ZSUO8VQkP/6mw3rXdGQR2zjiipui4daW0MpoSOzXkjOeL4c009zEi6Mo92ckNumsO8icZoTcu1+d24gYpSt8ld2Z8iJ5CA02Sm/AVS+z4+TIcgAANeyHaCIeo9WNcoIPJrV14czOToc9ReBNd8PZFYJaWRKbZ5DcMLMJmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kvTeteKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8DBC4CEC5;
	Wed,  2 Oct 2024 13:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876176;
	bh=BsplhSWHTUbbVV3Solq/F/wEika2Y37/JH/ivnFwCQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvTeteKSzupkaXctF3v4XULo6TYt7DiQCpDxYrbmhzYkOusbxNB+ljPPFMMk7yMhb
	 rw4z6c4OmFst1wzD9Hw9PdDySy6fySJha1uHl/JNUib8tTrE7w3GIsXfbElhvrFALv
	 t8iYclafQO4XRn8No2yjOzTzgGRR1az9d84X8Pis=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 324/695] perf bpf: Move BPF disassembly routines to separate file to avoid clash with capstone bpf headers
Date: Wed,  2 Oct 2024 14:55:22 +0200
Message-ID: <20241002125835.382118691@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit ea59b70a8418a313d6f2ab48a957de015fc33018 ]

There is a clash of the libbpf and capstone libraries, that ends up
with:

  In file included from /usr/include/capstone/capstone.h:325,
                   from util/disasm.c:1513:
  /usr/include/capstone/bpf.h:94:14: error: ‘bpf_insn’ defined as wrong kind of tag
     94 | typedef enum bpf_insn {

So far we're just trying to avoid this by not having both headers
included in the same .c or .h file, do it one more time by moving the
BPF diassembly routines from util/disasm.c to util/disasm_bpf.c.

This is only being hit when building with BUILD_NONDISTRO=1, i.e.
building with binutils-devel, that isn't the in the default build due to
a licencing clash. We need to reimplement what is now isolated in
util/disasm_bpf.c using some other library to have BPF annotation
feature that now only is available with BUILD_NONDISTRO=1.

Fixes: 6d17edc113de1e21 ("perf annotate: Use libcapstone to disassemble")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/ZqpUSKPxMwaQKORr@x1
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/Build        |   1 +
 tools/perf/util/disasm.c     | 187 +--------------------------------
 tools/perf/util/disasm_bpf.c | 195 +++++++++++++++++++++++++++++++++++
 tools/perf/util/disasm_bpf.h |  12 +++
 4 files changed, 209 insertions(+), 186 deletions(-)
 create mode 100644 tools/perf/util/disasm_bpf.c
 create mode 100644 tools/perf/util/disasm_bpf.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 0f18fe81ef0b2..b24360c04aaea 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -13,6 +13,7 @@ perf-util-y += copyfile.o
 perf-util-y += ctype.o
 perf-util-y += db-export.o
 perf-util-y += disasm.o
+perf-util-y += disasm_bpf.o
 perf-util-y += env.o
 perf-util-y += event.o
 perf-util-y += evlist.o
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index e10558b79504b..766cbd005f32a 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -15,6 +15,7 @@
 #include "build-id.h"
 #include "debug.h"
 #include "disasm.h"
+#include "disasm_bpf.h"
 #include "dso.h"
 #include "env.h"
 #include "evsel.h"
@@ -1164,192 +1165,6 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	return 0;
 }
 
-#if defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
-#define PACKAGE "perf"
-#include <bfd.h>
-#include <dis-asm.h>
-#include <bpf/bpf.h>
-#include <bpf/btf.h>
-#include <bpf/libbpf.h>
-#include <linux/btf.h>
-#include <tools/dis-asm-compat.h>
-
-#include "bpf-event.h"
-#include "bpf-utils.h"
-
-static int symbol__disassemble_bpf(struct symbol *sym,
-				   struct annotate_args *args)
-{
-	struct annotation *notes = symbol__annotation(sym);
-	struct bpf_prog_linfo *prog_linfo = NULL;
-	struct bpf_prog_info_node *info_node;
-	int len = sym->end - sym->start;
-	disassembler_ftype disassemble;
-	struct map *map = args->ms.map;
-	struct perf_bpil *info_linear;
-	struct disassemble_info info;
-	struct dso *dso = map__dso(map);
-	int pc = 0, count, sub_id;
-	struct btf *btf = NULL;
-	char tpath[PATH_MAX];
-	size_t buf_size;
-	int nr_skip = 0;
-	char *buf;
-	bfd *bfdf;
-	int ret;
-	FILE *s;
-
-	if (dso__binary_type(dso) != DSO_BINARY_TYPE__BPF_PROG_INFO)
-		return SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE;
-
-	pr_debug("%s: handling sym %s addr %" PRIx64 " len %" PRIx64 "\n", __func__,
-		  sym->name, sym->start, sym->end - sym->start);
-
-	memset(tpath, 0, sizeof(tpath));
-	perf_exe(tpath, sizeof(tpath));
-
-	bfdf = bfd_openr(tpath, NULL);
-	if (bfdf == NULL)
-		abort();
-
-	if (!bfd_check_format(bfdf, bfd_object))
-		abort();
-
-	s = open_memstream(&buf, &buf_size);
-	if (!s) {
-		ret = errno;
-		goto out;
-	}
-	init_disassemble_info_compat(&info, s,
-				     (fprintf_ftype) fprintf,
-				     fprintf_styled);
-	info.arch = bfd_get_arch(bfdf);
-	info.mach = bfd_get_mach(bfdf);
-
-	info_node = perf_env__find_bpf_prog_info(dso__bpf_prog(dso)->env,
-						 dso__bpf_prog(dso)->id);
-	if (!info_node) {
-		ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
-		goto out;
-	}
-	info_linear = info_node->info_linear;
-	sub_id = dso__bpf_prog(dso)->sub_id;
-
-	info.buffer = (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
-	info.buffer_length = info_linear->info.jited_prog_len;
-
-	if (info_linear->info.nr_line_info)
-		prog_linfo = bpf_prog_linfo__new(&info_linear->info);
-
-	if (info_linear->info.btf_id) {
-		struct btf_node *node;
-
-		node = perf_env__find_btf(dso__bpf_prog(dso)->env,
-					  info_linear->info.btf_id);
-		if (node)
-			btf = btf__new((__u8 *)(node->data),
-				       node->data_size);
-	}
-
-	disassemble_init_for_target(&info);
-
-#ifdef DISASM_FOUR_ARGS_SIGNATURE
-	disassemble = disassembler(info.arch,
-				   bfd_big_endian(bfdf),
-				   info.mach,
-				   bfdf);
-#else
-	disassemble = disassembler(bfdf);
-#endif
-	if (disassemble == NULL)
-		abort();
-
-	fflush(s);
-	do {
-		const struct bpf_line_info *linfo = NULL;
-		struct disasm_line *dl;
-		size_t prev_buf_size;
-		const char *srcline;
-		u64 addr;
-
-		addr = pc + ((u64 *)(uintptr_t)(info_linear->info.jited_ksyms))[sub_id];
-		count = disassemble(pc, &info);
-
-		if (prog_linfo)
-			linfo = bpf_prog_linfo__lfind_addr_func(prog_linfo,
-								addr, sub_id,
-								nr_skip);
-
-		if (linfo && btf) {
-			srcline = btf__name_by_offset(btf, linfo->line_off);
-			nr_skip++;
-		} else
-			srcline = NULL;
-
-		fprintf(s, "\n");
-		prev_buf_size = buf_size;
-		fflush(s);
-
-		if (!annotate_opts.hide_src_code && srcline) {
-			args->offset = -1;
-			args->line = strdup(srcline);
-			args->line_nr = 0;
-			args->fileloc = NULL;
-			args->ms.sym  = sym;
-			dl = disasm_line__new(args);
-			if (dl) {
-				annotation_line__add(&dl->al,
-						     &notes->src->source);
-			}
-		}
-
-		args->offset = pc;
-		args->line = buf + prev_buf_size;
-		args->line_nr = 0;
-		args->fileloc = NULL;
-		args->ms.sym  = sym;
-		dl = disasm_line__new(args);
-		if (dl)
-			annotation_line__add(&dl->al, &notes->src->source);
-
-		pc += count;
-	} while (count > 0 && pc < len);
-
-	ret = 0;
-out:
-	free(prog_linfo);
-	btf__free(btf);
-	fclose(s);
-	bfd_close(bfdf);
-	return ret;
-}
-#else // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
-static int symbol__disassemble_bpf(struct symbol *sym __maybe_unused,
-				   struct annotate_args *args __maybe_unused)
-{
-	return SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF;
-}
-#endif // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
-
-static int
-symbol__disassemble_bpf_image(struct symbol *sym,
-			      struct annotate_args *args)
-{
-	struct annotation *notes = symbol__annotation(sym);
-	struct disasm_line *dl;
-
-	args->offset = -1;
-	args->line = strdup("to be implemented");
-	args->line_nr = 0;
-	args->fileloc = NULL;
-	dl = disasm_line__new(args);
-	if (dl)
-		annotation_line__add(&dl->al, &notes->src->source);
-
-	zfree(&args->line);
-	return 0;
-}
-
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 #include <capstone/capstone.h>
 
diff --git a/tools/perf/util/disasm_bpf.c b/tools/perf/util/disasm_bpf.c
new file mode 100644
index 0000000000000..1fee71c79b624
--- /dev/null
+++ b/tools/perf/util/disasm_bpf.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "util/annotate.h"
+#include "util/disasm_bpf.h"
+#include "util/symbol.h"
+#include <linux/zalloc.h>
+#include <string.h>
+
+#if defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
+#define PACKAGE "perf"
+#include <bfd.h>
+#include <bpf/bpf.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
+#include <dis-asm.h>
+#include <errno.h>
+#include <linux/btf.h>
+#include <tools/dis-asm-compat.h>
+
+#include "util/bpf-event.h"
+#include "util/bpf-utils.h"
+#include "util/debug.h"
+#include "util/dso.h"
+#include "util/map.h"
+#include "util/env.h"
+#include "util/util.h"
+
+int symbol__disassemble_bpf(struct symbol *sym, struct annotate_args *args)
+{
+	struct annotation *notes = symbol__annotation(sym);
+	struct bpf_prog_linfo *prog_linfo = NULL;
+	struct bpf_prog_info_node *info_node;
+	int len = sym->end - sym->start;
+	disassembler_ftype disassemble;
+	struct map *map = args->ms.map;
+	struct perf_bpil *info_linear;
+	struct disassemble_info info;
+	struct dso *dso = map__dso(map);
+	int pc = 0, count, sub_id;
+	struct btf *btf = NULL;
+	char tpath[PATH_MAX];
+	size_t buf_size;
+	int nr_skip = 0;
+	char *buf;
+	bfd *bfdf;
+	int ret;
+	FILE *s;
+
+	if (dso__binary_type(dso) != DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE;
+
+	pr_debug("%s: handling sym %s addr %" PRIx64 " len %" PRIx64 "\n", __func__,
+		  sym->name, sym->start, sym->end - sym->start);
+
+	memset(tpath, 0, sizeof(tpath));
+	perf_exe(tpath, sizeof(tpath));
+
+	bfdf = bfd_openr(tpath, NULL);
+	if (bfdf == NULL)
+		abort();
+
+	if (!bfd_check_format(bfdf, bfd_object))
+		abort();
+
+	s = open_memstream(&buf, &buf_size);
+	if (!s) {
+		ret = errno;
+		goto out;
+	}
+	init_disassemble_info_compat(&info, s,
+				     (fprintf_ftype) fprintf,
+				     fprintf_styled);
+	info.arch = bfd_get_arch(bfdf);
+	info.mach = bfd_get_mach(bfdf);
+
+	info_node = perf_env__find_bpf_prog_info(dso__bpf_prog(dso)->env,
+						 dso__bpf_prog(dso)->id);
+	if (!info_node) {
+		ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
+		goto out;
+	}
+	info_linear = info_node->info_linear;
+	sub_id = dso__bpf_prog(dso)->sub_id;
+
+	info.buffer = (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
+	info.buffer_length = info_linear->info.jited_prog_len;
+
+	if (info_linear->info.nr_line_info)
+		prog_linfo = bpf_prog_linfo__new(&info_linear->info);
+
+	if (info_linear->info.btf_id) {
+		struct btf_node *node;
+
+		node = perf_env__find_btf(dso__bpf_prog(dso)->env,
+					  info_linear->info.btf_id);
+		if (node)
+			btf = btf__new((__u8 *)(node->data),
+				       node->data_size);
+	}
+
+	disassemble_init_for_target(&info);
+
+#ifdef DISASM_FOUR_ARGS_SIGNATURE
+	disassemble = disassembler(info.arch,
+				   bfd_big_endian(bfdf),
+				   info.mach,
+				   bfdf);
+#else
+	disassemble = disassembler(bfdf);
+#endif
+	if (disassemble == NULL)
+		abort();
+
+	fflush(s);
+	do {
+		const struct bpf_line_info *linfo = NULL;
+		struct disasm_line *dl;
+		size_t prev_buf_size;
+		const char *srcline;
+		u64 addr;
+
+		addr = pc + ((u64 *)(uintptr_t)(info_linear->info.jited_ksyms))[sub_id];
+		count = disassemble(pc, &info);
+
+		if (prog_linfo)
+			linfo = bpf_prog_linfo__lfind_addr_func(prog_linfo,
+								addr, sub_id,
+								nr_skip);
+
+		if (linfo && btf) {
+			srcline = btf__name_by_offset(btf, linfo->line_off);
+			nr_skip++;
+		} else
+			srcline = NULL;
+
+		fprintf(s, "\n");
+		prev_buf_size = buf_size;
+		fflush(s);
+
+		if (!annotate_opts.hide_src_code && srcline) {
+			args->offset = -1;
+			args->line = strdup(srcline);
+			args->line_nr = 0;
+			args->fileloc = NULL;
+			args->ms.sym  = sym;
+			dl = disasm_line__new(args);
+			if (dl) {
+				annotation_line__add(&dl->al,
+						     &notes->src->source);
+			}
+		}
+
+		args->offset = pc;
+		args->line = buf + prev_buf_size;
+		args->line_nr = 0;
+		args->fileloc = NULL;
+		args->ms.sym  = sym;
+		dl = disasm_line__new(args);
+		if (dl)
+			annotation_line__add(&dl->al, &notes->src->source);
+
+		pc += count;
+	} while (count > 0 && pc < len);
+
+	ret = 0;
+out:
+	free(prog_linfo);
+	btf__free(btf);
+	fclose(s);
+	bfd_close(bfdf);
+	return ret;
+}
+#else // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
+int symbol__disassemble_bpf(struct symbol *sym __maybe_unused, struct annotate_args *args __maybe_unused)
+{
+	return SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF;
+}
+#endif // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
+
+int symbol__disassemble_bpf_image(struct symbol *sym, struct annotate_args *args)
+{
+	struct annotation *notes = symbol__annotation(sym);
+	struct disasm_line *dl;
+
+	args->offset = -1;
+	args->line = strdup("to be implemented");
+	args->line_nr = 0;
+	args->fileloc = NULL;
+	dl = disasm_line__new(args);
+	if (dl)
+		annotation_line__add(&dl->al, &notes->src->source);
+
+	zfree(&args->line);
+	return 0;
+}
diff --git a/tools/perf/util/disasm_bpf.h b/tools/perf/util/disasm_bpf.h
new file mode 100644
index 0000000000000..2ecb19545388b
--- /dev/null
+++ b/tools/perf/util/disasm_bpf.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#ifndef __PERF_DISASM_BPF_H
+#define __PERF_DISASM_BPF_H
+
+struct symbol;
+struct annotate_args;
+
+int symbol__disassemble_bpf(struct symbol *sym, struct annotate_args *args);
+int symbol__disassemble_bpf_image(struct symbol *sym, struct annotate_args *args);
+
+#endif /* __PERF_DISASM_BPF_H */
-- 
2.43.0




