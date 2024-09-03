Return-Path: <stable+bounces-72806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CFE969A10
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E735A284984
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772751B9841;
	Tue,  3 Sep 2024 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzhQe6Iw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE441B983E;
	Tue,  3 Sep 2024 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359040; cv=none; b=fFf8mqxGJKBeM9AtFFKVpypoXcK5KkJLawRToHl0FSM+Fu4+gkmIu1QuaDkBs720MEafw1rWKzIcM7bTdNP16WNgZvGNKnvptJJIWCeBD4Rdh+AQOldLeUAM/HoODGr4ehUpU4yx9aNGfgaLfVToKbLo915Es6WkVClCwbJEdIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359040; c=relaxed/simple;
	bh=RuBumBigVCVoi3VznTaZJkhBfsWaBHM7oEcGDAFpFfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwwEZEcbZgI1dsMLYbHDLvck+KkmFOXCGHpv0RMYBTlHm/fZHAr7jFXv/L+oQs80pRgHDTHIAiAePYPG6yurF3CnOvERAAIHAWIW2+d1Jg+fMaHCrT54vogkbp3kJo17kkxJZ1tebJjED+4JrIrV2Uz3pw5Lzbq1Q9s5+Soaelg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzhQe6Iw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4340BC4CEC8;
	Tue,  3 Sep 2024 10:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725359039;
	bh=RuBumBigVCVoi3VznTaZJkhBfsWaBHM7oEcGDAFpFfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tzhQe6IwB+cFlp7vaZKnEaZFoN4sxTCeGKsZsldCu10nsLqrs+TjYZW/PuyhJtR33
	 PCR6clXbH/iSC9vakbYgnlAwL1KgmKO3oyGnIdoDwirfmwy4NBsbZNGGykVZvh+WN5
	 669pZqRwwYDkO8BPdp2Pup3IyL3kfBpQBgKyLffKmX8sEtG4fzKD4a+BeeRPQZF8xX
	 T6oqb3xBfDSlSrqQvfr8IEb1FE1JyRn8kqBXe+CbmkVFsL5PhkHITXP/PcattlQu5v
	 lWvVBkV4NIarpQweA1281iGP2/KUvDz1zFHQ2aEHwK8HjjSxCoQZp6xjRGYte9ZCpr
	 2/q9djjJm5VQA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6.y 3/3] selftests: mptcp: join: check re-re-adding ID 0 signal
Date: Tue,  3 Sep 2024 12:23:51 +0200
Message-ID: <20240903102347.3384947-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083025-ruined-stupor-4967@gregkh>
References: <2024083025-ruined-stupor-4967@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3347; i=matttbe@kernel.org; h=from:subject; bh=RuBumBigVCVoi3VznTaZJkhBfsWaBHM7oEcGDAFpFfg=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1uOz5htbm2a46iJtawAaOGM2Gk4cmNXhxAUSy xEoy7qMFPuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtbjswAKCRD2t4JPQmmg c92wEADtpIHSUxl4FGEdgm7XtO831uJnM81oMI2tWvGg8PdxDgyL1U3bQyNhBxUgo00RnXBwwl0 8EYBSoPEpkZ//VQvlkhxOaMIWPy1fKlf3HBYPsRMlbv4cXwLGibxSQ7ieTBgxzE4b1sWlvo6l67 BTDscIT8vaJfbcUjBXZ9JXT4I0mf+dX7op9YGNFKYmRRkHjCpb4AfuMAOiVJ171If+92rGcd+ge rVEyoNwWRIghkiXXl1r47/wfWjqkTiAgFNikgo0cN8tKKedpZA9hG3tRGQetxkMYLuAzShV8LgR jSx9XdchZyIZYr660ewBvfS4ofxUfVAG9CALVED8uvJ4Obka/zpgQxsft6ubRjFyRf8UBI++nzD V4eVwN5SiT2lcMTLT1w0cEytLIprOewj7YEk3dScW41gVjXDjJuMNHNxJxQvlPjMk0vfqV0krp/ /p3ZMG1ifaA6JV+4iEjc+43Xko4NG8ULGpD1P5M6nxQU+jrXk/p4KQd/vu3mAGoifwG7h9InuAp daX/p1yI2pK16pNtGD8Z7UeUiLHA/cH2JA+/41gHofnrz1w6IzLHGzaGvbUoQfuuOybWAK+HzOY iHIYxwVpMUtB97mkbK4Z2qnszTGdpzwp5f6oYUqQKvUrWnQpsJIWYBxlf/M85hQKZ15MIokpAWT MQqlMDkCeQRDYBQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit f18fa2abf81099d822d842a107f8c9889c86043c upstream.

This test extends "delete re-add signal" to validate the previous
commit: when the 'signal' endpoint linked to the initial subflow (ID 0)
is re-added multiple times, it will re-send the ADD_ADDR with id 0. The
client should still be able to re-create this subflow, even if the
add_addr_accepted limit has been reached as this special address is not
considered as a new address.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 32 ++++++++++++-------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 52a028f0a3de..4efcbd2dea50 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3689,7 +3689,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
-		test_linkfail=4 speed=20 \
+		test_linkfail=4 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 
@@ -3718,7 +3718,17 @@ endpoint_tests()
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
 		wait_mpj $ns2
-		chk_subflow_nr "after re-add" 3
+		chk_subflow_nr "after re-add ID 0" 3
+		chk_mptcp_info subflows 3 subflows 3
+
+		pm_nl_del_endpoint $ns1 99 10.0.1.1
+		sleep 0.5
+		chk_subflow_nr "after re-delete ID 0" 2
+		chk_mptcp_info subflows 2 subflows 2
+
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 88 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "after re-re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
 		mptcp_lib_kill_wait $tests_pid
 
@@ -3728,19 +3738,19 @@ endpoint_tests()
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_ANNOUNCED 0
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_REMOVED 0
-		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
-		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 3
 
 		chk_evt_nr ns2 MPTCP_LIB_EVENT_CREATED 1
 		chk_evt_nr ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 5
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 3
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
-		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 6
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 4
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 3
 
-		chk_join_nr 4 4 4
-		chk_add_nr 5 5
-		chk_rm_nr 3 2 invert
+		chk_join_nr 5 5 5
+		chk_add_nr 6 6
+		chk_rm_nr 4 3 invert
 	fi
 
 	# flush and re-add
-- 
2.45.2


