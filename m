Return-Path: <stable+bounces-52592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A7590B9F8
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 20:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04DA0B30329
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 18:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CE81990C9;
	Mon, 17 Jun 2024 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aPj8UuzT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2942D18EFEF
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648330; cv=none; b=rlijaGtrrmsDeDnuynjPrVJ1Iut0ejbuXdTwNq0xIjz2pHATqlWMjhU5kR6KLXOMCkJPal5imIgD4VXXR+DdGEwJ+RWyhMQy6FDx+CkL7UaYMM+uetG3YHBV9/QSShAUa2o6wqPtNNukUCc0bmlWOBBLo/Q+tqd/R0/V/+Pn3RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648330; c=relaxed/simple;
	bh=U/U/lvb1RnfjAJDIgpLkxOd0iZm1G0RSilhJsTvTjtA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cjV+CifgPxMnbLWKWvDyxhz1t/8huQaF5meKw4+uppOtrq4//ygj09ZHjTMdnTai9VLnojY6QbKz4pQNz1JUvtHDgHEqll8e4YzncCjmKsRyDKW9R5+K4wKVmo8l7IGxQMSGO88O6LwTKR4Xm5Hsq7wo8j1rb3T/TDpIt+E0ItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aPj8UuzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6788DC4AF1C;
	Mon, 17 Jun 2024 18:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718648329;
	bh=U/U/lvb1RnfjAJDIgpLkxOd0iZm1G0RSilhJsTvTjtA=;
	h=Subject:To:Cc:From:Date:From;
	b=aPj8UuzTf7Ibpb4G5hi3xVA5ERHMV9UCvBiFKsIvg+zo2lcQEUxUmq1u28rjJcAG6
	 PGqN4awdzEnvsmWx2H8r0xA1VFG1p2QhEWny8/T2KOPnIqLjxhBZPhrPXS4GtRxn4U
	 fESmCvkWdnPoNdAK7Quek5/tZHj1iY5tLBHpyZ8A=
Subject: FAILED: patch "[PATCH] mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID" failed to apply to 5.10-stable tree
To: liyonglong@chinatelecom.cn,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 20:18:38 +0200
Message-ID: <2024061738-bright-knelt-4f2a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6a09788c1a66e3d8b04b3b3e7618cc817bb60ae9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061738-bright-knelt-4f2a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

6a09788c1a66 ("mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID")
3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
c157bbe776b7 ("mptcp: allow the in kernel PM to set MPC subflow priority")
843b5e75efff ("mptcp: fix local endpoint accounting")
4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
0530020a7c8f ("mptcp: track and update contiguous data status")
0348c690ed37 ("mptcp: add the fallback check")
1761fed25678 ("mptcp: don't send RST for single subflow")
c682bf536cf4 ("mptcp: add pm_nl_pernet helpers")
ae7bd9ccecc3 ("selftests: mptcp: join: option to execute specific tests")
e59300ce3ff8 ("selftests: mptcp: join: reset failing links")
3afd0280e7d3 ("selftests: mptcp: join: define tests groups once")
3c082695e78b ("selftests: mptcp: drop msg argument of chk_csum_nr")
69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
4cf86ae84c71 ("mptcp: strict local address ID selection")
d045b9eb95a9 ("mptcp: introduce implicit endpoints")
6fa0174a7c86 ("mptcp: more careful RM_ADDR generation")
f98c2bca7b2b ("selftests: mptcp: Rename wait function")
826d7bdca833 ("selftests: mptcp: join: allow running -cCi")
ea56dcb43c20 ("mptcp: use MPTCP_SUBFLOW_NODATA")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6a09788c1a66e3d8b04b3b3e7618cc817bb60ae9 Mon Sep 17 00:00:00 2001
From: YonglongLi <liyonglong@chinatelecom.cn>
Date: Fri, 7 Jun 2024 17:01:49 +0200
Subject: [PATCH] mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID

The RmAddr MIB counter is supposed to be incremented once when a valid
RM_ADDR has been received. Before this patch, it could have been
incremented as many times as the number of subflows connected to the
linked address ID, so it could have been 0, 1 or more than 1.

The "RmSubflow" is incremented after a local operation. In this case,
it is normal to tied it with the number of subflows that have been
actually removed.

The "remove invalid addresses" MP Join subtest has been modified to
validate this case. A broadcast IP address is now used instead: the
client will not be able to create a subflow to this address. The
consequence is that when receiving the RM_ADDR with the ID attached to
this broadcast IP address, no subflow linked to this ID will be found.

Fixes: 7a7e52e38a40 ("mptcp: add RM_ADDR related mibs")
Cc: stable@vger.kernel.org
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: YonglongLi <liyonglong@chinatelecom.cn>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240607-upstream-net-20240607-misc-fixes-v1-2-1ab9ddfa3d00@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7f53e022e27e..766a8409fa67 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -814,10 +814,13 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			spin_lock_bh(&msk->pm.lock);
 
 			removed = true;
-			__MPTCP_INC_STATS(sock_net(sk), rm_type);
+			if (rm_type == MPTCP_MIB_RMSUBFLOW)
+				__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
 		if (rm_type == MPTCP_MIB_RMSUBFLOW)
 			__set_bit(rm_id ? rm_id : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap);
+		else if (rm_type == MPTCP_MIB_RMADDR)
+			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		if (!removed)
 			continue;
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2b66c5fa71eb..aea314d140c9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2250,7 +2250,8 @@ remove_tests()
 		pm_nl_set_limits $ns1 3 3
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 flags signal
 		pm_nl_set_limits $ns2 3 3
 		addr_nr_ns1=-3 speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1


