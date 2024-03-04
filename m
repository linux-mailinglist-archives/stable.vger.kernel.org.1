Return-Path: <stable+bounces-25937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8278E87040F
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 15:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA25284520
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 14:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E56481DA;
	Mon,  4 Mar 2024 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPAo/EWw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1863FE5F;
	Mon,  4 Mar 2024 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562330; cv=none; b=FPzpwL4Ibp5sYcP9cCYRObendbuSIpCwnpTdM6hiO+fTdmp8b6tRJwm7alNr6ePXD7ItWTTUhuedLWoij3cqlyZgMG4+XKPEppH2S+fPbHibOY3uZIadnSR5dwqxsz2FeqDyIIlxiJNGmmtGoBVsMvQIUGhV2fMheAnJK2JaMek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562330; c=relaxed/simple;
	bh=VUBlDU/d31EPX0NxCdY/p4hIZRJZhb2Rq335rbt48nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnUlhI5tiw+usALLxFOdplXbRG8RTyrXF7Gr9cwhVLH2SnirWJkQQhe36YUpXIK0dRRUfl2Z/mF2nHPSgub7M9L0+jzp/eS5fPHg8OPDe9nEpjAqCq/ObF8g1fTMxy6mVW4Ak72mlGUrZ9orwXqe7UCsX8rK8fE8ftwC239Jy2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPAo/EWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B03C43399;
	Mon,  4 Mar 2024 14:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709562330;
	bh=VUBlDU/d31EPX0NxCdY/p4hIZRJZhb2Rq335rbt48nE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPAo/EWwAXGuw/uFFEkVS8UmWlrX9BVLrDRGTgK/0sl/Pe5jl9ih4BBkezGv7RsBF
	 AusMUCdPMnNgGpLL8PwDp8FqnnTP+dMCDZqvuZkWNl5tFjpiGfyVoYokLPc7lbRRpb
	 gPB5rCE0OrpdfIJI5ZBOnuJivcwJxUioIPioJp6W3G/Fodhdb5aOmPYlQVah1i6Ax+
	 5qUevP5bu8dlYebTY7TEHVGCM43PeZEpPsyGjUmQ+9ytSVu7iB1CvET0Vg0041lCem
	 UPrHl4xGDI0qNsFB+4lNDTAhxsfEfQnvlztA2m32UEQ8GuU5k3q5afUtFSc+hUbETW
	 bZKKT71M+f5vQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 5/5] selftests: mptcp: rm subflow with v4/v4mapped addr
Date: Mon,  4 Mar 2024 15:25:14 +0100
Message-ID: <20240304142508.2086803-12-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024030421-badly-bucket-6555@gregkh>
References: <2024030421-badly-bucket-6555@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4018; i=matttbe@kernel.org; h=from:subject; bh=/jLgqkgNCWU+pjzW9v6fylGsryClNA19vjkzxBeTaiE=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5dnEzptEuSKZDqIb6W3jK3NDtPFKp9TIpO8dl +CUTo4E/56JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeXZxAAKCRD2t4JPQmmg c2yHEADd4ztsCPKWDR+jk+1gVUtftTFMCWp9jdQRbv+3rVgqhWZTmt4kpZW9LCXiqp6QxgksSIw Hp7XN7DXlTTLq3jS9jIDrPFBYq89pb1UzeDsVwUkBXG0F9o37ogwf6cZJe+lQdgh8p1hQoD7WN1 mwq5KLo+eV6FV66jM/qDZ2WajNm56dD45MCW+gbJigAvs3R0r34OZhQ4tCnyU1lIgo6jAGyNaEU Ql0PEEK5x0CP2w4s+9nfLuNUFRDwy0BiP35bUoBpkiEJYlGfoi3DVRkbyvl3G0dDeG9NfeXMwoQ wYX9cN4BdnDO6qtwY7rjsLpPbkm/00z/zMDLfRt9ZMGcMozmq7d2sjJ+D+vMPVRLiS5bO7qKaR9 lNLHrYUN2tt4pALjhsJ6QJrP8Qj65BCK9fZWfw2laVWLL85n29CbbAHcvnB+OwkflrmrpnJbQMN mBWlmogyvYEgOf66OVIMhiIUad3UCOL1mK1YxdNIWnAclyNYqz8Ot3xJwKY7cR2i8jtSi4Usn1V mdRNogTXKmTDV1TQQcuuRe1o2ElxMSJLBGvKwuZX4KPBDoI/ZVxms8+3Ed76YP9ZzEAwgDGhsrd hqZ7CIfhmmmG2hhFIfdNXdW8F3/DwybKkyopLqn03pm+JxFaur7b6OeK3lVZtfXDQovOhLisoOH NgZ1d+z7o899wYA==
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
index ef17e39abefa..34c342346967 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3325,16 +3325,17 @@ userspace_pm_rm_sf()
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
@@ -3421,20 +3422,23 @@ userspace_tests()
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


