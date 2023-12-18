Return-Path: <stable+bounces-7248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 381CF817199
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60D0281D08
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ED7129ED2;
	Mon, 18 Dec 2023 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yB6BMQaG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A241D13A;
	Mon, 18 Dec 2023 13:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE20C433C7;
	Mon, 18 Dec 2023 13:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907956;
	bh=q3kuaPaQZYRAljsNon/8YoYGPo2EC/pFDsSIzWTrerI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yB6BMQaGpl/0Zetz7wZ4mInhxzWBbagLhxSMr1JjdhcbE9eao+C29L9G8h1xUS1+V
	 o+G1biZDgC7vo2SubuKRBzsygoLpcyOzs91oVIKIVVSNPCdQQczbbARtj67RNtEXVS
	 M2gfbRI753ndFjIg6tSir18nJAN+Py13brbmKTWw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.1 095/106] ring-buffer: Fix memory leak of free page
Date: Mon, 18 Dec 2023 14:51:49 +0100
Message-ID: <20231218135059.125116635@linuxfoundation.org>
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

commit 17d801758157bec93f26faaf5ff1a8b9a552d67a upstream.

Reading the ring buffer does a swap of a sub-buffer within the ring buffer
with a empty sub-buffer. This allows the reader to have full access to the
content of the sub-buffer that was swapped out without having to worry
about contention with the writer.

The readers call ring_buffer_alloc_read_page() to allocate a page that
will be used to swap with the ring buffer. When the code is finished with
the reader page, it calls ring_buffer_free_read_page(). Instead of freeing
the page, it stores it as a spare. Then next call to
ring_buffer_alloc_read_page() will return this spare instead of calling
into the memory management system to allocate a new page.

Unfortunately, on freeing of the ring buffer, this spare page is not
freed, and causes a memory leak.

Link: https://lore.kernel.org/linux-trace-kernel/20231210221250.7b9cc83c@rorschach.local.home

Cc: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 73a757e63114d ("ring-buffer: Return reader page back into existing ring buffer")
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ring_buffer.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1801,6 +1801,8 @@ static void rb_free_cpu_buffer(struct ri
 		free_buffer_page(bpage);
 	}
 
+	free_page((unsigned long)cpu_buffer->free_page);
+
 	kfree(cpu_buffer);
 }
 



