Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2B47A7B96
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjITLxg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbjITLxf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:53:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A519992
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:53:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BA7C433C8;
        Wed, 20 Sep 2023 11:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210808;
        bh=twPCkCSd/AKzg6yLjRzjxiRqOkS/tcre+Sd2tSGM0Nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yeFlY3yHHLBJG0dnl8aCRkhC5YIgGj13BBWIR2JMyap00RcWR3pQM3hzuQ4k6faGE
         HDS3abMIRq2+vQcLw92Y/CCWBjh9ieArrtggt9Viv9gLebLN6eO5vO7pxB0akOHY4R
         KuS01hpZTq8Osi+oaLLODaSx5LkzH/YPRLwLmBm8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.5 186/211] tracing: Have event inject files inc the trace array ref count
Date:   Wed, 20 Sep 2023 13:30:30 +0200
Message-ID: <20230920112851.640114311@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit e5c624f027ac74f97e97c8f36c69228ac9f1102d upstream.

The event inject files add events for a specific trace array. For an
instance, if the file is opened and the instance is deleted, reading or
writing to the file will cause a use after free.

Up the ref count of the trace_array when a event inject file is opened.

Link: https://lkml.kernel.org/r/20230907024804.292337868@goodmis.org
Link: https://lore.kernel.org/all/1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com/

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Fixes: 6c3edaf9fd6a ("tracing: Introduce trace event injection")
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_events_inject.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -328,7 +328,8 @@ event_inject_read(struct file *file, cha
 }
 
 const struct file_operations event_inject_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_inject_read,
 	.write = event_inject_write,
+	.release = tracing_release_file_tr,
 };


