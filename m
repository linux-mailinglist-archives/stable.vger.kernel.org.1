Return-Path: <stable+bounces-195359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB3AC756F1
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 18B14364D1C
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B422857F9;
	Thu, 20 Nov 2025 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2C+xAnBv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A00224B04
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656224; cv=none; b=KUMP8KL/ZeZ4EcpKcDqCwpDnCE72CoCnaJE4nTme+cTjMsZooO/dswgMM5TqA8uRyhZMMKkv8xCYfNlbbOfuU42QyZj1xiT+Zf04xin0nMzfGW1D7l7Pj4kqL/aAiwWApFde4x42EfZ1S4jgt0Ubf6Q0tQjCYuahkJlm8dNRtAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656224; c=relaxed/simple;
	bh=6gPBryJ7mQrrVKtXozcR1OIsgkHCeVLR1kkzaw9XRIg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TJ3xxQAzoqnrIA78jUC6CId0Iif4Po1jAGmP2Y/IDE9FWmunkrlvOQqvx9k/AtpHKblNL6K8m50ykpSj3xZImU+oCA0QMlAC3kfhGojouyBrFf9bsxCP+Fzsbr2IxTfKAX6Rh6sExQCbJahdAy+zDZ6pqwpSjLXXL2F6NPTXMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2C+xAnBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA05C4CEF1;
	Thu, 20 Nov 2025 16:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763656224;
	bh=6gPBryJ7mQrrVKtXozcR1OIsgkHCeVLR1kkzaw9XRIg=;
	h=Subject:To:Cc:From:Date:From;
	b=2C+xAnBvIlTESztKurWaB0LfTVc6iIgp2RXS6kTJGSJY1bFQ0roi6FmNq2cWfSoIo
	 AdDYMUoWhUqz0SpAZOxAjy+5KyR2708lRJrPstpweU/FNhUi8XX/CldIcpKK/ueR/j
	 OpR9rdJMTuHs6VX7mOzBrSiJ6NP6BNNJ64zMDUp0=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: rm: set backup flag" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:30:13 +0100
Message-ID: <2025112013-amusable-thesis-e973@gregkh>
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
git cherry-pick -x aea73bae662a0e184393d6d7d0feb18d2577b9b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112013-amusable-thesis-e973@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aea73bae662a0e184393d6d7d0feb18d2577b9b9 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 10 Nov 2025 19:23:41 +0100
Subject: [PATCH] selftests: mptcp: join: rm: set backup flag

Some of these 'remove' tests rarely fail because a subflow has been
reset instead of cleanly removed. This can happen when one extra subflow
which has never carried data is being closed (FIN) on one side, while
the other is sending data for the first time.

To avoid such subflows to be used right at the end, the backup flag has
been added. With that, data will be only carried on the initial subflow.

Fixes: d2c4333a801c ("selftests: mptcp: add testcases for removing addrs")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251110-net-mptcp-sft-join-unstable-v1-2-a4332c714e10@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 78a1aa4ecff2..9ed9ec7202d6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2532,7 +2532,7 @@ remove_tests()
 	if reset "remove single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
 		addr_nr_ns2=-1 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
@@ -2545,8 +2545,8 @@ remove_tests()
 	if reset "remove multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
 		addr_nr_ns2=-2 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
@@ -2557,7 +2557,7 @@ remove_tests()
 	# single address, remove
 	if reset "remove single address"; then
 		pm_nl_set_limits $ns1 0 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
 		pm_nl_set_limits $ns2 1 1
 		addr_nr_ns1=-1 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
@@ -2570,9 +2570,9 @@ remove_tests()
 	# subflow and signal, remove
 	if reset "remove subflow and signal"; then
 		pm_nl_set_limits $ns1 0 2
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
 		pm_nl_set_limits $ns2 1 2
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
 		addr_nr_ns1=-1 addr_nr_ns2=-1 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
@@ -2584,10 +2584,10 @@ remove_tests()
 	# subflows and signal, remove
 	if reset "remove subflows and signal"; then
 		pm_nl_set_limits $ns1 0 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
 		pm_nl_set_limits $ns2 1 3
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
+		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow,backup
 		addr_nr_ns1=-1 addr_nr_ns2=-2 speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
@@ -2599,9 +2599,9 @@ remove_tests()
 	# addresses remove
 	if reset "remove addresses"; then
 		pm_nl_set_limits $ns1 3 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup id 250
+		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal,backup
+		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal,backup
 		pm_nl_set_limits $ns2 3 3
 		addr_nr_ns1=-3 speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1
@@ -2614,10 +2614,10 @@ remove_tests()
 	# invalid addresses remove
 	if reset "remove invalid addresses"; then
 		pm_nl_set_limits $ns1 3 3
-		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal,backup
 		# broadcast IP: no packet for this address will be received on ns1
-		pm_nl_add_endpoint $ns1 224.0.0.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+		pm_nl_add_endpoint $ns1 224.0.0.1 flags signal,backup
+		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal,backup
 		pm_nl_set_limits $ns2 2 2
 		addr_nr_ns1=-3 speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1
@@ -2631,10 +2631,10 @@ remove_tests()
 	# subflows and signal, flush
 	if reset "flush subflows and signal"; then
 		pm_nl_set_limits $ns1 0 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
 		pm_nl_set_limits $ns2 1 3
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
+		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow,backup
 		addr_nr_ns1=-8 addr_nr_ns2=-8 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
@@ -2647,9 +2647,9 @@ remove_tests()
 	if reset "flush subflows"; then
 		pm_nl_set_limits $ns1 3 3
 		pm_nl_set_limits $ns2 3 3
-		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup id 150
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
+		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow,backup
 		addr_nr_ns1=-8 addr_nr_ns2=-8 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
@@ -2666,9 +2666,9 @@ remove_tests()
 	# addresses flush
 	if reset "flush addresses"; then
 		pm_nl_set_limits $ns1 3 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup id 250
+		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal,backup
+		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal,backup
 		pm_nl_set_limits $ns2 3 3
 		addr_nr_ns1=-8 addr_nr_ns2=-8 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
@@ -2681,9 +2681,9 @@ remove_tests()
 	# invalid addresses flush
 	if reset "flush invalid addresses"; then
 		pm_nl_set_limits $ns1 3 3
-		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal,backup
+		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal,backup
+		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal,backup
 		pm_nl_set_limits $ns2 3 3
 		addr_nr_ns1=-8 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1


