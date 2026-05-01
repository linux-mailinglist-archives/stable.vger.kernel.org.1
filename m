Return-Path: <stable+bounces-242422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELhDF1Gf9Gm9CwIAu9opvQ
	(envelope-from <stable+bounces-242422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:40:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DB44AC746
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 770BB3015CAB
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 12:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8433A5428;
	Fri,  1 May 2026 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=csmantle.top header.i=@csmantle.top header.b="LBDq3vDq";
	dkim=pass (3072-bit key) header.d=csmantle.top header.i=@csmantle.top header.b="nu3AVgBh"
X-Original-To: stable@vger.kernel.org
Received: from mail.srv.csmantle.top (mail.srv.csmantle.top [77.93.157.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5073921D8;
	Fri,  1 May 2026 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.157.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777639237; cv=none; b=UeWAtFubK5EKPchQh48tzu6Ybg0baa73tjYGt+XGBgCOIi/gCKiIzT65LyP5TC4p9nxPgmOPURIa825EVxAJRux7J2bquCapyWXTh8GFF40AWgmGAJ/+Ca666vZpAdP8mUvNl4fWNeTD1ZpOw9YManKHeV5xBxd3ZjUGz5ZZF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777639237; c=relaxed/simple;
	bh=fdNEXmNvBb0fLlg1T5UQffKpl7utvUmlADoT7QiM01o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvW/wzq6KIxYFoytyj4OiW+tTqrf2Mv6iMj+fhIg0abb3eCDb+jxeqXdJ95jMe+qRwLu41Q3HqAFYLRDazLRDyaJ4cSHzzXtViW6ol+G5VLw/H13B1lsnoCOn7brMTZyjH//F94iF1JS7YzoVBuiY6pfb+qq78fgctdCSx6EQZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csmantle.top; spf=pass smtp.mailfrom=csmantle.top; dkim=permerror (0-bit key) header.d=csmantle.top header.i=@csmantle.top header.b=LBDq3vDq; dkim=pass (3072-bit key) header.d=csmantle.top header.i=@csmantle.top header.b=nu3AVgBh; arc=none smtp.client-ip=77.93.157.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csmantle.top
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csmantle.top
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=csmantle.top; s=self-ed25519; h=BIMI-Selector:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:In-Reply-To:References:
	BIMI-Selector; bh=ynKYvQ+XTvbrh45g38hs0XCGPrBgqG8ni13XOi0ZQao=; t=1777639236;
	x=1778244036; b=LBDq3vDqhwMRuXZnIRusQM6+9N+E+wY5Akv9GRT5lNzrbEqDFL7Klw1MhpXw9
	0RNzEyPDnoj5ALjI+9tPpsKCA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=csmantle.top; s=self-rsa3072; h=BIMI-Selector:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:In-Reply-To:References:
	BIMI-Selector; bh=ynKYvQ+XTvbrh45g38hs0XCGPrBgqG8ni13XOi0ZQao=; t=1777639236;
	x=1778244036; b=nu3AVgBhQUWbOafU5QXbDyqhK2vJ5LSajti/SVOqx9Yc3NfQLz++uhmUtqB3F
	vwwj/nQG2FQ7xo2l/2La8pq7y8hA8ioxsJxkCjCLD3m/C+x7gsDleY0vbrcW+juZJz8t1P/q53niK
	o5bDKvfW7yVqsr2zsqaCz7RyfdmaE1RScV42mMl1r8xFsQxoIfhjRmpyqrU9GAQOPnW4aJb7sZJI5
	DxWTyPUhSa3xKrgTuTksevJ5rwW7QYpNa02vqL9PMGr5EJmbmsLP/vEdGwpLyGpay3TwmYDiL3VE9
	moRYeRghHoQni3omF1vF9EOdn00aMZml4QcIZtHEFiRKBkcUhy1ydoRYMsEM0JBc3h22/gsTnUaUh
	M0kkLOyt+Exws5oFOUOlVHvEqX2/8w4EMg6IyeeB6lxwtYifplB8AmGsMg7ETlehciAfcERdtk6qt
	Ik5f6Pykkd0Uim0qDAjT/Tt7ZAgRQmUnpNr6oJWqKv7REfLUi2xakzSlQ6AZTiRubh;
Received: from [199.15.77.47] (helo=loongcatbox)
	by mail.srv.csmantle.top with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rong.bao@csmantle.top>)
	id 1wImsy-00000000LDq-33ou;
	Fri, 01 May 2026 20:22:25 +0800
From: Rong Bao <rong.bao@csmantle.top>
To: stable@vger.kernel.org
Cc: Rong Bao <rong.bao@csmantle.top>,
	WANG Rui <wangrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 6.18.y] perf annotate: Use jump__delete when freeing LoongArch jumps
Date: Fri,  1 May 2026 20:22:05 +0800
Message-ID: <20260501122205.4089260-1-rong.bao@csmantle.top>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026050115-composed-stand-38e1@gregkh>
References: <2026050115-composed-stand-38e1@gregkh>
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
X-Rspamd-Queue-Id: A6DB44AC746
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[csmantle.top,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[csmantle.top:s=self-ed25519,csmantle.top:s=self-rsa3072];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242422-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[rong.bao@csmantle.top,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[csmantle.top:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email,xen0n.name:email,linux.dev:email]

[ Upstream commit a355eefc36c4481188249b067832b40a2c45fa5c ]

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
Tested-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/loongarch/annotate/instructions.c | 1 +
 tools/perf/util/disasm.c                          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/arch/loongarch/annotate/instructions.c b/tools/perf/arch/loongarch/annotate/instructions.c
index 1c3abb43c8d72197dbc8b13f5c42dfad79787e2e..1a0a1dacebc30c72e916815f872eeb45561b533f 100644
--- a/tools/perf/arch/loongarch/annotate/instructions.c
+++ b/tools/perf/arch/loongarch/annotate/instructions.c
@@ -97,6 +97,7 @@ static int loongarch_jump__parse(struct arch *arch, struct ins_operands *ops, st
 }
 
 static struct ins_ops loongarch_jump_ops = {
+	.free	   = jump__delete,
 	.parse	   = loongarch_jump__parse,
 	.scnprintf = jump__scnprintf,
 };
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index b1be847446fea0279043cbf19b42ff817615a5b1..c513db41137fa414aab8afe191dd209ae01508d4 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -47,6 +47,7 @@ static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops, int max_ins_name);
 static int call__scnprintf(struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops, int max_ins_name);
+static void jump__delete(struct ins_operands *ops);
 
 static void ins__sort(struct arch *arch);
 static int disasm_line__parse(char *line, const char **namep, char **rawp);

base-commit: 1fe06068166d4fc16722201f267b1fe19efad639
-- 
2.54.0


