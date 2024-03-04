Return-Path: <stable+bounces-25854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E4886FBE3
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 09:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA38F2826D6
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 08:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C34C2C4;
	Mon,  4 Mar 2024 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xCwy+3KP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931E818629
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541023; cv=none; b=revVeqRFqosmxMQ4Fag0QHuAh0f5EUSrm00bN8eYy66jANcOeZbobk6szXiMvOnfm7rDWSMMqajf3K/+Az8yeu1/+9GFQfQVkKMB0IQXyVLBoX76hVU9SFuTUEbxHPqLbZDaw4PK+don4Zbgy+XM1mN9a04V3E0K++EbYTbcCcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541023; c=relaxed/simple;
	bh=PzZc7bBog2wRHyTIPo6VFAHQtdLH95zh0/9y+wmR9VI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mOBpxViUnRBJWEVJsAYbU+YgBF5VzOYzeQ22qtHvk9aIvXR7ssdiMz05nLXOMZG0QMnbEzD7AdF9VA8w65iegoICWAFvhQHe7D40nWW9cT5X5fpPxNtDEcIJB+UZardeRLRad+K1eSbTe7CHkrtTt1O2zeIK878OQm2AernBVgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xCwy+3KP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9401C433F1;
	Mon,  4 Mar 2024 08:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709541023;
	bh=PzZc7bBog2wRHyTIPo6VFAHQtdLH95zh0/9y+wmR9VI=;
	h=Subject:To:Cc:From:Date:From;
	b=xCwy+3KPJR9TD6NCKGzgNSxfQT6Vq+/QI5Qjxmfv/Y3awB2rkVKlfh+NeiveGI0rN
	 A/TxzhVDSjAJR868dec98bNBs6nAhrnYRk3nGmWB+9GQ/KGTKs28DwNPMtpmUoebQU
	 0JcRoSk30sIYbBjmGdymK0gK7m04jlKt5NJ0mD1o=
Subject: FAILED: patch "[PATCH] selftests: mptcp: rm subflow with v4/v4mapped addr" failed to apply to 6.7-stable tree
To: tanggeliang@kylinos.cn,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 09:30:20 +0100
Message-ID: <2024030420-swimsuit-antacid-a0dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x 7092dbee23282b6fcf1313fc64e2b92649ee16e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024030420-swimsuit-antacid-a0dd@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

7092dbee2328 ("selftests: mptcp: rm subflow with v4/v4mapped addr")
b850f2c7dd85 ("selftests: mptcp: add mptcp_lib_is_v6")
bdbef0a6ff10 ("selftests: mptcp: add mptcp_lib_kill_wait")
757c828ce949 ("selftests: mptcp: update userspace pm test helpers")
80775412882e ("selftests: mptcp: add chk_subflows_total helper")
06848c0f341e ("selftests: mptcp: add evts_get_info helper")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7092dbee23282b6fcf1313fc64e2b92649ee16e8 Mon Sep 17 00:00:00 2001
From: Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 23 Feb 2024 17:14:12 +0100
Subject: [PATCH] selftests: mptcp: rm subflow with v4/v4mapped addr

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

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c07386e21e0a..e68b1bc2c2e4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3333,16 +3333,17 @@ userspace_pm_rm_sf()
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
@@ -3429,20 +3430,23 @@ userspace_tests()
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
index 3a2abae5993e..3777d66fc56d 100644
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


