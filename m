Return-Path: <stable+bounces-95500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16889D925A
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 08:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BD6EB2369B
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 07:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD731898FC;
	Tue, 26 Nov 2024 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U1PYhCIU"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3015187876
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732605733; cv=none; b=GFX15ja3niC+5AFv0kQr7GYx2qvAGT4XPc/ObDF117FbevVNr4ZUW1pOLo4FZpASDGkVviFvl9rroPkpUXdD8WumMtJEnAW1ekfmVGdQ8dT1wDiww3n4+HDsYy2hqwMXnFDuJvDwtEDRTO4GAqckUHHlvCHNnC4iZEiQMAlCS3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732605733; c=relaxed/simple;
	bh=Ht3vrSZbcO53Ax7kESKVNNLl17YCBc59kuC+CG6Kapk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKXUKR8YIGeWZi9rzlrC1ubMWYe5bdBYzu891WSvwDCi1NSx3JQCw1mxr8x5nUjgI/ytzPS+O5NATKQgQHOqKwUqhcRQDufztFaYNO3pdx145VUNzXbRIiUmtZZgRSPAouxS7bLTL9nkGU+RYZsyDQoPxPEVuiq3vKu4Ki+S37c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U1PYhCIU; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-53dded7be84so2963579e87.1
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 23:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732605730; x=1733210530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzUnJ1ajQ+z8Yp/7A/gAy2QmLtWRd8oVcaCzk9iW4/s=;
        b=U1PYhCIUT8qdc3oghyzDnbq3/Po/J3E2lHcw+Q+ITJT1FNc4vdIX0S7RJT0dgY+Ohd
         jcs3waw4cQqYj2S0H0kgZ7+S9gXlFWUaVsAj3dciIDZEBGbjlhvR4LxkkrY5451CpKjR
         RDbbTsSoW1plq5dPLhU3PiWozV+pKTu/xo9VHYk44OuMPGSpSwrdlhWa7j3hw4AjHKnG
         Nl4r3LM+aBFflvLBEosIilib91FJf7y/XzViVEtwWSbFpGYPCeocjhe/71wPHRHDCM+H
         WBoJ5tVCRqXkhFE2Lcv6XVDpPLLm72JG931FF1Pp5Cm4q4sQzO8grE6OU259D7C0377X
         oP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732605730; x=1733210530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzUnJ1ajQ+z8Yp/7A/gAy2QmLtWRd8oVcaCzk9iW4/s=;
        b=g6v4pnZgc6R8SYLzTotILHasqlkBHRBUNCDecAkJxWLEu5kW9oiv7fabL1jk5Zxejx
         BKBwML4OcwaL6KljPH/6Im3focU17QqiRnFdYfOB5qAMXj08nk49BO0B/gATHJelTmFH
         KmYoZDkRGrVpJuHiGeyMFmivHtqLztVUpJ7KMrZMJ3vOXl/X4fSQR/rFxma4aaLcFB4a
         R5DKok4n6sdFZHAAw8uu4BJGNPRNcpe3HweEhH/SeQMZX1xcl+QWDe28MOXGU4M/tRET
         N7KLHotz1f23freu2I+oPGQka+pYIClq3sDH+MUiv6QwvowB4k5Lqd3w+Ko6kbeMubHp
         gP5w==
X-Gm-Message-State: AOJu0Yz2vHQiM1lpRFlc86/YZvRlBZnKwM+eTEO4bdv7VpLemRCphZfY
	ZfBLjAiRQNg0NN4cOPDj49VwveehP984/740DMgIC2qkQU278So6tzhrvDbDhDMRwiMN8gx0nc9
	COO2YM1Qr0WI=
X-Gm-Gg: ASbGncv8P/0jdRIAxynFflxc3WLSFLyI3wnOyW29LmScqpE0S0Ey01RioBtkBsPQTTl
	QdQADzgJGF4KA40YC9YedSIIxFFmR26ywnHBA4zAp7QgB+0UaTxtm1rsZKEa26UQ/FzgF/+fODH
	RdsN1cSl780RcWQy7CfxfFkrcYdlSKFE2OOZp6QGCvFMLKGvF7TWnHQAXeI486tc+LqkvNIrFkg
	ayD00fj9q1kojulSVmZsEjAdN33Jb0kdCQbIC4rRz6JqwRHbzU=
X-Google-Smtp-Source: AGHT+IF426HQrRCO4j3Z43oA6PMDhXAtVxc7YFuvcoYrXxbfnnZ9t36hhK4QXysUOoFXJK3XJ/rBWA==
X-Received: by 2002:ac2:4bd3:0:b0:53d:d486:9705 with SMTP id 2adb3069b0e04-53dd4869906mr7785429e87.9.1732605729563;
        Mon, 25 Nov 2024 23:22:09 -0800 (PST)
Received: from localhost ([2401:e180:8891:cc8b:6df8:da33:1f62:8cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc20feasm77225855ad.256.2024.11.25.23.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 23:22:09 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Hao Luo <haoluo@google.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hou Tao <houtao1@huawei.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH stable 6.6 4/8] selftests/bpf: extract utility function for BPF disassembly
Date: Tue, 26 Nov 2024 15:21:26 +0800
Message-ID: <20241126072137.823699-5-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126072137.823699-1-shung-hsi.yu@suse.com>
References: <20241126072137.823699-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit 424ebaa3678b0d7f653dffb08eae90424740e0f4 ]

struct bpf_insn *disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz);

  Disassembles instruction 'insn' to a text buffer 'buf'.
  Removes insn->code hex prefix added by kernel disassembly routine.
  Returns a pointer to the next instruction
  (increments insn by either 1 or 2).

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20240722233844.1406874-5-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/Makefile          |  1 +
 tools/testing/selftests/bpf/disasm_helpers.c  | 51 +++++++++++++
 tools/testing/selftests/bpf/disasm_helpers.h  | 12 +++
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 74 +++----------------
 tools/testing/selftests/bpf/testing_helpers.c |  1 +
 5 files changed, 75 insertions(+), 64 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/disasm_helpers.c
 create mode 100644 tools/testing/selftests/bpf/disasm_helpers.h

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4e569d155da5..a245528db0eb 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -602,6 +602,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 test_loader.c		\
 			 xsk.c			\
 			 disasm.c		\
+			 disasm_helpers.c	\
 			 json_writer.c 		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h
diff --git a/tools/testing/selftests/bpf/disasm_helpers.c b/tools/testing/selftests/bpf/disasm_helpers.c
new file mode 100644
index 000000000000..96b1f2ffe438
--- /dev/null
+++ b/tools/testing/selftests/bpf/disasm_helpers.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+#include <bpf/bpf.h>
+#include "disasm.h"
+
+struct print_insn_context {
+	char *buf;
+	size_t sz;
+};
+
+static void print_insn_cb(void *private_data, const char *fmt, ...)
+{
+	struct print_insn_context *ctx = private_data;
+	va_list args;
+
+	va_start(args, fmt);
+	vsnprintf(ctx->buf, ctx->sz, fmt, args);
+	va_end(args);
+}
+
+struct bpf_insn *disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz)
+{
+	struct print_insn_context ctx = {
+		.buf = buf,
+		.sz = buf_sz,
+	};
+	struct bpf_insn_cbs cbs = {
+		.cb_print	= print_insn_cb,
+		.private_data	= &ctx,
+	};
+	char *tmp, *pfx_end, *sfx_start;
+	bool double_insn;
+	int len;
+
+	print_bpf_insn(&cbs, insn, true);
+	/* We share code with kernel BPF disassembler, it adds '(FF) ' prefix
+	 * for each instruction (FF stands for instruction `code` byte).
+	 * Remove the prefix inplace, and also simplify call instructions.
+	 * E.g.: "(85) call foo#10" -> "call foo".
+	 * Also remove newline in the end (the 'max(strlen(buf) - 1, 0)' thing).
+	 */
+	pfx_end = buf + 5;
+	sfx_start = buf + max((int)strlen(buf) - 1, 0);
+	if (strncmp(pfx_end, "call ", 5) == 0 && (tmp = strrchr(buf, '#')))
+		sfx_start = tmp;
+	len = sfx_start - pfx_end;
+	memmove(buf, pfx_end, len);
+	buf[len] = 0;
+	double_insn = insn->code == (BPF_LD | BPF_IMM | BPF_DW);
+	return insn + (double_insn ? 2 : 1);
+}
diff --git a/tools/testing/selftests/bpf/disasm_helpers.h b/tools/testing/selftests/bpf/disasm_helpers.h
new file mode 100644
index 000000000000..7b26cab70099
--- /dev/null
+++ b/tools/testing/selftests/bpf/disasm_helpers.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+
+#ifndef __DISASM_HELPERS_H
+#define __DISASM_HELPERS_H
+
+#include <stdlib.h>
+
+struct bpf_insn;
+
+struct bpf_insn *disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz);
+
+#endif /* __DISASM_HELPERS_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
index 3b7c57fe55a5..2b01a97d5d36 100644
--- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
+++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
@@ -10,7 +10,8 @@
 #include "bpf/btf.h"
 #include "bpf_util.h"
 #include "linux/filter.h"
-#include "disasm.h"
+#include "linux/kernel.h"
+#include "disasm_helpers.h"
 
 #define MAX_PROG_TEXT_SZ (32 * 1024)
 
@@ -626,63 +627,6 @@ static bool match_pattern(struct btf *btf, char *pattern, char *text, char *reg_
 	return false;
 }
 
-static void print_insn(void *private_data, const char *fmt, ...)
-{
-	va_list args;
-
-	va_start(args, fmt);
-	vfprintf((FILE *)private_data, fmt, args);
-	va_end(args);
-}
-
-/* Disassemble instructions to a stream */
-static void print_xlated(FILE *out, struct bpf_insn *insn, __u32 len)
-{
-	const struct bpf_insn_cbs cbs = {
-		.cb_print	= print_insn,
-		.cb_call	= NULL,
-		.cb_imm		= NULL,
-		.private_data	= out,
-	};
-	bool double_insn = false;
-	int i;
-
-	for (i = 0; i < len; i++) {
-		if (double_insn) {
-			double_insn = false;
-			continue;
-		}
-
-		double_insn = insn[i].code == (BPF_LD | BPF_IMM | BPF_DW);
-		print_bpf_insn(&cbs, insn + i, true);
-	}
-}
-
-/* We share code with kernel BPF disassembler, it adds '(FF) ' prefix
- * for each instruction (FF stands for instruction `code` byte).
- * This function removes the prefix inplace for each line in `str`.
- */
-static void remove_insn_prefix(char *str, int size)
-{
-	const int prefix_size = 5;
-
-	int write_pos = 0, read_pos = prefix_size;
-	int len = strlen(str);
-	char c;
-
-	size = min(size, len);
-
-	while (read_pos < size) {
-		c = str[read_pos++];
-		if (c == 0)
-			break;
-		str[write_pos++] = c;
-		if (c == '\n')
-			read_pos += prefix_size;
-	}
-	str[write_pos] = 0;
-}
-
 struct prog_info {
 	char *prog_kind;
 	enum bpf_prog_type prog_type;
@@ -697,9 +641,10 @@ static void match_program(struct btf *btf,
 			  char *reg_map[][2],
 			  bool skip_first_insn)
 {
-	struct bpf_insn *buf = NULL;
+	struct bpf_insn *buf = NULL, *insn, *insn_end;
 	int err = 0, prog_fd = 0;
 	FILE *prog_out = NULL;
+	char insn_buf[64];
 	char *text = NULL;
 	__u32 cnt = 0;
 
@@ -737,12 +682,13 @@ static void match_program(struct btf *btf,
 		PRINT_FAIL("Can't open memory stream\n");
 		goto out;
 	}
-	if (skip_first_insn)
-		print_xlated(prog_out, buf + 1, cnt - 1);
-	else
-		print_xlated(prog_out, buf, cnt);
+	insn_end = buf + cnt;
+	insn = buf + (skip_first_insn ? 1 : 0);
+	while (insn < insn_end) {
+		insn = disasm_insn(insn, insn_buf, sizeof(insn_buf));
+		fprintf(prog_out, "%s\n", insn_buf);
+	}
 	fclose(prog_out);
-	remove_insn_prefix(text, MAX_PROG_TEXT_SZ);
 
 	ASSERT_TRUE(match_pattern(btf, pattern, text, reg_map),
 		    pinfo->prog_kind);
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 622c2c4245e0..c6a82e779aca 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
+#include "disasm.h"
 #include "test_progs.h"
 #include "testing_helpers.h"
 #include <linux/membarrier.h>
-- 
2.47.0


