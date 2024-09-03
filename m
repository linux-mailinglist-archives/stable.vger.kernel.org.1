Return-Path: <stable+bounces-72805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76EF969A0F
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC67C1C232D5
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A344E1B983A;
	Tue,  3 Sep 2024 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scnmWBlG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1181B9835;
	Tue,  3 Sep 2024 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359038; cv=none; b=A3bqZRPsODHUDvT8SRSDL2WqND7gNdhmdW3YPbwIZ4qI+bxwHCKfwPsB94cAJyBxJ5gGWfR6SgdKhb7ln2aG/Htd/l2dcq6zubg5ikhlM6zTAMXJ6Qc88SfDS+rF9KSfbCxw1hFmI0FDf9Bl2QIKX/015OQ+Wu0Qr4UJMFxmKjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359038; c=relaxed/simple;
	bh=F3E1oFfdFzgtEQpafWqcWkO5+2evu97CmqTGGwxq0FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmJTDVOy8dDbAuSLH1UAHklGDaLvUgBBNTGEO4pXvgY67zFrgVQXqjMOysf+DnB0c77ALGXy72PlodKAKt7NWAOmHk/axtydnHOod4gq6C3haqY2I2a1aIOphLdaYQFqSt6CksGv6mZ26dOMIiS6XKEqkWz9Wk1sqfxUrWMj5Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scnmWBlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561E9C4CEC4;
	Tue,  3 Sep 2024 10:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725359037;
	bh=F3E1oFfdFzgtEQpafWqcWkO5+2evu97CmqTGGwxq0FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=scnmWBlG4H6TGpOZaINuxOINDp9f9xVzxgyM0Xnb2190OPg2N2ACbVCh1UmgmLpub
	 36DZnwJ4jk6vCXyM5pSnJTOv4LTX88zol5+EISP7j1A97johYKuPbDG46YyTgE2dAb
	 E2/DRqMhXQ3+o37NepDcJl2CGtCrLycAnpzmS7zB1YseUVWQ7gh5aAXuj7KCX3oTAn
	 yObcvejftDAUTyxk6bkzSt7eFHJ+ogxElFO+rqokARot5VqE468Ypi02h/dxL0mVEI
	 YdtBrM37rDynQvVU6dW//JI0ySEttO7K5DtbRGpWwaBU152Ij5F8ieUP1z4/YdWyKN
	 HglBPaFid7qfA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6.y 2/3] selftests: mptcp: join: validate event numbers
Date: Tue,  3 Sep 2024 12:23:50 +0200
Message-ID: <20240903102347.3384947-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083025-ruined-stupor-4967@gregkh>
References: <2024083025-ruined-stupor-4967@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6917; i=matttbe@kernel.org; h=from:subject; bh=F3E1oFfdFzgtEQpafWqcWkO5+2evu97CmqTGGwxq0FI=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1uOzzoIOLzsz7NPvKsncpcTB4hU8g3Qn+jto7 h0zp+pbx9qJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtbjswAKCRD2t4JPQmmg c9hwEADi4G1eaUdETuj5I2P0onLauwsrF6Ig0w2LS+KwUNDb+xZjC1nfcsQ6EWv9mUgT3mKDKEh edDIdFgnclVXjaW7DBpICAQXb42nx2lOv2NxFHTYThFaIFtaM7Rd4guLgL3bfkgFDReI09VmPj2 tyUzYoWnE4qV7yxM74I3RCEPx7padpShLj8JD86UW4xCl1ixn6K7yg/JobiWPWU/dxfaux7pvnx tj4HkPoTRuS/feFkrELBbCeOKtUYCwhUqTUsoZ2i+xNaRCaDzkX51PtghixrlvRbLEVaQT/G4e0 WoM7rtuPEPaO8UQuEPJTSVTkSgVfaoGI31ANQ6IjulK8lcImOUiuNiRwgZ9Yvf6oEhQCC1/IyNQ GSRsmD1uqvkus+zSvHPwQ/PQ5VnwtNakaRaH2ybOzrRGlXZmumWC7xfPNSrj6kAtQHVfgru9KG+ jDEd0nlZgsFnB4QyImi1n4n8Vh7gJl/ff17n0V+epJHQTy4b2MZKBlTuU2MenZPIMFNGTtz39K3 zcir7X1xcZ4eBY77xRweKNCDdEsXmlAOLgdGJ/ClkTP/FlvtGiZQ3GYbyN6geFnkUZBbHU8o6M1 QZRpHa02z45IMIgCwXNkvPbsuPvyhwyyvrNN54axKIqgl5leMCLHOwStx2eEHzVWVoBQ1bZVRYX MirNlXozZfoF0jA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 20ccc7c5f7a3aa48092441a4b182f9f40418392e upstream.

This test extends "delete and re-add" and "delete re-add signal" to
validate the previous commit: the number of MPTCP events are checked to
make sure there are no duplicated or unexpected ones.

A new helper has been introduced to easily check these events. The
missing events have been added to the lib.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: b911c97c7dc7 ("mptcp: add netlink event support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in mptcp_join.sh and mptcp_lib.sh, due to commit
  38f027fca1b7 ("selftests: mptcp: dump userspace addrs list") -- linked
  to a new feature, not backportable to stable -- and commit
  23a0485d1c04 ("selftests: mptcp: declare event macros in mptcp_lib")
  -- depending on the previous one -- not in this version. The conflicts
  in mptcp_join.sh were in the context, because a new helper had to be
  added after others that are not in this version. The conflicts in
  mptcp_lib.sh were due to the fact the other MPTCP_LIB_EVENT_*
  constants were not present. They have all been added in this version
  to ease future backports if any. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 74 ++++++++++++++++++-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 15 ++++
 2 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 12a5daf6dc10..52a028f0a3de 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -461,12 +461,17 @@ reset_with_fail()
 	fi
 }
 
+start_events()
+{
+	mptcp_lib_events "${ns1}" "${evts_ns1}" evts_ns1_pid
+	mptcp_lib_events "${ns2}" "${evts_ns2}" evts_ns2_pid
+}
+
 reset_with_events()
 {
 	reset "${1}" || return 1
 
-	mptcp_lib_events "${ns1}" "${evts_ns1}" evts_ns1_pid
-	mptcp_lib_events "${ns2}" "${evts_ns2}" evts_ns2_pid
+	start_events
 }
 
 reset_with_tcp_filter()
@@ -3420,6 +3425,36 @@ userspace_pm_rm_sf()
 	wait_rm_sf $1 "${cnt}"
 }
 
+# $1: ns ; $2: event type ; $3: count
+chk_evt_nr()
+{
+	local ns=${1}
+	local evt_name="${2}"
+	local exp="${3}"
+
+	local evts="${evts_ns1}"
+	local evt="${!evt_name}"
+	local count
+
+	evt_name="${evt_name:16}" # without MPTCP_LIB_EVENT_
+	[ "${ns}" == "ns2" ] && evts="${evts_ns2}"
+
+	print_check "event ${ns} ${evt_name} (${exp})"
+
+	if [[ "${evt_name}" = "LISTENER_"* ]] &&
+	   ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
+		print_skip "event not supported"
+		return
+	fi
+
+	count=$(grep -cw "type:${evt}" "${evts}")
+	if [ "${count}" != "${exp}" ]; then
+		fail_test "got ${count} events, expected ${exp}"
+	else
+		print_ok
+	fi
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3573,6 +3608,7 @@ endpoint_tests()
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		start_events
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
@@ -3624,12 +3660,28 @@ endpoint_tests()
 
 		mptcp_lib_kill_wait $tests_pid
 
+		kill_events_pids
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_LISTENER_CREATED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_CREATED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_ANNOUNCED 0
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_REMOVED 4
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 6
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 4
+
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_CREATED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 0
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 0
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 6
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 5 # one has been closed before estab
+
 		chk_join_nr 6 6 6
 		chk_rm_nr 4 4
 	fi
 
 	# remove and re-add
-	if reset "delete re-add signal" &&
+	if reset_with_events "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 3 3
@@ -3670,6 +3722,22 @@ endpoint_tests()
 		chk_mptcp_info subflows 3 subflows 3
 		mptcp_lib_kill_wait $tests_pid
 
+		kill_events_pids
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_LISTENER_CREATED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_CREATED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_ANNOUNCED 0
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_REMOVED 0
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 2
+
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_CREATED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 5
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 3
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+
 		chk_join_nr 4 4 4
 		chk_add_nr 5 5
 		chk_rm_nr 3 2 invert
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 000a9f7c018c..d98c89f31afe 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -8,6 +8,21 @@ readonly KSFT_SKIP=4
 # shellcheck disable=SC2155 # declare and assign separately
 readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 
+# These variables are used in some selftests, read-only
+declare -rx MPTCP_LIB_EVENT_CREATED=1           # MPTCP_EVENT_CREATED
+declare -rx MPTCP_LIB_EVENT_ESTABLISHED=2       # MPTCP_EVENT_ESTABLISHED
+declare -rx MPTCP_LIB_EVENT_CLOSED=3            # MPTCP_EVENT_CLOSED
+declare -rx MPTCP_LIB_EVENT_ANNOUNCED=6         # MPTCP_EVENT_ANNOUNCED
+declare -rx MPTCP_LIB_EVENT_REMOVED=7           # MPTCP_EVENT_REMOVED
+declare -rx MPTCP_LIB_EVENT_SUB_ESTABLISHED=10  # MPTCP_EVENT_SUB_ESTABLISHED
+declare -rx MPTCP_LIB_EVENT_SUB_CLOSED=11       # MPTCP_EVENT_SUB_CLOSED
+declare -rx MPTCP_LIB_EVENT_SUB_PRIORITY=13     # MPTCP_EVENT_SUB_PRIORITY
+declare -rx MPTCP_LIB_EVENT_LISTENER_CREATED=15 # MPTCP_EVENT_LISTENER_CREATED
+declare -rx MPTCP_LIB_EVENT_LISTENER_CLOSED=16  # MPTCP_EVENT_LISTENER_CLOSED
+
+declare -rx MPTCP_LIB_AF_INET=2
+declare -rx MPTCP_LIB_AF_INET6=10
+
 MPTCP_LIB_SUBTESTS=()
 
 # only if supported (or forced) and not disabled, see no-color.org
-- 
2.45.2


