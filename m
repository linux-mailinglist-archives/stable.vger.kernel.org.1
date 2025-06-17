Return-Path: <stable+bounces-154303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF6BADD9C6
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C577D19E2980
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F1720B807;
	Tue, 17 Jun 2025 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lhkOSohf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225A42FA642;
	Tue, 17 Jun 2025 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178758; cv=none; b=Uk8/M6B0lATU4yueGtTUfp9KS0epbhkzB5xf3sZsl/tnfMEqLaP4IU5RKbgWar3YZgXYkpjttEBQ+Bvjk11K52QZk8MvYjuUXInjQz3jGXbWS0ZmdsT0uFsGqK3sTrUfH/Mqs4dCwp5PBhZOjjIdgWC35pUk/RjkGJzv6mtU2ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178758; c=relaxed/simple;
	bh=dghugeQD5Uv5n2e2BjTYobZbJy9utIEyUdCF3a+6yaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k98/BIdYTittetakXJWeJryLa37vSbVvvummBRTGEiQBfbLfKmmy4YMfIGOKcIDaexLSdb6RyJK0kSMFAa8vJKhWcJrYNSs9VdfT3hJz9KF5Bgn5w/tXWRhVk8v/Vlja4yKmG2d6lGEyu7XNqVAz5+lyxuaOQoxUMVkTc+Hasdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lhkOSohf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327A4C4CEE3;
	Tue, 17 Jun 2025 16:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178757;
	bh=dghugeQD5Uv5n2e2BjTYobZbJy9utIEyUdCF3a+6yaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lhkOSohf1VOuwFwppQibmsrsRbd1isvjGCrekpNpqneqjPGN3sp9nhYQTNcAEtd2g
	 2Ra2VxZzHeLfHzq8gaAAWeETCl6u3ZZtnlg1RBEV6war3L5qQiJq/MjYPO7MqIGbe9
	 HO8mUuyGrJZb/LpB7rRERwrQaWdk6tEYbOytlToA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 514/780] sched_ext: idle: Skip cross-node search with !CONFIG_NUMA
Date: Tue, 17 Jun 2025 17:23:42 +0200
Message-ID: <20250617152512.442749413@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrea Righi <arighi@nvidia.com>

[ Upstream commit 9960be72a54cf0e4d47abdd4cacd1278835a3bb4 ]

In the idle CPU selection logic, attempting cross-node searches adds
unnecessary complexity when CONFIG_NUMA is disabled.

Since there's no meaningful concept of nodes in this case, simplify the
logic by restricting the idle CPU search to the current node only.

Fixes: 48849271e6611 ("sched_ext: idle: Per-node idle cpumasks")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext_idle.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index e67a19a071c11..50b9f3af810d9 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -131,6 +131,7 @@ static s32 pick_idle_cpu_in_node(const struct cpumask *cpus_allowed, int node, u
 		goto retry;
 }
 
+#ifdef CONFIG_NUMA
 /*
  * Tracks nodes that have not yet been visited when searching for an idle
  * CPU across all available nodes.
@@ -179,6 +180,13 @@ static s32 pick_idle_cpu_from_online_nodes(const struct cpumask *cpus_allowed, i
 
 	return cpu;
 }
+#else
+static inline s32
+pick_idle_cpu_from_online_nodes(const struct cpumask *cpus_allowed, int node, u64 flags)
+{
+	return -EBUSY;
+}
+#endif
 
 /*
  * Find an idle CPU in the system, starting from @node.
-- 
2.39.5




