Return-Path: <stable+bounces-55067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F13FF91549D
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81DEE1F24C41
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B32C142905;
	Mon, 24 Jun 2024 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k6vWLNfa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3AB3EA72
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247519; cv=none; b=Z5v89E1xuVcB3ks0+Hd4CnuFP5JNfWFMWrQice5IBwGS4Q+ML1D35mrke2rUGUzBjcrnvFqlQae+wncgY49gxJ5rsKDneWeESvvAj4gk2140ueAhH7XM8EJO7aI6jM7uVKIBpGuoE2KkcmevR1qyyxmbRTtcsM8GuOzPuPhAt2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247519; c=relaxed/simple;
	bh=f9XrUmmbZGHdJL+HCyxxlu1oBp8LuDNq5pOw7UxbdkE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VKQb9XO5CevxTMf5z7WXpIMS6p06/YV8w6lsiI2lQvcGZya+0F/JPYTzID1r0ySs99yR5hMWkPAy6bnaJJQ0+s8SRjgF5Fw1X8JAQZhSkSBjqZ66PqDZrPBY2VSEeAFQEYXSvJdaoutRW68n6KiNYRw0Uemyiivl4ORkAeBUXr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k6vWLNfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE5BC2BBFC;
	Mon, 24 Jun 2024 16:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719247519;
	bh=f9XrUmmbZGHdJL+HCyxxlu1oBp8LuDNq5pOw7UxbdkE=;
	h=Subject:To:Cc:From:Date:From;
	b=k6vWLNfaOFxDXnuewsb/AiiYU9b4QnWOoqFYbaOCr6pPsXPnOhH/e6qxMHa9rmhEZ
	 v1hAWH9RL4bwkj4Wh5Msjtf6qM/TSoVgeZThC3uulhYkYIhYZgKkLignzc72epbO6A
	 Inhg5aaPusZCHUCO9NxIaVR+pqDxQC9hk5G0iznU=
Subject: FAILED: patch "[PATCH] selftests: mptcp: userspace_pm: fixed subtest names" failed to apply to 6.6-stable tree
To: matttbe@kernel.org,horms@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 18:45:06 +0200
Message-ID: <2024062405-railway-unpack-e903@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e874557fce1b6023efafd523aee0c347bf7f1694
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062405-railway-unpack-e903@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

e874557fce1b ("selftests: mptcp: userspace_pm: fixed subtest names")
8ebb44196585 ("selftests: mptcp: print_test out of verify_listener_events")
2ef0d804c090 ("selftests: mptcp: userspace_pm: unique subtest names")
06848c0f341e ("selftests: mptcp: add evts_get_info helper")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e874557fce1b6023efafd523aee0c347bf7f1694 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Jun 2024 19:15:29 +0200
Subject: [PATCH] selftests: mptcp: userspace_pm: fixed subtest names

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

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 9e2981f2d7f5..9cb05978269d 100755
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


