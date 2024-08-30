Return-Path: <stable+bounces-71594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7975A965F05
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACAE51C24B5A
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7CE18A6A2;
	Fri, 30 Aug 2024 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tAhZ8y/U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5018991D
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013395; cv=none; b=MZwJdkaWSfLgtpcgCGxbf2oqwIN9tuAeE59Bssr+Lq43hbxFOhSTNwqOl1kKX4xyTrZDhraSNzIg69daDomS/5c2cw6JGsiZ1NhM/zxlvrSBElOrL7I1FSQrUGm+H2YcT2746Su9rO1Y22FW2/UBY+DWxchaZVskUZjr13sBvmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013395; c=relaxed/simple;
	bh=dao4W0V4RN2AfKfZnekjqNQdNAeD68c70oPvCL919jU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rNmEqdal5UgEtwktf9MQtnA1+aIovJKJArpwQ4ZytT1z0bZ8vGW/TRbqLAbQCaX7Sxk6nshVpEECdpdLp0Ii18jhIa3Q8OpSw0sxO88IwybVde4FisrC+9aOg2T2+I0Mr+eW7mDnuDvJNM7sAJa0g2AZp7p6o9sfhcL4sl2nQ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tAhZ8y/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5B4C4CEC2;
	Fri, 30 Aug 2024 10:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725013395;
	bh=dao4W0V4RN2AfKfZnekjqNQdNAeD68c70oPvCL919jU=;
	h=Subject:To:Cc:From:Date:From;
	b=tAhZ8y/UvfGewXKxAkWzmtfUSIWUfbQY04lRf+WlWJ/824lGMFjKN21z+NExFe4Jw
	 e6rObL8G70r4doXV81imV/v6HLGoMZiu+zVSTUEc5PJLx2rPMiOg7aSOFKTK7eE1Uy
	 U3wqsQOlWUMzjOMvFW6lY2pRFiRyN4DB4OIY91o8=
Subject: FAILED: patch "[PATCH] mptcp: pm: fix ID 0 endp usage after multiple re-creations" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,arinc.unal@arinc9.com,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Aug 2024 12:23:11 +0200
Message-ID: <2024083011-antics-rented-acb7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9366922adc6a71378ca01f898c41be295309f044
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024083011-antics-rented-acb7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

9366922adc6a ("mptcp: pm: fix ID 0 endp usage after multiple re-creations")
8b8ed1b429f8 ("mptcp: pm: reuse ID 0 after delete and re-add")
48e50dcbcbaa ("mptcp: pm: avoid possible UaF when selecting endp")
85df533a787b ("mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set")
cd7c957f936f ("mptcp: pm: don't try to create sf if alloc failed")
c95eb32ced82 ("mptcp: pm: reduce indentation blocks")
40eec1795cc2 ("mptcp: pm: update add_addr counters after connect")
6a09788c1a66 ("mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID")
e571fb09c893 ("selftests: mptcp: add speed env var")
4aadde088a58 ("selftests: mptcp: add fullmesh env var")
080b7f5733fd ("selftests: mptcp: add fastclose env var")
662aa22d7dcd ("selftests: mptcp: set all env vars as local ones")
9e9d176df8e9 ("selftests: mptcp: add pm_nl_set_endpoint helper")
1534f87ee0dc ("selftests: mptcp: drop sflags parameter")
595ef566a2ef ("selftests: mptcp: drop addr_nr_ns1/2 parameters")
0c93af1f8907 ("selftests: mptcp: drop test_linkfail parameter")
be7e9786c915 ("selftests: mptcp: set FAILING_LINKS in run_tests")
4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
528cb5f2a1e8 ("mptcp: pass addr to mptcp_pm_alloc_anno_list")
ae947bb2c253 ("selftests: mptcp: join: skip Fastclose tests if not supported")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9366922adc6a71378ca01f898c41be295309f044 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:33 +0200
Subject: [PATCH] mptcp: pm: fix ID 0 endp usage after multiple re-creations
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

'local_addr_used' and 'add_addr_accepted' are decremented for addresses
not related to the initial subflow (ID0), because the source and
destination addresses of the initial subflows are known from the
beginning: they don't count as "additional local address being used" or
"ADD_ADDR being accepted".

It is then required not to increment them when the entrypoint used by
the initial subflow is removed and re-added during a connection. Without
this modification, this entrypoint cannot be removed and re-added more
than once.

Reported-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/512
Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Reported-by: syzbot+455d38ecd5f655fc45cf@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/00000000000049861306209237f4@google.com
Cc: stable@vger.kernel.org
Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3ff273e219f2..a93450ded50a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -615,12 +615,13 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		fullmesh = !!(local.flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 
-		msk->pm.local_addr_used++;
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 
 		/* Special case for ID0: set the correct ID */
 		if (local.addr.id == msk->mpc_endpoint_id)
 			local.addr.id = 0;
+		else /* local_addr_used is not decr for ID 0 */
+			msk->pm.local_addr_used++;
 
 		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
 		if (nr == 0)
@@ -750,7 +751,9 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (sf_created) {
-		msk->pm.add_addr_accepted++;
+		/* add_addr_accepted is not decr for ID 0 */
+		if (remote.id)
+			msk->pm.add_addr_accepted++;
 		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
 		    msk->pm.subflows >= subflows_max)
 			WRITE_ONCE(msk->pm.accept_addr, false);


