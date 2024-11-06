Return-Path: <stable+bounces-91456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E536C9BEE11
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DCD286913
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EC01EF94F;
	Wed,  6 Nov 2024 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IaDpHJQ+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9A1EE01A;
	Wed,  6 Nov 2024 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898784; cv=none; b=pIRsxAw2kJiwP/j1HI8nK92A0ln4RYXWCNs+hvAiiOXcWzDta9byMw933gKAYaIQRFGrrN9XWyd+skrigbtwC9H39/C81fDF2zF0rOxwB6V3L79aVihEgRIwkLM62Zw3WgUjcsPMiwvCQFeFAORh/IgaN/Cxot8aNql1gvQWu9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898784; c=relaxed/simple;
	bh=Thp0yKPWojygWlJHiu65qPvNS6tjL8aec6F2Hs3EmFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7aWiSSwYWIsbLC4oVHUh4afd8nNeADn9iIbEAPziCIlf3uXdNp0Lrg/UCqs94Dyau8Xvf6J5/qxPT385DvPhhRVMAvwsZcLMgmp1tmo3k0mCElZFzuIMUVm0c9jXj4unkFqJrFgmo6iZCecaeUOQMLe9CG5cWp2cSP9PRyW3eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IaDpHJQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B896C4CECD;
	Wed,  6 Nov 2024 13:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898784;
	bh=Thp0yKPWojygWlJHiu65qPvNS6tjL8aec6F2Hs3EmFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IaDpHJQ+Wa+GcEfRaBqBiToNEVXab49lExpRTNuYBi1jnUCdsl+JFjivYDiZMcG3E
	 q9LV94LZPJUG+1HqoqytT1H7t8R6B5J3seWrpLOwbl6ky6N4aT6Wt1espprOhi3IDb
	 k20wIWpGe9OH0Q4rJkFtMf/8mqFTxA1+aYmwd6vc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	Sherry Yang <sherry.yang@oracle.com>
Subject: [PATCH 5.4 355/462] tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
Date: Wed,  6 Nov 2024 13:04:08 +0100
Message-ID: <20241106120340.299815837@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Francis Laniel <flaniel@linux.microsoft.com>

commit b022f0c7e404887a7c5229788fc99eff9f9a80d5 upstream.

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
[ Sherry: kselftest kprobe_non_uniq_symbol.tc failed on 5.4.y, because of missing
  this commit, backport it to 5.4.y. Minor conflicts due to context change, ignore
  context change ]
Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_kprobe.c |   74 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h  |    1 
 2 files changed, 75 insertions(+)

--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -714,6 +714,36 @@ static inline void sanitize_event_name(c
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
@@ -825,6 +855,31 @@ static int trace_kprobe_create(int argc,
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
@@ -1596,6 +1651,7 @@ static int unregister_kprobe_event(struc
 }
 
 #ifdef CONFIG_PERF_EVENTS
+
 /* create a trace_kprobe, but don't add it to global lists */
 struct trace_event_call *
 create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
@@ -1605,6 +1661,24 @@ create_local_trace_kprobe(char *func, vo
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
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -403,6 +403,7 @@ extern int traceprobe_define_arg_fields(
 	C(BAD_MAXACT,		"Invalid maxactive number"),		\
 	C(MAXACT_TOO_BIG,	"Maxactive is too big"),		\
 	C(BAD_PROBE_ADDR,	"Invalid probed address or symbol"),	\
+	C(NON_UNIQ_SYMBOL,	"The symbol is not unique"),		\
 	C(BAD_RETPROBE,		"Retprobe address must be an function entry"), \
 	C(NO_GROUP_NAME,	"Group name is not specified"),		\
 	C(GROUP_TOO_LONG,	"Group name is too long"),		\



