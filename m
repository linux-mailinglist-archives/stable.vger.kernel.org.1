Return-Path: <stable+bounces-108524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22956A0C092
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 19:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF651696A6
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 18:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBD7225406;
	Mon, 13 Jan 2025 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7chWYPz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9EC225403;
	Mon, 13 Jan 2025 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793406; cv=none; b=jtjw4CWAbW9VwbxvpLLvaZkmZmnKJUgKwhC23ApTVX6xj8b+lZC3zofJ8CotFNPO8j9uuTz6qxh5ATS1hh7S9jXk5jc4BX/WmAO12tayp7ltptBeXvjbB6kX1Qd+jSLTCZY2XfsejYNi9z5cJ6JtR7QfQWF5angjb4H7HdtiYMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793406; c=relaxed/simple;
	bh=HbtvBeIcZy2P32mTLCcMuGA1L+t+DPjp5Ry6smyZ6KQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=prt3Pt6Re6rMwPvmEKY1KimLTCt3vOifad1cHBkPW2/Cn6zW7L4I2rtP6BBH5xFxk8mND6c0b5CEWMBEumRao/RtktSotAI1DN1ZmOYT0qpHWR2F0jn4Znn3j4swD23cWV2JxcL4SkwkBoqDuM5SxetkRloZQw22TYE96RDtZkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7chWYPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A831C4CEE1;
	Mon, 13 Jan 2025 18:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793406;
	bh=HbtvBeIcZy2P32mTLCcMuGA1L+t+DPjp5Ry6smyZ6KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7chWYPzF1c4tBrE0gMDL2S5pT5mmoyE4nBrI41i9xGCqrDRudwuweBLWLjGM3M4x
	 PhcKVkriJfkdBWJhvJy1Yv4G9mm+VPMBcaSlZz93ubFAoQPh1DMSIdtnlu+HsbrlJY
	 YKATGi37r5kDfTj608xVBw19JlYm25rQBsSrVaQDyIqdid1p3HGX02Ba+ryXRXlEid
	 8+umLm3BSf93/DX05A3IR8BT2rC5f4kg8zal0fdupWM8tcrDx4sbA5gA7Y9MGeaxaX
	 xh+tccEF/M/PfK+rv1BXciwVUs6k0MpJXIda9ag3NF4JX3xZZdgN2QGnLbriPgGm+k
	 s6SlPkuP3RKBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kees@kernel.org,
	arnd@arndb.de,
	ak@linux.intel.com
Subject: [PATCH AUTOSEL 5.4 4/4] poll_wait: add mb() to fix theoretical race between waitqueue_active() and .poll()
Date: Mon, 13 Jan 2025 13:36:33 -0500
Message-Id: <20250113183633.1784590-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183633.1784590-1-sashal@kernel.org>
References: <20250113183633.1784590-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.289
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


