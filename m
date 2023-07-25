Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4257760D5B
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 10:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjGYIoA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 04:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjGYInZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 04:43:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B071FFC
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 01:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 693F96109A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 08:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEFBC433C9;
        Tue, 25 Jul 2023 08:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690274541;
        bh=fo0v5P0JSUACaPdDTYgpPP1FbJZQh204rapPNYt2lc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AE49/xcw1BVfDggCoL685KhXsFBEp3vJwug4w7VcZF3xHwfjQvg5owH35lvivxfIg
         K3QVCP7Ha+xNK0XpTZDEXFdhWaoX58Kns+rd/syo2ZNmM7+lz7Wvi18CcjcCDUlx64
         EOS18jF8q76pPaZ/Ww73cMm3qroidYLKnxjnA+oWNXS7uVCSXTeOGK4Wa/r//CVo/g
         Gm1c3O0+4Y1zG0LZi3oB/oiMMON5I86uRrlpSzLWrbwJmPv6ujzzEnmmMLj0vfJ7lx
         qK0nUg+Zbt7d1GoSLEPGA3BRqoD7V5VI+F01EnQIVGPavosCVAL+ChjJWKJbjAidld
         iAgZHpxjdBeGw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     stable@vger.kernel.org, Hou Tao <houtao1@huawei.com>,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCHv3 bpf 1/2] bpf: Disable preemption in bpf_perf_event_output
Date:   Tue, 25 Jul 2023 10:42:05 +0200
Message-ID: <20230725084206.580930-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725084206.580930-1-jolsa@kernel.org>
References: <20230725084206.580930-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The nesting protection in bpf_perf_event_output relies on disabled
preemption, which is guaranteed for kprobes and tracepoints.

However bpf_perf_event_output can be also called from uprobes context
through bpf_prog_run_array_sleepable function which disables migration,
but keeps preemption enabled.

This can cause task to be preempted by another one inside the nesting
protection and lead eventually to two tasks using same perf_sample_data
buffer and cause crashes like:

  kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
  BUG: unable to handle page fault for address: ffffffff82be3eea
  ...
  Call Trace:
   ? __die+0x1f/0x70
   ? page_fault_oops+0x176/0x4d0
   ? exc_page_fault+0x132/0x230
   ? asm_exc_page_fault+0x22/0x30
   ? perf_output_sample+0x12b/0x910
   ? perf_event_output+0xd0/0x1d0
   ? bpf_perf_event_output+0x162/0x1d0
   ? bpf_prog_c6271286d9a4c938_krava1+0x76/0x87
   ? __uprobe_perf_func+0x12b/0x540
   ? uprobe_dispatcher+0x2c4/0x430
   ? uprobe_notify_resume+0x2da/0xce0
   ? atomic_notifier_call_chain+0x7b/0x110
   ? exit_to_user_mode_prepare+0x13e/0x290
   ? irqentry_exit_to_user_mode+0x5/0x30
   ? asm_exc_int3+0x35/0x40

Fixing this by disabling preemption in bpf_perf_event_output.

Cc: stable@vger.kernel.org
Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by chaining gps")
Acked-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 5f2dcabad202..14c9a1a548c9 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -661,8 +661,7 @@ static DEFINE_PER_CPU(int, bpf_trace_nest_level);
 BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 	   u64, flags, void *, data, u64, size)
 {
-	struct bpf_trace_sample_data *sds = this_cpu_ptr(&bpf_trace_sds);
-	int nest_level = this_cpu_inc_return(bpf_trace_nest_level);
+	struct bpf_trace_sample_data *sds;
 	struct perf_raw_record raw = {
 		.frag = {
 			.size = size,
@@ -670,7 +669,12 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 		},
 	};
 	struct perf_sample_data *sd;
-	int err;
+	int nest_level, err;
+
+	preempt_disable();
+
+	sds = this_cpu_ptr(&bpf_trace_sds);
+	nest_level = this_cpu_inc_return(bpf_trace_nest_level);
 
 	if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(sds->sds))) {
 		err = -EBUSY;
@@ -691,6 +695,7 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 
 out:
 	this_cpu_dec(bpf_trace_nest_level);
+	preempt_enable();
 	return err;
 }
 
-- 
2.41.0

