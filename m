Return-Path: <stable+bounces-152016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DABAD1DFC
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 14:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3A43A3047
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 12:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D00022A7FE;
	Mon,  9 Jun 2025 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="dZ27jXOj"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326651DD9AD;
	Mon,  9 Jun 2025 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749472783; cv=none; b=BSxs6R5GVr5OP6N2108GXWEYARZsiCU8M9YyHYRMX+t3rLm0ll7bAzRpivjCWM2Xll4qBMcHEoh46J0q6ccsQG+mUDZlYLCr1nRn7kns/zWcrAfd3qgPCjbz/OpCeX1iTpxIu1EK+hP9KOpX7quP3obzEwo56xooQLWKw6XFYqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749472783; c=relaxed/simple;
	bh=hzKEF2ecIKDix/vhYaGCpQ9As2KvNgwE7WcPkF2O8qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aog3xWLmJKxlH9vHI0ydgDM86kPfHVLeaiTJ4ijF1YkuWVBbLYmfisMEK3N8MSS5vDszErPfgYwyq2qT5Ya2TVtpYiH7LHqmbUWpeexcC5W8hDivq9311LlUmkmZ4Q+SbJyUfGRws+Q+NIseZ87KTTLWG6aoj/q/NZBgdO6WFrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=dZ27jXOj; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1749472742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=klUL2nXA/lE8AsxdeDYvpY9PFSSBvKNY2wP+dT//QvE=;
	b=dZ27jXOjoZmKrsDQndaolIfayYwqS/WVu1bJkgojUeGuCFe3sG9PzxJbkmvq88vJMwjkBo
	SAi/nXaOHtNWLdBwwXynJQTemyumLb0Z3o3OPUrY73buLRNYjAd8fSUEMxb56XPpxv5Lu5
	tzeDD40BPl146BYyT80ugXRUCYqnZcw=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 5.10] tracing: Do not let histogram values have some modifiers
Date: Mon,  9 Jun 2025 15:39:01 +0300
Message-ID: <20250609123902.42252-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

commit e0213434fe3e4a0d118923dc98d31e7ff1cd9e45 upstream.

Histogram values can not be strings, stacktraces, graphs, symbols,
syscalls, or grouped in buckets or log. Give an error if a value is set to
do so.

Note, the histogram code was not prepared to handle these modifiers for
histograms and caused a bug.

Mark Rutland reported:

 # echo 'p:copy_to_user __arch_copy_to_user n=$arg2' >> /sys/kernel/tracing/kprobe_events
 # echo 'hist:keys=n:vals=hitcount.buckets=8:sort=hitcount' > /sys/kernel/tracing/events/kprobes/copy_to_user/trigger
 # cat /sys/kernel/tracing/events/kprobes/copy_to_user/hist
[  143.694628] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[  143.695190] Mem abort info:
[  143.695362]   ESR = 0x0000000096000004
[  143.695604]   EC = 0x25: DABT (current EL), IL = 32 bits
[  143.695889]   SET = 0, FnV = 0
[  143.696077]   EA = 0, S1PTW = 0
[  143.696302]   FSC = 0x04: level 0 translation fault
[  143.702381] Data abort info:
[  143.702614]   ISV = 0, ISS = 0x00000004
[  143.702832]   CM = 0, WnR = 0
[  143.703087] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000448f9000
[  143.703407] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[  143.704137] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[  143.704714] Modules linked in:
[  143.705273] CPU: 0 PID: 133 Comm: cat Not tainted 6.2.0-00003-g6fc512c10a7c #3
[  143.706138] Hardware name: linux,dummy-virt (DT)
[  143.706723] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  143.707120] pc : hist_field_name.part.0+0x14/0x140
[  143.707504] lr : hist_field_name.part.0+0x104/0x140
[  143.707774] sp : ffff800008333a30
[  143.707952] x29: ffff800008333a30 x28: 0000000000000001 x27: 0000000000400cc0
[  143.708429] x26: ffffd7a653b20260 x25: 0000000000000000 x24: ffff10d303ee5800
[  143.708776] x23: ffffd7a6539b27b0 x22: ffff10d303fb8c00 x21: 0000000000000001
[  143.709127] x20: ffff10d303ec2000 x19: 0000000000000000 x18: 0000000000000000
[  143.709478] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  143.709824] x14: 0000000000000000 x13: 203a6f666e692072 x12: 6567676972742023
[  143.710179] x11: 0a230a6d6172676f x10: 000000000000002c x9 : ffffd7a6521e018c
[  143.710584] x8 : 000000000000002c x7 : 7f7f7f7f7f7f7f7f x6 : 000000000000002c
[  143.710915] x5 : ffff10d303b0103e x4 : ffffd7a653b20261 x3 : 000000000000003d
[  143.711239] x2 : 0000000000020001 x1 : 0000000000000001 x0 : 0000000000000000
[  143.711746] Call trace:
[  143.712115]  hist_field_name.part.0+0x14/0x140
[  143.712642]  hist_field_name.part.0+0x104/0x140
[  143.712925]  hist_field_print+0x28/0x140
[  143.713125]  event_hist_trigger_print+0x174/0x4d0
[  143.713348]  hist_show+0xf8/0x980
[  143.713521]  seq_read_iter+0x1bc/0x4b0
[  143.713711]  seq_read+0x8c/0xc4
[  143.713876]  vfs_read+0xc8/0x2a4
[  143.714043]  ksys_read+0x70/0xfc
[  143.714218]  __arm64_sys_read+0x24/0x30
[  143.714400]  invoke_syscall+0x50/0x120
[  143.714587]  el0_svc_common.constprop.0+0x4c/0x100
[  143.714807]  do_el0_svc+0x44/0xd0
[  143.714970]  el0_svc+0x2c/0x84
[  143.715134]  el0t_64_sync_handler+0xbc/0x140
[  143.715334]  el0t_64_sync+0x190/0x194
[  143.715742] Code: a9bd7bfd 910003fd a90153f3 aa0003f3 (f9400000)
[  143.716510] ---[ end trace 0000000000000000 ]---
Segmentation fault

Link: https://lkml.kernel.org/r/20230302020810.559462599@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: c6afad49d127f ("tracing: Add hist trigger 'sym' and 'sym-offset' modifiers")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
[Denis: minor fix to resolve merge conflict.]                                           
Signed-off-by: Denis Arefev <arefev@swemel.ru>                                    
---
Backport fix for CVE-2023-53093
Link:  https://nvd.nist.gov/vuln/detail/CVE-2023-53093
---
 kernel/trace/trace_events_hist.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a0342b45a06d..e4f76e5ac6df 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3705,6 +3705,15 @@ static int __create_val_field(struct hist_trigger_data *hist_data,
 		goto out;
 	}
 
+	/* Some types cannot be a value */
+	if (hist_field->flags & (HIST_FIELD_FL_GRAPH | HIST_FIELD_FL_PERCENT |
+				 HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2 |
+				 HIST_FIELD_FL_SYM | HIST_FIELD_FL_SYM_OFFSET |
+				 HIST_FIELD_FL_SYSCALL | HIST_FIELD_FL_STACKTRACE)) {
+		hist_err(file->tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(field_str));
+		ret = -EINVAL;
+	}
+
 	hist_data->fields[val_idx] = hist_field;
 
 	++hist_data->n_vals;
-- 
2.43.0


