Return-Path: <stable+bounces-184044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 967E1BCEF66
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 05:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B2919A3EB9
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 03:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B2A1A76BC;
	Sat, 11 Oct 2025 03:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nu3YoxKx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F973D6F;
	Sat, 11 Oct 2025 03:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760154427; cv=none; b=XAP6tXWhiwuuCJXz20agxMlvsbp5LdKFtWUo09X1YY5gRMX07ExEYppFkpxzmOtuJnFGZDZUwv9xfdlEEcNSzlkuVVY4zW3I6U5bgA5Ug8YeypCyKlqWGPSmpmSTDGUx/e90tyCSGViUqESXDn+zkKOVH9HXwKV8EPIxDvpUPdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760154427; c=relaxed/simple;
	bh=o8tTvTn6Jw4Ls8asZavAxXg3pyAe0oCWkJfumpXw6eA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DW3COHmPC3wFr7ppEx5TNg7mFgM0njC9W48VJyBOsgW1BNff49nURBccJJEQQEiUr04ORSSKyE26OBU/1DH6oYKTlr3Q8DjJnMP/G0Ufs9Kf/5+VW07B/pcTLYyHNhkzbRZegm2kV1YV2T9ZM87WPn1ECIs4mL+KnBkB7+VKpDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nu3YoxKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01D4C4CEF5;
	Sat, 11 Oct 2025 03:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760154426;
	bh=o8tTvTn6Jw4Ls8asZavAxXg3pyAe0oCWkJfumpXw6eA=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Nu3YoxKxJicl6mi7OPnjypBWskbqy7bbCSb55Fq+7SkSgP2udo7T4tp46NiqwcnQu
	 2kn8TQIPx0qs0jTe7TNZEIK6Dsw9Ea2klQ00Kdv3rnLXviYZsti5SZ6K8vXPLWiEU/
	 txbNE4MQ8InvqYdsw0oKZ36HnNIzifXmpMshBLHQ7cQFd41dMFAVFxLUSHWHwO8Mjt
	 v3QC1JOQPRH7J9yArOeeOR55/NFYLO0B41xc6mqLmkzFqc68EBV8ETZ7947Jk+Z2NU
	 S/Qm7ud4aY5LazuDd0Ktysn3qqQvDHu+Z2uq5VpAYcz2FdELEw2oH30WB5mjlE0hEp
	 x+4G0vA7qdXog==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v7QZa-00000000jYx-3qBK;
	Fri, 10 Oct 2025 23:47:10 -0400
Message-ID: <20251011034710.768448162@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 10 Oct 2025 23:46:34 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 syzbot+9a2ede1643175f350105@syzkaller.appspotmail.com
Subject: [for-linus][PATCH 1/2] tracing: Fix tracing_mark_raw_write() to use buf and not ubuf
References: <20251011034633.619611825@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

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
Fixes: 64cf7d058a00 ("tracing: Have trace_marker use per-cpu data to read user space")
Reported-by: syzbot+9a2ede1643175f350105@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68e973f5.050a0220.1186a4.0010.GAE@google.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.51.0



