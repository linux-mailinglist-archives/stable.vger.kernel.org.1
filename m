Return-Path: <stable+bounces-71589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16910965EFF
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C612328DC2B
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B73A185E6E;
	Fri, 30 Aug 2024 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uckoMRl1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC9E184555
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013327; cv=none; b=m93ly8Mj3hJzNzW9p+Zy3IQrRwsohBtZO86Mj7KbxhAymwjGLK4ooeyUZUCWrzHmBeDla0PnA7YS7iB/TZEt10dNF1zTw58A9bYgaw9V5fQHCrCdYjjZ604eAzk41ze4PfARsBgD/Mf8GaJi2lJ/N1GEpo4MMk2fiOKzXMofPt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013327; c=relaxed/simple;
	bh=Wm2mYwR0TIrg/Gf4i7sRqiEfFSMpL8e7MvpLU61NtkI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=glTPe2VGSuIb5RB+SCsAdjFALEHxX0sNPhZn8WyOCIJ3qw+UCow0FmbxjaiRFsAG6PnByPWAfTaOziwdDdnC1sqf/yzI3mpSgADum7V7a7Ku7CTvXa9FXDwcDR0DFmOLrOrNJ8UbgFxarCc5ezo27i8WlMGPwsj5h+Dcm6Yo2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uckoMRl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD741C4CEC2;
	Fri, 30 Aug 2024 10:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725013327;
	bh=Wm2mYwR0TIrg/Gf4i7sRqiEfFSMpL8e7MvpLU61NtkI=;
	h=Subject:To:Cc:From:Date:From;
	b=uckoMRl1xMqZkkicnDT49ygNkE9TZee+nXX7PjGSpweQ0yLTlMJqjN/TJsWFyugNG
	 jEhC+UwAhckGidTwFOCwQburC3ENtx/3WidraQavSFkD4hdErG/QdxS4kdkfXnLWEg
	 hZl+jadbHO8IM1HeH7SI0pDnwglWsigAZ2wPpJas=
Subject: FAILED: patch "[PATCH] mptcp: pm: skip connecting to already established sf" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Aug 2024 12:22:03 +0200
Message-ID: <2024083003-chowder-scurvy-2e9c@gregkh>
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
git cherry-pick -x bc19ff57637ff563d2bdf2b385b48c41e6509e0d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024083003-chowder-scurvy-2e9c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

bc19ff57637f ("mptcp: pm: skip connecting to already established sf")
4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
c682bf536cf4 ("mptcp: add pm_nl_pernet helpers")
4cf86ae84c71 ("mptcp: strict local address ID selection")
d045b9eb95a9 ("mptcp: introduce implicit endpoints")
90d930882139 ("mptcp: constify a bunch of of helpers")
33397b83eee6 ("selftests: mptcp: add backup with port testcase")
09f12c3ab7a5 ("mptcp: allow to use port and non-signal in set_flags")
6a0653b96f5d ("selftests: mptcp: add fullmesh setting tests")
8e9eacad7ec7 ("mptcp: fix msk traversal in mptcp_nl_cmd_set_flags()")
327b9a94e2a8 ("selftests: mptcp: more stable join tests-cases")
a88c9e496937 ("mptcp: do not block subflows creation on errors")
86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
f7d6a237d742 ("mptcp: fix per socket endpoint accounting")
b29fcfb54cd7 ("mptcp: full disconnect implementation")
59060a47ca50 ("mptcp: clean up harmless false expressions")
3ce0852c86b9 ("mptcp: enforce HoL-blocking estimation")
602837e8479d ("mptcp: allow changing the "backup" bit by endpoint id")
6511882cdd82 ("mptcp: allocate fwd memory separately on the rx and tx path")
dd9a887b35b0 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bc19ff57637ff563d2bdf2b385b48c41e6509e0d Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:28 +0200
Subject: [PATCH] mptcp: pm: skip connecting to already established sf

The lookup_subflow_by_daddr() helper checks if there is already a
subflow connected to this address. But there could be a subflow that is
closing, but taking time due to some reasons: latency, losses, data to
process, etc.

If an ADD_ADDR is received while the endpoint is being closed, it is
better to try connecting to it, instead of rejecting it: the peer which
has sent the ADD_ADDR will not be notified that the ADD_ADDR has been
rejected for this reason, and the expected subflow will not be created
at the end.

This helper should then only look for subflows that are established, or
going to be, but not the ones being closed.

Fixes: d84ad04941c3 ("mptcp: skip connecting the connected address")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ed2205ef7208..0134b6273c54 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -130,12 +130,15 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
-	struct sock_common *skc;
 
 	list_for_each_entry(subflow, list, node) {
-		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		remote_address(skc, &cur);
+		if (!((1 << inet_sk_state_load(ssk)) &
+		      (TCPF_ESTABLISHED | TCPF_SYN_SENT | TCPF_SYN_RECV)))
+			continue;
+
+		remote_address((struct sock_common *)ssk, &cur);
 		if (mptcp_addresses_equal(&cur, daddr, daddr->port))
 			return true;
 	}


