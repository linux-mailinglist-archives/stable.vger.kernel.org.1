Return-Path: <stable+bounces-9589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE516823306
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FEB51C20FF8
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4461A1C28C;
	Wed,  3 Jan 2024 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l3LCEwME"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE6F1C280;
	Wed,  3 Jan 2024 17:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60657C433C8;
	Wed,  3 Jan 2024 17:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704302095;
	bh=LO2WLCB6Ob1tNWe8Px25QEOq1x8j23wyUOdmgO+Tj9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l3LCEwMEOHr566M5G7NohJRzEiNQQSp/k/pkC+jS+dHMX8z+LVFkTY7Bln98Ek8BE
	 YqzekHSCIxYCM+NmGb/GM59Gk1BVt8A0QoYMuLeIkfWc8jK00wjF7VW6FtCelndoG5
	 QKXjomxUt4e40bhLpyD2w3vcpCiHUgvv7WQz+VrU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.6 44/49] ring-buffer: Fix wake ups when buffer_percent is set to 100
Date: Wed,  3 Jan 2024 17:56:04 +0100
Message-ID: <20240103164841.820004514@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164834.970234661@linuxfoundation.org>
References: <20240103164834.970234661@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit 623b1f896fa8a669a277ee5a258307a16c7377a3 upstream.

The tracefs file "buffer_percent" is to allow user space to set a
water-mark on how much of the tracing ring buffer needs to be filled in
order to wake up a blocked reader.

 0 - is to wait until any data is in the buffer
 1 - is to wait for 1% of the sub buffers to be filled
 50 - would be half of the sub buffers are filled with data
 100 - is not to wake the waiter until the ring buffer is completely full

Unfortunately the test for being full was:

	dirty = ring_buffer_nr_dirty_pages(buffer, cpu);
	return (dirty * 100) > (full * nr_pages);

Where "full" is the value for "buffer_percent".

There is two issues with the above when full == 100.

1. dirty * 100 > 100 * nr_pages will never be true
   That is, the above is basically saying that if the user sets
   buffer_percent to 100, more pages need to be dirty than exist in the
   ring buffer!

2. The page that the writer is on is never considered dirty, as dirty
   pages are only those that are full. When the writer goes to a new
   sub-buffer, it clears the contents of that sub-buffer.

That is, even if the check was ">=" it would still not be equal as the
most pages that can be considered "dirty" is nr_pages - 1.

To fix this, add one to dirty and use ">=" in the compare.

Link: https://lore.kernel.org/linux-trace-kernel/20231226125902.4a057f1d@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: 03329f9939781 ("tracing: Add tracefs file buffer_percentage")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ring_buffer.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -881,9 +881,14 @@ static __always_inline bool full_hit(str
 	if (!nr_pages || !full)
 		return true;
 
-	dirty = ring_buffer_nr_dirty_pages(buffer, cpu);
+	/*
+	 * Add one as dirty will never equal nr_pages, as the sub-buffer
+	 * that the writer is on is not counted as dirty.
+	 * This is needed if "buffer_percent" is set to 100.
+	 */
+	dirty = ring_buffer_nr_dirty_pages(buffer, cpu) + 1;
 
-	return (dirty * 100) > (full * nr_pages);
+	return (dirty * 100) >= (full * nr_pages);
 }
 
 /*



