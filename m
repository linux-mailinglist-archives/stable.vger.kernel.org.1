Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEB17758E0
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjHIKzx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjHIKzj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:55:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17262690
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:54:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65FE4630D2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BFCC433C7;
        Wed,  9 Aug 2023 10:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578496;
        bh=HZf9mBn7XGBdhhFooDESb4q+iPzkiKPMUHuXqIYTE1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8WwozjwvHEd732ydG8ChNDeqcpmj8mGN1DaU22+3OYtdFwwa/x042tKSScvWev0U
         Kx2rbosVmgf+09B2brLX0aelG39yiRKBW+Gum8uJQGU/5DthCtagQZUewFJSkPI7we
         i6rEcE4AjHyb0U/0FtmDaBFbnTIKhfh9xknN0tWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hou Tao <houtao1@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 6.1 081/127] bpf: Disable preemption in bpf_perf_event_output
Date:   Wed,  9 Aug 2023 12:41:08 +0200
Message-ID: <20230809103639.333605569@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

commit f2c67a3e60d1071b65848efaa8c3b66c363dd025 upstream.

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
Link: https://lore.kernel.org/r/20230725084206.580930-2-jolsa@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/bpf_trace.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -662,8 +662,7 @@ static DEFINE_PER_CPU(int, bpf_trace_nes
 BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 	   u64, flags, void *, data, u64, size)
 {
-	struct bpf_trace_sample_data *sds = this_cpu_ptr(&bpf_trace_sds);
-	int nest_level = this_cpu_inc_return(bpf_trace_nest_level);
+	struct bpf_trace_sample_data *sds;
 	struct perf_raw_record raw = {
 		.frag = {
 			.size = size,
@@ -671,7 +670,11 @@ BPF_CALL_5(bpf_perf_event_output, struct
 		},
 	};
 	struct perf_sample_data *sd;
-	int err;
+	int nest_level, err;
+
+	preempt_disable();
+	sds = this_cpu_ptr(&bpf_trace_sds);
+	nest_level = this_cpu_inc_return(bpf_trace_nest_level);
 
 	if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(sds->sds))) {
 		err = -EBUSY;
@@ -690,9 +693,9 @@ BPF_CALL_5(bpf_perf_event_output, struct
 	sd->sample_flags |= PERF_SAMPLE_RAW;
 
 	err = __bpf_perf_event_output(regs, map, flags, sd);
-
 out:
 	this_cpu_dec(bpf_trace_nest_level);
+	preempt_enable();
 	return err;
 }
 


