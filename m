Return-Path: <stable+bounces-72792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C39D9699BF
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37E81F21C9A
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8501AD24C;
	Tue,  3 Sep 2024 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWwZ5U1T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571D917C9B3;
	Tue,  3 Sep 2024 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358101; cv=none; b=gxIuhRxCBFOUh1RJKJuPv9crSUGg9LzcHv4wgLGTslgnMz4xfugV8p5rf/SdI9Ro3n8VIJa0x87LHp9NbSUpkVs5biGenZkqYL2iT2+DWy7GKJ+ttB8owWDgmBcF+QSnYwOkpK+9x/+Nxm9HwQ6bTWt/pVxkP1au8rNqTY5HAtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358101; c=relaxed/simple;
	bh=LGrbH01udiahr2f5q3ht4r6aoqoA6kr6U8G2RxHCO0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFlRJpw+a6yDRCz0CHoqdR5SzhnwtFQerMPs5EPylOuRC3pXlF7sZ9EdqagIUzY04qCJySc1h8jiJ3YQa+gVS43MDwWt5EKor/f8VsBZbR1Q447f06buWtAlwpUtC3jKdKB68EhK+SGcMR0NVzR+7+I4wxnFvBs7FL2yvVdFoWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWwZ5U1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEAFC4CEC8;
	Tue,  3 Sep 2024 10:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725358100;
	bh=LGrbH01udiahr2f5q3ht4r6aoqoA6kr6U8G2RxHCO0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MWwZ5U1TCIYurLZej3f3H72LBn+pWcxUZv3AeC5NWhccwEvjEBigCI2oHgDLfsS4j
	 KSccr82rM+fo8Gpm/7mMcXk/zmlLbWsnAhSU1S0e+SoYuaH2z0OoAecFD/4jy3YKlG
	 e1o8fWb/LoQpR6O+lqeXHLykYT1pzKqaXrFkXj4X0ry23SYbrVHdkyfNwZ6ZNc9o+E
	 tUHaKG4w60mYun48FJVMyGLSKIAaRTbopwxt9Ze2LCpu9qSF7PZwGlTT2uDgaG6Y4h
	 psAA63X2kZo3J/ziVsH0hqAn+WYyOaDcCTbeK+5WGbb7FyPtw6A7pmyrOtSHMh2gVV
	 fSTWA0DPY8dFg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 2/4] selftests: mptcp: join: test for flush/re-add endpoints
Date: Tue,  3 Sep 2024 12:08:10 +0200
Message-ID: <20240903100807.3365691-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082617-capture-unbolted-5880@gregkh>
References: <2024082617-capture-unbolted-5880@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2517; i=matttbe@kernel.org; h=from:subject; bh=LGrbH01udiahr2f5q3ht4r6aoqoA6kr6U8G2RxHCO0c=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1uAH0/5lNfr9nukPzC9laJfl0r+YDkYd2O0fs +fv51iGjnmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtbgBwAKCRD2t4JPQmmg cxZgEADtbT6+qJsMdkKlBH38SJDNzLva82FmrGVBIoztWH1fUZ3P3JD8rxrYlUrXbgJgaLe6wW4 YFGM6e9qyijJYMqrHV1olpMuiEidS17tZEzPJoTMi0KFmRnG39L86hhJ7gGMeADB75QAzUcO1ys 8ZwmfSe5g2yOLDVv4MVusW2j4KHMh4/I3sCKfnJV/aVjQ4Cafrp1ogbqEZm977rHf/j6VHs8q27 n1X6nsrWUmJNzhASLsSGYvipHoSskANEK2y7NvnfyjY7kL/xeEXkV6ia+zv8FMR5cbbFMgBW86I IZkg4Gkqy6lMIpJwWsIjDdQhmr7oKhlKMS1YIFzSPi2qixPXE3lEBV9/5npqaaQq25/qFz7LlCw sl3+xPslPLxXttKjkb2dxmcLo9y8oI+iaetEC0ds97V4f117GgBuBCeAa23dlKhl1rePREnmQ6O ctwJIMxEO8Xk1U/2Wcp+LAj9Ma3m6CdfO8hz5WkD1T7yTR5Pr3+DStJsvFYMRrYLlGUcFl4rFQb FaBIRxyC21S6dY/CVtKKQCf2VYQLlwpzBrYhG7X6xlM5+nhWpXI35zMPqGrEu9V6q8UfyDLzc1L lBjy7L4TosDxr/ikPDujYoQvCEFzg4BFUgYvhN3WaMX7yLPjx97oQvlhF/CyxGWGfPnYxQym21I OYIkH1Nszlz9xZQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit e06959e9eebdfea4654390f53b65cff57691872e upstream.

After having flushed endpoints that didn't cause the creation of new
subflows, it is important to check endpoints can be re-created, re-using
previously used IDs.

Before the previous commit, the client would not have been able to
re-create the subflow that was previously rejected.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-6-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 69f78879cfa1..0352c05ca519 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3661,6 +3661,36 @@ endpoint_tests()
 		mptcp_lib_kill_wait $tests_pid
 	fi
 
+	# flush and re-add
+	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 1 2
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		test_linkfail=4 speed=20 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+
+		wait_attempt_fail $ns2
+		chk_subflow_nr "before flush" 1
+		chk_mptcp_info subflows 0 subflows 0
+
+		pm_nl_flush_endpoint $ns2
+		pm_nl_flush_endpoint $ns1
+		wait_rm_addr $ns2 0
+		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_mpj $ns2
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
+		wait_mpj $ns2
+		mptcp_lib_kill_wait $tests_pid
+
+		chk_join_nr 2 2 2
+		chk_add_nr 2 2
+		chk_rm_nr 1 0 invert
+	fi
 }
 
 # [$1: error message]
-- 
2.45.2


