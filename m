Return-Path: <stable+bounces-36118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F0689A02F
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 16:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8AF282838
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 14:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E767B16F299;
	Fri,  5 Apr 2024 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irOFr250"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A551616D9B3;
	Fri,  5 Apr 2024 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328697; cv=none; b=JbAWnBL4MBR0DXn9khEDAu6CBSDgmdS5tAGchddk/4oFAxYuyh8hsse9ghWoq6zbRq9+EfnxHQJ887B6miUHi/FBDqvZ9gZVh55w/e1h/A6RIxqER8E6u7axVo7Qb6lQ2c07T4B7hLY6/y9brBRoP6Wu2Aw5hI1G0hSdGCnVFSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328697; c=relaxed/simple;
	bh=pVCa0jbz8DEWwrQCnSAzD5JrtHSnPyTQx1O0UYWEuak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJZCirYx2octS797k44hAmEs5lQ08UQOnEXqgLiMm6RwORsu4qv8W8YQrHj1D7S+cWIryCIprEumxE2vAQdbypl5azPnrM87zA0USvlN1+wrjuui9xbNEG1RfY1IJqpiP4s5FDcJKrd4I3R5VFsczY2h57NkLuB8tt9gzK7gkIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irOFr250; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13A6C43394;
	Fri,  5 Apr 2024 14:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712328697;
	bh=pVCa0jbz8DEWwrQCnSAzD5JrtHSnPyTQx1O0UYWEuak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=irOFr250CLc+EqO2arf8UXj/paEM/MBsWboryUZVfTfKHLB2d2CcfuHifqP5jagHJ
	 4ocfOXfsvoKbXnM0tSi3STWJQPVrzkN9uKHMoE0Lf1/pIOzzevaFVYBvZ45ynaeXQh
	 AiVOhMzNBxkZCx/Cla8I+/WjiHQgZ06eQyoUNCiRKTYlY2TIW4QCYlA0oWQMSc3O9P
	 fqipUan/RSk6/vEB6w/UqM8vCQIxoKtbB24C87cR2vVqOfsAs6z1C2mEagbe+P9K36
	 II3i9wKbJqRXkGbHTZNVWXHO8aP3zsp4fs/oBKnaEdLkDUVQaBgjL2V+ufCWHtirpZ
	 JrnGnPgrDyskg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.8.y 1/3] selftests: mptcp: connect: fix shellcheck warnings
Date: Fri,  5 Apr 2024 16:51:19 +0200
Message-ID: <20240405145117.854766-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024040519-palpable-barrel-9103@gregkh>
References: <2024040519-palpable-barrel-9103@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9205; i=matttbe@kernel.org; h=from:subject; bh=pVCa0jbz8DEWwrQCnSAzD5JrtHSnPyTQx1O0UYWEuak=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmEA/lVLoWAJ11cBX6vUWNIS+Jvc/vbQsUe1bRa W3Ps0xFGFuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZhAP5QAKCRD2t4JPQmmg c/t8EACJeokiubp5Ez1VdVHW1FbO9rSuFqwwTIWIpRZqnjIvuB1Y1RIj9q+fMMz1KlrzRvwhHAt 6eIbEKZtAidB7JjYFYor0f6R2atoc/FOW72THtbCEmii2u3W6i26ZhzW59XwQLdcr6XSVj7he9K e/lX5IgGq6hZi3ijHBmTcJix1I5nXWFTNpWktPjnAR85JtulHi14XMGfj6YMhsj0tuSCKwz6QyH w7IFHb6SjseKS63mM2aR38+gcEtPKDxpmwEG+46I1fFl8Y2Fb5DZxoYoMB4my9N2nC9a4aptNVT QrgqLxTD2Zl5+YH2mBB210BBwPvs/SbcV+0n6IFOMactrPX05KisSn7kAEcfkcu1LAiaN3LeBnz 9Gh//mDpfnQtH/WfkDSfWpZybFSynWGXwE2zdNHBk91ZMT66p71M7aqbM5ACat4fcKeFs5Cmkxj /z6D+8uElN06iaKu7Z2D3mpJ3JVB3QVlmzkK/Q05maQA+q/1kStHf+MhsIrmmlb/8F/N2wVwyjg UuwuiHsoLDlIWx/fYwFRYnPHZfqz6XX23IrSV8y2Bp2HxMrQjB8503PdoM6/X9e3gzO3V8qmnNR tQdgWUOhkNkFotuNE+4vz7zDymjXvmFF6WVx7ChrnMSK4aGE2VgJiE8i0n7+NVgGNAcsNxPcRtc 13UzLIBjT20hX/Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

shellcheck recently helped to prevent issues. It is then good to fix the
other harmless issues in order to spot "real" ones later.

Here, two categories of warnings are now ignored:

- SC2317: Command appears to be unreachable. The cleanup() function is
  invoked indirectly via the EXIT trap.

- SC2086: Double quote to prevent globbing and word splitting. This is
  recommended, but the current usage is correct and there is no need to
  do all these modifications to be compliant with this rule.

For the modifications:

  - SC2034: ksft_skip appears unused.
  - SC2181: Check exit code directly with e.g. 'if mycmd;', not
            indirectly with $?.
  - SC2004: $/${} is unnecessary on arithmetic variables.
  - SC2155: Declare and assign separately to avoid masking return
            values.
  - SC2166: Prefer [ p ] && [ q ] as [ p -a q ] is not well defined.
  - SC2059: Don't use variables in the printf format string. Use printf
            '..%s..' "$foo".

Now this script is shellcheck (0.9.0) compliant. We can easily spot new
issues.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-8-bc79e6e5e6a0@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit e3aae1098f109f0bd33c971deff1926f4e4441d0)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 76 ++++++++++++-------
 1 file changed, 47 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 7898d62fce0b..cce0e553976f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -1,6 +1,11 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Double quotes to prevent globbing and word splitting is recommended in new
+# code but we accept it, especially because there were too many before having
+# address all other issues detected by shellcheck.
+#shellcheck disable=SC2086
+
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 time_start=$(date +%s)
@@ -13,7 +18,6 @@ sout=""
 cin_disconnect=""
 cin=""
 cout=""
-ksft_skip=4
 capture=false
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
@@ -131,6 +135,8 @@ ns4="ns4-$rndh"
 TEST_COUNT=0
 TEST_GROUP=""
 
+# This function is used in the cleanup trap
+#shellcheck disable=SC2317
 cleanup()
 {
 	rm -f "$cin_disconnect" "$cout_disconnect"
@@ -225,8 +231,9 @@ set_ethtool_flags() {
 	local dev="$2"
 	local flags="$3"
 
-	ip netns exec $ns ethtool -K $dev $flags 2>/dev/null
-	[ $? -eq 0 ] && echo "INFO: set $ns dev $dev: ethtool -K $flags"
+	if ip netns exec $ns ethtool -K $dev $flags 2>/dev/null; then
+		echo "INFO: set $ns dev $dev: ethtool -K $flags"
+	fi
 }
 
 set_random_ethtool_flags() {
@@ -321,7 +328,7 @@ do_transfer()
 	local extra_args="$7"
 
 	local port
-	port=$((10000+$TEST_COUNT))
+	port=$((10000+TEST_COUNT))
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
@@ -378,12 +385,18 @@ do_transfer()
 			nstat -n
 	fi
 
-	local stat_synrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
-	local stat_ackrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
-	local stat_cookietx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
-	local stat_cookierx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
-	local stat_csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
-	local stat_csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
+	local stat_synrx_last_l
+	local stat_ackrx_last_l
+	local stat_cookietx_last
+	local stat_cookierx_last
+	local stat_csum_err_s
+	local stat_csum_err_c
+	stat_synrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
+	stat_ackrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
+	stat_cookietx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
+	stat_cookierx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
+	stat_csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
+	stat_csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
 
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
@@ -446,11 +459,16 @@ do_transfer()
 	mptcp_lib_check_transfer $cin $sout "file received by server"
 	rets=$?
 
-	local stat_synrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
-	local stat_ackrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
-	local stat_cookietx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
-	local stat_cookierx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
-	local stat_ooo_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtTCPOFOQueue")
+	local stat_synrx_now_l
+	local stat_ackrx_now_l
+	local stat_cookietx_now
+	local stat_cookierx_now
+	local stat_ooo_now
+	stat_synrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
+	stat_ackrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
+	stat_cookietx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
+	stat_cookierx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
+	stat_ooo_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtTCPOFOQueue")
 
 	expect_synrx=$((stat_synrx_last_l))
 	expect_ackrx=$((stat_ackrx_last_l))
@@ -459,8 +477,8 @@ do_transfer()
 	cookies=${cookies##*=}
 
 	if [ ${cl_proto} = "MPTCP" ] && [ ${srv_proto} = "MPTCP" ]; then
-		expect_synrx=$((stat_synrx_last_l+$connect_per_transfer))
-		expect_ackrx=$((stat_ackrx_last_l+$connect_per_transfer))
+		expect_synrx=$((stat_synrx_last_l+connect_per_transfer))
+		expect_ackrx=$((stat_ackrx_last_l+connect_per_transfer))
 	fi
 
 	if [ ${stat_synrx_now_l} -lt ${expect_synrx} ]; then
@@ -468,7 +486,7 @@ do_transfer()
 			"${stat_synrx_now_l}" "${expect_synrx}" 1>&2
 		retc=1
 	fi
-	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} -a ${stat_ooo_now} -eq 0 ]; then
+	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ] && [ ${stat_ooo_now} -eq 0 ]; then
 		if [ ${stat_ooo_now} -eq 0 ]; then
 			printf "[ FAIL ] lower MPC ACK rx (%d) than expected (%d)\n" \
 				"${stat_ackrx_now_l}" "${expect_ackrx}" 1>&2
@@ -479,18 +497,20 @@ do_transfer()
 	fi
 
 	if $checksum; then
-		local csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
-		local csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
+		local csum_err_s
+		local csum_err_c
+		csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
+		csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
 
 		local csum_err_s_nr=$((csum_err_s - stat_csum_err_s))
 		if [ $csum_err_s_nr -gt 0 ]; then
-			printf "[ FAIL ]\nserver got $csum_err_s_nr data checksum error[s]"
+			printf "[ FAIL ]\nserver got %d data checksum error[s]" ${csum_err_s_nr}
 			rets=1
 		fi
 
 		local csum_err_c_nr=$((csum_err_c - stat_csum_err_c))
 		if [ $csum_err_c_nr -gt 0 ]; then
-			printf "[ FAIL ]\nclient got $csum_err_c_nr data checksum error[s]"
+			printf "[ FAIL ]\nclient got %d data checksum error[s]" ${csum_err_c_nr}
 			retc=1
 		fi
 	fi
@@ -658,7 +678,7 @@ run_test_transparent()
 		return
 	fi
 
-ip netns exec "$listener_ns" nft -f /dev/stdin <<"EOF"
+	if ! ip netns exec "$listener_ns" nft -f /dev/stdin <<"EOF"
 flush ruleset
 table inet mangle {
 	chain divert {
@@ -669,7 +689,7 @@ table inet mangle {
 	}
 }
 EOF
-	if [ $? -ne 0 ]; then
+	then
 		echo "SKIP: $msg, could not load nft ruleset"
 		mptcp_lib_fail_if_expected_feature "nft rules"
 		mptcp_lib_result_skip "${TEST_GROUP}"
@@ -684,8 +704,7 @@ EOF
 		local_addr="0.0.0.0"
 	fi
 
-	ip -net "$listener_ns" $r6flag rule add fwmark 1 lookup 100
-	if [ $? -ne 0 ]; then
+	if ! ip -net "$listener_ns" $r6flag rule add fwmark 1 lookup 100; then
 		ip netns exec "$listener_ns" nft flush ruleset
 		echo "SKIP: $msg, ip $r6flag rule failed"
 		mptcp_lib_fail_if_expected_feature "ip rule"
@@ -693,8 +712,7 @@ EOF
 		return
 	fi
 
-	ip -net "$listener_ns" route add local $local_addr/0 dev lo table 100
-	if [ $? -ne 0 ]; then
+	if ! ip -net "$listener_ns" route add local $local_addr/0 dev lo table 100; then
 		ip netns exec "$listener_ns" nft flush ruleset
 		ip -net "$listener_ns" $r6flag rule del fwmark 1 lookup 100
 		echo "SKIP: $msg, ip route add local $local_addr failed"
@@ -857,7 +875,7 @@ stop_if_error "Could not even run ping tests"
 echo -n "INFO: Using loss of $tc_loss "
 test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
 
-reorder_delay=$(($tc_delay / 4))
+reorder_delay=$((tc_delay / 4))
 
 if [ -z "${tc_reorder}" ]; then
 	reorder1=$((RANDOM%10))
-- 
2.43.0


