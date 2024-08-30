Return-Path: <stable+bounces-71588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2695D965EF7
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D596E28DA42
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD5A17C215;
	Fri, 30 Aug 2024 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KGubusL+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE1917C21E
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013309; cv=none; b=F+iYSbSZU7ZZ/L1UTTfeycm5jeStVbtrpymKlzJWC6/QP04ov5IjwJ0Ewj56bC0fz+1c4S/xc+EDJ+s62ziiXg7JbiWGX9TX/FeIi9HXCfBJhc1k9XSchQ6dqUWTPvB16kxwFZ9Kbo9NxoCRBaJ5fsvSAgkGw3Q7oBEPwO2e4G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013309; c=relaxed/simple;
	bh=s2e1GHmtILSoOiu2yShcaCq3YGpfToFLDjBQbMj4npM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Hdh4NcI6VDsl/cpsqEo+wQY60ic7u+BzVfYbjmQKzT9+UvpLDYCMbzPv2DDU7frutN00eZdmTwmZ88+GvT4GU+FqMbgT2bVA0G59nOutq0HrtOoItKjYFjaiPoEYsv06lSs/z3ae/H0CFs+20PJTR5zPUNztRhoPwehaJByoub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KGubusL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F12C4CEC2;
	Fri, 30 Aug 2024 10:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725013309;
	bh=s2e1GHmtILSoOiu2yShcaCq3YGpfToFLDjBQbMj4npM=;
	h=Subject:To:Cc:From:Date:From;
	b=KGubusL+VR9V/n6aB81MOiKwIhWTkmWR3G/toYHFArXRqM7v/QBC/fyuw95yB0S3v
	 jWPckxnAK9z5JIGy0HpG40ZhDumeqsmQ8OgFowlPl7pOsxQvVfdiGoxsND4dTkeO0F
	 F0c2RwL8g6qYlXiwcgDRImduGAswbcRI2jC2QJFw=
Subject: FAILED: patch "[PATCH] mptcp: pm: reuse ID 0 after delete and re-add" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Aug 2024 12:21:44 +0200
Message-ID: <2024083043-surreal-prepay-46e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8b8ed1b429f8fa7ebd5632555e7b047bc0620075
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024083043-surreal-prepay-46e5@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

8b8ed1b429f8 ("mptcp: pm: reuse ID 0 after delete and re-add")
48e50dcbcbaa ("mptcp: pm: avoid possible UaF when selecting endp")
85df533a787b ("mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set")
cd7c957f936f ("mptcp: pm: don't try to create sf if alloc failed")
c95eb32ced82 ("mptcp: pm: reduce indentation blocks")
528cb5f2a1e8 ("mptcp: pass addr to mptcp_pm_alloc_anno_list")
77e4b94a3de6 ("mptcp: update userspace pm infos")
24430f8bf516 ("mptcp: add address into userspace pm list")
b9d69db87fb7 ("mptcp: let the in-kernel PM use mixed IPv4 and IPv6 addresses")
fb00ee4f3343 ("mptcp: netlink: respect v4/v6-only sockets")
80638684e840 ("mptcp: get sk from msk directly")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8b8ed1b429f8fa7ebd5632555e7b047bc0620075 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:24 +0200
Subject: [PATCH] mptcp: pm: reuse ID 0 after delete and re-add

When the endpoint used by the initial subflow is removed and re-added
later, the PM has to force the ID 0, it is a special case imposed by the
MPTCP specs.

Note that the endpoint should then need to be re-added reusing the same
ID.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8d2f97854c64..ec45ab4c66ab 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -585,6 +585,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;
+
+		/* Special case for ID0: set the correct ID */
+		if (local.addr.id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+
 		mptcp_pm_announce_addr(msk, &local.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 
@@ -609,6 +614,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		msk->pm.local_addr_used++;
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
+
+		/* Special case for ID0: set the correct ID */
+		if (local.addr.id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+
 		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
 		if (nr == 0)
 			continue;


