Return-Path: <stable+bounces-73010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EBE96B99D
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96131F272FE
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519841CFEA2;
	Wed,  4 Sep 2024 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMNns84g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1A21CF7C0;
	Wed,  4 Sep 2024 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447994; cv=none; b=F8L8XZvJP7KA9yLOMzse4kfKEyeSNO6iMovxSFVo9jxcrWZ7q36N6EbDouMCv9zw9ga96Po0UkAam71E0Gi87Omgn6s+ZZpkGyHKMJ3/UQKMzXr2fsp1ZTIv3NVW9LBCi++tIVYcVsg6Hx/zXnUU5O/gkG+ayYXBtcXyE67fpYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447994; c=relaxed/simple;
	bh=/QXBL5BfqoMeyrvLxmqYzg8bHM7f9x/l7MnfUpsZsHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2a7poZG5Y5rrCw0o6Sx4CTjCSP8ec4wwu/K3Wk0/HLUPgqWp/kTG34o6GmlBHTaoA4Y5zPfu9KxCAndGrmfvltREOQHdYCas3ut7kLwouYMpAZdvspc9Rt40B1L429P0nkM79d+S10ndOJsfe3PrdWISx0kD6FYNmKgV9eXUjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMNns84g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E553C4CEC8;
	Wed,  4 Sep 2024 11:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725447993;
	bh=/QXBL5BfqoMeyrvLxmqYzg8bHM7f9x/l7MnfUpsZsHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bMNns84gguQgyE1lr+Ydi7Bua/srRRMOUpCmYsdeewySa41UVFSTNGxmmfQSWuwqF
	 p5EnfdJVwqBBxqj6EJJqn+glzqCXDyH4WeUXR6ADlwAS0kb+2voI404heLUNeHetiO
	 SVaPoc8rwFjq8vPPHawEP/hsEGFu4cPF/uOfmWBquaJsxKgMaOWAD66vpfkmmSJfQv
	 23kLJVF5dLbqchJfhgkmTuRCYyxI4d1bJZxnu3pPJ0iCO4+ICNoq5a+NA9maDC21PE
	 cVx9B7fQCveS02vEUCOpUkJGjRbDX69WBTCiNfZt9MJNhTQfh9PLTn1SM2vZqjv3JV
	 aDztYEVey9JQg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 2/2] selftests: mptcp: join: test for flush/re-add endpoints
Date: Wed,  4 Sep 2024 13:06:13 +0200
Message-ID: <20240904110611.4086328-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904110611.4086328-3-matttbe@kernel.org>
References: <2024082618-wilt-deafness-0a89@gregkh>
 <20240904110611.4086328-3-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2774; i=matttbe@kernel.org; h=from:subject; bh=/QXBL5BfqoMeyrvLxmqYzg8bHM7f9x/l7MnfUpsZsHs=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2D8jjX77OHD1/XO86EUpnQx2iQsQeiAu83qWW NNw1frHMxOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtg/IwAKCRD2t4JPQmmg czH0EACjccAJhAy+SeY6b28RxttjeveBcRsJd8t5bkJDIoOghHPDNvR32yxmq63kO93BHZWIas8 8dHxaehf2BmWeoUcRMPu5ReVOtT4b43azloQvgGcfqWMW/ZA0iY5qvR2R8DzHYnv1IxqeLhbVsF Ac6ar9AA7WYKcIp50A770eAsgywf2D8IrmjZxi07v8WBJzBxNuNdeo+0HbwcaUj1TP5pF+Xd+s3 K6gbEdXxI8oaF0PTihU6onKOeqFBtWCZBn9463upzGLJy+/eJIJspHCofUHc+GNgW5Tjrxik1YG LD7HbwVPKUbBb29avMjb1aYtdAh55YGpn3pJ8EzMpvA7e//c3inPHyPsT53CVd3l33FTFg1FiFk /sibI1bevPJUId8NwG6N7jsBXuMtQJy5f6qfwVkEf4SONXe4nI1ihZ8v8pO6scd6qfRCamhUJHA E6nVR0RysPTQO45xQyetdgD71LugXshpCXSajkPgxxsUkTt8TJ5SYUeikH+4yH8sY5rksLstQn8 7VW6SiNA7KPYZNSjszPvJP+xGLHQXNIdr+QknvTovJt1kYL4Wl0JxENbLAlUU7vZUVg9NrjB5Y3 HqaSnrQhN/QFulH+qEq0ppJ5fcCiscRX5UNtumFoOXQX/ONJ1hYGN+gW6he0lWkoM49Q5sFZArX bWE3BDtCPvxjJuw==
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
[ No conflicts, but adapt the test to the helpers in this version:
  - run_tests has been modified a few times to reduce the number of
    positional parameters
  - no chk_mptcp_info helper
  - chk_subflow_nr taking an extra parameter
  - kill_tests_wait instead of mptcp_lib_kill_wait ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 549b230238ca..0d2f30affe1b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3320,6 +3320,35 @@ endpoint_tests()
 		kill_tests_wait
 	fi
 
+	# flush and re-add
+	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 1 2
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		local tests_pid=$!
+
+		wait_attempt_fail $ns2
+		chk_subflow_nr needtitle "before flush" 1
+
+		pm_nl_flush_endpoint $ns2
+		pm_nl_flush_endpoint $ns1
+		wait_rm_addr $ns2 0
+		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_mpj $ns2
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
+		wait_mpj $ns2
+		kill_wait "${tests_pid}"
+		kill_tests_wait
+
+		chk_join_nr 2 2 2
+		chk_add_nr 2 2
+		chk_rm_nr 1 0 invert
+	fi
 }
 
 # [$1: error message]
-- 
2.45.2


