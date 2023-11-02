Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B856F7DF939
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 18:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjKBRy5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 13:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjKBRy4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 13:54:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A01131
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 10:54:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B2AC433C7;
        Thu,  2 Nov 2023 17:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698947690;
        bh=jkmah/NVtRcLoayrc8MYpED7jPSHqdmR2a4wQtZ/qjs=;
        h=Subject:To:Cc:From:Date:From;
        b=zw/CVCs+e+Aus8qGweqZRuSpKNtwK4sAI0iu5zfVCXhoyubSvmlQSqwliLvrrA05/
         eEttuu8zhFuDs07o4/TMe5eBuuVD2PMlPfeGxPrCKhjkXM5gaByjf5BP0H2/C/hvks
         QIAAXXzZx4sZGtAnZ25DLsmWKs11idPtVAeHxiaY=
Subject: FAILED: patch "[PATCH] tracing/kprobes: Return EADDRNOTAVAIL when func matches" failed to apply to 5.15-stable tree
To:     flaniel@linux.microsoft.com, mhiramat@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 02 Nov 2023 18:54:47 +0100
Message-ID: <2023110246-cursive-monthly-f800@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x b022f0c7e404887a7c5229788fc99eff9f9a80d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023110246-cursive-monthly-f800@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b022f0c7e404887a7c5229788fc99eff9f9a80d5 Mon Sep 17 00:00:00 2001
From: Francis Laniel <flaniel@linux.microsoft.com>
Date: Fri, 20 Oct 2023 13:42:49 +0300
Subject: [PATCH] tracing/kprobes: Return EADDRNOTAVAIL when func matches
 several symbols

When a kprobe is attached to a function that's name is not unique (is
static and shares the name with other functions in the kernel), the
kprobe is attached to the first function it finds. This is a bug as the
function that it is attaching to is not necessarily the one that the
user wants to attach to.

Instead of blindly picking a function to attach to what is ambiguous,
error with EADDRNOTAVAIL to let the user know that this function is not
unique, and that the user must use another unique function with an
address offset to get to the function they want to attach to.

Link: https://lore.kernel.org/all/20231020104250.9537-2-flaniel@linux.microsoft.com/

Cc: stable@vger.kernel.org
Fixes: 413d37d1eb69 ("tracing: Add kprobe-based event tracer")
Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
Link: https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea742@kernel.org/
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 3d7a180a8427..a8fef6ab0872 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -705,6 +705,25 @@ static struct notifier_block trace_kprobe_module_nb = {
 	.priority = 1	/* Invoked after kprobe module callback */
 };
 
+static int count_symbols(void *data, unsigned long unused)
+{
+	unsigned int *count = data;
+
+	(*count)++;
+
+	return 0;
+}
+
+static unsigned int number_of_same_symbols(char *func_name)
+{
+	unsigned int count;
+
+	count = 0;
+	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
+
+	return count;
+}
+
 static int __trace_kprobe_create(int argc, const char *argv[])
 {
 	/*
@@ -836,6 +855,31 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		}
 	}
 
+	if (symbol && !strchr(symbol, ':')) {
+		unsigned int count;
+
+		count = number_of_same_symbols(symbol);
+		if (count > 1) {
+			/*
+			 * Users should use ADDR to remove the ambiguity of
+			 * using KSYM only.
+			 */
+			trace_probe_log_err(0, NON_UNIQ_SYMBOL);
+			ret = -EADDRNOTAVAIL;
+
+			goto error;
+		} else if (count == 0) {
+			/*
+			 * We can return ENOENT earlier than when register the
+			 * kprobe.
+			 */
+			trace_probe_log_err(0, BAD_PROBE_ADDR);
+			ret = -ENOENT;
+
+			goto error;
+		}
+	}
+
 	trace_probe_log_set_index(0);
 	if (event) {
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
@@ -1695,6 +1739,7 @@ static int unregister_kprobe_event(struct trace_kprobe *tk)
 }
 
 #ifdef CONFIG_PERF_EVENTS
+
 /* create a trace_kprobe, but don't add it to global lists */
 struct trace_event_call *
 create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
@@ -1705,6 +1750,24 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 	int ret;
 	char *event;
 
+	if (func) {
+		unsigned int count;
+
+		count = number_of_same_symbols(func);
+		if (count > 1)
+			/*
+			 * Users should use addr to remove the ambiguity of
+			 * using func only.
+			 */
+			return ERR_PTR(-EADDRNOTAVAIL);
+		else if (count == 0)
+			/*
+			 * We can return ENOENT earlier than when register the
+			 * kprobe.
+			 */
+			return ERR_PTR(-ENOENT);
+	}
+
 	/*
 	 * local trace_kprobes are not added to dyn_event, so they are never
 	 * searched in find_trace_kprobe(). Therefore, there is no concern of
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 02b432ae7513..850d9ecb6765 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -450,6 +450,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_MAXACT,		"Invalid maxactive number"),		\
 	C(MAXACT_TOO_BIG,	"Maxactive is too big"),		\
 	C(BAD_PROBE_ADDR,	"Invalid probed address or symbol"),	\
+	C(NON_UNIQ_SYMBOL,	"The symbol is not unique"),		\
 	C(BAD_RETPROBE,		"Retprobe address must be an function entry"), \
 	C(NO_TRACEPOINT,	"Tracepoint is not found"),		\
 	C(BAD_ADDR_SUFFIX,	"Invalid probed address suffix"), \

