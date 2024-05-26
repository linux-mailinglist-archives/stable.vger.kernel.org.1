Return-Path: <stable+bounces-46224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4F68CF38D
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 11:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3744F281DC7
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 09:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752CC7FBD0;
	Sun, 26 May 2024 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVxV+VeH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3C7C08F;
	Sun, 26 May 2024 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716583; cv=none; b=M5yqcK2fhjYJeKQYZkHJMdOsNaikS4nl3mHJQERPJyXerYDSUAmurYuLyVaAF0EIQtOLRheAUwqdo4ED9y0IUJWz6ZF73p2b1P4MhPz6gEaPKhLaFqa0zEbgbZu6UfeG1se0wKMHO5Eb05KGZLHCPQN7yuNvL9aBBp6J41TuspE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716583; c=relaxed/simple;
	bh=sXseDOvVUdSHtWU/fS7YvS0C0q5Z1V5Iz1T7PcKEaqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONqKfLl0PsagoCNjXULRFil41CAws0kOhm+Fp5HsIjk3zkuXKY94kXZuciABMn7D/cMNp5ydKxj3LAvgUNOMH1ab0SqhYKeq1vhJvHwTBCJiJzGW1nSU02DKoBg7l1IYUmtzC29nKt/Nc9DzITrs5cZFaZmsLITDnqhN0gackLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVxV+VeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787D7C32781;
	Sun, 26 May 2024 09:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716582;
	bh=sXseDOvVUdSHtWU/fS7YvS0C0q5Z1V5Iz1T7PcKEaqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVxV+VeHHR+5olarp9l9fBmJLinWVa+z4KkvZyLG1G6xNpLn9nTL32LKh60LKOGb8
	 xLolFXfh6C2dZIo7pqXI7J5wNnmZ1epdMM3789dCMIGkKaclTde/KLhU3zgX+4xkxu
	 ScVh9gpwMUuo8uXZQEzmhqzaebE1YdkZnVcj445/wP7FJD+HkBSuiBDpCjf5NWQC9Z
	 xOex/IFnKMX/ipfa+iyVXZiq1MI7dK757Su/RtZCh4PGUyWTHjYniWKbas8bnMj42u
	 fyV/xYIUIWxuqYyn4Ua7Jrw2UDQ+3pqfZNO86B8pGc2BnYDqxc6eZAE3UoytfSfVJL
	 koGYU6WI5OSfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	dave@stgolabs.net,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	boqun.feng@gmail.com,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/11] rcutorture: Fix rcu_torture_one_read() pipe_count overflow comment
Date: Sun, 26 May 2024 05:42:45 -0400
Message-ID: <20240526094251.3413178-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094251.3413178-1-sashal@kernel.org>
References: <20240526094251.3413178-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.31
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 8b9b443fa860276822b25057cb3ff3b28734dec0 ]

The "pipe_count > RCU_TORTURE_PIPE_LEN" check has a comment saying "Should
not happen, but...".  This is only true when testing an RCU whose grace
periods are always long enough.  This commit therefore fixes this comment.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/lkml/CAHk-=wi7rJ-eGq+xaxVfzFEgbL9tdf6Kc8Z89rCpfcQOKm74Tw@mail.gmail.com/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ade42d6a9d9b6..eb40c1f63a8b1 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1992,7 +1992,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	preempt_disable();
 	pipe_count = READ_ONCE(p->rtort_pipe_count);
 	if (pipe_count > RCU_TORTURE_PIPE_LEN) {
-		/* Should not happen, but... */
+		// Should not happen in a correct RCU implementation,
+		// happens quite often for torture_type=busted.
 		pipe_count = RCU_TORTURE_PIPE_LEN;
 	}
 	completed = cur_ops->get_gp_seq();
-- 
2.43.0


