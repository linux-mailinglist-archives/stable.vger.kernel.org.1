Return-Path: <stable+bounces-55719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B499164E0
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 12:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D3C1F214B6
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 10:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6E8148319;
	Tue, 25 Jun 2024 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zIjK2fI5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A79713C90B;
	Tue, 25 Jun 2024 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309736; cv=none; b=Qoy9Bnx2CvhOh7LEVUyMTEamHrTcvZofgIggoLHfllxicYjEKfFbz/0JMjHMxc75LQg6LcSNHAGstZPqoi/ItTr+Tj1ZXa9waKoytRFVj18U7o2/DRwxZsKsI391w5DIMF19GWDouZKimT+Y3QR/FNdWtIO/Dpdo4+V2P/po7Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309736; c=relaxed/simple;
	bh=qg1XOAK0PQBtypvFLCYBNF0ZG7Nje2lXibfyB3h7coc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CO5BdEWFXLMjuSeYFZC25kxhKmq/7Cwp541OqpIsF1EBA7j11b8qoAjx8qo9kFCRyYxXqpxtY3qqaMm1dJvsN6DnwsQR2G64exbhFnkOY/rw2/cXczAR9EpXElIzR77Dgk1gl5xhxEdE0mzmrBaKmrHTdAY2w9gs1EMRCa3iKks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zIjK2fI5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F58C32781;
	Tue, 25 Jun 2024 10:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719309736;
	bh=qg1XOAK0PQBtypvFLCYBNF0ZG7Nje2lXibfyB3h7coc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zIjK2fI5R1svP6NPo4JyoPZ7YH5xvRJU+ZxrcHvFe3VIdR9JllvjceSYRwco9hVqw
	 30qIFyxRpyz6sgEU1mIJYZDybDgLrjEEI0nGlSn7Hpdzp+VNMntzN+3p1yEdEEw2GB
	 K423ePRBSp1x/64ucLJlBp6SYbT38KpKZxzlhwiI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Changbin Du <changbin.du@huawei.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	changbin.du@gmail.com,
	Thomas Richter <tmricht@linux.ibm.com>,
	Andi Kleen <ak@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 117/131] perf: script: add raw|disasm arguments to --insn-trace option
Date: Tue, 25 Jun 2024 11:34:32 +0200
Message-ID: <20240625085530.382689510@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085525.931079317@linuxfoundation.org>
References: <20240625085525.931079317@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Changbin Du <changbin.du@huawei.com>

[ Upstream commit 6750ba4b6442fa5ea4bf5c0e4b4ff8b0249ef71d ]

Now '--insn-trace' accept a argument to specify the output format:
  - raw: display raw instructions.
  - disasm: display mnemonic instructions (if capstone is installed).

$ sudo perf script --insn-trace=raw
              ls 1443864 [006] 2275506.209908875:      7f216b426100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: 48 89 e7
              ls 1443864 [006] 2275506.209908875:      7f216b426103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: e8 e8 0c 00 00
              ls 1443864 [006] 2275506.209908875:      7f216b426df0 _dl_start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: f3 0f 1e fa

$ sudo perf script --insn-trace=disasm
              ls 1443864 [006] 2275506.209908875:      7f216b426100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)		movq %rsp, %rdi
              ls 1443864 [006] 2275506.209908875:      7f216b426103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)		callq _dl_start+0x0
              ls 1443864 [006] 2275506.209908875:      7f216b426df0 _dl_start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)	illegal instruction
              ls 1443864 [006] 2275506.209908875:      7f216b426df4 _dl_start+0x4 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)	pushq %rbp
              ls 1443864 [006] 2275506.209908875:      7f216b426df5 _dl_start+0x5 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)	movq %rsp, %rbp
              ls 1443864 [006] 2275506.209908875:      7f216b426df8 _dl_start+0x8 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)	pushq %r15

Signed-off-by: Changbin Du <changbin.du@huawei.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: changbin.du@gmail.com
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240217074046.4100789-5-changbin.du@huawei.com
Stable-dep-of: d4a98b45fbe6 ("perf script: Show also errors for --insn-trace option")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Documentation/perf-script.txt |  7 ++++---
 tools/perf/builtin-script.c              | 22 ++++++++++++++++++----
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 68e37de5fae47..96ec1dec9efe3 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -438,9 +438,10 @@ include::itrace.txt[]
 	will be printed. Each entry has function name and file/line. Enabled by
 	default, disable with --no-inline.
 
---insn-trace::
-	Show instruction stream for intel_pt traces. Combine with --xed to
-	show disassembly.
+--insn-trace[=<raw|disasm>]::
+	Show instruction stream in bytes (raw) or disassembled (disasm)
+	for intel_pt traces. The default is 'raw'. To use xed, combine
+	'raw' with --xed to show disassembly done by xed.
 
 --xed::
 	Run xed disassembler on output. Requires installing the xed disassembler.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a794a3d2e47b7..af91fdcabb05c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3712,10 +3712,24 @@ static int perf_script__process_auxtrace_info(struct perf_session *session,
 #endif
 
 static int parse_insn_trace(const struct option *opt __maybe_unused,
-			    const char *str __maybe_unused,
-			    int unset __maybe_unused)
+			    const char *str, int unset __maybe_unused)
 {
-	parse_output_fields(NULL, "+insn,-event,-period", 0);
+	const char *fields = "+insn,-event,-period";
+	int ret;
+
+	if (str) {
+		if (strcmp(str, "disasm") == 0)
+			fields = "+disasm,-event,-period";
+		else if (strlen(str) != 0 && strcmp(str, "raw") != 0) {
+			fprintf(stderr, "Only accept raw|disasm\n");
+			return -EINVAL;
+		}
+	}
+
+	ret = parse_output_fields(NULL, fields, 0);
+	if (ret < 0)
+		return ret;
+
 	itrace_parse_synth_opts(opt, "i0ns", 0);
 	symbol_conf.nanosecs = true;
 	return 0;
@@ -3859,7 +3873,7 @@ int cmd_script(int argc, const char **argv)
 		   "only consider these symbols"),
 	OPT_INTEGER(0, "addr-range", &symbol_conf.addr_range,
 		    "Use with -S to list traced records within address range"),
-	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, NULL,
+	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, "raw|disasm",
 			"Decode instructions from itrace", parse_insn_trace),
 	OPT_CALLBACK_OPTARG(0, "xed", NULL, NULL, NULL,
 			"Run xed disassembler on output", parse_xed),
-- 
2.43.0




