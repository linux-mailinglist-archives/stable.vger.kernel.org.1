Return-Path: <stable+bounces-134647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301DDA93CD8
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 20:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5DBF7ADD64
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 18:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF13227B95;
	Fri, 18 Apr 2025 18:33:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512C8226CFC;
	Fri, 18 Apr 2025 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745001227; cv=none; b=QwR5KN/abgqQpnxdFjEhAVuUgWPk8lTJWiK5LlC7Nxy/ZF2pLTrH6h2I475VNQUUd9Vlth1r8X8+S3DmBEg77kGBxc4blvm5tTfnDy7O9HTEZnueWr9m/zzZdzpXZdjaRVNH8u9h7VRrWAvb/DwO7+sDhMfeajzd2J6CU1spiQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745001227; c=relaxed/simple;
	bh=mAHbmri/ydJCCCNyZ8TtbhRs/REQDtNLw4Sz7n+2K7k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Ju3kEU0UkIHv9mcx3leeUdcltyiceYPdPkjrRQW1rIBSWS0F4D/zGSRjiG55Ga55ob2FypQBPu5wqleJXnY9xilfXixAYpzYI3L08WXoWv7/m4hnrc9IOV+NBV4jwL5Yray0TKyJTGarpNTAFpKxzWKmKEoyEzOKQps/GvLQKmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BFCC4CEEF;
	Fri, 18 Apr 2025 18:33:47 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u5qYj-0000000Db9e-0agq;
	Fri, 18 Apr 2025 14:35:29 -0400
Message-ID: <20250418183528.990167813@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 18 Apr 2025 14:34:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [for-linus][PATCH 6/7] tracing: Fix filter string testing
References: <20250418183446.383784216@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The filter string testing uses strncpy_from_kernel/user_nofault() to
retrieve the string to test the filter against. The if() statement was
incorrect as it considered 0 as a fault, when it is only negative that it
faulted.

Running the following commands:

  # cd /sys/kernel/tracing
  # echo "filename.ustring ~ \"/proc*\"" > events/syscalls/sys_enter_openat/filter
  # echo 1 > events/syscalls/sys_enter_openat/enable
  # ls /proc/$$/maps
  # cat trace

Would produce nothing, but with the fix it will produce something like:

      ls-1192    [007] .....  8169.828333: sys_openat(dfd: ffffffffffffff9c, filename: 7efc18359904, flags: 80000, mode: 0)

Link: https://lore.kernel.org/all/CAEf4BzbVPQ=BjWztmEwBPRKHUwNfKBkS3kce-Rzka6zvbQeVpg@mail.gmail.com/

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/20250417183003.505835fb@gandalf.local.home
Fixes: 77360f9bbc7e5 ("tracing: Add test for user space strings when filtering on string pointers")
Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Reported-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 0993dfc1c5c1..2048560264bb 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -808,7 +808,7 @@ static __always_inline char *test_string(char *str)
 	kstr = ubuf->buffer;
 
 	/* For safety, do not trust the string pointer */
-	if (!strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE))
+	if (strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE) < 0)
 		return NULL;
 	return kstr;
 }
@@ -827,7 +827,7 @@ static __always_inline char *test_ustring(char *str)
 
 	/* user space address? */
 	ustr = (char __user *)str;
-	if (!strncpy_from_user_nofault(kstr, ustr, USTRING_BUF_SIZE))
+	if (strncpy_from_user_nofault(kstr, ustr, USTRING_BUF_SIZE) < 0)
 		return NULL;
 
 	return kstr;
-- 
2.47.2



