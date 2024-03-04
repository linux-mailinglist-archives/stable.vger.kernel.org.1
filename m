Return-Path: <stable+bounces-25936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B61A4870418
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 15:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E818B2797D
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DE4481D0;
	Mon,  4 Mar 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EugdjTEM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F44E3FE5F;
	Mon,  4 Mar 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562328; cv=none; b=Sn88DrmPweZSzC0c2wA4Hixjww194TFmRaYgNWSmHgBHjRcgv/G8udCdOjX9ZZ2pfd31UfEAft2as2itrb4J/kJbgxwPKJHW0prr7SA2bkgExKikjEMV+APrfPIeJXibDN2MIxDhnmWXabC896D2ISMem3AWypEjQSEIgrEnOeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562328; c=relaxed/simple;
	bh=hWFhFUUO2V5bAinoqsiPrwcvkscCE6QOmT0I8lak8OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TH1Gg0g4CUuk6BQmK/TLS3PATCm0//URnS/V9c2y/dRiyTey+lzzzxXYqxh8xpojFM88xDH/dQwCUgK9GlHqdsy9CIApozCdbZ4fu7xzr/KqF3niFAJgcZ/Wxf97TJ9foo5v3r5PPfpRweYIQ4deoHuNncnXri/0+g3pIVu8e/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EugdjTEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A45C433C7;
	Mon,  4 Mar 2024 14:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709562328;
	bh=hWFhFUUO2V5bAinoqsiPrwcvkscCE6QOmT0I8lak8OA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EugdjTEMavfFlFgaWAN5DELhaAMLZrgh+VYsuU2+qnibTrHSO01wp8VWISVujz6kv
	 tEUHufKslEPkRCbBc5sV6e7w72YQC2ajQPAiJCkyibPtI6J6zID6IOarmvu3G5GMG5
	 aRpgNvNom7k6LZBVRB9Ui2zvVQsGLiqJ9Jcho1DGAmgp1OCvthCobZyggd8KPdy2ui
	 Bh7DdxZHL7xDgkMeKbUsmtFqAcEG4X+0DVw6zAtADFCOlV0/WDIJKVLz+haKCyEI1Q
	 pWxFFQzqOM6+3X44RUQaJnA5QkJs/UndJqdXjDkengiMO2XYJpoBfKhrm0Tr5eNGVa
	 XOf/9wFVPP1VQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 4/5] selftests: mptcp: add mptcp_lib_is_v6
Date: Mon,  4 Mar 2024 15:25:13 +0100
Message-ID: <20240304142508.2086803-11-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024030421-badly-bucket-6555@gregkh>
References: <2024030421-badly-bucket-6555@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5230; i=matttbe@kernel.org; h=from:subject; bh=Sy9wvWpFoqb2U/7Okkq6XpcsENWo8kU6xG6nZ1FlhNE=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5dnEbennyJG9XK/mmK/ncfP2KW1r7TXXz5XCd ZXAE5zxSJiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeXZxAAKCRD2t4JPQmmg c0dXD/9jp72OglXpErCdlQMVc+VF5G+jqXaF9PeiwnXYoZixWq+Rjd+WfwHkLryQyJ2qcDr6gTK pA6w2rpOCPavUT9VAwyy1U+b1GlkhU2X2tlfatgaPLj02yKRRSmil89/uh2gOJ/pJEsOpAt8NlK 9qsNsT+iAum0PqPUB7YuVKNCtSRxPYDMJiqVsu3MJw5t7ZprkEuOClXgwZBr2fAnwsAACZPYGst OEeBFT/KWE/yXD2dTvRZKqQ6y2wGJwWqz7Jq+4PpNNfXbyFmHnZLOPtlFuIUzbTJhmING1Johyt MAhWO+5dEOOPRY9PCmH7OOe46v/7k5KpNlYZ3dPxAJyBasZo8jTrbjQpbutakyKHdaNb7Vg3gMj y3pD7VsOypY4lyitg8bemxq03FR84hE4WYUrr5KJrKDWW4BI40IFeQnIOefL4AfvYXK+T72rt3D 1KTVWrvxPm60s/sQFh7gUsqjz+zqKp/5lEElBRJzmVrAMi5vLpIN+ROUjgEtJm206rowZZMJGet XvBbpexC0k5XRzcpBgmBSZXTMbbS3UyFpVyFZEBo+Fsx6P4EOH01FXqLK+ogjTvn0fJ0XKJn8zW 3rHBUew/NfCsZ7TcCZcmuVp9U4kL+wWuK8vXEh5x/eLcfa+IDHsc+X/BLKTia7eAZdAlnhLWOZh /chOMY1xSOI0q5A==
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
index 7c560ced6ce4..ef17e39abefa 100755
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
@@ -3336,7 +3330,7 @@ userspace_pm_rm_sf()
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
index 8c8694f21e7d..306d6c4ed5bb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -162,12 +162,6 @@ check_transfer()
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
@@ -184,7 +178,7 @@ do_transfer()
 	local mptcp_connect="./mptcp_connect -r 20"
 
 	local local_addr ip
-	if is_v6 "${connect_addr}"; then
+	if mptcp_lib_is_v6 "${connect_addr}"; then
 		local_addr="::"
 		ip=ipv6
 	else
-- 
2.43.0


