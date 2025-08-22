Return-Path: <stable+bounces-172299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03D5B30E72
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 08:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12BC25E3FBD
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 06:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C8A2135AD;
	Fri, 22 Aug 2025 06:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="czS4o/Jg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F80016FF44
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 06:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842703; cv=none; b=GvP1SHoqZISUEDC60RIG+p+MawsO2TvaildeQOQyqY376t0DLjT0gooWfX6aKysbt6C+Hxlny1q9+SyPRvKULvR/y26xPCxWj+KJ/ZKJKZ1Pp3lA1BaW4kD+Vw0eFKZVJQE6thCFi2Halmwyrr0wPK38zoOANjGz5kgMAXVN9LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842703; c=relaxed/simple;
	bh=/rNsMhg9Xt8FkJeGtWfTSD4McJI8kbMhDM58s4Z2YJ4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NzHMfFnkN52xf34wx4hmt7c+nEa6yuG6YRfABvilNTYBHI9HmEPXqHRhHh2qgppQiJGXwu2kaEWJOB4I1dBY6FGxzU/dDlHP++YRCxooK1LC23v+//TBDJIEn5Cw7wYRAeJPDBZMOMlcKLcYXYYOh3yV8r6H2lDcsJa/uGWn7wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=czS4o/Jg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E9AC4CEF1;
	Fri, 22 Aug 2025 06:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755842702;
	bh=/rNsMhg9Xt8FkJeGtWfTSD4McJI8kbMhDM58s4Z2YJ4=;
	h=Subject:To:Cc:From:Date:From;
	b=czS4o/JgD1UaPNWbTaosTFB+tI8pEHnceI228hSxHi3B8ZkHyUtK4lkJnLpeOztgL
	 aYJndKbvAv4AKFCS78szB5K3kqhA4oSynbzgYvIQxH/t7nrCyzv5USvD7XYT0gmZs3
	 iC8Ck+RjeMECLpf48aCd3HeaGV66HZMVjAJbonBg=
Subject: FAILED: patch "[PATCH] mptcp: disable add_addr retransmission when timeout is 0" failed to apply to 6.6-stable tree
To: geliang@kernel.org,kuba@kernel.org,matttbe@kernel.org,tanggeliang@kylinos.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 08:04:41 +0200
Message-ID: <2025082241-diner-uncoated-a54e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f5ce0714623cffd00bf2a83e890d09c609b7f50a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082241-diner-uncoated-a54e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f5ce0714623cffd00bf2a83e890d09c609b7f50a Mon Sep 17 00:00:00 2001
From: Geliang Tang <geliang@kernel.org>
Date: Fri, 15 Aug 2025 19:28:23 +0200
Subject: [PATCH] mptcp: disable add_addr retransmission when timeout is 0

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

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 5bfab01eff5a..1683c139821e 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -12,6 +12,8 @@ add_addr_timeout - INTEGER (seconds)
 	resent to an MPTCP peer that has not acknowledged a previous
 	ADD_ADDR message.
 
+	Do not retransmit if set to 0.
+
 	The default value matches TCP_RTO_MAX. This is a per-namespace
 	sysctl.
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c5f6a53ce5f1..136a380602ca 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -274,6 +274,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 							      add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
+	unsigned int timeout;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -291,6 +292,10 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		goto out;
 	}
 
+	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
+	if (!timeout)
+		goto out;
+
 	spin_lock_bh(&msk->pm.lock);
 
 	if (!mptcp_pm_should_add_signal_addr(msk)) {
@@ -302,7 +307,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
-			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
+			       jiffies + timeout);
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -344,6 +349,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
+	unsigned int timeout;
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -368,8 +374,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 reset_timer:
-	sk_reset_timer(sk, &add_entry->add_timer,
-		       jiffies + mptcp_get_add_addr_timeout(net));
+	timeout = mptcp_get_add_addr_timeout(net);
+	if (timeout)
+		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
 
 	return true;
 }


