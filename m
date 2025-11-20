Return-Path: <stable+bounces-195360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF33C756AC
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3D9E4EAB69
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5681A2D9497;
	Thu, 20 Nov 2025 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gr5zvgyy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1144E2C11FB
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656231; cv=none; b=CeZI3Gp+JE0u9mbMBGFbZopDdmEAWbIhNtn4nlipupnuGekWnl63r3stMdbT8JVBmpjTFnnlVFde0gJtmNa1NDquulGaUfZsUgGyz2+oG6WXjphpGYawLhWOh62vLTXCaa6CrLWsOjO5EoLUC7cUF8BrKAmHHOap/TEPuhpN+Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656231; c=relaxed/simple;
	bh=ImjdCnAVuZN73cMpMsw605X9CeHil8bGoFdu/qySHK0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t4obCZxg0J/cGW3uUWXD/tOErStFwAhwLo5rjOCgkWTG8Q4mzb7oF6PvyxPlN9dR+7ZRZurcQ4KeYB1/b0HIBqlMqizbVczKAOwv0TGAkD6gqNMEdr01pyd5BoN+ahD1N6LXFzztC6ZZuUD5NYes5+Vm8oShaMx3c4GC7EARMnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gr5zvgyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11200C4CEF1;
	Thu, 20 Nov 2025 16:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763656230;
	bh=ImjdCnAVuZN73cMpMsw605X9CeHil8bGoFdu/qySHK0=;
	h=Subject:To:Cc:From:Date:From;
	b=gr5zvgyyOlVBJ//UqXZlVAH/3LbZs/bJu52t/syM1/2/NcYNz7BJzPr7fTHGKy7OL
	 kccC4GQFoHZC3P/ujli6u4VERI6bwAriZcwIcUSSNniiZEwgzA/0grFqtHljQO+qzl
	 DCMfyrqrXhWadiaSYX42xpkp1gS87cLJG+mSAEls=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: endpoints: longer transfer" failed to apply to 6.6-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:30:27 +0100
Message-ID: <2025112027-clench-amazingly-fc3f@gregkh>
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
git cherry-pick -x 6457595db9870298ee30b6d75287b8548e33fe19
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112027-clench-amazingly-fc3f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6457595db9870298ee30b6d75287b8548e33fe19 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 10 Nov 2025 19:23:42 +0100
Subject: [PATCH] selftests: mptcp: join: endpoints: longer transfer

In rare cases, when the test environment is very slow, some userspace
tests can fail because some expected events have not been seen.

Because the tests are expecting a long on-going connection, and they are
not waiting for the end of the transfer, it is fine to make the
connection longer. This connection will be killed at the end, after the
verifications, so making it longer doesn't change anything, apart from
avoid it to end before the end of the verifications

To play it safe, all endpoints tests not waiting for the end of the
transfer are now sharing a longer file (128KB) at slow speed.

Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
Cc: stable@vger.kernel.org
Fixes: e274f7154008 ("selftests: mptcp: add subflow limits test-cases")
Fixes: b5e2fb832f48 ("selftests: mptcp: add explicit test case for remove/readd")
Fixes: e06959e9eebd ("selftests: mptcp: join: test for flush/re-add endpoints")
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251110-net-mptcp-sft-join-unstable-v1-3-a4332c714e10@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9ed9ec7202d6..97af8d89ac5c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3943,7 +3943,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		{ speed=slow \
+		{ test_linkfail=128 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
@@ -3970,7 +3970,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		{ test_linkfail=4 speed=5 \
+		{ test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
@@ -4048,7 +4048,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
-		{ test_linkfail=4 speed=5 \
+		{ test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
@@ -4121,7 +4121,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		{ test_linkfail=4 speed=20 \
+		{ test_linkfail=128 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 


