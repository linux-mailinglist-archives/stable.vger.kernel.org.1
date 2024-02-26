Return-Path: <stable+bounces-23751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624E186800F
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 19:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84EC01C21A31
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 18:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CDE12E1F0;
	Mon, 26 Feb 2024 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbcRqoqN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CCC12C53D;
	Mon, 26 Feb 2024 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973523; cv=none; b=mOyRwlhtGakFEeYIkIbZI5pN4ga9eeuV1FfJyF1XYQ3NdnWNSRooz3l29cCZ43drZ5YPfw53FPZvyVdRKsyh6UIfoJh6VrxDVog/oMM3caARtWIykWYyknkB5XKlAoV5IL2RVqsnYdUcCfvGpTFyNhbjBA4cXgLzgbLzl6EaGjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973523; c=relaxed/simple;
	bh=47Mrczbm6Bhgwrm2+aie1DoEAUeq8NsaAuERKwQoZAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZ8rIjg1zMlm/pLkQL5aC2Lk2ba4fj0YqXVW826VWVTld6jVJdkmfgep9Y6jJHHPPuq3+4ZrwnTyhhyTGCViQCCXTALqJ2mCqBK+P4k/tBF5Vd5KBFuC9XQJMPKa79k2243WhEv7sqc+9p2lH5oXCM7L/auNYrWSVUm79nUIQgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbcRqoqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE25C43394;
	Mon, 26 Feb 2024 18:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708973523;
	bh=47Mrczbm6Bhgwrm2+aie1DoEAUeq8NsaAuERKwQoZAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SbcRqoqNwuV/TEE2IWi/GcL8sJI7heYSLkaHOKfyLy9dTzVKryLsg+geskCdHdgri
	 oxKiyYkfggFiP6PnZzts1t7NBGL1pOe3DWWwMicsid3KOhSdmJJ0DaCiqfNMxolpIn
	 uYCR9qDuxblgQR6mjvLesKpHXBkIc1nfWZGS36PwaOCYHC68NG/kkhVeOIS5sxGWCo
	 9WdGErwIc6+03HsdvHvefnoBU5zQUPJUJc+TLExikSJM5LOqGf4hcB77Jl8WmYAB6N
	 FBxEkkS0JKIFGv8OXUqd+CIwomUelBRGJdgIgDfgV/Ixt5uQBFqatpjaUF1EbeQZfM
	 xHLG6fob7J8vQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.7.y] selftests: mptcp: join: stop transfer when check is done (part 2)
Date: Mon, 26 Feb 2024 19:51:56 +0100
Message-ID: <20240226185155.448681-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024021925-saloon-pursuit-2736@gregkh>
References: <2024021925-saloon-pursuit-2736@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3045; i=matttbe@kernel.org; h=from:subject; bh=47Mrczbm6Bhgwrm2+aie1DoEAUeq8NsaAuERKwQoZAM=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl3N3LjOiTdSd8VfEWsZnT8hzmYQosb9+wUx1UJ Y9/JSfXUgiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdzdywAKCRD2t4JPQmmg c6wpEACx0BpCumr5x1ocGhPptlKH57ossp4TZyn4HijHoMIUvK9Xhw/Ek9D6I4dxQrqJW5rWDPn F61Y8fTA/doPfYfEnIvClRgKcDY7dSp+4G2DW4CMVBbe12n2EPDOH06VQnyZhFAL5ZFMYUPT5GY M+KJxEAzMwsrLQVjp0wSdvEes122B/GcVFLO4alxub9vQau1ONQPOonDsi7Y45Ryn8t+dOZintt 8SLCjoZp2PactknT5zm5qPTJBzgzbGtXdPSNz7nE9gBke91en19h6NtfWczs8Ef+BC6JTspX4qm PIRFSjDLna8TCk6G6KaYBC1qPG9hCfQ29sFUUAoYio6tHrLInSGIotHavMXk1IQsJgwJPJmegYX Os37ELHV3ptKF07tTC9Cr92yyAGH7yN1NA7c3evBNFwJZTdBga+GOtGJKM8c40i5YDpf5Rg3R5A AO70xkgDnN5Y5QpmCQpOI9OAzpfCq5wM+oTtu8eEAgV8nfStiT0+kYxL/kFqL1ZT8Yh0VLwJYZ9 w6VPhRk7nx/tWq/obrtshqFXuVXUCB7PlgdtjncgS9wuAPza5uxFeA3HWjO/N060Sscj8qvpz7j /+ztUXrS8iVWdngK70OqAo/qPNgPRex4UmpAAd/66rydxrMbZKMf+HVdU1NURaqnn+gPZ/aLy2+ BBm8Uq2jnJ06prQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Since the "Fixes" commits mentioned below, the newly added "userspace
pm" subtests of mptcp_join selftests are launching the whole transfer in
the background, do the required checks, then wait for the end of
transfer.

There is no need to wait longer, especially because the checks at the
end of the transfer are ignored (which is fine). This saves quite a few
seconds on slow environments.

While at it, use 'mptcp_lib_kill_wait()' helper everywhere, instead of
on a specific one with 'kill_tests_wait()'.

Fixes: b2e2248f365a ("selftests: mptcp: userspace pm create id 0 subflow")
Fixes: e3b47e460b4b ("selftests: mptcp: userspace pm remove initial subflow")
Fixes: b9fb176081fb ("selftests: mptcp: userspace pm send RM_ADDR for ID 0")
Cc: stable@vger.kernel.org
Reviewed-and-tested-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240131-upstream-net-20240131-mptcp-ci-issues-v1-9-4c1c11e571ff@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 04b57c9e096a9479fe0ad31e3956e336fa589cb2)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - conflicts because modified "userspace pm" tests are not in v6.7.x
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 99674dafa698..2f28d594b2c5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -688,13 +688,6 @@ kill_events_pids()
 	mptcp_lib_kill_wait $evts_ns2_pid
 }
 
-kill_tests_wait()
-{
-	#shellcheck disable=SC2046
-	kill -SIGUSR1 $(ip netns pids $ns2) $(ip netns pids $ns1)
-	wait
-}
-
 pm_nl_set_limits()
 {
 	local ns=$1
@@ -3466,7 +3459,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		speed=slow \
-			run_tests $ns1 $ns2 10.0.1.1 2>/dev/null &
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint "creation" \
@@ -3481,7 +3475,7 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
-		kill_tests_wait
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	if reset "delete and re-add" &&
@@ -3490,7 +3484,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		test_linkfail=4 speed=20 \
-			run_tests $ns1 $ns2 10.0.1.1 2>/dev/null &
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
 
 		wait_mpj $ns2
 		chk_subflow_nr "before delete" 2
@@ -3505,7 +3500,7 @@ endpoint_tests()
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add" 2
 		chk_mptcp_info subflows 1 subflows 1
-		kill_tests_wait
+		mptcp_lib_kill_wait $tests_pid
 	fi
 }
 
-- 
2.43.0


