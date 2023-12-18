Return-Path: <stable+bounces-7474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BF38172B2
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6667A1F23BAA
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C5642389;
	Mon, 18 Dec 2023 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r67LJCH9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6FB3786D;
	Mon, 18 Dec 2023 14:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC47C433C8;
	Mon, 18 Dec 2023 14:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908563;
	bh=sX8ZqyHQwCZ0sbOS2WCx0FBbSM2RYH67uHbohwuUmRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r67LJCH9OyKbYtmU4i+zWr4KO+l8B/NH84ZMNZIy/s4r6dPOuVqprJSdi1t4+787F
	 8cxDTf+zQ7qMzebfPpKN/20DklqIoYqACsW8M6vYCfsZEWghHaeWvl1PekDuuCSSaB
	 fG15cUU0PIKSSnmNQJHzoq9OvZ1C4DSjnEWbsiqg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 5.10 56/62] ring-buffer: Fix a race in rb_time_cmpxchg() for 32 bit archs
Date: Mon, 18 Dec 2023 14:52:20 +0100
Message-ID: <20231218135048.703406757@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135046.178317233@linuxfoundation.org>
References: <20231218135046.178317233@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit fff88fa0fbc7067ba46dde570912d63da42c59a9 upstream.

Mathieu Desnoyers pointed out an issue in the rb_time_cmpxchg() for 32 bit
architectures. That is:

 static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 {
	unsigned long cnt, top, bottom, msb;
	unsigned long cnt2, top2, bottom2, msb2;
	u64 val;

	/* The cmpxchg always fails if it interrupted an update */
	 if (!__rb_time_read(t, &val, &cnt2))
		 return false;

	 if (val != expect)
		 return false;

<<<< interrupted here!

	 cnt = local_read(&t->cnt);

The problem is that the synchronization counter in the rb_time_t is read
*after* the value of the timestamp is read. That means if an interrupt
were to come in between the value being read and the counter being read,
it can change the value and the counter and the interrupted process would
be clueless about it!

The counter needs to be read first and then the value. That way it is easy
to tell if the value is stale or not. If the counter hasn't been updated,
then the value is still good.

Link: https://lore.kernel.org/linux-trace-kernel/20231211201324.652870-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/linux-trace-kernel/20231212115301.7a9c9a64@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Fixes: 10464b4aa605e ("ring-buffer: Add rb_time_t 64 bit operations for speeding up 32 bit")
Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ring_buffer.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -703,6 +703,9 @@ static int rb_time_cmpxchg(rb_time_t *t,
 	unsigned long cnt2, top2, bottom2;
 	u64 val;
 
+	/* Any interruptions in this function should cause a failure */
+	cnt = local_read(&t->cnt);
+
 	/* The cmpxchg always fails if it interrupted an update */
 	 if (!__rb_time_read(t, &val, &cnt2))
 		 return false;
@@ -710,7 +713,6 @@ static int rb_time_cmpxchg(rb_time_t *t,
 	 if (val != expect)
 		 return false;
 
-	 cnt = local_read(&t->cnt);
 	 if ((cnt & 3) != cnt2)
 		 return false;
 



