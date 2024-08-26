Return-Path: <stable+bounces-70209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082F895F0FB
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE031C23498
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9A21891BA;
	Mon, 26 Aug 2024 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OqYK8N14"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31F11714B5
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674189; cv=none; b=mxs5oAH1zCQx6vi1jWgbSuLWMjJ7NB6c9mTLHk5GgSubsoK/LtEGky7l+Rz/NMA2XnbcR0cddZ4qUr/bWFsWR3UZe2nrGFfvAqcXeJ+n8+w3aw7ZDvI0unGZIgF/OtSa6M8MA4QqGUv07bgWixVRY7kgGXTEaodpWdLC3lJcDtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674189; c=relaxed/simple;
	bh=Wrv8HEVm/B2LEPI2WuJBU2O8wV3nPqVwnmG+n8FSMhc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SevHcuD3GZWqTOLwyRikrR8/5S9n3VofX5Cvvtj2QmVIn6n5q2ht2WE0r+FqPeEM88kYbP3t9XERWlI8o7mU0RkJ/024+HOt5oQ0G1d5Sfiw5VJxdEDhlLqTvllrWXiwhOrfl33Kgg9vnX56JKfpEEc0NdwjWQqMSo5thrVpSIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OqYK8N14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4416AC4DE03;
	Mon, 26 Aug 2024 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724674189;
	bh=Wrv8HEVm/B2LEPI2WuJBU2O8wV3nPqVwnmG+n8FSMhc=;
	h=Subject:To:Cc:From:Date:From;
	b=OqYK8N140+cFCbrEwWMdI5WdTNksjHYwks2jdFScuQC9ACh65fAxTtZLVYiqVLzsh
	 hO5XGjcOIgbxzBtSSDoBZwfJAPDkAoIABj6rsqPhiEW0IiTqy28CjVNCeGNXIUYwod
	 AiWUkjkDvXt1uRbH3l3vPmgGfHhGNFSWuAPMf3Fo=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: check re-using ID of unused ADD_ADDR" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:09:28 +0200
Message-ID: <2024082628-stapling-dad-555c@gregkh>
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
git cherry-pick -x a13d5aad4dd9a309eecdc33cfd75045bd5f376a3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082628-stapling-dad-555c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

a13d5aad4dd9 ("selftests: mptcp: join: check re-using ID of unused ADD_ADDR")
b5e2fb832f48 ("selftests: mptcp: add explicit test case for remove/readd")
ae7bd9ccecc3 ("selftests: mptcp: join: option to execute specific tests")
e59300ce3ff8 ("selftests: mptcp: join: reset failing links")
3afd0280e7d3 ("selftests: mptcp: join: define tests groups once")
3c082695e78b ("selftests: mptcp: drop msg argument of chk_csum_nr")
69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
d045b9eb95a9 ("mptcp: introduce implicit endpoints")
6fa0174a7c86 ("mptcp: more careful RM_ADDR generation")
f98c2bca7b2b ("selftests: mptcp: Rename wait function")
826d7bdca833 ("selftests: mptcp: join: allow running -cCi")
7d9bf018f907 ("selftests: mptcp: update output info of chk_rm_nr")
26516e10c433 ("selftests: mptcp: add more arguments for chk_join_nr")
8117dac3e7c3 ("selftests: mptcp: add invert check in check_transfer")
01542c9bf9ab ("selftests: mptcp: add fastclose testcase")
cbfafac4cf8f ("selftests: mptcp: add extra_args in do_transfer")
922fd2b39e5a ("selftests: mptcp: add the MP_RST mibs check")
e8e947ef50f6 ("selftests: mptcp: add the MP_FASTCLOSE mibs check")
9a0a93672c14 ("selftests: mptcp: adjust output alignment for more tests")
aaa25a2fa796 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a13d5aad4dd9a309eecdc33cfd75045bd5f376a3 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:20 +0200
Subject: [PATCH] selftests: mptcp: join: check re-using ID of unused ADD_ADDR

This test extends "delete re-add signal" to validate the previous
commit. An extra address is announced by the server, but this address
cannot be used by the client. The result is that no subflow will be
established to this address.

Later, the server will delete this extra endpoint, and set a new one,
with a valid address, but re-using the same ID. Before the previous
commit, the server would not have been able to announce this new
address.

While at it, extra checks have been added to validate the expected
numbers of MPJ, ADD_ADDR and RM_ADDR.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-2-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9ea6d698e9d3..25077ccf31d2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3601,9 +3601,11 @@ endpoint_tests()
 	# remove and re-add
 	if reset "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		test_linkfail=4 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
@@ -3615,15 +3617,21 @@ endpoint_tests()
 		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_del_endpoint $ns1 1 10.0.2.1
+		pm_nl_del_endpoint $ns1 2 224.0.0.1
 		sleep 0.5
 		chk_subflow_nr "after delete" 1
 		chk_mptcp_info subflows 0 subflows 0
 
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
 		wait_mpj $ns2
-		chk_subflow_nr "after re-add" 2
-		chk_mptcp_info subflows 1 subflows 1
+		chk_subflow_nr "after re-add" 3
+		chk_mptcp_info subflows 2 subflows 2
 		mptcp_lib_kill_wait $tests_pid
+
+		chk_join_nr 3 3 3
+		chk_add_nr 4 4
+		chk_rm_nr 2 1 invert
 	fi
 
 }


