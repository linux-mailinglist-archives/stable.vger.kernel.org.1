Return-Path: <stable+bounces-46246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D508CF3C7
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 11:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1181F21B98
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 09:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C259131724;
	Sun, 26 May 2024 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzE+2pX5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC32D1311BE;
	Sun, 26 May 2024 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716627; cv=none; b=UU0vErVusnJbshp3waPbBRU/OK1LyrNDu1RB+6ggDMuKc4ePJhC9U4vKKaX70CGXf4Z/z2FdBRrPjxuYyFvnW3fLgm9ZeFp2w/eeeli8Dfc0HvmNRhfUil3Jbp7jxU+171e28x4BBjmdtsl8s4nsGfsuk5BqIBv9wuaYS/0lIMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716627; c=relaxed/simple;
	bh=XaEGA68BUUujn4yR6tf6QVt67bABjq9zz5jcwlYFAFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFCNomnBsZUC3uGWvnEcmsaLG60o3SNOzqyydB7Kkzw/eHNEL+wMjb23kaaqvZIe5cEcJI3Awf8NM0U5Rure762XxdcM3u7FccsJehwp47s7uPRAQhEhZN/I5SR/3EQ4JxXHMrijluK8LgIiNrPI9uIwTWAf7cMylgxVUK3c+1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzE+2pX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680C9C32781;
	Sun, 26 May 2024 09:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716626;
	bh=XaEGA68BUUujn4yR6tf6QVt67bABjq9zz5jcwlYFAFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PzE+2pX50pbNKMYlI4/gVlM0ykPVI3t3yKQMy8fsEHTZLBtoPLLU5PbVXamR4WAql
	 WRUZ8woSZCDmQXGTkXx4qxj5jcSRLR/XbfmAJPM66htClY13oiyrigH+Adcr0pC4gc
	 AF8b5tpeTsg4YVdsLq5/xbGS2H4BtEfSSWM9WDWmj9Hhw3mihik/uXcAiU/YH0vebV
	 Suk8AWZW3ZzYkeepPlS1i/2j5OM6mVnbKIP8X4gtDM7Eg3d7HQaCiZcfmZgvL3mnyw
	 rHL6ojqeMP9j+tTI9LchKcDgd/oSFfEiN4sKQFikpQK/RmrRNGlUbNj63u6JWZUkCo
	 AlbwtUMzeEZPg==
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
Subject: [PATCH AUTOSEL 5.10 2/5] rcutorture: Fix rcu_torture_one_read() pipe_count overflow comment
Date: Sun, 26 May 2024 05:43:38 -0400
Message-ID: <20240526094342.3413841-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094342.3413841-1-sashal@kernel.org>
References: <20240526094342.3413841-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.217
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
index 6c1aea48a79a1..c413eb4a95667 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1407,7 +1407,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
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


