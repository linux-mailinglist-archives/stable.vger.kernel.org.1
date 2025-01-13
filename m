Return-Path: <stable+bounces-108499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37781A0C042
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 19:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E62F3A7BEE
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 18:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78222080F2;
	Mon, 13 Jan 2025 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiFPICpc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9362F2080DD;
	Mon, 13 Jan 2025 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793336; cv=none; b=Y/HoGZbKam5EVGq3Kwp6MhLUeLnLk0rcwx97UQlNwq/HqLVYKX6mQejpEtdutd6PullV+1kA62GIURvuNqe760ZIdGE1e35TjpnERfzGRaDKNPdFC414O7PPDobnGjNJg2TYWGmqVjYN0guep6ZiJ54KavNaA8KIk5v6WA8TaMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793336; c=relaxed/simple;
	bh=n0Pf6qpGoYAXXTCIUxq4k5sAvt6d3JS46oA5bUdbivA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UxnhBzlgc8T864qTLiA6BUx9vuGLvSQtbuMZJi5AFudx8VWnqNMTwxLl6MZh0MCL4tyQfOuislWN0jQL4yG5Vq6OypP0E3ioXxelWeSC67M+lufir8N8D1QeBQF98nqL5yAN7leiNdI8cWDlZS7Gs8zCOp+wZlBEs2mueZDAxUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiFPICpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79566C4CEE1;
	Mon, 13 Jan 2025 18:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793336;
	bh=n0Pf6qpGoYAXXTCIUxq4k5sAvt6d3JS46oA5bUdbivA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QiFPICpc8z6jDRKaWK/xU711zNR2Auq2ccRspCTxlR+y5R1G3NH3PvrH/g7+o8uAi
	 XhunN5yzHtnNmduCl+o6HZefmyv2+fqehlj7HEjNDy1kn3cQzVFbOT2uf95oyEN3Sh
	 wkYLhh/936cKsAR7xo3VNIjMfqgni3odw3SmBcihgvNueaaP9fclbIkbbEaGMT3xpf
	 U2oh9oyuGjL2g3WikoZ14O1OFJE2dKNjRX6N9VuFUEhmqMinmBBPQ3URXWllPidA5v
	 z6rIvUJSUfweH21a1DBXjJiTanQ9kzW5vsbjr2rBW9c1G3BRtsa6AA1S3nNCYocibn
	 a6bIfWax8nAqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kees@kernel.org,
	ak@linux.intel.com,
	jack@suse.cz,
	arnd@arndb.de
Subject: [PATCH AUTOSEL 6.6 10/10] poll_wait: add mb() to fix theoretical race between waitqueue_active() and .poll()
Date: Mon, 13 Jan 2025 13:35:11 -0500
Message-Id: <20250113183511.1783990-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183511.1783990-1-sashal@kernel.org>
References: <20250113183511.1783990-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.71
Content-Transfer-Encoding: 8bit

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
index d1ea4f3714a8..fc641b50f129 100644
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


