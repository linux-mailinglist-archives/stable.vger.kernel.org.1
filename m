Return-Path: <stable+bounces-39422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AF38A4F22
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3721D1C2127D
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 12:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9346E611;
	Mon, 15 Apr 2024 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rLw4uD7q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6796E605
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184565; cv=none; b=b53TmsoHiHVdeCtwSLGkza3mtKLb/SDL3x2pLBZHfLeANPav78MGl0RJ/u92XzgkjFJK2gOAvBRpQ/rX5i8BXMnyakwXvnNGxJGz1y6ZKzY93sKqdcyPJHvlwjnIdCNN0gvTlWXgA9qYyidBFY1XuQXO7sNEMvpjxSuGQP3iTSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184565; c=relaxed/simple;
	bh=wIFmpycCMSIP/X4nVyJQu48nppw4jpwrUsg6LtBdw2k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OBf5jC7/pcRANr2QnveDcruJqQkRW/9Vjj2XcrzZX4mpUJs+BdDNKyo5Itlj9sywTX/nAUtud61fMb8SkJo7uVe42YnQAmRczI96jxzKVbrn9BrdzYgE3IMTTtFu8p8dkq/OoIlNFQFrv4W7MoMeKl/Wiw2xSc7TfnEwr8CuHQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rLw4uD7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B905C2BD11;
	Mon, 15 Apr 2024 12:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713184564;
	bh=wIFmpycCMSIP/X4nVyJQu48nppw4jpwrUsg6LtBdw2k=;
	h=Subject:To:Cc:From:Date:From;
	b=rLw4uD7qaz7ChZVVMRjxN6CIOZjZog9p3rOGmKGlzTde05WlgCHiKWm/nnVA7WH8n
	 Zu9SaXlcO1zhOmNTJzdy+qlhK+DtMIEUkVzTwjfZ11HXNuUgd6Y9HQRVHE1M8qyL8C
	 lzpRTPjOfRGrsxtAKlnlfOdMctBnHlmVayr0+ilc=
Subject: FAILED: patch "[PATCH] io_uring: Fix io_cqring_wait() not restoring sigmask on" failed to apply to 6.8-stable tree
To: izbyshev@ispras.ru,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Apr 2024 14:36:01 +0200
Message-ID: <2024041501-repulsion-purging-1a06@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x 978e5c19dfefc271e5550efba92fcef0d3f62864
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041501-repulsion-purging-1a06@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 978e5c19dfefc271e5550efba92fcef0d3f62864 Mon Sep 17 00:00:00 2001
From: Alexey Izbyshev <izbyshev@ispras.ru>
Date: Fri, 5 Apr 2024 15:55:51 +0300
Subject: [PATCH] io_uring: Fix io_cqring_wait() not restoring sigmask on
 get_timespec64() failure

This bug was introduced in commit 950e79dd7313 ("io_uring: minor
io_cqring_wait() optimization"), which was made in preparation for
adc8682ec690 ("io_uring: Add support for napi_busy_poll"). The latter
got reverted in cb3182167325 ("Revert "io_uring: Add support for
napi_busy_poll""), so simply undo the former as well.

Cc: stable@vger.kernel.org
Fixes: 950e79dd7313 ("io_uring: minor io_cqring_wait() optimization")
Signed-off-by: Alexey Izbyshev <izbyshev@ispras.ru>
Link: https://lore.kernel.org/r/20240405125551.237142-1-izbyshev@ispras.ru
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 4521c2b66b98..c170a2b8d2cf 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2602,19 +2602,6 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 	if (__io_cqring_events_user(ctx) >= min_events)
 		return 0;
 
-	if (sig) {
-#ifdef CONFIG_COMPAT
-		if (in_compat_syscall())
-			ret = set_compat_user_sigmask((const compat_sigset_t __user *)sig,
-						      sigsz);
-		else
-#endif
-			ret = set_user_sigmask(sig, sigsz);
-
-		if (ret)
-			return ret;
-	}
-
 	init_waitqueue_func_entry(&iowq.wq, io_wake_function);
 	iowq.wq.private = current;
 	INIT_LIST_HEAD(&iowq.wq.entry);
@@ -2633,6 +2620,19 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 		io_napi_adjust_timeout(ctx, &iowq, &ts);
 	}
 
+	if (sig) {
+#ifdef CONFIG_COMPAT
+		if (in_compat_syscall())
+			ret = set_compat_user_sigmask((const compat_sigset_t __user *)sig,
+						      sigsz);
+		else
+#endif
+			ret = set_user_sigmask(sig, sigsz);
+
+		if (ret)
+			return ret;
+	}
+
 	io_napi_busy_loop(ctx, &iowq);
 
 	trace_io_uring_cqring_wait(ctx, min_events);


