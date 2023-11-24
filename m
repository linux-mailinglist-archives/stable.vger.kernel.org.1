Return-Path: <stable+bounces-178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597E57F7493
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5480F1C20DCE
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAD6250F9;
	Fri, 24 Nov 2023 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NXDnu/Qn"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A5AD110
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 05:09:49 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr [85.170.33.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 136A220B74C0;
	Fri, 24 Nov 2023 05:09:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 136A220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700831389;
	bh=5X2JwOpByllef/VP7Y9O1DLhg1fhQ0DWV2XAPv8pjpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NXDnu/QnRvh/GPnwTn7w1PYQNA+doLhLs+sx2vjGj0d/DsILqqcZsxdNL4qDuqzES
	 0WmjXmW6JB/9Ss9vuGH/Kn7cK91dS7sdBz1HvODO4SQMrQElZLxLrUMXeX+fSsSF9x
	 79SauC+xQL7Vt1xSgTTWyVN9/OXxVpmmWiVA/e/4=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 5.10.y] tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
Date: Fri, 24 Nov 2023 14:09:35 +0100
Message-Id: <20231124130935.168451-1-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023102135-shuffle-blank-783e@gregkh>
References: <2023102135-shuffle-blank-783e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 kernel/trace/trace_kprobe.c | 74 +++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h  |  1 +
 2 files changed, 75 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 718357289899..2f7cdbecdddd 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -715,6 +715,36 @@ static inline void sanitize_event_name(char *name)
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
 static int trace_kprobe_create(int argc, const char *argv[])
 {
 	/*
@@ -842,6 +872,31 @@ static int trace_kprobe_create(int argc, const char *argv[])
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
 		ret = traceprobe_parse_event_name(&event, &group, buf,
@@ -1805,6 +1860,7 @@ static int unregister_kprobe_event(struct trace_kprobe *tk)
 }
 
 #ifdef CONFIG_PERF_EVENTS
+
 /* create a trace_kprobe, but don't add it to global lists */
 struct trace_event_call *
 create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
@@ -1814,6 +1870,24 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
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
index d4a69b83902e..22c05ca97758 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -390,6 +390,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_MAXACT,		"Invalid maxactive number"),		\
 	C(MAXACT_TOO_BIG,	"Maxactive is too big"),		\
 	C(BAD_PROBE_ADDR,	"Invalid probed address or symbol"),	\
+	C(NON_UNIQ_SYMBOL,	"The symbol is not unique"),		\
 	C(BAD_RETPROBE,		"Retprobe address must be an function entry"), \
 	C(BAD_ADDR_SUFFIX,	"Invalid probed address suffix"), \
 	C(NO_GROUP_NAME,	"Group name is not specified"),		\
-- 
2.34.1


