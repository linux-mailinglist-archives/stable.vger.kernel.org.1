Return-Path: <stable+bounces-47027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA0D8D0C46
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007F81F213CC
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DA815EFC3;
	Mon, 27 May 2024 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z/S8kKrX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1E168C4;
	Mon, 27 May 2024 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837478; cv=none; b=iEZt/nRjhx8MYguCteGDK2WxHtegob5KjMqqKfbl10UhaEce8MfRWC7Gv/NCg5stiGKiD5zEIHoUUeHZKTWnz9nl3EFiFBFVO+YMHxqXJB+cEwJLuWkIPf5q35VWdvqEr+CL+G79zRVep4K/L1QNhKti8C0u+hDT9lx8YtGm7gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837478; c=relaxed/simple;
	bh=vjKL5fyhvQZVHXvFUxQ4U5kD6Vqk0ThZXdqMTqDqO3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPmeNhka8A2hbyTCKJqIfu0c8+c3c8s3YrQujz29e3cc1tTBSQhVD37Q3rFrGUGUozwQ0GqPa0wZzZZv/wnjhS7kU2ha70bnzF3di1xmyeGjOBHTP+2we2CXyuQxAa5L+TNFjvXM4IhvgSNEGjjFp/9sSb8UTGssQzBNOWtUkm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z/S8kKrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B28DC2BBFC;
	Mon, 27 May 2024 19:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716837477;
	bh=vjKL5fyhvQZVHXvFUxQ4U5kD6Vqk0ThZXdqMTqDqO3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z/S8kKrXISQHLmx9wih25ROJqMwkoEt3RnuxmkleVxlbV7ArssuJugiZFn90KMZZ4
	 rNY1wyJXD6T8iMIfummCzc5KrPQZK9IBbtSFDhgtJQ7DZdechjq+WziAS5HCN6wxxQ
	 v7NV++S6LIoykn58ZMRFBQbcnWzWOLsWq2B+Ifts=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	"Bai, Shuangpeng" <sjb7183@psu.edu>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.8 026/493] nilfs2: fix unexpected freezing of nilfs_segctor_sync()
Date: Mon, 27 May 2024 20:50:28 +0200
Message-ID: <20240527185629.072928089@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit 936184eadd82906992ff1f5ab3aada70cce44cee upstream.

A potential and reproducible race issue has been identified where
nilfs_segctor_sync() would block even after the log writer thread writes a
checkpoint, unless there is an interrupt or other trigger to resume log
writing.

This turned out to be because, depending on the execution timing of the
log writer thread running in parallel, the log writer thread may skip
responding to nilfs_segctor_sync(), which causes a call to schedule()
waiting for completion within nilfs_segctor_sync() to lose the opportunity
to wake up.

The reason why waking up the task waiting in nilfs_segctor_sync() may be
skipped is that updating the request generation issued using a shared
sequence counter and adding an wait queue entry to the request wait queue
to the log writer, are not done atomically.  There is a possibility that
log writing and request completion notification by nilfs_segctor_wakeup()
may occur between the two operations, and in that case, the wait queue
entry is not yet visible to nilfs_segctor_wakeup() and the wake-up of
nilfs_segctor_sync() will be carried over until the next request occurs.

Fix this issue by performing these two operations simultaneously within
the lock section of sc_state_lock.  Also, following the memory barrier
guidelines for event waiting loops, move the call to set_current_state()
in the same location into the event waiting loop to ensure that a memory
barrier is inserted just before the event condition determination.

Link: https://lkml.kernel.org/r/20240520132621.4054-3-konishi.ryusuke@gmail.com
Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Cc: "Bai, Shuangpeng" <sjb7183@psu.edu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/segment.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2211,19 +2211,28 @@ static int nilfs_segctor_sync(struct nil
 	struct nilfs_segctor_wait_request wait_req;
 	int err = 0;
 
-	spin_lock(&sci->sc_state_lock);
 	init_wait(&wait_req.wq);
 	wait_req.err = 0;
 	atomic_set(&wait_req.done, 0);
+	init_waitqueue_entry(&wait_req.wq, current);
+
+	/*
+	 * To prevent a race issue where completion notifications from the
+	 * log writer thread are missed, increment the request sequence count
+	 * "sc_seq_request" and insert a wait queue entry using the current
+	 * sequence number into the "sc_wait_request" queue at the same time
+	 * within the lock section of "sc_state_lock".
+	 */
+	spin_lock(&sci->sc_state_lock);
 	wait_req.seq = ++sci->sc_seq_request;
+	add_wait_queue(&sci->sc_wait_request, &wait_req.wq);
 	spin_unlock(&sci->sc_state_lock);
 
-	init_waitqueue_entry(&wait_req.wq, current);
-	add_wait_queue(&sci->sc_wait_request, &wait_req.wq);
-	set_current_state(TASK_INTERRUPTIBLE);
 	wake_up(&sci->sc_wait_daemon);
 
 	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
 		if (atomic_read(&wait_req.done)) {
 			err = wait_req.err;
 			break;



