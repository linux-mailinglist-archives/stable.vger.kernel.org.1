Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC9575AA6A
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 11:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjGTJO2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 05:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjGTJGV (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 05:06:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA24A449B
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 01:57:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C71861934
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 08:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85816C433C8;
        Thu, 20 Jul 2023 08:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689843451;
        bh=eWsO3usRBxHzLz/MzFKOIEMz2QGTjBq5921O/fZkWio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mN8IXOYq6D2qJy2Cf1hagci1WaCtu05O541e5O39kDYn1Qhe0ELeV8YJJSaUf7V92
         cgGBEHIoLwi4BXKYiQsgVvzBasJazE7dohFDKEK7P1xU/AUQBw9PCuC6qMK09iITdh
         MJSB4zGewq9vRi7OIcxOhZjbBYuWYTbZuMevNN1/1HXJPwwG9Yr96o/X68ePuQUOcu
         CKHaZ44FvM7LJLAOxd/I6b6qNop9ZX0wIPNNZlhdgpYCL7HTXvbyrfbqMWQ89MtMvt
         v2msdB7rAPQ9EaS5AP4k44FmDeVGIvCgH1P8gHM59EDlFKeKEO3h+QmsmRLkGDD1mN
         UVXKV6Z+M78wA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     stable@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf 2/2] bpf: Disable preemption in bpf_event_output
Date:   Thu, 20 Jul 2023 10:57:04 +0200
Message-ID: <20230720085704.190592-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720085704.190592-1-jolsa@kernel.org>
References: <20230720085704.190592-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

We received report [1] of kernel crash, which is caused by
using nesting protection without disabled preemption.

The bpf_event_output can be called by programs executed by
bpf_prog_run_array_cg function that disabled migration but
keeps preemption enabled.

This can cause task to be preempted by another one inside the
nesting protection and lead eventually to two tasks using same
perf_sample_data buffer and cause crashes like:

  BUG: kernel NULL pointer dereference, address: 0000000000000001
  #PF: supervisor instruction fetch in kernel mode
  #PF: error_code(0x0010) - not-present page
  ...
  ? perf_output_sample+0x12a/0x9a0
  ? finish_task_switch.isra.0+0x81/0x280
  ? perf_event_output+0x66/0xa0
  ? bpf_event_output+0x13a/0x190
  ? bpf_event_output_data+0x22/0x40
  ? bpf_prog_dfc84bbde731b257_cil_sock4_connect+0x40a/0xacb
  ? xa_load+0x87/0xe0
  ? __cgroup_bpf_run_filter_sock_addr+0xc1/0x1a0
  ? release_sock+0x3e/0x90
  ? sk_setsockopt+0x1a1/0x12f0
  ? udp_pre_connect+0x36/0x50
  ? inet_dgram_connect+0x93/0xa0
  ? __sys_connect+0xb4/0xe0
  ? udp_setsockopt+0x27/0x40
  ? __pfx_udp_push_pending_frames+0x10/0x10
  ? __sys_setsockopt+0xdf/0x1a0
  ? __x64_sys_connect+0xf/0x20
  ? do_syscall_64+0x3a/0x90
  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc

Fixing this by disabling preemption in bpf_event_output.

[1] https://github.com/cilium/cilium/issues/26756
Cc: stable@vger.kernel.org
Reported-by:  Oleg "livelace" Popov <o.popov@livelace.ru>
Fixes: 2a916f2f546c bpf: Use migrate_disable/enable in array macros and cgroup/lirc code.
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 14c9a1a548c9..6826ebf750b0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -720,7 +720,6 @@ static DEFINE_PER_CPU(struct bpf_trace_sample_data, bpf_misc_sds);
 u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 		     void *ctx, u64 ctx_size, bpf_ctx_copy_t ctx_copy)
 {
-	int nest_level = this_cpu_inc_return(bpf_event_output_nest_level);
 	struct perf_raw_frag frag = {
 		.copy		= ctx_copy,
 		.size		= ctx_size,
@@ -737,8 +736,13 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 	};
 	struct perf_sample_data *sd;
 	struct pt_regs *regs;
+	int nest_level;
 	u64 ret;
 
+	preempt_disable();
+
+	nest_level = this_cpu_inc_return(bpf_event_output_nest_level);
+
 	if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(bpf_misc_sds.sds))) {
 		ret = -EBUSY;
 		goto out;
@@ -753,6 +757,7 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 	ret = __bpf_perf_event_output(regs, map, flags, sd);
 out:
 	this_cpu_dec(bpf_event_output_nest_level);
+	preempt_enable();
 	return ret;
 }
 
-- 
2.41.0

