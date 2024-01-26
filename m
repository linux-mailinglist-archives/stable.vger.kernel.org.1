Return-Path: <stable+bounces-15964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC7B83E5BC
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64F71F2060D
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE5B249F2;
	Fri, 26 Jan 2024 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c1OZh3eW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B29522EFA
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308808; cv=none; b=CZMDpPTvlgtrC4v6GU/KZQligFavcNc3BCNW3kwtu6nof22aKidvLeeMXqC0BULtzLZiLaCTQC1FI1wepTIERXpGW0b4IppP3ysJqW9EPqdMBUAwJt1GzYLpfs/72rILJ+N4F0+SHJeN1u0h/5Wu2SkDNGgNgwlxPLFMHw3zazA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308808; c=relaxed/simple;
	bh=T32VIVd77UuBs3EH7xIk6mmgBNRtC2LKN9qvCQbWXFo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WMfwCjr93rkd6yie0pT2IRN692Xm6VyQ+3ypIQoNdloOq8pZ2Km49EFq/iHPo4DFhSxb7OpsxwOmsQWATFKyTNlHyi4W+O1K3HGIi8wujQJ9u7IDPvARc2MKv071pz2Pz3pIUgFpOvLkeODjlsp51cMd5KU/G9VIo2i4HikvfXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c1OZh3eW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77348C433F1;
	Fri, 26 Jan 2024 22:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706308807;
	bh=T32VIVd77UuBs3EH7xIk6mmgBNRtC2LKN9qvCQbWXFo=;
	h=Subject:To:Cc:From:Date:From;
	b=c1OZh3eWvfgpV/sLLVA5R7DA8lNE4wn2qm5YtjiZKUsH2RG8aKC94EGrldoIOr2ME
	 WccwVy1fNFydAVLtGYv+kt+A+65EnO5tG6GkSLnYoZUoDD2AhVsUt4uxUiTy9c75py
	 CTTja9Kavv3XnGJWEKDQvVMK9UHCgE5bDxU23cdI=
Subject: FAILED: patch "[PATCH] pipe: wakeup wr_wait after setting max_usage" failed to apply to 6.6-stable tree
To: lukas@schauer.dev,brauner@kernel.org,dhowells@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:40:06 -0800
Message-ID: <2024012606-expediter-rental-fd22@gregkh>
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
git cherry-pick -x e95aada4cb93d42e25c30a0ef9eb2923d9711d4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012606-expediter-rental-fd22@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

e95aada4cb93 ("pipe: wakeup wr_wait after setting max_usage")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e95aada4cb93d42e25c30a0ef9eb2923d9711d4a Mon Sep 17 00:00:00 2001
From: Lukas Schauer <lukas@schauer.dev>
Date: Fri, 1 Dec 2023 11:11:28 +0100
Subject: [PATCH] pipe: wakeup wr_wait after setting max_usage

Commit c73be61cede5 ("pipe: Add general notification queue support") a
regression was introduced that would lock up resized pipes under certain
conditions. See the reproducer in [1].

The commit resizing the pipe ring size was moved to a different
function, doing that moved the wakeup for pipe->wr_wait before actually
raising pipe->max_usage. If a pipe was full before the resize occured it
would result in the wakeup never actually triggering pipe_write.

Set @max_usage and @nr_accounted before waking writers if this isn't a
watch queue.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=212295 [1]
Link: https://lore.kernel.org/r/20231201-orchideen-modewelt-e009de4562c6@brauner
Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Reviewed-by: David Howells <dhowells@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Lukas Schauer <lukas@schauer.dev>
[Christian Brauner <brauner@kernel.org>: rewrite to account for watch queues]
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/pipe.c b/fs/pipe.c
index 226e7f66b590..8d9286a1f2e8 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1324,6 +1324,11 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 	pipe->tail = tail;
 	pipe->head = head;
 
+	if (!pipe_has_watch_queue(pipe)) {
+		pipe->max_usage = nr_slots;
+		pipe->nr_accounted = nr_slots;
+	}
+
 	spin_unlock_irq(&pipe->rd_wait.lock);
 
 	/* This might have made more room for writers */
@@ -1375,8 +1380,6 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned int arg)
 	if (ret < 0)
 		goto out_revert_acct;
 
-	pipe->max_usage = nr_slots;
-	pipe->nr_accounted = nr_slots;
 	return pipe->max_usage * PAGE_SIZE;
 
 out_revert_acct:


