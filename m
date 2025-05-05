Return-Path: <stable+bounces-140432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6D9AAA8AC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586EB18917BC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAC32980B1;
	Mon,  5 May 2025 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPoWSvYH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A523351E8C;
	Mon,  5 May 2025 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484842; cv=none; b=gDEwN+X07AhC7MSDPEYSY5fYkFRnB54hXIfNiZf+dpBuPj9nwoewVSDkcAemQP4YLb8T0GcK4qKBAwN9kWvYYHS0q4IcF/s70tbs68uFLZeC/nJs9fUploVe672UqC5kt3sDgJkCB7C+zLM6+Iz45DpULTdy4TABSiJDz9LX9nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484842; c=relaxed/simple;
	bh=qA6MpgJTUB3aLiZe/+cSlVGQ5S9qsBkpUfOAbl1kWYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JR/6E5C0gFlm/afATSRpb17tbwVbUzVAkqr7c/3QrY+vMAgRPYTPzzDhP7HZMHXmW0+ISqqFZURgCLt3NMj/IMZw3bGaOehp97K/kto1c6N8U5HTuol0s2Wb/lJFsO9ayCqMTybb54GHfCS/upbsdhAiZyIpW3aL+dbsN7mzioc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPoWSvYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10C3C4CEED;
	Mon,  5 May 2025 22:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484840;
	bh=qA6MpgJTUB3aLiZe/+cSlVGQ5S9qsBkpUfOAbl1kWYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iPoWSvYHDxOwf63Jj9c1PQKFjCZ8HM0Nuk8UFnAkd04OMFhtKoQIM7caWonvkCpB6
	 WdZVT/Ru2croYy5DpW9/yO3aDKvD7gYs3GvS8navWvK8Wh44VzhlhnYV986v2yb5gF
	 9JljAxVMizs+SnYeqiOKt7ym3dD+Jl38dIU+Zi0l7w5hDfvl62Nr5C//C6V6cAvrvT
	 HzvIYX3xNRmaXcJFxzNzqr+asi/ag2P22AQMmpOZiqWudL51yReOT5BiV6W/nhKkzw
	 g6K37wBp/qC7WpKyHeSxxwyn4lQufRLXuC6Ipe5as8a+1sg5d7K2LX9H4/NDGd8wvS
	 xidSh8xKRUSAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	Liam.Howlett@Oracle.com,
	mjguzik@gmail.com,
	pasha.tatashin@soleen.com,
	alexjlzheng@tencent.com
Subject: [PATCH AUTOSEL 6.12 041/486] exit: fix the usage of delay_group_leader->exit_code in do_notify_parent() and pidfs_exit()
Date: Mon,  5 May 2025 18:31:57 -0400
Message-Id: <20250505223922.2682012-41-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 619f0014c33be..9d888f26bf784 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -266,6 +266,9 @@ void release_task(struct task_struct *p)
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


