Return-Path: <stable+bounces-20598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE29485A89C
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CAE01C233DE
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5273C46F;
	Mon, 19 Feb 2024 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lxDUUN6c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A823B7A1
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359522; cv=none; b=Dec96AsunTV7JOat+CPt29vTM6nB32JLO4rh0XNZZ0frQTj2J0N2X0/n5FrwzaU3jDKiUGzrTZfZ/ej3BRhWTp/Im14bmptLzGaNJVPfbQN2JeSyGAVqt3gca3uaE/MH0B3siNVSWUiYrvFjY1De9Tja2StnD+crqy5z5myHgrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359522; c=relaxed/simple;
	bh=Ycr+rkwAX4HS2a1IUZ5HvJX2GWHtvI9ypj8HMGVKfPs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W12DViBqXrGz5kzhSpW0uTjhcAxy9Q/Y2/ZPRt3MxN2mSk/JGJNgv+HpnVRv+QWDKqZX9/tJOyymo/vq9JucIThB8LBo1FFV2vuKQOXMK4kBKCLFXkXQu0khrBPir8ds75kbLk3Nh0gXQ/tQ3aGnV4Nlj6dtQeKE21RxYhvO1d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lxDUUN6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B4EC433F1;
	Mon, 19 Feb 2024 16:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359522;
	bh=Ycr+rkwAX4HS2a1IUZ5HvJX2GWHtvI9ypj8HMGVKfPs=;
	h=Subject:To:Cc:From:Date:From;
	b=lxDUUN6cwLKdse1vMdx7SXjRUu62hSsM90cI+FUQNmXss7aQCStJt7HkxzPCWHGDK
	 KqKI5z51bcxZWXHHW8Q7NICFq9F0/G58P3TJpXqRJ/fGH9UovrZJIVoCNyDD7ALLD6
	 Mu+FzP81zGEw1zDhWF/HpnAYO+cHHfuPdV17Wo/Y=
Subject: FAILED: patch "[PATCH] tracing/probes: Fix to show a parse error for bad type for" failed to apply to 6.1-stable tree
To: mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:18:39 +0100
Message-ID: <2024021939-unproven-observer-095f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8c427cc2fa73684ea140999e121b7b6c1c717632
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021939-unproven-observer-095f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


