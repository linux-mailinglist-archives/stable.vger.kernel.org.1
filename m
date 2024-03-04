Return-Path: <stable+bounces-25935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D8487040E
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 15:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E786283AB1
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 14:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B575641238;
	Mon,  4 Mar 2024 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFxVMGT2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E3C3FE5F;
	Mon,  4 Mar 2024 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562327; cv=none; b=QgWk+ryF2jvEgaMLzVJdx4LOjh2EkliZQtNxRnYRRvysDeHLF2Pq1NE4NZubOVvyEojdCVA8MdafAlcUfSj2ysZHxdnnwoHQ1qfkBeXaXq+nHDJrREIb/gUXtbYkbvqRCl9DWRuLhenT/5wUyMLi/d2T3R7MAbbUcknAIwQdwro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562327; c=relaxed/simple;
	bh=DID7IBjFEJ30+VxhNl+o3s9z5IueQMrb2JLNBjAT+Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMkSXmo4zftGvAQJ9ElgBDI5Cy20cXn9Xv48M21wdbgOkrjpIyNPmuD3C1oNmizDaj37Rc3jKGheh0P0w87CcVE7M8ZSUPjTLPfenIF45qNVnvdRbFRdPPwDGZ0r7AYeYJcaZhBn2ZAJzVxjrmQePE+ODPHSa1HNtj87SLkX9No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFxVMGT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4978FC433A6;
	Mon,  4 Mar 2024 14:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709562326;
	bh=DID7IBjFEJ30+VxhNl+o3s9z5IueQMrb2JLNBjAT+Qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFxVMGT2EisKptPBxYg41gXkTbUmZveHNmuYYmKcuR/LsxdE+byL3wVh6D+fUkwdr
	 m9FMo/5gaLbSsKgQYqm2Fu0zkGlSFlSQ0iUqHIAYo/F+3FP6hzQJ2ytGTu42lUk2jS
	 jU4dYADaPXadiWix+S9g0utWp/WFbu+84VC1tTNfXIB0H9IjbW5SbDUwNuxI2tF16y
	 NB54F1q0pS7PIUiMbh9Hwq7olj/46LiL+3nR3BfFTAIn3K1pgegST1Ou2eXKSy9/3C
	 DPzrwgLszBFelxmk0psyzxtoiL+br6cs7gQri7t/+MUM/g9lJaRZmoxc+prtVoAJQH
	 g/LcaTZw7o9Jg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 3/5] selftests: mptcp: update userspace pm test helpers
Date: Mon,  4 Mar 2024 15:25:12 +0100
Message-ID: <20240304142508.2086803-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024030421-badly-bucket-6555@gregkh>
References: <2024030421-badly-bucket-6555@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6079; i=matttbe@kernel.org; h=from:subject; bh=3RPdwpBfny/+m4yxtu9OzcXma4pN/654VUcVerRRXfc=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5dnEz7pl7SnoSKc5oQPIs2eeGgtBv2Foh48dn 54r3MwYRDyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeXZxAAKCRD2t4JPQmmg c/bSEACmQcDLsT1vhXGunx2/sFfANwNwPTKNG6e68c4SXcMqtLI07KCxuWJ3OOidCZaTMkUib2+ 9tKxC56FsbzwS3sJ/AS5AhA+HJ9QIkxaWsHAvfw5ZWtG9kQ9EtveMozrV0lH4qMThtSzEM7s97+ 2oGRL3g6ocVt8Rxlh2d7kWDMEVt4gMDBiXRAMZ7ZVexKvuSItsORDp97B2/5dKcBsRpGOw3+VGM bsWKFBR6wlMVT+EYgArEN9LqgaWWWG+Twe6omJ2rXz1yqsV5AyTXImoTQ/QYAcJmv87lWfK52w5 8fsm8Yqn8cAXKVJrrzUeIq1RXsdtSk3SnNQLCCQfsxTKAR6z6Wxb1hESgYK/xkxxi93TwBTI1NG 2RNw7/qGHYe9wwPRT/cfP74fwiEcysl0xo8q4MyEKsvbLLWgmOc+qAsQOmGNYQKcWRwk3OL5Dne LZ+soLBYtslWSePeCJu4JwpxIIBSgM6eYK48eue3V792oT5xS7hVaC4jiu9ucauPFImCdm6f1hr Gt9l10kCsgOSwy4+f/EAI2P/jw05Uhxzk0XBWxAhAbvAUaRm3W2z63+hPvxpEUFRbCSqfb46997 MPooOuhvCOKdodaEqi9nPx4WdpQX9r58ZVcWoJ0pbAaLOZzJc7DDuRZuZQuPLtBCOllnT9b4LoO h40LIJ6ZYC+us0A==
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
index 58f7be4d880f..7c560ced6ce4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2821,6 +2821,7 @@ backup_tests()
 	fi
 }
 
+SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
 LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
 LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
 
@@ -3281,75 +3282,70 @@ fail_tests()
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
@@ -3436,13 +3432,14 @@ userspace_tests()
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
@@ -3459,11 +3456,12 @@ userspace_tests()
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


