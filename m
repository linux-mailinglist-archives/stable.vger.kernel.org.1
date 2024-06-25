Return-Path: <stable+bounces-55385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4473791635B
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7DB28AC1A
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9836E1487E9;
	Tue, 25 Jun 2024 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OgLEw54W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574D81465A8;
	Tue, 25 Jun 2024 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308748; cv=none; b=sToqFzwvDYlcWkW3yRZxvEeVMhHn3wJ5JNKKIdFOz/FZ96l/SFz3rA7hjh1J2UX1JwxBD9wChjv4gmS1gD6+Ilqb4t0hT+G7J4ta+ulDt3ok8uStkSjMDnfulVjHw8IyxxGrsoQI0oDSTx6pJnmPeipv8+evO9XaGFvxHxm0fn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308748; c=relaxed/simple;
	bh=EsQ4GjJjDFl0xUBK1xHZqZHkYE/4zKwtnUCSI6Y4s0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTCILofSctwN+IlnwfXvfBZP8FjBZEm/E1PZ+IWP9ESN/nNKalHjvKQ37w1I3Xzvy1tAdf8R0+3smTeF8do/I6R18uH+dOBH+BPMUU+a+tt14yamUWJlDkFo4RGo3aifGIJpaJjc/s5KQGof8c6GGl0AE4OQq3MYvvs3z+NmAO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OgLEw54W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD46BC32781;
	Tue, 25 Jun 2024 09:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719308748;
	bh=EsQ4GjJjDFl0xUBK1xHZqZHkYE/4zKwtnUCSI6Y4s0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OgLEw54W5uOiaaPLCAxrce/h6qoSEAyPrtNUs+vCEgdCQVNzdpmuvDwluIhmtD7xR
	 Ki8Je9Z4DPSSh9ZAm6D3xFb2exZYxVWZH/YxzyuTDxj+gvnPB02EIAA2Ouwd0nnkDq
	 8wjgeJ6G2CtD9W4CsbP2vZuIqNunDrBToQzj+I0Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.9 225/250] selftests: mptcp: userspace_pm: fixed subtest names
Date: Tue, 25 Jun 2024 11:33:03 +0200
Message-ID: <20240625085556.688891647@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
References: <20240625085548.033507125@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu Baerts (NGI0) <matttbe@kernel.org>

commit e874557fce1b6023efafd523aee0c347bf7f1694 upstream.

It is important to have fixed (sub)test names in TAP, because these
names are used to identify them. If they are not fixed, tracking cannot
be done.

Some subtests from the userspace_pm selftest were using random numbers
in their names: the client and server address IDs from $RANDOM, and the
client port number randomly picked by the kernel when creating the
connection. These values have been replaced by 'client' and 'server'
words: that's even more helpful than showing random numbers. Note that
the addresses IDs are incremented and decremented in the test: +1 or -1
are then displayed in these cases.

Not to loose info that can be useful for debugging in case of issues,
these random numbers are now displayed at the beginning of the test.

Fixes: f589234e1af0 ("selftests: mptcp: userspace_pm: format subtests results in TAP")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240614-upstream-net-20240614-selftests-mptcp-uspace-pm-fixed-test-names-v1-1-460ad3edb429@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh |   46 +++++++++++++---------
 1 file changed, 28 insertions(+), 18 deletions(-)

--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -160,10 +160,12 @@ make_connection()
 	local is_v6=$1
 	local app_port=$app4_port
 	local connect_addr="10.0.1.1"
+	local client_addr="10.0.1.2"
 	local listen_addr="0.0.0.0"
 	if [ "$is_v6" = "v6" ]
 	then
 		connect_addr="dead:beef:1::1"
+		client_addr="dead:beef:1::2"
 		listen_addr="::"
 		app_port=$app6_port
 	else
@@ -206,6 +208,7 @@ make_connection()
 		   [ "$server_serverside" = 1 ]
 	then
 		test_pass
+		print_title "Connection info: ${client_addr}:${client_port} -> ${connect_addr}:${app_port}"
 	else
 		test_fail "Expected tokens (c:${client_token} - s:${server_token}) and server (c:${client_serverside} - s:${server_serverside})"
 		mptcp_lib_result_print_all_tap
@@ -297,7 +300,7 @@ test_announce()
 	ip netns exec "$ns2"\
 	   ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id $client_addr_id dev\
 	   ns2eth1
-	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, reuse port"
+	print_test "ADD_ADDR id:client 10.0.2.2 (ns2) => ns1, reuse port"
 	sleep 0.5
 	verify_announce_event $server_evts $ANNOUNCED $server4_token "10.0.2.2" $client_addr_id \
 			      "$client4_port"
@@ -306,7 +309,7 @@ test_announce()
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl ann\
 	   dead:beef:2::2 token "$client6_token" id $client_addr_id dev ns2eth1
-	print_test "ADD_ADDR6 id:${client_addr_id} dead:beef:2::2 (ns2) => ns1, reuse port"
+	print_test "ADD_ADDR6 id:client dead:beef:2::2 (ns2) => ns1, reuse port"
 	sleep 0.5
 	verify_announce_event "$server_evts" "$ANNOUNCED" "$server6_token" "dead:beef:2::2"\
 			      "$client_addr_id" "$client6_port" "v6"
@@ -316,7 +319,7 @@ test_announce()
 	client_addr_id=$((client_addr_id+1))
 	ip netns exec "$ns2" ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id\
 	   $client_addr_id dev ns2eth1 port $new4_port
-	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, new port"
+	print_test "ADD_ADDR id:client+1 10.0.2.2 (ns2) => ns1, new port"
 	sleep 0.5
 	verify_announce_event "$server_evts" "$ANNOUNCED" "$server4_token" "10.0.2.2"\
 			      "$client_addr_id" "$new4_port"
@@ -327,7 +330,7 @@ test_announce()
 	# ADD_ADDR from the server to client machine reusing the subflow port
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
 	   $server_addr_id dev ns1eth2
-	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
+	print_test "ADD_ADDR id:server 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$app4_port"
@@ -336,7 +339,7 @@ test_announce()
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann dead:beef:2::1 token "$server6_token" id\
 	   $server_addr_id dev ns1eth2
-	print_test "ADD_ADDR6 id:${server_addr_id} dead:beef:2::1 (ns1) => ns2, reuse port"
+	print_test "ADD_ADDR6 id:server dead:beef:2::1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "dead:beef:2::1"\
 			      "$server_addr_id" "$app6_port" "v6"
@@ -346,7 +349,7 @@ test_announce()
 	server_addr_id=$((server_addr_id+1))
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
 	   $server_addr_id dev ns1eth2 port $new4_port
-	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, new port"
+	print_test "ADD_ADDR id:server+1 10.0.2.1 (ns1) => ns2, new port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$new4_port"
@@ -380,7 +383,7 @@ test_remove()
 	local invalid_token=$(( client4_token - 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token $invalid_token id\
 	   $client_addr_id > /dev/null 2>&1
-	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1, invalid token"
+	print_test "RM_ADDR id:client ns2 => ns1, invalid token"
 	local type
 	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	if [ "$type" = "" ]
@@ -394,7 +397,7 @@ test_remove()
 	local invalid_id=$(( client_addr_id + 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $invalid_id > /dev/null 2>&1
-	print_test "RM_ADDR id:${invalid_id} ns2 => ns1, invalid id"
+	print_test "RM_ADDR id:client+1 ns2 => ns1, invalid id"
 	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	if [ "$type" = "" ]
 	then
@@ -407,7 +410,7 @@ test_remove()
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $client_addr_id
-	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
+	print_test "RM_ADDR id:client ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
 
@@ -416,7 +419,7 @@ test_remove()
 	client_addr_id=$(( client_addr_id - 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $client_addr_id
-	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
+	print_test "RM_ADDR id:client-1 ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
 
@@ -424,7 +427,7 @@ test_remove()
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client6_token" id\
 	   $client_addr_id
-	print_test "RM_ADDR6 id:${client_addr_id} ns2 => ns1"
+	print_test "RM_ADDR6 id:client-1 ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server6_token" "$client_addr_id"
 
@@ -434,7 +437,7 @@ test_remove()
 	# RM_ADDR from the server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server4_token" id\
 	   $server_addr_id
-	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
+	print_test "RM_ADDR id:server ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
 
@@ -443,7 +446,7 @@ test_remove()
 	server_addr_id=$(( server_addr_id - 1 ))
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server4_token" id\
 	   $server_addr_id
-	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
+	print_test "RM_ADDR id:server-1 ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
 
@@ -451,7 +454,7 @@ test_remove()
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server6_token" id\
 	   $server_addr_id
-	print_test "RM_ADDR6 id:${server_addr_id} ns1 => ns2"
+	print_test "RM_ADDR6 id:server-1 ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client6_token" "$server_addr_id"
 }
@@ -479,8 +482,14 @@ verify_subflow_events()
 	local locid
 	local remid
 	local info
+	local e_dport_txt
 
-	info="${e_saddr} (${e_from}) => ${e_daddr}:${e_dport} (${e_to})"
+	# only display the fixed ports
+	if [ "${e_dport}" -ge "${app4_port}" ] && [ "${e_dport}" -le "${app6_port}" ]; then
+		e_dport_txt=":${e_dport}"
+	fi
+
+	info="${e_saddr} (${e_from}) => ${e_daddr}${e_dport_txt} (${e_to})"
 
 	if [ "$e_type" = "$SUB_ESTABLISHED" ]
 	then
@@ -766,7 +775,7 @@ test_subflows_v4_v6_mix()
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server6_token" id\
 	   $server_addr_id dev ns1eth2
-	print_test "ADD_ADDR4 id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
+	print_test "ADD_ADDR4 id:server 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "10.0.2.1"\
 			      "$server_addr_id" "$app6_port"
@@ -861,7 +870,7 @@ test_listener()
 	local listener_pid=$!
 
 	sleep 0.5
-	print_test "CREATE_LISTENER 10.0.2.2:$client4_port"
+	print_test "CREATE_LISTENER 10.0.2.2 (client port)"
 	verify_listener_events $client_evts $LISTENER_CREATED $AF_INET 10.0.2.2 $client4_port
 
 	# ADD_ADDR from client to server machine reusing the subflow port
@@ -878,13 +887,14 @@ test_listener()
 	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
-	print_test "CLOSE_LISTENER 10.0.2.2:$client4_port"
+	print_test "CLOSE_LISTENER 10.0.2.2 (client port)"
 	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
 }
 
 print_title "Make connections"
 make_connection
 make_connection "v6"
+print_title "Will be using address IDs ${client_addr_id} (client) and ${server_addr_id} (server)"
 
 test_announce
 test_remove



