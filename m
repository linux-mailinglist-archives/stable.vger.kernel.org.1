Return-Path: <stable+bounces-24239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 036FF86934B
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE3E282A76
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F15D13AA55;
	Tue, 27 Feb 2024 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Z3J7AuY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F35B13A25D;
	Tue, 27 Feb 2024 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041419; cv=none; b=Fcd2UPQ/EiFCwbiayjRmnYUCoJuuRilgw43Xz2OS8gWXQwlg3j6EVL8Mu4S4NLVxqMVBer7WxhkNkovhjqggZPXl7aIC70snxfu91FgS44H/ccc/wDHJmwmuk4dLUE63d5BA7rbty64/HkuUUA02BuQ0gjS3eZRbbXM1pdVkIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041419; c=relaxed/simple;
	bh=IP0JscJYBt34ipl9xRqas4WfOqRU4Ojo2bdayiURJYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsZuakCtN7YGUCXcp3dzD08Z1yTj+QkVadZpOKUQYj1pB5R0f4o00KJhflH+VRpUVsnaeFmDMrBnb/Qh3FrHPPsvxOPzGzaEFNrpBb8Ko0gNdlG9m85T1gxQJZdsS4bANOcFFinBtKPM6I/us6DnG7AyfkGhhbe33nQv3UcNNJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Z3J7AuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D46C43394;
	Tue, 27 Feb 2024 13:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041419;
	bh=IP0JscJYBt34ipl9xRqas4WfOqRU4Ojo2bdayiURJYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0Z3J7AuY/Heh2TkWlDa7Li8Yo8Fl3W3HITwdNUshZA8mp/x0vFNpMhztyxEb7lGCS
	 JLq08F7cpYEx68QA6+A4Np2hnG+KFabEiJ559dO9/P1W92MSyA6Frm2G91i0YIVxPx
	 m7YzWDF7jMg+HYOfJvJyBF7MzetK1vrDyAo2LrOA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH 6.7 333/334] selftests: mptcp: join: stop transfer when check is done (part 2)
Date: Tue, 27 Feb 2024 14:23:11 +0100
Message-ID: <20240227131641.895829765@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu Baerts (NGI0) <matttbe@kernel.org>

commit 04b57c9e096a9479fe0ad31e3956e336fa589cb2 upstream.

Since the "Fixes" commits mentioned below, the newly added "userspace
pm" subtests of mptcp_join selftests are launching the whole transfer in
the background, do the required checks, then wait for the end of
transfer.

There is no need to wait longer, especially because the checks at the
end of the transfer are ignored (which is fine). This saves quite a few
seconds on slow environments.

While at it, use 'mptcp_lib_kill_wait()' helper everywhere, instead of
on a specific one with 'kill_tests_wait()'.

Fixes: b2e2248f365a ("selftests: mptcp: userspace pm create id 0 subflow")
Fixes: e3b47e460b4b ("selftests: mptcp: userspace pm remove initial subflow")
Fixes: b9fb176081fb ("selftests: mptcp: userspace pm send RM_ADDR for ID 0")
Cc: stable@vger.kernel.org
Reviewed-and-tested-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240131-upstream-net-20240131-mptcp-ci-issues-v1-9-4c1c11e571ff@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -688,13 +688,6 @@ kill_events_pids()
 	mptcp_lib_kill_wait $evts_ns2_pid
 }
 
-kill_tests_wait()
-{
-	#shellcheck disable=SC2046
-	kill -SIGUSR1 $(ip netns pids $ns2) $(ip netns pids $ns1)
-	wait
-}
-
 pm_nl_set_limits()
 {
 	local ns=$1
@@ -3466,7 +3459,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		speed=slow \
-			run_tests $ns1 $ns2 10.0.1.1 2>/dev/null &
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint "creation" \
@@ -3481,7 +3475,7 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
-		kill_tests_wait
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	if reset "delete and re-add" &&
@@ -3490,7 +3484,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		test_linkfail=4 speed=20 \
-			run_tests $ns1 $ns2 10.0.1.1 2>/dev/null &
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
 
 		wait_mpj $ns2
 		chk_subflow_nr "before delete" 2
@@ -3505,7 +3500,7 @@ endpoint_tests()
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add" 2
 		chk_mptcp_info subflows 1 subflows 1
-		kill_tests_wait
+		mptcp_lib_kill_wait $tests_pid
 	fi
 }
 



