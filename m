Return-Path: <stable+bounces-46240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A88B8CF3B8
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 11:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7FE1F21618
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 09:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D9C1304A7;
	Sun, 26 May 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCf3Ukl+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C208A13049F;
	Sun, 26 May 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716614; cv=none; b=OpcClcigd6hln3N/o711WuRX7ZDSp0nZLEuYymu/JkJxbTXljz2bH+zWerDZbPorXCizZva88F5EtcKih+aJNNtnyMbWWrvB6rzvh+tqOV69/XBYUHrPKGEwaHa5FeJjFfzFVlucrIa8fDuH6AK92AawYMQOUve5OvvsnBVaHCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716614; c=relaxed/simple;
	bh=T55+DPkc3PTOXL6KvirvL0sLE62EmSCCbw5DZnTAuZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EwRQ9i3Mgcf6xxzBwiY6J3MPPYhCdHj+BuR9Vmk3PaZruioH3jVZ3mHPka7xWABVI/Anvh3fwsxgZw+zHLeuzeh3/+lGMpZbbZBkC3WvkNnclCsXD4GLgHgF16MJuumYHFK8GG9Km76sZRqWsL++c6X/tGAGfXKE0vtQ4zraXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCf3Ukl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41757C32782;
	Sun, 26 May 2024 09:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716614;
	bh=T55+DPkc3PTOXL6KvirvL0sLE62EmSCCbw5DZnTAuZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VCf3Ukl+r/Gm9gHh6twmhDpEYfUaPuOqmc6VjpOJXhGBcM4IOEP+bwEGyULyrZ2AH
	 VZM3RRgipepomS3niwASZLoXZlOBg8wM8P9KpyLm7hy9pVGYRi1sy2zg15fX9+Lmy8
	 xq5E1lUA9OTG9LebTLPPlHxc4RY+HHsxzK5aEQ8Gn9u6ZeP0QiJUsbdnIWoMKhlxqQ
	 GUl6tVxDDWV2/XjwraZXtQVK3FS3R8cfzp/OayEHrXf9DK5N/OTL2+m4d5b4Ga7vdm
	 idYyddqGsVsH0qpLEMfL1o8jVWvsZm3vg7pZZ7DUhUhN8G4t79uTFaWHIao2mweajf
	 chVk1+CWgQ6HA==
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
Subject: [PATCH AUTOSEL 5.15 3/7] rcutorture: Fix rcu_torture_one_read() pipe_count overflow comment
Date: Sun, 26 May 2024 05:43:23 -0400
Message-ID: <20240526094329.3413652-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094329.3413652-1-sashal@kernel.org>
References: <20240526094329.3413652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.159
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
index d820ef615475b..82c6046db8a42 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1604,7 +1604,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
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


