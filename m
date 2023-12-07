Return-Path: <stable+bounces-4900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5363D807EA4
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 03:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1470B21164
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 02:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8462E1C38;
	Thu,  7 Dec 2023 02:37:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7461C2E
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 02:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACC2C433C9;
	Thu,  7 Dec 2023 02:37:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rB4HN-00000001aQB-03PE;
	Wed, 06 Dec 2023 21:38:21 -0500
Message-ID: <20231207023820.797727180@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 06 Dec 2023 21:38:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 8/8] ring-buffer: Test last update in 32bit version of __rb_time_read()
References: <20231207023752.712829638@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Since 64 bit cmpxchg() is very expensive on 32bit architectures, the
timestamp used by the ring buffer does some interesting tricks to be able
to still have an atomic 64 bit number. It originally just used 60 bits and
broke it up into two 32 bit words where the extra 2 bits were used for
synchronization. But this was not enough for all use cases, and all 64
bits were required.

The 32bit version of the ring buffer timestamp was then broken up into 3
32bit words using the same counter trick. But one update was not done. The
check to see if the read operation was done without interruption only
checked the first two words and not last one (like it had before this
update). Fix it by making sure all three updates happen without
interruption by comparing the initial counter with the last updated
counter.

Link: https://lore.kernel.org/linux-trace-kernel/20231206100050.3100b7bb@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: f03f2abce4f39 ("ring-buffer: Have 32 bit time stamps use all 64 bits")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a6da2d765c78..8d2a4f00eca9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -644,8 +644,8 @@ static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
 
 	*cnt = rb_time_cnt(top);
 
-	/* If top and bottom counts don't match, this interrupted a write */
-	if (*cnt != rb_time_cnt(bottom))
+	/* If top and msb counts don't match, this interrupted a write */
+	if (*cnt != rb_time_cnt(msb))
 		return false;
 
 	/* The shift to msb will lose its cnt bits */
-- 
2.42.0



