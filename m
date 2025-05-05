Return-Path: <stable+bounces-141595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B112AAB4B4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C04E4A6C16
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9052C4825E5;
	Tue,  6 May 2025 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+V0lyBk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3E72F2C6E;
	Mon,  5 May 2025 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486829; cv=none; b=gXsGAe5NT1VgGtk2siwJHzISpbyLFMxEqT1QCnQ1NQj76QXRAfXmJMrCEH6q2f/QpAPHtEOTUbD2UOWGWTrHY4vwtuq8sI134S+UUdyiip3J6r/JZ6nd3CaEZnFmQzt5ce/I+d4uTTy+0c0kbe898BWGITOIhPYp7JwGylJXYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486829; c=relaxed/simple;
	bh=wyshX/auvUOZ03jOCYc11Ffh1tm2QvlTLfd6fDYLhkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lKbu/bF2yv3d4PgCqslCE+dFKxP0qI7u0LRZL4N1Me2j/VPwAjpqAX7PYSZR8gJEBrU6f2jtuQhBxtkMCFm1uo0XY7Smn+4W7VkfC8TUh+Vvc+9V38SUoshOU7Yn+qxJYKPd1P/JRQL8Jj2PLMTNpEvfyAq04Ui0QJgNbB5g8Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+V0lyBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488D5C4CEE4;
	Mon,  5 May 2025 23:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486829;
	bh=wyshX/auvUOZ03jOCYc11Ffh1tm2QvlTLfd6fDYLhkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+V0lyBkM0vnhVKU9MtpFTJzXP2lf5nxrChz6P3F/oZbbka62zRSwlF66N4tMg9ne
	 R1tV8K4cBmBRzQ92iSkjNF/mubbSyGA4swtQ0A7rjn+y0TIlGY6lmvyFnS4pQZCwcs
	 zXoP2amYGhYWUNPbqOtlPrszA6WcFa36fP24Qb1J0It9W6guFAe8hbQORHGaP+N0CS
	 VeHtJIl/zMe3k/ddi5q5xrW9ef6TsogjnPYtNks1p+S3AqUf9jaZq4ASOdjsJ6RZUx
	 iDGXIkQtVIEfi7XrcjSFmFa4TW/LdmKOJj3jn1gobGNcY45LUxW7nTL3RpiJtqD87T
	 /46FO2d0AjkRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	mjguzik@gmail.com,
	alexjlzheng@tencent.com,
	pasha.tatashin@soleen.com
Subject: [PATCH AUTOSEL 5.15 012/153] exit: fix the usage of delay_group_leader->exit_code in do_notify_parent() and pidfs_exit()
Date: Mon,  5 May 2025 19:10:59 -0400
Message-Id: <20250505231320.2695319-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 890e5cb6799b0..04fc65f2b690d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -254,6 +254,9 @@ void release_task(struct task_struct *p)
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


