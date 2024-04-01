Return-Path: <stable+bounces-33876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE168938B6
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 09:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A364A1F213B1
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 07:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF00BA39;
	Mon,  1 Apr 2024 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TeKYQjLM"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DED15A4
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711957854; cv=none; b=gWkxiYA7H7jHqHJIs/Q7iwBrd3pwL+/X3g4IY9i/WZecwLOzIP588cK/6JjlO0+PuAgz0iQKcU3Sszuw2544bMHwiY2OETAfTLlXH9HPeupqVGmrbFfjjXjeApuHoOBk00GBD9SU5s/M1/6W3TIwotIjcprCNViyZ/B5e4m0a7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711957854; c=relaxed/simple;
	bh=dinTKapuX6VyptU96Biqjg8HiA5DV9FeuFimHUyFU0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HgQxpYRUuUb3LE3HfoP2QbdlMl7PHKtX1e+5JAwW8SpSy8NPfOA74Aws0qbdHgTW9K/d9lLm8zWF8OzbWhfL1hcUO57qh6ct4iusN1gBL8ikbduUkjsrpRDNSphfU8mY091GjdOmXfO7kwR1XdR8EyeXyvt7quFHZe1jlRMN44o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TeKYQjLM; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711957849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWnA0HCgztMN1DavppDyOBxdoO5LUu33vfhRvspzS8A=;
	b=TeKYQjLMVQ0u8kjNoTh5ZqXDsJdgBFJOSF7gkt12+LdWJJ4WulpgsEYTcc3/scDM/hU3cF
	P5okN2fASuhuubLOsxgjoC3p/2h0RwLXssr7Mg9AfRSbsKeR/S4nos9V5BAM4dlIW+QwP2
	mED9u0yZ5Y/59r9ARLxdv9M1+zo1UIU=
From: George Guo <dongtai.guo@linux.dev>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 4.19 v2 1/2] tracing: Remove unnecessary hist_data destroy in destroy_synth_var_refs()
Date: Mon,  1 Apr 2024 15:50:48 +0800
Message-Id: <20240401075049.2655077-2-dongtai.guo@linux.dev>
In-Reply-To: <20240401075049.2655077-1-dongtai.guo@linux.dev>
References: <20240401075049.2655077-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

commit 912201345f7c39e6b0ac283207be2b6641fa47b9 upstream.

The destroy_synth_var_refs() destroyed hist_data, casusing a double-free 
error flagged by KASAN.

This is tested via "./ftracetest test.d/trigger/inter-event/
trigger-field-variable-support.tc"

==================================================================
BUG: KASAN: use-after-free in destroy_hist_field+0x115/0x140
Read of size 4 at addr ffff888012e95318 by task ftracetest/1858

CPU: 1 PID: 1858 Comm: ftracetest Kdump: loaded Tainted: GE 4.19.90-89 #24
Source Version: Unknown
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0
Call Trace:
 dump_stack+0xcb/0x10b
 print_address_description.cold+0x54/0x249
 kasan_report_error.cold+0x63/0xab
 ? destroy_hist_field+0x115/0x140
 __asan_report_load4_noabort+0x8d/0xa0
 ? destroy_hist_field+0x115/0x140
 destroy_hist_field+0x115/0x140
 destroy_hist_data+0x4e4/0x9a0
 event_hist_trigger_free+0x212/0x2f0
 ? update_cond_flag+0x128/0x170
 ? event_hist_trigger_func+0x2880/0x2880
 hist_unregister_trigger+0x2f2/0x4f0
 event_hist_trigger_func+0x168c/0x2880
 ? tracing_map_read_var_once+0xd0/0xd0
 ? create_key_field+0x520/0x520
 ? __mutex_lock_slowpath+0x10/0x10
 event_trigger_write+0x2f4/0x490
 ? trigger_start+0x180/0x180
 ? __fget_light+0x369/0x5d0
 ? count_memcg_event_mm+0x104/0x2b0
 ? trigger_start+0x180/0x180
 __vfs_write+0x81/0x100
 vfs_write+0x1e1/0x540
 ksys_write+0x12a/0x290
 ? __ia32_sys_read+0xb0/0xb0
 ? __close_fd+0x1d3/0x280
 do_syscall_64+0xe3/0x2d0
 entry_SYSCALL_64_after_hwframe+0x5c/0xc1
RIP: 0033:0x7efdd342ee04
Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 48 
8d 05 39 34 0c 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff 
ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 89 f5
RSP: 002b:00007ffda01f5e08 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000000000b4 RCX: 00007efdd342ee04
RDX: 00000000000000b4 RSI: 000055c5b41b1e90 RDI: 0000000000000001
RBP: 000055c5b41b1e90 R08: 000000000000000a R09: 0000000000000000
R10: 000000000000000a R11: 0000000000000246 R12: 00007efdd34ed5c0
R13: 00000000000000b4 R14: 00007efdd34ed7c0 R15: 00000000000000b4
==================================================================

So remove the destroy_synth_var_refs() call for that hist_data.

Fixes: c282a386a397("tracing: Add 'onmatch' hist trigger action support")
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 kernel/trace/trace_events_hist.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index e004daf8cad5..7dcb96305e56 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -280,8 +280,6 @@ struct hist_trigger_data {
 	struct action_data		*actions[HIST_ACTIONS_MAX];
 	unsigned int			n_actions;
 
-	struct hist_field               *synth_var_refs[SYNTH_FIELDS_MAX];
-	unsigned int                    n_synth_var_refs;
 	struct field_var		*field_vars[SYNTH_FIELDS_MAX];
 	unsigned int			n_field_vars;
 	unsigned int			n_field_var_str;
@@ -1363,8 +1361,8 @@ static struct hist_field *find_var_ref(struct hist_trigger_data *hist_data,
 			return found;
 	}
 
-	for (i = 0; i < hist_data->n_synth_var_refs; i++) {
-		hist_field = hist_data->synth_var_refs[i];
+	for (i = 0; i < hist_data->n_var_refs; i++) {
+		hist_field = hist_data->var_refs[i];
 		found = check_field_for_var_refs(hist_data, hist_field,
 						 var_data, var_idx, 0);
 		if (found)
@@ -3707,21 +3705,6 @@ static void save_field_var(struct hist_trigger_data *hist_data,
 		hist_data->n_field_var_str++;
 }
 
-
-static void destroy_synth_var_refs(struct hist_trigger_data *hist_data)
-{
-	unsigned int i;
-
-	for (i = 0; i < hist_data->n_synth_var_refs; i++)
-		destroy_hist_field(hist_data->synth_var_refs[i], 0);
-}
-
-static void save_synth_var_ref(struct hist_trigger_data *hist_data,
-			 struct hist_field *var_ref)
-{
-	hist_data->synth_var_refs[hist_data->n_synth_var_refs++] = var_ref;
-}
-
 static int check_synth_field(struct synth_event *event,
 			     struct hist_field *hist_field,
 			     unsigned int field_pos)
@@ -3884,7 +3867,6 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 				goto err;
 			}
 
-			save_synth_var_ref(hist_data, var_ref);
 			field_pos++;
 			kfree(p);
 			continue;
@@ -4631,7 +4613,6 @@ static void destroy_hist_data(struct hist_trigger_data *hist_data)
 	destroy_actions(hist_data);
 	destroy_field_vars(hist_data);
 	destroy_field_var_hists(hist_data);
-	destroy_synth_var_refs(hist_data);
 
 	kfree(hist_data);
 }
-- 
2.34.1


