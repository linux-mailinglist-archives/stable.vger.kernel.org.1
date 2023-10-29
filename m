Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B25A7DAC8C
	for <lists+stable@lfdr.de>; Sun, 29 Oct 2023 13:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjJ2Mub (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 29 Oct 2023 08:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjJ2Mub (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 29 Oct 2023 08:50:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F269BB0
        for <stable@vger.kernel.org>; Sun, 29 Oct 2023 05:50:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCB9C433C8;
        Sun, 29 Oct 2023 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698583828;
        bh=9W6FF+geU0pd20hOroPh+azaYXMsDkJkBQlOH2NuV1o=;
        h=Subject:To:Cc:From:Date:From;
        b=2Zw4YTkBd44NAkzsfZWtEkzZtPTwKeWSTWo3w1BaqxKJzCILNMiEc1Ry72khKI933
         VtgYns6F648AwKlFwcy9Zxt/M2TgeZFYe70wLQr7snfKM/7+2uyYF9vvYJ76lfkDQ+
         YLicgItHMBge+jL2Fn3iApyP/3UqKHbwylZdazLg=
Subject: FAILED: patch "[PATCH] tracing/kprobes: Fix symbol counting logic by looking at" failed to apply to 6.1-stable tree
To:     andrii@kernel.org, flaniel@linux.microsoft.com,
        mhiramat@kernel.org, rostedt@goodmis.org, song@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 29 Oct 2023 13:50:23 +0100
Message-ID: <2023102922-handwrite-unpopular-0e1d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 926fe783c8a64b33997fec405cf1af3e61aed441
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102922-handwrite-unpopular-0e1d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 926fe783c8a64b33997fec405cf1af3e61aed441 Mon Sep 17 00:00:00 2001
From: Andrii Nakryiko <andrii@kernel.org>
Date: Fri, 27 Oct 2023 16:31:26 -0700
Subject: [PATCH] tracing/kprobes: Fix symbol counting logic by looking at
 modules as well

Recent changes to count number of matching symbols when creating
a kprobe event failed to take into account kernel modules. As such, it
breaks kprobes on kernel module symbols, by assuming there is no match.

Fix this my calling module_kallsyms_on_each_symbol() in addition to
kallsyms_on_each_match_symbol() to perform a proper counting.

Link: https://lore.kernel.org/all/20231027233126.2073148-1-andrii@kernel.org/

Cc: Francis Laniel <flaniel@linux.microsoft.com>
Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 95c5b0668cb7..e834f149695b 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -714,14 +714,30 @@ static int count_symbols(void *data, unsigned long unused)
 	return 0;
 }
 
+struct sym_count_ctx {
+	unsigned int count;
+	const char *name;
+};
+
+static int count_mod_symbols(void *data, const char *name, unsigned long unused)
+{
+	struct sym_count_ctx *ctx = data;
+
+	if (strcmp(name, ctx->name) == 0)
+		ctx->count++;
+
+	return 0;
+}
+
 static unsigned int number_of_same_symbols(char *func_name)
 {
-	unsigned int count;
+	struct sym_count_ctx ctx = { .count = 0, .name = func_name };
+
+	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
 
-	count = 0;
-	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
+	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
 
-	return count;
+	return ctx.count;
 }
 
 static int __trace_kprobe_create(int argc, const char *argv[])

