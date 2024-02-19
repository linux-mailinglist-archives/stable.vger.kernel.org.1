Return-Path: <stable+bounces-20557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 147FD85A815
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C461E2824D0
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B973A8CC;
	Mon, 19 Feb 2024 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2nZNmfiO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FAA3399C
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358617; cv=none; b=XMIt90GHCetX6mUXH6iaslNp91qDYD/JfN0R36Wf0J0BgXVbxG9LQlvxnR7HRUvmoammKbUg2mq0kJTREQHAi/6sgFnZnOFukP3NaZflqneWuuYXP320VrnyIHMs3JcLVRUwyUdJrnUT1UZnmKizhBaPdQBTGS5/evqBLlVQYyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358617; c=relaxed/simple;
	bh=Q1e7c67p5HoZ4nOwe44oKQFi8ZZUk73F3wX/s497bSU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aTyQik6+H9BPNc6c2oLagDpWGsBLJUUUWmnWTjpMGhZzzIhdx0F0PyVDJWpMTe8dfRdragpLyvo80oPlRFMZyhhrDA/obCvyhl9ozJz2KXrk1WgCfJa6l6eiIvqjZQZxSrU6R/ARSHuVMdrv1DaQZftqfumau2BouBRaor6IWNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2nZNmfiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3265BC433F1;
	Mon, 19 Feb 2024 16:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708358616;
	bh=Q1e7c67p5HoZ4nOwe44oKQFi8ZZUk73F3wX/s497bSU=;
	h=Subject:To:Cc:From:Date:From;
	b=2nZNmfiOfE09QePpxObKSpV5gY9i42i7C0Glqsu8+/3yJhSNJ+/fPYPyQ7ylbsW44
	 5FU4k1q2ZLXfBxr8+78rsH9TOWQe8rYBYomTZii+iSaUKO3vfke9ircLL0ZTfdEPdq
	 geU717Io97H096cqHB4vUZcgRsFMVkSU5nRVY6lI=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: stop transfer when check is done" failed to apply to 6.7-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:03:25 +0100
Message-ID: <2024021925-saloon-pursuit-2736@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x 04b57c9e096a9479fe0ad31e3956e336fa589cb2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021925-saloon-pursuit-2736@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

04b57c9e096a ("selftests: mptcp: join: stop transfer when check is done (part 2)")
b9fb176081fb ("selftests: mptcp: userspace pm send RM_ADDR for ID 0")
e3b47e460b4b ("selftests: mptcp: userspace pm remove initial subflow")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 04b57c9e096a9479fe0ad31e3956e336fa589cb2 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jan 2024 22:49:54 +0100
Subject: [PATCH] selftests: mptcp: join: stop transfer when check is done
 (part 2)

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

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 85bcc95f4ede..c07386e21e0a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -643,13 +643,6 @@ kill_events_pids()
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
@@ -3494,7 +3487,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	# userspace pm remove initial subflow
@@ -3518,7 +3511,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	# userspace pm send RM_ADDR for ID 0
@@ -3544,7 +3537,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 }
 
@@ -3558,7 +3551,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		speed=slow \
-			run_tests $ns1 $ns2 10.0.1.1 2>/dev/null &
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint "creation" \
@@ -3573,7 +3567,7 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
-		kill_tests_wait
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	if reset "delete and re-add" &&
@@ -3582,7 +3576,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		test_linkfail=4 speed=20 \
-			run_tests $ns1 $ns2 10.0.1.1 2>/dev/null &
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
 
 		wait_mpj $ns2
 		chk_subflow_nr "before delete" 2
@@ -3597,7 +3592,7 @@ endpoint_tests()
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add" 2
 		chk_mptcp_info subflows 1 subflows 1
-		kill_tests_wait
+		mptcp_lib_kill_wait $tests_pid
 	fi
 }
 


