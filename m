Return-Path: <stable+bounces-15967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA3C83E5BF
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBED1C217CC
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C52241C99;
	Fri, 26 Jan 2024 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AytBhjkn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098894207E
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308812; cv=none; b=cjGCOG8Ui7nZJWQlwmjM2yJf8d6VoYp5R+GBa2yCfdg+YuQQQcrtZxgpGr00Tr664UM0dzuDzU+pEuOmAoBpu/9bhlaVoP4e9Ec1U6yuoEECuxxHtTTPFJ2jR3uv2GcFUJVzY9/KwxFc8o87QFoVx95k5qjV3GYjrGBN9qteftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308812; c=relaxed/simple;
	bh=fMFkXdBhBsSLtQ5V3IlZSNZWbequTo0DfPyPN64gM2k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X2n6UUvvOGqJhw4OWm0qpbTLOJK9VC5FqjD0yHgLme3n5+7T8GCbbs+1ea9wtgCBzxhw4tn7R7zaD8D7bmtWfyKbvabxa55BuRLT9u2KkKlwjqEuJXfcL6ZoP0lRMF1ro01OTl+jk6RDu1NLLYsN7UmLIiVM5YJqgGMSWG0Sfwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AytBhjkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E32C433C7;
	Fri, 26 Jan 2024 22:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706308811;
	bh=fMFkXdBhBsSLtQ5V3IlZSNZWbequTo0DfPyPN64gM2k=;
	h=Subject:To:Cc:From:Date:From;
	b=AytBhjknCgCrsEpisY5DyKRNmqKp9dRwc4fCtCq6mSqrenWIuytPyl2pHHMUlmOHv
	 Gg6jDoZFhWrLdqRm7qTmPG0gbPpjm618quDnScWsyE+XrRh0tTtqASM3Gzcr67mYuR
	 o0WGCzwDs9ixwc1HUKjrGY95W5gLwymAjlOjpWI4=
Subject: FAILED: patch "[PATCH] pipe: wakeup wr_wait after setting max_usage" failed to apply to 5.15-stable tree
To: lukas@schauer.dev,brauner@kernel.org,dhowells@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:40:10 -0800
Message-ID: <2024012610-lustiness-grew-ee5c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e95aada4cb93d42e25c30a0ef9eb2923d9711d4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012610-lustiness-grew-ee5c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

e95aada4cb93 ("pipe: wakeup wr_wait after setting max_usage")
189b0ddc2451 ("pipe: Fix missing lock in pipe_resize_ring()")

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


