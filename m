Return-Path: <stable+bounces-73020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E1396B9E4
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A43284179
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49851D5CC6;
	Wed,  4 Sep 2024 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVz0Uixp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDCB1D54EC;
	Wed,  4 Sep 2024 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448363; cv=none; b=NUZZIWKb5suM5waVhYLLO/EIi8el+c2F8Jf02gZ2Dx7/tDGmBDCoYvMfXU3sCpyvz/LJH+msKHyoBpFCwycL7SFA9+HLru4zOb7d1ZGk7SFGJbxKH3EzHNFNOINSetGjK+U1cI9o3WHT8ceeVtrUIYalWmkTGG/8n0KHgRDuR3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448363; c=relaxed/simple;
	bh=tML1e/dZpRljoNIYpr4HHfPzkXVuPIy86VIXipYRi8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTv1sBevE/YVwwrcMQYq10Zg+pskAfDwGDK0PeemtaUzFFizDa4dZgHWWZ+Zvm0I8tF28P0sxd40TS5oIW+fCiGjjpdUEk9r/gONxtc3B3xgI/Kgfun9Tb8ddSy7ozzIae+GrEd5LhGQP+5fKqt0Mj1QJWcoCgbD8/VUapTseeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVz0Uixp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4944C4CEC6;
	Wed,  4 Sep 2024 11:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725448363;
	bh=tML1e/dZpRljoNIYpr4HHfPzkXVuPIy86VIXipYRi8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lVz0UixpqakHVD8fb97yutaQEFHeCeZLWhMsNwk2joe6G7I9kjOwNDu5+VdthtM10
	 uUzjG51ejOdW3sMBqATML6hoHGy5ymiJGGe9s8k6s3ldbSZCom+wpZ62KZIz3qtUBG
	 K3Kqjrcd6Npn90ZOPUmwBtwrm1NAfQgXNqqlVfEdBU5O2LzYwWg+EH9jKe2bDzz5nd
	 cUwOi6phfC+e6LhYRnTr6m+v0xTnkl8958KVrlF31IOyzXy7RRcRtP8iO4F03m5dMv
	 YgeOHGtltOiVKjQQK+PEtHX6j6y6aCiIiUg+iBWCgEc5hV84NuDfdwaJ5VRCJ7Xy1L
	 WU1bN96Uyi9/g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] selftests: mptcp: join: no extra msg if no counter
Date: Wed,  4 Sep 2024 13:12:34 +0200
Message-ID: <20240904111233.4094425-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083033-mounting-headsman-336e@gregkh>
References: <2024083033-mounting-headsman-336e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3776; i=matttbe@kernel.org; h=from:subject; bh=tML1e/dZpRljoNIYpr4HHfPzkXVuPIy86VIXipYRi8Y=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2ECh9iFTi5T4JuKZyEUEWegzOLZuVaiQlWNON vGgjADMySiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZthAoQAKCRD2t4JPQmmg c0x9EACukiQ26khbBsczbLmvv9J5kaKtZ/EpW0pR+DxM8TzBYTlOKFpEeVH1Rw9fMR3XPYC/L09 09MBdC2yDAH06s8XgbjkKDCMMMNcz1nVSVbCz7+N/J0NmXnVGmgPjNaRNP2SOnlrsCGsnPZg+7H eNL29K70R/Gl7S7yW7+V/ywOZf+5rHu0n5nPiEZaU3e349NZZ2u4xM5BuTMuxXjJuuU6hbkzJJM xkr3IS2MaX7h7/82Vmyf2kbwcfURjlKp1JwYGNWtWueAeBrm8NHMSg5DmNynqB3+wdnv+yF4KE1 nhAqqTFSXHmGLOvgaOABpU8CZV0VwUqHkparN4bD2PI7B7tPVtgr5hEzF8eNjm63NbUqXDX36fM IVGC6MdzMZqtFzMKd36a+f7DGbu31wT+3feHx5t0fBFr0UjJRIGqihtP2gBLkiOhBolj6ikO1Zu vqYMrOg5MGDP993F7XXLkNNoz36XqWm2OWC5w6x3k/eoDr3zHDnGzo3RuKrUtPtRiVKerHvFf7b HPqPYMOJQZ5Vv/yO6J4b4MqrCB87Eta6yit4od3dxvPNqR3x679P0NNK4PmhJTu5Dh1bAyxAQiQ Ga1K/cNTGGFAHxAHS0+dgqMKz9T4rmuqBAx1bKPQ18KU4JANemcs3/hlSEmQ4rD4Ia4UJlv8yMt sJ1KzAhkn7yuoiQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 76a2d8394cc183df872adf04bf636eaf42746449 upstream.

The checksum and fail counters might not be available. Then no need to
display an extra message with missing info.

While at it, fix the indentation around, which is wrong since the same
commit.

Fixes: 47867f0a7e83 ("selftests: mptcp: join: skip check if MIB counter not supported")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in mptcp_join.sh, because the context is different, but the
  exact same fix can still be applied on the modified lines: adding
  '[ -n "$count" ]', and fixing the indentation. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ea1c7992336d..bed980b04624 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1252,13 +1252,13 @@ chk_csum_nr()
 
 	printf "%-${nr_blank}s %s" " " "sum"
 	count=$(get_counter ${ns1} "MPTcpExtDataCsumErr")
-	if [ "$count" != "$csum_ns1" ]; then
+	if [ -n "$count" ] && [ "$count" != "$csum_ns1" ]; then
 		extra_msg="$extra_msg ns1=$count"
 	fi
 	if [ -z "$count" ]; then
 		echo -n "[skip]"
 	elif { [ "$count" != $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 0 ]; } ||
-	   { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; then
+	     { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
 		fail_test
 		dump_stats=1
@@ -1267,13 +1267,13 @@ chk_csum_nr()
 	fi
 	echo -n " - csum  "
 	count=$(get_counter ${ns2} "MPTcpExtDataCsumErr")
-	if [ "$count" != "$csum_ns2" ]; then
+	if [ -n "$count" ] && [ "$count" != "$csum_ns2" ]; then
 		extra_msg="$extra_msg ns2=$count"
 	fi
 	if [ -z "$count" ]; then
 		echo -n "[skip]"
 	elif { [ "$count" != $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 0 ]; } ||
-	   { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; then
+	     { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		fail_test
 		dump_stats=1
@@ -1315,13 +1315,13 @@ chk_fail_nr()
 
 	printf "%-${nr_blank}s %s" " " "ftx"
 	count=$(get_counter ${ns_tx} "MPTcpExtMPFailTx")
-	if [ "$count" != "$fail_tx" ]; then
+	if [ -n "$count" ] && [ "$count" != "$fail_tx" ]; then
 		extra_msg="$extra_msg,tx=$count"
 	fi
 	if [ -z "$count" ]; then
 		echo -n "[skip]"
 	elif { [ "$count" != "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
-	   { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
+	     { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
 		fail_test
 		dump_stats=1
@@ -1331,13 +1331,13 @@ chk_fail_nr()
 
 	echo -n " - failrx"
 	count=$(get_counter ${ns_rx} "MPTcpExtMPFailRx")
-	if [ "$count" != "$fail_rx" ]; then
+	if [ -n "$count" ] && [ "$count" != "$fail_rx" ]; then
 		extra_msg="$extra_msg,rx=$count"
 	fi
 	if [ -z "$count" ]; then
 		echo -n "[skip]"
 	elif { [ "$count" != "$fail_rx" ] && [ $allow_rx_lost -eq 0 ]; } ||
-	   { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
+	     { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
 		fail_test
 		dump_stats=1
-- 
2.45.2


