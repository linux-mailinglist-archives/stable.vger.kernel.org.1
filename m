Return-Path: <stable+bounces-172603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F2BB32921
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 16:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038ED1BC016D
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 14:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF93C1E0E14;
	Sat, 23 Aug 2025 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ni069HfI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F54F1C8630
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755959273; cv=none; b=aycEDVRoz9r3jKM063TQLG7LKeKQdvmaLmjEb6RJbE1KJnh5KenB6PD27BuKvshciHwWIUXsaoeanfJU3QnRw0ROqX5j1X4dNutxaFE6FobMZhtdXLR6rlO/wJMeNBL44wDlD5881OujqyZRCj1kaNOXr74FP6RsgEZb0P7qSSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755959273; c=relaxed/simple;
	bh=j/m6k6jSpKCHsXhmkWxTJuFOZIujyosbu7tAKdlSJYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8LisLf94I1FwOc8ot23U+2FqozzF7kGMYP9KXL3rZn2q2KUQ2lCpqRHH9T/4EJTcz5VsTH8EyTUopR+4FEjJxbgSzRcJR6LK5VfFMJrMJuPEByanmPFXTVk5W0LZjgqZU0JB66B/Cl9L8i+dLV8kbCQRY5mvoRtHC/17HX+ewg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ni069HfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53389C4CEE7;
	Sat, 23 Aug 2025 14:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755959273;
	bh=j/m6k6jSpKCHsXhmkWxTJuFOZIujyosbu7tAKdlSJYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ni069HfIfwrjBj+M08D+gQnZTSCHOcm4cclBF7VSugQuhGr/LMvkB0usHtVRjRxP3
	 29UD3GsT3dAy2GPW/53XKIzZVfLves7P97hWdW0JNAmEY2GYCIZeeMs+yx1SUp9uQZ
	 46TJjboaNhe8iAoy4jnKrG9xusXJds87jCAU0+3qDVeSgqkE6R5cWqwgD8/xNi288I
	 BbTgut5Yj0Aki9Xqhxu/a0BTYNwIw48ip3OtVgvJP/i5QTBCoQYiaxZgQ/pNGy4rKc
	 oSlfIkOijVnOtQHK2aCGzmvUBW1LV3q24+AMV907Jtdc9NUyuWlqaEii8jbIGtGQSx
	 8boatgtmIVHVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mptcp: disable add_addr retransmission when timeout is 0
Date: Sat, 23 Aug 2025 10:27:50 -0400
Message-ID: <20250823142750.2245119-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082241-oxidant-avoid-0017@gregkh>
References: <2025082241-oxidant-avoid-0017@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

[ Upstream commit f5ce0714623cffd00bf2a83e890d09c609b7f50a ]

When add_addr_timeout was set to 0, this caused the ADD_ADDR to be
retransmitted immediately, which looks like a buggy behaviour. Instead,
interpret 0 as "no retransmissions needed".

The documentation is updated to explicitly state that setting the timeout
to 0 disables retransmission.

Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
Cc: stable@vger.kernel.org
Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-5-521fe9957892@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Apply to net/mptcp/pm_netlink.c , structural changes in mptcp_pm_alloc_anno_list ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst |  2 ++
 net/mptcp/pm_netlink.c                    | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 95598c21fc8e..09be0e68b9af 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -12,6 +12,8 @@ add_addr_timeout - INTEGER (seconds)
 	resent to an MPTCP peer that has not acknowledged a previous
 	ADD_ADDR message.
 
+	Do not retransmit if set to 0.
+
 	The default value matches TCP_RTO_MAX. This is a per-namespace
 	sysctl.
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2a085ec5bfd0..d7e29583f644 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -293,6 +293,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
+	unsigned int timeout;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -310,6 +311,10 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		goto out;
 	}
 
+	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
+	if (!timeout)
+		goto out;
+
 	spin_lock_bh(&msk->pm.lock);
 
 	if (!mptcp_pm_should_add_signal_addr(msk)) {
@@ -321,7 +326,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
-			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
+			       jiffies + timeout);
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -363,6 +368,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
+	unsigned int timeout;
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -372,9 +378,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
-		sk_reset_timer(sk, &add_entry->add_timer,
-			       jiffies + mptcp_get_add_addr_timeout(net));
-		return true;
+		goto reset_timer;
 	}
 
 	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
@@ -388,8 +392,10 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
-	sk_reset_timer(sk, &add_entry->add_timer,
-		       jiffies + mptcp_get_add_addr_timeout(net));
+reset_timer:
+	timeout = mptcp_get_add_addr_timeout(net);
+	if (timeout)
+		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
 
 	return true;
 }
-- 
2.50.1


