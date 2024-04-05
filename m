Return-Path: <stable+bounces-36131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643C589A16B
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 17:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB5D1C23AE8
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 15:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F400616FF30;
	Fri,  5 Apr 2024 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbZAozqu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1081171065;
	Fri,  5 Apr 2024 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331438; cv=none; b=Yr9osAZ7ih95TM6kh3X4h8fnDAWxuT3bojuGl2pNXdgjMyy0DGqX87qeUaUTtSpqhFCZbluFcMt6BRcLXGK7Ea6ipkuBjQWyefzwiF56tpKlgiYP+HTA5mIyKSHvsXVIaEvdveFpyQvvVQIt7Y8mKFixFklCiWHvBGKzq50mhZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331438; c=relaxed/simple;
	bh=4IwTE+tD05bK8y+QH3S9Bt5Z05MGO2zaqvbRugPo8ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olaO1DkAHqt7RfnONs9uFIDJAzi5cvUc/imAf+8DC72KSVn0XE/2LSRBAtnhLhyFuiQZTE/eSBou5tblpf2F7RgvEt/cppyS5DfI5GBoeTkiUToTDkucFWKBLtzDMYIooMida+CPdGeBXAHPZCyggjDi3eGYu9najd43jEanDh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbZAozqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3ACAC433B2;
	Fri,  5 Apr 2024 15:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712331438;
	bh=4IwTE+tD05bK8y+QH3S9Bt5Z05MGO2zaqvbRugPo8ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbZAozqu4tqnnuF/Jw9Za5D963airzgMNm72RNTXQ5cZJs605IHnFbLPsACvqguF7
	 ltQNjGvJaMFicBYiOcBI5vrDvV0HwPykD2zvaznk05IGMIGzM+TgIaR/Y5rytsxtZ0
	 3FXZ4JgLNeZHxIyp/G1m4gAGrlGpB3YbtNIZWgm59mKqgl+KchYGKTlayj2BEaCp+N
	 ZpGNi98626tBNLfZOELPQ52F1zlgiDxQenFi/niHbTVfJ69SIyjiiTXXldb8WDbWkO
	 Y1qZyJI/BfJg8KnFdw8m8FZ6N+WEv2WSvwbIJp31wkVR7Vs276uxvwOzC9Ph/qIJ3G
	 jdMT/7w9pt1rA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 3/5] selftests: mptcp: use += operator to append strings
Date: Fri,  5 Apr 2024 17:36:40 +0200
Message-ID: <20240405153636.958019-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024040520-unselect-antitrust-a41b@gregkh>
References: <2024040520-unselect-antitrust-a41b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8858; i=matttbe@kernel.org; h=from:subject; bh=Kx0Ehs4adSddVAxK8Tfj3O2cfIzZae8mLVEqrRQjIg0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmEBqFJpEGYAKx20eR3cLuEBc9ftKGaj2LPR+bI DA6Ne4HPIiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZhAahQAKCRD2t4JPQmmg c5d+EACzWczI4dCBMiqfhhk3voBSm5d8pazp3l2iZbVGbdoxO7mmxPAkDQ3p98ilh2zL+Wm3UKD yZbhVCrX57vyYi6Is1ZGCsKgREerM5+VfwPUgUjR+srYxXgswQG4+KoMo7KVsirfNRpNbkWuZtb 9qYPsVGcNVSkD2CASeWn47byt6XWY3BL4ofvMD/bk8JOgOjBvLEJa3th6Y+PmXFf8A4F8KDES7p wzTlY/XCWwV+5h+uYO2Mv94ea0T9yJ1HLNzpDtQGbj+dEvUicOpBpSxb8li2Fw5oMMSFKs4gODJ PvBjHYXWAxpgYi5xNfISSFQp8My2maYVmesk2S83LLLjiWgO2jn/9qtUecSYwDpmQVdm4Cu0zb4 6sjw+kdO/BlbhT2waBVK2Qi5WidBITrBdYImEhR2jsGMVrDohhDnGI53JfDW5gtIV2732nyd73z moPrz8ULK+VmU5vWQ0ntnKu0uSYRyDFgtL4KcsrLYjHDI6Cdg/2sikkGlE1f7xG3XQGEgc+qUh4 8vJ+qjJ1DZuhXuUiI0X2fnP0QJ253mu+icaVjTsRes5RoLRChWzAXTwXkB0ON0MYyA3cmDgjKbi mIEegCdvZB3du6I8X5RR+dZl6wCRjhiXiJmXWj8dO1ugpf227GQgcU+cjUNf/N8vsSjf3E/Th5w XKiNPFhy/H22nqg==
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
index 8b3017cedba0..f40d3222442b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -374,15 +374,15 @@ do_transfer()
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
@@ -501,6 +501,7 @@ do_transfer()
 	check_transfer $cin $sout "file received by server"
 	rets=$?
 
+	local extra=""
 	local stat_synrx_now_l
 	local stat_ackrx_now_l
 	local stat_cookietx_now
@@ -534,7 +535,7 @@ do_transfer()
 				"${stat_ackrx_now_l}" "${expect_ackrx}" 1>&2
 			rets=1
 		else
-			printf "[ Note ] fallback due to TCP OoO"
+			extra+=" [ Note ] fallback due to TCP OoO"
 		fi
 	fi
 
@@ -557,39 +558,41 @@ do_transfer()
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
@@ -915,8 +918,8 @@ mptcp_lib_result_code "${ret}" "ping tests"
 stop_if_error "Could not even run ping tests"
 
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
-echo -n "INFO: Using loss of $tc_loss "
-test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
+tc_info="loss of $tc_loss "
+test "$tc_delay" -gt 0 && tc_info+="delay $tc_delay ms "
 
 reorder_delay=$((tc_delay / 4))
 
@@ -927,17 +930,17 @@ if [ -z "${tc_reorder}" ]; then
 
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
index e6b778a9a937..eb227557d590 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -822,18 +822,18 @@ pm_nl_check_endpoint()
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
@@ -1256,7 +1256,7 @@ chk_csum_nr()
 	print_check "sum"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns1" ]; then
-		extra_msg="$extra_msg ns1=$count"
+		extra_msg+=" ns1=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1269,7 +1269,7 @@ chk_csum_nr()
 	print_check "csum"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns2" ]; then
-		extra_msg="$extra_msg ns2=$count"
+		extra_msg+=" ns2=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1313,7 +1313,7 @@ chk_fail_nr()
 	print_check "ftx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFailTx")
 	if [ "$count" != "$fail_tx" ]; then
-		extra_msg="$extra_msg,tx=$count"
+		extra_msg+=",tx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1327,7 +1327,7 @@ chk_fail_nr()
 	print_check "failrx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFailRx")
 	if [ "$count" != "$fail_rx" ]; then
-		extra_msg="$extra_msg,rx=$count"
+		extra_msg+=",rx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1362,7 +1362,7 @@ chk_fclose_nr()
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$fclose_tx" ]; then
-		extra_msg="$extra_msg,tx=$count"
+		extra_msg+=",tx=$count"
 		fail_test "got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
 	else
 		print_ok
@@ -1373,7 +1373,7 @@ chk_fclose_nr()
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$fclose_rx" ]; then
-		extra_msg="$extra_msg,rx=$count"
+		extra_msg+=",rx=$count"
 		fail_test "got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
 	else
 		print_ok
@@ -1742,7 +1742,7 @@ chk_rm_nr()
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


