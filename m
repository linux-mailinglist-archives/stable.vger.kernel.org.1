Return-Path: <stable+bounces-184179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADF0BD2163
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 10:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A9394EEDDE
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 08:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529422F3C3B;
	Mon, 13 Oct 2025 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="izFI+AnO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104C92F8BF7
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760344520; cv=none; b=kkAyE2N0ZEEGX9xN7gH4xpQ8oPKL04PqoiUAebYZ198uovU28C4WVjUCgFXAReDL/2b3KEWmVvKH0Ka07dgOyxo5+p97ni0ICsGQR27PF30r/dERI/dJNa65/BYpp0/dAWmk/E5oGL1oKX7Scswt2kdArLHFEP7DV4jWi15MOGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760344520; c=relaxed/simple;
	bh=AoGaMcYwmzLrnUx/NcpQpgGps24LIjpZNIxvzJVeybI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Pu3ZEYKoURFgxjUOuJ6vi44BqOJ3oPIzjZ7ikISiEea1wNoTAZflIOV3URo+7qqbjyWx90CvqHVJ0IpzdSqVyj41uS6LdywK3bt+YHf6NRdJhMqo1NXFiAkR+T1HEwVeaA+F4EkQE3re/EYmFYRuv3VlSSFFMjXOeXjPBr6kYok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=izFI+AnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E924C4CEE7;
	Mon, 13 Oct 2025 08:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760344519;
	bh=AoGaMcYwmzLrnUx/NcpQpgGps24LIjpZNIxvzJVeybI=;
	h=Subject:To:Cc:From:Date:From;
	b=izFI+AnOOcU0DGTiSf9wDWFuwmLdXohG2ZWAnPDlEDHflAznFX/Dul2i7tLWemaDM
	 kzbip32n3Yh+jQgTWcuJ93XCLcKw6HhyCO72vprpbScYEfu9wWs2CMHhyi5D4Vwdhq
	 rhOtMAttr8ygSugiJnTdqLIUAEfPGYXJIIopSXRA=
Subject: FAILED: patch "[PATCH] tracing: Fix tracing_mark_raw_write() to use buf and not ubuf" failed to apply to 6.6-stable tree
To: rostedt@goodmis.org,akpm@linux-foundation.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 10:35:10 +0200
Message-ID: <2025101310-shrapnel-prune-60b1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x bda745ee8fbb63330d8f2f2ea4157229a5df959e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101310-shrapnel-prune-60b1@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


