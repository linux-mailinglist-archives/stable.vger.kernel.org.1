Return-Path: <stable+bounces-25928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6908702E7
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 14:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9F11F269F7
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 13:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2483F9FC;
	Mon,  4 Mar 2024 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qL5wxeBT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF713F9C2;
	Mon,  4 Mar 2024 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559549; cv=none; b=AY1LHQ5FYiM1xwUEMROz3zwrQQ290H8crMj6+a+zZPQGCKEl2HOQAUf3yO6xMiiuFt1DrOYqSsh0rpTrYLi+wy+hqtJiTdahki81X7TPVzEhYDUV/xMU0QRcMp2JxqHV85RFSqsMdJ16wDu6QTIaLVPFabIrsMPYCc9ViU4yKRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559549; c=relaxed/simple;
	bh=RNK1T5EBcTT0dJEI4o/0l2KMNXhZbkzGFu5Z658QZOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n65R8UYTZJBDG7YVNAgev0n37j0nApaIAiiJQ9kVS/UeOXPUnSgPp3Iqy6WGAGyHoq9Zlg027RBDEaLa6S1sYmq3FnxZcK2eQ8lWc7/m0GdqDez67KcV9CqjFMN9RNHxRCISzuGcLXLH/ZI/XLyJfuru6TD4qUmXmG1aPdiMyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qL5wxeBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29F4C433B1;
	Mon,  4 Mar 2024 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709559549;
	bh=RNK1T5EBcTT0dJEI4o/0l2KMNXhZbkzGFu5Z658QZOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qL5wxeBT4PbTN+Lmje/gAw8vitjcszybYdSd+vx6qhdBlb0X39oEPXXJm8eUqZUne
	 vwg6LqBdADLJyVh9+pUJn58yY0IRjSrfZluFV+xyM7EOKk/XFYS7aCyf9iwiIk7zjL
	 LkvB6Q8x1brCxplR7oeR3vAjjMYmIv+MyH2KzEmv6cNCFzTbrH0G9oeJmeQSWfLvEA
	 8hv9TkcJMiOGNJlWLwnHGytnssHpOnWHSDvM2yEG1e59acg2wjxQCFHFJkl4rh1PAk
	 SrNJ9LlgEexChhxLoQKejPa/9fhAn77RgUBl1wu0bF+/WwmmMzO5Y/BbqfBvNXOAaG
	 gmaUumdhwp0UQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.7.y 3/5] selftests: mptcp: update userspace pm test helpers
Date: Mon,  4 Mar 2024 14:38:31 +0100
Message-ID: <20240304133827.1989736-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024030420-swimsuit-antacid-a0dd@gregkh>
References: <2024030420-swimsuit-antacid-a0dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6079; i=matttbe@kernel.org; h=from:subject; bh=LwzpQpYQQVUgmzdhWlVborTdj8V0bI1EUq9c3HD6t+4=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5c7UNINK4694Fkg+k2XbPNP5E7+gx+rv/Y0qd VMvICAm3ZqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeXO1AAKCRD2t4JPQmmg c/VEEADg1NaR5eqA0sTKj70oeV1cSrSz31MSw4/qQwGsQe+z9ocppPz+h1w9E+AZYRr/iKldFu0 WrMnVFW2js9M9MGTIirzs3CE5DUNNIo/ONHagZdkRO2TiAwgmtIq8sxtzq6dC4WsdatRha/tRZG FZg6xoWTkY+r+4TKn5W/DgbSQD/2IofINziL0kSrJRDqxXidfjWIuFN7ObFzZZ440Lqi7c8g4sv hlnK4KeddWMcQ1EsfvT5BFXnTbvCFqeyg8lO8A3R89OngjqH/GxbdsrcuHXlilPXS1JZeaT0D+2 JMg3F+MbIJHJnDPDexyVPYd14zFPr/NtZtVM/izbMzIzfqwicBFQYukIyAZOUD4UlEbHkleKe7z ma+9PLXbeTllmApcfd2O9qMfFTaPfYq3GuLuV8EVG8xUeJ8tyr0PnRzF9M+ZaaQRvC/yRFhqn5n qHIJbn7hTZG4U6rdoinUElfkt02ktWEo5eoxKIHxYu8fkffoZX8hHcK3QE8Q1TJNzhI27hbrVwp caXzQlyLUMFT6xbfRg/It+Ei/1c2+IDfDI9lp2PXcQwdJoKZaoV4CONKcCL/+qE+I95uIMvei3I D0zwHOg2A5ThK5bkJSyVcW9W+1AEIIfbN/h9e8E03+UldJCmp3Mi5gQK8Y/yUeOc692Q56Io0ND w/i22N+OQcYOEzw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch adds a new argument namespace to userspace_pm_add_addr() and
userspace_pm_add_sf() to make these two helper more versatile.

Add two more versatile helpers for userspace pm remove subflow or address:
userspace_pm_rm_addr() and userspace_pm_rm_sf(). The original test helpers
userspace_pm_rm_sf_addr_ns1() and userspace_pm_rm_sf_addr_ns2() can be
replaced by these new helpers.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231128-send-net-next-2023107-v4-4-8d6b94150f6b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 757c828ce94905a2975873d5e90a376c701b2b90)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 98 +++++++++----------
 1 file changed, 48 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 90845b130a95..2a769cfb7f24 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2824,6 +2824,7 @@ backup_tests()
 	fi
 }
 
+SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
 LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
 LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
 
@@ -3284,75 +3285,70 @@ fail_tests()
 	fi
 }
 
+# $1: ns ; $2: addr ; $3: id
 userspace_pm_add_addr()
 {
-	local addr=$1
-	local id=$2
+	local evts=$evts_ns1
 	local tk
 
-	tk=$(grep "type:1," "$evts_ns1" |
-	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-	ip netns exec $ns1 ./pm_nl_ctl ann $addr token $tk id $id
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl ann $2 token $tk id $3
 	sleep 1
 }
 
-userspace_pm_rm_sf_addr_ns1()
+# $1: ns ; $2: id
+userspace_pm_rm_addr()
 {
-	local addr=$1
-	local id=$2
-	local tk sp da dp
-	local cnt_addr cnt_sf
+	local evts=$evts_ns1
+	local tk
+	local cnt
 
-	tk=$(grep "type:1," "$evts_ns1" |
-	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-	sp=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	da=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
-	dp=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
-	cnt_addr=$(rm_addr_count ${ns1})
-	cnt_sf=$(rm_sf_count ${ns1})
-	ip netns exec $ns1 ./pm_nl_ctl rem token $tk id $id
-	ip netns exec $ns1 ./pm_nl_ctl dsf lip "::ffff:$addr" \
-				lport $sp rip $da rport $dp token $tk
-	wait_rm_addr $ns1 "${cnt_addr}"
-	wait_rm_sf $ns1 "${cnt_sf}"
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	cnt=$(rm_addr_count ${1})
+	ip netns exec $1 ./pm_nl_ctl rem token $tk id $2
+	wait_rm_addr $1 "${cnt}"
 }
 
+# $1: ns ; $2: addr ; $3: id
 userspace_pm_add_sf()
 {
-	local addr=$1
-	local id=$2
+	local evts=$evts_ns1
 	local tk da dp
 
-	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	ip netns exec $ns2 ./pm_nl_ctl csf lip $addr lid $id \
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+	da=$(mptcp_lib_evts_get_info daddr4 "$evts")
+	dp=$(mptcp_lib_evts_get_info dport "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl csf lip $2 lid $3 \
 				rip $da rport $dp token $tk
 	sleep 1
 }
 
-userspace_pm_rm_sf_addr_ns2()
+# $1: ns ; $2: addr $3: event type
+userspace_pm_rm_sf()
 {
-	local addr=$1
-	local id=$2
+	local evts=$evts_ns1
+	local t=${3:-1}
+	local ip=4
 	local tk da dp sp
-	local cnt_addr cnt_sf
+	local cnt
 
-	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	sp=$(grep "type:10" "$evts_ns2" |
-	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	cnt_addr=$(rm_addr_count ${ns2})
-	cnt_sf=$(rm_sf_count ${ns2})
-	ip netns exec $ns2 ./pm_nl_ctl rem token $tk id $id
-	ip netns exec $ns2 ./pm_nl_ctl dsf lip $addr lport $sp \
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	if is_v6 $2; then ip=6; fi
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
+	dp=$(mptcp_lib_evts_get_info dport "$evts" $t)
+	sp=$(mptcp_lib_evts_get_info sport "$evts" $t)
+
+	cnt=$(rm_sf_count ${1})
+	ip netns exec $1 ./pm_nl_ctl dsf lip $2 lport $sp \
 				rip $da rport $dp token $tk
-	wait_rm_addr $ns2 "${cnt_addr}"
-	wait_rm_sf $ns2 "${cnt_sf}"
+	wait_rm_sf $1 "${cnt}"
 }
 
 userspace_tests()
@@ -3439,13 +3435,14 @@ userspace_tests()
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns1
-		userspace_pm_add_addr 10.0.2.1 10
+		userspace_pm_add_addr $ns1 10.0.2.1 10
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
+		userspace_pm_rm_addr $ns1 10
+		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
@@ -3462,11 +3459,12 @@ userspace_tests()
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns2
-		userspace_pm_add_sf 10.0.3.2 20
+		userspace_pm_add_sf $ns2 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
+		userspace_pm_rm_addr $ns2 20
+		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-- 
2.43.0


