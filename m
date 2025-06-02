Return-Path: <stable+bounces-149906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08677ACB4A9
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842B17B15D9
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4C2221F12;
	Mon,  2 Jun 2025 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WVucjeGH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266B11FF61E;
	Mon,  2 Jun 2025 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875416; cv=none; b=gUMYkZlgXGs2yhcMT7adZ5yhS8YE5HaxF3Z0PVeCn/IvfZ3we6mKYcLqhQ05QHruQTDc4c+NX+Wr2pqzPfF0Y+qzK0V/zhhYXKluqXxEnUdKUHQ/Rsuvh7aRIH/tO9b2cAyOYJjeUqACobNURzwIpUlNcZP9wxj6uB+NwZeHgQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875416; c=relaxed/simple;
	bh=t3ExbEVyNO0+/en70y7Rrp8KshhoRhh+/5wCb1FWvm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGiZ0sllaoqyq9QNKsNoekON3IHvETQbHst33btQ/UWiyUqysVvjMEX8B4lQfxc7jGNpeFqbY2MO1oFwIk3pjaoyA+O2tscUFnNuAKI3liPb7f1GCd94cTch51maMCnDusJrEXf5jjDrTBpI6s7ZdwEK4PcvCQqQGqB2JaS8S44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WVucjeGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28333C4CEF0;
	Mon,  2 Jun 2025 14:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748875415;
	bh=t3ExbEVyNO0+/en70y7Rrp8KshhoRhh+/5wCb1FWvm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVucjeGHHXEj1xa0vQUg1rDwyrSAlLPRRLeS6JNVMwlFpYZCYkWzjeqo9iY+ux2H+
	 Pvrh1tNhXwktsHL4kD3FCGmiiXTCHAz/lVIRUcibeUTLiv2zdcXBhgp6pagVyhT1In
	 ZdlRxJ4DUN8Mz4bklVvftKkVpH/YLInxX6c/KJ4c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Divya Indi <divya.indi@oracle.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 5.10 098/270] tracing: samples: Initialize trace_array_printk() with the correct function
Date: Mon,  2 Jun 2025 15:46:23 +0200
Message-ID: <20250602134311.178691977@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134307.195171844@linuxfoundation.org>
References: <20250602134307.195171844@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Steven Rostedt <rostedt@goodmis.org>

commit 1b0c192c92ea1fe2dcb178f84adf15fe37c3e7c8 upstream.

When using trace_array_printk() on a created instance, the correct
function to use to initialize it is:

  trace_array_init_printk()

Not

  trace_printk_init_buffer()

The former is a proper function to use, the latter is for initializing
trace_printk() and causes the NOTICE banner to be displayed.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Divya Indi <divya.indi@oracle.com>
Link: https://lore.kernel.org/20250509152657.0f6744d9@gandalf.local.home
Fixes: 89ed42495ef4a ("tracing: Sample module to demonstrate kernel access to Ftrace instances.")
Fixes: 38ce2a9e33db6 ("tracing: Add trace_array_init_printk() to initialize instance trace_printk() buffers")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 samples/ftrace/sample-trace-array.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/samples/ftrace/sample-trace-array.c
+++ b/samples/ftrace/sample-trace-array.c
@@ -112,7 +112,7 @@ static int __init sample_trace_array_ini
 	/*
 	 * If context specific per-cpu buffers havent already been allocated.
 	 */
-	trace_printk_init_buffers();
+	trace_array_init_printk(tr);
 
 	simple_tsk = kthread_run(simple_thread, NULL, "sample-instance");
 	if (IS_ERR(simple_tsk)) {



