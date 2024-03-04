Return-Path: <stable+bounces-25934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1AB87040D
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 15:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7C7283BA9
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3996C40BF0;
	Mon,  4 Mar 2024 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XF7+uGcJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBB63FE5F;
	Mon,  4 Mar 2024 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562324; cv=none; b=uKrnja9SsOW2rxM0zHyOIO+hadO7Mk3KR94TIZBxPuzl+d1ov7BBSjQhI2HLIHQRpiMAoEOXsdk6l/yLegA3wEy5xgDGSmrrDbbGEPDGFCiEDfUPjLATYhNYKtZu3LvKBpnkdwU+ZuQB558rBb++FcxncibK6nrosfgmLC++ng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562324; c=relaxed/simple;
	bh=xMw3Da9ktXvcnqzQCrGz6BxyQSTDMoHDNayxIyysmIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrOxmM69kOUtIniwNQoFWh+fkp4tmsAnU65wSjRf7W/6zcJ49S8GwPt7uKtiEHlpfEanYoEFDplkAFSduTYnSwFRjZudkbE+PlVHTt33m77eKmlETW4Xj+LMf6bX1Ta8YPUn/Xo0RGofDHmDamJFqFGMIBissTbXkdUNoGulHUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XF7+uGcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3B3C433F1;
	Mon,  4 Mar 2024 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709562323;
	bh=xMw3Da9ktXvcnqzQCrGz6BxyQSTDMoHDNayxIyysmIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XF7+uGcJxNTm1AqQ9gSQXpYMKLb4iF+Kzq8I0iWTW/cy34vH4EffjgwGxmwm7NXoM
	 DuPAidOqco4qHL4PwDkZQmRguW8orewdC/m6AzuR+dXns24eTLmbSdfs9GV1s0jZhE
	 i7f8oXoMe4LRCSG6de9v7XhJ65905YEX3GlyuUqonXjN6Cb2Bv3zLhuiPl8DyyS5vz
	 vsm+XOy/SnbB3t1GzItRGdzT+pxRnURiLODYPD2dlDyJhf5MWhVtc+DvHfJGzWIKv7
	 Rs/mwiZJUMcwk5m56Iff017RQzBQRS0wxQf4FdTprM8zMTBreoCl5c+a2Rttxb6TPg
	 +DFW24YlIlULA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 2/5] selftests: mptcp: add chk_subflows_total helper
Date: Mon,  4 Mar 2024 15:25:11 +0100
Message-ID: <20240304142508.2086803-9-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024030421-badly-bucket-6555@gregkh>
References: <2024030421-badly-bucket-6555@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3441; i=matttbe@kernel.org; h=from:subject; bh=kkxtrQLFZj6jDn7/fSntVJwrrje1VMzBq33szjfe2c8=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5dnElkEUqBU9RPzBOXugdFTTjvY27bz8BwaOm Q9IWZHOvrSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeXZxAAKCRD2t4JPQmmg c5QMD/4mBGZKg46Fk0AtU2I6Rvatt7XfSgYyy/LgqbMujlQhnFGNwSujic210cxkItl/JOHEPnz 23Hf0oGkxPk1K3noBV4gsU/jgBnTZNeYXWHx9ltcntzyaLevgxtWqkhLQOl3LaAmcqwStAg/frp xz3LO+dYLsKrR+XMpDoHtcYtDAn4woFILtY8V/Kr3HyOXe2gtjvAN68exXDoy11LyeYC8FdeWFF RsNCVXamtGIAP4yMg9lFZDD3jhiS2PqeNjtDufyDyInqAWCIQaxcezqvj+sH6N6uReEDnBHB8Un 61s9MCT5l+OQ64+YJGusOLMNH2XvdPjhLluWgsZYeMDOKSfRP0/U1MP1UYRCF0JwEm26WilsAT7 VrEyppTHhP9efnPmCCn5VwnJhjxT9Yb6W06rTRZojMpR6o/KihKyjUuqDbMqndZsUMGKFGEyRRQ 2dArdF05ViWfrssC8A6Tzz5VUnf9Foyo283q/ILYw+XkfdqNkN6unxg1J0iOdZtnVy2iljdCae5 1l/qAvGbvhzsn772i92VFhHe02rSVb7pOLQX2tH4qKgiNC8H7DGkEx+QYz6YxkW2gE9+IdchWgX LUjl2DJRCKzFG21Bd1ja9EQv5psRA8DJJ1ZRkZgmKPtJE8y8AWB1OQ92X5etrS2GnviIWk2nx8j +m3xphZCEnYUpyQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch adds a new helper chk_subflows_total(), in it use the newly
added counter mptcpi_subflows_total to get the "correct" amount of
subflows, including the initial one.

To be compatible with old 'ss' or kernel versions not supporting this
counter, get the total subflows by listing TCP connections that are
MPTCP subflows:

    ss -ti state state established state syn-sent state syn-recv |
        grep -c tcp-ulp-mptcp.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231128-send-net-next-2023107-v4-3-8d6b94150f6b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 80775412882e273b8ef62124fae861cde8e6fb3d)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 42 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 10299f056261..58f7be4d880f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1840,7 +1840,7 @@ chk_mptcp_info()
 	local cnt2
 	local dump_stats
 
-	print_check "mptcp_info ${info1:0:8}=$exp1:$exp2"
+	print_check "mptcp_info ${info1:0:15}=$exp1:$exp2"
 
 	cnt1=$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value "$info1" "$info1")
 	cnt2=$(ss -N $ns2 -inmHM | mptcp_lib_get_info_value "$info2" "$info2")
@@ -1861,6 +1861,42 @@ chk_mptcp_info()
 	fi
 }
 
+# $1: subflows in ns1 ; $2: subflows in ns2
+# number of all subflows, including the initial subflow.
+chk_subflows_total()
+{
+	local cnt1
+	local cnt2
+	local info="subflows_total"
+	local dump_stats
+
+	# if subflows_total counter is supported, use it:
+	if [ -n "$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value $info $info)" ]; then
+		chk_mptcp_info $info $1 $info $2
+		return
+	fi
+
+	print_check "$info $1:$2"
+
+	# if not, count the TCP connections that are in fact MPTCP subflows
+	cnt1=$(ss -N $ns1 -ti state established state syn-sent state syn-recv |
+	       grep -c tcp-ulp-mptcp)
+	cnt2=$(ss -N $ns2 -ti state established state syn-sent state syn-recv |
+	       grep -c tcp-ulp-mptcp)
+
+	if [ "$1" != "$cnt1" ] || [ "$2" != "$cnt2" ]; then
+		fail_test "got subflows $cnt1:$cnt2 expected $1:$2"
+		dump_stats=1
+	else
+		print_ok
+	fi
+
+	if [ "$dump_stats" = 1 ]; then
+		ss -N $ns1 -ti
+		ss -N $ns2 -ti
+	fi
+}
+
 chk_link_usage()
 {
 	local ns=$1
@@ -3404,10 +3440,12 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		mptcp_lib_kill_wait $tests_pid
 	fi
@@ -3424,9 +3462,11 @@ userspace_tests()
 		userspace_pm_add_sf 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
 		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		mptcp_lib_kill_wait $tests_pid
 	fi
-- 
2.43.0


