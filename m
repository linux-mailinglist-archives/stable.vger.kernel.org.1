Return-Path: <stable+bounces-184086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE17BCFC3B
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 21:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1188F4EA3A0
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 19:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F841284B29;
	Sat, 11 Oct 2025 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwTakpWi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E128469A;
	Sat, 11 Oct 2025 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760211778; cv=none; b=ArU7hu9umkm3FYqBlmHH7+JnIexWtWQU8deCUH7UoZQ+UO+PSR6Kjzzw6h0Zoj1J420VlzXCVclEoCrw3/5Vbu5y3Ym2keX6wDjMCzTrC+AoMLiAn48cI+UnZTFUunKa5LJ/MFduJaQwp3HbgTIAycGYPfA/fzOBrHi90N1Rotk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760211778; c=relaxed/simple;
	bh=M10GgFzKdMK0LcE4RW+C+kpgKRygFalui4rnGO9A/F0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NiuPSmNaXAzyT0Sp+/xcSnFlS0LpR/LfMHWETlMCDWym+o+y/efSIX8ED4B7qSKyxMYbpRUkAhoyOhovx1ICkIV4+ppj+T5tsSnip7nfZtxAF/0luKpJ+KO9yPSkJcAmzZMJqhuOX6wE6bIuw1TejfrZZexC/LZdYAxNfnhH8AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwTakpWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFDDC116B1;
	Sat, 11 Oct 2025 19:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760211777;
	bh=M10GgFzKdMK0LcE4RW+C+kpgKRygFalui4rnGO9A/F0=;
	h=Date:From:To:Cc:Subject:References:From;
	b=mwTakpWipOklIgbBifB30hI+WIDdLQslS5HqNVmRsgtIxMOLDXYqQOAeHXTe/2v5M
	 vh+6pxtHVo3mGnhdwmKIgz1gGLJiJeYNAOIOAKpi1EOPBEdgSVcVJ2sN+iUG4peGEH
	 S3r+3J7RQ76RkP/fMRsE7LobPWiEZzm4VNUnL4q8S6FC0fUUzaN3hxdXFZTPsjRMZg
	 BG/XdxQH8x8WuEvsSfziY+KyUDheNud7oqiQxTOnYdzVcC+e9gX6UOCvzVXfFN5PpE
	 J9gecC4EF04Gta2SY72YfpbHK2+MxhsrNSxDowo3BH6wBmNXYBN7HrhvSxXW/m5AE3
	 5zQclM9x9WL9w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v7fUX-0000000021u-1LeB;
	Sat, 11 Oct 2025 15:42:57 -0400
Message-ID: <20251011194257.174203652@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 11 Oct 2025 15:42:37 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 syzbot+9a2ede1643175f350105@syzkaller.appspotmail.com
Subject: [for-linus][PATCH v2 1/2] tracing: Fix tracing_mark_raw_write() to use buf and not ubuf
References: <20251011194236.326710166@kernel.org>
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
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/20251011035243.386098147@kernel.org
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



