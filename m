Return-Path: <stable+bounces-66754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4103E94F1C5
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85901F24E29
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B7F1862B4;
	Mon, 12 Aug 2024 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6sx8Tl6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1531474C3;
	Mon, 12 Aug 2024 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476665; cv=none; b=KLfrsn0Wm0TjHsvg1P5VAnC3VvLgjvWgjBghO2BvQ01AXEDQk+zkyjtPbQB4MHGPpVQS17h/yN/DdQdxIUYnaElhLoW5VVzC/srZ7JWFm1tC9TydgR8dYp24adABYGqwqK4nW0suiUEwtXvSt/Q1Nzj3n4abCICH+j/SQT2JlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476665; c=relaxed/simple;
	bh=G0z2nCV3MjIf4cIB+MgXXbHphIenIWAmacqUNvNvloY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbfMBvKrQTA/bVy7rRLQPudogNKDin/izr/Sg4wNIH08OseBANChamqMxZaTO0cjbEBllOTALPsMqM9lE3wRw/Qu+RBxdjimlh7MkeRcDnbmyMLoMCfb/2Vkk/l6uv8CF6VXf3hFUXWtSMLNO61wPtou1z/uejnPS1BsfoQ70LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6sx8Tl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0B9C4AF0F;
	Mon, 12 Aug 2024 15:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723476665;
	bh=G0z2nCV3MjIf4cIB+MgXXbHphIenIWAmacqUNvNvloY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6sx8Tl64mmDoMiNOiE/Qw7Xj9I+snkjmZRB51e/4bGHXa7gjHaSttaUsgWfGAUq2
	 sw8ojnEjXlSgqAYTds3iLwjFAupHzsIchq3ih+KYrJzHrtTVdo/d5e/uE/IaEqy8hx
	 9Qr6Q3TW2Zv8dsLTopmhlnNWGjVVoR81uDb25KJPB0f+L8C2iEt8mX0945riK2kFb1
	 eR9gVA35c+djDsruu6BDkVOrKvYuPlVfgQB1Q8B4BGOQ9MuW+UPAL87an1Fs/BB1fS
	 z0dMoF76OluWw8D5lbjBYPF3/6MrlVIKM91LUTNgGIN7BYfOi3nRK46NXc/Matvq1v
	 NUNOs0z1oly3g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 4/5] selftests: mptcp: join: ability to invert ADD_ADDR check
Date: Mon, 12 Aug 2024 17:30:55 +0200
Message-ID: <20240812153050.573404-11-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081244-uncertain-snarl-e4f6@gregkh>
References: <2024081244-uncertain-snarl-e4f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4614; i=matttbe@kernel.org; h=from:subject; bh=G0z2nCV3MjIf4cIB+MgXXbHphIenIWAmacqUNvNvloY=; b=kA0DAAgB9reCT0JpoHMByyZiAGa6KquhkQnXRiQfVI3pFcZfzXEUeKaSfqmwpn+TrNTjUk3+K YkCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJmuiqrAAoJEPa3gk9CaaBz9mEQALvT gobDnAW6Jzs/+4bOXHgyFS0oaA6iRazx1sjmi7axIG3WolIWpjuxeAxKzkA1jHNu+8VmmBYgG0P dA+aXHOHw4twu59r0amX9jhTcZmGlnakMV5Duy7/0TtADRL8jkTnaoBikPP4LWzJZ6tj613FNJ2 UDLeAaKbuqcPKADQPK1U+KBbo3skg4UzdE+66OK9BB/eY/LoAnBLTzfqp/nrtC8VAj/bKeGqwnT CVY7tVYCjXlaBY50bcdAeFwUMoIA4KX7a0O358PErFxvKBdhMf/m7bExxEVt7UTI4MnEH8Owr0u nkczX8+YHU3SaXbc5T7xr7dffD9xp/5Mf/AUOGvI/XoeToOOcRpxT0GVIyd6KrsOKSCMyEWDJIQ pydqiT3oemQtzF6eSRuWapHVmN1pt3/nqutoGvbQHQWoHOODb1Ydmflws0hVoIddagP9CVFJEIK p1wA9h4fDVVsEkyIkLRKhBpzGsyaGCIDCJtb0A1IFewAELMeDF/Nzst62aG0H7Fw9me1H9orQym HVen/Dh/QgbfMmYXQPpBkAIvCwboCHGXAXDv6hL3FXWB7wdyCxwDfQtLyMp8TriNym1UXh6qZjQ xCKNi1q6HtBNMZACPJQpLpGVnB3hItISGVJ9H8G51fSiSXlNXcvAQvsX9eGF+27Y0P93bZOFr0b olzZx
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit bec1f3b119ebc613d08dfbcdbaef01a79aa7de92 upstream.

In the following commit, the client will initiate the ADD_ADDR, instead
of the server. We need to way to verify the ADD_ADDR have been correctly
sent.

Note: the default expected counters for when the port number is given
are never changed by the caller, no need to accept them as parameter
then.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-6-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 40 ++++++++++++-------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d7973b1202d9..ede3661607ef 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1559,18 +1559,28 @@ chk_add_nr()
 	local add_nr=$1
 	local echo_nr=$2
 	local port_nr=${3:-0}
-	local syn_nr=${4:-$port_nr}
-	local syn_ack_nr=${5:-$port_nr}
-	local ack_nr=${6:-$port_nr}
-	local mis_syn_nr=${7:-0}
-	local mis_ack_nr=${8:-0}
+	local ns_invert=${4:-""}
+	local syn_nr=$port_nr
+	local syn_ack_nr=$port_nr
+	local ack_nr=$port_nr
+	local mis_syn_nr=0
+	local mis_ack_nr=0
+	local ns_tx=$ns1
+	local ns_rx=$ns2
+	local extra_msg=""
 	local count
 	local timeout
 
-	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
+	if [[ $ns_invert = "invert" ]]; then
+		ns_tx=$ns2
+		ns_rx=$ns1
+		extra_msg="invert"
+	fi
+
+	timeout=$(ip netns exec ${ns_tx} sysctl -n net.mptcp.add_addr_timeout)
 
 	print_check "add"
-	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtAddAddr")
+	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtAddAddr")
 	if [ -z "$count" ]; then
 		print_skip
 	# if the test configured a short timeout tolerate greater then expected
@@ -1582,7 +1592,7 @@ chk_add_nr()
 	fi
 
 	print_check "echo"
-	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtEchoAdd")
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtEchoAdd")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$echo_nr" ]; then
@@ -1593,7 +1603,7 @@ chk_add_nr()
 
 	if [ $port_nr -gt 0 ]; then
 		print_check "pt"
-		count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtPortAdd")
+		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtPortAdd")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$port_nr" ]; then
@@ -1603,7 +1613,7 @@ chk_add_nr()
 		fi
 
 		print_check "syn"
-		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinPortSynRx")
+		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$syn_nr" ]; then
@@ -1614,7 +1624,7 @@ chk_add_nr()
 		fi
 
 		print_check "synack"
-		count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinPortSynAckRx")
+		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPJoinPortSynAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$syn_ack_nr" ]; then
@@ -1625,7 +1635,7 @@ chk_add_nr()
 		fi
 
 		print_check "ack"
-		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinPortAckRx")
+		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$ack_nr" ]; then
@@ -1636,7 +1646,7 @@ chk_add_nr()
 		fi
 
 		print_check "syn"
-		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMismatchPortSynRx")
+		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$mis_syn_nr" ]; then
@@ -1647,7 +1657,7 @@ chk_add_nr()
 		fi
 
 		print_check "ack"
-		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMismatchPortAckRx")
+		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$mis_ack_nr" ]; then
@@ -1657,6 +1667,8 @@ chk_add_nr()
 			print_ok
 		fi
 	fi
+
+	print_info "$extra_msg"
 }
 
 chk_add_tx_nr()
-- 
2.45.2


