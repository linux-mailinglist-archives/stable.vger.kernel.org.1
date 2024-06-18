Return-Path: <stable+bounces-52660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB42D90C9DE
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4F21F22D75
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3CB157490;
	Tue, 18 Jun 2024 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwF+YKTI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A00614D2A5;
	Tue, 18 Jun 2024 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708279; cv=none; b=bnCODP74hDQYDECTIyhsih2GK987F+8KPrfH56ivZXDdnlFu8cdQzY6/hbCUpC0quEctN5tk0E1TZRAx9ug24NoXqCZOJSfnZXiPXBDxo5VB1Td1FvCoNwUhaUrGlKR7fpQokajM645rd4j+etBDtLUwDlKjGwAKUrFTYde3bP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708279; c=relaxed/simple;
	bh=/y/dqF/ybd0QML+UvJ/cQpIV3/QUFzYkGtwa+JUucBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zio2WSDonqdx3Lo5HVz5Y2ybd/ICbuVKW0qmn+srIaVyMfoJCE9ZJtOxf+4Y+OnEhKLojfq2oozKaawUnq3nyjJhzskK+nCyXmRPP66q8H7HUzQCwTwVpRwJWfiMJbjgehdr+RVg101oQ2in0y3ksMXW+4yZTlyOREMcol3S790=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwF+YKTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B03FC3277B;
	Tue, 18 Jun 2024 10:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718708279;
	bh=/y/dqF/ybd0QML+UvJ/cQpIV3/QUFzYkGtwa+JUucBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwF+YKTIjLtZL6YhmXr/xh5oyUiXA+8+obRu6MTVU3iiLebOHq2opmtT1D7/a7yuM
	 +OEbakgVQYo7rl8JJoYnvmdhKFRm5+qdj8Ka3FBlysMYEcDB+ln9538XpnsZzpSqBW
	 TJp9LuHW3A1DSHFG2Zv9omHvbvahYYS3whVtw4IZ6LKAQbHD70aWoqwE4HMcDc6fv/
	 5O2iOOqOZlQRpsv2qL3VA0X3vsiDjDzt8I/yJT0ZBRC4GO4avOrtUV56decNxLHsbv
	 UGTJiEhSlUpaRlN9gyHpIzF/JXBijnp0zvJmN46mPpD2+lhsjNlpp6GdV6XU42QEiV
	 lCuLB+6fYWgQg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	YonglongLi <liyonglong@chinatelecom.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mptcp: pm: update add_addr counters after connect
Date: Tue, 18 Jun 2024 12:57:51 +0200
Message-ID: <20240618105750.471201-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024061752-crowbar-granddad-34da@gregkh>
References: <2024061752-crowbar-granddad-34da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4903; i=matttbe@kernel.org; h=from:subject; bh=D9IwU5jcCWKHwO0lgV0mq62dBlcwWyBPzf85+hFP8kA=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmcWgu81D7hJ63VYyQU/1NK9oj0htHWqgA3Wewk K/Sy28K/z6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZnFoLgAKCRD2t4JPQmmg c989EACnk7GihhrOI0vZxDjh1qYuJK4FmfCtpUMB8Q3owz3Pcq09jm6I5O2nDGJlQqGQzcby7QN EYhmHbJ4KcJtHGKN5ubt0WXs3BTgi44O3ygoUDBOtyCSHx5wEGerRuviKVplCSh8jhhj5p+72OC F2p30eoczI3gcmRDmCyMvLhiHUDooZELzfVDZcLq3mHZqu4B4Gl64UWVt16GvY5ddlBz0Njw2Ci ols6grPq7aV4aSIb0RxmfVw2BJcajyPQAE6zMMGP46+YWBdno2q72zupbYEEp/3YfD0pBjKS1pO hXgkMbAIF3j+kn1Ipga9ohX0UoUHxrwGL1UafVww9L20f5VbbbpKf8vCJYaw3g40vrXkFCdNGeG ehYXl1NBcco2FCx2dPqJmF4w58yDbTnvkTBXAerGVUvOjatjZ6kDo+zzUxV2aejYbE4CzAD5+eT 2tWwj3DZtN3tsfdOIWip5KXpsLSZh3mN61pT4O/XlD0A/NHaCbkeZQyjxTlNW5AYhS/MgJrvm3M Fepda19+FWLrLlrWaU+0UBPfnxjIq9rrUB9dg8MOWdlgSiiRpUpdMAC5mK3XovueU4zAf2rqffw 1LmdDQMcjdXK3mLWt1To5SVdsJvL9TEVrR7iOvNs4FCDgCoEhW+6ngDEHFCFGtoF8YQKepks/8+ i9VSx6zgy/MkRmg==
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
[ Conflicts in pm_netlink.c because commit 12a18341b5c3 ("mptcp: send
  ADD_ADDR echo before create subflows") is not present in this version,
  and it changes the context, but not the block that needs to be moved.
  Conflicts in the selftests, because many features modifying the whole
  file have been added later, e.g. commit ae7bd9ccecc3 ("selftests:
  mptcp: join: option to execute specific tests"). The same
  modifications have been reported to the old code: simply moving one
  line, and changing the limits. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c                          | 16 ++++++++++------
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  4 ++--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d78ef96a88cc..7b312aa03e6b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -608,6 +608,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	struct mptcp_addr_info remote;
 	unsigned int subflows_max;
 	bool reset_port = false;
+	bool sf_created = false;
 	int i, nr;
 
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
@@ -632,16 +633,19 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
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
 
+	if (sf_created) {
+		msk->pm.add_addr_accepted++;
+		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
+		    msk->pm.subflows >= subflows_max)
+			WRITE_ONCE(msk->pm.accept_addr, false);
+	}
+
 	/* be sure to echo exactly the received address */
 	if (reset_port)
 		remote.port = 0;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3cf4f9f05956..e725285298a0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1306,10 +1306,10 @@ remove_tests()
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	# broadcast IP: no packet for this address will be received on ns1
 	ip netns exec $ns1 ./pm_nl_ctl add 224.0.0.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove invalid addresses" 1 1 1
 	chk_add_nr 3 3
-- 
2.43.0


