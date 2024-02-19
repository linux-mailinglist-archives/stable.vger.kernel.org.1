Return-Path: <stable+bounces-20600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B72E85A89E
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6964288B02
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683D43C49D;
	Mon, 19 Feb 2024 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k3DpptQq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E543C49C
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359529; cv=none; b=dZvUTLE7aiftU8bEyjf6oO5dUH3gjuqyy78CrWGGO05puOn0KyQx/Ugq/VtmaBc6fOsxpgGiVJxJTkkqkGKAzXY02o3hPKfhXtrrnHJ2Ld9UqKYK2GlE89kKvH7EKTaVo9QuTpXc3kb5/o2khhkGBoIBxhQQynNi1jW8SDfY7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359529; c=relaxed/simple;
	bh=jNLMYGsLA4UzA8cfPtKUSfk4Dg9hEj9th9jaBNBSF2U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ugkLi3Gezt9IehZF8g9TO8OJH2BFZWef33w6LxBFC3A61ovkdZFQ77wk76sFcXy98qfHrSnjXCJ2in3fqjfau/0sjMrjE+75FjgkKIEo3ujztJuNh4QIRv4G14B4AAfQOSNmaDPeJHuEAhlOrdJK9aVJxe3FrWnONCRi+ahkagU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k3DpptQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0FFC433F1;
	Mon, 19 Feb 2024 16:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359528;
	bh=jNLMYGsLA4UzA8cfPtKUSfk4Dg9hEj9th9jaBNBSF2U=;
	h=Subject:To:Cc:From:Date:From;
	b=k3DpptQqmGAfLvn6smMXUaRi0uzj8HFFbVK9BUOKNR7NpNeQOsym2rKUnhEYudzA0
	 auYZo/X/AGpTHwC86ziLIwfOjTXlZVvja23DPLmuziaB0pR8wH1d/wpGqaFtEufhAp
	 KHZ9WATvbT5Anhyi1hssOzTTOE8RRHz098F+Ygn0=
Subject: FAILED: patch "[PATCH] tracing/probes: Fix to show a parse error for bad type for" failed to apply to 5.10-stable tree
To: mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:18:41 +0100
Message-ID: <2024021941-launch-unjustly-2fa8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8c427cc2fa73684ea140999e121b7b6c1c717632
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021941-launch-unjustly-2fa8@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

8c427cc2fa73 ("tracing/probes: Fix to show a parse error for bad type for $comm")
27973e5c64b9 ("tracing/probes: Add string type check with BTF")
d157d7694460 ("tracing/probes: Support BTF field access from $retval")
c440adfbe302 ("tracing/probes: Support BTF based data structure field access")
ebeed8d4a555 ("tracing/probes: Move finding func-proto API and getting func-param API to trace_btf")
b1d1e90490b6 ("tracing/probes: Support BTF argument on module functions")
1f9f4f4777e7 ("tracing/probes: Fix to add NULL check for BTF APIs")
53431798f4bb ("tracing/probes: Fix tracepoint event with $arg* to fetch correct argument")
fd26290ec89d ("tracing/probes: Add BTF retval type support")
18b1e870a496 ("tracing/probes: Add $arg* meta argument for all function args")
b576e09701c7 ("tracing/probes: Support function parameters if BTF is available")
1b8b0cd754cd ("tracing/probes: Move event parameter fetching code to common parser")
e2d0d7b2f42d ("tracing/probes: Add tracepoint support on fprobe_events")
334e5519c375 ("tracing/probes: Add fprobe events for tracing function entry and exit.")
30460c21ed40 ("tracing/probes: Avoid setting TPARG_FL_FENTRY and TPARG_FL_RETURN")
d4505aa6afae ("tracing/probes: Reject symbol/symstr type for uprobe")
b26a124cbfa8 ("tracing/probes: Add symstr type for dynamic events")
61b304b73ab4 ("tracing/fprobe: Fix to check whether fprobe is registered correctly")
752be5c5c910 ("tracing/eprobe: Add eprobe filter support")
ab8384442ee5 ("tracing/probes: Have kprobes and uprobes use $COMM too")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8c427cc2fa73684ea140999e121b7b6c1c717632 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Wed, 24 Jan 2024 00:02:34 +0900
Subject: [PATCH] tracing/probes: Fix to show a parse error for bad type for
 $comm

Fix to show a parse error for bad type (non-string) for $comm/$COMM and
immediate-string. With this fix, error_log file shows appropriate error
message as below.

 /sys/kernel/tracing # echo 'p vfs_read $comm:u32' >> kprobe_events
sh: write error: Invalid argument
 /sys/kernel/tracing # echo 'p vfs_read \"hoge":u32' >> kprobe_events
sh: write error: Invalid argument
 /sys/kernel/tracing # cat error_log

[   30.144183] trace_kprobe: error: $comm and immediate-string only accepts string type
  Command: p vfs_read $comm:u32
                            ^
[   62.618500] trace_kprobe: error: $comm and immediate-string only accepts string type
  Command: p vfs_read \"hoge":u32
                              ^
Link: https://lore.kernel.org/all/170602215411.215583.2238016352271091852.stgit@devnote2/

Fixes: 3dd1f7f24f8c ("tracing: probeevent: Fix to make the type of $comm string")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 4dc74d73fc1d..c6da5923e5b9 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1159,9 +1159,12 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	if (!(ctx->flags & TPARG_FL_TEVENT) &&
 	    (strcmp(arg, "$comm") == 0 || strcmp(arg, "$COMM") == 0 ||
 	     strncmp(arg, "\\\"", 2) == 0)) {
-		/* The type of $comm must be "string", and not an array. */
-		if (parg->count || (t && strcmp(t, "string")))
+		/* The type of $comm must be "string", and not an array type. */
+		if (parg->count || (t && strcmp(t, "string"))) {
+			trace_probe_log_err(ctx->offset + (t ? (t - arg) : 0),
+					NEED_STRING_TYPE);
 			goto out;
+		}
 		parg->type = find_fetch_type("string", ctx->flags);
 	} else
 		parg->type = find_fetch_type(t, ctx->flags);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 850d9ecb6765..c1877d018269 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -515,7 +515,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_HYPHEN,		"Failed to parse single hyphen. Forgot '>'?"),	\
 	C(NO_BTF_FIELD,		"This field is not found."),	\
 	C(BAD_BTF_TID,		"Failed to get BTF type info."),\
-	C(BAD_TYPE4STR,		"This type does not fit for string."),
+	C(BAD_TYPE4STR,		"This type does not fit for string."),\
+	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a


