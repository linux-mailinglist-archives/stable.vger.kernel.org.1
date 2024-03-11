Return-Path: <stable+bounces-27247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821A7877EC6
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 12:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDC3283644
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 11:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C2339FC3;
	Mon, 11 Mar 2024 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pvs6Sxfk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A1638FA5;
	Mon, 11 Mar 2024 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710155740; cv=none; b=WiFUEP50Wu12B+waj1VngLL6pA5kLlucq4FClv7vOmCCijyvPFBj3Na3TMTw/hhuNYYhhPm9nRMWp5eJmeRiMEpt8qYyipSexfiuSKbmpUrnT2A6AcAhSnVDKmpZJcz9aV1x5PeN4YmbMCgeUjrrlqD5LijLYlR/Ti+ASluicmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710155740; c=relaxed/simple;
	bh=6peI3ciCm7aQ4dA3hRQ4FkGNP7ugdIiF/HMrpOKrqxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQnExqzF3a5egsHwIZ/dPbEDpe2aquH0oV6oq/ybCVK2D7KLwvKpW1hW/Tlnh2fZKStcL1fCeH9U5l3eyO79QRKjjV1u61xwSgOQOxGiT++VpXXJ3Fkai0axaszg1BqlQ9IKhlR6TaFZ1O7EmBB2wJ0oAT9mVRWf0z2w4DMMDI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pvs6Sxfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C34C433C7;
	Mon, 11 Mar 2024 11:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710155739;
	bh=6peI3ciCm7aQ4dA3hRQ4FkGNP7ugdIiF/HMrpOKrqxY=;
	h=From:To:Cc:Subject:Date:From;
	b=Pvs6Sxfk+Cjsf74wv029DhoroomWjkMSCT3Ucq8yMW979HGKJ8mXrjJJgJSjNkGbW
	 eV4lQmxO3oaYgw5QSNE3mr/3JiIuAdt22dnBCG+2VHpkU79J0bzMCQPH4e/F5CPzh6
	 B28jFSE8U1p/LHHOyovr4R3kJm8K/oSJu/0jL7kIWXXcFuEvRsIgcft/5mMTk6AgdP
	 8nTTcvwo98G66tEOcChKCC8/mXMachTRlEUtLBEIpMfSv6DTA0br5ms7Fa4Ah4gX8j
	 V37qZfkYiXD0YsjhJReAtqhlNXqJxGZlGKobW2Rd2rOpSOJvN1C6nfn+CPkjFfIvOL
	 q0ksq0IJKqTqQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] selftests: mptcp: decrease BW in simult flows
Date: Mon, 11 Mar 2024 12:15:31 +0100
Message-ID: <20240311111530.1425144-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2548; i=matttbe@kernel.org; h=from:subject; bh=6peI3ciCm7aQ4dA3hRQ4FkGNP7ugdIiF/HMrpOKrqxY=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl7ufSqB/PIpQYSGmnvn16lkqqNu0u9NuJ9qJPU EQPnjMg42mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZe7n0gAKCRD2t4JPQmmg c3YhD/9z4cu/hVfKUes7OcIrIyF6MoKRfJMH+PQBScvctE/QhSzUqdVecwFX6VCIvy7z9Q2eg1Y miVtE1HwjLtbCs+rWAjqOC/PMukpQALl2tbovchQrkLBsVjuxPZ0Gnp32jCaCzzB1X0IyXt8H+Z DNFtdECibBEqKOhCE0URPj8gzQsoai5+aDobq6pBm+2SaKmxmJ0OdQen1Bzi9/NsYwBtZgxDeHB it7cUZGAzc9PS6GmPakLm0awV5zNcgZChDXYbqbJohZSbCMZIjDSmSybJ7iUGM0/OZzqWLH4a/Q 1rmfYKc/Pj41wtajdQ5YxstRSOrY331/0qOO6AUrynmh9LTmdqtCsZ7dBtZSDDmVLFVkeekrSZ0 gqZu/JD7R0ri4zte1tjJcQ7bGP3D5DXqG3XULfMHrqgfo6X6B2wNywSbeDED7bQA/IZyJzkue+G ChsRPUH2vlXQPxipolrmIeWrEkXF90MgrmE13YGjY22y43/HPzcLpHzjqh1aDUpyb7jRIu1VjCw f6Yeypo4Dn6SmQF8E5BTwUXPE9l0MvjbcAct79QbAanHqr//5q3cnf2pvQhf0kTYPW3VZ0j0BvV yuKrYvNUMzeUdcFnbzA7WdiIaQPpN8spU9Y0zYBGDNJdvClB66aMPCLV/CgzkVTCxE2puGp0nOo rsqppbduuSKHsfw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

When running the simult_flow selftest in slow environments -- e.g. QEmu
without KVM support --, the results can be unstable. This selftest
checks if the aggregated bandwidth is (almost) fully used as expected.

To help improving the stability while still keeping the same validation
in place, the BW and the delay are reduced to lower the pressure on the
CPU.

Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
Fixes: 219d04992b68 ("mptcp: push pending frames when subflow has free space")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240131-upstream-net-20240131-mptcp-ci-issues-v1-6-4c1c11e571ff@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 5e2f3c65af47e527ccac54060cf909e3306652ff)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - Conflicts in simult_flows.sh, because v5.15 doesn't have commit
   675d99338e7a ("selftests: mptcp: simult flows: format subtests
   results in TAP") which modifies the context for a new but unrelated
   feature.
 - This is a new version to the one recently proposed by Sasha, this
   time without dependences:
   https://lore.kernel.org/stable/9f185a3f-9373-401c-9a5c-ec0f106c0cbc@kernel.org/
 - This is the same patch as the one recently sent for v6.1:
   https://lore.kernel.org/stable/20240311111224.1421344-2-matttbe@kernel.org/
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 752cef168804..cab3e3a5481d 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -289,10 +289,11 @@ done
 
 setup
 run_test 10 10 0 0 "balanced bwidth"
-run_test 10 10 1 50 "balanced bwidth with unbalanced delay"
+run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
 
 # we still need some additional infrastructure to pass the following test-cases
-run_test 30 10 0 0 "unbalanced bwidth"
-run_test 30 10 1 50 "unbalanced bwidth with unbalanced delay"
-run_test 30 10 50 1 "unbalanced bwidth with opposed, unbalanced delay"
+run_test 10 3 0 0 "unbalanced bwidth"
+run_test 10 3 1 25 "unbalanced bwidth with unbalanced delay"
+run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
+
 exit $ret
-- 
2.43.0


