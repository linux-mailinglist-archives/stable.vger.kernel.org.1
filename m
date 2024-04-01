Return-Path: <stable+bounces-33877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AF28938B7
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 09:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0561F2161E
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 07:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2AC15A4;
	Mon,  1 Apr 2024 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V0qVg081"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA208F6E
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711957855; cv=none; b=Xl+8IRca69VWv/607JHfWJGh/OpM/xcF2rEnYGVNYHcMr53KL4jkP1+b+Ss1veCtnV3gqTUO3fzOK0wB8U97vI/DP78gfhvSJ9sF532KmUPkHXU676dAUMbpVsTiRA3e+mRf+5m1uOpbr+vg44zY6cKHiPEitlUej6YHkpihkSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711957855; c=relaxed/simple;
	bh=JigHOSBjxmUkvUOMIdPDj7ZNUA7z6jU/r3gDNG+eGvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TGvDBxeuhMJe04e+hu0+tgRpDjey0opeFeneLNI0ZNzw1Q02VM4Xq1R1A9go3HYgxI8f1RAs2uzRypCBHAM0nXtkucnIV9oLJePD93EshAlAzbvPAxAbC2vPXCxNXqHRszddkY8d02iNfpmC8KOrmFOL9U/+LkUWWOiIAj+GwNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V0qVg081; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711957850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azKewMdXjrP1Vb4JbEgXcwOQdFK4Qn8EqameaBqK/gE=;
	b=V0qVg0810KrGabS8A1RI8LkcCQGVFTEA3nAaGWRVRYKnfTm00mNyoMJROK/LKJeUjJu4rs
	RvFal3heDvhFZsw4R91xU+y9lvil4pF94tJGMXUFNjp1rkWarNk8BFi6aQ3nKw6HDHx4X3
	pI9J8BOJectgpCGLRksHyBB/Jb1lPnw=
From: George Guo <dongtai.guo@linux.dev>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 4.19 2/2] tracing: Remove unnecessary var destroy in onmax_destroy()
Date: Mon,  1 Apr 2024 15:50:49 +0800
Message-Id: <20240401075049.2655077-3-dongtai.guo@linux.dev>
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

commit ff9d31d0d46672e201fc9ff59c42f1eef5f00c77 upstream.

The onmax_destroy() destroyed the onmax var, casusing a double-free error
flagged by KASAN.

This is tested via "./ftracetest test.d/trigger/inter-event/
trigger-onmatch-onmax-action-hist.tc".

==================================================================
BUG: KASAN: use-after-free in destroy_hist_field+0x1c2/0x200
Read of size 8 at addr ffff88800a4ad100 by task ftracetest/4731

CPU: 0 PID: 4731 Comm: ftracetest Kdump: loaded Tainted: GE 4.19.90-89 #77
Source Version: Unknown
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0
Call Trace:
 dump_stack+0xcb/0x10b
 print_address_description.cold+0x54/0x249
 kasan_report_error.cold+0x63/0xab
 ? destroy_hist_field+0x1c2/0x200
 ? hist_trigger_elt_data_alloc+0x5a0/0x5a0
 __asan_report_load8_noabort+0x8d/0xa0
 ? destroy_hist_field+0x1c2/0x200
 destroy_hist_field+0x1c2/0x200
 onmax_destroy+0x72/0x1e0
 ? hist_trigger_elt_data_alloc+0x5a0/0x5a0
 destroy_hist_data+0x236/0xa40
 event_hist_trigger_free+0x212/0x2f0
 ? update_cond_flag+0x128/0x170
 ? event_hist_trigger_func+0x2880/0x2880
 hist_unregister_trigger+0x2f2/0x4f0
 event_hist_trigger_func+0x168c/0x2880
 ? tracing_map_cmp_u64+0xa0/0xa0
 ? onmatch_create.constprop.0+0xf50/0xf50
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
RIP: 0033:0x7fd7f4c44e04
Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 
48 8d 05 39 34 0c 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 
f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 89 f5
RSP: 002b:00007fff10370df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000000010f RCX: 00007fd7f4c44e04
RDX: 000000000000010f RSI: 000055fa765df650 RDI: 0000000000000001
RBP: 000055fa765df650 R08: 000000000000000a R09: 0000000000000000
R10: 000000000000000a R11: 0000000000000246 R12: 00007fd7f4d035c0
R13: 000000000000010f R14: 00007fd7f4d037c0 R15: 000000000000010f
==================================================================

So remove the onmax_destroy() destroy_hist_field() call for that var.

Fixes: 50450603ec9c("tracing: Add 'onmax' hist trigger action support")
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 kernel/trace/trace_events_hist.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 7dcb96305e56..58b8a2575b8c 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -337,7 +337,6 @@ struct action_data {
 			char			*fn_name;
 			unsigned int		max_var_ref_idx;
 			struct hist_field	*max_var;
-			struct hist_field	*var;
 		} onmax;
 	};
 };
@@ -3489,7 +3488,6 @@ static void onmax_destroy(struct action_data *data)
 	unsigned int i;
 
 	destroy_hist_field(data->onmax.max_var, 0);
-	destroy_hist_field(data->onmax.var, 0);
 
 	kfree(data->onmax.var_str);
 	kfree(data->onmax.fn_name);
@@ -3528,8 +3526,6 @@ static int onmax_create(struct hist_trigger_data *hist_data,
 	if (!ref_field)
 		return -ENOMEM;
 
-	data->onmax.var = ref_field;
-
 	data->fn = onmax_save;
 	data->onmax.max_var_ref_idx = var_ref_idx;
 	max_var = create_var(hist_data, file, "max", sizeof(u64), "u64");
-- 
2.34.1


