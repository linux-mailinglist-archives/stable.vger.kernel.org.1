Return-Path: <stable+bounces-196549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E097FC7B37F
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 19:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7F63A129B
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F9228AAEE;
	Fri, 21 Nov 2025 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOmNthQo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A571E5B95
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748416; cv=none; b=HT/ezdF4mZMCtRtOofNNqIwZRRLQRIz6aB2H8WHdepv4+Zl39DB9ol8q6AU0ul3k08upV0Zgehhro53/yEJLFKj3d5g/szyEEsesqtUojeQhUTzQkkmql7152yR7DykjFmb+S+ND0DhPVJWuzuTzszREV9MZgtOtHYjtG4kIlTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748416; c=relaxed/simple;
	bh=xpDk1MA+RgwtaJTs7OEv5Gjfzcu4RHFwdTcOrVQE9Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XD+8Nnx8DaHiSQEE9TDrU761z/sDCI+wR9+zUzL2EBHh19KZ75brbtdGpyD7luZLCHgU/oMkDjKOOnpGEq6ECr2sqQZH9/9X+HiXt8cuOaecc6CFgVfP7C33UkTPgUgmVgf4hi7JiXDT6m1gPcG4poIERQ5KYGkc69XW2Ez32ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOmNthQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD55C116C6;
	Fri, 21 Nov 2025 18:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748416;
	bh=xpDk1MA+RgwtaJTs7OEv5Gjfzcu4RHFwdTcOrVQE9Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lOmNthQofiiwP/7tge8NH36kU4jUir1ogbIGBRTdjiEpjuiayH6GntKupYSBPy8Aw
	 F8jsXC0yyhF3vrUY7T6vrFyhdRJMmVLt0iUY+POU1INelSXCQpQd4RkGwmGIX0KDBx
	 +P48DdT7dxjDn4n+Sr8gkRC1ot12ap9lwLC8XW6RG+vzo/4CzE4+WwnaqEgFQKn5T3
	 swsuMKLein2Ef2laiQyYgpxeLFqaej3urtHU+LxqfBAG80eztoROKFityNfzaEXC8t
	 Iwsz3d112AhCuRfujilYHTq6mYjXXRi9d+l7xpjgZDCkqKo7q8FZY2pLX2wpy7qHH6
	 iPm9Lwq2BMIjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: join: rm: set backup flag
Date: Fri, 21 Nov 2025 13:06:53 -0500
Message-ID: <20251121180653.2636754-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112012-gliding-propose-87a0@gregkh>
References: <2025112012-gliding-propose-87a0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit aea73bae662a0e184393d6d7d0feb18d2577b9b9 ]

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 54 +++++++++----------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d7dbbaa1f64ad..ecfd15be77e22 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2332,7 +2332,7 @@ remove_tests()
 	if reset "remove single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
@@ -2343,8 +2343,8 @@ remove_tests()
 	if reset "remove multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
@@ -2354,7 +2354,7 @@ remove_tests()
 	# single address, remove
 	if reset "remove single address"; then
 		pm_nl_set_limits $ns1 0 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
 		pm_nl_set_limits $ns2 1 1
 		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
 		chk_join_nr 1 1 1
@@ -2366,9 +2366,9 @@ remove_tests()
 	# subflow and signal, remove
 	if reset "remove subflow and signal"; then
 		pm_nl_set_limits $ns1 0 2
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
 		pm_nl_set_limits $ns2 1 2
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
@@ -2379,10 +2379,10 @@ remove_tests()
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
 		run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 speed_10
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
@@ -2393,9 +2393,9 @@ remove_tests()
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
 		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
 		chk_join_nr 3 3 3
@@ -2407,10 +2407,10 @@ remove_tests()
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
 		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
 		chk_join_nr 1 1 1
@@ -2422,10 +2422,10 @@ remove_tests()
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
 		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
@@ -2437,9 +2437,9 @@ remove_tests()
 	if reset "flush subflows"; then
 		pm_nl_set_limits $ns1 3 3
 		pm_nl_set_limits $ns2 3 3
-		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup id 150
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
+		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 		chk_join_nr 3 3 3
 
@@ -2454,9 +2454,9 @@ remove_tests()
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
 		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 		chk_join_nr 3 3 3
@@ -2468,9 +2468,9 @@ remove_tests()
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
 		run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
 		chk_join_nr 1 1 1
-- 
2.51.0


