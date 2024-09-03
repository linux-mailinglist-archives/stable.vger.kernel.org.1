Return-Path: <stable+bounces-72791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9358C9699BE
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CEF42851AF
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DC41AD249;
	Tue,  3 Sep 2024 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTw4dwQu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24AE1A4E88;
	Tue,  3 Sep 2024 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358098; cv=none; b=KqIRPSbIzLJaaGu+IJtRTD9rv0x5rVX+eQZTczR6T42mD/tr/PasLlEtOJhd9BF5dXm6AuKUsnXh0I5JFiP6JtkL0pfjsYVXqe0+uutEDg7BtJTl/LUrM2eoAhrlqgfv+H8/CfInD/ZigYESq8k1ZxwIlMUJCwZe3WVkohEp9dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358098; c=relaxed/simple;
	bh=UzNjJGFouj8dhslGdiJb4b/LAO9FTe2HEbAadmZy6EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uzf4x3WPZzXVdgvROL154HFYF7nfD8FNL6iX+kB7r13nGLzTgGXBrg49s1BLLEm42011O+Y057s0sYp/u6MEM1TZAv4C27f4523gAgzBekQRwtTH9gpX58/JCdEI4Jkn0Vf/QnHK966Nd08sa4iWKt0y5yVKlN9Xlw9ztinckxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTw4dwQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4098C4CEC5;
	Tue,  3 Sep 2024 10:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725358098;
	bh=UzNjJGFouj8dhslGdiJb4b/LAO9FTe2HEbAadmZy6EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uTw4dwQucCUHDdq0luNISCiMKoPxXZVDGPGHyBV18D1/zXDhk34hD23T3kwI+emqf
	 o6BIfiJ3C00DVKF0AVJUtGbolZHcY2WIXdWkQSGtpK4o7UFHDGFAyDegJkjzyALv7B
	 +KH2btmTGMC4KkSldHQ0Z31ehbL+pr7416P3kxUNxmbpUoy5iMOtYyg5XjohnvzPil
	 xDgNqDuV45zyru6LUP2qEBibm7IysV5yGNidyQgCpb24Tl5yEnCTCrgYy9aC54LDEV
	 QWlH7xutsfckTNWE21djne89nxtrQ/AflVQBdtFqzYAkEz0RwdULclTIRfyoZYmtCB
	 aVBxVtj2XPscQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.6.y 1/4] selftests: mptcp: add explicit test case for remove/readd
Date: Tue,  3 Sep 2024 12:08:09 +0200
Message-ID: <20240903100807.3365691-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082617-capture-unbolted-5880@gregkh>
References: <2024082617-capture-unbolted-5880@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=matttbe@kernel.org; h=from:subject; bh=v/48NbHMmW6SB5kTtotOFsNLfOnzM8ecvHHEzA7c2mg=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1uAHSluqY7SjylecZ+REkH5uXOfEBa8L+EvSx xhEPX/1ZI+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtbgBwAKCRD2t4JPQmmg cwc6D/4lalGurp03mPhpC/zHgJ4yZoz5WdgVo06LRbYYxX0y40x8/N0PAYAoHJ+vPO+fttj1Ocy PbpaQJ/o4BHTroegf/uge07o6BAtx5Kg6eduAocRKfnc/lggp1QeIKS7R3mEhcZTd/mbGfCKH4K HujLL/4b86FU5Q/V2CYGOL6NMZnCUAcu5Thyujn5cW2q1DZhTEodqBA8mBHgHXaeJcUCSfyoWPP 2vFS4ZEYeojENRgAE068bObwLTjkuZjyrnp/FB4S0F7QvZsiGdRYTOb5z6XI/V39++uFRVbp/pz c1zPYUPERhEpXZczYTn5aXxtbbHAHHZiAs/EdQwpKvPtIyU+NT3cLdHtFYo4BQH8pR6co5ltIa1 /nxIg7/+FZ7QRJu1JgJVHQfH3PhayducBtdmfU0S3sKYuhes3onyqNL+2twjU5mcGWNFRUnyCLZ hcVGmSFY2qo9lRla6NQb97g0+eFVFwS4U1BZkypIuAffiSKXLMQ23x5952qsvTn+elLBEI2iCsN yLSbJo6CT1dNtMxwOaTI1eE5oq5z4R3c5NcaQkCE8i1jIVj9yMK08AtiRO5cDGn3fSoj90xr8bO sAXZRYaPcPiXxvt/rK4mKBmpXJQ0DgvmbVT58qHiZ3NdYGlQOU+3A8tRybku2f8y2mRXSbB34Cg OMd9D8diVY4F1nQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit b5e2fb832f48bc01d937a053e0550a1465a2f05d upstream.

Delete and re-create a signal endpoint and ensure that the PM
actually deletes and re-create the subflow.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: e06959e9eebd ("selftests: mptcp: join: test for flush/re-add endpoints")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2be13dd19ddd..69f78879cfa1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3632,6 +3632,35 @@ endpoint_tests()
 		chk_join_nr 6 6 6
 		chk_rm_nr 4 4
 	fi
+
+	# remove and re-add
+	if reset "delete re-add signal" &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 1 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		test_linkfail=4 speed=20 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+
+		wait_mpj $ns2
+		pm_nl_check_endpoint "creation" \
+			$ns1 10.0.2.1 id 1 flags signal
+		chk_subflow_nr "before delete" 2
+		chk_mptcp_info subflows 1 subflows 1
+
+		pm_nl_del_endpoint $ns1 1 10.0.2.1
+		sleep 0.5
+		chk_subflow_nr "after delete" 1
+		chk_mptcp_info subflows 0 subflows 0
+
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "after re-add" 2
+		chk_mptcp_info subflows 1 subflows 1
+		mptcp_lib_kill_wait $tests_pid
+	fi
+
 }
 
 # [$1: error message]
-- 
2.45.2


