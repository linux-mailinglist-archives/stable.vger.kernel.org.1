Return-Path: <stable+bounces-70187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF55695F0D9
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776B51F24C05
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBAA17BEDB;
	Mon, 26 Aug 2024 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cgDJmcqp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F217BEC1
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674016; cv=none; b=RearR3ZR0jqYtrnPcpVl+dnMacIgIW936HYNgiertOlkL3c69rWPXxVplyzdTiYHBxJN+rtbTu286S+khzQPFODBeGLUT20GSYXJvZ+kFfOhK79FDdpCwtRRfefyhSRQO1Xt4KE+hGodmwat8OlrFPjK/jfU28O0Ipwlk1WNQSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674016; c=relaxed/simple;
	bh=RSLM9QeeLKpeletSZQWeZUNUXhnmVEGQ2cq8FWUrRY0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T/VETSUJoThJ4oowz0XpQumGUZUdZ25vQPwrwt/GxSXNVRqdt4F67SuKrPoVoLmluwtEsz3law1EJVV2UuZM/YSlYTF6IcxH5/jRDLsqbgwiA6q4erGnIyftwvxrO1Ju3sLahaRhZAkSqy0/6Bzwc/CNHpKko/UtonnkmgpxxEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cgDJmcqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A987EC51430;
	Mon, 26 Aug 2024 12:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724674016;
	bh=RSLM9QeeLKpeletSZQWeZUNUXhnmVEGQ2cq8FWUrRY0=;
	h=Subject:To:Cc:From:Date:From;
	b=cgDJmcqpOlaJ+bTDgGhY39iz4OUKP4qqgorwmT2ocX5UW+20IECrMJz/PUw2SfQL7
	 XFnnrmxk6hr+pg5sBgZA7fGZ8uBh99ai9BDcDi39inHOhpHGBRK8NUWwu22K64WUkN
	 sqsHvJgx9gX6mqazBdCzMuK7KTPPLtv3s+TxbrZo=
Subject: FAILED: patch "[PATCH] mptcp: pm: only decrement add_addr_accepted for MPJ req" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:06:53 +0200
Message-ID: <2024082652-polka-escapist-f8f8@gregkh>
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
git cherry-pick -x 1c1f721375989579e46741f59523e39ec9b2a9bd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082652-polka-escapist-f8f8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

1c1f72137598 ("mptcp: pm: only decrement add_addr_accepted for MPJ req")
6a09788c1a66 ("mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID")
3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
c157bbe776b7 ("mptcp: allow the in kernel PM to set MPC subflow priority")
843b5e75efff ("mptcp: fix local endpoint accounting")
4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
4d25247d3ae4 ("mptcp: bypass in-kernel PM restrictions for non-kernel PMs")
14b06811bec6 ("mptcp: Bypass kernel PM when userspace PM is enabled")
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

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c1f721375989579e46741f59523e39ec9b2a9bd Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:27 +0200
Subject: [PATCH] mptcp: pm: only decrement add_addr_accepted for MPJ req

Adding the following warning ...

  WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)

... before decrementing the add_addr_accepted counter helped to find a
bug when running the "remove single subflow" subtest from the
mptcp_join.sh selftest.

Removing a 'subflow' endpoint will first trigger a RM_ADDR, then the
subflow closure. Before this patch, and upon the reception of the
RM_ADDR, the other peer will then try to decrement this
add_addr_accepted. That's not correct because the attached subflows have
not been created upon the reception of an ADD_ADDR.

A way to solve that is to decrement the counter only if the attached
subflow was an MP_JOIN to a remote id that was not 0, and initiated by
the host receiving the RM_ADDR.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-9-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4cf7cc851f80..882781571c7b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -829,7 +829,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			mptcp_close_ssk(sk, ssk, subflow);
 			spin_lock_bh(&msk->pm.lock);
 
-			removed = true;
+			removed |= subflow->request_join;
 			if (rm_type == MPTCP_MIB_RMSUBFLOW)
 				__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
@@ -843,7 +843,11 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		if (!mptcp_pm_is_kernel(msk))
 			continue;
 
-		if (rm_type == MPTCP_MIB_RMADDR) {
+		if (rm_type == MPTCP_MIB_RMADDR && rm_id &&
+		    !WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
+			/* Note: if the subflow has been closed before, this
+			 * add_addr_accepted counter will not be decremented.
+			 */
 			msk->pm.add_addr_accepted--;
 			WRITE_ONCE(msk->pm.accept_addr, true);
 		}


