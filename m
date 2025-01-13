Return-Path: <stable+bounces-108520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBD7A0C086
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 19:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5417318879E2
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 18:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DB12248A5;
	Mon, 13 Jan 2025 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdV2axPr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5322489D;
	Mon, 13 Jan 2025 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793393; cv=none; b=NkOFxiWPxj3rniNm3dQUZHz8HENbRU4QFam9KDyTPpnobvptFru4JVd2B14X379n4ZSzIFxy1/6Ko2jFdtR59HKcAbt5uZjO+UigXMTw6dO8IDwqv3bgz/JdACrIuPnGq9nf6rQb2M36G83UD1iAL/dIpyUqf6AAxnU3FbRA9ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793393; c=relaxed/simple;
	bh=HbtvBeIcZy2P32mTLCcMuGA1L+t+DPjp5Ry6smyZ6KQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iu2y8RWCqInYUwlOrN+46ntmTgfogbPkh/1dQUcYyk0wtePAyQwDKvMZB6OXkh4p7c9g0u6YwPNFssvREV34PtIPoas+A8Jg30EmKyEf0rBDp1JP1obyNw87NS6HO1jFZ0Bx9oYPXaIatVVDPBqImfsM8AqJs8MscTTVVmlxMPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdV2axPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DBAC4CED6;
	Mon, 13 Jan 2025 18:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793393;
	bh=HbtvBeIcZy2P32mTLCcMuGA1L+t+DPjp5Ry6smyZ6KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fdV2axPrlTMzZlwNXgJjfDTwMnp1wrpT2ykuPgY3jIKymkjj30V/HChrtvgIH8cPl
	 UjQjKy/xbMt9XE1y9I/jwFaEYeJpSIdhYGpsKjoSOaEoAmzhyi457U4oPR0WJ7GkNe
	 ftoXRkrtia1ZwTOxy6LqqtkM8C+qSGjnR0FU+N2+5bIC9fR+fSW/dr3xo0pIIb85UO
	 zBnseMAPcpqJhUb78+Jp5dpUj2QXN6TrxueYobHaEabGerywgc2EEk5tuxr48YKbZH
	 txhuxU+lvdnQqKwhK0dtfH4QA4qrCoMXfw7mpk80CAI0mF0/68+YlHvWaJ9vR+8Ek2
	 J9QqMPpfELu3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.cz,
	ak@linux.intel.com,
	kees@kernel.org,
	arnd@arndb.de
Subject: [PATCH AUTOSEL 5.10 5/5] poll_wait: add mb() to fix theoretical race between waitqueue_active() and .poll()
Date: Mon, 13 Jan 2025 13:36:19 -0500
Message-Id: <20250113183619.1784510-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183619.1784510-1-sashal@kernel.org>
References: <20250113183619.1784510-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.233
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
index 7e0fdcf905d2..a4af5e14dffe 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -43,8 +43,16 @@ typedef struct poll_table_struct {
 
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


