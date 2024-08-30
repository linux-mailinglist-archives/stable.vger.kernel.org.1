Return-Path: <stable+bounces-71615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 949C5965F3C
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180791F22258
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271041898FE;
	Fri, 30 Aug 2024 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GZ13SmTJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCDE17C20F
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013730; cv=none; b=nSVNPQFrn6K4oQKS/JrYrqGaGqEWDWMMMOpVBWFZphMW+/h18YF8cyZYTjHjn142VWHyZrRdLyWdHLaziocwfiuIkFKEXol4nLgR3kkmJGwq84/XjpU1T7gSuiardYvy+kEest76Kyma+qVQcOiyCLzS1xawuzbC0AVCRECJ+qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013730; c=relaxed/simple;
	bh=QTflr5zyDvRbTpedG3lImC/KTJjxCApRNNyv/L49LbY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=or6glXcSaNG5ZQEzsL2iU9qGZhfDTqlGCJ2zYqkEIRtMmFPvENqGxlncEuHYR/e8NmSfgD3WsMH7ksw7QJaOw8+Ux+jb6PTKsSUTj03Ve9PyhFnvMCQEHZ78GVPVknAeMEGNIWxbFk4ZpMc+GhpE8FKhUMatLmaJXkmFOTxjZDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GZ13SmTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16ECEC4CEC2;
	Fri, 30 Aug 2024 10:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725013730;
	bh=QTflr5zyDvRbTpedG3lImC/KTJjxCApRNNyv/L49LbY=;
	h=Subject:To:Cc:From:Date:From;
	b=GZ13SmTJatsMvi9chNRMB2C4xtiw43Gc/FoARayQ4iz420u8atSJRdiA5KZ4kCYe3
	 4Sf31JrKc0qjgrNiYzuE/tDn9U20LMy+MiNR1o5IXIfBkZ2sBGXrOffr6ttKl/m3g6
	 MIS6J9idrCcXBV+Mia6DHu6M/+g7EFgQ1VZycohU=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: check re-re-adding ID 0 signal" failed to apply to 6.6-stable tree
To: matttbe@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Aug 2024 12:28:32 +0200
Message-ID: <2024083032-bodacious-swifter-6f19@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f18fa2abf81099d822d842a107f8c9889c86043c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024083032-bodacious-swifter-6f19@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

f18fa2abf810 ("selftests: mptcp: join: check re-re-adding ID 0 signal")
20ccc7c5f7a3 ("selftests: mptcp: join: validate event numbers")
d397d7246c11 ("selftests: mptcp: join: check re-re-adding ID 0 endp")
1c2326fcae4f ("selftests: mptcp: join: check re-adding init endp with != id")
5f94b08c0012 ("selftests: mptcp: join: check removing ID 0 endpoint")
65fb58afa341 ("selftests: mptcp: join: check re-using ID of closed subflow")
a13d5aad4dd9 ("selftests: mptcp: join: check re-using ID of unused ADD_ADDR")
b5e2fb832f48 ("selftests: mptcp: add explicit test case for remove/readd")
40061817d95b ("selftests: mptcp: join: fix dev in check_endpoint")
23a0485d1c04 ("selftests: mptcp: declare event macros in mptcp_lib")
35bc143a8514 ("selftests: mptcp: add mptcp_lib_events helper")
3a0f9bed3c28 ("selftests: mptcp: add mptcp_lib_ns_init/exit helpers")
3fb8c33ef4b9 ("selftests: mptcp: add mptcp_lib_check_tools helper")
7c2eac649054 ("selftests: mptcp: stop forcing iptables-legacy")
4cc5cc7ca052 ("selftests: mptcp: userspace pm get addr tests")
38f027fca1b7 ("selftests: mptcp: dump userspace addrs list")
2d0c1d27ea4e ("selftests: mptcp: add mptcp_lib_check_output helper")
9480f388a2ef ("selftests: mptcp: join: add ss mptcp support check")
7092dbee2328 ("selftests: mptcp: rm subflow with v4/v4mapped addr")
04b57c9e096a ("selftests: mptcp: join: stop transfer when check is done (part 2)")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f18fa2abf81099d822d842a107f8c9889c86043c Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:38 +0200
Subject: [PATCH] selftests: mptcp: join: check re-re-adding ID 0 signal

This test extends "delete re-add signal" to validate the previous
commit: when the 'signal' endpoint linked to the initial subflow (ID 0)
is re-added multiple times, it will re-send the ADD_ADDR with id 0. The
client should still be able to re-create this subflow, even if the
add_addr_accepted limit has been reached as this special address is not
considered as a new address.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a8ea0fe200fb..a4762c49a878 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3688,7 +3688,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
-		test_linkfail=4 speed=20 \
+		test_linkfail=4 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 
@@ -3717,7 +3717,17 @@ endpoint_tests()
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
 		wait_mpj $ns2
-		chk_subflow_nr "after re-add" 3
+		chk_subflow_nr "after re-add ID 0" 3
+		chk_mptcp_info subflows 3 subflows 3
+
+		pm_nl_del_endpoint $ns1 99 10.0.1.1
+		sleep 0.5
+		chk_subflow_nr "after re-delete ID 0" 2
+		chk_mptcp_info subflows 2 subflows 2
+
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 88 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "after re-re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
 		mptcp_lib_kill_wait $tests_pid
 
@@ -3727,19 +3737,19 @@ endpoint_tests()
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_ANNOUNCED 0
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_REMOVED 0
-		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
-		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 3
 
 		chk_evt_nr ns2 MPTCP_LIB_EVENT_CREATED 1
 		chk_evt_nr ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 5
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 3
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 6
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 4
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 3
 
-		chk_join_nr 4 4 4
-		chk_add_nr 5 5
-		chk_rm_nr 3 2 invert
+		chk_join_nr 5 5 5
+		chk_add_nr 6 6
+		chk_rm_nr 4 3 invert
 	fi
 
 	# flush and re-add


