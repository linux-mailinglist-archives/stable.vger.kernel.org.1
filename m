Return-Path: <stable+bounces-186135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB811BE3AD5
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8C41A65A27
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B6531A812;
	Thu, 16 Oct 2025 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oTHm8R5G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4B431690D
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620982; cv=none; b=I6Vx53YDJ1K4aE/bAh/K8IV4PO58YkWWPKGvMS4UYTXko+Rw6qHIEdKdh+eGgPvw8IdTXhdOm40xIwurUsscYkHiwTfKm3qyA+YLzVrnUITzobEBRcDx66Dnlz6AHAOhOyCkwKSFAQXZfea40ZuLys3GrRbs+BWDzkgQ8aLumRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620982; c=relaxed/simple;
	bh=5Pcdkiaf93PU/8vWTEuV8bh0y3Lvs1YDLikxOYMVCXg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tXoslq7O53FRJWz98SiH/qDpVmFZU9BhNu0c6caxy1YLop4/yE0yj1pIZS43LYv5sW7R+VYXqtacHE20TzjfpFVqEq6Fy/4IhU7f4eCjKFPQ3IQWFxnafb9fek4mrY02yAabScnBnO6g6DL94okbMZWsCHkZ1O3aMT1K/V0YGqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oTHm8R5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5D4C4CEF1;
	Thu, 16 Oct 2025 13:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760620982;
	bh=5Pcdkiaf93PU/8vWTEuV8bh0y3Lvs1YDLikxOYMVCXg=;
	h=Subject:To:Cc:From:Date:From;
	b=oTHm8R5GTxeih4ev3jT3pqC/TH+scc8sP1tCDI8UHvzf7zCFkRuFKCoPvunWvrYAh
	 FuEWoACY8EE9e6+6+xDjjgHCo+S30Sm4GDCHTPmHPGSNiuBq/YyhMl9vD54sFfsyen
	 yi0ZVTGx6vaA22rnUjkbE+4SYDar/q62KE6gDtY8=
Subject: FAILED: patch "[PATCH] mptcp: reset blackhole on success with non-loopback ifaces" failed to apply to 6.12-stable tree
To: matttbe@kernel.org,horms@kernel.org,kuba@kernel.org,kuniyu@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 15:20:04 +0200
Message-ID: <2025101604-chamber-playhouse-5278@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 833d4313bc1e9e194814917d23e8874d6b651649
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101604-chamber-playhouse-5278@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 833d4313bc1e9e194814917d23e8874d6b651649 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Sep 2025 10:50:18 +0200
Subject: [PATCH] mptcp: reset blackhole on success with non-loopback ifaces

When a first MPTCP connection gets successfully established after a
blackhole period, 'active_disable_times' was supposed to be reset when
this connection was done via any non-loopback interfaces.

Unfortunately, the opposite condition was checked: only reset when the
connection was established via a loopback interface. Fixing this by
simply looking at the opposite.

This is similar to what is done with TCP FastOpen, see
tcp_fastopen_active_disable_ofo_check().

This patch is a follow-up of a previous discussion linked to commit
893c49a78d9f ("mptcp: Use __sk_dst_get() and dst_dev_rcu() in
mptcp_active_enable()."), see [1].

Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/4209a283-8822-47bd-95b7-87e96d9b7ea3@kernel.org [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250918-net-next-mptcp-blackhole-reset-loopback-v1-1-bf5818326639@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index e8ffa62ec183..d96130e49942 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -507,7 +507,7 @@ void mptcp_active_enable(struct sock *sk)
 		rcu_read_lock();
 		dst = __sk_dst_get(sk);
 		dev = dst ? dst_dev_rcu(dst) : NULL;
-		if (dev && (dev->flags & IFF_LOOPBACK))
+		if (!(dev && (dev->flags & IFF_LOOPBACK)))
 			atomic_set(&pernet->active_disable_times, 0);
 		rcu_read_unlock();
 	}


