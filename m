Return-Path: <stable+bounces-73408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B034696D4BB
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D544D1C238E2
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AF019413B;
	Thu,  5 Sep 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x1a8cNBA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EB9154BFF;
	Thu,  5 Sep 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530133; cv=none; b=gw6goNgvZW+D8wzPSdSL5woVXrtb9ps+5p8jsqjzhX/eu5xan8vxsb/oXfbIXep3etew+TyqTBbg0z4/FNm3WOMsUPCcKs+nlbEQVbmnpKmwzfD9OKbMPetJhPYRGnUztrd72wm9ldJhYyh29hyrfao8xf4AgyeVGSvdmRPBqPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530133; c=relaxed/simple;
	bh=qh4zMz8FQwQR81L5jOAvafoFOtV4Gm4p/2kIx5s3+Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MODeXJ1PRD24Moot/eLCZlLbslj1HjoA0By/4BpkMPAZn91tMU8UxvefZZ4fNOI7KJf91+Ga3H/AuucNiSeN3C7Uj1AIDse/K4SvbpbstCWAzh6ODB6KFJd83lPlueRk0vlBtLFcetiSAyGOcoAlVASQ7oYhJZpTPl/CePYeTUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x1a8cNBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C563C4CEC3;
	Thu,  5 Sep 2024 09:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725530132;
	bh=qh4zMz8FQwQR81L5jOAvafoFOtV4Gm4p/2kIx5s3+Jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x1a8cNBAG325G6X2URyX7MisIUhARSbiyVhRrkuzWnNZ4vSyahVmNd/AKvh/CXsAh
	 l0CoR8xL51HPX3ycXrl7DmDfzrxWbbSUZG1Mxc7hB07MbIEEVqh9XEj+MeM6yJhlh7
	 qzMfmOtUQzAaoIWXsjsDTkjJuuq1PldXdXVyRkFU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6 033/132] selftests: mptcp: join: validate event numbers
Date: Thu,  5 Sep 2024 11:40:20 +0200
Message-ID: <20240905093723.529598255@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093722.230767298@linuxfoundation.org>
References: <20240905093722.230767298@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   74 +++++++++++++++++++++++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |   15 ++++
 2 files changed, 86 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -464,12 +464,17 @@ reset_with_fail()
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
@@ -3489,6 +3494,36 @@ userspace_pm_chk_get_addr()
 	fi
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
@@ -3678,6 +3713,7 @@ endpoint_tests()
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		start_events
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
@@ -3729,12 +3765,28 @@ endpoint_tests()
 
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
@@ -3775,6 +3827,22 @@ endpoint_tests()
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
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -19,6 +19,21 @@ declare -rx MPTCP_LIB_EVENT_LISTENER_CLO
 declare -rx MPTCP_LIB_AF_INET=2
 declare -rx MPTCP_LIB_AF_INET6=10
 
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



