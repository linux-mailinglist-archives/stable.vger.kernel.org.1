Return-Path: <stable+bounces-25930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6678702E9
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 14:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA049286A1D
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23E13E485;
	Mon,  4 Mar 2024 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LowgJOT1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2913DB9A;
	Mon,  4 Mar 2024 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559553; cv=none; b=nDoVGFcZf3VH35GTRaoZcOKUqYaTRxwpIUKU88DDR+GE4eRMiMET2x5y3mg5tvmM+UtOaKylMVe2wAiWhizx48iExNBbdNeEwwB92z3cbGBFX2YEt4ABAtD8P9Yf50kIv8P+SPOOXLGdBURk9V1ZELJcnLUWJJKeO6DkbI38rPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559553; c=relaxed/simple;
	bh=CwC9QxAIErrAtfaYiScfGf8mPejqh11llUCnGb/ko6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BugWCX7UkUr7gUiexzMV1TpPcV7Kro2bONQjyC92RAEVbTuj9Zxs5QmydIamQAZ+1wFcrfY4qkRt7jcxP1Cgdras6CAWPFeGXsSmpu8NAlIaCMBYAOhVSRFhASgRzUHJsjzeWh6MRBXOFno5C69+6WE0zITEhcHd+RclZV+M14o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LowgJOT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55DAC43394;
	Mon,  4 Mar 2024 13:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709559553;
	bh=CwC9QxAIErrAtfaYiScfGf8mPejqh11llUCnGb/ko6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LowgJOT1d4+pT222Ol1VyDKOnu0CX9AVAvLompLzkr0+8KB+xIgaRloSCx+24To6o
	 /DyggDogfKMz5jieh/4nZX+tGNRlPJjLEq8vxUS/wp2DtQf1NvenoiOaB0VtFgy3hb
	 tRQ1NO0lDdSSGUmuSvBpiyRKV3TOrlddKBu14zS4N/XqLno3bIvu1IwsIp5v1rejRJ
	 bd3YUUcUL+SX6Kypi3/dXIH8zqpqJC21vuPxe7F+oGijn3EdTRVjyGUFPMdDywI16K
	 S8kpivRKRO+2RjlqZB8kyLFIWUDjuEF2s1kEE9ICaJS2a5QprkMuHKmPD0Txng441i
	 vMxg+6cFwdK6g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.7.y 5/5] selftests: mptcp: rm subflow with v4/v4mapped addr
Date: Mon,  4 Mar 2024 14:38:33 +0100
Message-ID: <20240304133827.1989736-12-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024030420-swimsuit-antacid-a0dd@gregkh>
References: <2024030420-swimsuit-antacid-a0dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4018; i=matttbe@kernel.org; h=from:subject; bh=+YI5S+bg4Qqsk2cC/FpCWVSaR+F/PjuF/l9DB2ZTJys=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5c7UTHaUhSR3rZLmqpX0HmqitM0QPXH2658x6 kZbfwWapEuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeXO1AAKCRD2t4JPQmmg c8RXEADgmqUHFNG7Ol2c4x8/PbJpGCrYuPXwKl4djQlti99xRE4sNbZhh4i7NI5muALGGmS8WoH MqPlzTD9Vp6IToD1daSGOfm/ZJRT1ciWShs/A3+b7Zp44E7U6iUqLXwJolBPPkxXQp8ZDeJnPmf FrmWu4+Lx7ALUjSlhzo8m+cUDLSkNEF7k2p7FaL2emCZ3DdTK1M/Z2uomjFhCffOanijwajXopW AXvW2SZKMabYNHKhrEEUz2s4jKebZDyrFvVT/GR6qAeKW2fwCQEJkr7RKXaTu+WCCagr5w5GYUQ MppDQ8qb7ZwcgDG0IXjyZMs/SOaZoo8ILM0ZjrNb6XGF0S38+ZyWisIEsP1JCHf/Bu+lAEhItAp dmH5vmxHMJfDmvsNtc2iF2nzGqR1GDk6jw+OmtLMXv8/MyKcywV93y3NrFo8LD85pkN1hYk4CwT DQ9qb+XmpQWyl0Y4dqGZCFrzXtQqA3tNt5hQgQE4AkEXOfrUXf/BwkExP7ImYusf51/WK5sDwMy bQAaFRvfZzSzG/QRSbgugUOZCPaTBCy+oPw8V9XUUsEwmJ/ry7WiN0vPfL78An9QOAzCCV2alyH xLaqn10qu60CCkWzO9KYOkRvCxtA3rrUwZ+P11f60N/dBcr8pGE5L24H7Q/lJAYYbuDuftlceEn KrFn9To6XlTAfVQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now both a v4 address and a v4-mapped address are supported when
destroying a userspace pm subflow, this patch adds a second subflow
to "userspace pm add & remove address" test, and two subflows could
be removed two different ways, one with the v4mapped and one with v4.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/387
Fixes: 48d73f609dcc ("selftests: mptcp: update userspace pm addr tests")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240223-upstream-net-20240223-misc-fixes-v1-2-162e87e48497@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 7092dbee23282b6fcf1313fc64e2b92649ee16e8)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++--------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  4 +--
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1bc9e424194b..e6b778a9a937 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3328,16 +3328,17 @@ userspace_pm_rm_sf()
 {
 	local evts=$evts_ns1
 	local t=${3:-1}
-	local ip=4
+	local ip
 	local tk da dp sp
 	local cnt
 
 	[ "$1" == "$ns2" ] && evts=$evts_ns2
-	if mptcp_lib_is_v6 $2; then ip=6; fi
+	[ -n "$(mptcp_lib_evts_get_info "saddr4" "$evts" $t)" ] && ip=4
+	[ -n "$(mptcp_lib_evts_get_info "saddr6" "$evts" $t)" ] && ip=6
 	tk=$(mptcp_lib_evts_get_info token "$evts")
-	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
-	dp=$(mptcp_lib_evts_get_info dport "$evts" $t)
-	sp=$(mptcp_lib_evts_get_info sport "$evts" $t)
+	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t $2)
+	dp=$(mptcp_lib_evts_get_info dport "$evts" $t $2)
+	sp=$(mptcp_lib_evts_get_info sport "$evts" $t $2)
 
 	cnt=$(rm_sf_count ${1})
 	ip netns exec $1 ./pm_nl_ctl dsf lip $2 lport $sp \
@@ -3424,20 +3425,23 @@ userspace_tests()
 	if reset_with_events "userspace pm add & remove address" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
-		pm_nl_set_limits $ns2 1 1
+		pm_nl_set_limits $ns2 2 2
 		speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
-		chk_join_nr 1 1 1
-		chk_add_nr 1 1
-		chk_mptcp_info subflows 1 subflows 1
-		chk_subflows_total 2 2
-		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		userspace_pm_add_addr $ns1 10.0.3.1 20
+		chk_join_nr 2 2 2
+		chk_add_nr 2 2
+		chk_mptcp_info subflows 2 subflows 2
+		chk_subflows_total 3 3
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 		userspace_pm_rm_addr $ns1 10
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
-		chk_rm_nr 1 1 invert
+		userspace_pm_rm_addr $ns1 20
+		userspace_pm_rm_sf $ns1 10.0.3.1 $SUB_ESTABLISHED
+		chk_rm_nr 2 2 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index f7b16d0bb5e5..8939d5c135a0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -213,9 +213,9 @@ mptcp_lib_get_info_value() {
 	grep "${2}" | sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'
 }
 
-# $1: info name ; $2: evts_ns ; $3: event type
+# $1: info name ; $2: evts_ns ; [$3: event type; [$4: addr]]
 mptcp_lib_evts_get_info() {
-	mptcp_lib_get_info_value "${1}" "^type:${3:-1}," < "${2}"
+	grep "${4:-}" "${2}" | mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
 }
 
 # $1: PID
-- 
2.43.0


