Return-Path: <stable+bounces-7251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE1881719E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87134B216AE
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0407200A0;
	Mon, 18 Dec 2023 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j2PJ95uS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C391D13A;
	Mon, 18 Dec 2023 13:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2E7C433C8;
	Mon, 18 Dec 2023 13:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907964;
	bh=NgIOGYmcULwxmCpLCYpndBc6zRp0or7xjCTClGwkdaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j2PJ95uSfGJT/nxEEf1/+rxNoST3guohwUo/FLPE45TDoNzecee2e4qEj86X9JWgx
	 44H5uOmBnRUNzARfcXyUomzs3J2zrjiSxtNYvkhSMrTL63TV0L3LtLojIRhjY5PdzR
	 ugUWFKK9zOy2M75wSsk7Kqnr2AuxVV1LWHei+Hqw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.1 098/106] ring-buffer: Have saved event hold the entire event
Date: Mon, 18 Dec 2023 14:51:52 +0100
Message-ID: <20231218135059.250473915@linuxfoundation.org>
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

commit b049525855fdd0024881c9b14b8fbec61c3f53d3 upstream.

For the ring buffer iterator (non-consuming read), the event needs to be
copied into the iterator buffer to make sure that a writer does not
overwrite it while the user is reading it. If a write happens during the
copy, the buffer is simply discarded.

But the temp buffer itself was not big enough. The allocation of the
buffer was only BUF_MAX_DATA_SIZE, which is the maximum data size that can
be passed into the ring buffer and saved. But the temp buffer needs to
hold the meta data as well. That would be BUF_PAGE_SIZE and not
BUF_MAX_DATA_SIZE.

Link: https://lore.kernel.org/linux-trace-kernel/20231212072558.61f76493@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 785888c544e04 ("ring-buffer: Have rb_iter_head_event() handle concurrent writer")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ring_buffer.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2403,7 +2403,7 @@ rb_iter_head_event(struct ring_buffer_it
 	 */
 	barrier();
 
-	if ((iter->head + length) > commit || length > BUF_MAX_DATA_SIZE)
+	if ((iter->head + length) > commit || length > BUF_PAGE_SIZE)
 		/* Writer corrupted the read? */
 		goto reset;
 
@@ -5113,7 +5113,8 @@ ring_buffer_read_prepare(struct trace_bu
 	if (!iter)
 		return NULL;
 
-	iter->event = kmalloc(BUF_MAX_DATA_SIZE, flags);
+	/* Holds the entire event: data and meta data */
+	iter->event = kmalloc(BUF_PAGE_SIZE, flags);
 	if (!iter->event) {
 		kfree(iter);
 		return NULL;



