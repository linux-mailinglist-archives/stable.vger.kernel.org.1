Return-Path: <stable+bounces-52656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E3C90C8FA
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFE9288186
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 11:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C99915A867;
	Tue, 18 Jun 2024 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9X/S4a3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C215A859;
	Tue, 18 Jun 2024 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705149; cv=none; b=k2fQSW3p7GT+WZKaCw3TY6hoCtwLqT1LmtgSL2VI/nqqWZfBlwh7k5sV1iAnZ7zAyjiA6DheEsGk+KAYjHF6MOWmobHzWTZO0W6QfAlrJwxQ1PdNn+DKbfgTlCZbJSBP6BUeeNZSnkqzloZ6lnfjKcRI2IAyLL3Agqd/56MYNAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705149; c=relaxed/simple;
	bh=f2gFUBQGSToIC5rKbptKClNUzniA5zUZciPZxi8UhlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBCKbfXjnRdbH5cw0AeiMv8pW4o0Y5613aKmDSlRPZZaDPZAePq3aWYxNUIbE8/njgKzPF2r+WWRE//TvJuOcwNOywAsilExPMOjioij7HRvRJAMghbEAlNg0jTkuffCE17zuNkc1zGuRWsdsYKjv+Mu3ZVxqIe5U+dSuWGoXLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9X/S4a3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD98C3277B;
	Tue, 18 Jun 2024 10:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718705149;
	bh=f2gFUBQGSToIC5rKbptKClNUzniA5zUZciPZxi8UhlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U9X/S4a3wChhu86MEsGy05uxxqNSSg1r4TDqyiFkbcffsZWpzRehtHCvkbe7Fs6Qv
	 SsxfBSjJIB3h/HGTCaLmg2KGVAZRN1m+O99zhnJpotiGz2mlMPfDuyZKr3chEaeGVS
	 PcvMDci8T7vXU7N4kwkmfh/UHiMoR4ySc0p5Dt6jY0RrSGGs8qdDa903easkb8SFZ1
	 s6zRwet2jhEdPoGq9S20d/rlU0YdQUntxrc0nKBwPgSjvrfEOC2R8n6QUqSdPXQwDs
	 vedCR30E5Gu9/HjCyDEBCXW4T6rhhsYWTbJtXloEoqgjp86VPG7vmpRTMqiDc4VApB
	 5pQkmJIVy1GZQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	YonglongLi <liyonglong@chinatelecom.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] mptcp: pm: update add_addr counters after connect
Date: Tue, 18 Jun 2024 12:05:44 +0200
Message-ID: <20240618100543.347011-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024061751-duplicate-backlash-e65c@gregkh>
References: <2024061751-duplicate-backlash-e65c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4570; i=matttbe@kernel.org; h=from:subject; bh=QSMEsbDUdQDCaJDPrKnYeqctTMKdoj5Dz+Z3NWVjUy4=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmcVv3WdfLHNCOKPFlyrrK7C03QPIy3DTJxQtkB 8JRd+KSOuCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZnFb9wAKCRD2t4JPQmmg cxiaD/9b0ybyeCJK8JagHpxDbq5iXrnEETD/vnnCdaYzE9reWzP+SOo2uxmJyZgyzzXln2j2srL 5ahiavcp1aCGuQZAosbGQU+LP3cXbDjlqGA+AFY8lWd9qgrRzpt0G6zVMpG3GP7moXQaasTaPIH 6CrIDtxpiezbpEhKQSMI+A/klqvwCYsT1sqaOyyMBofMCWkiLVhsDZlvcBd4kvov3+XBe1UKcl7 bxfQn/aclHjxYAb67teFNWwT4MRtwWBnrrxbXzwhGEFa39Ua6vOzBwb2jvLQRgCcHNieKMdeLAi ScP/UH3+DHzmcI6EZ/tB1n9Iid/LqmxFt9ffCNuwSPpHBKQKym7VCmmb6JJfgvS+u3wwT3FqUIJ thPu3oi2SXETdncaV+hMRKXqY5tavPlAo/oMEOK4Nsefs71Yno9Ssv2hiWbc+FJU+DIWnJ+k4uK V10oWdJO9LiDRx+RK/tuRWoYzRC30Ww45zaPqvm0YC5PgukYTw/DwpihmEdgOWyZWRA70Pr9npE gWAdR5tCYWVQA7gQQ0o3UJnuh92WdKVnsqWaTZ+tc/KUG+e3nDFv7yUFDhGHWUwdYDTa3YVvu2u 9o0wRPhC38f5o+cEqMYIXUBOBp+pSaW2HCHd5lKUsxi23xakj7bulZRhDV4vnRmGfsudwx80wZs Bgn19izMX8WEjkg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: YonglongLi <liyonglong@chinatelecom.cn>

commit 40eec1795cc27b076d49236649a29507c7ed8c2d upstream.

The creation of new subflows can fail for different reasons. If no
subflow have been created using the received ADD_ADDR, the related
counters should not be updated, otherwise they will never be decremented
for events related to this ID later on.

For the moment, the number of accepted ADD_ADDR is only decremented upon
the reception of a related RM_ADDR, and only if the remote address ID is
currently being used by at least one subflow. In other words, if no
subflow can be created with the received address, the counter will not
be decremented. In this case, it is then important not to increment
pm.add_addr_accepted counter, and not to modify pm.accept_addr bit.

Note that this patch does not modify the behaviour in case of failures
later on, e.g. if the MP Join is dropped or rejected.

The "remove invalid addresses" MP Join subtest has been modified to
validate this case. The broadcast IP address is added before the "valid"
address that will be used to successfully create a subflow, and the
limit is decreased by one: without this patch, it was not possible to
create the last subflow, because:

- the broadcast address would have been accepted even if it was not
  usable: the creation of a subflow to this address results in an error,

- the limit of 2 accepted ADD_ADDR would have then been reached.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: YonglongLi <liyonglong@chinatelecom.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240607-upstream-net-20240607-misc-fixes-v1-3-1ab9ddfa3d00@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in the selftests, in the same context, because the next line
  with 'run_tests' has been updated later by a few commits like commit
  e571fb09c893 ("selftests: mptcp: add speed env var"). We don't need to
  touch this line, nor to backport the long refactoring series. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c                          | 16 ++++++++++------
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  4 ++--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7d9b41d7445b..3e2cbf0e6ce9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -685,6 +685,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
 	unsigned int subflows_max;
+	bool sf_created = false;
 	int i, nr;
 
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
@@ -710,15 +711,18 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	 */
 	nr = fill_local_addresses_vec(msk, addrs);
 
-	msk->pm.add_addr_accepted++;
-	if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
-	    msk->pm.subflows >= subflows_max)
-		WRITE_ONCE(msk->pm.accept_addr, false);
-
 	spin_unlock_bh(&msk->pm.lock);
 	for (i = 0; i < nr; i++)
-		__mptcp_subflow_connect(sk, &addrs[i], &remote);
+		if (__mptcp_subflow_connect(sk, &addrs[i], &remote) == 0)
+			sf_created = true;
 	spin_lock_bh(&msk->pm.lock);
+
+	if (sf_created) {
+		msk->pm.add_addr_accepted++;
+		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
+		    msk->pm.subflows >= subflows_max)
+			WRITE_ONCE(msk->pm.accept_addr, false);
+	}
 }
 
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e9744e31e6a0..51f68bb6bdb8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2343,10 +2343,10 @@ remove_tests()
 	if reset "remove invalid addresses"; then
 		pm_nl_set_limits $ns1 3 3
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 flags signal
-		pm_nl_set_limits $ns2 3 3
+		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+		pm_nl_set_limits $ns2 2 2
 		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
-- 
2.43.0


