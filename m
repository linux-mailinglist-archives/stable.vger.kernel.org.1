Return-Path: <stable+bounces-73612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DB696DC32
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 16:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97C91F24EA4
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 14:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C438B17BBF;
	Thu,  5 Sep 2024 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElfCtF6A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8110317741;
	Thu,  5 Sep 2024 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547464; cv=none; b=GxEvaxtqYA/nlsmKmKEwRh6kQvY2e3sNwpKDnf0UXIUgJseDy1lVH1+YXLvpR9XMSl7l7pOX7R9J+3TuJH/out3pSBi6cvRsKYt+pVQUYqK+M+F/+I8QKd8cpw94eCotFiFeY0+lmXbk2EGIrY+ahwD/B8E7fjV33d+YzTy4oyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547464; c=relaxed/simple;
	bh=rrc8sw5qmDPrPzaP2o1+vWj/tzlkGZ+KpIJALquMpAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlAXMko3DXc48WrvrNxksoljY4aNtf0zhfEPcZPTxkuR4ot3KuunbUcCzqLzEJ9fyJmpPfS4rXERg93t4emRPaqS8XXTnxqML2bFgxZah3v2C+0ogBSswf4rB/i3OGW6kNAShjxktO2Tk6s2Q+wC5HJOBUNxXmJraIRt69l1JIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElfCtF6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BA2C4CEC5;
	Thu,  5 Sep 2024 14:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725547464;
	bh=rrc8sw5qmDPrPzaP2o1+vWj/tzlkGZ+KpIJALquMpAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ElfCtF6A3Ic2i7JqlBA8S1csOVndLFAzHyvycp5k9Ji18OumVveQZ4aooOOk8CRtv
	 1Ys+nN/jnLvSHdrF9jRlaX3+yti5Y6Qoy4GpkC1d+xusKtYmOJMNValJVdHPdUF0zx
	 /5TP+wwCsPTPIH/JSnwOimYZ5DYTMYBPskmXm2TkpHleesJcdmQCMO94YxR0Yqbnb/
	 JVBEbK23aTm3QagJoPniilVKj+bdlSseFbJQ5TDE1haZXotABfveW/vC6HiSroAfRx
	 0QwyT24/gM2VZRSAeXxSa94123EPTlvxmciQ9ZE3fO986K++cDy3W+JFizEonao4FI
	 yKdfF/o/wSNHg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y 2/3] selftests: mptcp: join: validate event numbers
Date: Thu,  5 Sep 2024 16:43:09 +0200
Message-ID: <20240905144306.1192409-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <220913e1-603f-4399-a595-bb602942161a@kernel.org>
References: <220913e1-603f-4399-a595-bb602942161a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7624; i=matttbe@kernel.org; h=from:subject; bh=rrc8sw5qmDPrPzaP2o1+vWj/tzlkGZ+KpIJALquMpAo=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2cN7ZWAIeQRxdJm31hOq6IlpGvNZJDPfh24TC PfB7Q8GQZ2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtnDewAKCRD2t4JPQmmg cwGWEACh4Jlkzur0fWabGOUlkmVnLq5rxx0kt5wLAkBBIdy6kZK1z+wl7ce9h3Rg397cudzH3dP fAaFKWE27wd06nVyLp/T122G1r5mT273sl1CP/60uE4L3cLIPbKAwr2yo1fo/ZifgflSuj9Tdts OzWJkIL8IvyPhOtjaeUnlCNhF7l5rN6vl+QdsAUQveu8l8i7K9yMAJhU3q9JauvkTM4MAk3aXPq RQU7mzLXxEqadYUSTocFA/0WnsfuG6eRJXdGQNB7wS/aRMBEOIbf9wo7Cpek6sZlB4J4WwGfX9m Wud2mpwi2WxG1txUBnspOfPPqj4r+B/AHjXm3BVAhwMXMFQKWLbz5o8W+OKaKIBPAWqhs5gPvXA NAqinBfDpm9/YhZ5GL8K0eER6zrXWbgtATKwZRB/7r0Kgs6dapkf1lpX6kzZ7r1yHzfyE2SyJyW haDWMRHBG6QGuYdcQxIsVJ5eIo+VB2ErVdpliEixrp42y2sRvk8fLf/pfDLA0hQ/F2FRaIc4OJH DbQ71JCNeZtGowjkk7VPBFE2fLkWN5mT+5ysMYXIIRHF6dnVkbh57HAwbSWzVXMkeXnPW0filLA amSfdCVrH1qz3AAuJGccgFTn6p7R6oEy8aBSd4+FFyIHaO3mM6ecekjFtz4niQJTj5nC/bf2gFA X6V0Rl3Gbhxf4MQ==
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
  to ease future backports if any.
  In this version, it was also needed to import reset_with_events and
  kill_events_pids from the newer version, and adapt chk_evt_nr to how
  the results are printed in this version, plus remove the LISTENER
  events checks because the linked feature is not available in this
  kernel version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 90 ++++++++++++++++++-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 15 ++++
 2 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 11585510695e..adfdcf1ffef9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -394,6 +394,25 @@ reset_with_fail()
 	fi
 }
 
+start_events()
+{
+	evts_ns1=$(mktemp)
+	evts_ns2=$(mktemp)
+	:> "$evts_ns1"
+	:> "$evts_ns2"
+	ip netns exec "${ns1}" ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
+	evts_ns1_pid=$!
+	ip netns exec "${ns2}" ./pm_nl_ctl events >> "$evts_ns2" 2>&1 &
+	evts_ns2_pid=$!
+}
+
+reset_with_events()
+{
+	reset "${1}" || return 1
+
+	start_events
+}
+
 reset_with_tcp_filter()
 {
 	reset "${1}" || return 1
@@ -596,6 +615,14 @@ kill_tests_wait()
 	wait
 }
 
+kill_events_pids()
+{
+	kill_wait $evts_ns1_pid
+	evts_ns1_pid=0
+	kill_wait $evts_ns2_pid
+	evts_ns2_pid=0
+}
+
 pm_nl_set_limits()
 {
 	local ns=$1
@@ -3143,6 +3170,32 @@ fail_tests()
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
+	printf "%-${nr_blank}s %s" " " "event ${ns} ${evt_name} (${exp})"
+
+	count=$(grep -cw "type:${evt}" "${evts}")
+	if [ "${count}" != "${exp}" ]; then
+		echo "[fail] got $count events, expected $exp"
+		fail_test
+		dump_stats
+	else
+		echo "[ ok ]"
+	fi
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3265,11 +3318,13 @@ endpoint_tests()
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		start_events
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_5 2>/dev/null &
+		local tests_pid=$!
 
 		wait_mpj $ns2
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
@@ -3301,14 +3356,30 @@ endpoint_tests()
 			chk_subflow_nr "" "after re-add id 0 ($i)" 3
 		done
 
+		kill_wait "${tests_pid}"
+		kill_events_pids
 		kill_tests_wait
 
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
@@ -3339,8 +3410,25 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
 		wait_mpj $ns2
 		chk_subflow_nr "" "after re-add" 3
+
+		kill_wait "${tests_pid}"
+		kill_events_pids
 		kill_tests_wait
 
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
index f32045b23b89..4b1bef34d6d8 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -4,6 +4,21 @@
 readonly KSFT_FAIL=1
 readonly KSFT_SKIP=4
 
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
 # SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
 # features using the last version of the kernel and the selftests to make sure
 # a test is not being skipped by mistake.
-- 
2.45.2


