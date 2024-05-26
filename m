Return-Path: <stable+bounces-46251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066338CF3D3
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 11:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E590B2204F
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 09:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFEE132818;
	Sun, 26 May 2024 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SW1UUKKN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0AD132C16;
	Sun, 26 May 2024 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716638; cv=none; b=ibdmU3G8Cjc2qsQkVn2oZiAofnb/QzMqTr2MwqqVlbj7dQ4OLiqbmyMt4qeMCvUo3csgBJ9gZU7s7XmQ5Jgy2sxcCwhlwHN4q1S17IZ4oNeM48VnsvtrSM97hc119GUv5gPyCJr+M4vnHS736XhoTEJ0nH7Ol9daQISy0TV0tDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716638; c=relaxed/simple;
	bh=bXW37V1Flhx5xKq+9jOYUj5LIwd5KNR2wByg+MPa6WY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UHw1xcRQAb7P6FpjFk2gzZjA8pRBClEi/kMMU83bPSRGR8oCieWLZ8DQjaVgs3LKDpzZxRE381Q26e9EbwP0QT7sSwDUI9dtQ0FA6aBZQtIeqWJposFccBwi3NeCgfEfdgzU1TvMkum/y/TSAB/sGGV6vIGoLa6NPdA4jIzovDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SW1UUKKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5F3C2BD10;
	Sun, 26 May 2024 09:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716638;
	bh=bXW37V1Flhx5xKq+9jOYUj5LIwd5KNR2wByg+MPa6WY=;
	h=From:To:Cc:Subject:Date:From;
	b=SW1UUKKNhtnTEvIMh7fV0vi11q2PwNUAxZkHQlWcz7Jqc7f6F0eEAXi002RvzjEO8
	 StC79IF2IfzOpZv2MP6TIGlizlEMBHtU53WVKtMtFFha5IjLqSIQGNcMlOAPx+hhuh
	 AEFv/okm7ji4bn/N7Na4SqHxKE/kXM/553t49tCeHyIwfCcJiA2XROW3GCkWeur3qN
	 Z4eQDLVHQDAN2V5nFA7UE1KgfH2TKUh5bEXVWMnQpNnRC5utAWBGLxfCVAcf4DodEB
	 qTREpr7IuwaQJOzcuXLll0lxpQrRe7FcQ56RKY9EQjMRDTAwG8F1Vfq/l8rbGqxlqF
	 N8DTCKUTfrY9g==
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
Subject: [PATCH AUTOSEL 4.19] rcutorture: Fix rcu_torture_one_read() pipe_count overflow comment
Date: Sun, 26 May 2024 05:43:55 -0400
Message-ID: <20240526094355.3413996-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.314
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
index 0b7af7e2bcbb1..8986ef3a95888 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1334,7 +1334,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 	preempt_disable();
 	pipe_count = p->rtort_pipe_count;
 	if (pipe_count > RCU_TORTURE_PIPE_LEN) {
-		/* Should not happen, but... */
+		// Should not happen in a correct RCU implementation,
+		// happens quite often for torture_type=busted.
 		pipe_count = RCU_TORTURE_PIPE_LEN;
 	}
 	completed = cur_ops->get_gp_seq();
-- 
2.43.0


