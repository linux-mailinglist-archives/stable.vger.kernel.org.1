Return-Path: <stable+bounces-70193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2A595F0E9
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E0E1C23549
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4F0186619;
	Mon, 26 Aug 2024 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N9mkCjwb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAA916F0EB
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674073; cv=none; b=WFLYSs5zzlzX1kZaRjYUrIG0NbMzU3oQPbw9U+NbKU8G3i8Vgv4C0GDn+jeWgRaFWVlboDrouXZXAkXjSozlcx0cbeNLGPn8Aal/gnSM9gLIUtIvkNR/lXjmMNRMVswmeeVfbZkLcdSufBR+MvezKTlxQBPJSG9tMwJUYgijFOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674073; c=relaxed/simple;
	bh=ukH8MeMHVyxYJ2rKRQ46ntIZx5ksLMXRu0b7UDPsS2Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oaTEh9+a0+2m0pNbIJkHhicRNH0hMZ081izrH4VSyLdxlOfmuLbWjzVvcwyEItIZTOLjft0f6/hAZIv3bxssNOu/sCNJRIb+8aIEcN2FpU/EpAgTGci04waeb1SuT4FC38nbreulSMzLp+23eeT9y5R5e5d6LqXHKpqpsRo/hqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N9mkCjwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DA8C51413;
	Mon, 26 Aug 2024 12:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724674072;
	bh=ukH8MeMHVyxYJ2rKRQ46ntIZx5ksLMXRu0b7UDPsS2Y=;
	h=Subject:To:Cc:From:Date:From;
	b=N9mkCjwbNqBFsVZStHhS9C/t9Ufzb2HUCEsJxiZ97Az6jGm6PHFBmxigDR6vqSn1S
	 uwNxFDPcL7CfmUwEjJ3hceY47E8gRvMnzqF+g4tZjbkT9uC31Jc/Vj5i9BbrSq3A7h
	 DvYabDdRO1gpDtOUbY4Sc+ZNW2oQdUs4zi++6+3U=
Subject: FAILED: patch "[PATCH] mptcp: pm: fullmesh: select the right ID later" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:07:41 +0200
Message-ID: <2024082641-cauterize-slum-9eb2@gregkh>
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
git cherry-pick -x 09355f7abb9fbfc1a240be029837921ea417bf4f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082641-cauterize-slum-9eb2@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

09355f7abb9f ("mptcp: pm: fullmesh: select the right ID later")
b9d69db87fb7 ("mptcp: let the in-kernel PM use mixed IPv4 and IPv6 addresses")
837cf45df163 ("mptcp: fix race in incoming ADD_ADDR option processing")
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

From 09355f7abb9fbfc1a240be029837921ea417bf4f Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:30 +0200
Subject: [PATCH] mptcp: pm: fullmesh: select the right ID later

When reacting upon the reception of an ADD_ADDR, the in-kernel PM first
looks for fullmesh endpoints. If there are some, it will pick them,
using their entry ID.

It should set the ID 0 when using the endpoint corresponding to the
initial subflow, it is a special case imposed by the MPTCP specs.

Note that msk->mpc_endpoint_id might not be set when receiving the first
ADD_ADDR from the server. So better to compare the addresses.

Fixes: 1a0d6136c5f0 ("mptcp: local addresses fullmesh")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-12-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d0a80f537fc3..a2e37ab1c40f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -636,6 +636,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
 	int i = 0;
@@ -643,6 +644,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	pernet = pm_nl_get_pernet_from_msk(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
+	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
@@ -653,7 +656,13 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 
 		if (msk->pm.subflows < subflows_max) {
 			msk->pm.subflows++;
-			addrs[i++] = entry->addr;
+			addrs[i] = entry->addr;
+
+			/* Special case for ID0: set the correct ID */
+			if (mptcp_addresses_equal(&entry->addr, &mpc_addr, entry->addr.port))
+				addrs[i].id = 0;
+
+			i++;
 		}
 	}
 	rcu_read_unlock();


