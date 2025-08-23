Return-Path: <stable+bounces-172602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A48B32907
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 16:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3459F3B02CB
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 14:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CC0253944;
	Sat, 23 Aug 2025 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTuoiCI/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565AA191F9C
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755958496; cv=none; b=t22ObJx8pfaMDIkkAwtmaZvQo3AH7TL4E3v5yXzV9sTsf/qtAeV8U8rGm6mFRzChoj5Ktkbly6F+7+kpiRmRQDmolx9NRClH1DwHrBV3NkPHQE7X/K5zwSLKMp1c1AGA8lVcKiQByz9/XYd325SdiDN+avVHXpquU2E6VLi4tVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755958496; c=relaxed/simple;
	bh=OL8xfYTk+VU3iAEehQpStJgKuO3AdqynF9Ssg4yNODk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgkJINBO45QpnL1RehOTUfm9BOthmAjRa7hVkw/K4NxZlTKUk4U59Lv92P1nqqf0Of2jXL0JNUvxk/uOEJQcQZV887BjgLvNrjHzAnQFpPEQ4zxhOXxPpry6IEksudLMkVdSH5ey2KwuTWF4nZ/h+AbtOReDjlbOowUQRGcq+UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTuoiCI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2B7C4CEE7;
	Sat, 23 Aug 2025 14:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755958494;
	bh=OL8xfYTk+VU3iAEehQpStJgKuO3AdqynF9Ssg4yNODk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WTuoiCI/1s+8mZSpXa7OHubnelvE0jOT9+Ux5Cfq5p4RkCSCUaIKNFmow9PjmaRmf
	 SzJnEI87azZEgTSexhis9We8H6KIKjteH/bVC8t3y+H8n+ac9QETS9NW7S0IypLnp3
	 lI+7WwIwQcF6DgKhy0iv+T+U5dRDPaQaBm6IWJisZRmO0YO9nnWVmc31/xhzaHZ7Gv
	 LLOvTRs9UeJkx33LxIgd5Wm6yKvribviQtX3A4QANfjwA2tvwOW9/8fw2s+Etl3Ae0
	 OH2qlQVuVFm3NuTkG8REMfPC4oLaTahrXvbeyMJYQBHn2aG0EbJGCZcVGGfdEjepsg
	 N/a1FA57pWSsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <geliang@kernel.org>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mptcp: remove duplicate sk_reset_timer call
Date: Sat, 23 Aug 2025 10:14:52 -0400
Message-ID: <20250823141452.2197599-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082229-perch-unusable-f355@gregkh>
References: <2025082229-perch-unusable-f355@gregkh>
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
index f7257de37bd0..951928c69b44 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -373,9 +373,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
-		sk_reset_timer(sk, &add_entry->add_timer,
-			       jiffies + mptcp_get_add_addr_timeout(net));
-		return true;
+		goto reset_timer;
 	}
 
 	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
@@ -389,6 +387,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+reset_timer:
 	sk_reset_timer(sk, &add_entry->add_timer,
 		       jiffies + mptcp_get_add_addr_timeout(net));
 
-- 
2.50.1


