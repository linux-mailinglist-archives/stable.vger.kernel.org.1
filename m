Return-Path: <stable+bounces-25926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7918702E4
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 14:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8CB1C23CE7
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 13:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6FC3F9E1;
	Mon,  4 Mar 2024 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1w3g7mj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D263F8D3;
	Mon,  4 Mar 2024 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559545; cv=none; b=PUUPgtuF8qjpgWLr7bnZm334CqwJn/Gv6+fhM6D/VXbbIZ5ytjwtLfggvkeZcSiWThDyGg1dJDxU0JE1BKo+KR25LpsnpI7q2LQGWlhUDsQ6AeTitPP55nNmWKaNYGRXPbwi5W1cxH6jRmU1mUbrCof5RtRzblO++Sl6tz9gIy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559545; c=relaxed/simple;
	bh=a3ZZmvOJyixL19OyiRHz8eY0l5dHLGerJt30f39okFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UU1mKShMSJCCJKhysgRZ/nr4z5j2k9S7n/SvtTme+JfTToWBtdr6nJcuA29rj5nvuj+kIixReu1/HDH21g7uyndu/wPupynjJyWyMNqOdLsSrGCGnHO3JjX5aXfnWUW7THcY516BuNEafUlwn0VOcU87LcStV3abmsAWnDq2mXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1w3g7mj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC40C43390;
	Mon,  4 Mar 2024 13:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709559545;
	bh=a3ZZmvOJyixL19OyiRHz8eY0l5dHLGerJt30f39okFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e1w3g7mjx+gvad5LStXHlmUctQasDc9qy8kQUEvbU8OyQ3x6dax4j8pAfuwVqpCtI
	 Hx+Lt677i1zC1tJZaMxnqD+j01UpO0KkyYcJiC2rI+dIcoFAN676RMj5XmRTm3wi02
	 e02x7VSefL53rpoSRPGx0ZT4SbNwVRxFA1LkCjREco0PwHWCL022cQxoBoT9N6Qt+/
	 sZ0zF1z5bVlOy82lSU7nT0iEzm4RU7NyQ98TxUuVP/3UxXtOR4BzKdFamT49oYy/q/
	 EmGYrEQSPR/PkKwNncKTGD1mFqixKbBF0XTK2z1oxQu2V+QeOrQ0lFMQhzhSL/Wcj0
	 iCBhQEHCnae6g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.7.y 1/5] selftests: mptcp: add evts_get_info helper
Date: Mon,  4 Mar 2024 14:38:29 +0100
Message-ID: <20240304133827.1989736-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024030420-swimsuit-antacid-a0dd@gregkh>
References: <2024030420-swimsuit-antacid-a0dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13215; i=matttbe@kernel.org; h=from:subject; bh=aUt0iiMdC3DmQMypDBE8W1zP3AjCpEc6S6LCYKS2SGU=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5c7UOiApqXzQf/I7UmeQsjD5udtXdUUCNR4Sk bZzdlaRpE6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeXO1AAKCRD2t4JPQmmg cyG2D/9BhSy9pCM6YNFrhgwKCl4DqAL38G06jJze/dSDIdaOMI98HKZSYF28SiLRDl6VGITfycY uOj7FlIaELv393dyDnmUcAi9GFmYIlsof8S04SFk6zTA+Pmh85ijxkiq1D8TTRxMvpKJ6NNkyU2 1Z4uSLNw7u4SiEeLedhyJ/8xh97j95qO+ccpK6n8chiVQ2pjyK0qqB+yjPPKOAjwNoGNj3Lb1kw lhy87ZMqUBYN81PbBLZ+QdOkjX7hCQVpRWtISBqRnvHTNAXos9f3ZtYR9WKnui0bZsRrS6kvqF7 5+/3GnkbZ61EULhr6fQdyi+DGI1NDzm70A1UjVN8HprjCJlqcSLksK9QCpA4FT2NhwCGuHIsvUi vnfL/K+gzswyqT/qn8i4bhHn0s488x7Er/1WcofXJuC8nv+PMLxju6hF08rvDxSobG+wD5xY6qr hvVYNE6Kel0EgdHB79UA7m6bUuqStJpAW2RVPs7jHde/VxufnfvCFRzlVV1vcpx1E7qIWjpPvTx nGg46vyP9IEdy27jkfk1flb/Qr9AdlT+wEu1/5wPSM3jAkDhVkFPhvtNtuRe943lktFPRwMgLhL NINB7xnD6kvMAVogFnxTL/6EPJC3JUAoQEOZTk8F7AJixdpXYHsMCRLm+GgeA3VSYYaPzLukNKl JMf4Oe7Of7ZuyNA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch adds a new helper get_info_value(), using 'sed' command to
parse the value of the given item name in the line with the given keyword,
to make chk_mptcp_info() and pedit_action_pkts() more readable.

Also add another helper evts_get_info() to use get_info_value() to parse
the output of 'pm_nl_ctl events' command, to make all the userspace pm
selftests more readable, both in mptcp_join.sh and userspace_pm.sh.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231128-send-net-next-2023107-v4-2-8d6b94150f6b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 06848c0f341ee3f9226ed01e519c72e4d2b6f001)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 ++--
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 10 +++
 .../selftests/net/mptcp/userspace_pm.sh       | 86 +++++++++----------
 3 files changed, 57 insertions(+), 58 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 927bc45ddf63..7140a40042b2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1845,10 +1845,8 @@ chk_mptcp_info()
 
 	print_check "mptcp_info ${info1:0:8}=$exp1:$exp2"
 
-	cnt1=$(ss -N $ns1 -inmHM | grep "$info1:" |
-	       sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
-	cnt2=$(ss -N $ns2 -inmHM | grep "$info2:" |
-	       sed -n 's/.*\('"$info2"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt1=$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value "$info1" "$info1")
+	cnt2=$(ss -N $ns2 -inmHM | mptcp_lib_get_info_value "$info2" "$info2")
 	# 'ss' only display active connections and counters that are not 0.
 	[ -z "$cnt1" ] && cnt1=0
 	[ -z "$cnt2" ] && cnt2=0
@@ -2824,13 +2822,13 @@ verify_listener_events()
 		return
 	fi
 
-	type=$(grep "type:$e_type," $evt | sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
-	family=$(grep "type:$e_type," $evt | sed -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
-	sport=$(grep "type:$e_type," $evt | sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
+	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
+	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
 	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(grep "type:$e_type," $evt | sed -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
 	else
-		saddr=$(grep "type:$e_type," $evt | sed -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
+		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
 	fi
 
 	if [ $type ] && [ $type = $e_type ] &&
@@ -3225,8 +3223,7 @@ fastclose_tests()
 pedit_action_pkts()
 {
 	tc -n $ns2 -j -s action show action pedit index 100 | \
-		grep "packets" | \
-		sed 's/.*"packets":\([0-9]\+\),.*/\1/'
+		mptcp_lib_get_info_value \"packets\" packets
 }
 
 fail_tests()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 2b10f200de40..3cf31be5f655 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -208,6 +208,16 @@ mptcp_lib_result_print_all_tap() {
 	done
 }
 
+# get the value of keyword $1 in the line marked by keyword $2
+mptcp_lib_get_info_value() {
+	grep "${2}" | sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'
+}
+
+# $1: info name ; $2: evts_ns ; $3: event type
+mptcp_lib_evts_get_info() {
+	mptcp_lib_get_info_value "${1}" "^type:${3:-1}," < "${2}"
+}
+
 # $1: PID
 mptcp_lib_kill_wait() {
 	[ "${1}" -eq 0 ] && return 0
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 0e748068ee95..4c62114de063 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -238,14 +238,11 @@ make_connection()
 	local server_token
 	local server_serverside
 
-	client_token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
-	client_port=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
-	client_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
-				      "$client_evts")
-	server_token=$(grep "type:1," "$server_evts" |
-		       sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-	server_serverside=$(grep "type:1," "$server_evts" |
-			    sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q')
+	client_token=$(mptcp_lib_evts_get_info token "$client_evts")
+	client_port=$(mptcp_lib_evts_get_info sport "$client_evts")
+	client_serverside=$(mptcp_lib_evts_get_info server_side "$client_evts")
+	server_token=$(mptcp_lib_evts_get_info token "$server_evts")
+	server_serverside=$(mptcp_lib_evts_get_info server_side "$server_evts")
 
 	print_test "Established IP${is_v6} MPTCP Connection ns2 => ns1"
 	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
@@ -331,16 +328,16 @@ verify_announce_event()
 	local dport
 	local id
 
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
+	type=$(mptcp_lib_evts_get_info type "$evt" $e_type)
+	token=$(mptcp_lib_evts_get_info token "$evt" $e_type)
 	if [ "$e_af" = "v6" ]
 	then
-		addr=$(sed --unbuffered -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q' "$evt")
+		addr=$(mptcp_lib_evts_get_info daddr6 "$evt" $e_type)
 	else
-		addr=$(sed --unbuffered -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evt")
+		addr=$(mptcp_lib_evts_get_info daddr4 "$evt" $e_type)
 	fi
-	dport=$(sed --unbuffered -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	id=$(sed --unbuffered -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
+	dport=$(mptcp_lib_evts_get_info dport "$evt" $e_type)
+	id=$(mptcp_lib_evts_get_info rem_id "$evt" $e_type)
 
 	check_expected "type" "token" "addr" "dport" "id"
 }
@@ -358,7 +355,7 @@ test_announce()
 	   $client_addr_id dev ns2eth1 > /dev/null 2>&1
 
 	local type
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	print_test "ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token"
 	if [ "$type" = "" ]
 	then
@@ -437,9 +434,9 @@ verify_remove_event()
 	local token
 	local id
 
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	id=$(sed --unbuffered -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
+	type=$(mptcp_lib_evts_get_info type "$evt" $e_type)
+	token=$(mptcp_lib_evts_get_info token "$evt" $e_type)
+	id=$(mptcp_lib_evts_get_info rem_id "$evt" $e_type)
 
 	check_expected "type" "token" "id"
 }
@@ -457,7 +454,7 @@ test_remove()
 	   $client_addr_id > /dev/null 2>&1
 	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1, invalid token"
 	local type
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	if [ "$type" = "" ]
 	then
 		test_pass
@@ -470,7 +467,7 @@ test_remove()
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $invalid_id > /dev/null 2>&1
 	print_test "RM_ADDR id:${invalid_id} ns2 => ns1, invalid id"
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	if [ "$type" = "" ]
 	then
 		test_pass
@@ -574,19 +571,19 @@ verify_subflow_events()
 		fi
 	fi
 
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	family=$(sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	dport=$(sed --unbuffered -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	locid=$(sed --unbuffered -n 's/.*\(loc_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	remid=$(sed --unbuffered -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
+	type=$(mptcp_lib_evts_get_info type "$evt" $e_type)
+	token=$(mptcp_lib_evts_get_info token "$evt" $e_type)
+	family=$(mptcp_lib_evts_get_info family "$evt" $e_type)
+	dport=$(mptcp_lib_evts_get_info dport "$evt" $e_type)
+	locid=$(mptcp_lib_evts_get_info loc_id "$evt" $e_type)
+	remid=$(mptcp_lib_evts_get_info rem_id "$evt" $e_type)
 	if [ "$family" = "$AF_INET6" ]
 	then
-		saddr=$(sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q' "$evt")
-		daddr=$(sed --unbuffered -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q' "$evt")
+		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" $e_type)
+		daddr=$(mptcp_lib_evts_get_info daddr6 "$evt" $e_type)
 	else
-		saddr=$(sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q' "$evt")
-		daddr=$(sed --unbuffered -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evt")
+		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" $e_type)
+		daddr=$(mptcp_lib_evts_get_info daddr4 "$evt" $e_type)
 	fi
 
 	check_expected "type" "token" "daddr" "dport" "family" "saddr" "locid" "remid"
@@ -621,7 +618,7 @@ test_subflows()
 	mptcp_lib_kill_wait $listener_pid
 
 	local sport
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from server to client machine
 	:>"$server_evts"
@@ -659,7 +656,7 @@ test_subflows()
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW6 from server to client machine
 	:>"$server_evts"
@@ -698,7 +695,7 @@ test_subflows()
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from server to client machine
 	:>"$server_evts"
@@ -736,7 +733,7 @@ test_subflows()
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
@@ -775,7 +772,7 @@ test_subflows()
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW6 from client to server machine
 	:>"$client_evts"
@@ -812,7 +809,7 @@ test_subflows()
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
@@ -858,7 +855,7 @@ test_subflows_v4_v6_mix()
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
@@ -926,18 +923,13 @@ verify_listener_events()
 		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
 	fi
 
-	type=$(grep "type:$e_type," $evt |
-	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
-	family=$(grep "type:$e_type," $evt |
-		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
-	sport=$(grep "type:$e_type," $evt |
-		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	type=$(mptcp_lib_evts_get_info type $evt $e_type)
+	family=$(mptcp_lib_evts_get_info family $evt $e_type)
+	sport=$(mptcp_lib_evts_get_info sport $evt $e_type)
 	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(grep "type:$e_type," $evt |
-			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+		saddr=$(mptcp_lib_evts_get_info saddr6 $evt $e_type)
 	else
-		saddr=$(grep "type:$e_type," $evt |
-			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
+		saddr=$(mptcp_lib_evts_get_info saddr4 $evt $e_type)
 	fi
 
 	check_expected "type" "family" "saddr" "sport"
-- 
2.43.0


