Return-Path: <stable+bounces-46233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308898CF3A6
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 11:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616531C20314
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFE917BAE;
	Sun, 26 May 2024 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH9+0mHc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D0212CD8A;
	Sun, 26 May 2024 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716601; cv=none; b=hIS73FlxQgLQWvLbAroLHMiyfkpfJ4eDaHybbAVrDI5/ik5zIDPiAhUgG2rSBKLpSdC0lLUwVddXZegtq8XI5GjUr4xxnGHRKeuSf5f6/XwsKQ9rNvECfM8+R6xUfaVOVeYlui3DyZI6L6ZuxXCD6i+s1FOwYCUbLgxqYHm7Tu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716601; c=relaxed/simple;
	bh=/Umh3Vpg+Odt6mANn+D3jmTU6B7vl2HCHuDlBXmYHTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7tIMxP7vV7Y1QJI8czzZOTmR6k6mQ++P1iO+YoOGuMAu7wOwMovSGx1/mgB8nPRpoHdUV8Rd/4jOxRFfZC0RzZe9tLyopDbRnNitjPCXmfEzp+HrIzzGj5jJNNMFpiGY5qECfAK9rZVvbKVUSdMnzzT+ib95g4pJmp3R1t6SKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH9+0mHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B50CC32781;
	Sun, 26 May 2024 09:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716600;
	bh=/Umh3Vpg+Odt6mANn+D3jmTU6B7vl2HCHuDlBXmYHTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HH9+0mHcIPIIZpOwwdaR1jYuN4OpeeKwaKx+7XHFKrrFtbdUgbBT2O1Nm1qzts9FI
	 BerrSBujd8b0Rn/QUXFEBa2YNlBeXEYo+fiz9Jg16MPnNsG7BO3sxfX2ZC82j2TTbt
	 BKCvUyLBxZ6XhxyMfv4WOzSu/0WMyeXerMuLV/6Ii2SP+pLUOs4V7x6GRykSazsUVq
	 vKzocOnQ00V2+MbcLnwkF4jOhMx4nz6CqYrFktIST8K6oJ6tZsxWL8UWxBjOIHmjx/
	 sNB3UeG5UmxxTc3ogB34KYUtAZQNPU3jAt4S5PJspA8VV3EJVA5IzIiV8pRTf9INH3
	 ZbU7OSro7e5pQ==
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
Subject: [PATCH AUTOSEL 6.1 5/9] rcutorture: Fix rcu_torture_one_read() pipe_count overflow comment
Date: Sun, 26 May 2024 05:43:06 -0400
Message-ID: <20240526094312.3413460-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094312.3413460-1-sashal@kernel.org>
References: <20240526094312.3413460-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.91
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
index 503c2aa845a4a..2f6c52a863f2e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1946,7 +1946,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
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


