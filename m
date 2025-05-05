Return-Path: <stable+bounces-140658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F28AAAE6D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E9E17AF2C6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A263438E944;
	Mon,  5 May 2025 23:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYb8pVg8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D810136E0A3;
	Mon,  5 May 2025 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485848; cv=none; b=IUF48MREHRCErAk6JByY0WBJVu8XPAZR88mkm1IlKr1GWPchTmriFZ4b5Cd6xzYDEZGBQDf6/kXpbWomBsToML8f+KyvKMyNgG+VejWoPG9FRyXd4KWCgi/ZrG6r4O/RSKqkwPLLjPI3TEIW1OY0Cu+pdZ51XMFbHe9xGIRiQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485848; c=relaxed/simple;
	bh=BC5wgkzZrLUQpv9RRq6O9txRZ/0tSk0XyV13p3GKeGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AMjstFBbV/B4sRYNKNe8nCRvicVtBRWQYyIXXwJy1ko46RpHxQx97TtUkbHXVgJpR+YX4nZZKv62SICMh9815eR4AN0+tFzdhU4xJ6Aj38bJ+ieBlSQT5mATEZtsDturrBmSiZi4WiBUYHnbIJEZAeC8voHZu4t8KIlhVuMLrs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYb8pVg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB09C4CEE4;
	Mon,  5 May 2025 22:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485848;
	bh=BC5wgkzZrLUQpv9RRq6O9txRZ/0tSk0XyV13p3GKeGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qYb8pVg8/qsjxfK1lTkLmpMDw8hGcZsE3K+4rqHyXOsxG234C8sPBj7Ui2bPZH3KO
	 wrAO2dOb4W38YS4t8wylzYNPAJV7yEpSf5Y0N2LxO1/xdjFWUXJqqAEh3ZR8GkQm9O
	 fdyDvAZKY8uVNBNUAuFVCqYXXkd/go+DQSn4Q9Pa0GaOzscQU+FIL35/kuThfv29xp
	 vtdEplV00Ez24Yf0e+BSlbPrLku47eVqe+ksOIJPCvhZzK//RsPf7c4NnZPzIdu3lK
	 eUjLTw924Xmlyv51qQBkLgylaulJPQ1SD1Vl5ABNt+Gc99yad+BOCGPhwgwSTwLnvX
	 YqxBD6bZyFrFw==
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
Subject: [PATCH AUTOSEL 6.6 027/294] exit: fix the usage of delay_group_leader->exit_code in do_notify_parent() and pidfs_exit()
Date: Mon,  5 May 2025 18:52:07 -0400
Message-Id: <20250505225634.2688578-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 3540b2c9b1b6a..1b7257c12cb10 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -264,6 +264,9 @@ void release_task(struct task_struct *p)
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


