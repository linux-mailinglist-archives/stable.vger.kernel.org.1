Return-Path: <stable+bounces-72793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 301649699C0
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6389C1C2240A
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F181AD257;
	Tue,  3 Sep 2024 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOn5DXua"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C717C9B3;
	Tue,  3 Sep 2024 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358103; cv=none; b=AwzbQh3hsUPNa9qbAFTPmchTUdT+cIy4ENGqdcIGalegSBy4XEMsBn2w9Ay5GQljox2z4zSE5HUP+dXoEYceh3joLLLcjhNN+5fMiZCjuw7dVvl2T76pWphE/h4YVcEJjNoTzmgrsGggtk7ijRSh/kebtaUMS75HO+250vEhTeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358103; c=relaxed/simple;
	bh=ONfsUj6ZHszT7rtw9q5ppYwiNFmhk+sHUvvYejz2uVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9fhrF6P2frsgpWT2ZjwJMow9xws+u7fyzj9fc/hvCn3MXuAghaqWlT60fdh92TtuOSFoIRMdWPncx1+444d1jrCqryxaEImNwk5du/ZJfqLpPajgKvosDesnckBWiLDizuAOztgFCJKFVWD1RlRxHWlX4Sex8mfmdYqlb4foTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOn5DXua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5237AC4CEC9;
	Tue,  3 Sep 2024 10:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725358102;
	bh=ONfsUj6ZHszT7rtw9q5ppYwiNFmhk+sHUvvYejz2uVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eOn5DXuaa1tLIPV64SIbOrHcUeTixTLFYRJwEdVCex5LPTtTl5w14e2hzfod/ee4g
	 uvMIAs75d8UKXbriLsHwS6+E5smtof9baujl3ak+I/MN+cTLeXmkyqpKJf2Ppvjt3r
	 BrjSq7XGMa836k7Ufh/gpYnRnKPE/c71Gta+LkbFwD0KJL/YI5COKluoJhv90tIdzf
	 OLby1tKv6i47XB5amLzygJ17gRkPW9nPy90k9N7TKfYO8UfU/N+OcAsJArrYAwhkcf
	 pj2F0Z4fjQzkNom+/DQ3m8UTbUCThljneoWgiGO824DymVlnTckLxR0jmOa5uV5GKr
	 WwktvGyHcK9qw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 3/4] selftests: mptcp: join: check re-using ID of unused ADD_ADDR
Date: Tue,  3 Sep 2024 12:08:11 +0200
Message-ID: <20240903100807.3365691-9-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082617-capture-unbolted-5880@gregkh>
References: <2024082617-capture-unbolted-5880@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2949; i=matttbe@kernel.org; h=from:subject; bh=ONfsUj6ZHszT7rtw9q5ppYwiNFmhk+sHUvvYejz2uVI=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1uAICzqPd5pjnnpmFe0xW04TGDC7r/Pu8DfNs Tx96+QcnOmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtbgCAAKCRD2t4JPQmmg cz/fEADBxTNUNMM3xELF3FxSbBdQqyUlqOlVveVPeZMGDNpPRGhtDOrPf8m+mIQmb4ygCen2sQg 2E1409hTUBtq7JxXnw96IiEh9ZO6MpxmlOkC1/i/SCs83N6iAgTae/7zpxhaXSIALxSUvuWe79o zEMNKpLaaUw08DIFN/DSFbk/yGlkvf0p+q1H7Q42aQo9YAMG5glbZCoHBvsnSYJF16UITYrrWON 4SyN3U2MGCMzlPJhSoK5pf9ieuntdC0R1giL9WJrlQhpoC97F82ra0sPOFAsnL/0VPKS01j3HT3 w/E5ylKNyHW297zWB3QRreYe6A3WofuagwoYvQq4cXGXakjiQV8G9q68JuB3vKZJm7XYJ0vY14F VKbtQMAYhhnncX28qzpf3swQJqM+nLh3zhwG3UiKLs/jntAWGpewKeI1mZELed0YfQX7QR6YWJ3 F5BTTbcq/pQYCJyqDwniT3JrHUpRcrVaAXirmvHaOC/SpafXD9LWckdMPPmQp2dXXdFjr+2Nzvk /CnzAAmKrANhNpdCja9x4+lDFN/rrbyZS0H8KU4ISPZT8m8MouaGdwVwXdMZuqaJbCfy9nZFjqF RkcnW9kpscM73N2MOY7tk/jUSDHcQiJsYzz2lu68PIWd/DOPAXMJxvmQ+DO33ya3XRnR1BBxxJu AZU6cYMBWMXdZdg==
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
index 0352c05ca519..cdba2607b272 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3636,9 +3636,11 @@ endpoint_tests()
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
@@ -3650,15 +3652,21 @@ endpoint_tests()
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


