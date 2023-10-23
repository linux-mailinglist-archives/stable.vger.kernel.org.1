Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3034E7D2F62
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 12:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjJWKBw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 06:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjJWJua (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 05:50:30 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B124D70
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 02:50:27 -0700 (PDT)
Received: from pwmachine.numericable.fr (unknown [188.24.154.80])
        by linux.microsoft.com (Postfix) with ESMTPSA id 91F5B20B74C1;
        Mon, 23 Oct 2023 02:50:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 91F5B20B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1698054626;
        bh=FAEhFYOhnayu4PeFFq8VQQmGfr1cpHPLceibWhYsytY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JLWdxS9A1wnIiRydSYwyT0aDvfcI7xeJmWFfpsu1f4IJc7gmMfaWvzCG4FOjWJn+T
         r9sW9lYhdPs96eVE+viryujoRxCFBktNWCMkLRuXxhNxFDpQUHhz4K/gXQsYW95R9m
         GxCGFkvrLh48NXepGnbiPp+wt8CSe5V/u2HuemO4=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Francis Laniel <flaniel@linux.microsoft.com>
Subject: [PATCH 4.14.y 1/1] tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
Date:   Mon, 23 Oct 2023 12:49:47 +0300
Message-Id: <20231023094947.258663-2-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023094947.258663-1-flaniel@linux.microsoft.com>
References: <2023102140-tartly-democrat-140d@gregkh>
 <20231023094947.258663-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
(cherry picked from commit b022f0c7e404887a7c5229788fc99eff9f9a80d5)
---
 kernel/trace/trace_kprobe.c | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index d66aed6e9c75..45779ec370fa 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -617,6 +617,36 @@ static inline void sanitize_event_name(char *name)
 			*name = '_';
 }
 
+struct count_symbols_struct {
+	const char *func_name;
+	unsigned int count;
+};
+
+static int count_symbols(void *data, const char *name, struct module *unused0,
+			 unsigned long unused1)
+{
+	struct count_symbols_struct *args = data;
+
+	if (strcmp(args->func_name, name))
+		return 0;
+
+	args->count++;
+
+	return 0;
+}
+
+static unsigned int number_of_same_symbols(char *func_name)
+{
+	struct count_symbols_struct args = {
+		.func_name = func_name,
+		.count = 0,
+	};
+
+	kallsyms_on_each_symbol(count_symbols, &args);
+
+	return args.count;
+}
+
 static int create_trace_kprobe(int argc, char **argv)
 {
 	/*
@@ -746,6 +776,24 @@ static int create_trace_kprobe(int argc, char **argv)
 	}
 	argc -= 2; argv += 2;
 
+	if (symbol && !strchr(symbol, ':')) {
+		unsigned int count;
+
+		count = number_of_same_symbols(symbol);
+		if (count > 1)
+			/*
+			 * Users should use ADDR to remove the ambiguity of
+			 * using KSYM only.
+			 */
+			return -EADDRNOTAVAIL;
+		else if (count == 0)
+			/*
+			 * We can return ENOENT earlier than when register the
+			 * kprobe.
+			 */
+			return -ENOENT;
+	}
+
 	/* setup a probe */
 	if (!event) {
 		/* Make a new event name */
-- 
2.34.1

