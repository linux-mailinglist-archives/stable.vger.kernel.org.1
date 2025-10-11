Return-Path: <stable+bounces-184048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75726BCEF81
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 05:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981783E6E53
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 03:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2871DF985;
	Sat, 11 Oct 2025 03:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDSmyB6s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475E1A76BC;
	Sat, 11 Oct 2025 03:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760154759; cv=none; b=Ki2mxi2yRB+IYS9vef2/jkN3j0oQuHUOLq+9K0djsz0XUyzy4DbfHwjvnC7l70R68B2+qtHEwrYZeJhtMgYtrISVC88MAOjKQPlmm5S1OEHz2IH08nWm0mOuic4p1V/h6FESvqsEm9ts8bzBBuCcGynQXmlzmWL9vHpDE9zoFn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760154759; c=relaxed/simple;
	bh=o8tTvTn6Jw4Ls8asZavAxXg3pyAe0oCWkJfumpXw6eA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=a+YtL6XOXayH5Igz/Yvj8vvdODmBoN3HZIDJltRT9AnyUw45YQtXx+ihCkpex/9/pq3zA26IdYMWjuZbE5OaEtshJqaeJgb9XKnM4DJZlPIxy+9O8QO5IHaOecIOwKOVWNokZU1wTgYCPfwvTiw89Q95dTWLHR5t7+D0DaQ9bkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDSmyB6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8ECC116B1;
	Sat, 11 Oct 2025 03:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760154759;
	bh=o8tTvTn6Jw4Ls8asZavAxXg3pyAe0oCWkJfumpXw6eA=;
	h=Date:From:To:Cc:Subject:References:From;
	b=hDSmyB6sgHvNZAC4SfP1WQ+/wWjLsScSo6ohMi7yYtNtJhxQG5urCfhNuMGlDGGmW
	 LZP9SWeskW3/NQdlyjGPYVfRhwMgD9FCeONQ/DVbdyrUjxKuruArjoS8S9Cg85Ho7/
	 fbry3ADiGBTGg919Ak/CQCXa//D40wFt1ogocaaVnsLSUSpwRYV/sMTrJ+mBVtQyGQ
	 N93mhz2kVP0soOjbdTWq5PUROvADLcAi2HK2wc2RP2wJ0SBWJL07WI3voaJVqVQALl
	 3X+XKmTSpfxXF1z5JbTOHQxPe43v6THFKDM3P5eeEz8xAsX1Do7jc9+w2xGobTKcIQ
	 /ahNv3BPqzoJg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v7Qex-00000000jgG-2EaM;
	Fri, 10 Oct 2025 23:52:43 -0400
Message-ID: <20251011035243.386098147@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 10 Oct 2025 23:51:42 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 syzbot+9a2ede1643175f350105@syzkaller.appspotmail.com
Subject: [PATCH 1/2] tracing: Fix tracing_mark_raw_write() to use buf and not ubuf
References: <20251011035141.552201166@kernel.org>
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



