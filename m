Return-Path: <stable+bounces-72740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CF8968CCF
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 19:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74E02B21A1C
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 17:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B7C1C62A3;
	Mon,  2 Sep 2024 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bf87TAWO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715811AB6E5;
	Mon,  2 Sep 2024 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725297928; cv=none; b=KfaLKQilQvnpSPaltEBK0nQQ8/orHt4+N011pAX3esgEbXSL9qdoVErEFOd7vlyRfRUf5A462HtrLLjR9QsINkNhp910CuIlbn5vnCILTZMvuyl1AhANFIpJfuKxPUnOhP76lYp6Guswl41K8cfE1d/BqPGkC3ILp+w4KG/388c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725297928; c=relaxed/simple;
	bh=NmV/2KiAqkucjyEihyCSc1dEWciI3jC8QlkGn16kAfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpThFGLpkyPcNw3Ze+iwGtw/MWWzQot4VJpwMoKSFNV7dkCs3MmOk7TPiUXgUo/bEe79JHbF45bYqaOC5SZI1JSHvmaUplwBjjjrUDwFThgWECt1QxX/YehhEuBIYQOUPrbRuW4CnbFrxz3Tg+PglNG9Ha9h+NQxlQ0Bje4eYkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bf87TAWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD67C4CECF;
	Mon,  2 Sep 2024 17:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725297928;
	bh=NmV/2KiAqkucjyEihyCSc1dEWciI3jC8QlkGn16kAfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bf87TAWOwqMib7hwixH9UEBVR+/nH5wKhNccIRE6TAxgj9wF8QyGFh9FtVCCPRq68
	 U4/2Cz7Z4dlKWCJHXg6cZoS8cuFmTpsUHrZLZsunEuvVj3JnfhG6PN7f4SsaGIVdD7
	 yDpnfKyL6WqNLxqiYlZdgcW729net1DP4yP/BwFLefc6c0GqopsETe+wej18i8CkOD
	 a71JkN9ktY4j2ZIIKXmYwk5nwwpxZGFUVRM00cUxTPDHhfoQRHc/6e7Yv9w/dJHSS7
	 LrkU+jE8mEkteLebX7wS93Jy408xccKHa73aqdKq4yYpJ5zm40RIuE68b8G4FgIEXO
	 vlPQMb445lXuQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.10.y 2/6] selftests: mptcp: join: test for flush/re-add endpoints
Date: Mon,  2 Sep 2024 19:25:19 +0200
Message-ID: <20240902172516.3021978-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082617-malt-arbitrary-2f17@gregkh>
References: <2024082617-malt-arbitrary-2f17@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2517; i=matttbe@kernel.org; h=from:subject; bh=NmV/2KiAqkucjyEihyCSc1dEWciI3jC8QlkGn16kAfE=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1fT8TkXo8jqiHHUQERYrxMMHBJv0nY1WtLu7U UnBDKnHyliJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtX0/AAKCRD2t4JPQmmg cwrnEACdlMHwCflFLB/HIb3R4CtZaiPCa9RJyW2OEIFcgNWfy787+G9q3/Tz/3cCKMT2B3/z4p7 rAem+4K9pOv5o0Dmw5Foa/1j0E3Zi4uAW0/g2g2AgKuIbD0LmoJ5Jk9ji8WdCFJCNoQQwabZHWL rMSDhkwm14jLEfM5jfvNbEVcwsT2BH+Qu9NOcPaQlIBa6Vf7YM8G49Ucw2jcKz79UxpwTW3CspV dyfUunptIr/3ETTkK+8iq/1rw92VQM2+TTjlz6Oj6adLJ4RZy7HtRlXdthI0Xsmw0xUHrBgsa89 Nnn1ZOMtv6H/yWP6UukNIgoXuhC5RmclsAAZxmztkvSHqF1nTg0dkyGJpcdhfF+QjJrJy3n9Jl8 8Lt78EGk1okTg5BTrTns+66rrRIZyuwJ/9alzvEyHWXsi2i99aIhfxnME7LziXEcrNyAx7cI1Bm tiCCqa4iIKaM/Q+MV+wJdxJZTWEZ19glEJACcTleD+CT8lcPOkg+JNdYo5b2XqfIZMthEYC7lxL 6EbYMUFZVxXgSoZNYRkhjqY5OQY+pL5i3ldkQ92LXIYU4zxFwyidGO+uDZQA3XmzOHAVCjP67O6 5nXmDAWm3KnNuIY+R8MhGRXzax634YhOenPPzoclK27ci8WNb8NlhidHvQJKB2dtHdPcjYGmG9C M80eQ+15kHgzCwg==
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
index fb2d8326109e..7dee194bdb62 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3655,6 +3655,36 @@ endpoint_tests()
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


