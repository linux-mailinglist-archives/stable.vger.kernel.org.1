Return-Path: <stable+bounces-77447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6C0985D60
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25FB21F27C51
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812111E0B95;
	Wed, 25 Sep 2024 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8ke0qiN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5E51E0B64;
	Wed, 25 Sep 2024 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265803; cv=none; b=ZFFRFIkiYfH8E4lIfUU0h13DmsE2OyIhdqqigdySJQ27+7qmwct0tg7j4hKoirkKLJ0GLt1/DK+Hs+ipr1zPaUj7Kx8u82zw8qymhD1kznakrBimZfEKbgSFa+5bUE7ouN3LzPUKTlfje5+4A0P81Xdx5h70D0dhKzJ2HqSlr7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265803; c=relaxed/simple;
	bh=qnV+lX6Aqcz0MQ/9o7UjdXSthWFMVYmvUmCg9f1w+iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpWDTOaqN+0zbybFrVviyLp+479DYOMyATLMbTQf2MBmHqfbf2tCkn9brqUW5SVKy1y5MDD3dCTS86Li9OYfnDJzzXZKhCGuHkuDjHUuj6hHCDTbcwM+aD99tLUJkCt0FEJT7KZJ6VEBbSBWRw92o1Oy59EE0+smvkVCsE2uwvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8ke0qiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF6BC4CED0;
	Wed, 25 Sep 2024 12:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265802;
	bh=qnV+lX6Aqcz0MQ/9o7UjdXSthWFMVYmvUmCg9f1w+iU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s8ke0qiNf9sN/Qp4/WLOY5pgY6xObp7cuOUhvl8jtzm390hTY4Ew6l7xvjiyGGP2T
	 Yvp5ZxjA7uyuzTEKW2MwgGuiyN//5jJTr/g35YF1UuQRhVCznpg15z1ncm42J20PTy
	 4zmJJdNPwq86lUjZHhKjVm/elmhGFcVEGy5YEzGknKisVdURZ3iehVdDt0y6qwWqQ1
	 1hiX3we29vczJQlRsXjKAjU1uqabRdOqpjPQ47EOetaLCFkgqj7BZrVY4n4WeMXSwh
	 uGPkEsqLnTQjV9vKrIqvSobqdoq6tU9WhQUughaV4Z8hmDduiKtjc8ho83d1umV4+Y
	 6xgRqZNY5FLTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dave@stgolabs.net,
	josh@joshtriplett.org,
	frederic@kernel.org,
	joel@joelfernandes.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 102/197] rcuscale: Provide clear error when async specified without primitives
Date: Wed, 25 Sep 2024 07:52:01 -0400
Message-ID: <20240925115823.1303019-102-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 11377947b5861fa59bf77c827e1dd7c081842cc9 ]

Currently, if the rcuscale module's async module parameter is specified
for RCU implementations that do not have async primitives such as RCU
Tasks Rude (which now lacks a call_rcu_tasks_rude() function), there
will be a series of splats due to calls to a NULL pointer.  This commit
therefore warns of this situation, but switches to non-async testing.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcuscale.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 8db4fedaaa1eb..a5806baa1a2a8 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -498,7 +498,7 @@ rcu_scale_writer(void *arg)
 			schedule_timeout_idle(torture_random(&tr) % writer_holdoff_jiffies + 1);
 		wdp = &wdpp[i];
 		*wdp = ktime_get_mono_fast_ns();
-		if (gp_async) {
+		if (gp_async && !WARN_ON_ONCE(!cur_ops->async)) {
 retry:
 			if (!rhp)
 				rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
@@ -554,7 +554,7 @@ rcu_scale_writer(void *arg)
 			i++;
 		rcu_scale_wait_shutdown();
 	} while (!torture_must_stop());
-	if (gp_async) {
+	if (gp_async && cur_ops->async) {
 		cur_ops->gp_barrier();
 	}
 	writer_n_durations[me] = i_max + 1;
-- 
2.43.0


