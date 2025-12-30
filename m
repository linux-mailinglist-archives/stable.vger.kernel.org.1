Return-Path: <stable+bounces-204204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 321A9CE9C43
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 14:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 004E830111A6
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 13:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6FA204583;
	Tue, 30 Dec 2025 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rni4lgu6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D331C1EEA5F
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767100807; cv=none; b=sc7QnTb+B4fc3kXxqvYEhbbH7lEh20bSks2LqKGtUYq8QObm9l+wCGn/zpp7YKPy+RuAglr/19tEtACVbpo5o/1JGPcsfjhlgpRetpUrgL8fxgtF4Thuskdq17AB40GvXxPrIfOB+ShGyRK7mDZn79nUEi2sZ7hZWvbdFUzBB7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767100807; c=relaxed/simple;
	bh=ytFkIGyIs6qcsD3qRuzam4ylaIrsjlJBvzYf3qM0zdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIhH5H3HW3aSG0s8ZzCHrzevNxP+LIeKK7yWllcYdIeFyYWFlPxJMZm5gmmKo5R1jiByeyLUYj6ynV5YAV6AI/AjWdfgjP1a7hqlA9f5VnvOX0p+pAWhAZ8PLgIgFlhFrg/zg2qV5vCCLtpyGh0+tf+7CIPpaschSiqmNbsigpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rni4lgu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B88C4CEFB;
	Tue, 30 Dec 2025 13:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767100807;
	bh=ytFkIGyIs6qcsD3qRuzam4ylaIrsjlJBvzYf3qM0zdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rni4lgu66uEM9FqlkzSA615hF0SmtxKNRJ4DphjupvYZ34Eha3Xa3OsdMzH3EU4ME
	 X4BILzT3dgeqT5CaR4VBMOLDFkiw5XuffL1UDCW3k/7MMUvOjgQsC57SlCzdMZVLXy
	 RrfkgrG5Fb2OPsj3uvsT3ieNkF1ZCe2JuOKLiFfyu1sq+i71Nk1Un8RosoSnc/0dyV
	 aknPWzHGxREmwRgF/AL5kTV1Qes0PT7rBPg9lwyrQ723UfPg5MDWwIh6KyoPbLpgXt
	 vbgLGdc5nP+GEAoGQE8+hH1WSLj0Jub4QTwTQC6hfQgcMeZyY5teiTwJLYAZxvjFAs
	 2dUSrabWLyqEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mptcp: avoid deadlock on fallback while reinjecting
Date: Tue, 30 Dec 2025 08:20:05 -0500
Message-ID: <20251230132005.2177978-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122942-stonework-habitant-a877@gregkh>
References: <2025122942-stonework-habitant-a877@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit ffb8c27b0539dd90262d1021488e7817fae57c42 ]

Jakub reported an MPTCP deadlock at fallback time:

 WARNING: possible recursive locking detected
 6.18.0-rc7-virtme #1 Not tainted
 --------------------------------------------
 mptcp_connect/20858 is trying to acquire lock:
 ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_try_fallback+0xd8/0x280

 but task is already holding lock:
 ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_retrans+0x352/0xaa0

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&msk->fallback_lock);
   lock(&msk->fallback_lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 3 locks held by mptcp_connect/20858:
  #0: ff1100001da18290 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg+0x114/0x1bc0
  #1: ff1100001db40fd0 (k-sk_lock-AF_INET#2){+.+.}-{0:0}, at: __mptcp_retrans+0x2cb/0xaa0
  #2: ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_retrans+0x352/0xaa0

 stack backtrace:
 CPU: 0 UID: 0 PID: 20858 Comm: mptcp_connect Not tainted 6.18.0-rc7-virtme #1 PREEMPT(full)
 Hardware name: Bochs, BIOS Bochs 01/01/2011
 Call Trace:
  <TASK>
  dump_stack_lvl+0x6f/0xa0
  print_deadlock_bug.cold+0xc0/0xcd
  validate_chain+0x2ff/0x5f0
  __lock_acquire+0x34c/0x740
  lock_acquire.part.0+0xbc/0x260
  _raw_spin_lock_bh+0x38/0x50
  __mptcp_try_fallback+0xd8/0x280
  mptcp_sendmsg_frag+0x16c2/0x3050
  __mptcp_retrans+0x421/0xaa0
  mptcp_release_cb+0x5aa/0xa70
  release_sock+0xab/0x1d0
  mptcp_sendmsg+0xd5b/0x1bc0
  sock_write_iter+0x281/0x4d0
  new_sync_write+0x3c5/0x6f0
  vfs_write+0x65e/0xbb0
  ksys_write+0x17e/0x200
  do_syscall_64+0xbb/0xfd0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 RIP: 0033:0x7fa5627cbc5e
 Code: 4d 89 d8 e8 14 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
 RSP: 002b:00007fff1fe14700 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fa5627cbc5e
 RDX: 0000000000001f9c RSI: 00007fff1fe16984 RDI: 0000000000000005
 RBP: 00007fff1fe14710 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff1fe16920
 R13: 0000000000002000 R14: 0000000000001f9c R15: 0000000000001f9c

The packet scheduler could attempt a reinjection after receiving an
MP_FAIL and before the infinite map has been transmitted, causing a
deadlock since MPTCP needs to do the reinjection atomically from WRT
fallback.

Address the issue explicitly avoiding the reinjection in the critical
scenario. Note that this is the only fallback critical section that
could potentially send packets and hit the double-lock.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/mptcp-dbg/results/412720/1-mptcp-join-sh/stderr
Fixes: f8a1d9b18c5e ("mptcp: make fallback action and fallback decision atomic")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251205-net-mptcp-misc-fixes-6-19-rc1-v1-4-9e4781a6c1b8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 10844f08752c..0d044ea1baeb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2715,9 +2715,15 @@ static void __mptcp_retrans(struct sock *sk)
 	info.sent = 0;
 	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
 
-	/* make the whole retrans decision, xmit, disallow fallback atomic */
+	/*
+	 * make the whole retrans decision, xmit, disallow
+	 * fallback atomic, note that we can't retrans even
+	 * when an infinite fallback is in progress, i.e. new
+	 * subflows are disallowed.
+	 */
 	spin_lock_bh(&msk->fallback_lock);
-	if (__mptcp_check_fallback(msk)) {
+	if (__mptcp_check_fallback(msk) ||
+	    !msk->allow_subflows) {
 		spin_unlock_bh(&msk->fallback_lock);
 		release_sock(ssk);
 		return;
-- 
2.51.0


