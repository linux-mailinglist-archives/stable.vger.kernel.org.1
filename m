Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3EF7A7970
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 12:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbjITKiS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 06:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjITKiR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 06:38:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E21AD
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 03:38:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F714C433C7;
        Wed, 20 Sep 2023 10:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695206290;
        bh=qttWFKbLtj4A9K25TPtAIv6IWBC31btpgupPoh+NyII=;
        h=Subject:To:Cc:From:Date:From;
        b=bn7UEHI6nw0cA60cOIc72tPgcBe57vN2X4zfFKIHjPJla0kTOl7y8gJTsIXV0h80w
         aXaztp1uW6SqeHpgak3yuQHZ1WF+f7+/02FDbvb2r09/UQ4BF7dFaILVvsgk7Y7EAB
         hMUjpcmxSEHi6iIaKm2nltIqsjNPDPFq9CSupZXk=
Subject: FAILED: patch "[PATCH] tracing: Have event inject files inc the trace array ref" failed to apply to 5.15-stable tree
To:     rostedt@goodmis.org, akpm@linux-foundation.org, lkft@linaro.org,
        mark.rutland@arm.com, mhiramat@kernel.org,
        naresh.kamboju@linaro.org, zhengyejian1@huawei.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 12:37:33 +0200
Message-ID: <2023092033-smother-cannabis-e03d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e5c624f027ac74f97e97c8f36c69228ac9f1102d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023092033-smother-cannabis-e03d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

e5c624f027ac ("tracing: Have event inject files inc the trace array ref count")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e5c624f027ac74f97e97c8f36c69228ac9f1102d Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Wed, 6 Sep 2023 22:47:16 -0400
Subject: [PATCH] tracing: Have event inject files inc the trace array ref
 count

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

diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index abe805d471eb..8650562bdaa9 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -328,7 +328,8 @@ event_inject_read(struct file *file, char __user *buf, size_t size,
 }
 
 const struct file_operations event_inject_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_inject_read,
 	.write = event_inject_write,
+	.release = tracing_release_file_tr,
 };

