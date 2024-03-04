Return-Path: <stable+bounces-25927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F293E8702E6
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 14:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF4F1F269F1
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 13:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DCB3F8C7;
	Mon,  4 Mar 2024 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oluU56aF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60C03F9C2;
	Mon,  4 Mar 2024 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559547; cv=none; b=WAO7FnS+mTCiisa+hS/Ua1oYIosCZSW+gqM9mu1sNsIMlrKf4zJcxezFL1dU/WpsS7kgG/fk321lDQwfkGG2JQpdiiijLIzUvhiUHu1OT4nx2qtd5pUBih7dVKCa1Ql/f57BZMfB2L4bbfcyw85HTIhfOKHDU4G+U5vpN5/jERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559547; c=relaxed/simple;
	bh=rCFMUcrIQ9QGh+UYBPFwaV+lujT8EpYC6ry93W4qhLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pB2h2IwNuqJ/EwWcjBJRGzypyZUuMUfmdgkeyRcbzu7e1KTckihBya2g67YDxFVkoZskz/Wuc5kjz+Mi1HHR2uIGmvxT8YXOfQfkx/yEOwuMuSB+acr5eAARrXbGxeqkFSmvX0zAM1cbHe6zJEYzdpk49K8l3eHaWYPUTR++CUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oluU56aF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99965C433F1;
	Mon,  4 Mar 2024 13:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709559547;
	bh=rCFMUcrIQ9QGh+UYBPFwaV+lujT8EpYC6ry93W4qhLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oluU56aFEnRF9I+kF3G4JzHrag6Mw0hptvC3e+MYIue5iLdFemE80C/y5M/nUZRX3
	 kOMNPr5DkxsdCTtt6u9iBdq4qyfajpLDrTSFFTh60nZdwOgihMRguy+rnf8Ga/O3zB
	 FzMlqOZU+lnYwaAQ0KMFpoXK4IuRpimyx61lm73qiRhe/MUPlieJhOIQqzX+x5OkFq
	 Y0+lUem/+WSVgEZX48tPtbDhsqx8VeOWyrK6/v+heISCMJ8xtCKCavCbhJXa1BwzLC
	 y658I1+GO5evYIq2YpMNJt92YFW8LN410SIPUshrpQxhQRQoYA+9QClgmkeml9AN7D
	 ZTavbkhBAjTAw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.7.y 2/5] selftests: mptcp: add chk_subflows_total helper
Date: Mon,  4 Mar 2024 14:38:30 +0100
Message-ID: <20240304133827.1989736-9-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024030420-swimsuit-antacid-a0dd@gregkh>
References: <2024030420-swimsuit-antacid-a0dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3441; i=matttbe@kernel.org; h=from:subject; bh=hEr4TcMDJG16rTS3qy12nKjSUYv7knQsSKIOiErvZeY=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5c7U6xExNUsSV+Bok5q8lGVutsHLgEG71azoN TqBLkZxMH2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeXO1AAKCRD2t4JPQmmg c+JhD/9UZfIQF5GtYGEQLTxuDChnaD26f7CYGmKTG/tSvLbXfMTfNg4TbdZ3db2jtUIViVNd0ig XE7pehiAeycV7JzreeRP4ULyANHciqsjzYy7ac+c+mMOhDbfHIF+ztobcmRH+EW9yRxEiRNuIVx znyr14EvqxZJSqW+eEfCJEhwRqZoqCdpb5Qb5QGcQo7knFT2M63I1qsC+YM5GGs6Ximy6Mb9Wh3 SugyRJF8mHOHdg3NMzoc4gThGj83j98fnfcgHo3qdmvhTZcYAczO7NLaVBLoJYKb9qQWzBekrnW JByaHgW9dJgVronAPEphe+1wQ3M04LVujIZaEWSYRoYn1LyklTf22Drc2MyE2W24lMGOq/32Ukf tHu5XpopbMXC+4TwDHbHi/rlJTBh6qBmrwbjAc+4OpHbkXtLwRgtZ0PhrWkFFkOjHfNJRnYfMKP epq1MWUweA6tmDqwu5Bw+/l2wVpPhJLkUura80aF1YIc1CIkv95QbLzDq7+rBhZHCuQUP8csppL LnkSG6XhFzUb+WGEjwkpThTZTIeMI2z0D/6lOgawV4T5KuV+cktr8n9OCmlwQVMg5SuNqU/XbeK ElARRT9AK4ohMm+Lqsz4kgbG+M6O2FUFFysrZGN8uHVCBT6eOfwwvwvqvhMFzQlQ/24MlpWI9wW 9V2bsGAqpR4Jzjw==
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
index 7140a40042b2..90845b130a95 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1843,7 +1843,7 @@ chk_mptcp_info()
 	local cnt2
 	local dump_stats
 
-	print_check "mptcp_info ${info1:0:8}=$exp1:$exp2"
+	print_check "mptcp_info ${info1:0:15}=$exp1:$exp2"
 
 	cnt1=$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value "$info1" "$info1")
 	cnt2=$(ss -N $ns2 -inmHM | mptcp_lib_get_info_value "$info2" "$info2")
@@ -1864,6 +1864,42 @@ chk_mptcp_info()
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
@@ -3407,10 +3443,12 @@ userspace_tests()
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
@@ -3427,9 +3465,11 @@ userspace_tests()
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


