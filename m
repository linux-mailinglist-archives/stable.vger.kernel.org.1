Return-Path: <stable+bounces-172598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C84A2B328EC
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E05BA05B6C
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 13:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A301DE4F6;
	Sat, 23 Aug 2025 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTQIicU5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F641C6FE9
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755957217; cv=none; b=TnCPJo89ms4PmS0RASoDkNmLeicIjsbJtkEQUpEPXDdyxTfWDGM/F4jlFmkwIYSZlXdDaEkx5lUWjbgQAmR9t/SyxY7RwCiSK4LMtRvI4wUfDkmbA3owxbQHPzTyUAgwnKpGbwzjmpvnf7sUhLbX4mS/w+3ZkxpM/N70CxYPwoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755957217; c=relaxed/simple;
	bh=7VCUPHRM5yr0HQk/mBt/ETyA7YKAz4gh9Eo45YfQxos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ND577yJDDZ6A4Chhume/fdhk448/W9QoN2xeAYl1KgQSdUPznSe8YTXD5UMUEJtTyz8B8BKkmtRQ76JZ9RBbdy+yxD3VTC71DRvjfkTlB8JZY+9V6w3fratOAANO0Cvl40DaiR1HckVgAuLxbP6KEtg3U+Jguq+RLp5Nb7dcBts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTQIicU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCA9C4CEE7;
	Sat, 23 Aug 2025 13:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755957216;
	bh=7VCUPHRM5yr0HQk/mBt/ETyA7YKAz4gh9Eo45YfQxos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aTQIicU5/Tf6MWGjhe4sjawNMz+cdhDuUR5uYTHRqF+ujnjKBdDHq6xKCHgyWZYMv
	 x5GS+PkkqC3uoDgMXVGCIWwS/2rdSG+YCc5q4W1GqltpaIPYiVPM4Stk+R6wu+R8TD
	 Qw/kXPKTWGyA/hg5iT8OP4MccrYIwb+IY1UG40NpImsFlAK2Q+4R281FJZguJkyN3j
	 A1LuhMH9KQBMql6E/VhsYrfHAeP/VgDPvNXPakjJhobdCSTd2DAIHjUXrPrnJISAGM
	 bCvodaVLuYhLe8vvlN2paU86oe/paj2J6PlGArbm2z6eoswzRVf5y1AI9Q9FIuAPaF
	 yT9SyxJnB7mxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <geliang@kernel.org>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mptcp: remove duplicate sk_reset_timer call
Date: Sat, 23 Aug 2025 09:53:31 -0400
Message-ID: <20250823135331.2151568-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082229-sly-caution-e57f@gregkh>
References: <2025082229-sly-caution-e57f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang@kernel.org>

[ Upstream commit 5d13349472ac8abcbcb94407969aa0fdc2e1f1be ]

sk_reset_timer() was called twice in mptcp_pm_alloc_anno_list.

Simplify the code by using a 'goto' statement to eliminate the
duplication.

Note that this is not a fix, but it will help backporting the following
patch. The same "Fixes" tag has been added for this reason.

Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-4-521fe9957892@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adjusted function location from pm.c to pm_netlink.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2a085ec5bfd0..fe1634e2780b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -372,9 +372,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
-		sk_reset_timer(sk, &add_entry->add_timer,
-			       jiffies + mptcp_get_add_addr_timeout(net));
-		return true;
+		goto reset_timer;
 	}
 
 	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
@@ -388,6 +386,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+reset_timer:
 	sk_reset_timer(sk, &add_entry->add_timer,
 		       jiffies + mptcp_get_add_addr_timeout(net));
 
-- 
2.50.1


