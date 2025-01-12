Return-Path: <stable+bounces-108317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B58E0A0A801
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 10:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC03D1615C5
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 09:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9141898F2;
	Sun, 12 Jan 2025 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hPwYtovU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D36325763
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736674619; cv=none; b=m3DOFP/1RgqRyAODvi5ooNOWO5N5x4zRBB+r7c3pEZEe1IyQp9RQgkUMpWSTsVEZ7PjsGa1I0LUFjeXUrseNTTmbmEL4LTbBA+925WOmpl2H9oQcKodX1L6pr8qlHLF0NKrvb6cELDdGKix1RiOyWxW1YV1VrS9vPadyQjYAhtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736674619; c=relaxed/simple;
	bh=E1yxeWsYooN7cy0+BDaC3YC3q7RtxTCqVLImmBedUPQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SZEtel7ROOTmG7fB05fOvRpc77uC95MWB3EMtrh1udNoM7GrOODxR8yEwyvwr0WC+/44jlaq9DKebUcgraD709sHW16/pMaGeITCyyNL8XWgncHgn02aNyYxGnxiYjLA75ZPB8bSEQ3SUKQ+KCA9+y/M5L5SyuXnpwEEBh0USl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hPwYtovU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AA9C4CEDF;
	Sun, 12 Jan 2025 09:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736674619;
	bh=E1yxeWsYooN7cy0+BDaC3YC3q7RtxTCqVLImmBedUPQ=;
	h=Subject:To:Cc:From:Date:From;
	b=hPwYtovU4NANIylcYpN7wIO1P4TENvTCbhBHY0nkIBgWwabhVQbVEtvuMo9EeN8aO
	 ZAitKcSFMDqVkX2EigPPN3OD9NC6RZkeBxQsft1lc40HR8oxNJc16OOqaQ/v+nOpoY
	 s2vLOBKrp7sVL9oeNRQf+/GoB60BkNKUxehrXOCs=
Subject: FAILED: patch "[PATCH] io_uring: don't touch sqd->thread off tw add" failed to apply to 6.12-stable tree
To: asml.silence@gmail.com,axboe@kernel.dk,lizetao1@huawei.com,minhquangbui99@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 12 Jan 2025 10:36:56 +0100
Message-ID: <2025011256-extinct-expanse-d059@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x bd2703b42decebdcddf76e277ba76b4c4a142d73
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011256-extinct-expanse-d059@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bd2703b42decebdcddf76e277ba76b4c4a142d73 Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Fri, 10 Jan 2025 20:36:45 +0000
Subject: [PATCH] io_uring: don't touch sqd->thread off tw add

With IORING_SETUP_SQPOLL all requests are created by the SQPOLL task,
which means that req->task should always match sqd->thread. Since
accesses to sqd->thread should be separately protected, use req->task
in io_req_normal_work_add() instead.

Note, in the eyes of io_req_normal_work_add(), the SQPOLL task struct
is always pinned and alive, and sqd->thread can either be the task or
NULL. It's only problematic if the compiler decides to reload the value
after the null check, which is not so likely.

Cc: stable@vger.kernel.org
Cc: Bui Quang Minh <minhquangbui99@gmail.com>
Reported-by: lizetao <lizetao1@huawei.com>
Fixes: 78f9b61bd8e54 ("io_uring: wake SQPOLL task when task_work is added to an empty queue")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/1cbbe72cf32c45a8fee96026463024cd8564a7d7.1736541357.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index d3403c8216db..5eb119002099 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1226,10 +1226,7 @@ static void io_req_normal_work_add(struct io_kiocb *req)
 
 	/* SQPOLL doesn't need the task_work added, it'll run it itself */
 	if (ctx->flags & IORING_SETUP_SQPOLL) {
-		struct io_sq_data *sqd = ctx->sq_data;
-
-		if (sqd->thread)
-			__set_notify_signal(sqd->thread);
+		__set_notify_signal(tctx->task);
 		return;
 	}
 


