Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3AD79B4A4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjIKUue (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242359AbjIKP2y (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:28:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2A0E4
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:28:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561C4C433CD;
        Mon, 11 Sep 2023 15:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694446129;
        bh=NvtVzgSc9Om23mpOJmHud+DFVzl9nfq0NV+Bp5x1qqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwKFVlAKKaveiVqVHoB0+fUf4nUEcCu0EcNxMPS7q4m3rw2YD65rpzrZLa/cO4bgo
         I2doZ8Gc+Kx+vEj622F/RCefYu0RVhWeQnF6CJh1i9Mguc5nZis5woz3KVkTtmJukd
         tJ5sKCPU6B1sm/lMYS5i7285VaesweO4BAdrH3+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Yejian <zhengyejian1@huawei.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.1 592/600] tracing: Zero the pipe cpumask on alloc to avoid spurious -EBUSY
Date:   Mon, 11 Sep 2023 15:50:25 +0200
Message-ID: <20230911134651.118928570@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Foster <bfoster@redhat.com>

commit 3d07fa1dd19035eb0b13ae6697efd5caa9033e74 upstream.

The pipe cpumask used to serialize opens between the main and percpu
trace pipes is not zeroed or initialized. This can result in
spurious -EBUSY returns if underlying memory is not fully zeroed.
This has been observed by immediate failure to read the main
trace_pipe file on an otherwise newly booted and idle system:

 # cat /sys/kernel/debug/tracing/trace_pipe
 cat: /sys/kernel/debug/tracing/trace_pipe: Device or resource busy

Zero the allocation of pipe_cpumask to avoid the problem.

Link: https://lore.kernel.org/linux-trace-kernel/20230831125500.986862-1-bfoster@redhat.com

Cc: stable@vger.kernel.org
Fixes: c2489bb7e6be ("tracing: Introduce pipe_cpumask to avoid race on trace_pipes")
Reviewed-by: Zheng Yejian <zhengyejian1@huawei.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Brian Foster <bfoster@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9395,7 +9395,7 @@ static struct trace_array *trace_array_c
 	if (!alloc_cpumask_var(&tr->tracing_cpumask, GFP_KERNEL))
 		goto out_free_tr;
 
-	if (!alloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
 		goto out_free_tr;
 
 	tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
@@ -10267,7 +10267,7 @@ __init static int tracer_alloc_buffers(v
 	if (trace_create_savedcmd() < 0)
 		goto out_free_temp_buffer;
 
-	if (!alloc_cpumask_var(&global_trace.pipe_cpumask, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&global_trace.pipe_cpumask, GFP_KERNEL))
 		goto out_free_savedcmd;
 
 	/* TODO: make the number of buffers hot pluggable with CPUS */


