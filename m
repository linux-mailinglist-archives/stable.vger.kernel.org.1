Return-Path: <stable+bounces-141713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F7EAAB7E3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70903B6AE0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E3B34C99D;
	Tue,  6 May 2025 00:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouw3d8UJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6923B9713;
	Mon,  5 May 2025 23:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487327; cv=none; b=RYq1ukp5z2zrvU3wvzBfvyIXxBYDEnIYmELwgVcg2Eq36kt60p9hojWwDr10fAPW4I+T2KM5uMC3HN7f8gA66UGTYBicnD+2JAZG1ozTrz0yR4ZPq/g5mf5ykZIWJ2yvFoS+KVBhf6/P/mHZ+/vCrycbZqOW+34jgZWixXoowM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487327; c=relaxed/simple;
	bh=U0TwbD88pZSRao+uKN5cVvjVctGmavvj1FmStfO7D18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JplbD4pDoHz4PyOtnugNEsbEsSuJajtvMJiPwuZuB5gEZy87IqLWZPs9av8c6M0kfBVd3x7fQfjnB9baWp4qreZUCCqZSMcdfP6bLv47FGzOv1VIVSfsrsqy5fRcwJSIX9y98lSle6eP4IRTl+0Jr21dTj/7UFxLylp0cQGwl5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouw3d8UJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F63FC4CEE4;
	Mon,  5 May 2025 23:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487326;
	bh=U0TwbD88pZSRao+uKN5cVvjVctGmavvj1FmStfO7D18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ouw3d8UJiZkIaNUhLY/kNvzsKk5bLLL/ppUAYuEi8rjnuCA4+BRlTrnTOEuXJCXQk
	 CIg8Yd9NFrL1s50ITCWKKnllbDLDPk+cbweljvtom3Hv9HDWaUMZ8p9lhoBTV3T4e2
	 Wjz0GWd7UOPf89fNlKZnjQGbQb7uJt1sTZ4KdbYyG4OPgS5DH4tHK8dibkpprfVpLO
	 RUJy4xcuk5dvm5IR8zMhFVBWnwMKyVWP2qMi+vXqBIVDkr5IjsRmx3aAaqhNW8EeHI
	 Fst9lcHEHHaluWmYcsrwn5evM6qnOMTZMjmSWXgjf0/AjAIxqV+/OkIhgCLLWUDIvX
	 8nKhYEwnYJBig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	mjguzik@gmail.com,
	pasha.tatashin@soleen.com,
	alexjlzheng@tencent.com
Subject: [PATCH AUTOSEL 5.4 07/79] exit: fix the usage of delay_group_leader->exit_code in do_notify_parent() and pidfs_exit()
Date: Mon,  5 May 2025 19:20:39 -0400
Message-Id: <20250505232151.2698893-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit 9133607de37a4887c6f89ed937176a0a0c1ebb17 ]

Consider a process with a group leader L and a sub-thread T.
L does sys_exit(1), then T does sys_exit_group(2).

In this case wait_task_zombie(L) will notice SIGNAL_GROUP_EXIT and use
L->signal->group_exit_code, this is correct.

But, before that, do_notify_parent(L) called by release_task(T) will use
L->exit_code != L->signal->group_exit_code, and this is not consistent.
We don't really care, I think that nobody relies on the info which comes
with SIGCHLD, if nothing else SIGCHLD < SIGRTMIN can be queued only once.

But pidfs_exit() is more problematic, I think pidfs_exit_info->exit_code
should report ->group_exit_code in this case, just like wait_task_zombie().

TODO: with this change we can hopefully cleanup (or may be even kill) the
similar SIGNAL_GROUP_EXIT checks, at least in wait_task_zombie().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250324171941.GA13114@redhat.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/exit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/exit.c b/kernel/exit.c
index 56d3a099825fb..5015ecdda6d95 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -262,6 +262,9 @@ void release_task(struct task_struct *p)
 	leader = p->group_leader;
 	if (leader != p && thread_group_empty(leader)
 			&& leader->exit_state == EXIT_ZOMBIE) {
+		/* for pidfs_exit() and do_notify_parent() */
+		if (leader->signal->flags & SIGNAL_GROUP_EXIT)
+			leader->exit_code = leader->signal->group_exit_code;
 		/*
 		 * If we were the last child thread and the leader has
 		 * exited already, and the leader's parent ignores SIGCHLD,
-- 
2.39.5


