Return-Path: <stable+bounces-235798-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKhWLaRA22nX+wgAu9opvQ
	(envelope-from <stable+bounces-235798-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 08:50:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1644A3E2F39
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 08:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC8F7301B904
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 06:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272C7366564;
	Sun, 12 Apr 2026 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=csmantle.top header.i=@csmantle.top header.b="L0Jzfi4w";
	dkim=fail reason="signature verification failed" (3072-bit key) header.d=csmantle.top header.i=@csmantle.top header.b="BotqNdbM"
X-Original-To: stable@vger.kernel.org
Received: from mail.srv.csmantle.top (mail.srv.csmantle.top [77.93.157.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE75284693;
	Sun, 12 Apr 2026 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.157.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775976565; cv=none; b=INlCpvCaNn/f/Jn5crOG0xxdBu/WX8kZOiKZ4oY6nmsOd53QZtM9YWDneBIA8klizpssUU6Mu+f4EVRojg5L8djLp+i9JKv2yhkzbEe0Y9Y5uVV4PF16TmqLramFjWO1ezyd8e/QVPrUKnLqt2t5nYxdVsgO8vhyu9W+/MuyYms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775976565; c=relaxed/simple;
	bh=EAh/E2u/DE+syhU1hV2eNJ1OFxXh6YEQ8VHYcCZTJXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=saLrAOG+DvgHkZzXMFpURavw975MzLz9gvF/bvYdW1Gi83KlD95rvfVO3Ih5bQ0dV0vqsMAi3We3W6jgPGHEncx2VTfJzbnzJY7l7V6F0nhMcQGXOgY041iyQ0CktxNaRg85+C3seucB2tByUghup6ZKXt95AQpqucR+I+xDauM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csmantle.top; spf=pass smtp.mailfrom=csmantle.top; dkim=permerror (0-bit key) header.d=csmantle.top header.i=@csmantle.top header.b=L0Jzfi4w; dkim=pass (3072-bit key) header.d=csmantle.top header.i=@csmantle.top header.b=BotqNdbM; arc=none smtp.client-ip=77.93.157.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csmantle.top
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csmantle.top
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=csmantle.top; s=self-ed25519; h=BIMI-Selector:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pCBuahhqYxLO4y077kLFV+DwODh86Np+XQ6YWVVD59E=; t=1775976564; x=1776581364; 
	b=L0Jzfi4wely+tO2QFn5aMd4iNMfefj7mgGzXQUcMjKlWZIPNxH9N5OBN9e7G13o80QDEkjvDbzF
	4TAMMA1RGAw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=csmantle.top; s=self-rsa3072; h=BIMI-Selector:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pCBuahhqYxLO4y077kLFV+DwODh86Np+XQ6YWVVD59E=; t=1775976564; x=1776581364; 
	b=BotqNdbMiec0Mtz1ccMNc7r/fdw0WIoK2fe0/18qMrmAs0RdY8Y5uALzjMpjORcGzufMU9M13s2
	MbfSozY1Nr6NctmdJugoB8BBddci6wblFnIBsQMd3M0RxvGvFSYX4D8K7TcUr9kJlC+1QRjG3wZjx
	W/TEsG4Iukm62F5ZR6xM0RiP23e4aIR8rGrjXzANg642joyAuQl6RluA/RzBSCNrcoYUcA19tdSnH
	ryRksUH+hob+vl7wgm2TY1xrocgQEXxpcDR14YC0zMCD6cNu019Vun/VCRDmGxJQSf2S1ZhkjJbxo
	hkHTWGnp39WZ+TP5UuCASeAPa2ierfrjTYum7zFKUiP/HxYsI8NkO+vYVYuH40hAZ92ojqVSq+jFn
	YCy7GzBjtHA64n2YTxAKnWxtbzTNyBZ04pi5yKHdUlaecaH1FxYjobzPN5qKcgZbm+pvDNVf4WCHo
	OHvoxL9RH0oQhHDS/nPGkOXIBntu8o271XjtpJE5uBfIRcM4KuJl;
Received: from [47.76.78.191] (helo=loongcatbox)
	by mail.srv.csmantle.top with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rong.bao@csmantle.top>)
	id 1wBoJG-00000000b9i-0Fcp;
	Sun, 12 Apr 2026 14:28:42 +0800
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
Subject: [PATCH] perf annotate: Use jump__delete when freeing LoongArch jumps
Date: Sun, 12 Apr 2026 14:28:11 +0800
Message-ID: <20260412062828.1734637-1-rong.bao@csmantle.top>
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
X-Spamd-Result: default: False [2.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[csmantle.top : SPF not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[csmantle.top:s=self-ed25519,csmantle.top:s=self-rsa3072];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235798-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[csmantle.top:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.832];
	FROM_NEQ_ENVFROM(0.00)[rong.bao@csmantle.top,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1644A3E2F39
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

Fixes: 4ca0d340ce206 ("perf annotate: Fix instruction association and parsing for LoongArch")
Cc: stable@vger.kernel.org
Cc: WANG Rui <wangrui@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev
Signed-off-by: Rong Bao <rong.bao@csmantle.top>
---
 tools/perf/util/annotate-arch/annotate-loongarch.c | 1 +
 tools/perf/util/disasm.c                           | 2 +-
 tools/perf/util/disasm.h                           | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

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
index a6e478caf61a9..6b7fef3bbc42f 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -158,6 +158,7 @@ int call__scnprintf(const struct ins *ins, char *bf, size_t size,
 		    struct ins_operands *ops, int max_ins_name);
 int jump__scnprintf(const struct ins *ins, char *bf, size_t size,
 		    struct ins_operands *ops, int max_ins_name);
+void jump__delete(struct ins_operands *ops);
 int mov__scnprintf(const struct ins *ins, char *bf, size_t size,
 		   struct ins_operands *ops, int max_ins_name);
 

base-commit: f5459048c38a00fc583658d6dcd0f894aff6df8f
-- 
2.53.0


