Return-Path: <stable+bounces-197530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD18C8FEC2
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 19:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2D53A60A2
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 18:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749F92ED161;
	Thu, 27 Nov 2025 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwIh/uuB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094A24886A;
	Thu, 27 Nov 2025 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764268113; cv=none; b=hBT29Lhl8lZWixSVP2F9sWD6SnjPhEXrCh2ugJWkTVPfL/yV5VhbfH3IBgUTXrJsUMXtsRJdpbgm6LihOZwhTYKmfGzM/PXZKrpUm2Sim0ALQY5meFC2BCl3no75OrZCYsXrUk1SXU0ipLsmps/EZ4RunIPcAKHjROm0VMDxfJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764268113; c=relaxed/simple;
	bh=Nn/v01Ey2/HJHJ9en82lXk5ClSWcY67yxVYax8RmE+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oosQRrXXxM50UZgup7V8CD54R/EOzKeDOy+cWCz1e3C60wFPdh0FTgseLJx5FU/2N9/yrkcwI638CLS0PVzNVHfh89FM49jI1ZHH8ZuwmNlwbrc4SG25Zm4hp7oSgHvpLb07cKz2mQHNSW/7LMmppJTI30j6ShUBnPNbNK5J3QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwIh/uuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DA2C4CEF8;
	Thu, 27 Nov 2025 18:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764268112;
	bh=Nn/v01Ey2/HJHJ9en82lXk5ClSWcY67yxVYax8RmE+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mwIh/uuBqkvlgtX51ytD90WSIHG9IxjqZU+7dNlGVbYNzVvlqbdhcFHLE66grYGoG
	 HgZg3mXi3Qd8MEeEZkPZsFLxJOXRrZ8hardoD6FDXM7Si9zqsQGp/Ua3gvcsXslMdj
	 m0+DZNx0ZEZ+fjBo6tANuZhE2TcUt+3NfXVUb2oawBK1qG6VbxSal/QUZDpxsLwvIL
	 fW9zxFt1Wkfp6jVbEjUiWmbtOaaVNL20UQDjnBapB97VMbFeZvix3sxjxxiKM+eccC
	 h/9kId4kTM03VQFTGXCaSGjtfzGZyczc8PgOxNHHPVt+YoVlruNsAkT+YeVIjBdQ1w
	 mSQDk/0X00oPg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] selftests: mptcp: join: properly kill background tasks
Date: Thu, 27 Nov 2025 19:28:11 +0100
Message-ID: <20251127182810.3578622-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112001-gauging-hurdle-297f@gregkh>
References: <2025112001-gauging-hurdle-297f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4553; i=matttbe@kernel.org; h=from:subject; bh=Nn/v01Ey2/HJHJ9en82lXk5ClSWcY67yxVYax8RmE+s=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI1ZlgfPJWW+Gniv6VXu+unbMtm4rtQYs9zx2eK8T2d2 4F/y6Yd6yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjI3BSG/1W8B/k8f74MtD2d mJNbWVLfeF51koKQ7afp+wMZ38hECjP8U1M5nTqPy23VlzwXufQDhn31yj9DJjT2nVn+JUNpt+d 7ZgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 852b644acbce1529307a4bb283752c4e77b5cda7 upstream.

The 'run_tests' function is executed in the background, but killing its
associated PID would not kill the children tasks running in the
background.

To properly kill all background tasks, 'kill -- -PID' could be used, but
this requires kill from procps-ng. Instead, all children tasks are
listed using 'ps', and 'kill' is called with all PIDs of this group.

Fixes: 31ee4ad86afd ("selftests: mptcp: join: stop transfer when check is done (part 1)")
Cc: stable@vger.kernel.org
Fixes: 04b57c9e096a ("selftests: mptcp: join: stop transfer when check is done (part 2)")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251110-net-mptcp-sft-join-unstable-v1-6-a4332c714e10@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mptcp_join.sh, because commit e3b47e460b4b ("selftests:
  mptcp: userspace pm remove initial subflow") and commit b9fb176081fb
  ("selftests: mptcp: userspace pm send RM_ADDR for ID 0") are not in
  this version. They introduced new subtests that got modified by this
  patch. That's OK, no need to modify them if they are not there: the
  conflicts can be dropped. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 14 ++++++-------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 21 +++++++++++++++++++
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ef16edce4759..2c025c73e19f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3679,7 +3679,7 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 
 	# userspace pm create destroy subflow
@@ -3707,7 +3707,7 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 
 	# userspace pm create id 0 subflow
@@ -3728,7 +3728,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		kill_events_pids
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 }
 
@@ -3758,7 +3758,7 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
@@ -3813,7 +3813,7 @@ endpoint_tests()
 			chk_mptcp_info subflows 3 subflows 3
 		done
 
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 
 		kill_events_pids
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_LISTENER_CREATED 1
@@ -3886,7 +3886,7 @@ endpoint_tests()
 		wait_mpj $ns2
 		chk_subflow_nr "after re-re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 
 		kill_events_pids
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_LISTENER_CREATED 1
@@ -3933,7 +3933,7 @@ endpoint_tests()
 		wait_mpj $ns2
 		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
 		wait_mpj $ns2
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 919f4f1018eb..8b3bd063f7be 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -242,6 +242,27 @@ mptcp_lib_kill_wait() {
 	wait "${1}" 2>/dev/null
 }
 
+# $1: PID
+mptcp_lib_pid_list_children() {
+	local curr="${1}"
+	# evoke 'ps' only once
+	local pids="${2:-"$(ps o pid,ppid)"}"
+
+	echo "${curr}"
+
+	local pid
+	for pid in $(echo "${pids}" | awk "\$2 == ${curr} { print \$1 }"); do
+		mptcp_lib_pid_list_children "${pid}" "${pids}"
+	done
+}
+
+# $1: PID
+mptcp_lib_kill_group_wait() {
+	# Some users might not have procps-ng: cannot use "kill -- -PID"
+	mptcp_lib_pid_list_children "${1}" | xargs -r kill &>/dev/null
+	wait "${1}" 2>/dev/null
+}
+
 # $1: IP address
 mptcp_lib_is_v6() {
 	[ -z "${1##*:*}" ]
-- 
2.51.0


