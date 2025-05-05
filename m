Return-Path: <stable+bounces-140983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8749AAAD46
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EC05A300C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382EC302247;
	Mon,  5 May 2025 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4Yl1fDJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE993392F93;
	Mon,  5 May 2025 23:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487126; cv=none; b=NZpgRvDDTxFwhY2jjU1X9sKvt9hZDEexEiSj+z0jrf1zM7iJlcsyjS2LdvK/hdzOVil8rgxRtGDBTl/1tkEWFH3VELYyOg+EYalJOX88YzKFls3eAVc00jBE4EsDUieqSwOAH5/99dQxJX0Jqzd+lyCl45F1J4T4Pn1kWrTYyVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487126; c=relaxed/simple;
	bh=1BSmrDs6dTVRT8K2+i9kol7+Sfem7R29/3HUUWM4/dU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gLoSZFHXfgadDXGni564KWEsLWydo37ovj/BGKbBhE36mnco4VWPUwU0B3ygkvwUWS0Sy3hILIGqyqbGQnLijRi/2V3xlKxoOxoUYnzgie5m3XNRO00Ik25dXqZ4aj/yg32ds61bPoPChbyLvEP28L2rDpVz2pft6a8hXvMQI4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4Yl1fDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1581CC4CEED;
	Mon,  5 May 2025 23:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487125;
	bh=1BSmrDs6dTVRT8K2+i9kol7+Sfem7R29/3HUUWM4/dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U4Yl1fDJdrTChclhoCy2X1iND9vax5Ba6yczLoZ/0uH49isiwD4sHFxXKoGe8QUBN
	 oP9a+gJ5v3+E3xrxOEdlxcdJCCz6C0YP/eWFhSKzi+DVzv3zrgpwxoUvQ5g1NgAdF3
	 +kM3dnUJE58Z9QHKyriQBvE1f87ihaOhXjrqMLkqvLtYH9lK+H44+Z3gwSKKAa5RYC
	 ZfNPcMPlo3xy+4Mc3505jZiDXJ9rhZHP/GKdqfF+Gnpo9t5B5vq02Ly+EqAdh8/77D
	 +J8PkbNCrRJzosvjiruM2ot4BuUtFmlL1E1G+TZqA4p/6kTUCh36HpXEG4ZG7P7yRI
	 hBzMbqez4xiaw==
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
	alexjlzheng@tencent.com,
	pasha.tatashin@soleen.com
Subject: [PATCH AUTOSEL 5.10 011/114] exit: fix the usage of delay_group_leader->exit_code in do_notify_parent() and pidfs_exit()
Date: Mon,  5 May 2025 19:16:34 -0400
Message-Id: <20250505231817.2697367-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index af9c8e794e4d7..05f682cfdd6a7 100644
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


