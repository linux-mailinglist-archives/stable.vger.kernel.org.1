Return-Path: <stable+bounces-77217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1E1985A87
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 622EAB26640
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386CE1B6538;
	Wed, 25 Sep 2024 11:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eO5RZlyL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E621B6533;
	Wed, 25 Sep 2024 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264546; cv=none; b=E5QOdspudnM+F39Ryw9zfiRrIuR68trkpIxH1yHEsfpAuWSovP2caoSPwt+N6FvKCPyK8bvvh7IemiBgc1DD+7AXOmafoYd0y2yyBNb4e+6NSdMDHxq6YAdRepnzzBPNcSAo3FqTdtX64EKufiKGvKbdHQi8RxMku0jfPdXW4ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264546; c=relaxed/simple;
	bh=BoXrkVwWiqMD3qz24Nmzym9K7iKNFA5tr8OUVjQN9eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDyunoti5Via1SiU41rDniAWZgVtoLG7rGmTqG4t2TdDEr6mga+UgJbEwKd0xCDjxS5VTzBBwcsJYIf3ba9hQdb5K/588qN3+X77hUpOSBt8cEHQ/4tcu2HTJ8I5vb/nC1jI/tEcs/1wzks5xVOiqDWJX+JyEpX5jFOHQ0c7s7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eO5RZlyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEBEC4CECD;
	Wed, 25 Sep 2024 11:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264545;
	bh=BoXrkVwWiqMD3qz24Nmzym9K7iKNFA5tr8OUVjQN9eA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eO5RZlyLqAAXnqDtplw6pzxTIuT30QUNG5Ooa5msxmRZxu5Y3kWJWKNP8yKoh6adS
	 FduE011CqlEKN8T4gqdC4mscmPV/0umrZRWBE+HwnxrkVsrqOo7w8aQdEDch9KSqBC
	 X5F3l5H5xhuT3y6qhpS8SkHrRH454X7r4ZIy2woBNf1e43Ye1QC0MsYJ8ztWpQKYxN
	 x0EmVKbRtg3mbWqu93E3t/XFwEhHA3gyCqOD6jb2S+SfqazywerLqE+0RUr2cEse1E
	 whv6GQEnAuOh6uOKJqDR5xY/6GuB81emSSgK660ivgmsVAIldv8OU8XFfE2trXyDDf
	 t+sIAX5WGmMYw==
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
Subject: [PATCH AUTOSEL 6.11 119/244] rcuscale: Provide clear error when async specified without primitives
Date: Wed, 25 Sep 2024 07:25:40 -0400
Message-ID: <20240925113641.1297102-119-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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
index b53a9e8f5904f..f88c75b3cea3b 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -499,7 +499,7 @@ rcu_scale_writer(void *arg)
 			schedule_timeout_idle(torture_random(&tr) % writer_holdoff_jiffies + 1);
 		wdp = &wdpp[i];
 		*wdp = ktime_get_mono_fast_ns();
-		if (gp_async) {
+		if (gp_async && !WARN_ON_ONCE(!cur_ops->async)) {
 retry:
 			if (!rhp)
 				rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
@@ -555,7 +555,7 @@ rcu_scale_writer(void *arg)
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


