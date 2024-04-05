Return-Path: <stable+bounces-36119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B836289A030
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 16:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B781C21486
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 14:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDED16F29D;
	Fri,  5 Apr 2024 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA5esWvU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE2116D9B3;
	Fri,  5 Apr 2024 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328699; cv=none; b=eooRyl9Ume5MQpVnyS003V90lb0UbfY/RWsQVzD8RKuhzPt3F0oX842XwPQiGNfM17sMBO+/W/CGuLnXSn8sEJqGTGMtlqm0vVGhmJHkjsst30Es6UVYwkhXe9PydV6iBE8QID2xtQ0dnIgDt8koJexDORbQwmqdB37vvyBt9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328699; c=relaxed/simple;
	bh=1xA36JhL2+IDYs/yVQw5bVmFfa/NP0uELx+AwgAMuHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAb/5Mk/7G5DpsXADW9fmB1HDlqhA+n+dDyy/b/5X+GcOedTUL9PDMTQ3yJOIldH2x4ilxFLGuQYT6J0jSGSqWZ+G3z5MLWC5Klo9cO3Gvb9GxNpc/SIRbfIUnT31hwtBwQdfJq/Fkt1cuXS1rhzM2QfoWwNHbjDo4vtEyzUfNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA5esWvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF975C433C7;
	Fri,  5 Apr 2024 14:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712328699;
	bh=1xA36JhL2+IDYs/yVQw5bVmFfa/NP0uELx+AwgAMuHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kA5esWvUaS3J+nQNpzBkl0vhclpnx6RSvtTZ+MNnP4fK6aHoC5ub/t9F8OWNUPLLf
	 u40SNJbT5uhXzHHhBwA4cvb0e0sb4Q5i8XAeJ7LKUsoMX0SvHUda8IvOGmJvlBMReG
	 qZwJBhLx6FccO8Qq/InuyeOrKPYl6BOKvEvHe6BoZZaRJfTgAZVa/iFve2qzegR42S
	 6nCojjKaV1edPN6pbif3stQ3s+Iay0CLD55kDC8ihytcmT/HjjI4bEpPTMFlR0AyZ5
	 SH/PHPAECMwC2xU4/Xst6ibL9QtexsyjsG0uafq8+sT3bctPCNbK6iEX/2QURnGfMW
	 CaaebaHNc7+Ug==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.8.y 2/3] selftests: mptcp: use += operator to append strings
Date: Fri,  5 Apr 2024 16:51:20 +0200
Message-ID: <20240405145117.854766-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024040519-palpable-barrel-9103@gregkh>
References: <2024040519-palpable-barrel-9103@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8868; i=matttbe@kernel.org; h=from:subject; bh=7KaHpl9pSdN5SiiX0MJ9bIOclaO2t4B8+rVqfkkvdJc=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmEA/msuzoYabH3zbhFkocO+QPYYyy2+WGma9dL FpcuWTmXnuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZhAP5gAKCRD2t4JPQmmg c/ZgD/491hNo6kp+fVXj2xfaxGdihugocaIohlO411h1H2q9KG6iNCFBXzGlFr3wCjRT3++SKVs xY2kRr6qb9M9lMOz2791rhG3xBZHlOvWZsJrnh+mczOWF1xR4LMseKgt5VlF7ayEk+jcuufdB81 UFJCIrS1e0XutEJUaoLP2FgJ+Zq9k4/wiczrbypFH4Psf1FwhCor3Uvfa3rM9ZnLnfWy7vus5+j 6r9z603BdlcfFsCEkdUsxsMnFGNE1Ect2+rjSbfgd4k19h7NW8+htLIXpo6w2ql2IFCyuAECbO7 NW+lnGIpNxtRZ2+kN8NQs2xRBDmb1H9ZtvQkxKJ2pcW80UJnDGyFvQLSzG/3nl0W+92Phog2sil g4FHcboiInJ630LmjCqfunae/UfU6chB34Jd73C8eJ2cBpJpzlPz8+HGmF17+s3fPdJctrWfo7g HRysOGY/KTMU5n4TBzApB8IJGUrumgS1Jh8O5SD88vN6+yLqy58hHHJcFyZqtwgZiTQjZHCQ4as 2yTZJSs4qOh0u1pra5ei05op7wIb1JWha1liQMkTyzbAddjUd+hJdSRaH4G/dv/jHlwXOkSX3Io 4EcxgnOUBiHM1tX6bxrlHBvHJTM9DFA6HUKb8zELyArkWQbxOcm5StJRVihntAJnSCtwrZGU79L NxS28GsRWHCHxWg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses addition assignment operator (+=) to append strings
instead of duplicating the variable name in mptcp_connect.sh and
mptcp_join.sh.

This can make the statements shorter.

Note: in mptcp_connect.sh, add a local variable extra in do_transfer to
save the various extra warning logs, using += to append it. And add a
new variable tc_info to save various tc info, also using += to append it.
This can make the code more readable and prepare for the next commit.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-8-4f42c347b653@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit e7c42bf4d320affe37337aa83ae0347832b3f568)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 53 ++++++++++---------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++------
 2 files changed, 43 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index cce0e553976f..f8e1b3daa748 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -332,15 +332,15 @@ do_transfer()
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
-		extra_args="$extra_args -R $rcvbuf"
+		extra_args+=" -R $rcvbuf"
 	fi
 
 	if [ "$sndbuf" -gt 0 ]; then
-		extra_args="$extra_args -S $sndbuf"
+		extra_args+=" -S $sndbuf"
 	fi
 
 	if [ -n "$testmode" ]; then
-		extra_args="$extra_args -m $testmode"
+		extra_args+=" -m $testmode"
 	fi
 
 	if [ -n "$extra_args" ] && $options_log; then
@@ -459,6 +459,7 @@ do_transfer()
 	mptcp_lib_check_transfer $cin $sout "file received by server"
 	rets=$?
 
+	local extra=""
 	local stat_synrx_now_l
 	local stat_ackrx_now_l
 	local stat_cookietx_now
@@ -492,7 +493,7 @@ do_transfer()
 				"${stat_ackrx_now_l}" "${expect_ackrx}" 1>&2
 			rets=1
 		else
-			printf "[ Note ] fallback due to TCP OoO"
+			extra+=" [ Note ] fallback due to TCP OoO"
 		fi
 	fi
 
@@ -515,39 +516,41 @@ do_transfer()
 		fi
 	fi
 
-	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
-		printf "[ OK ]"
-		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
-	else
-		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
-	fi
-
 	if [ $cookies -eq 2 ];then
 		if [ $stat_cookietx_last -ge $stat_cookietx_now ] ;then
-			printf " WARN: CookieSent: did not advance"
+			extra+=" WARN: CookieSent: did not advance"
 		fi
 		if [ $stat_cookierx_last -ge $stat_cookierx_now ] ;then
-			printf " WARN: CookieRecv: did not advance"
+			extra+=" WARN: CookieRecv: did not advance"
 		fi
 	else
 		if [ $stat_cookietx_last -ne $stat_cookietx_now ] ;then
-			printf " WARN: CookieSent: changed"
+			extra+=" WARN: CookieSent: changed"
 		fi
 		if [ $stat_cookierx_last -ne $stat_cookierx_now ] ;then
-			printf " WARN: CookieRecv: changed"
+			extra+=" WARN: CookieRecv: changed"
 		fi
 	fi
 
 	if [ ${stat_synrx_now_l} -gt ${expect_synrx} ]; then
-		printf " WARN: SYNRX: expect %d, got %d (probably retransmissions)" \
-			"${expect_synrx}" "${stat_synrx_now_l}"
+		extra+=" WARN: SYNRX: expect ${expect_synrx},"
+		extra+=" got ${stat_synrx_now_l} (probably retransmissions)"
 	fi
 	if [ ${stat_ackrx_now_l} -gt ${expect_ackrx} ]; then
-		printf " WARN: ACKRX: expect %d, got %d (probably retransmissions)" \
-			"${expect_ackrx}" "${stat_ackrx_now_l}"
+		extra+=" WARN: ACKRX: expect ${expect_ackrx},"
+		extra+=" got ${stat_ackrx_now_l} (probably retransmissions)"
+	fi
+
+	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
+		printf "[ OK ]%s\n" "${extra:1}"
+		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
+	else
+		if [ -n "${extra}" ]; then
+			printf "%s\n" "${extra:1}"
+		fi
+		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
 	fi
 
-	echo
 	cat "$capout"
 	[ $retc -eq 0 ] && [ $rets -eq 0 ]
 }
@@ -872,8 +875,8 @@ mptcp_lib_result_code "${ret}" "ping tests"
 stop_if_error "Could not even run ping tests"
 
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
-echo -n "INFO: Using loss of $tc_loss "
-test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
+tc_info="loss of $tc_loss "
+test "$tc_delay" -gt 0 && tc_info+="delay $tc_delay ms "
 
 reorder_delay=$((tc_delay / 4))
 
@@ -884,17 +887,17 @@ if [ -z "${tc_reorder}" ]; then
 
 	if [ $reorder_delay -gt 0 ] && [ $reorder1 -lt 100 ] && [ $reorder2 -gt 0 ]; then
 		tc_reorder="reorder ${reorder1}% ${reorder2}%"
-		echo -n "$tc_reorder with delay ${reorder_delay}ms "
+		tc_info+="$tc_reorder with delay ${reorder_delay}ms "
 	fi
 elif [ "$tc_reorder" = "0" ];then
 	tc_reorder=""
 elif [ "$reorder_delay" -gt 0 ];then
 	# reordering requires some delay
 	tc_reorder="reorder $tc_reorder"
-	echo -n "$tc_reorder with delay ${reorder_delay}ms "
+	tc_info+="$tc_reorder with delay ${reorder_delay}ms "
 fi
 
-echo "on ns3eth4"
+echo "INFO: Using ${tc_info}on ns3eth4"
 
 tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${reorder_delay}ms $tc_reorder
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e4581b0dfb96..df7521aa274b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -799,18 +799,18 @@ pm_nl_check_endpoint()
 		line="${line% }"
 		# the dump order is: address id flags port dev
 		[ -n "$addr" ] && expected_line="$addr"
-		expected_line="$expected_line $id"
-		[ -n "$_flags" ] && expected_line="$expected_line ${_flags//","/" "}"
-		[ -n "$dev" ] && expected_line="$expected_line $dev"
-		[ -n "$port" ] && expected_line="$expected_line $port"
+		expected_line+=" $id"
+		[ -n "$_flags" ] && expected_line+=" ${_flags//","/" "}"
+		[ -n "$dev" ] && expected_line+=" $dev"
+		[ -n "$port" ] && expected_line+=" $port"
 	else
 		line=$(ip netns exec $ns ./pm_nl_ctl get $_id)
 		# the dump order is: id flags dev address port
 		expected_line="$id"
-		[ -n "$flags" ] && expected_line="$expected_line $flags"
-		[ -n "$dev" ] && expected_line="$expected_line $dev"
-		[ -n "$addr" ] && expected_line="$expected_line $addr"
-		[ -n "$_port" ] && expected_line="$expected_line $_port"
+		[ -n "$flags" ] && expected_line+=" $flags"
+		[ -n "$dev" ] && expected_line+=" $dev"
+		[ -n "$addr" ] && expected_line+=" $addr"
+		[ -n "$_port" ] && expected_line+=" $_port"
 	fi
 	if [ "$line" = "$expected_line" ]; then
 		print_ok
@@ -1261,7 +1261,7 @@ chk_csum_nr()
 	print_check "sum"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns1" ]; then
-		extra_msg="$extra_msg ns1=$count"
+		extra_msg+=" ns1=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1274,7 +1274,7 @@ chk_csum_nr()
 	print_check "csum"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns2" ]; then
-		extra_msg="$extra_msg ns2=$count"
+		extra_msg+=" ns2=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1318,7 +1318,7 @@ chk_fail_nr()
 	print_check "ftx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFailTx")
 	if [ "$count" != "$fail_tx" ]; then
-		extra_msg="$extra_msg,tx=$count"
+		extra_msg+=",tx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1332,7 +1332,7 @@ chk_fail_nr()
 	print_check "failrx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFailRx")
 	if [ "$count" != "$fail_rx" ]; then
-		extra_msg="$extra_msg,rx=$count"
+		extra_msg+=",rx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1367,7 +1367,7 @@ chk_fclose_nr()
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$fclose_tx" ]; then
-		extra_msg="$extra_msg,tx=$count"
+		extra_msg+=",tx=$count"
 		fail_test "got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
 	else
 		print_ok
@@ -1378,7 +1378,7 @@ chk_fclose_nr()
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$fclose_rx" ]; then
-		extra_msg="$extra_msg,rx=$count"
+		extra_msg+=",rx=$count"
 		fail_test "got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
 	else
 		print_ok
@@ -1747,7 +1747,7 @@ chk_rm_nr()
 		count=$((count + cnt))
 		if [ "$count" != "$rm_subflow_nr" ]; then
 			suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
-			extra_msg="$extra_msg simult"
+			extra_msg+=" simult"
 		fi
 		if [ $count -ge "$rm_subflow_nr" ] && \
 		   [ "$count" -le "$((rm_subflow_nr *2 ))" ]; then
-- 
2.43.0


