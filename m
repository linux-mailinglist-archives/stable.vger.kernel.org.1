Return-Path: <stable+bounces-38611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 562A48A0F85
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1471F27F3A
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33957146A81;
	Thu, 11 Apr 2024 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eyc3gPiZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59F714600E;
	Thu, 11 Apr 2024 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831079; cv=none; b=XrWBD+olkZdINvk0JnfKx/mJ1eVNCGAt1MnBYKvpZ+2a8pZAqXxB3DHUPr1cU0hXFuH21S4MbXGnuh2Tdd18a82Hu8JWhEAwbI9kRBr1+l5L2cVgoW1dQPr8wd5G/NPZDhvGVTr7WWp2DMLbgmFAkwO+vzvtU/sdmQouwljJz5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831079; c=relaxed/simple;
	bh=fSqc5PZHJVXCxX98xwzsi5QrLE7JoUejIAcyIyVbrrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0Le8dEQT0qZ3IGh9jQFXo8xl4Jfuq0BSB2PI+cVnM06llfHgBwcLJkFOUQjELkFbE+EvM8mxH6g74UMVjjZICg0bD/KmaWKcrm7PprzPR/BAMHstRssrukioxdCH92RTT6BO3guzc5yLHV8TaozVe5+PPKQ8FTWIQHifO1wO1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eyc3gPiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6B3C43394;
	Thu, 11 Apr 2024 10:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831078;
	bh=fSqc5PZHJVXCxX98xwzsi5QrLE7JoUejIAcyIyVbrrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eyc3gPiZ8qaOGmBEKBoIHRKShQ7fz36Cw6TK9Vb0MxVKoS1WlAE2UGBYz82E6A/Ya
	 /gISQLIhyhwIf47WcP/hP9v4sCTGT3jZ3yy/D2NHAC9m4dLf0EG7MREyAfFpnyhqHT
	 6xnEQ+naqx05dyAZc7Bq9fuXvFlaa+kdoY8GqDlI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dai Ngo <dai.ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 191/215] SUNRPC: increase size of rpc_wait_queue.qlen from unsigned short to unsigned int
Date: Thu, 11 Apr 2024 11:56:40 +0200
Message-ID: <20240411095430.604371983@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
References: <20240411095424.875421572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dai Ngo <dai.ngo@oracle.com>

[ Upstream commit 2c35f43b5a4b9cdfaa6fdd946f5a212615dac8eb ]

When the NFS client is under extreme load the rpc_wait_queue.qlen counter
can be overflowed. Here is an instant of the backlog queue overflow in a
real world environment shown by drgn helper:

rpc_task_stats(rpc_clnt):
-------------------------
rpc_clnt: 0xffff92b65d2bae00
rpc_xprt: 0xffff9275db64f000
  Queue:  sending[64887] pending[524] backlog[30441] binding[0]
XMIT task: 0xffff925c6b1d8e98
     WRITE: 750654
        __dta_call_status_580: 65463
        __dta_call_transmit_status_579: 1
        call_reserveresult: 685189
        nfs_client_init_is_complete: 1
    COMMIT: 584
        call_reserveresult: 573
        __dta_call_status_580: 11
    ACCESS: 1
        __dta_call_status_580: 1
   GETATTR: 10
        __dta_call_status_580: 4
        call_reserveresult: 6
751249 tasks for server 111.222.333.444
Total tasks: 751249

count_rpc_wait_queues(xprt):
----------------------------
**** rpc_xprt: 0xffff9275db64f000 num_reqs: 65511
wait_queue: xprt_binding[0] cnt: 0
wait_queue: xprt_binding[1] cnt: 0
wait_queue: xprt_binding[2] cnt: 0
wait_queue: xprt_binding[3] cnt: 0
rpc_wait_queue[xprt_binding].qlen: 0 maxpriority: 0
wait_queue: xprt_sending[0] cnt: 0
wait_queue: xprt_sending[1] cnt: 64887
wait_queue: xprt_sending[2] cnt: 0
wait_queue: xprt_sending[3] cnt: 0
rpc_wait_queue[xprt_sending].qlen: 64887 maxpriority: 3
wait_queue: xprt_pending[0] cnt: 524
wait_queue: xprt_pending[1] cnt: 0
wait_queue: xprt_pending[2] cnt: 0
wait_queue: xprt_pending[3] cnt: 0
rpc_wait_queue[xprt_pending].qlen: 524 maxpriority: 0
wait_queue: xprt_backlog[0] cnt: 0
wait_queue: xprt_backlog[1] cnt: 685801
wait_queue: xprt_backlog[2] cnt: 0
wait_queue: xprt_backlog[3] cnt: 0
rpc_wait_queue[xprt_backlog].qlen: 30441 maxpriority: 3 [task cnt mismatch]

There is no effect on operations when this overflow occurs. However
it causes confusion when trying to diagnose the performance problem.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index 5c37fabdec103..61de83be9cc27 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -196,7 +196,7 @@ struct rpc_wait_queue {
 	unsigned char		maxpriority;		/* maximum priority (0 if queue is not a priority queue) */
 	unsigned char		priority;		/* current priority */
 	unsigned char		nr;			/* # tasks remaining for cookie */
-	unsigned short		qlen;			/* total # tasks waiting in queue */
+	unsigned int		qlen;			/* total # tasks waiting in queue */
 	struct rpc_timer	timer_list;
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) || IS_ENABLED(CONFIG_TRACEPOINTS)
 	const char *		name;
-- 
2.43.0




