Return-Path: <stable+bounces-23767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4519786835D
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 22:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762FC1C21D18
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 21:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748A6131733;
	Mon, 26 Feb 2024 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHdtTSWz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB1612F388;
	Mon, 26 Feb 2024 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708984547; cv=none; b=lgwPUKgYcD2zvcAv3/OoKQYfwqiGOtGJjMmamb5dtt0Asa+QFgf0ATxSZgGQD0Ozj3kYzP5iYy0AMG3zzXZa/xmOalZU29nNVP2y3SQsi245Cm2w4hTW9tdZKzoBY8pdg7sYx1QG1kgK4IUT+O4JM1SbLRdv0ZaiqmwbOntlqIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708984547; c=relaxed/simple;
	bh=b4QKCeImaCwyUK7wIB0+oTEjfjngW9nAizDuGu5NAcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8o/GP6nkroXTOwo7q5v9j3zXmjbVZyyZK7k/Rqx/uf7HybN2qNsPcJxVTy2hnHpS0EPJZM9WWXpS5/nNAgUP2M+3VoKSNAf1loBX97nvuMc+PZGta56+15I6SfEbdZHtPhMdHlG56ZIvNGd8rO1MIZ4UPLq+pHWpc5mk/SC6DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHdtTSWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BEAC433C7;
	Mon, 26 Feb 2024 21:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708984546;
	bh=b4QKCeImaCwyUK7wIB0+oTEjfjngW9nAizDuGu5NAcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YHdtTSWz76HOlLE4LOokzFJQFlIf/oenNnsiap/J4vKFoI8meCdC5KJW/xyeIB+u/
	 v1A/fh814ihTio7zR/OesNLMBwHMuEZE/sHOGTdea/NJQd01hDwFImEQrDFC9zyegr
	 aKwsDxQUWZuZTT2O0Kp0xNxRtRr3xNYqp7n4wFlftcyTKdlSYvKRNR9bQHIhWZQOVR
	 3VY6+cBV4+ZQSjS8AjgcxzEartAVTpzNEXFl+uYy/jCtqLmSnKVcSo5qou6Ga9RHdf
	 /TjLMbXJOVJY3EZPJl99alEdF3m5o9a2KKdyh8R8/H4iaw6PBdIUa73db/Jk9T02EH
	 /sp30rkZ+t7mw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] selftests: mptcp: join: stop transfer when check is done (part 2)
Date: Mon, 26 Feb 2024 22:55:35 +0100
Message-ID: <20240226215534.756867-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024021924-setback-disinfect-0bd6@gregkh>
References: <2024021924-setback-disinfect-0bd6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3045; i=matttbe@kernel.org; h=from:subject; bh=b4QKCeImaCwyUK7wIB0+oTEjfjngW9nAizDuGu5NAcA=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl3QjWVCiZCiwqheC0J9RDfIMXSL7WVXQS6EH7P q4Ro9MdEZ+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZd0I1gAKCRD2t4JPQmmg c8Q2D/wMfCBn+SErpnlWoNDLgcLQdk8KQl8JyAs7GATCJoLdXYr+FoVrpPl5JhybFsBCx+AmjNf bJJ0bwg5k+sFZstbjb4Zhf19LafOugYYv+QFHP/9bFFJU+F8brDR0p7RW83/IyxfJhJOk5fkKhb lEPQAv0F8Gn186VZhQS/1HkEFhiZc8AhSBVFfXVxRyZ+fU2jde9eFSyI1bXrh1XANDZYMvcMYQU 4SiSD9kMCs48HK5/N3GULzx2a0OufJvSYAI3dy22rQMNvNEWBZij1rT82owM55ifzKMz3JfFFtQ yHf3KDxwq3KK2cq1/ameg0zO68rKFQl1mO7LRB8mt+6ZMRA8d3X1KEFWg62zEJonGuWKizRKBvs gsx4ZI9zcvWYjfNcGIH4IzIT9PQT+iGvZewugOX1MS+5RySP6GWJKBGR2WUF/8rDt+VwUWknAx0 D3qsiKNcQbB6UM4KJSieumbOwZNjE+tWPLWmbghIoMumRt73P5fXi2Nlo9fRaTS5fGUak9pDF3P CShV6aHeALZuCPkPkRTyXWl3/W3Svj4ePVd09nLeH3r32TY4zvLsBtTtyRh4noRc8WU9izq73aA viWlplF1mKRaWZqWl8j+b1csEC+afJ3wc2U0FKucQ4QzadQAPxsVkp9uBXhylze8d6XscB9GJ/E 3lmcH2QY2j2SidQ==
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
 - conflicts because modified "userspace pm" tests are not in v6.6.x
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a0584417bcab..bc85570a6b26 100755
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
@@ -3463,7 +3456,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		speed=slow \
-			run_tests $ns1 $ns2 10.0.1.1 2>/dev/null &
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint "creation" \
@@ -3478,7 +3472,7 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
-		kill_tests_wait
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	if reset "delete and re-add" &&
@@ -3487,7 +3481,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		test_linkfail=4 speed=20 \
-			run_tests $ns1 $ns2 10.0.1.1 2>/dev/null &
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
 
 		wait_mpj $ns2
 		chk_subflow_nr "before delete" 2
@@ -3502,7 +3497,7 @@ endpoint_tests()
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add" 2
 		chk_mptcp_info subflows 1 subflows 1
-		kill_tests_wait
+		mptcp_lib_kill_wait $tests_pid
 	fi
 }
 
-- 
2.43.0


