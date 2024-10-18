Return-Path: <stable+bounces-86859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29289A430A
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 17:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6BB28797F
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 15:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7472022D7;
	Fri, 18 Oct 2024 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxDjPB9D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BCB165EFC;
	Fri, 18 Oct 2024 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267068; cv=none; b=aWDH8v/AqEOIuyA17wMWsBBzNtSNswLVcLdPH5dDt3Y6Y91y2bkFdxcEDW8p0KNM2hKTM4KL/UUgDTjtoAqufNiUHF8PXcaei5jObENZtWrr46xm56YnRIloPTAh137pDxqf3ovdCdJ/9S6fMZ2EkX4Jd2uVMTVg/koJcRe3XZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267068; c=relaxed/simple;
	bh=qo6r/mw8oUE9DD2fRzr4sCwXq4FPKMbhhVDz0oHu4g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTO3t4gIx6S7nwxEyM31ihf3sopPsN5HW6m+sUSgUHY+Z4qrNdnI3fuvPkmuTtu2mZSpw7l8NauqgQDKj/shbhJWKjoK94nCZgDN8HQ4h+HL/iSXdrZ3z9AIsev5mMXil3H1+L6aJYxPk14QLRIRnEoixpKrnA/OzZUvcXL95II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxDjPB9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D18C4CEC7;
	Fri, 18 Oct 2024 15:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729267068;
	bh=qo6r/mw8oUE9DD2fRzr4sCwXq4FPKMbhhVDz0oHu4g0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pxDjPB9DharNY3H1ORgKAzGSmohIMh2rm0C/sLhus02evk2mH+RLfKe2XfESkWIkb
	 kq9cudYIEGgUqsc+urTs41e48zumiMfxeH7HOsIdVx4sS5GxnCHxavREmubuaNt73X
	 AVBoX7cQTw3tUNYiJuAuXbzZC6hJHKE9CFm7uNGnpsYU5RlZ5rW+OT88ezSN/5036S
	 yf/780tSjE+/7t/y9IVRvWs23NqzojPSlcVimTexxaYe5GgZ+lssLPxjsBdsaKuTYJ
	 2DK2QfEC6w3XABsRiM6GTUY5bKHJRyUSVJvGUGYj51A4OgCNsNBrFMWAPBc3cwJooZ
	 NaHJ1+h5a9DMg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 3/4] selftests: mptcp: join: test for prohibited MPC to port-based endp
Date: Fri, 18 Oct 2024 17:57:38 +0200
Message-ID: <20241018155734.2548697-9-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018155734.2548697-6-matttbe@kernel.org>
References: <20241018155734.2548697-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5983; i=matttbe@kernel.org; h=from:subject; bh=k+Xh3xbMiatTkG5lalMrGfe9U2p513cAqnUCtPHiMbE=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnEoVuS0rHOY21lmMlCUaSf1RUg2tJcTn4q+arE aKHbpr3AN6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxKFbgAKCRD2t4JPQmmg cxE/EADxO6yviDnmj5lsHYB748pmbvG0s++t6ImmFy0CB6Ta0HnU/9FHTBLnzMgqiLpE58cNpwg F/i0Inba1yZjLIDvPACTl7Iml+LN7HMKejscxWR9mf5s2rDfQZ8krGbz3ZIvsN4tCPtotMa5pft x0BAHTvauixGcQj/34RY/mCa3KEci6VAJ/pqzvsBEkGE5qP3BCZ2iFXwnX44Z/hO+DRwJtZAkW3 3FkjaOWFFwLBOFQgjku4ilp2P0C6valfc0IA8GrNHJfKF+6k93ZjPkHlBt/VYqgH8YFQ6cJ70B4 XFA2HCAiQwFhY8MDSJeJ+bKIoHONk5o//kcMWjsXaLnZpSu9DYn63sOLqxTuADt5C8nJkjYgqq2 taFMNNxtqTivx0i1P9sX6pxnOjWhP8M32UAD10P+mCgUmXpSBmIqOXhTQ0J2RewzfV8/Qg+stRQ jEHfBfQwME6DWJKek6BSl3+HNXJFFJk3GAZTHB3qPToDqrE3wFxrCbqK02qC+diZmQBuzRPBKgL NUemsxOEvRGvRXSaPKHB+XZN2tCMC9jSS+XSDKlxh0ON0xhTZUwmZa+3TG60YsOEsonvOu5CELH gj5Yz/Eq09JcdzvA5jqOI0cDGgARRRHi16TTppxHttLFls0ob3UgPDFR/Z9bekk06fVB5aDdyRD sj/7K4OO71dpljw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 5afca7e996c42aed1b4a42d4712817601ba42aff upstream.

Explicitly verify that MPC connection attempts towards a port-based
signal endpoint fail with a reset.

Note that this new test is a bit different from the other ones, not
using 'run_tests'. It is then needed to add the capture capability, and
the picking the right port which have been extracted into three new
helpers. The info about the capture can also be printed from a single
point, which simplifies the exit paths in do_transfer().

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Cc: stable@vger.kernel.org
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241014-net-mptcp-mpc-port-endp-v2-2-7faea8e6b6ae@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mptcp_join.sh, because commit 0bd962dd86b2 ("selftests:
  mptcp: join: check CURRESTAB counters"), and commit 9e6a39ecb9a1
  ("selftests: mptcp: export TEST_COUNTER variable") are linked to new
  features, not available in this version. Resolving the conflicts is
  easy, simply adding the new helpers before do_transfer(), and rename
  MPTCP_LIB_TEST_COUNTER to TEST_COUNT that was used before. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 117 +++++++++++++-----
 1 file changed, 86 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a21376b0f61d..17ace5627ce3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -23,6 +23,7 @@ tmpfile=""
 cout=""
 err=""
 capout=""
+cappid=""
 ns1=""
 ns2=""
 ksft_skip=4
@@ -1006,6 +1007,44 @@ pm_nl_set_endpoint()
 	fi
 }
 
+cond_start_capture()
+{
+	local ns="$1"
+
+	:> "$capout"
+
+	if $capture; then
+		local capuser capfile
+		if [ -z $SUDO_USER ]; then
+			capuser=""
+		else
+			capuser="-Z $SUDO_USER"
+		fi
+
+		capfile=$(printf "mp_join-%02u-%s.pcap" "$TEST_COUNT" "$ns")
+
+		echo "Capturing traffic for test $TEST_COUNT into $capfile"
+		ip netns exec "$ns" tcpdump -i any -s 65535 -B 32768 $capuser -w "$capfile" > "$capout" 2>&1 &
+		cappid=$!
+
+		sleep 1
+	fi
+}
+
+cond_stop_capture()
+{
+	if $capture; then
+		sleep 1
+		kill $cappid
+		cat "$capout"
+	fi
+}
+
+get_port()
+{
+	echo "$((10000 + TEST_COUNT - 1))"
+}
+
 do_transfer()
 {
 	local listener_ns="$1"
@@ -1013,33 +1052,17 @@ do_transfer()
 	local cl_proto="$3"
 	local srv_proto="$4"
 	local connect_addr="$5"
+	local port
 
-	local port=$((10000 + TEST_COUNT - 1))
-	local cappid
 	local FAILING_LINKS=${FAILING_LINKS:-""}
 	local fastclose=${fastclose:-""}
 	local speed=${speed:-"fast"}
+	port=$(get_port)
 
 	:> "$cout"
 	:> "$sout"
-	:> "$capout"
 
-	if $capture; then
-		local capuser
-		if [ -z $SUDO_USER ] ; then
-			capuser=""
-		else
-			capuser="-Z $SUDO_USER"
-		fi
-
-		capfile=$(printf "mp_join-%02u-%s.pcap" "$TEST_COUNT" "${listener_ns}")
-
-		echo "Capturing traffic for test $TEST_COUNT into $capfile"
-		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuser -w $capfile > "$capout" 2>&1 &
-		cappid=$!
-
-		sleep 1
-	fi
+	cond_start_capture ${listener_ns}
 
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
 		nstat -n
@@ -1125,10 +1148,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	if $capture; then
-	    sleep 1
-	    kill $cappid
-	fi
+	cond_stop_capture
 
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
 		nstat | grep Tcp > /tmp/${listener_ns}.out
@@ -1144,7 +1164,6 @@ do_transfer()
 		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
 		cat /tmp/${connector_ns}.out
 
-		cat "$capout"
 		return 1
 	fi
 
@@ -1161,13 +1180,7 @@ do_transfer()
 	fi
 	rets=$?
 
-	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
-		cat "$capout"
-		return 0
-	fi
-
-	cat "$capout"
-	return 1
+	[ $retc -eq 0 ] && [ $rets -eq 0 ]
 }
 
 make_file()
@@ -2944,6 +2957,32 @@ verify_listener_events()
 	fail_test "$e_type:$type $e_family:$family $e_saddr:$saddr $e_sport:$sport"
 }
 
+chk_mpc_endp_attempt()
+{
+	local retl=$1
+	local attempts=$2
+
+	print_check "Connect"
+
+	if [ ${retl} = 124 ]; then
+		fail_test "timeout on connect"
+	elif [ ${retl} = 0 ]; then
+		fail_test "unexpected successful connect"
+	else
+		print_ok
+
+		print_check "Attempts"
+		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPCapableEndpAttempt")
+		if [ -z "$count" ]; then
+			print_skip
+		elif [ "$count" != "$attempts" ]; then
+			fail_test "got ${count} MPC attempt[s] on port-based endpoint, expected ${attempts}"
+		else
+			print_ok
+		fi
+	fi
+}
+
 add_addr_ports_tests()
 {
 	# signal address with port
@@ -3034,6 +3073,22 @@ add_addr_ports_tests()
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2 2
 	fi
+
+	if reset "port-based signal endpoint must not accept mpc"; then
+		local port retl count
+		port=$(get_port)
+
+		cond_start_capture ${ns1}
+		pm_nl_add_endpoint ${ns1} 10.0.2.1 flags signal port ${port}
+		mptcp_lib_wait_local_port_listen ${ns1} ${port}
+
+		timeout 1 ip netns exec ${ns2} \
+			./mptcp_connect -t ${timeout_poll} -p $port -s MPTCP 10.0.2.1 >/dev/null 2>&1
+		retl=$?
+		cond_stop_capture
+
+		chk_mpc_endp_attempt ${retl} 1
+	fi
 }
 
 syncookies_tests()
-- 
2.45.2


