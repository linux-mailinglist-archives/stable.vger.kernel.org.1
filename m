Return-Path: <stable+bounces-25929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F3E8702E8
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 14:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B191C23D4C
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A73B3E47F;
	Mon,  4 Mar 2024 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkHuzUsm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94543DBB2;
	Mon,  4 Mar 2024 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559552; cv=none; b=ZOq727P3AMBNXrWclejAMGhBtofsS+AmHGtNJFDUr6I8hvBfA7ngxuFvuPVp/OBjAcd+nZz+Ji7+dekSTexiQ+IOUQ57N4d1fuguY/af7qEq/W5CMLk1WriiwAJJ3mfcPLAYIN/8Y1RHp1aMphkiUyQCy/5/Aj4DqXthrSPGay4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559552; c=relaxed/simple;
	bh=NmVUivCAmX9LTWN6+xdDcJ2R5h3I9vHy2vk1QYMsadA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNWiVms1ACKwYgCvWKWPmaa0YbOyJe1loqoLgSHr3h4tp+sV8PtpuyCfkEhPkifXVw1UiXPxI8dlit02OkmOMelkYzQQUactNYMWFwZ8jvNPUfhkh6kGbpDO5URs+sxWYLSCZo/EobYoRWI+qkfSEUjvqqktTnjB0WshUKK6+SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkHuzUsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4B9C433C7;
	Mon,  4 Mar 2024 13:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709559551;
	bh=NmVUivCAmX9LTWN6+xdDcJ2R5h3I9vHy2vk1QYMsadA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YkHuzUsm2w0S6WYpv8Y2i88BwEOR+FSFLnJS0R5WttdRwqVMRbnWAHkZnBZJl/hnC
	 dv70PrdmBA/+wCa66wKribEtEAxZANfOBmTHo2urmc4/QLoMLaNQZF5MB6zRmCLhFE
	 HRDI3upEGZPwO23UpkQ/nWM1jwPmnS/DhcpelUXjXT7hIzzFkC3jKmfek8X208iaSO
	 fJ3wUSuF1abaCLycwez12e9+bmNJJXeZ/36WVFZoNWjs3dysBcuiGBsBwPKzhUj0Oc
	 DJcqkaXULbIR2Z6KDJanYOrZ79ItwS6wwdxh7tpRRR7K+qEZIWeravP9DYTGRDjjKt
	 BBpkuEUyjdpXA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.7.y 4/5] selftests: mptcp: add mptcp_lib_is_v6
Date: Mon,  4 Mar 2024 14:38:32 +0100
Message-ID: <20240304133827.1989736-11-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024030420-swimsuit-antacid-a0dd@gregkh>
References: <2024030420-swimsuit-antacid-a0dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5230; i=matttbe@kernel.org; h=from:subject; bh=5hiqhWrm9xKsoHocITti9kdoJvB0Ll12DAqWaHrEbho=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5c7U7ypt4mkPZtyEtCoXeBbAu8YDmn7zgTo+c jZJSB9+DGOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeXO1AAKCRD2t4JPQmmg c2FYD/90b/pKQKm0NZztcqv+hclMPPO3eUJATz7pz6iKRic/ha2a2RrtWEPODn16MKZqp1Lcaka fSIRvCKc1j18oFovWXwj5duu/r3Sl7/ndtXvowAZhbwhRtXpKTQ8usbRKDQE1435lURzg8rHUxm Rik3dYxbTIuP7yQYJgrV/mtPuf6wRzpg39K2iZ4Cbgox5IUQ/54TPmcWNSi0k7DfE5PAZtUizXv WlyQR1gUEE4lP4WeQr+kIK6XOCOQUxyRksrPiv2QpZeCu0Gx7U4Q6mFEpb5TF7HwVTfpM1Ba8KB pdE8LQrQ6DydZ1Z7B41KQFYCLhC1q+vGHv+KBN5PCoUdVxbN7eDa9p5jDmDwomTa7UK6ZXfx9oq 4TVj6zp3716v1fP+V4NkLlYuQGTvbquihJmG0GMBeHODYknHFovy8QJCpk75hV1nRjq+fXfgd1B 13RljLxGzXQhzOj4DtSFJZOZeWbqTsHDifIMt4x1maYlGt8v8RQxzVwHXyaQ9XZ1YCO0sriULm3 +5zSCdsZnHtFNqfs2S65lD0qMjvyxI8jSWHrjO8G5iOL+Hjrs6fTJZcMtpftloURWtTwhTcKhVm SZMN72+wEO+nvBDn30dV2xhmkb2/hz2NNt09jSOsWiT57qiXUtCSsCaj+xhfBQFJEXODcSwdprq MVWI4Gbns1otxNw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

To avoid duplicated code in different MPTCP selftests, we can add
and use helpers defined in mptcp_lib.sh.

is_v6() helper is defined in mptcp_connect.sh, mptcp_join.sh and
mptcp_sockopt.sh, so export it into mptcp_lib.sh and rename it as
mptcp_lib_is_v6(). Use this new helper in all scripts.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231128-send-net-next-2023107-v4-10-8d6b94150f6b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit b850f2c7dd85ecd14a333685c4ffd23f12665e94)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_connect.sh | 16 +++++-----------
 tools/testing/selftests/net/mptcp/mptcp_join.sh  | 14 ++++----------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh   |  5 +++++
 .../testing/selftests/net/mptcp/mptcp_sockopt.sh |  8 +-------
 4 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 10cd322e05c4..3b971d1617d8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -310,12 +310,6 @@ check_mptcp_disabled()
 	return 0
 }
 
-# $1: IP address
-is_v6()
-{
-	[ -z "${1##*:*}" ]
-}
-
 do_ping()
 {
 	local listener_ns="$1"
@@ -324,7 +318,7 @@ do_ping()
 	local ping_args="-q -c 1"
 	local rc=0
 
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		$ipv6 || return 0
 		ping_args="${ping_args} -6"
 	fi
@@ -620,12 +614,12 @@ run_tests_lo()
 	fi
 
 	# skip if we don't want v6
-	if ! $ipv6 && is_v6 "${connect_addr}"; then
+	if ! $ipv6 && mptcp_lib_is_v6 "${connect_addr}"; then
 		return 0
 	fi
 
 	local local_addr
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 	else
 		local_addr="0.0.0.0"
@@ -693,7 +687,7 @@ run_test_transparent()
 	TEST_GROUP="${msg}"
 
 	# skip if we don't want v6
-	if ! $ipv6 && is_v6 "${connect_addr}"; then
+	if ! $ipv6 && mptcp_lib_is_v6 "${connect_addr}"; then
 		return 0
 	fi
 
@@ -726,7 +720,7 @@ EOF
 	fi
 
 	local local_addr
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 		r6flag="-6"
 	else
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2a769cfb7f24..1bc9e424194b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -592,12 +592,6 @@ link_failure()
 	done
 }
 
-# $1: IP address
-is_v6()
-{
-	[ -z "${1##*:*}" ]
-}
-
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -877,7 +871,7 @@ pm_nl_set_endpoint()
 		local id=10
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
-			if is_v6 "${connect_addr}"; then
+			if mptcp_lib_is_v6 "${connect_addr}"; then
 				addr="dead:beef:$counter::1"
 			else
 				addr="10.0.$counter.1"
@@ -929,7 +923,7 @@ pm_nl_set_endpoint()
 		local id=20
 		while [ $add_nr_ns2 -gt 0 ]; do
 			local addr
-			if is_v6 "${connect_addr}"; then
+			if mptcp_lib_is_v6 "${connect_addr}"; then
 				addr="dead:beef:$counter::2"
 			else
 				addr="10.0.$counter.2"
@@ -971,7 +965,7 @@ pm_nl_set_endpoint()
 			pm_nl_flush_endpoint ${connector_ns}
 		elif [ $rm_nr_ns2 -eq 9 ]; then
 			local addr
-			if is_v6 "${connect_addr}"; then
+			if mptcp_lib_is_v6 "${connect_addr}"; then
 				addr="dead:beef:1::2"
 			else
 				addr="10.0.1.2"
@@ -3339,7 +3333,7 @@ userspace_pm_rm_sf()
 	local cnt
 
 	[ "$1" == "$ns2" ] && evts=$evts_ns2
-	if is_v6 $2; then ip=6; fi
+	if mptcp_lib_is_v6 $2; then ip=6; fi
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
 	dp=$(mptcp_lib_evts_get_info dport "$evts" $t)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 3cf31be5f655..f7b16d0bb5e5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -227,6 +227,11 @@ mptcp_lib_kill_wait() {
 	wait "${1}" 2>/dev/null
 }
 
+# $1: IP address
+mptcp_lib_is_v6() {
+	[ -z "${1##*:*}" ]
+}
+
 # $1: ns, $2: MIB counter
 mptcp_lib_get_counter() {
 	local ns="${1}"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index a817af6616ec..bfa744e350ef 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -161,12 +161,6 @@ check_transfer()
 	return 0
 }
 
-# $1: IP address
-is_v6()
-{
-	[ -z "${1##*:*}" ]
-}
-
 do_transfer()
 {
 	local listener_ns="$1"
@@ -183,7 +177,7 @@ do_transfer()
 	local mptcp_connect="./mptcp_connect -r 20"
 
 	local local_addr ip
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 		ip=ipv6
 	else
-- 
2.43.0


