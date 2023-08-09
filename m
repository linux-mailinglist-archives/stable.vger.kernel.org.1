Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D005B775D57
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjHILg1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbjHILg0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:36:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC3A2112
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:36:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4742E63527
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C87C433C8;
        Wed,  9 Aug 2023 11:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580982;
        bh=B/RAgFrvkzcuQPP/THAsHrdxKsIrw9YwaY8+Y2ndRBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tgrLO/gHY1MKb1V4NUPCmRMELCUWoKo+ZXCmx2Hw17bgYOF3qgENNvgqXI91YYpuy
         HsUQcqG8/qEsrM9IQVugwCqxBnXBZLxXp3nWbZbH3Ud+nil9m7CJUK+pn6TINHifAY
         zRLD9l4+QFgX6yNeQTkwDCwYsdHJWsIMFdlMGFw8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, mhiramat@kernel.org,
        Zheng Yejian <zhengyejian1@huawei.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 064/201] tracing: Fix warning in trace_buffered_event_disable()
Date:   Wed,  9 Aug 2023 12:41:06 +0200
Message-ID: <20230809103645.975359740@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zheng Yejian <zhengyejian1@huawei.com>

[ Upstream commit dea499781a1150d285c62b26659f62fb00824fce ]

Warning happened in trace_buffered_event_disable() at
  WARN_ON_ONCE(!trace_buffered_event_ref)

  Call Trace:
   ? __warn+0xa5/0x1b0
   ? trace_buffered_event_disable+0x189/0x1b0
   __ftrace_event_enable_disable+0x19e/0x3e0
   free_probe_data+0x3b/0xa0
   unregister_ftrace_function_probe_func+0x6b8/0x800
   event_enable_func+0x2f0/0x3d0
   ftrace_process_regex.isra.0+0x12d/0x1b0
   ftrace_filter_write+0xe6/0x140
   vfs_write+0x1c9/0x6f0
   [...]

The cause of the warning is in __ftrace_event_enable_disable(),
trace_buffered_event_enable() was called once while
trace_buffered_event_disable() was called twice.
Reproduction script show as below, for analysis, see the comments:
 ```
 #!/bin/bash

 cd /sys/kernel/tracing/

 # 1. Register a 'disable_event' command, then:
 #    1) SOFT_DISABLED_BIT was set;
 #    2) trace_buffered_event_enable() was called first time;
 echo 'cmdline_proc_show:disable_event:initcall:initcall_finish' > \
     set_ftrace_filter

 # 2. Enable the event registered, then:
 #    1) SOFT_DISABLED_BIT was cleared;
 #    2) trace_buffered_event_disable() was called first time;
 echo 1 > events/initcall/initcall_finish/enable

 # 3. Try to call into cmdline_proc_show(), then SOFT_DISABLED_BIT was
 #    set again!!!
 cat /proc/cmdline

 # 4. Unregister the 'disable_event' command, then:
 #    1) SOFT_DISABLED_BIT was cleared again;
 #    2) trace_buffered_event_disable() was called second time!!!
 echo '!cmdline_proc_show:disable_event:initcall:initcall_finish' > \
     set_ftrace_filter
 ```

To fix it, IIUC, we can change to call trace_buffered_event_enable() at
fist time soft-mode enabled, and call trace_buffered_event_disable() at
last time soft-mode disabled.

Link: https://lore.kernel.org/linux-trace-kernel/20230726095804.920457-1-zhengyejian1@huawei.com

Cc: <mhiramat@kernel.org>
Fixes: 0fc1b09ff1ff ("tracing: Use temp buffer when filtering events")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f8ed66f38175b..a46d34d840f69 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -371,7 +371,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 {
 	struct trace_event_call *call = file->event_call;
 	struct trace_array *tr = file->tr;
-	unsigned long file_flags = file->flags;
 	int ret = 0;
 	int disable;
 
@@ -395,6 +394,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 				break;
 			disable = file->flags & EVENT_FILE_FL_SOFT_DISABLED;
 			clear_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			/* Disable use of trace_buffered_event */
+			trace_buffered_event_disable();
 		} else
 			disable = !(file->flags & EVENT_FILE_FL_SOFT_MODE);
 
@@ -433,6 +434,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 			if (atomic_inc_return(&file->sm_ref) > 1)
 				break;
 			set_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			/* Enable use of trace_buffered_event */
+			trace_buffered_event_enable();
 		}
 
 		if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
@@ -472,15 +475,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		break;
 	}
 
-	/* Enable or disable use of trace_buffered_event */
-	if ((file_flags & EVENT_FILE_FL_SOFT_DISABLED) !=
-	    (file->flags & EVENT_FILE_FL_SOFT_DISABLED)) {
-		if (file->flags & EVENT_FILE_FL_SOFT_DISABLED)
-			trace_buffered_event_enable();
-		else
-			trace_buffered_event_disable();
-	}
-
 	return ret;
 }
 
-- 
2.40.1



