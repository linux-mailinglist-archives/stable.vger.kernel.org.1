Return-Path: <stable+bounces-114871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA19A30762
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137881887143
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5D01F1521;
	Tue, 11 Feb 2025 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RH2UM2Js"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FB31F12F8
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739266900; cv=none; b=L0SbriDAjgwR0zzw77lwRBv9enjGHo98C/+jSaxhohHMKI4hE8OYxvibhovkZVXQzEDvrHoKrdasZ1EGxtHGuq1GMBPy84/uvdhfYd+lcWYdudAy1v5fxOemrAMZrj1Hdo4FcPGMjtKro8Zf4PnRngTYwNpqaY5gr77BhLLRlQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739266900; c=relaxed/simple;
	bh=2Ks0OW3hyDEKjYrelLkqtIHncrYDz3sTRsrL5nPdPaw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uv9hOw425iVX/hQx5MnKlkbJyxzw5GkdY5c+4EchZg0mSszbc7nctJ1uiZfF7E/TIjf0Zi/a89Yj+exDMrKyDWumYxHgz9f4bAbGuQ4aLsDtV2dW4IwTgAHTl7Qt54Amj/Qdt+paWHirp7DUutUTnKnVHTgy/fW7Pk72YRye7mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RH2UM2Js; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FF7C4CEDD;
	Tue, 11 Feb 2025 09:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739266900;
	bh=2Ks0OW3hyDEKjYrelLkqtIHncrYDz3sTRsrL5nPdPaw=;
	h=Subject:To:Cc:From:Date:From;
	b=RH2UM2JsYdMoEjiS0RmaTZGNbNmAIy/4b+hyIK2fFfQnluJvzAHQzC1as7kSeVcbm
	 fkclcdRx7Fa6w8TtQIBF2WIfLu9U/sCQtwSisMt7wk8Vhn+zIxZk/BD+1lmqtd3wxK
	 p9lfAIiYYroZXdyhulNZmhUMg4P8xc+CD+a3jtBo=
Subject: FAILED: patch "[PATCH] io_uring: fix multishots with selected buffers" failed to apply to 6.1-stable tree
To: asml.silence@gmail.com,axboe@kernel.dk,billy@starlabs.sg,jacob.soo@starlabs.sg,ramdhan@starlabs.sg
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 11 Feb 2025 10:41:32 +0100
Message-ID: <2025021131-mushy-affecting-a576@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d63b0e8a628e62ca85a0f7915230186bb92f8bb4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021131-mushy-affecting-a576@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d63b0e8a628e62ca85a0f7915230186bb92f8bb4 Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Tue, 28 Jan 2025 00:55:24 +0000
Subject: [PATCH] io_uring: fix multishots with selected buffers

We do io_kbuf_recycle() when arming a poll but every iteration of a
multishot can grab more buffers, which is why we need to flush the kbuf
ring state before continuing with waiting.

Cc: stable@vger.kernel.org
Fixes: b3fdea6ecb55c ("io_uring: multishot recv")
Reported-by: Muhammad Ramdhan <ramdhan@starlabs.sg>
Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Reported-by: Jacob Soo <jacob.soo@starlabs.sg>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/1bfc9990fe435f1fc6152ca9efeba5eb3e68339c.1738025570.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/poll.c b/io_uring/poll.c
index 356474c66f32..31b118133bb0 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -315,8 +315,10 @@ void io_poll_task_func(struct io_kiocb *req, struct io_tw_state *ts)
 
 	ret = io_poll_check_events(req, ts);
 	if (ret == IOU_POLL_NO_ACTION) {
+		io_kbuf_recycle(req, 0);
 		return;
 	} else if (ret == IOU_POLL_REQUEUE) {
+		io_kbuf_recycle(req, 0);
 		__io_poll_execute(req, 0);
 		return;
 	}


