Return-Path: <stable+bounces-106664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2630A000F8
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 23:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D9C16287E
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 22:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8872B1940B1;
	Thu,  2 Jan 2025 22:01:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3DB13CF82;
	Thu,  2 Jan 2025 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735855313; cv=none; b=rqFgtrT1PtH+n+2GFWsxIiXXhrFEt5no6Bmh4Nx1IDwbD04XEUxqimeAG9Itn6CcoueEiAVy16n3A+p8/rGJzoYWCBgI/GXNUVatxvebL9H0v10G80IMvWE2ntcUyKZ7a971EDJGTtz1SMBjLZuHj5TcQ5T63xrDuYlE/WZwpDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735855313; c=relaxed/simple;
	bh=mg2GeBaUknbKMtOyH+kEmodhcBGpk2LgG9qzL2i+EwA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cdNXREYXLn9XJ14P7ScMwsBYcuSxqthw+feU3CRpkluwSiFS/+fdeF3Ynsy+gStTeRMKSbL08NdnHv58Dh7iE8lsAYR9CATrFXOLn7G/5977PUH4sQnLP0CAtO6tMZi6mILnRPw1ljMGR6dg+Kas4cqpTdKV1tCf8azF3Y5M1ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A7EC4CEDD;
	Thu,  2 Jan 2025 22:01:52 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tTTHa-00000005UsW-0NG4;
	Thu, 02 Jan 2025 17:03:10 -0500
Message-ID: <20250102220309.941099662@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 02 Jan 2025 17:02:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Zilin Guan <zilin@seu.edu.cn>
Subject: [for-linus][PATCH 1/2] fgraph: Add READ_ONCE() when accessing fgraph_array[]
References: <20250102220238.225015816@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Zilin Guan <zilin@seu.edu.cn>

In __ftrace_return_to_handler(), a loop iterates over the fgraph_array[]
elements, which are fgraph_ops. The loop checks if an element is a
fgraph_stub to prevent using a fgraph_stub afterward.

However, if the compiler reloads fgraph_array[] after this check, it might
race with an update to fgraph_array[] that introduces a fgraph_stub. This
could result in the stub being processed, but the stub contains a null
"func_hash" field, leading to a NULL pointer dereference.

To ensure that the gops compared against the fgraph_stub matches the gops
processed later, add a READ_ONCE(). A similar patch appears in commit
63a8dfb ("function_graph: Add READ_ONCE() when accessing fgraph_array[]").

Cc:stable@vger.kernel.org
Fixes: 37238abe3cb47 ("ftrace/function_graph: Pass fgraph_ops to function graph callbacks")
Link: https://lore.kernel.org/20241231113731.277668-1-zilin@seu.edu.cn
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index ddedcb50917f..30e3ddc8a8a8 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -833,7 +833,7 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 #endif
 	{
 		for_each_set_bit(i, &bitmap, sizeof(bitmap) * BITS_PER_BYTE) {
-			struct fgraph_ops *gops = fgraph_array[i];
+			struct fgraph_ops *gops = READ_ONCE(fgraph_array[i]);
 
 			if (gops == &fgraph_stub)
 				continue;
-- 
2.45.2



