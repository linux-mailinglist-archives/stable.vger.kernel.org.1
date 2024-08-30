Return-Path: <stable+bounces-71601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFA5965F1F
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE38E28B517
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23D4186605;
	Fri, 30 Aug 2024 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jz2na/r5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6CD17B516
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013633; cv=none; b=SgXH/+UXilZdp+6Ml0JGrhdlguI8zH5sAZEDW4sYapMy7LKo52OUnXNcTJPdROz/5Kf6RjBJIKy+HggJsWfQDfKhUVcEp3VL1NBQWYB/a2kT7DN+Nb3Z95tcQwyWOAPTs+shI63eRUTHoPnR6Ug4E2eNHO5jQKfMKXfOahW6zYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013633; c=relaxed/simple;
	bh=WF9xixVinSpTz2euMbI2Eu6cCjHOQcRgbrDQaJKFr9w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YW5YbW1u5TruQ203URhVVkn8xwWqOi75axiDtikEZ1nT/BQS6FHsXg5KsQT36JJT5ze7FP5MFRbhDNVT+gMN9Ruc11K1pxZNLT4TrdVeAANUQmUwH0rbUE1SdLVp5ca31WjTQLEnPgo/DY+WWYAm3P2jjjOarJwj9iiHaTU6zw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jz2na/r5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5CEC4CEC6;
	Fri, 30 Aug 2024 10:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725013632;
	bh=WF9xixVinSpTz2euMbI2Eu6cCjHOQcRgbrDQaJKFr9w=;
	h=Subject:To:Cc:From:Date:From;
	b=jz2na/r5pu26T75Of1fHZzeOPITkTQAZ4uQA18ItlX3YMmBGbjjC4MnMdnlwPdJiJ
	 kC7r9v8svHzRA+Y+sfaxMnWU2XVH1yHl3m92xg8WDClsu318NFHQOiugGvYKYxp71o
	 H9gD/vgAEGsLU0J+xwye8pBrRXFXK1nUa0PSYrh0=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: check removing ID 0 endpoint" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Aug 2024 12:27:09 +0200
Message-ID: <2024083009-escapable-arguable-125f@gregkh>
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
git cherry-pick -x 5f94b08c001290acda94d9d8868075590931c198
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024083009-escapable-arguable-125f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

5f94b08c0012 ("selftests: mptcp: join: check removing ID 0 endpoint")
65fb58afa341 ("selftests: mptcp: join: check re-using ID of closed subflow")
40061817d95b ("selftests: mptcp: join: fix dev in check_endpoint")
04b57c9e096a ("selftests: mptcp: join: stop transfer when check is done (part 2)")
b9fb176081fb ("selftests: mptcp: userspace pm send RM_ADDR for ID 0")
e3b47e460b4b ("selftests: mptcp: userspace pm remove initial subflow")
03668c65d153 ("selftests: mptcp: join: rework detailed report")
7f117cd37c61 ("selftests: mptcp: join: format subtests results in TAP")
e571fb09c893 ("selftests: mptcp: add speed env var")
4aadde088a58 ("selftests: mptcp: add fullmesh env var")
080b7f5733fd ("selftests: mptcp: add fastclose env var")
662aa22d7dcd ("selftests: mptcp: set all env vars as local ones")
9e9d176df8e9 ("selftests: mptcp: add pm_nl_set_endpoint helper")
1534f87ee0dc ("selftests: mptcp: drop sflags parameter")
595ef566a2ef ("selftests: mptcp: drop addr_nr_ns1/2 parameters")
0c93af1f8907 ("selftests: mptcp: drop test_linkfail parameter")
be7e9786c915 ("selftests: mptcp: set FAILING_LINKS in run_tests")
d7ced753aa85 ("selftests: mptcp: check subflow and addr infos")
4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
00079f18c24f ("selftests: mptcp: join: skip check if MIB counter not supported (part 2)")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5f94b08c001290acda94d9d8868075590931c198 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:26 +0200
Subject: [PATCH] selftests: mptcp: join: check removing ID 0 endpoint

Removing the endpoint linked to the initial subflow should trigger a
RM_ADDR for the right ID, and the removal of the subflow. That's what is
now being verified in the "delete and re-add" test.

Note that removing the initial subflow will not decrement the 'subflows'
counters, which corresponds to the *additional* subflows. On the other
hand, when the same endpoint is re-added, it will increment this
counter, as it will be seen as an additional subflow this time.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 264040a760c6..8b4529ff15e5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3572,8 +3572,9 @@ endpoint_tests()
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 0 2
+		pm_nl_set_limits $ns1 0 3
+		pm_nl_set_limits $ns2 0 3
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		test_linkfail=4 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 &
@@ -3582,17 +3583,17 @@ endpoint_tests()
 		wait_mpj $ns2
 		pm_nl_check_endpoint "creation" \
 			$ns2 10.0.2.2 id 2 flags subflow dev ns2eth2
-		chk_subflow_nr "before delete" 2
+		chk_subflow_nr "before delete id 2" 2
 		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
 		sleep 0.5
-		chk_subflow_nr "after delete" 1
+		chk_subflow_nr "after delete id 2" 1
 		chk_mptcp_info subflows 0 subflows 0
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
-		chk_subflow_nr "after re-add" 2
+		chk_subflow_nr "after re-add id 2" 2
 		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
@@ -3607,10 +3608,20 @@ endpoint_tests()
 		chk_subflow_nr "after no reject" 3
 		chk_mptcp_info subflows 2 subflows 2
 
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		sleep 0.5
+		chk_subflow_nr "after delete id 0" 2
+		chk_mptcp_info subflows 2 subflows 2 # only decr for additional sf
+
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
+		wait_mpj $ns2
+		chk_subflow_nr "after re-add id 0" 3
+		chk_mptcp_info subflows 3 subflows 3
+
 		mptcp_lib_kill_wait $tests_pid
 
-		chk_join_nr 3 3 3
-		chk_rm_nr 1 1
+		chk_join_nr 4 4 4
+		chk_rm_nr 2 2
 	fi
 
 	# remove and re-add


