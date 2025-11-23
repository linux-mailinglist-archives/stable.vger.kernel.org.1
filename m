Return-Path: <stable+bounces-196624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C98C7E477
	for <lists+stable@lfdr.de>; Sun, 23 Nov 2025 17:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6AC4F343A71
	for <lists+stable@lfdr.de>; Sun, 23 Nov 2025 16:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58A71F2B88;
	Sun, 23 Nov 2025 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1EWC0Li"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A491819F40A
	for <stable@vger.kernel.org>; Sun, 23 Nov 2025 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763916960; cv=none; b=nF0z3RF9ALj1bNvvimPNJkAY0ueaKQhWhx5GEcD0tyEbOnwZqwbBm/UzpJoWSHMALS4/NyVt6dWBbklbYpPUKl+2l0BhlCxZI9X1iEiA1yaMUXpme4DvWbMr9AgxtthuqFaBI9Wb7k6CC12u3cWDWOrg9rwnDOrTUz1VE8OnQCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763916960; c=relaxed/simple;
	bh=bDrWytvlzBJfN6DbHeRyPAnoNNtMjYwXfqfOCuZTtQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DepbM8OxU6ONQzQxhFT1yDoqe5IzqlFc/KFOFqWaKalsgsxV+mXNjpEfHZ/orPqBHxXYQ1LBCCYrfiMk1kCq4DtlScjr+IKM8WZl+fRPT52TOLye1a/FUn8a4ta8k5+fi6X656xUQPInD0Ubu7L3IilxGfajHdk4N46EI9DT8G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1EWC0Li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CEBC113D0;
	Sun, 23 Nov 2025 16:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763916960;
	bh=bDrWytvlzBJfN6DbHeRyPAnoNNtMjYwXfqfOCuZTtQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p1EWC0Liri05dXO5GNlOjObY3HECKS4m+ajB/Y/rijmhKcsKDB4mRPAUWYOCNR6VQ
	 kYkSkP8T0WXxTl2XJ6ts0y5f0nrUobV8K7uY7ByLeOvvILCxomeU7DIAXl6IG83hBD
	 eqi6TKu0h0+MDMe6SKi2LN/KKkqRGdk6F9jzJm/DfjFa2EM55oCIUI3ompcQ6Qm8XK
	 ZSZXi67UGa0kS+cLiConBoTyTr8SDQacHEy0KkuccPkwZEMZoRbXUUCDB3sjV1Yqgi
	 4TpTXEtjnwN3KgGNNwFEFrt9QsXST+MUi3Uk9qUDDur3dVy6QXALQGWUBupX1NUgEZ
	 jeUuQiaPIn77g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] selftests: mptcp: join: endpoints: longer transfer
Date: Sun, 23 Nov 2025 11:55:57 -0500
Message-ID: <20251123165557.3491636-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112027-clench-amazingly-fc3f@gregkh>
References: <2025112027-clench-amazingly-fc3f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

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
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b9cc3d51dc285..3b10432fa6be0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3741,7 +3741,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		speed=slow \
+		test_linkfail=128 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 
@@ -3768,7 +3768,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		test_linkfail=4 speed=5 \
+		test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 
@@ -3845,7 +3845,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
-		test_linkfail=4 speed=5 \
+		test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 
@@ -3917,7 +3917,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		test_linkfail=4 speed=20 \
+		test_linkfail=128 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 
-- 
2.51.0


