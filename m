Return-Path: <stable+bounces-86762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A399A35F1
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 08:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23471C213E3
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 06:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497FC2BAEF;
	Fri, 18 Oct 2024 06:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xPAQ5i9E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F13187FF4
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 06:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234055; cv=none; b=FTyX7aP5a1gmaiE5ULQ3rNUPoQ3trGjb/LQl3/sWHBnRbSomzZ/R6d5EE0BZQbcYviyR9B/OduYRcu3osUlUqBTni5ml4+27Q8orfz/6HWq17OjHUHb0JAQxh2AXRcUWZeqSxn3Hk5R9BhGSyMQ9NwAs9ju4+Bv1KZosrkWZ1UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234055; c=relaxed/simple;
	bh=nedYWzUpKAiLwRwthTouAdJuNOzn2yCAgtWl11x6t80=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FXIiTKSihjSc79kRcJ7WnP18LxkQ02XmTyYE3eDXYq/ToC9tuWdDfETW4nAUM6V80Y/SMyZJqOXZSk6vdh3kwY33xJ3NIFqVNjUzVQ9jVkETDMZu2CFJ6Q6prsKp2f6HxHBPSgLtw+rqcUpqY33oL/3iluN2oGn3b5vcp4B0I/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xPAQ5i9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C46C4CEC3;
	Fri, 18 Oct 2024 06:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729234054;
	bh=nedYWzUpKAiLwRwthTouAdJuNOzn2yCAgtWl11x6t80=;
	h=Subject:To:Cc:From:Date:From;
	b=xPAQ5i9E/+e8pAX22qrSQ4RMPYRdtSbkdyVxRUcjeiIshkOCCqO765lBMoMepOKmU
	 gTTTnwyZoWm/HJnZoV3PUhzdDC1rvgqs8vFqf1S/yj/koWkMcUQkDa7cIZKH4pGM6P
	 d82mXGV334GjC7Qfc31M17kBkL8Ed9HQRzj3iXnw=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: test for prohibited MPC to port-based" failed to apply to 6.1-stable tree
To: pabeni@redhat.com,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 18 Oct 2024 08:47:27 +0200
Message-ID: <2024101826-outshine-powdered-a548@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5afca7e996c42aed1b4a42d4712817601ba42aff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101826-outshine-powdered-a548@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5afca7e996c42aed1b4a42d4712817601ba42aff Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Mon, 14 Oct 2024 16:06:01 +0200
Subject: [PATCH] selftests: mptcp: join: test for prohibited MPC to port-based
 endp

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

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e8d0a01b4144..c07e2bd3a315 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -23,6 +23,7 @@ tmpfile=""
 cout=""
 err=""
 capout=""
+cappid=""
 ns1=""
 ns2=""
 iptables="iptables"
@@ -887,6 +888,44 @@ check_cestab()
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
+		capfile=$(printf "mp_join-%02u-%s.pcap" "$MPTCP_LIB_TEST_COUNTER" "$ns")
+
+		echo "Capturing traffic for test $MPTCP_LIB_TEST_COUNTER into $capfile"
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
+	echo "$((10000 + MPTCP_LIB_TEST_COUNTER - 1))"
+}
+
 do_transfer()
 {
 	local listener_ns="$1"
@@ -894,33 +933,17 @@ do_transfer()
 	local cl_proto="$3"
 	local srv_proto="$4"
 	local connect_addr="$5"
+	local port
 
-	local port=$((10000 + MPTCP_LIB_TEST_COUNTER - 1))
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
-		capfile=$(printf "mp_join-%02u-%s.pcap" "$MPTCP_LIB_TEST_COUNTER" "${listener_ns}")
-
-		echo "Capturing traffic for test $MPTCP_LIB_TEST_COUNTER into $capfile"
-		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuser -w $capfile > "$capout" 2>&1 &
-		cappid=$!
-
-		sleep 1
-	fi
+	cond_start_capture ${listener_ns}
 
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
 		nstat -n
@@ -1007,10 +1030,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	if $capture; then
-	    sleep 1
-	    kill $cappid
-	fi
+	cond_stop_capture
 
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
 		nstat | grep Tcp > /tmp/${listener_ns}.out
@@ -1026,7 +1046,6 @@ do_transfer()
 		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
 		cat /tmp/${connector_ns}.out
 
-		cat "$capout"
 		return 1
 	fi
 
@@ -1043,13 +1062,7 @@ do_transfer()
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
@@ -2873,6 +2886,32 @@ verify_listener_events()
 	fail_test
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
@@ -2963,6 +3002,22 @@ add_addr_ports_tests()
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


