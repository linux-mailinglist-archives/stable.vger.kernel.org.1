Return-Path: <stable+bounces-17262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1472784107C
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA223B218E5
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5977605F;
	Mon, 29 Jan 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2HVQ6NoA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F207A76032;
	Mon, 29 Jan 2024 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548630; cv=none; b=ou2AfpnykxM3+R5UyvuriSkZZ25xqvdV1jBIsfY+rKzfg/1bKcG4tZyqaCj2Jm2U6GVdML2sT5gX0JBtSf0v/YgMDfzkAXj8K6fBN6TbAaz7f1TovNlLLm7cY6jjsF68HO16ZNgS3bSi3UOl+aPXakAo9T4Xu/fjsxO7ZBS8VS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548630; c=relaxed/simple;
	bh=KeVvMkcjegjKgiDTiBTMKOq8LUGKmo6Gqk8/blUsf5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNeF+TfR3JLfRY9sUA+XnuTEKUOLzhIz6rfqDAGwK0FfpPHadc105M0IlPuzcbfMvK7x87qxd0IuHKJ0v3T3eWN23pPm2tS8vFhJ70As0QnxdL1ZcCzQ0ti+ES7OdO0tKRv+Xbgp5EDdUnqBIaUZCWU1JueaHLjfMrO8dHFE8xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2HVQ6NoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539AEC433C7;
	Mon, 29 Jan 2024 17:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548629;
	bh=KeVvMkcjegjKgiDTiBTMKOq8LUGKmo6Gqk8/blUsf5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2HVQ6NoAlqpsEbOYKwOcL5jh3gp35XiWF/e0Gb0acB7cDzli2sZohyrwobdorQkF3
	 YrHPDhXX4lEEAdtTQnWhuKSqGsm7mLXNUAIT3dP3XzAC5Dz2RCh2FVHHGx9Bm9cmjc
	 YU6g6/WFJ4/twP5AlF9/EC8BWDr6nMlWsaqYWado=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Lukas Schauer <lukas@schauer.dev>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 278/331] pipe: wakeup wr_wait after setting max_usage
Date: Mon, 29 Jan 2024 09:05:42 -0800
Message-ID: <20240129170022.999306321@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Schauer <lukas@schauer.dev>

[ Upstream commit e95aada4cb93d42e25c30a0ef9eb2923d9711d4a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pipe.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 603ab19b0861..a234035cc375 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1305,6 +1305,11 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 	pipe->tail = tail;
 	pipe->head = head;
 
+	if (!pipe_has_watch_queue(pipe)) {
+		pipe->max_usage = nr_slots;
+		pipe->nr_accounted = nr_slots;
+	}
+
 	spin_unlock_irq(&pipe->rd_wait.lock);
 
 	/* This might have made more room for writers */
@@ -1356,8 +1361,6 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned int arg)
 	if (ret < 0)
 		goto out_revert_acct;
 
-	pipe->max_usage = nr_slots;
-	pipe->nr_accounted = nr_slots;
 	return pipe->max_usage * PAGE_SIZE;
 
 out_revert_acct:
-- 
2.43.0




