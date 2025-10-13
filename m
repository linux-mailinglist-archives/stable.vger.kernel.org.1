Return-Path: <stable+bounces-184181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A76BD21B6
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 10:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226A23C21A1
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 08:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEFA2FABFB;
	Mon, 13 Oct 2025 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uDFJNVwB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2062FABF8
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760344526; cv=none; b=esXsrjTVl7FgfRRHmpxO6hUhbpoMkM4XgC2InXwkJgxDxMwCCHorkb9rz1hiaH5OEZX4XEyJVhFLeWrXQmim/WV1Y2nEmn85ClKjO5yeDAnFhVx7I4fjP4wLFBKr1RwJjsAvKNWwPgiahUXstzFdfqTrUYlMXUnwbT94c0X63B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760344526; c=relaxed/simple;
	bh=CoRWLAQlNo1N3t8LfkNmepwg/UGy6bzlhvKdD1FwZ9g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=it/d4+H/lcyQDGZgJn6Zx5KwKBnV0TsUfYhKmQRnFluMB3Vjg8iR2LpsdELG4MhPjJplnbCNvPcHVtiwVdofwPQRNEFuWfuIrF7Zc94lQ+DyET/PoAtYkEpkskI4NE1J+UOAvAZf4urUQM3IcHcOGfp0B0mXy7scIdG4HBIW1C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uDFJNVwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8BCC4CEE7;
	Mon, 13 Oct 2025 08:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760344526;
	bh=CoRWLAQlNo1N3t8LfkNmepwg/UGy6bzlhvKdD1FwZ9g=;
	h=Subject:To:Cc:From:Date:From;
	b=uDFJNVwBvYhvqxJ3letGZin2PnX0fAubPcgyctyJCggW9dEJT4PZZuEsU2teef5C3
	 jBVtlEEYMdCW3jjub6B5nm+HVhcw3KS+xhav0/sZE+xv/Jr9OXDGWWS5l3fX8bINyG
	 oKFOjmeWrUZWAaktD2DQ0iIJZqwQ1+pSvpYIZtNI=
Subject: FAILED: patch "[PATCH] tracing: Fix tracing_mark_raw_write() to use buf and not ubuf" failed to apply to 5.15-stable tree
To: rostedt@goodmis.org,akpm@linux-foundation.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 10:35:12 +0200
Message-ID: <2025101312-duplex-shimmer-a161@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x bda745ee8fbb63330d8f2f2ea4157229a5df959e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101312-duplex-shimmer-a161@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bda745ee8fbb63330d8f2f2ea4157229a5df959e Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Fri, 10 Oct 2025 23:51:42 -0400
Subject: [PATCH] tracing: Fix tracing_mark_raw_write() to use buf and not ubuf

The fix to use a per CPU buffer to read user space tested only the writes
to trace_marker. But it appears that the selftests are missing tests to
the trace_maker_raw file. The trace_maker_raw file is used by applications
that writes data structures and not strings into the file, and the tools
read the raw ring buffer to process the structures it writes.

The fix that reads the per CPU buffers passes the new per CPU buffer to
the trace_marker file writes, but the update to the trace_marker_raw write
read the data from user space into the per CPU buffer, but then still used
then passed the user space address to the function that records the data.

Pass in the per CPU buffer and not the user space address.

TODO: Add a test to better test trace_marker_raw.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/20251011035243.386098147@kernel.org
Fixes: 64cf7d058a00 ("tracing: Have trace_marker use per-cpu data to read user space")
Reported-by: syzbot+9a2ede1643175f350105@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68e973f5.050a0220.1186a4.0010.GAE@google.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0fd582651293..bbb89206a891 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7497,12 +7497,12 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	if (tr == &global_trace) {
 		guard(rcu)();
 		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
-			written = write_raw_marker_to_buffer(tr, ubuf, cnt);
+			written = write_raw_marker_to_buffer(tr, buf, cnt);
 			if (written < 0)
 				break;
 		}
 	} else {
-		written = write_raw_marker_to_buffer(tr, ubuf, cnt);
+		written = write_raw_marker_to_buffer(tr, buf, cnt);
 	}
 
 	return written;


