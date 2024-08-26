Return-Path: <stable+bounces-70199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B11595F0F2
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C1828AA89
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F5E1862B9;
	Mon, 26 Aug 2024 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AIEu+Mwj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2816F827
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674143; cv=none; b=MOS99xQDvWVtKOFK6Tk5h4mVrjHh/PU/wLSnw1WcaSSvSzTEv6NMrskCkUR3fBvzIemP6iCBfZ5BRxi52qJo0QtMRn3kjyDbBcck1DpACSrx/STdlbVQTV5pBPCos+Dam2QslOC/eObxv5NRVx2Bv5aXgKzG0hmi1yAc9qaPmbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674143; c=relaxed/simple;
	bh=9K+0StABcAajl4AzZ6uhIIqpPi6s40aVZvioRM8GI6c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YlYgcRdU0l9h6PnGVeb6oClFOjLnaTraeM5w8GTJFiYf6rJa41wFt1RwC/5gJriwxyx09m6iGEMIf77k6Bec0d3yq6wPT7d7uPWyiqol/ICON6sRv6kjIdqDtPixTTHtudTvOtD/YoDiRrM6oMuPwvzDRhlKs3SqE6cZjbQM0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AIEu+Mwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BF5C4DDEC;
	Mon, 26 Aug 2024 12:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724674143;
	bh=9K+0StABcAajl4AzZ6uhIIqpPi6s40aVZvioRM8GI6c=;
	h=Subject:To:Cc:From:Date:From;
	b=AIEu+Mwj1EQXbAp9ntYxpJi4/cjjvmZxUESCSu4LCRX72SvAV5b823iOaIZSpn4V0
	 ef+y2GNi6qeDcbQVEm0w0km9bevuyMtolSmUdsf0LYWLMo8bE7S1dLj9Iv9wLQaajO
	 HMwcDmtPoYEujqzvppb6+SXA7msY4SUjr/cv+eAI=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: check re-using ID of closed subflow" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:09:00 +0200
Message-ID: <2024082600-chokehold-shininess-0f20@gregkh>
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
git cherry-pick -x 65fb58afa341ad68e71e5c4d816b407e6a683a66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082600-chokehold-shininess-0f20@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

65fb58afa341 ("selftests: mptcp: join: check re-using ID of closed subflow")
04b57c9e096a ("selftests: mptcp: join: stop transfer when check is done (part 2)")
b9fb176081fb ("selftests: mptcp: userspace pm send RM_ADDR for ID 0")
e3b47e460b4b ("selftests: mptcp: userspace pm remove initial subflow")
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
36c4127ae8dd ("selftests: mptcp: join: skip implicit tests if not supported")
ae947bb2c253 ("selftests: mptcp: join: skip Fastclose tests if not supported")
d4c81bbb8600 ("selftests: mptcp: join: support local endpoint being tracked or not")
4a0b866a3f7d ("selftests: mptcp: join: skip test if iptables/tc cmds fail")
0c4cd3f86a40 ("selftests: mptcp: join: use 'iptables-legacy' if available")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 65fb58afa341ad68e71e5c4d816b407e6a683a66 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:22 +0200
Subject: [PATCH] selftests: mptcp: join: check re-using ID of closed subflow

This test extends "delete and re-add" to validate the previous commit. A
new 'subflow' endpoint is added, but the subflow request will be
rejected. The result is that no subflow will be established from this
address.

Later, the endpoint is removed and re-added after having cleared the
firewall rule. Before the previous commit, the client would not have
been able to create this new subflow.

While at it, extra checks have been added to validate the expected
numbers of MPJ and RM_ADDR.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-4-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 25077ccf31d2..fbb0174145ad 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -436,9 +436,10 @@ reset_with_tcp_filter()
 	local ns="${!1}"
 	local src="${2}"
 	local target="${3}"
+	local chain="${4:-INPUT}"
 
 	if ! ip netns exec "${ns}" ${iptables} \
-			-A INPUT \
+			-A "${chain}" \
 			-s "${src}" \
 			-p tcp \
 			-j "${target}"; then
@@ -3571,10 +3572,10 @@ endpoint_tests()
 		mptcp_lib_kill_wait $tests_pid
 	fi
 
-	if reset "delete and re-add" &&
+	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		test_linkfail=4 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 &
@@ -3591,11 +3592,27 @@ endpoint_tests()
 		chk_subflow_nr "after delete" 1
 		chk_mptcp_info subflows 0 subflows 0
 
-		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add" 2
 		chk_mptcp_info subflows 1 subflows 1
+
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_attempt_fail $ns2
+		chk_subflow_nr "after new reject" 2
+		chk_mptcp_info subflows 1 subflows 1
+
+		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		pm_nl_del_endpoint $ns2 3 10.0.3.2
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_mpj $ns2
+		chk_subflow_nr "after no reject" 3
+		chk_mptcp_info subflows 2 subflows 2
+
 		mptcp_lib_kill_wait $tests_pid
+
+		chk_join_nr 3 3 3
+		chk_rm_nr 1 1
 	fi
 
 	# remove and re-add


