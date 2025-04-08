Return-Path: <stable+bounces-128888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E139A7FB0B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91AB8441827
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02A826773B;
	Tue,  8 Apr 2025 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Av5kb6we"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8F2676DE
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106544; cv=none; b=Ur+IsJKdyO0c7iZa04cHiq4jHvPuAl434gOx6r/jvUBpntaI6dfx2qw6S4nXwAup33cfPCiuVPvBzFfP2Wt1vwEdDawgn0e4hWFdcXGZ0R29AVvIEZ4K9elyGxpqFxu2uhVPPXS4ndWCDjHRYMXKlSAzr8uthOJTR+rN+ixnezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106544; c=relaxed/simple;
	bh=3DhSOt6JI+TQ8e5goIE/PeKACD/632xpmo45Yol3hJg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G4BbWjBXel5Y8Nb7fcCLnzATPZfcWmd630YFssesQAvralmDmUrN8XEyCMETkM/5GNqbDV/Au3zucOMte38XOINF/uB2G+X84xF4oVq6AhJafsahX7tHApJHyhLBn0EVRTP3v3ENxmf221iW2IHvm99AZrR7BrjT7E+nlDtkuRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Av5kb6we; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18B3C4CEE8;
	Tue,  8 Apr 2025 10:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744106544;
	bh=3DhSOt6JI+TQ8e5goIE/PeKACD/632xpmo45Yol3hJg=;
	h=Subject:To:Cc:From:Date:From;
	b=Av5kb6wekMcDcmg+T26B4fbClyB3bYZ7mJDyRNo22CWA/Y/jp7h0lys1/7lYk1IKR
	 Syok9eOpoHcMeoA6rVA0k+H0pVsLAra/Gu7n7HZpWW8XXGxZ+pm3y6wOyGnkURfUkA
	 jJ1wmsA5hISI/Cx7ye2/E2Ux1/mN6YQGvf+yveE4=
Subject: FAILED: patch "[PATCH] tracing: Fix synth event printk format for str fields" failed to apply to 5.10-stable tree
To: douglas.raillard@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 12:00:51 +0200
Message-ID: <2025040851-snowstorm-anyhow-9887@gregkh>
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
git cherry-pick -x 4d38328eb442dc06aec4350fd9594ffa6488af02
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040851-snowstorm-anyhow-9887@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4d38328eb442dc06aec4350fd9594ffa6488af02 Mon Sep 17 00:00:00 2001
From: Douglas Raillard <douglas.raillard@arm.com>
Date: Tue, 25 Mar 2025 16:52:02 +0000
Subject: [PATCH] tracing: Fix synth event printk format for str fields

The printk format for synth event uses "%.*s" to print string fields,
but then only passes the pointer part as var arg.

Replace %.*s with %s as the C string is guaranteed to be null-terminated.

The output in print fmt should never have been updated as __get_str()
handles the string limit because it can access the length of the string in
the string meta data that is saved in the ring buffer.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 8db4d6bfbbf92 ("tracing: Change synthetic event string format to limit printed length")
Link: https://lore.kernel.org/20250325165202.541088-1-douglas.raillard@arm.com
Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index a5c5f34c207a..6d592cbc38e4 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -305,7 +305,7 @@ static const char *synth_field_fmt(char *type)
 	else if (strcmp(type, "gfp_t") == 0)
 		fmt = "%x";
 	else if (synth_field_is_string(type))
-		fmt = "%.*s";
+		fmt = "%s";
 	else if (synth_field_is_stack(type))
 		fmt = "%s";
 


