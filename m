Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881C47ECF48
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbjKOTrf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjKOTre (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:47:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7769FB8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:47:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF052C433C8;
        Wed, 15 Nov 2023 19:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077650;
        bh=b27ozrtTBe+7qAT97L76t/PYQ4xrWxtFOX0OMKaNFyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfPgKxUlbCfjZyGT1Kd/BScEkRUImhLKLhCFaxUEq26pisQLdyfWZ3ZKRVz1Kv0x4
         PoOheaN4l98FSoQeWo3arUFm5s7+qA7N3r0TA1tsDAKiNYm6mciXe9Iq3SrB9fwigi
         I9eIL0ETuf2JRFXxeoVp+uoNv8TPlokzMxzTTatA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        bpf@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 434/603] perf record: Fix BTF type checks in the off-cpu profiling
Date:   Wed, 15 Nov 2023 14:16:19 -0500
Message-ID: <20231115191642.865449745@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 0e501a65d35bf72414379fed0e31a0b6b81ab57d ]

The BTF func proto for a tracepoint has one more argument than the
actual tracepoint function since it has a context argument at the
begining.  So it should compare to 5 when the tracepoint has 4
arguments.

  typedef void (*btf_trace_sched_switch)(void *, bool, struct task_struct *, struct task_struct *, unsigned int);

Also, recent change in the perf tool would use a hand-written minimal
vmlinux.h to generate BTF in the skeleton.  So it won't have the info
of the tracepoint.  Anyway it should use the kernel's vmlinux BTF to
check the type in the kernel.

Fixes: b36888f71c85 ("perf record: Handle argument change in sched_switch")
Reviewed-by: Ian Rogers <irogers@google.com>
Acked-by: Song Liu <song@kernel.org>
Cc: Hao Luo <haoluo@google.com>
CC: bpf@vger.kernel.org
Link: https://lore.kernel.org/r/20230922234444.3115821-1-namhyung@kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/bpf_off_cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 01f70b8e705a8..21f4d9ba023d9 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -98,7 +98,7 @@ static void off_cpu_finish(void *arg __maybe_unused)
 /* v5.18 kernel added prev_state arg, so it needs to check the signature */
 static void check_sched_switch_args(void)
 {
-	const struct btf *btf = bpf_object__btf(skel->obj);
+	const struct btf *btf = btf__load_vmlinux_btf();
 	const struct btf_type *t1, *t2, *t3;
 	u32 type_id;
 
@@ -116,7 +116,8 @@ static void check_sched_switch_args(void)
 		return;
 
 	t3 = btf__type_by_id(btf, t2->type);
-	if (t3 && btf_is_func_proto(t3) && btf_vlen(t3) == 4) {
+	/* btf_trace func proto has one more argument for the context */
+	if (t3 && btf_is_func_proto(t3) && btf_vlen(t3) == 5) {
 		/* new format: pass prev_state as 4th arg */
 		skel->rodata->has_prev_state = true;
 	}
-- 
2.42.0



