Return-Path: <stable+bounces-51560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF63907077
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F10285124
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0501448C3;
	Thu, 13 Jun 2024 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hmjxc9Ta"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD0A13C69C;
	Thu, 13 Jun 2024 12:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281654; cv=none; b=WZxsp4nd6/yGDVgiorNfR7q8HUYBv0jGDm24QlwMy2BcjM9vZyfQJxzkD+IKpsNo8UFQtQCdpB+c+IFQvkr42fQDka1ZhD4QvxgdtguSrw3xJAPXcYJvkg1qP9JG78ml/MXQDu528DdAcMmeJbcUmRqp8m7U7IDhUZBqlptc+ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281654; c=relaxed/simple;
	bh=J642IvyFLkKCtBFeBUIybLBw/a7GuhXClXFco1kb2eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Co74q++tWRkTta6+dM0bSyLIn4GRcrFjeJH89oDXUGvJHqBasJ2vLsTs+yKTFcs0kH5oHIDTpSlA35+S71T12Vhh7BqigpXcsKo4DPsasF8eMLp5/6pbfr7+hS2m9xhMV1O+UBH5L0pi4pONWrdwWEiNGzO7A0cdy4UgyPnvyME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hmjxc9Ta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59125C32786;
	Thu, 13 Jun 2024 12:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281653;
	bh=J642IvyFLkKCtBFeBUIybLBw/a7GuhXClXFco1kb2eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hmjxc9TadIiBJ2KiYCQP4gemY7JkNjvTjB56PAb76qSsSc9W9nk2zwcl852tb/0nO
	 4vBV6LyMxFM7muVTCvW7jDFAsCmWreQn69dLOnarhedVb7Kw/Ltsz5LjO/vtoxziSj
	 uJZpy7LTncFyT5wHGKjx+5RhZvSwFUTib/hdnS6A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	"Bai, Shuangpeng" <sjb7183@psu.edu>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15 011/402] nilfs2: fix unexpected freezing of nilfs_segctor_sync()
Date: Thu, 13 Jun 2024 13:29:28 +0200
Message-ID: <20240613113302.577474701@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2207,19 +2207,28 @@ static int nilfs_segctor_sync(struct nil
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



