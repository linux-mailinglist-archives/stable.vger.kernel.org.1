Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DE67A7D9B
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjITMKe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbjITMKc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:10:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AB793
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:10:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7929BC433C9;
        Wed, 20 Sep 2023 12:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211825;
        bh=jHO9DRr8UDqXdjHUldmhVuxiHDxZyW3KQzsG/WkO19M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cljZrJ7Pfmh5KGEDE0YbAgxQKSzFMsj0X6ZJeH/tICVzP/0WJXiRkLG+Fg/svrivu
         NHhDNQpz5j6CjhWvZgLjoTSHnyNEkWGDnSW3/k0rxmkVWuW0OiE5QohEdLtOSjf6hX
         hleE+8aM01xeKTaZkau2UsOgi2sq1PPwzdtDfBWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yafang Shao <laoar.shao@gmail.com>,
        Yonghong Song <yhs@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 050/273] bpf: Clear the probe_addr for uprobe
Date:   Wed, 20 Sep 2023 13:28:10 +0200
Message-ID: <20230920112847.971792621@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yafang Shao <laoar.shao@gmail.com>

[ Upstream commit 5125e757e62f6c1d5478db4c2b61a744060ddf3f ]

To avoid returning uninitialized or random values when querying the file
descriptor (fd) and accessing probe_addr, it is necessary to clear the
variable prior to its use.

Fixes: 41bdc4b40ed6 ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20230709025630.3735-6-laoar.shao@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/trace_events.h | 3 ++-
 kernel/trace/bpf_trace.c     | 2 +-
 kernel/trace/trace_uprobe.c  | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 0643c083ed862..93a1b5497bdf1 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -581,7 +581,8 @@ extern int  perf_uprobe_init(struct perf_event *event, bool is_retprobe);
 extern void perf_uprobe_destroy(struct perf_event *event);
 extern int bpf_get_uprobe_info(const struct perf_event *event,
 			       u32 *fd_type, const char **filename,
-			       u64 *probe_offset, bool perf_type_tracepoint);
+			       u64 *probe_offset, u64 *probe_addr,
+			       bool perf_type_tracepoint);
 #endif
 extern int  ftrace_profile_set_filter(struct perf_event *event, int event_id,
 				     char *filter_str);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1cb13d6368f3f..b794470bb42ed 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1274,7 +1274,7 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 #ifdef CONFIG_UPROBE_EVENTS
 		if (flags & TRACE_EVENT_FL_UPROBE)
 			err = bpf_get_uprobe_info(event, fd_type, buf,
-						  probe_offset,
+						  probe_offset, probe_addr,
 						  event->attr.type == PERF_TYPE_TRACEPOINT);
 #endif
 	}
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 0da379b902492..0e3bdd69fa2d6 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1159,7 +1159,7 @@ static void uretprobe_perf_func(struct trace_uprobe *tu, unsigned long func,
 
 int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,
 			const char **filename, u64 *probe_offset,
-			bool perf_type_tracepoint)
+			u64 *probe_addr, bool perf_type_tracepoint)
 {
 	const char *pevent = trace_event_name(event->tp_event);
 	const char *group = event->tp_event->class->system;
@@ -1176,6 +1176,7 @@ int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,
 				    : BPF_FD_TYPE_UPROBE;
 	*filename = tu->filename;
 	*probe_offset = tu->offset;
+	*probe_addr = 0;
 	return 0;
 }
 #endif	/* CONFIG_PERF_EVENTS */
-- 
2.40.1



