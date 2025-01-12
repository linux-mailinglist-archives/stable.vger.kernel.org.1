Return-Path: <stable+bounces-108315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A12A0A7EF
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 10:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF8B188681E
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 09:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1BA14F10F;
	Sun, 12 Jan 2025 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u1EKP+NW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A10256D
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736673416; cv=none; b=Ge2C6vLGyx9798q7Oh2yEu+iXfaPn4cHjgJe/95qL6+NibN5qKYL6jnSEb/aZYvsPL3nZFZnq8bqmUAjN1YMWqWKQBq+xM7q/r9+0DuSIZ98WlLsMBiAPMWPARJ0YoLmEFYBXW0yTzAOpCnt9FVJwnC6ftrYwIsKGg9bG5UdyoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736673416; c=relaxed/simple;
	bh=SufVdJYs1D4xR7e4P4Wn6D9vfZoT7YShlBlUMAt9HuE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QHBHR6Z9xrGwfe3CErnVj6Hhp3eSwbZ9/GzeGflUETsd+81Fyi2APqo0XlnQvwKY8QZ8uY9YmEZ12HuBjEMb7O2SaB+vxN2T0pWoiND8Mtzb8NCSEnMcyXotWu/XXQmgy8O4pybxk+/dI+2/DZxkL0DHUqejzDiLZkDzvh/GaF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u1EKP+NW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FFAC4CEDF;
	Sun, 12 Jan 2025 09:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736673416;
	bh=SufVdJYs1D4xR7e4P4Wn6D9vfZoT7YShlBlUMAt9HuE=;
	h=Subject:To:Cc:From:Date:From;
	b=u1EKP+NWHL0wH0lSj5U89rQ1ENYV1iT4NBrDB7bwCMQRxUXC4bZeHVRVbxZczlpfc
	 K52SpOdiWQ0Ll3c+899XtZ37IsbQwYvLwjnpDouI3IzUhUOD/W7tfbq8MQePTz9cLx
	 f+VaR4zEQT2xm/K1xA7ufJpHo0900zJO8neGQL+k=
Subject: FAILED: patch "[PATCH] io_uring/eventfd: ensure io_eventfd_signal() defers another" failed to apply to 6.6-stable tree
To: axboe@kernel.dk,jannh@google.com,lizetao1@huawei.com,ptsm@linux.microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 12 Jan 2025 10:16:45 +0100
Message-ID: <2025011245-hardy-tiptop-229e@gregkh>
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
git cherry-pick -x c9a40292a44e78f71258b8522655bffaf5753bdb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011245-hardy-tiptop-229e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c9a40292a44e78f71258b8522655bffaf5753bdb Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 8 Jan 2025 10:28:05 -0700
Subject: [PATCH] io_uring/eventfd: ensure io_eventfd_signal() defers another
 RCU period

io_eventfd_do_signal() is invoked from an RCU callback, but when
dropping the reference to the io_ev_fd, it calls io_eventfd_free()
directly if the refcount drops to zero. This isn't correct, as any
potential freeing of the io_ev_fd should be deferred another RCU grace
period.

Just call io_eventfd_put() rather than open-code the dec-and-test and
free, which will correctly defer it another RCU grace period.

Fixes: 21a091b970cd ("io_uring: signal registered eventfd to process deferred task work")
Reported-by: Jann Horn <jannh@google.com>
Cc: stable@vger.kernel.org
Tested-by: Li Zetao <lizetao1@huawei.com>
Reviewed-by: Li Zetao<lizetao1@huawei.com>
Reviewed-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/eventfd.c b/io_uring/eventfd.c
index fab936d31ba8..100d5da94cb9 100644
--- a/io_uring/eventfd.c
+++ b/io_uring/eventfd.c
@@ -33,20 +33,18 @@ static void io_eventfd_free(struct rcu_head *rcu)
 	kfree(ev_fd);
 }
 
+static void io_eventfd_put(struct io_ev_fd *ev_fd)
+{
+	if (refcount_dec_and_test(&ev_fd->refs))
+		call_rcu(&ev_fd->rcu, io_eventfd_free);
+}
+
 static void io_eventfd_do_signal(struct rcu_head *rcu)
 {
 	struct io_ev_fd *ev_fd = container_of(rcu, struct io_ev_fd, rcu);
 
 	eventfd_signal_mask(ev_fd->cq_ev_fd, EPOLL_URING_WAKE);
-
-	if (refcount_dec_and_test(&ev_fd->refs))
-		io_eventfd_free(rcu);
-}
-
-static void io_eventfd_put(struct io_ev_fd *ev_fd)
-{
-	if (refcount_dec_and_test(&ev_fd->refs))
-		call_rcu(&ev_fd->rcu, io_eventfd_free);
+	io_eventfd_put(ev_fd);
 }
 
 static void io_eventfd_release(struct io_ev_fd *ev_fd, bool put_ref)


