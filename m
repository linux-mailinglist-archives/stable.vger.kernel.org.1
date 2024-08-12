Return-Path: <stable+bounces-66733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C7F94F133
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8631C21FE1
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7BF183CD6;
	Mon, 12 Aug 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAc9rsea"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55805183CA5;
	Mon, 12 Aug 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474966; cv=none; b=lAFku5uhIet3vJGxhSlvYVXw6tNFS7c5MkQ1gljUMNo7hCMnJ5G9ySifxn2pvG2/UNqS23ofjsthx3OR2C6rZkFoJSnGi5EanRKS6Wa7gkuYSmDHGbQoBb1lZM+Es8rCylMedDpreC/35WGxOtZrc7F3kiI2+7HsLFNZ7oPSgL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474966; c=relaxed/simple;
	bh=6PshTR2lqHtb1XCT6Ya/zWI38tLeqez7DVwZDVlVSX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzbEC9/e7NIbggN4xQh2ZdvfWc9mpc6+HA4dl3I22zGBwcOJYWuCXOqgIXS1t4Pxf8dcD4YZ70TGcP/xwEkiHm6ylHqUh4gkzyGe+sMHi5pejxaGsVE6r7CKF+rdmRORrpHJ6jy9wN2x47lQlSWIEcdDY32fwEylol4EktXuoc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAc9rsea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A94C32782;
	Mon, 12 Aug 2024 15:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723474965;
	bh=6PshTR2lqHtb1XCT6Ya/zWI38tLeqez7DVwZDVlVSX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PAc9rseaaaULD9/jllCBbMhr1xVoKST6W7QT1jWGcYYdYfqC8mfMgxf9pdrne3B7D
	 dPzxbNcurfELyRFkXTQ19dJcR0CBB3+imgrbF9zYUFND3wHikstZ/ptkY0LsCsPpik
	 mSY4goCcFPSNZjdLBhdlRDvK4oS0UpUe/SEmfpjUKrX980l+Wh7dCwn5L4L3d1QlJD
	 la7L0zuJWISzVsbRr1Qd7AEwwm9w/V+vXooSMrBWpB23DIIBD3hY+zs0E59PGUglLI
	 UYB2lHMFdFZOzhy1SRmvo7BuRmogD7WsiZIxqiEVMS2QL5ciAPVZIm+D++c4cuZkTK
	 0ymswkIMT/DuA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.10.y 4/5] selftests: mptcp: join: ability to invert ADD_ADDR check
Date: Mon, 12 Aug 2024 17:02:18 +0200
Message-ID: <20240812150213.489098-11-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081244-smock-nearest-c09a@gregkh>
References: <2024081244-smock-nearest-c09a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4614; i=matttbe@kernel.org; h=from:subject; bh=6PshTR2lqHtb1XCT6Ya/zWI38tLeqez7DVwZDVlVSX4=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmuiP10UOI9+u8b/kMtDaziv0cQokOwmhOGUG8s 4fctZmX2GqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZroj9QAKCRD2t4JPQmmg c9hRD/0dRlnzbWQmSj8AI9tctwk9mEAY9AOOQ9LqRSHvXWuWCjfDnHXu4Qk6YAcOWyDd4woK/2N +RuPK6PeWQubI1nwma8zZeyitRj2NUJ5e3LZklvM3J8WhFdtnYY5ZfYI4OSfJ2G7nlzL2+Y8Emd XP0JCiNMMzhLq9tyKV/qgoIBkqGuVX+NgGLScDyOYbE6xQLGRvzTn45X3B4pami1D540m51DCnh ymeZWNCZbVDWt3SABgJsBFLgz88FjCFlYufkpJbj92HDSADzKt2G844NJ8ld4AZoE1KYM/2ll5U RlPNu6185iSOdohfleiRuqBwDq41+IKSbCz9InZoWQug/aP28pOhD5O/1oFubiYQ07gihRbzd6y v9AT2lprGUO03LazajIx05p07zarkCcajH6Mc2etBUQjamWwvmUW5iBIZv8ayNot7gdvTppdnXk RKin76/i/M+sJPQARUymrZiDsqYz4gQWZdaTO5pez0B2qJ9Jf6HV2GhZW8h2Uqzq8HdBu99N3p9 ZfDkRr8xkSitmvQIuxSD//k9Noaxm7TDsD0Mk4BaxD0jYOk8JgdBSOIQBha8Bt8WBozMKrHbaxt 5owJIT77HjYuztPrWRjSRswoXxDLAjO2A5Jv9EKIn6ZC+X0rtdS5JJe717dCeRn8HrVuTqV0F3N 0weqtMsmBZZFv8g==
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
index 7043984b7e74..8ab350059ce1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1415,18 +1415,28 @@ chk_add_nr()
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
@@ -1438,7 +1448,7 @@ chk_add_nr()
 	fi
 
 	print_check "echo"
-	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtEchoAdd")
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtEchoAdd")
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$echo_nr" ]; then
@@ -1449,7 +1459,7 @@ chk_add_nr()
 
 	if [ $port_nr -gt 0 ]; then
 		print_check "pt"
-		count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtPortAdd")
+		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtPortAdd")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$port_nr" ]; then
@@ -1459,7 +1469,7 @@ chk_add_nr()
 		fi
 
 		print_check "syn"
-		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinPortSynRx")
+		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$syn_nr" ]; then
@@ -1470,7 +1480,7 @@ chk_add_nr()
 		fi
 
 		print_check "synack"
-		count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinPortSynAckRx")
+		count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPJoinPortSynAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$syn_ack_nr" ]; then
@@ -1481,7 +1491,7 @@ chk_add_nr()
 		fi
 
 		print_check "ack"
-		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinPortAckRx")
+		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$ack_nr" ]; then
@@ -1492,7 +1502,7 @@ chk_add_nr()
 		fi
 
 		print_check "syn"
-		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMismatchPortSynRx")
+		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortSynRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$mis_syn_nr" ]; then
@@ -1503,7 +1513,7 @@ chk_add_nr()
 		fi
 
 		print_check "ack"
-		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMismatchPortAckRx")
+		count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMismatchPortAckRx")
 		if [ -z "$count" ]; then
 			print_skip
 		elif [ "$count" != "$mis_ack_nr" ]; then
@@ -1513,6 +1523,8 @@ chk_add_nr()
 			print_ok
 		fi
 	fi
+
+	print_info "$extra_msg"
 }
 
 chk_add_tx_nr()
-- 
2.45.2


