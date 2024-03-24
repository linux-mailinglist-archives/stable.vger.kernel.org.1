Return-Path: <stable+bounces-31120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 875F6889AC7
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 11:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40021C336F0
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 10:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A79B1DF113;
	Mon, 25 Mar 2024 02:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0iAlah1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A292C1D2A9A;
	Sun, 24 Mar 2024 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320538; cv=none; b=sNscjdui/GB4EcaNewcRZkw5mz4Eovu9yWiZJM+K+XJ4AoUUfLENUPNTCeAGxshgY4gS0m6r8mJCiwj3jCk+CpxcMFL03JBzL+LDrtlW1fewk9qynDCSof9CndXqblI+u7uCbQ2th0hgbgAlKZmWCIJaohQHN5kKZcyIvCgvMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320538; c=relaxed/simple;
	bh=OMAk9UOGghL2sUqX40h2Jrbj1lwl32TZ1AeXnBhK4Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+u9JyDb3zyx/1VpW4d2lwt+AtUocVbNx33q0HwoF5qVkYoJjVQYR145bCdSfJTf2A0KCKE41WTe1iRZR/2Z/3IMdaIfpzNQ23KjpXEdDIky15Rr7h24daufrfHqS1ik4Tb3qO9wTSzH93rvyexa8TAXtEJ0mk1nFg9vq1qdIKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0iAlah1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82EDC43399;
	Sun, 24 Mar 2024 22:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320537;
	bh=OMAk9UOGghL2sUqX40h2Jrbj1lwl32TZ1AeXnBhK4Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B0iAlah1CQ2WQ6y4F6XWKUMiNr8nKJthtAfVz4UeEC/a3unvRZm8jfMZutLahJYKC
	 YoLMVWUQ1lfp1DiDxg1s02pBb7uTveYBTSgPVP3QPftLNh/dMjGtszUqh+EpiNt4VF
	 0iXw0fkIJ6N8yz3SeURMVH6q4SZvkHJTX4LBBCYe96SKx5XKQDyZE+WHPv6Ghelydu
	 tpslXlHkNUqUb/mFtJjEsU0Ux45nOZdz6AgDsrDo7nps1f3ih0ApPcFvY+u48DzF+F
	 DTO+SzABeaYkwfNxLWgEecyNxPHOY8SRPIC/9idrjc/Jw2ltnOXLm9AA0dY/DUkJHd
	 JcYTHMPNaXerg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 099/713] rcu/exp: Fix RCU expedited parallel grace period kworker allocation failure recovery
Date: Sun, 24 Mar 2024 18:37:05 -0400
Message-ID: <20240324224720.1345309-100-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit a636c5e6f8fc34be520277e69c7c6ee1d4fc1d17 ]

Under CONFIG_RCU_EXP_KTHREAD=y, the nodes initialization for expedited
grace periods is queued to a kworker. However if the allocation of that
kworker failed, the nodes initialization is performed synchronously by
the caller instead.

Now the check for kworker initialization failure relies on the kworker
pointer to be NULL while its value might actually encapsulate an
allocation failure error.

Make sure to handle this case.

Reviewed-by: Kalesh Singh <kaleshsingh@google.com>
Fixes: 9621fbee44df ("rcu: Move expedited grace period (GP) work to RT kthread_worker")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 157f3ca2a9b56..fc318477877ba 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4747,6 +4747,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
 	rcu_exp_par_gp_kworker = kthread_create_worker(0, par_gp_kworker_name);
 	if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
 		pr_err("Failed to create %s!\n", par_gp_kworker_name);
+		rcu_exp_par_gp_kworker = NULL;
 		kthread_destroy_worker(rcu_exp_gp_kworker);
 		return;
 	}
-- 
2.43.0


