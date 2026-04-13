Return-Path: <stable+bounces-235984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDSjIVLB3GkaWAkAu9opvQ
	(envelope-from <stable+bounces-235984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:11:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E42753EA636
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F8393011F0D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422013612F1;
	Mon, 13 Apr 2026 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=csmantle.top header.i=@csmantle.top header.b="CBtIKUKp";
	dkim=pass (3072-bit key) header.d=csmantle.top header.i=@csmantle.top header.b="BuiosNpQ"
X-Original-To: stable@vger.kernel.org
Received: from mail.srv.csmantle.top (mail.srv.csmantle.top [77.93.157.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3050835A3BF;
	Mon, 13 Apr 2026 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.157.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776074738; cv=none; b=e0Yrjar2pV7naV9kA2NGKiTCdI1UjaPMprw6UJCARbmFGizgDsbcgzQHordvvu10QctxslDnt4N9qb5BSJowiqBrquwUg/KQhtxtqmAX5TVZj73ecwbVHx6+818JYt48tp+A4nHxJ46xgbWPK73Z0Qz7/im9+S3WbJhojAPp0kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776074738; c=relaxed/simple;
	bh=JSEUchAya0y+73XV9yDFcJ2NoXS9xU+kE5EAs/knHJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GOoH1E4NNLNDp6L6gIrItXPHXrmPXbGpOrSjkvVThF5PC7kmga4RF59FVvA2lzCi+5KUjSnqa9f2I7M/r10zUpjkUl3lqnkufBDh4k9JSEbWCjui4lYMcAUHbfWGhr938ahKqM8kcxL4MB9n7g97FxsD9Ni0B7h8nftaT70r8hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csmantle.top; spf=pass smtp.mailfrom=csmantle.top; dkim=permerror (0-bit key) header.d=csmantle.top header.i=@csmantle.top header.b=CBtIKUKp; dkim=pass (3072-bit key) header.d=csmantle.top header.i=@csmantle.top header.b=BuiosNpQ; arc=none smtp.client-ip=77.93.157.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csmantle.top
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csmantle.top
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=csmantle.top; s=self-ed25519; h=BIMI-Selector:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:In-Reply-To:References:BIMI-Selector;
	bh=0sa+/AiGfM+Bwi4P2uoBP8amjVYAN6KuVseFVbPjgOs=; t=1776074736; x=1776679536; 
	b=CBtIKUKpMRVkaLDd4aFZzHI7z5VHm8CwGyfbhtqkTIR/vAjal792g0j04dyf/WM9UFL0lFdtvoF
	BcGIV4MIYAQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=csmantle.top; s=self-rsa3072; h=BIMI-Selector:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:In-Reply-To:References:BIMI-Selector;
	bh=0sa+/AiGfM+Bwi4P2uoBP8amjVYAN6KuVseFVbPjgOs=; t=1776074736; x=1776679536; 
	b=BuiosNpQrTE+6UfmqFZZdkOaOuJVGsPD7bPMNuXf57Rg7pYLzJwW9El7bWa5w83aIS+LXiAeso5
	qElNrs+yLYoYDHKXu5ZIIsOjZu33OBBoJPawsbjHRikDplfrtzBKCh5bO/U0Cn9YPBKPFvmp+lyF8
	WDH1+HqBmV6BtRt65buP79UQYJMa+Ab/pmEWJlRK5CCBX9WSNMwNyBv6TYTyQ1gdqsNcFy9ErVFUL
	/M4W5HWkYVzKMxBsZX8OWmqzkdOQQOJttMy+q2b2O1amgGzXeVmx8+S5BGcKY4yr6p4tRyRdepDsB
	afmQXs+JPQpAfrb5uiL9STnIW6Ea4te7eZ++DEa4A5LVNeNtTJ5RQc55Oia6zFI0cMQOgQpc4QGWj
	oxqs4XATGlEMmKcnIEAvD0JijxyV8qZj6SAcFKzS8GZ2kYMqVwKdT8fw17+MQevgFjR6WWCz/bTJ9
	Z8uA5MNunYDsg1D1iIBhnjGsDBGz4ueLJ0JXd9Dwk9ZyxeK+fQWM;
Received: from [47.76.78.191] (helo=loongcatbox)
	by mail.srv.csmantle.top with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rong.bao@csmantle.top>)
	id 1wCEAd-00000000crG-060m;
	Mon, 13 Apr 2026 18:05:31 +0800
From: Rong Bao <rong.bao@csmantle.top>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Rong Bao <rong.bao@csmantle.top>,
	stable@vger.kernel.org,
	WANG Rui <wangrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf annotate: Use jump__delete when freeing LoongArch jumps
Date: Mon, 13 Apr 2026 18:03:55 +0800
Message-ID: <20260413100412.2313688-1-rong.bao@csmantle.top>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rcpt-Check: Accepted by authentication
X-42: Don't panic! 
BIMI-Selector: v=BIMI1; s=me
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[csmantle.top,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[csmantle.top:s=self-ed25519,csmantle.top:s=self-rsa3072];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235984-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rong.bao@csmantle.top,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[csmantle.top:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xen0n.name:email,csmantle.top:dkim,csmantle.top:email,csmantle.top:mid,linux.dev:email]
X-Rspamd-Queue-Id: E42753EA636
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, the initialization of loongarch_jump_ops does not contain an
assignment to its .free field. This causes disasm_line__free() to fall
through to ins_ops__delete() for LoongArch jump instructions.

ins_ops__delete() will free ins_operands.source.raw and
ins_operands.source.name, and these fields overlaps with
ins_operands.jump.raw_comment and ins_operands.jump.raw_func_start.
Since in loongarch_jump__parse(), these two fields are populated by
strchr()-ing the same buffer, trying to free them will lead to undefined
behavior.

This invalid free usually leads to crashes:

        Process 1712902 (perf) of user 1000 dumped core.
        Stack trace of thread 1712902:
        #0  0x00007fffef155c58 n/a (libc.so.6 + 0x95c58)
        #1  0x00007fffef0f7a94 raise (libc.so.6 + 0x37a94)
        #2  0x00007fffef0dd6a8 abort (libc.so.6 + 0x1d6a8)
        #3  0x00007fffef145490 n/a (libc.so.6 + 0x85490)
        #4  0x00007fffef1646f4 n/a (libc.so.6 + 0xa46f4)
        #5  0x00007fffef164718 n/a (libc.so.6 + 0xa4718)
        #6  0x00005555583a6764 __zfree (/home/csmantle/dist/linux-arch/tools/perf/perf + 0x106764)
        #7  0x000055555854fb70 disasm_line__free (/home/csmantle/dist/linux-arch/tools/perf/perf + 0x2afb70)
        #8  0x000055555853d618 annotated_source__purge (/home/csmantle/dist/linux-arch/tools/perf/perf + 0x29d618)
        #9  0x000055555852300c __hist_entry__tui_annotate (/home/csmantle/dist/linux-arch/tools/perf/perf + 0x28300c)
        #10 0x0000555558526718 do_annotate (/home/csmantle/dist/linux-arch/tools/perf/perf + 0x286718)
        #11 0x000055555852ed94 evsel__hists_browse (/home/csmantle/dist/linux-arch/tools/perf/perf + 0x28ed94)
        #12 0x000055555831fdd0 cmd_report (/home/csmantle/dist/linux-arch/tools/perf/perf + 0x7fdd0)
        #13 0x000055555839b644 handle_internal_command (/home/csmantle/dist/linux-arch/tools/perf/perf + 0xfb644)
        #14 0x00005555582fe6ac main (/home/csmantle/dist/linux-arch/tools/perf/perf + 0x5e6ac)
        #15 0x00007fffef0ddd90 n/a (libc.so.6 + 0x1dd90)
        #16 0x00007fffef0ddf0c __libc_start_main (libc.so.6 + 0x1df0c)
        #17 0x00005555582fed10 _start (/home/csmantle/dist/linux-arch/tools/perf/perf + 0x5ed10)
        ELF object binary architecture: LoongArch

... and it can be confirmed with Valgrind:

        ==1721834== Invalid free() / delete / delete[] / realloc()
        ==1721834==    at 0x4EA9014: free (in /usr/lib/valgrind/vgpreload_memcheck-loongarch64-linux.so)
        ==1721834==    by 0x4106287: __zfree (zalloc.c:13)
        ==1721834==    by 0x42ADC8F: disasm_line__free (in /home/csmantle/dist/linux-arch/tools/perf/perf)
        ==1721834==    by 0x429B737: annotated_source__purge (in /home/csmantle/dist/linux-arch/tools/perf/perf)
        ==1721834==    by 0x42811EB: __hist_entry__tui_annotate (in /home/csmantle/dist/linux-arch/tools/perf/perf)
        ==1721834==    by 0x42848D7: do_annotate (in /home/csmantle/dist/linux-arch/tools/perf/perf)
        ==1721834==    by 0x428CF33: evsel__hists_browse (in /home/csmantle/dist/linux-arch/tools/perf/perf)
        ==1721834==  Address 0x7d34303 is 35 bytes inside a block of size 62 alloc'd
        ==1721834==    at 0x4EA59B8: malloc (in /usr/lib/valgrind/vgpreload_memcheck-loongarch64-linux.so)
        ==1721834==    by 0x6B80B6F: strdup (strdup.c:42)
        ==1721834==    by 0x42AD917: disasm_line__new (in /home/csmantle/dist/linux-arch/tools/perf/perf)
        ==1721834==    by 0x42AE5A3: symbol__disassemble_objdump (in /home/csmantle/dist/linux-arch/tools/perf/perf)
        ==1721834==    by 0x42AF0A7: symbol__disassemble (in /home/csmantle/dist/linux-arch/tools/perf/perf)
        ==1721834==    by 0x429B3CF: symbol__annotate (in /home/csmantle/dist/linux-arch/tools/perf/perf)
        ==1721834==    by 0x429C233: symbol__annotate2 (in /home/csmantle/dist/linux-arch/tools/perf/perf)
        ==1721834==    by 0x42804D3: __hist_entry__tui_annotate (in /home/csmantle/dist/linux-arch/tools/perf/perf)
        ==1721834==    by 0x42848D7: do_annotate (in /home/csmantle/dist/linux-arch/tools/perf/perf)
        ==1721834==    by 0x428CF33: evsel__hists_browse (in /home/csmantle/dist/linux-arch/tools/perf/perf)

This patch adds the missing free() specialization in loongarch_jump_ops,
which prevents disasm_line__free() from invoking the default cleanup
function.

Fixes: fb7fd2a14a503b9a ("perf annotate: Move raw_comment and raw_func_start fields out of 'struct ins_operands'")
Cc: stable@vger.kernel.org
Cc: WANG Rui <wangrui@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev
Signed-off-by: Rong Bao <rong.bao@csmantle.top>
---
v1 -> v2: Correct "Fixes:" tag and move declaration of jump__delete()
          per comments.

v1: https://lore.kernel.org/lkml/20260412062828.1734637-1-rong.bao@csmantle.top

 tools/perf/util/annotate-arch/annotate-loongarch.c | 1 +
 tools/perf/util/disasm.c                           | 2 +-
 tools/perf/util/disasm.h                           | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-arch/annotate-loongarch.c b/tools/perf/util/annotate-arch/annotate-loongarch.c
index 950f34e59e5cd..c2addca77320b 100644
--- a/tools/perf/util/annotate-arch/annotate-loongarch.c
+++ b/tools/perf/util/annotate-arch/annotate-loongarch.c
@@ -110,6 +110,7 @@ static int loongarch_jump__parse(const struct arch *arch, struct ins_operands *o
 }
 
 static const struct ins_ops loongarch_jump_ops = {
+	.free	   = jump__delete,
 	.parse	   = loongarch_jump__parse,
 	.scnprintf = jump__scnprintf,
 	.is_jump   = true,
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 9e0420e14be19..62bd8c3e53051 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -451,7 +451,7 @@ int jump__scnprintf(const struct ins *ins, char *bf, size_t size,
 			 ops->target.offset);
 }
 
-static void jump__delete(struct ins_operands *ops __maybe_unused)
+void jump__delete(struct ins_operands *ops __maybe_unused)
 {
 	/*
 	 * The ops->jump.raw_comment and ops->jump.raw_func_start belong to the
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index a6e478caf61a9..25756e3f47e47 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -161,6 +161,8 @@ int jump__scnprintf(const struct ins *ins, char *bf, size_t size,
 int mov__scnprintf(const struct ins *ins, char *bf, size_t size,
 		   struct ins_operands *ops, int max_ins_name);
 
+void jump__delete(struct ins_operands *ops);
+
 int symbol__disassemble(struct symbol *sym, struct annotate_args *args);
 
 char *expand_tabs(char *line, char **storage, size_t *storage_len);

base-commit: 028ef9c96e96197026887c0f092424679298aae8
-- 
2.53.0


