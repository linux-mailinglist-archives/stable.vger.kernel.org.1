Return-Path: <stable+bounces-72741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE278968CCE
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 19:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C9B1C22754
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 17:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5B71AB6DE;
	Mon,  2 Sep 2024 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaiaDrtl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A82E19F129;
	Mon,  2 Sep 2024 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725297932; cv=none; b=DOJOP4Rk6Hkovzd/ThyvSCCw/GZvFTtqOM3BxpJhoi6iQ1R4vNhruGLRkX4+L0ZSGQj422j64I4UOw9stclgzorFnwgZjHObC1SWGl8fPfowOa/NwDjC/nms9AAtpShuEfEcTLqMEgi7Zd+XRVs4a3RLRYWaWB32as+YYyTvBn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725297932; c=relaxed/simple;
	bh=UcWk6p4N12BZ7iOJbyImbMLKPfb7OxRGjLJkRLTqKnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3znyMc1ATBM5sQlCDawUWpuPcdnGp3kBKiLoXYLpOuSsfcWtLJXPCUw2mJ6thj/lMMIx8a40IehauPoluovYRzZyou3GkpaTxcCKbksJk1y9Lqv3kvcw7Q8tnA2oaUjgCrIRc3O6M+XwRtHU9URttqicL1uBkwwqqqAmE0CxYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaiaDrtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C12C4CEC8;
	Mon,  2 Sep 2024 17:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725297930;
	bh=UcWk6p4N12BZ7iOJbyImbMLKPfb7OxRGjLJkRLTqKnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GaiaDrtl6IEYEwbJm0KUT+cB7xZWQ0ebitMB7dGdyfROkkIUpEvEpDBGtEj4c53D+
	 3iUI8lp3xDu8jGsbNevXkNDANvdb6ZUspH59Nai5gHhl+96PdBZGHK6G3Oh3923nNX
	 DmJ8zxm/HZfJ/exisdYg20F4+o5967Q6zqxweQxIfsCW44gjC63cWs/5rUlI3efYxQ
	 sJTtCF4o4Vzy59kejCf494U/7YehOfR6Oy/EtxTTlrqY0b22ISNdxoHqNF9AICwsTp
	 kYZSMgfTGtuRZt+uCVM5P0Tgj3lpyewrdUKLfbUugc8eIp5g++fi+Lvpx2lEVgMvAr
	 EI50L2Ufrbqpw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.10.y 3/6] selftests: mptcp: join: check re-using ID of unused ADD_ADDR
Date: Mon,  2 Sep 2024 19:25:20 +0200
Message-ID: <20240902172516.3021978-11-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082617-malt-arbitrary-2f17@gregkh>
References: <2024082617-malt-arbitrary-2f17@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2949; i=matttbe@kernel.org; h=from:subject; bh=UcWk6p4N12BZ7iOJbyImbMLKPfb7OxRGjLJkRLTqKnk=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1fT9tnxNNYcsPHTzzeNfjWqCtYx3yBBBrhW9Z Hb1g5+WJT2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtX0/QAKCRD2t4JPQmmg c4HsEACCsgEY8UAe5CpeVcZgpTSQSg8hSoVDRk8gu7qvY1BK1Er3FOiLS7Jxo/YuOQIsA3SQUVU w09BsRwswL3trwy0MakoAQuvheAiRzKVz+kMXrmnbfDq2DJhJ+3nMD/YLeMSKQ+k7sK/VhFSdN5 LPVRr8sQhc6Aj3RsgozNIM9vRKHpTr2AE0ieqJsCIhnuB3ig7hUSxFu+fj9lM/cP6VPDSn5gffv GdV1ktHXu78m9x3rjNjFT+cnWPVB9knruul05qr6OHZUdtKgMQJpkugmmeDUOLGDw87/foFCo4z qYaiia3+vsa3PHvDrzvSviVK2q4myJEVcAZpXITlveVNInErpEFxeuqkeeU+gwvVbiaNI2RpZ4B VWzCPZxRgN1b9ChknJXBkItVNcibzI6aFx/o4dNWHvQdzRc7qGaGdoVP7auILxtCrpvJLEOBlnU rzyXKRioU6yEDdQ3s9rgwViNQYKk8jbz3bP/ldcksQRR480a+YnG/p17fTZaTYmUJGplW2917oN +XkfDsSBYtJy6Gf6AwrMpAbHGFtZg6xqeEItjM3P58K1ggZRtzCFHFTHXJKRTSQvkumjzxFzm1V vtkOEuA+dtTtmNVZiyMlXT2eETpq8XSY3xOSAuplH6JfiFpXSVSWGd/3ZIHoqy8Sz3AekEYns4s 0mUWwOh7aohToPA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit a13d5aad4dd9a309eecdc33cfd75045bd5f376a3 upstream.

This test extends "delete re-add signal" to validate the previous
commit. An extra address is announced by the server, but this address
cannot be used by the client. The result is that no subflow will be
established to this address.

Later, the server will delete this extra endpoint, and set a new one,
with a valid address, but re-using the same ID. Before the previous
commit, the server would not have been able to announce this new
address.

While at it, extra checks have been added to validate the expected
numbers of MPJ, ADD_ADDR and RM_ADDR.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-2-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh  | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7dee194bdb62..64a35f96ff92 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3630,9 +3630,11 @@ endpoint_tests()
 	# remove and re-add
 	if reset "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		test_linkfail=4 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
@@ -3644,15 +3646,21 @@ endpoint_tests()
 		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_del_endpoint $ns1 1 10.0.2.1
+		pm_nl_del_endpoint $ns1 2 224.0.0.1
 		sleep 0.5
 		chk_subflow_nr "after delete" 1
 		chk_mptcp_info subflows 0 subflows 0
 
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
 		wait_mpj $ns2
-		chk_subflow_nr "after re-add" 2
-		chk_mptcp_info subflows 1 subflows 1
+		chk_subflow_nr "after re-add" 3
+		chk_mptcp_info subflows 2 subflows 2
 		mptcp_lib_kill_wait $tests_pid
+
+		chk_join_nr 3 3 3
+		chk_add_nr 4 4
+		chk_rm_nr 2 1 invert
 	fi
 
 	# flush and re-add
-- 
2.45.2


