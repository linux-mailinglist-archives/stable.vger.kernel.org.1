Return-Path: <stable+bounces-71598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0382B965F1C
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283931C22E19
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5B317DFFF;
	Fri, 30 Aug 2024 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sTxHMNjY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C31517D896
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013588; cv=none; b=CwbdbZUvXc740QzhkBMQZdB41ea0wxD7w+GrWDkU9xkha/6OWpoobz/EjA57otaTCN/rxqmD85BsLjtUZbOrNGJNA6qo18KDQYRxZZ0wxJWwLjdoPPZWTMGs+T2a5p2TH6Hy0j6lZW/CG+rnvW0BYaIqETSmqpLY0o6Vka2fAJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013588; c=relaxed/simple;
	bh=Fu9t/Br/UmIs9Qc+QUMzTw7vqtI/Po65fQOopgKF8oo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RrhLbf/gwIyPrVF3dk6EaHG9VS12oWR6ikV3Sg369y+RcqG8FEKpV1VPkoXVjJap71XN42Z0WAEIhl2+sSXBRKxpSLJJrXsp5D5+6yu575rzxaXNuM55wC5LH8f3QSd2NK80jPgInC+VAEhBWtWBtrz9VYBCjk8ly+TaLcJ+Wd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sTxHMNjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69058C4CEC2;
	Fri, 30 Aug 2024 10:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725013588;
	bh=Fu9t/Br/UmIs9Qc+QUMzTw7vqtI/Po65fQOopgKF8oo=;
	h=Subject:To:Cc:From:Date:From;
	b=sTxHMNjYxPq5Dg72yW06afGxA1Mx44z0YlQoEgJLoJm8Urp3pAnDGieYYi3uM15fQ
	 RGTfDr8HqxKtJ7mS6lKdxRN/0HFYXObYSfoq75BYJp7SAzvoUZZ9VrWfZEeJo9Rpi5
	 +jiJquwvdAk1XN9MIP55DMCXHuzSA0ikK+x5OXEY=
Subject: FAILED: patch "[PATCH] mptcp: pm: ADD_ADDR 0 is not a new address" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Aug 2024 12:26:24 +0200
Message-ID: <2024083024-distort-gallantly-afea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 57f86203b41c98b322119dfdbb1ec54ce5e3369b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024083024-distort-gallantly-afea@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

57f86203b41c ("mptcp: pm: ADD_ADDR 0 is not a new address")
4d25247d3ae4 ("mptcp: bypass in-kernel PM restrictions for non-kernel PMs")
14b06811bec6 ("mptcp: Bypass kernel PM when userspace PM is enabled")
a88c9e496937 ("mptcp: do not block subflows creation on errors")
86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
f7d6a237d742 ("mptcp: fix per socket endpoint accounting")
b29fcfb54cd7 ("mptcp: full disconnect implementation")
59060a47ca50 ("mptcp: clean up harmless false expressions")
3ce0852c86b9 ("mptcp: enforce HoL-blocking estimation")
6511882cdd82 ("mptcp: allocate fwd memory separately on the rx and tx path")
765ff425528f ("mptcp: use lockdep_assert_held_once() instead of open-coding it")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 57f86203b41c98b322119dfdbb1ec54ce5e3369b Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:37 +0200
Subject: [PATCH] mptcp: pm: ADD_ADDR 0 is not a new address

The ADD_ADDR 0 with the address from the initial subflow should not be
considered as a new address: this is not something new. If the host
receives it, it simply means that the address is available again.

When receiving an ADD_ADDR for the ID 0, the PM already doesn't consider
it as new by not incrementing the 'add_addr_accepted' counter. But the
'accept_addr' might not be set if the limit has already been reached:
this can be bypassed in this case. But before, it is important to check
that this ADD_ADDR for the ID 0 is for the same address as the initial
subflow. If not, it is not something that should happen, and the
ADD_ADDR can be ignored.

Note that if an ADD_ADDR is received while there is already a subflow
opened using the same address, this ADD_ADDR is ignored as well. It
means that if multiple ADD_ADDR for ID 0 are received, there will not be
any duplicated subflows created by the client.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3f8dbde243f1..37f6dbcd8434 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -226,7 +226,9 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 		} else {
 			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
 		}
-	} else if (!READ_ONCE(pm->accept_addr)) {
+	/* id0 should not have a different address */
+	} else if ((addr->id == 0 && !mptcp_pm_nl_is_init_remote_addr(msk, addr)) ||
+		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a93450ded50a..f891bc714668 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -760,6 +760,15 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	}
 }
 
+bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *remote)
+{
+	struct mptcp_addr_info mpc_remote;
+
+	remote_address((struct sock_common *)msk, &mpc_remote);
+	return mptcp_addresses_equal(&mpc_remote, remote, remote->port);
+}
+
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 26eb898a202b..3b22313d1b86 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -993,6 +993,8 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
+bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *remote);
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);


