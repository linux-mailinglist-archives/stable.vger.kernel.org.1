Return-Path: <stable+bounces-52591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0DE90B98C
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 20:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462401C23D08
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 18:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7E719AD99;
	Mon, 17 Jun 2024 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n35shkaW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF7919AD4A
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648321; cv=none; b=SqHvepgoLFG1FhDYhaYlHqJ1GNXpM+ditoE0Ui2EA+nhIlDcCGw1TNbSEaDFivwVSMmxZTMDDIDmghVRBTqup/klEJNK7gbeLccLubLckYEmZ5McfAz5evsbDEzGDomE1apQ1fjA+N3abw3oS9FEu0sTstwIBZ4h4iprv5sw3sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648321; c=relaxed/simple;
	bh=QUf8xur+iGMqVtDpR33c8t3OtP+KwYO9wnRCkVlVXCY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hUsfjjxekEVyL/QdjQbG0NlpS7uzTSgJ6TzJKpkqDMapCAWiz2NuYJzAgkNVPa6K86qPkXfQyi625PFGA1rlAnVtP97z3XjxWcuxKxw8OwWdGH4l7t5c7sIBlCw0MNdUfMDn85McfqFQfMK3OOsd7wmESsRqaO2B06tI9JPR/Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n35shkaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7111DC4AF1C;
	Mon, 17 Jun 2024 18:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718648320;
	bh=QUf8xur+iGMqVtDpR33c8t3OtP+KwYO9wnRCkVlVXCY=;
	h=Subject:To:Cc:From:Date:From;
	b=n35shkaWYCzNITekeo5TrzyvfWewhi31SL55Kewd97OSfOCM+6HZDesD+lRUeMTFW
	 D1w7fH2cenyAXmMGBjh03/kHAurboaXhBqTOpuTsGX0cNvBTnYipGrwSWakT8tFmsC
	 JAxmCXC2wGFzR229Ff2DWvZs4rCMExNy4tt5mDo0=
Subject: FAILED: patch "[PATCH] mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID" failed to apply to 5.15-stable tree
To: liyonglong@chinatelecom.cn,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 20:18:38 +0200
Message-ID: <2024061737-stove-fence-8c34@gregkh>
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
git cherry-pick -x 6a09788c1a66e3d8b04b3b3e7618cc817bb60ae9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061737-stove-fence-8c34@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


