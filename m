Return-Path: <stable+bounces-70205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EED895F0F8
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B581C2383F
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D4518892C;
	Mon, 26 Aug 2024 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ldXz4BdZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85F6146A61
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674174; cv=none; b=brbYn5o+ZTvIsfgAK3JXkGNeVYTT25FvZ2IbmsRtOyaLgp0SiuIMb3cO1HHfPsVMvnh42JN5vdI1xf42J7VNil7oQf50N6dN/8CaNyZWUyXhTH1cNl07jCqD44nGK5CAydPnZo2fmrDO3nF+7lDcnt6dSI1xAkxzQOD0p6RYawA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674174; c=relaxed/simple;
	bh=Edik8iZWrVQyD8Dkiw3c2sumXiA1yQKjFPr6h8+HtbA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=g4aDRtRJi61Bnq6qye8RG1UnaTJaCMAAPnHjIMnMn7Zfy685JFopUZpDe6Dnmzv+hzEloTze1ivSwfbw8nsEBzR+EuQnv3cEe9pzP5HMkxpVJR4ztA7ySB1VgfK7jXwCSZtPfQE33V1WbOe1S+8nNHnsq2W/vo4umqwsS5WmUtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ldXz4BdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4EDC4DDF6;
	Mon, 26 Aug 2024 12:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724674174;
	bh=Edik8iZWrVQyD8Dkiw3c2sumXiA1yQKjFPr6h8+HtbA=;
	h=Subject:To:Cc:From:Date:From;
	b=ldXz4BdZzF7eR2H4h23Ctk1vx8nsuKqZ09lp2xouLeA4/3/8Ty3FXkBNW6WgWg4MY
	 2z93Dc1YpUORu8937x5VIDtKtU9NbisijgfqmJXD1oTxO8bETMmZnPgH/tbFElnU2S
	 X01EMO0JUPGl9rsnok1Whw66M4wzEgLbCh9WjUnA=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: test for flush/re-add endpoints" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:09:20 +0200
Message-ID: <2024082619-chair-irritable-03aa@gregkh>
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
git cherry-pick -x e06959e9eebdfea4654390f53b65cff57691872e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082619-chair-irritable-03aa@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

e06959e9eebd ("selftests: mptcp: join: test for flush/re-add endpoints")
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

From e06959e9eebdfea4654390f53b65cff57691872e Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:24 +0200
Subject: [PATCH] selftests: mptcp: join: test for flush/re-add endpoints

After having flushed endpoints that didn't cause the creation of new
subflows, it is important to check endpoints can be re-created, re-using
previously used IDs.

Before the previous commit, the client would not have been able to
re-create the subflow that was previously rejected.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-6-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fbb0174145ad..f609c02c6123 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3651,6 +3651,36 @@ endpoint_tests()
 		chk_rm_nr 2 1 invert
 	fi
 
+	# flush and re-add
+	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 1 2
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		test_linkfail=4 speed=20 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+
+		wait_attempt_fail $ns2
+		chk_subflow_nr "before flush" 1
+		chk_mptcp_info subflows 0 subflows 0
+
+		pm_nl_flush_endpoint $ns2
+		pm_nl_flush_endpoint $ns1
+		wait_rm_addr $ns2 0
+		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_mpj $ns2
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
+		wait_mpj $ns2
+		mptcp_lib_kill_wait $tests_pid
+
+		chk_join_nr 2 2 2
+		chk_add_nr 2 2
+		chk_rm_nr 1 0 invert
+	fi
 }
 
 # [$1: error message]


