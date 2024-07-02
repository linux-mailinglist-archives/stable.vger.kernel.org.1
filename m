Return-Path: <stable+bounces-56596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 332F6924527
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B6D1F2195A
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E232C1C2310;
	Tue,  2 Jul 2024 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S+3DLdPc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA771BBBD7;
	Tue,  2 Jul 2024 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940709; cv=none; b=UEkat33TljTkh/Msi2D93HJSgiSZwkeob5vk7W8Wr3PirdjQiw+9WJEllBwxlTKhiO7zUx1eKJGcsE2DY1fZgLz8fFMJMtAxVlfLeVIDae+z+33B0PscU2GC/o+88a3IeVKjE4S7Sn0QRg9avpKEo5Tck2rjO3Ri5vJj+TTf0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940709; c=relaxed/simple;
	bh=MYQZC8FUQ0gNsChEhE2PzOfrCQcsn3gr4M8mh3ATvkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4qfbJy5oOl6qVBy5LTKjqSBerNYsMBNjvSW9rCw6w6Oe/7myKR7TFL/f1jnyt4gCdVff2BLLYEOAJSTrjq0Q/0q8HBIlCayVNhhh8lDuZEJk1kZaKnnZuqJMCo4hH300qZq3qKVdGgD785KB12T8nrWgRVeQhIBu675jBNbfXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S+3DLdPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D58C116B1;
	Tue,  2 Jul 2024 17:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940709;
	bh=MYQZC8FUQ0gNsChEhE2PzOfrCQcsn3gr4M8mh3ATvkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+3DLdPcB07yzpgVHMIv9+Bn2Ezg15X8jMpvk/oRqF2Eb961tZwKkKrn8r74PxF0U
	 XU1hTvIieMJEwN7RVZU7QXmYxc1cHh1o0iCcUKlq0a1obzYuz8nMjB5CGUw0k1OqJq
	 y6JduuwzT+uduqjanV/2LqV4v/Q4hLj1Kn5UOMq0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 014/163] selftests: mptcp: userspace_pm: fixed subtest names
Date: Tue,  2 Jul 2024 19:02:08 +0200
Message-ID: <20240702170233.594555410@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
References: <20240702170233.048122282@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu Baerts (NGI0) <matttbe@kernel.org>

[ Upstream commit e874557fce1b6023efafd523aee0c347bf7f1694 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/net/mptcp/userspace_pm.sh       | 46 +++++++++++--------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 305a0f6716c38..4e58291550498 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -184,10 +184,12 @@ make_connection()
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
@@ -249,6 +251,7 @@ make_connection()
 		   [ "$server_serverside" = 1 ]
 	then
 		test_pass
+		print_title "Connection info: ${client_addr}:${client_port} -> ${connect_addr}:${app_port}"
 	else
 		test_fail "Expected tokens (c:${client_token} - s:${server_token}) and server (c:${client_serverside} - s:${server_serverside})"
 		mptcp_lib_result_print_all_tap
@@ -369,7 +372,7 @@ test_announce()
 	ip netns exec "$ns2"\
 	   ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id $client_addr_id dev\
 	   ns2eth1
-	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, reuse port"
+	print_test "ADD_ADDR id:client 10.0.2.2 (ns2) => ns1, reuse port"
 	sleep 0.5
 	verify_announce_event $server_evts $ANNOUNCED $server4_token "10.0.2.2" $client_addr_id \
 			      "$client4_port"
@@ -378,7 +381,7 @@ test_announce()
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl ann\
 	   dead:beef:2::2 token "$client6_token" id $client_addr_id dev ns2eth1
-	print_test "ADD_ADDR6 id:${client_addr_id} dead:beef:2::2 (ns2) => ns1, reuse port"
+	print_test "ADD_ADDR6 id:client dead:beef:2::2 (ns2) => ns1, reuse port"
 	sleep 0.5
 	verify_announce_event "$server_evts" "$ANNOUNCED" "$server6_token" "dead:beef:2::2"\
 			      "$client_addr_id" "$client6_port" "v6"
@@ -388,7 +391,7 @@ test_announce()
 	client_addr_id=$((client_addr_id+1))
 	ip netns exec "$ns2" ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id\
 	   $client_addr_id dev ns2eth1 port $new4_port
-	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, new port"
+	print_test "ADD_ADDR id:client+1 10.0.2.2 (ns2) => ns1, new port"
 	sleep 0.5
 	verify_announce_event "$server_evts" "$ANNOUNCED" "$server4_token" "10.0.2.2"\
 			      "$client_addr_id" "$new4_port"
@@ -399,7 +402,7 @@ test_announce()
 	# ADD_ADDR from the server to client machine reusing the subflow port
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
 	   $server_addr_id dev ns1eth2
-	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
+	print_test "ADD_ADDR id:server 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$app4_port"
@@ -408,7 +411,7 @@ test_announce()
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann dead:beef:2::1 token "$server6_token" id\
 	   $server_addr_id dev ns1eth2
-	print_test "ADD_ADDR6 id:${server_addr_id} dead:beef:2::1 (ns1) => ns2, reuse port"
+	print_test "ADD_ADDR6 id:server dead:beef:2::1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "dead:beef:2::1"\
 			      "$server_addr_id" "$app6_port" "v6"
@@ -418,7 +421,7 @@ test_announce()
 	server_addr_id=$((server_addr_id+1))
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
 	   $server_addr_id dev ns1eth2 port $new4_port
-	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, new port"
+	print_test "ADD_ADDR id:server+1 10.0.2.1 (ns1) => ns2, new port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$new4_port"
@@ -452,7 +455,7 @@ test_remove()
 	local invalid_token=$(( client4_token - 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token $invalid_token id\
 	   $client_addr_id > /dev/null 2>&1
-	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1, invalid token"
+	print_test "RM_ADDR id:client ns2 => ns1, invalid token"
 	local type
 	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	if [ "$type" = "" ]
@@ -466,7 +469,7 @@ test_remove()
 	local invalid_id=$(( client_addr_id + 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $invalid_id > /dev/null 2>&1
-	print_test "RM_ADDR id:${invalid_id} ns2 => ns1, invalid id"
+	print_test "RM_ADDR id:client+1 ns2 => ns1, invalid id"
 	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	if [ "$type" = "" ]
 	then
@@ -479,7 +482,7 @@ test_remove()
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $client_addr_id
-	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
+	print_test "RM_ADDR id:client ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
 
@@ -488,7 +491,7 @@ test_remove()
 	client_addr_id=$(( client_addr_id - 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $client_addr_id
-	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
+	print_test "RM_ADDR id:client-1 ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
 
@@ -496,7 +499,7 @@ test_remove()
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client6_token" id\
 	   $client_addr_id
-	print_test "RM_ADDR6 id:${client_addr_id} ns2 => ns1"
+	print_test "RM_ADDR6 id:client-1 ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server6_token" "$client_addr_id"
 
@@ -506,7 +509,7 @@ test_remove()
 	# RM_ADDR from the server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server4_token" id\
 	   $server_addr_id
-	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
+	print_test "RM_ADDR id:server ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
 
@@ -515,7 +518,7 @@ test_remove()
 	server_addr_id=$(( server_addr_id - 1 ))
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server4_token" id\
 	   $server_addr_id
-	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
+	print_test "RM_ADDR id:server-1 ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
 
@@ -523,7 +526,7 @@ test_remove()
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server6_token" id\
 	   $server_addr_id
-	print_test "RM_ADDR6 id:${server_addr_id} ns1 => ns2"
+	print_test "RM_ADDR6 id:server-1 ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client6_token" "$server_addr_id"
 }
@@ -551,8 +554,14 @@ verify_subflow_events()
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
@@ -838,7 +847,7 @@ test_subflows_v4_v6_mix()
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server6_token" id\
 	   $server_addr_id dev ns1eth2
-	print_test "ADD_ADDR4 id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
+	print_test "ADD_ADDR4 id:server 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "10.0.2.1"\
 			      "$server_addr_id" "$app6_port"
@@ -948,7 +957,7 @@ test_listener()
 	local listener_pid=$!
 
 	sleep 0.5
-	print_test "CREATE_LISTENER 10.0.2.2:$client4_port"
+	print_test "CREATE_LISTENER 10.0.2.2 (client port)"
 	verify_listener_events $client_evts $LISTENER_CREATED $AF_INET 10.0.2.2 $client4_port
 
 	# ADD_ADDR from client to server machine reusing the subflow port
@@ -965,13 +974,14 @@ test_listener()
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
-- 
2.43.0




