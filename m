Return-Path: <stable+bounces-179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4947F74EE
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA271281333
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B2723761;
	Fri, 24 Nov 2023 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cZJSSofy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B7628DBF
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 13:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F0DC433C8;
	Fri, 24 Nov 2023 13:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700832443;
	bh=/hjxFPBrhlIFfgkmuSPa4aW7XntEdMpelaZQyFI8au8=;
	h=Subject:To:Cc:From:Date:From;
	b=cZJSSofyrEQPhR+8/8c9c419qi8gTQzB6dXJo6RYJ6jr4qLBBesND0P22AT177bpZ
	 oFSlfMN1nS9rmIXG9HZ8GhMNOXZPonKnPvFZ/tu1p3Kfaz9jeC8igfJ3+hdizJbbNY
	 6GIEsAUl9016NN5pZOfZgP3oKCgxhxktrTWd8XNY=
Subject: FAILED: patch "[PATCH] selftests: mptcp: fix fastclose with csum failure" failed to apply to 6.1-stable tree
To: pabeni@redhat.com,kuba@kernel.org,matttbe@kernel.org,xmu@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 13:27:21 +0000
Message-ID: <2023112420-stillness-tanned-cbca@gregkh>
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
git cherry-pick -x 7cefbe5e1dacc7236caa77e9d072423f21422fe2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112420-stillness-tanned-cbca@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

7cefbe5e1dac ("selftests: mptcp: fix fastclose with csum failure")
595ef566a2ef ("selftests: mptcp: drop addr_nr_ns1/2 parameters")
0c93af1f8907 ("selftests: mptcp: drop test_linkfail parameter")
be7e9786c915 ("selftests: mptcp: set FAILING_LINKS in run_tests")
4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
ae947bb2c253 ("selftests: mptcp: join: skip Fastclose tests if not supported")
d4c81bbb8600 ("selftests: mptcp: join: support local endpoint being tracked or not")
4a0b866a3f7d ("selftests: mptcp: join: skip test if iptables/tc cmds fail")
0c4cd3f86a40 ("selftests: mptcp: join: use 'iptables-legacy' if available")
6c160b636c91 ("selftests: mptcp: update userspace pm subflow tests")
48d73f609dcc ("selftests: mptcp: update userspace pm addr tests")
8697a258ae24 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7cefbe5e1dacc7236caa77e9d072423f21422fe2 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 14 Nov 2023 00:16:17 +0100
Subject: [PATCH] selftests: mptcp: fix fastclose with csum failure

Running the mp_join selftest manually with the following command line:

  ./mptcp_join.sh -z -C

leads to some failures:

  002 fastclose server test
  # ...
  rtx                                 [fail] got 1 MP_RST[s] TX expected 0
  # ...
  rstrx                               [fail] got 1 MP_RST[s] RX expected 0

The problem is really in the wrong expectations for the RST checks
implied by the csum validation. Note that the same check is repeated
explicitly in the same test-case, with the correct expectation and
pass successfully.

Address the issue explicitly setting the correct expectation for
the failing checks.

Reported-by: Xiumei Mu <xmu@redhat.com>
Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-5-7b9cd6a7b7f4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 75a2438efdf3..3c94f2f194d6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3240,7 +3240,7 @@ fastclose_tests()
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
 		test_linkfail=1024 fastclose=server \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
+		chk_join_nr 0 0 0 0 0 0 1
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
 	fi


