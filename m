Return-Path: <stable+bounces-186342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA85BE93EF
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537945E6AD8
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 14:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B8732E154;
	Fri, 17 Oct 2025 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpYBHmde"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CC01D554;
	Fri, 17 Oct 2025 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712134; cv=none; b=mdoY6pC01raNAUKWO7kjmtZYEuW/ZLvSdNyy6WzSWSqDPhxI7I4bXikJQx2b8qd8VqznK9bteLDZZ8JQZLvdxnCP+riTy6y1s8rHU1eZ9r+3aQo7oLqKZbyKDk2iL8UktvMxNv3dAe8M01IJshp7Aio8KwXZh/0r/9xgxEDJL1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712134; c=relaxed/simple;
	bh=eXk9QGfEQ4kWsV/vhIbDLldj4voccGNnwfBObLBtEPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6uGHHAXUy3k3tvYEPMxH1bu5K7vq3WJCWLAszwnAuvhnE43SS29AN3yTirT4ZL8szmosjXaYAZTKDSK8FAxDpIbxhKTsKxs9qjDZkgj5rltdwAgWkJg7lbR5ifrjEl35OLmnN3o+9b1RVq5GxBO2UVREabSNNbSJfpFqTbovaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpYBHmde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3124C4CEE7;
	Fri, 17 Oct 2025 14:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760712134;
	bh=eXk9QGfEQ4kWsV/vhIbDLldj4voccGNnwfBObLBtEPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HpYBHmde3XAc10/wJBXnD/yfWSoqyyBgE0t+Fpu7SiEy9ropFi3IHkdfRkT7sEHxb
	 we8wVPFHubFMXfrQJCdgGsqm/+QPb45BxaCD0zCm35pO7dO6CZjNj382tuD0+IsQrq
	 KWhESvQ5Ojh/Vak1Gcnmce7H6jz51tT404IaKttaq3VrJyf3baJGdgjnZ2eeJPuPN5
	 X46cQyiBG3andXBPNP7G1Yv4Q1K6x+3U9+daxFT/jnKk89fCTQizOc3Aj3z0DOrUSk
	 0AYNNk0SgzlLIY4AOz4pewcGohMgMoOtb0V6MfMilf+vUkVZjqwvNZHHyMJ8TPkIQF
	 UyKjNWic/1LTQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y 2/2] selftests: mptcp: join: validate C-flag + def limit
Date: Fri, 17 Oct 2025 16:39:52 +0200
Message-ID: <20251017143949.2844546-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101658-underwire-colonize-b998@gregkh>
References: <2025101658-underwire-colonize-b998@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688; i=matttbe@kernel.org; h=from:subject; bh=eXk9QGfEQ4kWsV/vhIbDLldj4voccGNnwfBObLBtEPM=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI+hVpuqvyxyZnF7LuVg8pnlTkWl+b3rG1uP9g1b8+Th oZItriUjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkkFjD8r923dNL9vWuE2q1W vr9jsCzi6MI3D/o0zK+VT57AWfTH9RfDb3YX9741xx+4aiycMamP42HeCgVrF8bSeOvre0TMwhL cuAE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 008385efd05e04d8dff299382df2e8be0f91d8a0 upstream.

The previous commit adds an exception for the C-flag case. The
'mptcp_join.sh' selftest is extended to validate this case.

In this subtest, there is a typical CDN deployment with a client where
MPTCP endpoints have been 'automatically' configured:

- the server set net.mptcp.allow_join_initial_addr_port=0

- the client has multiple 'subflow' endpoints, and the default limits:
  not accepting ADD_ADDRs.

Without the parent patch, the client is not able to establish new
subflows using its 'subflow' endpoints. The parent commit fixes that.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: df377be38725 ("mptcp: add deny_join_id0 in mptcp_options_received")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250925-net-next-mptcp-c-flag-laminar-v1-2-ad126cc47c6b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mptcp_join.sh, because many different helpers have been
  modified in newer kernel versions, e.g. in commit 03668c65d153
  ("selftests: mptcp: join: rework detailed report"), or commit
  985de45923e2 ("selftests: mptcp: centralize stats dumping"), etc.
  Adaptations have been made to use the old way, similar to what is done
  just above. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 06634417e3c4..2cf9bb39b22b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1826,6 +1826,16 @@ deny_join_id0_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and address allow join id0 2" 1 1 1
+
+	# default limits, server deny join id 0 + signal
+	reset_with_allow_join_id0 0 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "default limits, server deny join id 0" 2 2 2
 }
 
 fullmesh_tests()
-- 
2.51.0


