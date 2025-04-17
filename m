Return-Path: <stable+bounces-133222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7645CA923FB
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 19:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E073AE0AE
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 17:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D052255246;
	Thu, 17 Apr 2025 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaKRyAlV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21A254847;
	Thu, 17 Apr 2025 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910881; cv=none; b=ehFdMbOO8IF/U+L6EccZhuos9uruEnBAI2cmbiHjup9G7OikCl0r1u4BwmF6TZ6oe4P0v9xWMyUkIragvGq02KRPPEYRsiouiwsjGbtwK+3lOf1TKl2Rlfsh05RBGZ4FnQU6IaCbJlDRmkedhHbz9WXDmC6L3NJwfzw9S03vvho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910881; c=relaxed/simple;
	bh=bljGnNYfbh1ACOsb67nqaylECXbggMh4R/9LC/+FeGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWfxi/9mW0/7M1ZPzhtOYreczUxFEzzTBVpRxOz+b1Ud2SH4SFUMi7YS68tLdDTHRnT6QpF5uKuSewdr6Bf+DOtcw3GEZ5L3fyjrABH7qPBr1jXQG7pLvmtS5zAIH0qzPMnluOyI+lt59idhnbqaha1OimsGa0lW+88NbubUsxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaKRyAlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57924C4CEE4;
	Thu, 17 Apr 2025 17:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744910880;
	bh=bljGnNYfbh1ACOsb67nqaylECXbggMh4R/9LC/+FeGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IaKRyAlVUVJhaIx1Gb5dLjfBoT2ZX55tQ6Cchrw3byk9s0jZlvoCKw6yXKvTNSW0B
	 kO8aaU/SxMqYZ1mvhYkOZjhTG7DSvC0nznQQLrLOQRKM+84TLFPxDLNya8Jl0I+5z2
	 9FjELrGOunGdfizpkx2s7OepQfl0XAY2Zyz9JzVTd+CQcIBkT8uDZNslTAquu5rtwQ
	 4iSFbzJetdK016lFOOYOAHNK36uQiBXjSa3yjM5lAS95oy38EO8ZVBdzTRXrdcXrGq
	 /27qD2NZyvJk7vZyAbeMp4+XM79clZ5XDw5V6D7UFRlLjQTx0vlDhdzB8vME68oHYh
	 +GwcT4hRSb+Fw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 2/2] selftests: mptcp: add mptcp_lib_wait_local_port_listen
Date: Thu, 17 Apr 2025 19:27:52 +0200
Message-ID: <20250417172749.2446163-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025041756-ovary-sandfish-4a21@gregkh>
References: <2025041756-ovary-sandfish-4a21@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7462; i=matttbe@kernel.org; h=from:subject; bh=j3P95SBh5OkDH0uFs8kf2keZF36CNsnamq2iibJ43zo=; b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBoAToW+AWGSDuJKcOUwtM3Em+hZ/kwVpp39p7Fs Z+G9CrcbKKJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaAE6FgAKCRD2t4JPQmmg c+1fD/9ObzCPnpA5bFpSC7zlLuz0MVD4KYAOAa8AUnk5lioA9SAr/wzGmQaB9ZyY30dE8Vx43OV L/i41shgeH21jfI8FNhCJJn1e7qRYUXu0SA+1cNoFPY9mYDtXfDhhtn/pZ5K11GvPNjptqqR0s9 R9uRa0Vw68HE4BgLH32I3WnZuzdNKiGywmuHRldF+OVhaUZCy+nv6h6KdtL1DCGQW9oWAqsSkRq mJQ81U04YXSIGIH7N568CwDtT/z0kWVcImUnYsNJXdEA1v8UHE4iXuEF5YEIOe//AM4GwLSrUZD 2Z5BdN+w6gZRgzmGAwwAPeNlT9OPbza1OdT89WPMPHaMV2S1zu4HSnpUxjnvOHJ4GyRmH3Y0Dwr K8KEFa5dYaDuRMAIW0Fyg57s/aQZTIPLRu2y6ExP04PpqeHw6/rx6zWz+AR01VRYUr3Le4xpqMc 3fAb/bHC3r3ugN1SYVRQ5RmVwsvOJrW64H/h9hAL6ZwrCJ2R0dr9W3RN5ryp1eiSD6WZdgeKNb4 LMYA+ctD9IUA12Yr0SAYC4iVAY+aL9Iiyj2EToJSPuprWXQ3E2O4QA/eM75W5IkquT+jLyJW+Gu I0GO+aZyVBxTroiYRovRWJmLsrTdPCtOe/YS5cCWBHvp6aFdjTjqA6r72kMe+9St95ICYKAA1mD TVblzjkm5K5qpzw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

commit 9369777c29395730cec967e7d0f48aed872b7110 upstream.

To avoid duplicated code in different MPTCP selftests, we can add
and use helpers defined in mptcp_lib.sh.

wait_local_port_listen() helper is defined in diag.sh, mptcp_connect.sh,
mptcp_join.sh and simult_flows.sh, export it into mptcp_lib.sh and
rename it with mptcp_lib_ prefix. Use this new helper in all these
scripts.

Note: We only have IPv4 connections in this helper, not looking at IPv6
(tcp6) but that's OK because we only have IPv4 connections here in diag.sh.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231128-send-net-next-2023107-v4-15-8d6b94150f6b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 5afca7e996c4 ("selftests: mptcp: join: test for prohibited MPC to port-based endp")
[ Conflict in diag.sh, because commit 1f24ba67ba49 ("selftests: mptcp:
  diag: check CURRESTAB counters") that is more recent that the one
  here, has been backported in this kernel version before, introducing
  chk_msk_cestab() helper in the same context. wait_local_port_listen()
  was still the same as in the original, and can then be simply removed
  from diag.sh. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh     | 23 +++----------------
 .../selftests/net/mptcp/mptcp_connect.sh      | 19 +--------------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 20 +---------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 18 +++++++++++++++
 .../selftests/net/mptcp/simult_flows.sh       | 19 +--------------
 5 files changed, 24 insertions(+), 75 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 7f89623f1080..f00c97b2a6b5 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -186,23 +186,6 @@ chk_msk_inuse()
 	__chk_nr get_msk_inuse $expected "${msg}" 0
 }
 
-# $1: ns, $2: port
-wait_local_port_listen()
-{
-	local listener_ns="${1}"
-	local port="${2}"
-
-	local port_hex i
-
-	port_hex="$(printf "%04X" "${port}")"
-	for i in $(seq 10); do
-		ip netns exec "${listener_ns}" cat /proc/net/tcp | \
-			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
-			break
-		sleep 0.1
-	done
-}
-
 # $1: cestab nr
 chk_msk_cestab()
 {
@@ -240,7 +223,7 @@ echo "a" | \
 		ip netns exec $ns \
 			./mptcp_connect -p 10000 -l -t ${timeout_poll} -w 20 \
 				0.0.0.0 >/dev/null &
-wait_local_port_listen $ns 10000
+mptcp_lib_wait_local_port_listen $ns 10000
 chk_msk_nr 0 "no msk on netns creation"
 chk_msk_listen 10000
 
@@ -265,7 +248,7 @@ echo "a" | \
 		ip netns exec $ns \
 			./mptcp_connect -p 10001 -l -s TCP -t ${timeout_poll} -w 20 \
 				0.0.0.0 >/dev/null &
-wait_local_port_listen $ns 10001
+mptcp_lib_wait_local_port_listen $ns 10001
 echo "b" | \
 	timeout ${timeout_test} \
 		ip netns exec $ns \
@@ -288,7 +271,7 @@ for I in `seq 1 $NR_CLIENTS`; do
 				./mptcp_connect -p $((I+10001)) -l -w 20 \
 					-t ${timeout_poll} 0.0.0.0 >/dev/null &
 done
-wait_local_port_listen $ns $((NR_CLIENTS + 10001))
+mptcp_lib_wait_local_port_listen $ns $((NR_CLIENTS + 10001))
 
 for I in `seq 1 $NR_CLIENTS`; do
 	echo "b" | \
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index d203d314b7b2..3763ffa214d5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -342,23 +342,6 @@ do_ping()
 	return 0
 }
 
-# $1: ns, $2: port
-wait_local_port_listen()
-{
-	local listener_ns="${1}"
-	local port="${2}"
-
-	local port_hex i
-
-	port_hex="$(printf "%04X" "${port}")"
-	for i in $(seq 10); do
-		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
-			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
-			break
-		sleep 0.1
-	done
-}
-
 do_transfer()
 {
 	local listener_ns="$1"
@@ -448,7 +431,7 @@ do_transfer()
 				$extra_args $local_addr < "$sin" > "$sout" &
 	local spid=$!
 
-	wait_local_port_listen "${listener_ns}" "${port}"
+	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
 	local start
 	start=$(date +%s%3N)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 497dc187387f..442b7220468a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -598,24 +598,6 @@ link_failure()
 	done
 }
 
-# $1: ns, $2: port
-wait_local_port_listen()
-{
-	local listener_ns="${1}"
-	local port="${2}"
-
-	local port_hex
-	port_hex="$(printf "%04X" "${port}")"
-
-	local i
-	for i in $(seq 10); do
-		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
-			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
-			break
-		sleep 0.1
-	done
-}
-
 rm_addr_count()
 {
 	mptcp_lib_get_counter "${1}" "MPTcpExtRmAddr"
@@ -1117,7 +1099,7 @@ do_transfer()
 	fi
 	local spid=$!
 
-	wait_local_port_listen "${listener_ns}" "${port}"
+	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
 	extra_cl_args="$extra_args $extra_cl_args"
 	if [ "$test_linkfail" -eq 0 ];then
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index d98c89f31afe..919f4f1018eb 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -274,3 +274,21 @@ mptcp_lib_events() {
 	ip netns exec "${ns}" ./pm_nl_ctl events >> "${evts}" 2>&1 &
 	pid=$!
 }
+
+# $1: ns, $2: port
+mptcp_lib_wait_local_port_listen() {
+	local listener_ns="${1}"
+	local port="${2}"
+
+	local port_hex
+	port_hex="$(printf "%04X" "${port}")"
+
+	local _
+	for _ in $(seq 10); do
+		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
+			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) \
+			     {rc=0; exit}} END {exit rc}" &&
+			break
+		sleep 0.1
+	done
+}
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index f24bd2bf0831..214a89fce8b8 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -123,23 +123,6 @@ setup()
 	grep -q ' kmemleak_init$\| lockdep_init$\| kasan_init$\| prove_locking$' /proc/kallsyms && slack=$((slack+550))
 }
 
-# $1: ns, $2: port
-wait_local_port_listen()
-{
-	local listener_ns="${1}"
-	local port="${2}"
-
-	local port_hex i
-
-	port_hex="$(printf "%04X" "${port}")"
-	for i in $(seq 10); do
-		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
-			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
-			break
-		sleep 0.1
-	done
-}
-
 do_transfer()
 {
 	local cin=$1
@@ -179,7 +162,7 @@ do_transfer()
 				0.0.0.0 < "$sin" > "$sout" &
 	local spid=$!
 
-	wait_local_port_listen "${ns3}" "${port}"
+	mptcp_lib_wait_local_port_listen "${ns3}" "${port}"
 
 	timeout ${timeout_test} \
 		ip netns exec ${ns1} \
-- 
2.48.1


