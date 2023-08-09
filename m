Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A10775E07
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjHILnT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbjHILnP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:43:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAED0DF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:43:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B1D96370E
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A17C433C8;
        Wed,  9 Aug 2023 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581393;
        bh=dkyT2E/aS0Z6nkugb0/KCXt0ujX2sMIqaUO3hwSpK14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oz83vsiYydYcCb1ndsQbpXXMZG9x0VirkFc6aE0m+k2odPZTzFgYEz9wPZxtNMwC5
         YAkoydswAYjvwNDnFwNgZFQALjOllqFjlKxbQCml/71VfNygcyng9Q+7mm6xVzNK+K
         dUmmCWqo3aXkUViKiBVvQxY2Q/+owNVTbIrbv8JM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 5.10 177/201] tracing: Fix sleeping while atomic in kdb ftdump
Date:   Wed,  9 Aug 2023 12:42:59 +0200
Message-ID: <20230809103649.672558211@linuxfoundation.org>
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

From: Douglas Anderson <dianders@chromium.org>

commit 495fcec8648cdfb483b5b9ab310f3839f07cb3b8 upstream.

If you drop into kdb and type "ftdump" you'll get a sleeping while
atomic warning from memory allocation in trace_find_next_entry().

This appears to have been caused by commit ff895103a84a ("tracing:
Save off entry when peeking at next entry"), which added the
allocation in that path. The problematic commit was already fixed by
commit 8e99cf91b99b ("tracing: Do not allocate buffer in
trace_find_next_entry() in atomic") but that fix missed the kdb case.

The fix here is easy: just move the assignment of the static buffer to
the place where it should have been to begin with:
trace_init_global_iter(). That function is called in two places, once
is right before the assignment of the static buffer added by the
previous fix and once is in kdb.

Note that it appears that there's a second static buffer that we need
to assign that was added in commit efbbdaa22bb7 ("tracing: Show real
address for trace event arguments"), so we'll move that too.

Link: https://lkml.kernel.org/r/20220708170919.1.I75844e5038d9425add2ad853a608cb44bb39df40@changeid

Fixes: ff895103a84a ("tracing: Save off entry when peeking at next entry")
Fixes: efbbdaa22bb7 ("tracing: Show real address for trace event arguments")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9416,6 +9416,12 @@ void trace_init_global_iter(struct trace
 	/* Output in nanoseconds only if we are using a clock in nanoseconds. */
 	if (trace_clocks[iter->tr->clock_id].in_ns)
 		iter->iter_flags |= TRACE_FILE_TIME_IN_NS;
+
+	/* Can not use kmalloc for iter.temp and iter.fmt */
+	iter->temp = static_temp_buf;
+	iter->temp_size = STATIC_TEMP_BUF_SIZE;
+	iter->fmt = static_fmt_buf;
+	iter->fmt_size = STATIC_FMT_BUF_SIZE;
 }
 
 void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
@@ -9449,11 +9455,6 @@ void ftrace_dump(enum ftrace_dump_mode o
 
 	/* Simulate the iterator */
 	trace_init_global_iter(&iter);
-	/* Can not use kmalloc for iter.temp and iter.fmt */
-	iter.temp = static_temp_buf;
-	iter.temp_size = STATIC_TEMP_BUF_SIZE;
-	iter.fmt = static_fmt_buf;
-	iter.fmt_size = STATIC_FMT_BUF_SIZE;
 
 	for_each_tracing_cpu(cpu) {
 		atomic_inc(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);


