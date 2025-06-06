Return-Path: <stable+bounces-151725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B38DAD06D6
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 18:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C0C37A79ED
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DDB28A1D3;
	Fri,  6 Jun 2025 16:42:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3557428A1C3;
	Fri,  6 Jun 2025 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749228152; cv=none; b=PBYE+EuiQKoLmm5+qEmGKaV9uH3mfprvnOTcm5Kt9n9+m7Km+fZqCPmh2BwyW5il2QKA+M+kcwLfRDM2quDye7T5G3rBEN2eECdr1BRm38K1cTiD0dcbw8L7w5w98k92aLAq1XB9nUKvxF2CVDV0vZgxds933fZwwX0Ot4H8ydo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749228152; c=relaxed/simple;
	bh=bup0VwhlRIh0zyMHrfXhnPPznLi8Kh/TsT1pQRvseL0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sI2TMz8RxenVYad/UX+2Wok7WYCktsoZdlDiw3G/Nnq3OjNGZ3TOO6+vvygwbUjfLCjGCgLTL3yd53TwfnztjRe2GQO2L84awZ18sXLcIcy44CchssPnSxE4cFNEGQHqxeF1/vG6sKX0MaQjnsZnNmHu9bdDhCYsQYIDa93DoU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEF3C4CEF6;
	Fri,  6 Jun 2025 16:42:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uNaAb-0000000FxAu-2a8Y;
	Fri, 06 Jun 2025 12:43:53 -0400
Message-ID: <20250606164353.472136191@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 06 Jun 2025 12:42:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 syzbot+05d673e83ec640f0ced9@syzkaller.appspotmail.com,
 Dmitry Antipov <dmantipov@yandex.ru>
Subject: [for-linus][PATCH 2/3] ring-buffer: Fix buffer locking in ring_buffer_subbuf_order_set()
References: <20250606164229.056794577@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Dmitry Antipov <dmantipov@yandex.ru>

Enlarge the critical section in ring_buffer_subbuf_order_set() to
ensure that error handling takes place with per-buffer mutex held,
thus preventing list corruption and other concurrency-related issues.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Link: https://lore.kernel.org/20250606112242.1510605-1-dmantipov@yandex.ru
Reported-by: syzbot+05d673e83ec640f0ced9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=05d673e83ec640f0ced9
Fixes: f9b94daa542a8 ("ring-buffer: Set new size of the ring buffer sub page")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e24509bd0af5..00fc38d70e86 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6795,7 +6795,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	old_size = buffer->subbuf_size;
 
 	/* prevent another thread from changing buffer sizes */
-	mutex_lock(&buffer->mutex);
+	guard(mutex)(&buffer->mutex);
 	atomic_inc(&buffer->record_disabled);
 
 	/* Make sure all commits have finished */
@@ -6900,7 +6900,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	}
 
 	atomic_dec(&buffer->record_disabled);
-	mutex_unlock(&buffer->mutex);
 
 	return 0;
 
@@ -6909,7 +6908,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	buffer->subbuf_size = old_size;
 
 	atomic_dec(&buffer->record_disabled);
-	mutex_unlock(&buffer->mutex);
 
 	for_each_buffer_cpu(buffer, cpu) {
 		cpu_buffer = buffer->buffers[cpu];
-- 
2.47.2



