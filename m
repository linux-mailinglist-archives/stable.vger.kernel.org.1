Return-Path: <stable+bounces-46210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEFE8CF368
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 11:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3012820F1
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 09:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC49541214;
	Sun, 26 May 2024 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ/Sno7l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A560E405FC;
	Sun, 26 May 2024 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716555; cv=none; b=R+qznTtzY3oJaIDXzSLVqey3FuGwV0mjtCePfKE/SIA482ai48UY8zQaoAVzA4hOndMOS1bmw5PzdHU3YgHaOiDDvh3WqBcsRBuNz2uoHX0UVjR1PkGl+YmVqEJaiIcmkEUj+5UzfoipA/icCXpzPYtC0VMpQAPzFgrxMeHsEOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716555; c=relaxed/simple;
	bh=hnJ7mmUVfU+/2ZbWVFAQSjm6A/tPNpECoTwzkYlT9Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khANYQeTTZ3+nnb1TnJvCDHIYhuNw8Q5lXbu/EipmHJ3aPFw987G+QWmx0oxPTXHPWNJsU4THYV+4tsoqeXNWlIDrWV1SdZ80GMqozVWsu9huCYg9Wuu5SxoZUGjrkLK0BwKHH03G7e7FLl8QWPQvlvMI/W3tUCMBUhIrsTiqfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ/Sno7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDA6C32781;
	Sun, 26 May 2024 09:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716555;
	bh=hnJ7mmUVfU+/2ZbWVFAQSjm6A/tPNpECoTwzkYlT9Fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BQ/Sno7l3pkQ64YIaaaJUWygZmrIFfpnT2Af94BjLVa6p3nVAC9PRzIxly9oJ5Voq
	 Rt0uY2hKBOXMKmxBXmxI5ZxoYFpLNq5q4NqxQByb2O/BYVXxL9IL6a1sdnlMs4ivae
	 T9MW82V+7yRvm/0nogOmKo1bkRNCUPd+3Flk3JOzja4eo6/hBrxS76IC9bXkFHryja
	 JC9BEhsgxFHisg5i9Gyi4OiiPDo7IzkVhRWxV0Ot9rU2I5YXAqXwDT3In3n6NANuYV
	 zq+1APPJ5XKGriok0cls9fFZsUCodCKOISrbgNbMc0XYhg8Qw18CHD/jG1ysEpp8Ht
	 YXSJTXDfJ/k7g==
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
Subject: [PATCH AUTOSEL 6.8 07/14] rcutorture: Fix rcu_torture_one_read() pipe_count overflow comment
Date: Sun, 26 May 2024 05:42:12 -0400
Message-ID: <20240526094224.3412675-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094224.3412675-1-sashal@kernel.org>
References: <20240526094224.3412675-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.10
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
index 7567ca8e743ca..ade96c85b12ab 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1993,7 +1993,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
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


