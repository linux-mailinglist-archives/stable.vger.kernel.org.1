Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C57977596E
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjHILAX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjHILAW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769E92103
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16FE76312F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FB6C433C8;
        Wed,  9 Aug 2023 11:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578820;
        bh=AC0uBao4KIafDZjUGYhJmvO1fM0Vx30S+GywV4P56cM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7F1YdX8rNESraoy9dEaY1A7SC6OatSfisp53OJlkS04nryZ3BEZ4FGvw7avRvAkH
         CYbX1XZrHjTtuSBZuyWDqC2kTN718QFMSZVflh/j8F0adIpn0gczVrQmO7cIiXlilR
         jb660f4MBzMhqNPeI8diE9Oe+uhfqZ61TR2PHGCg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Oleg=20 livelace =20Popov?= <o.popov@livelace.ru>,
        Hou Tao <houtao1@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 5.15 69/92] bpf: Disable preemption in bpf_event_output
Date:   Wed,  9 Aug 2023 12:41:45 +0200
Message-ID: <20230809103635.963261225@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

commit d62cc390c2e99ae267ffe4b8d7e2e08b6c758c32 upstream.

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
Reported-by: Oleg "livelace" Popov <o.popov@livelace.ru>
Closes: https://github.com/cilium/cilium/issues/26756
Fixes: 2a916f2f546c ("bpf: Use migrate_disable/enable in array macros and cgroup/lirc code.")
Acked-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20230725084206.580930-3-jolsa@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/bpf_trace.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -662,7 +662,6 @@ static DEFINE_PER_CPU(struct bpf_trace_s
 u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 		     void *ctx, u64 ctx_size, bpf_ctx_copy_t ctx_copy)
 {
-	int nest_level = this_cpu_inc_return(bpf_event_output_nest_level);
 	struct perf_raw_frag frag = {
 		.copy		= ctx_copy,
 		.size		= ctx_size,
@@ -679,8 +678,12 @@ u64 bpf_event_output(struct bpf_map *map
 	};
 	struct perf_sample_data *sd;
 	struct pt_regs *regs;
+	int nest_level;
 	u64 ret;
 
+	preempt_disable();
+	nest_level = this_cpu_inc_return(bpf_event_output_nest_level);
+
 	if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(bpf_misc_sds.sds))) {
 		ret = -EBUSY;
 		goto out;
@@ -695,6 +698,7 @@ u64 bpf_event_output(struct bpf_map *map
 	ret = __bpf_perf_event_output(regs, map, flags, sd);
 out:
 	this_cpu_dec(bpf_event_output_nest_level);
+	preempt_enable();
 	return ret;
 }
 


