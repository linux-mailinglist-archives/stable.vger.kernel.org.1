Return-Path: <stable+bounces-72744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A24D968CD2
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 19:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17900B21B44
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 17:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B4A1AB6E8;
	Mon,  2 Sep 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6lZDSqh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E91183CBB;
	Mon,  2 Sep 2024 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725297936; cv=none; b=YfGV3m/fZyxGoTzWfxX9Z+ciuc2PBXNPAjneqSSxOhd6o3+iQqKzK4ylwjjxtC5vdmiTXfDhCJVQwl9Q59RmNRhI/Mca/OLXeYwp5x4EQ44+1cvMGqWeeSyJKVQXMjXnQutStBJhHQW+lvkhp7YWnImJ9/THAiUz+XfT9ii5XT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725297936; c=relaxed/simple;
	bh=i0GO9cmEnkQKQz1YiJmYHXmZrGBPLKjp35I3BqNj7d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0VVa5pVLemsnCgD6p8mI0YQOzIwQUYGu06pmWjxqsSs8Yg4butAKj2rd2KlCvIco/IiNtmd7xdgUYXGHkcELJRtTf6K+gSEMwwPdORAn63WnDP7oXFU1uzHHnW0J0CB2J4jNioy23Pj3UHeT+v3wCc8r0I0f81BxC7vYbcpEcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6lZDSqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B7FC4CEC8;
	Mon,  2 Sep 2024 17:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725297935;
	bh=i0GO9cmEnkQKQz1YiJmYHXmZrGBPLKjp35I3BqNj7d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I6lZDSqhhzeEUZilvoOZr15pMfb0RHSLw14KmjsOuPj7YkN72irqumCYJoia4mfkF
	 34Xa6zOfk5xKslq7SkrekdHnChuRTnT6tOqcibY9Hvft91/vKjHbaVxq9CsFaliEfL
	 tEa27e5IcmdHDYDXF/V3wSiSZm+6PGkltL0YCyyQ4cnDMEYQxrsEQ3WO/iJB72DKuX
	 kp4H43N74/EGkMoIlTCZL2F1zmB+sYchNjdrjBVKVKe8TVslrQPw7FtIZSB7j1gVTT
	 Q/7sos/4+O6x1GKhyVikpw6HfWM4KIDDlcLcAypl5KKQLXVapjeoECv6AvUVzePtvV
	 J+Zn8q6M8ciNQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.10.y 6/6] selftests: mptcp: join: check re-re-adding ID 0 signal
Date: Mon,  2 Sep 2024 19:25:23 +0200
Message-ID: <20240902172516.3021978-14-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082617-malt-arbitrary-2f17@gregkh>
References: <2024082617-malt-arbitrary-2f17@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3347; i=matttbe@kernel.org; h=from:subject; bh=i0GO9cmEnkQKQz1YiJmYHXmZrGBPLKjp35I3BqNj7d0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1fT9DCndlvkCM47XBITNmZf0NJR5VhCedb6X5 Ujbjn1pvBKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtX0/QAKCRD2t4JPQmmg c0igEACXtComh9cc/SseE/9t3+50bUDhwTRv7PT5CSmf8gXxIbhTpLaWcg2Ic1KsDjqPIOWwNUs pUawrX2vTnY3oxMRJ7KC0RKaQUnBlGJik3YzNRkFjTQXW5mlTwu1yfl76+IEfZnUgVmmR9UOyDw C7A4K973Bd8CLpJCA6YNfFUYajJbUHShIjp01wjvf51gAUXTl5gEAdtIF9uIT9hFfp52tVagIYs MHy11ivDYzaKaTHRRq88Gwrz1njcQ2EL/Xzaz1SBD7LWwnCx+mwIZni3asOlloPsJ6dUeGPnmUZ VdDjrdfmkg7bvHHwER3fQId+lRmS58eylp7u+Tb5fiQ7UzU6sMnwslJxrXdo6axRLhCQLSfW/QL /59r0wsRwyIRWxZpq2pX22VpGN+DWVNyJkakU+YFcLN89aqHEfAkWCnzdqQiijSPCrTzC0E/nwo XLQl3/Colh3Ndrucmw6+Ax+kEqKo5L/FS+W4ZnKxsa9qihMp90AblcpaTc9DeYl0Al2T88qzfsj 1W+vvyY67/K0CL6fJI6hG9nwgA1YExoge4Olz4fiWSa+fGM2k63ZUZjm7v/TVMyBhpmLmLzqyxh LJ8oYXOXTNtqY42xjCSsDF1U/0LBjE5hLc0fyd5h9HYiTsICa2S5LH2BK/YkzARawg/mzbuCeJJ 7vVb8b4eWz9DtXw==
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
index a8ea0fe200fb..a4762c49a878 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3688,7 +3688,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
-		test_linkfail=4 speed=20 \
+		test_linkfail=4 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 
@@ -3717,7 +3717,17 @@ endpoint_tests()
 
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
 
@@ -3727,19 +3737,19 @@ endpoint_tests()
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


