Return-Path: <stable+bounces-46250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEA48CF3D1
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 11:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A585BB21C5C
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 09:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528331327FE;
	Sun, 26 May 2024 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KV0WpSRz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC841327FC;
	Sun, 26 May 2024 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716635; cv=none; b=n1KuwVjfWVbBLP4MUtpTYBWPIsu4PS8htGvaw6MIeJuTYp9UzukDndmdr5CVlrkzVX+x7aaCHLiWuUHOgW08Tz63wMXRLCTKb5PaL53M/lyXiA+cMxQ6aHfkwTE5moR8YLDZ9IfUONXFTLms+cYKzl1VCP0roCRU2ryEXNqvGbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716635; c=relaxed/simple;
	bh=+1WSI6Am9V2JgdnGPquJH/MRGAEoUbgPpIB2ekCVDA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPIlZG3vIn2EaU3/ZLmx4uW6UU/8XnUboZiTQ35EzL3h8Y5WfVWhScpVIs/fqq3cdIPjXPmQhr8nwU907zFahx+D2ult7Dohu9xk/mgiL4Q+mKzVWviOgrl5lolSpq/jTX/rdIseodQHxGH4cgL5+LuXzn9G6Xo1thPbP4IR0CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KV0WpSRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E88C32782;
	Sun, 26 May 2024 09:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716634;
	bh=+1WSI6Am9V2JgdnGPquJH/MRGAEoUbgPpIB2ekCVDA4=;
	h=From:To:Cc:Subject:Date:From;
	b=KV0WpSRzsYcIQSLU6HrhKnCLTgcH4xMd0mCHCoRSfnU8eiyUdngfKcCrGLCkI/8yJ
	 Cg6MHbgllN/iGpHmEWsSAJTWSbxzYpioWfiWIegc/GKRH4TB4meMdvN6uLS9obUo75
	 JjH58cvEFCP/jR4irV6Kj+3GZBjZOo9v/whaKTsWkJUt/tnM9MMdHJZzlE4AFhZsmW
	 NXlt4kd1kv2J6lwVwS2PK2aYmMXDSxdvhHMHegQBl1qhYOHGZ5I+CcalZFgjPwnYmX
	 IDAourBmt0PyCGwcNB/x0H6zlyFrIr0u+EhqcscBQYZPumTWHgU5lJPJLiplx/Wkqn
	 bb7IeP5qV/7QQ==
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
Subject: [PATCH AUTOSEL 5.4] rcutorture: Fix rcu_torture_one_read() pipe_count overflow comment
Date: Sun, 26 May 2024 05:43:51 -0400
Message-ID: <20240526094352.3413964-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.276
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
index 3c9feca1eab17..aef4d01c4f61e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1291,7 +1291,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
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


