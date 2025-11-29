Return-Path: <stable+bounces-197643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339E6C94491
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 17:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1643A5EA1
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 16:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CABB217659;
	Sat, 29 Nov 2025 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJKNB4ZS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DDA1DFD96;
	Sat, 29 Nov 2025 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764435348; cv=none; b=iDiPJF9wwClqETh+ipwHz8h3JnVOnuIZEgli5DuSq19K2rzVC60pX6TfE8rg+w2KMVyiCBHNO0l/uIW+Uq9IMRwQkBD7sOC1Jw9BYt5dCazbeM3AuFMs9buMztq6oRs/Ga/4sungayh/jANnF4LDRlrnFGrFG5H5qWmnixRDvi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764435348; c=relaxed/simple;
	bh=Zhh6dHTOJ+CBhruhJ6LnEqoBS250ILVGbB8B2h58rls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S33U5qqNaL5DQGGmq7YrRHXHgiojrTDLfUUrYoQQPDOa8sJwIySXp6JOoQ8Q0qwv6jMOGLspxZaohziEpjmAm3MFVDkgLzUl5ulSwsfKztCV88TVPIV6b+uOeCHyb95VPKHBg0UZ8dgMegtTDq4LOGp/C8nOe2v4VV32cQgmf/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJKNB4ZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1508C4CEF7;
	Sat, 29 Nov 2025 16:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764435347;
	bh=Zhh6dHTOJ+CBhruhJ6LnEqoBS250ILVGbB8B2h58rls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJKNB4ZS9e4Tp9PTtxT/cppnpxj+z2IOAuF53sfAXDTh0IzbO/pF+WLvP4JRFjZQJ
	 uTYopIMeNv7P2QQKRQN+7tDyH0ItpuO4D2bqr6R/UMa2G0xQF50TLOR3cT2ukARO6i
	 PUbGYWU1p1+OyaBEKGVC8EXgFBhf5YPj1eJwmcUgTI/tRgF2Dmaa8G0nQH/6wvnu0Z
	 ulP8A9/GnT3H/BRMcM+aTvYG/wWiDxi1bwuRYkjbQQZx9F1D4e8Odef8KykFF4bsSp
	 g4p6n4gozTptEApoLvu3CXjIbttIq/xqBIXHN0SOjHUY62YtexNy3mCfob8v22PnHy
	 71UadPV9qL0ow==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: join: endpoints: longer transfer
Date: Sat, 29 Nov 2025 17:55:11 +0100
Message-ID: <20251129165510.2124040-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112028-sly-exclude-8f08@gregkh>
References: <2025112028-sly-exclude-8f08@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3609; i=matttbe@kernel.org; h=from:subject; bh=Zhh6dHTOJ+CBhruhJ6LnEqoBS250ILVGbB8B2h58rls=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK1VfOX/X237ve0uVuFJRO2Gqod+J0R9Eg9rbKzOUrz2 C+hpV9ZOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACayLoXhf86rVcFrD3Z8yE9n in0Z3hbmdl3sgXtIcGOjuffpGfPW9DAyzHgY3KwwL/vGoYCDHqHrqy4rGnkfC/659vDkaXub2Dh WcQEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

[ Upstream commit 6457595db9870298ee30b6d75287b8548e33fe19 ]

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
[ removed curly braces and stderr redirection ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Conflicts in mptcp_join.sh because commit 0c93af1f8907 ("selftests:
  mptcp: drop test_linkfail parameter") is not in this version. It moved
  the 4th parameter to an env var. To fix the conflicts, the new value
  simply needs to be added as the 4th argument instead of an env var. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e435e30e0d93..9f73297b69da 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3313,7 +3313,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 128 0 0 slow 2>/dev/null &
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3336,7 +3336,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_5 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 128 0 0 speed_5 2>/dev/null &
 		local tests_pid=$!
 
 		wait_mpj $ns2
@@ -3401,7 +3401,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_5 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 128 0 0 speed_5 2>/dev/null &
 		local tests_pid=$!
 
 		wait_mpj $ns2
@@ -3464,7 +3464,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 128 0 0 speed_20 2>/dev/null &
 		local tests_pid=$!
 
 		wait_attempt_fail $ns2
-- 
2.51.0


