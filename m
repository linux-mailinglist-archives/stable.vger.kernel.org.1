Return-Path: <stable+bounces-141479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 098ECAAB3DA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5681A1BA74C7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B1733EF97;
	Tue,  6 May 2025 00:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaAj8c3m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12A52EC001;
	Mon,  5 May 2025 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486428; cv=none; b=HUExbS/yQ6l4wDCXCUXs15ySNJFbx91XN6sAT7uzpnOFkSFO44n4eRrsIlaFknOIRtOGBc1LHE7U2U1QBAvONJFdQONa7iVdFzz/z6BtjRNZy9z/YIEtTyFf22m27dsb2xWAhAX5sn0yiKxOhw4N9Td+p3Pr+amHXs0GvG/pVcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486428; c=relaxed/simple;
	bh=H9fBNf2WkO9vQdBrY6Y2YkfbryWz7lwKy+BWtT18YA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zhwl3K5InwCfHvqBy4XKyMnpZX/JpNu7SmWYwyORIOeVBkMnfvwDEP+0q1Yey255n0ItacP+4jFiuEBbD5NR58TuAez87ebdk9LakEy+3GrZwecMVuDIvxZ0fay1DLAFYvaolRMmNU2Ihe10hAsbkjxgrqeCsueHWAxAROhttUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaAj8c3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7ABC4CEE4;
	Mon,  5 May 2025 23:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486427;
	bh=H9fBNf2WkO9vQdBrY6Y2YkfbryWz7lwKy+BWtT18YA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IaAj8c3mIUTNEZ494AZtR6vavd8UDWvZLEOO5aUO9bjogoty/5eRhtOkGofagzawv
	 zVKGyV9x+uReQ4BYQDdNzNfrgO/4rMIf5p8Hr2TDl+msfnX+I9heOtK8rmfYO52aWA
	 jOXKOdrSi+2D+qTuTUoZgH3G1rwAK2F6UAEV0YbFYyGxtwJ/S7rEucahfhWwuIYO1T
	 4QYM4NNB61dA3HNMUCXANIHIFZ83kKPUv2yCKZZjImTaGM3/ibp+b5vfjuDA6ZYcmg
	 ZnvNZ3HZBnDZh01iIDg5iQNxc6pbEA2jzBS5ZeC4/vwbsO60bxVjW/ZHg6jvtDM306
	 ZTsq57txmmZQA==
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
Subject: [PATCH AUTOSEL 6.1 021/212] exit: fix the usage of delay_group_leader->exit_code in do_notify_parent() and pidfs_exit()
Date: Mon,  5 May 2025 19:03:13 -0400
Message-Id: <20250505230624.2692522-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 156283b3c1bf6..49e4792405008 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -263,6 +263,9 @@ void release_task(struct task_struct *p)
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


