Return-Path: <stable+bounces-109671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51161A18354
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4C53AAC70
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 17:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B2A1F561E;
	Tue, 21 Jan 2025 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r/Oy0BBW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FEF1F55E3;
	Tue, 21 Jan 2025 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482099; cv=none; b=Lbcq2+WDNlDLK5i/EVtep54N43qUlppunUnSPMmAjnh1F3eut53KGrqtKjYN/637guDoqikZfFmXEc6bpMDqH6mKOksBxEgINO08uGv0w3NxFK2eOmNtpLbWq6CaCrboydvjqge7bnGMuSODJiL36qTVc46W9UTLVY+4xDO+0ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482099; c=relaxed/simple;
	bh=nmcLxghLpavFelkmunwhmgsbCStfGTUVeB2pBHaRwaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vexjd4fc1zHEBmYmfpVZLITiuo63PMlgc/FL4E1glYLclv5uOfRDZfRZdejZ85KVeOI4D3+yFNmmJAEbxmpEkWBifcv8y5AAtRzuACZbhYH7h1PTlelE9xZkvIg+On4qLB+VnlF9WPWoyn8UT+2Nez2S1rRsI3qMY//wPpkfcss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r/Oy0BBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08FEC4CEDF;
	Tue, 21 Jan 2025 17:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482099;
	bh=nmcLxghLpavFelkmunwhmgsbCStfGTUVeB2pBHaRwaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r/Oy0BBWospFdf26A8jsSFKKgZszVuqe3oooPA5co/PWcYYDs3MkgqRc0Qsn/E8Bb
	 7hYpciNTaxydmc8JCSJzweGpEl0S2SVDGVtApoG+EEmS993KGxs5krr3E/ySPnAd4X
	 opqizdUrewO6ljmzETEaQYn4BD40737ksrN8qZ30=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 34/72] poll_wait: add mb() to fix theoretical race between waitqueue_active() and .poll()
Date: Tue, 21 Jan 2025 18:52:00 +0100
Message-ID: <20250121174524.736780078@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174523.429119852@linuxfoundation.org>
References: <20250121174523.429119852@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit cacd9ae4bf801ff4125d8961bb9a3ba955e51680 ]

As the comment above waitqueue_active() explains, it can only be used
if both waker and waiter have mb()'s that pair with each other. However
__pollwait() is broken in this respect.

This is not pipe-specific, but let's look at pipe_poll() for example:

	poll_wait(...); // -> __pollwait() -> add_wait_queue()

	LOAD(pipe->head);
	LOAD(pipe->head);

In theory these LOAD()'s can leak into the critical section inside
add_wait_queue() and can happen before list_add(entry, wq_head), in this
case pipe_poll() can race with wakeup_pipe_readers/writers which do

	smp_mb();
	if (waitqueue_active(wq_head))
		wake_up_interruptible(wq_head);

There are more __pollwait()-like functions (grep init_poll_funcptr), and
it seems that at least ep_ptable_queue_proc() has the same problem, so the
patch adds smp_mb() into poll_wait().

Link: https://lore.kernel.org/all/20250102163320.GA17691@redhat.com/
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250107162717.GA18922@redhat.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/poll.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/poll.h b/include/linux/poll.h
index d1ea4f3714a84..fc641b50f1298 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -41,8 +41,16 @@ typedef struct poll_table_struct {
 
 static inline void poll_wait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p)
 {
-	if (p && p->_qproc && wait_address)
+	if (p && p->_qproc && wait_address) {
 		p->_qproc(filp, wait_address, p);
+		/*
+		 * This memory barrier is paired in the wq_has_sleeper().
+		 * See the comment above prepare_to_wait(), we need to
+		 * ensure that subsequent tests in this thread can't be
+		 * reordered with __add_wait_queue() in _qproc() paths.
+		 */
+		smp_mb();
+	}
 }
 
 /*
-- 
2.39.5




