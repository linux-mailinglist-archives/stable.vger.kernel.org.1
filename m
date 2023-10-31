Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9E37DD55A
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376495AbjJaRtp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376544AbjJaRtn (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:49:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA14BF5
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:49:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045C9C433C8;
        Tue, 31 Oct 2023 17:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774580;
        bh=/TvA3OcSogIL/3XE8I/UqCjZ0AsHE1mF8FP/jLrkvuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ethpzAuNusjIbTpzgKrmW5AUODRhEhhlm6KmWRn+XExE1+5NrNdoKSwH0m9nPj7/b
         au7WOU8LjdVYr2sEcuvNsK/OHuhh8v9mefqkLI9rcrrxFEifRjoYw+xADprQaExNxz
         DJWk8MTJ4j1vJHww25WMQtb/U90VJ+bDw4xald9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH 6.5 093/112] tracing/kprobes: Fix symbol counting logic by looking at modules as well
Date:   Tue, 31 Oct 2023 18:01:34 +0100
Message-ID: <20231031165904.233960529@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrii Nakryiko <andrii@kernel.org>

commit 926fe783c8a64b33997fec405cf1af3e61aed441 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_kprobe.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -714,14 +714,30 @@ static int count_symbols(void *data, uns
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


