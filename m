Return-Path: <stable+bounces-62450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7BB93F253
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E28282D5C
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01581419B5;
	Mon, 29 Jul 2024 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sSJPjGFl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6245225634
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248015; cv=none; b=ryMEHDJ724mHNw4T1IoNVV9HDxYRqbx6teq8SAbz/JeGRleqyIhJiWLE4w3IB5tdACeluKo1NBqE5YgvAGvAgdI/QqcjAspNoS1Gw9s2LBzOWn90ZpVzlUAo8WByZ5wru/AJ8wQgz4qL0UaRmHF+EMBOoMRCOyLddQvF4BZyBrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248015; c=relaxed/simple;
	bh=9y/cX9eMD10srts88GiD6NzsRzLPLrBaNjRdRw1brBI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mL3cgFS/z+BTZBKlniBTXbApfeONSCNuODUQsb3GiU1LsFkOFIKbJ0f7kwTNdoCZ51XDg3mbYaCbPBrmBEof7NN/cufeqSBuOhunQYOy+eP2VmG8ti93YRnZ8HskmZ86wRyvDrObG/V19i1XVXpwjpkK7kS5g/dioa1x0u9IcYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sSJPjGFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A72C4AF0A;
	Mon, 29 Jul 2024 10:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722248015;
	bh=9y/cX9eMD10srts88GiD6NzsRzLPLrBaNjRdRw1brBI=;
	h=Subject:To:Cc:From:Date:From;
	b=sSJPjGFlNyf2Wa8BVVAK/b5HkZliB0LUN3oj8zHXpoiqPxgUUcI077tD21UPSJZB5
	 fE4PerHaorQ00J5K83y8vJdG5maZu1BuXikYMCIVRCS6Mq+qnbGw2jUx0sEdkxkIIs
	 rraHABv9LSMXjb+mHdYnTsQivVXmLsZDObmft7O0=
Subject: FAILED: patch "[PATCH] io_uring: fix lost getsockopt completions" failed to apply to 6.6-stable tree
To: asml.silence@gmail.com,axboe@kernel.dk,leitao@debian.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 12:13:31 +0200
Message-ID: <2024072931-sarcastic-coagulant-6821@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 24dce1c538a7ceac43f2f97aae8dfd4bb93ea9b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072931-sarcastic-coagulant-6821@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

24dce1c538a7 ("io_uring: fix lost getsockopt completions")
d10f19dff56e ("io_uring/uring_cmd: switch to always allocating async data")
a9165b83c193 ("io_uring/rw: always setup io_async_rw for read/write requests")
8e5b3b89ecaf ("io_uring: remove struct io_tw_state::locked")
92219afb980e ("io_uring: force tw ctx locking")
6e6b8c62120a ("io_uring/rw: avoid punting to io-wq directly")
e1eef2e56cb0 ("io_uring/cmd: fix tw <-> issue_flags conversion")
6edd953b6ec7 ("io_uring/cmd: kill one issue_flags to tw conversion")
da12d9ab5889 ("io_uring/cmd: move io_uring_try_cancel_uring_cmd()")
8d0c12a80cde ("io-uring: add napi busy poll support")
405b4dc14b10 ("io-uring: move io_wait_queue definition to header file")
da08d2edb020 ("io_uring: re-arrange struct io_ring_ctx to reduce padding")
42c0905f0cac ("io_uring: cleanup handle_tw_list() calling convention")
9fe3eaea4a35 ("io_uring: remove unconditional looping in local task_work handling")
670d9d3df880 ("io_uring: remove next io_kiocb fetch in task_work running")
170539bdf109 ("io_uring: handle traditional task_work in FIFO order")
592b4805432a ("io_uring: remove looping around handling traditional task_work")
95041b93e90a ("io_uring: add io_file_can_poll() helper")
521223d7c229 ("io_uring/cancel: don't default to setting req->work.cancel_seq")
4bcb982cce74 ("io_uring: expand main struct io_kiocb flags to 64-bits")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 24dce1c538a7ceac43f2f97aae8dfd4bb93ea9b9 Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Tue, 16 Jul 2024 19:05:46 +0100
Subject: [PATCH] io_uring: fix lost getsockopt completions

There is a report that iowq executed getsockopt never completes. The
reason being that io_uring_cmd_sock() can return a positive result, and
io_uring_cmd() propagates it back to core io_uring, instead of IOU_OK.
In case of io_wq_submit_work(), the request will be dropped without
completing it.

The offending code was introduced by a hack in
a9c3eda7eada9 ("io_uring: fix submission-failure handling for uring-cmd"),
however it was fine until getsockopt was introduced and started
returning positive results.

The right solution is to always return IOU_OK, since
e0b23d9953b0c ("io_uring: optimise ltimeout for inline execution"),
we should be able to do it without problems, however for the sake of
backporting and minimising side effects, let's keep returning negative
return codes and otherwise do IOU_OK.

Link: https://github.com/axboe/liburing/issues/1181
Cc: stable@vger.kernel.org
Fixes: 8e9fad0e70b7b ("io_uring: Add io_uring command support for sockets")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/r/ff349cf0654018189b6077e85feed935f0f8839e.1721149870.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 21ac5fb2d5f0..a54163a83968 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -265,7 +265,7 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 		req_set_fail(req);
 	io_req_uring_cleanup(req, issue_flags);
 	io_req_set_res(req, ret, 0);
-	return ret;
+	return ret < 0 ? ret : IOU_OK;
 }
 
 int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,


