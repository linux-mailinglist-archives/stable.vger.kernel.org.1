Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D774B78AA32
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjH1KUF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjH1KTc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:19:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550CD124
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:19:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C1E763782
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F67FC433C7;
        Mon, 28 Aug 2023 10:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217952;
        bh=tW0RA2Di4G+ycEI3ZX5gI6Igc+l/32bZysRDIafBhQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oBfiwOvUX6WVzZ2Cm33Qw7/1hrWLvtaf4fWpIh9XHhZVXLng7BFmGMS2NFl6undiG
         IJ9YMhI2sHnFAN8KVG0fPwI7XsxjjkAdkce01oO2Mnjr0X6unZTmguGHS356cEH3zl
         64pD/OC1KMig9W8bMnceU/yv7Fno5A1lHR0FO2wg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 013/129] tracing/synthetic: Skip first entry for stack traces
Date:   Mon, 28 Aug 2023 12:11:32 +0200
Message-ID: <20230828101157.829705569@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Schnelle <svens@linux.ibm.com>

[ Upstream commit 887f92e09ef34a949745ad26ce82be69e2dabcf6 ]

While debugging another issue I noticed that the stack trace output
contains the number of entries on top:

         <idle>-0       [000] d..4.   203.322502: wake_lat: pid=0 delta=2268270616 stack=STACK:
=> 0x10
=> __schedule+0xac6/0x1a98
=> schedule+0x126/0x2c0
=> schedule_timeout+0x242/0x2c0
=> __wait_for_common+0x434/0x680
=> __wait_rcu_gp+0x198/0x3e0
=> synchronize_rcu+0x112/0x138
=> ring_buffer_reset_online_cpus+0x140/0x2e0
=> tracing_reset_online_cpus+0x15c/0x1d0
=> tracing_set_clock+0x180/0x1d8
=> hist_register_trigger+0x486/0x670
=> event_hist_trigger_parse+0x494/0x1318
=> trigger_process_regex+0x1d4/0x258
=> event_trigger_write+0xb4/0x170
=> vfs_write+0x210/0xad0
=> ksys_write+0x122/0x208

Fix this by skipping the first element. Also replace the pointer
logic with an index variable which is easier to read.

Link: https://lkml.kernel.org/r/20230816154928.4171614-3-svens@linux.ibm.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_synth.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index da0627fa91caf..a4c58a932dfa6 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -350,7 +350,7 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 	struct trace_seq *s = &iter->seq;
 	struct synth_trace_event *entry;
 	struct synth_event *se;
-	unsigned int i, n_u64;
+	unsigned int i, j, n_u64;
 	char print_fmt[32];
 	const char *fmt;
 
@@ -389,18 +389,13 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 			}
 		} else if (se->fields[i]->is_stack) {
-			unsigned long *p, *end;
 			union trace_synth_field *data = &entry->fields[n_u64];
-
-			p = (void *)entry + data->as_dynamic.offset;
-			end = (void *)p + data->as_dynamic.len - (sizeof(long) - 1);
+			unsigned long *p = (void *)entry + data->as_dynamic.offset;
 
 			trace_seq_printf(s, "%s=STACK:\n", se->fields[i]->name);
-
-			for (; *p && p < end; p++)
-				trace_seq_printf(s, "=> %pS\n", (void *)*p);
+			for (j = 1; j < data->as_dynamic.len / sizeof(long); j++)
+				trace_seq_printf(s, "=> %pS\n", (void *)p[j]);
 			n_u64++;
-
 		} else {
 			struct trace_print_flags __flags[] = {
 			    __def_gfpflag_names, {-1, NULL} };
@@ -490,10 +485,6 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
 			break;
 	}
 
-	/* Include the zero'd element if it fits */
-	if (len < HIST_STACKTRACE_DEPTH)
-		len++;
-
 	len *= sizeof(long);
 
 	/* Find the dynamic section to copy the stack into. */
-- 
2.40.1



