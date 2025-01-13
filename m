Return-Path: <stable+bounces-108489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC48A0C01E
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 19:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284B916A482
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 18:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9BB1FA8D3;
	Mon, 13 Jan 2025 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msPTIKoE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D821FA8C6;
	Mon, 13 Jan 2025 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793311; cv=none; b=U6PYwVY5wuIdJcH5I9ijOVgH6yCi9hiq//CvM6a2ty/wNPdJKmuqpc4M+E63diKl1zneeGJrX+lNg2KtWwXmqQqPnxsiAySYuY9BcxoGVUeIddkuiZWbgKTrAMKJLS8+kaavSNJd0/wWtEnW9wPSIzWtNTiknx5TrmkXHVloEKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793311; c=relaxed/simple;
	bh=n0Pf6qpGoYAXXTCIUxq4k5sAvt6d3JS46oA5bUdbivA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=faY3dMs2Ht50hZvuilkpx79TNllpUYoXT3EQPqVDmLXzuylJ4/tghnoX1tLmj30skHIB+TRgJ1dKvBWKKpMAt5Efgk3ZgzOaJ5xBgEQYUa89L8/ToznjEuZNsUgC9OgEO2CRWZEfgbhur75oZJHjwba5kvfM34wo9jp6URvkJTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msPTIKoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41536C4CEE2;
	Mon, 13 Jan 2025 18:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793311;
	bh=n0Pf6qpGoYAXXTCIUxq4k5sAvt6d3JS46oA5bUdbivA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=msPTIKoE/Njjr8HTPGv3mFs9NyrADg/SMUvz0urDTVb2l2ijyzCMGOckEyTdeAdPm
	 3+jIpGlS2hxqku++Pzdv2cUjHk1mfxVyaZWg/bplh7R4LldLEV6AoK5Bw9mPe1KJ4Q
	 juh3A4XnXjADiLYo1sePmxpwH9AbdOjv6jx1XpHz4g4Fo1MevArVd3tPhUIgxclLTZ
	 /hvpVDVAWPv//JToB0BNN9T66MXOEb0Yestzuf7e+sWRwzoaMYchP2Gh5dY2oT8edR
	 XfY2RWaeLerEmCoqM89Pp344mWCLOfvqQbvjhqIjSzVoA0uOJ+vfJOEtszeh3ssb4v
	 NoPchxvzfuQBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	arnd@arndb.de,
	kees@kernel.org,
	ak@linux.intel.com
Subject: [PATCH AUTOSEL 6.12 20/20] poll_wait: add mb() to fix theoretical race between waitqueue_active() and .poll()
Date: Mon, 13 Jan 2025 13:34:25 -0500
Message-Id: <20250113183425.1783715-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183425.1783715-1-sashal@kernel.org>
References: <20250113183425.1783715-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.9
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


