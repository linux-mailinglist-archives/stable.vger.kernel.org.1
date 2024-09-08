Return-Path: <stable+bounces-73874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1C397072C
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9E428184F
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248DC1531FA;
	Sun,  8 Sep 2024 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vuYdGtRQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA57414D2B2
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725797318; cv=none; b=GAmqi3cettUT/muuVd9HodIGoR2YSxFgb1sT90slNTm7VadrGe4j+vMm8VkqB4P50AFmooKPD/EgSGRl9kQF5Sc2DvePLF2EZXcI4Mvov4aWCM28R9iMLvhK9WJtoC8+ESGiCrrT4/v8HB02m+57zuXBBh9x3Yfg5N+Vk4pYK5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725797318; c=relaxed/simple;
	bh=2nt7KmZhR0hpza8zulRExa95Mk0Fo4DjUODcuZye3v0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XAdHtZ15weueFZmVSJ5KpwXTu7c9A7CcbqsqBZreC8fNUhnBbEmouwwkQfuZn7H6q/74rGSf5H9ZojQ0AeN8iskeBzJfrEli+yoqK9pVQaP4NQ/3gytYC/lkVJIWoSYt8iKu482eyR7oCgShgQtKgV3KRA/MpzulFy6jS9NKomw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vuYdGtRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B329C4CEC3;
	Sun,  8 Sep 2024 12:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725797317;
	bh=2nt7KmZhR0hpza8zulRExa95Mk0Fo4DjUODcuZye3v0=;
	h=Subject:To:Cc:From:Date:From;
	b=vuYdGtRQCRN9iE/XK7o1Fa0zcBtvxz2AGYEwqhHmGGMzjrO2o6mK3Uw+2+KYxirv4
	 TQbAw2D0RGqv42gK7n0r7800U8lRfLadTy0Lr+EmAm0BA4h61mvOSqzXkaXEYi/Fx3
	 ci48aXfctuJxkd91brLG9m75b64en04Nb2Ou6WAE=
Subject: FAILED: patch "[PATCH] tracing: Avoid possible softlockup in tracing_iter_reset()" failed to apply to 5.4-stable tree
To: zhengyejian@huaweicloud.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 14:08:34 +0200
Message-ID: <2024090834-cheddar-crust-24f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 49aa8a1f4d6800721c7971ed383078257f12e8f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090834-cheddar-crust-24f3@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

49aa8a1f4d68 ("tracing: Avoid possible softlockup in tracing_iter_reset()")
bc1a72afdc4a ("ring-buffer: Rename ring_buffer_read() to read_buffer_iter_advance()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 49aa8a1f4d6800721c7971ed383078257f12e8f9 Mon Sep 17 00:00:00 2001
From: Zheng Yejian <zhengyejian@huaweicloud.com>
Date: Tue, 27 Aug 2024 20:46:54 +0800
Subject: [PATCH] tracing: Avoid possible softlockup in tracing_iter_reset()

In __tracing_open(), when max latency tracers took place on the cpu,
the time start of its buffer would be updated, then event entries with
timestamps being earlier than start of the buffer would be skipped
(see tracing_iter_reset()).

Softlockup will occur if the kernel is non-preemptible and too many
entries were skipped in the loop that reset every cpu buffer, so add
cond_resched() to avoid it.

Cc: stable@vger.kernel.org
Fixes: 2f26ebd549b9a ("tracing: use timestamp to determine start of latency traces")
Link: https://lore.kernel.org/20240827124654.3817443-1-zhengyejian@huaweicloud.com
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ebe7ce2f5f4a..edf6bc817aa1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3958,6 +3958,8 @@ void tracing_iter_reset(struct trace_iterator *iter, int cpu)
 			break;
 		entries++;
 		ring_buffer_iter_advance(buf_iter);
+		/* This could be a big loop */
+		cond_resched();
 	}
 
 	per_cpu_ptr(iter->array_buffer->data, cpu)->skipped_entries = entries;


