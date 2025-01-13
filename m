Return-Path: <stable+bounces-108515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F187FA0C076
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 19:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716C8163612
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 18:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4825F21E0A6;
	Mon, 13 Jan 2025 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjHQprCl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0602C21D5A4;
	Mon, 13 Jan 2025 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793379; cv=none; b=LNRV7BPDTsg69wyDMMyZ0WD5oUEGCaDLcRTURgMmWizyafhr94abC1oauC9Bj7HDNLjDs9DTq/mNrPZTmGG+B9pX+DGR/IozU7iKyJW5F8K9pzDUpAk4j2fnmXqTbS5zpolSHQBjwx4W6dhMNumxvrhIpJUcAEjU7f27ukaVYJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793379; c=relaxed/simple;
	bh=HbtvBeIcZy2P32mTLCcMuGA1L+t+DPjp5Ry6smyZ6KQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oY3B6ReqZwc8b9tps0/Vbsi/CQBe3b6DMQStK73eyrLFGkrCr7qeuNEAaV8sXmM0SFCixJp5/i4f1B5DyIInDGX/7kXffyTTQZQxBmcuQBHDIwqfk30+PnQTrP3pM6lr6k5cLHYShK+NClpkFP9gpgLq3SKGaP1Qt7NGUZWKPoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjHQprCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FC0C4CED6;
	Mon, 13 Jan 2025 18:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793378;
	bh=HbtvBeIcZy2P32mTLCcMuGA1L+t+DPjp5Ry6smyZ6KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CjHQprClDk3P2QobjgP0cQnm7/JcfkmyEw2KG3R1DspEADOtLHqPhBiMOvhBqJm2G
	 nT16WhRBgai2WTAbEjkcm8hW2NrLMbdjxIF9XvkdSFwFfFtVzxzpQnl7LRGDmTssWp
	 QY58XttXPQu3D2RXZSJr5uhEbiWaA0HPCUXL8jmXPNu1giiG9lB3swepM5GpI1D00U
	 G5QOpOucQdCwgW6ICQT4Jm+FLCPx4E5qXwOo4tI+F4uqgFhQ08Ek7lJcxU/RKFlKBv
	 GlwHygxTwxBg5z6dTStessgho4/jQdKawP31ILtKVwCPykxkqa0MF6jffCmCKdbvmN
	 GZPWv1yAKkl7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ak@linux.intel.com,
	jack@suse.cz,
	kees@kernel.org,
	arnd@arndb.de
Subject: [PATCH AUTOSEL 5.15 6/6] poll_wait: add mb() to fix theoretical race between waitqueue_active() and .poll()
Date: Mon, 13 Jan 2025 13:36:00 -0500
Message-Id: <20250113183601.1784402-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183601.1784402-1-sashal@kernel.org>
References: <20250113183601.1784402-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.176
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


