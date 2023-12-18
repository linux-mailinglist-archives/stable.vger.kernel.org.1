Return-Path: <stable+bounces-7250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A316A81719B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43BB51F25483
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8361D14B;
	Mon, 18 Dec 2023 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HZl0ImaV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68951D13A;
	Mon, 18 Dec 2023 13:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCC0C433C7;
	Mon, 18 Dec 2023 13:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907961;
	bh=bMcqL8Ojjr4fbUvEFNn5c1lzgEBjqyXKg41KlUAnQu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZl0ImaVFgOIViI0gFFyCDIiVrroOALJHxhUXgwbHydUt2eqVwLAJIDrDU7drn8vb
	 XJRArsGrcNXFJo56JEsgPyaQP/+mdqthxu5Rzp7cv3cOYEww0ZJ26Np1Bek++bjm5n
	 CsbDoz/f5c4qAxFy0feGAzMkVqu/EZn9TD12U3OU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.1 097/106] ring-buffer: Do not update before stamp when switching sub-buffers
Date: Mon, 18 Dec 2023 14:51:51 +0100
Message-ID: <20231218135059.199953469@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit 9e45e39dc249c970d99d2681f6bcb55736fd725c upstream.

The ring buffer timestamps are synchronized by two timestamp placeholders.
One is the "before_stamp" and the other is the "write_stamp" (sometimes
referred to as the "after stamp" but only in the comments. These two
stamps are key to knowing how to handle nested events coming in with a
lockless system.

When moving across sub-buffers, the before stamp is updated but the write
stamp is not. There's an effort to put back the before stamp to something
that seems logical in case there's nested events. But as the current event
is about to cross sub-buffers, and so will any new nested event that happens,
updating the before stamp is useless, and could even introduce new race
conditions.

The first event on a sub-buffer simply uses the sub-buffer's timestamp
and keeps a "delta" of zero. The "before_stamp" and "write_stamp" are not
used in the algorithm in this case. There's no reason to try to fix the
before_stamp when this happens.

As a bonus, it removes a cmpxchg() when crossing sub-buffers!

Link: https://lore.kernel.org/linux-trace-kernel/20231211114420.36dde01b@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: a389d86f7fd09 ("ring-buffer: Have nested events still record running time stamp")
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ring_buffer.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3601,14 +3601,7 @@ __rb_reserve_next(struct ring_buffer_per
 
 	/* See if we shot pass the end of this buffer page */
 	if (unlikely(write > BUF_PAGE_SIZE)) {
-		/* before and after may now different, fix it up*/
-		b_ok = rb_time_read(&cpu_buffer->before_stamp, &info->before);
-		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
-		if (a_ok && b_ok && info->before != info->after)
-			(void)rb_time_cmpxchg(&cpu_buffer->before_stamp,
-					      info->before, info->after);
-		if (a_ok && b_ok)
-			check_buffer(cpu_buffer, info, CHECK_FULL_PAGE);
+		check_buffer(cpu_buffer, info, CHECK_FULL_PAGE);
 		return rb_move_tail(cpu_buffer, tail, info);
 	}
 



