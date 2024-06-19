Return-Path: <stable+bounces-54623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC6890EF18
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119711C24272
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7480314D6E4;
	Wed, 19 Jun 2024 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nNzHRPi1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233F14BF8D;
	Wed, 19 Jun 2024 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804128; cv=none; b=aYDsEeUKP1JEapfF15bP3UtcRO0bl/V1sF/pK5vMtvebAdqcjDsVmxdfrIrGtQOLAe2IOuTvKskDVaoTcVXSvTEccovqOvJoy3ftAxAkPall7EuzaPTDZ6Ob0AgBNewEE7LPw1cWBn0rnALXd7ZK7qrTG2eRPCHKlY3EDK0ntpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804128; c=relaxed/simple;
	bh=yBvuhzyTTo5MCSR4B92GBo/VtI8cInCfwPVaxiB6b+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EX6UosLDk3NaLIc4abyLG6v49H4UImY6Y1zB0zYT9pl8AeOi5exQD7yxcev+sfw0xfmT4eSku/YBtnp798bi0PPQJ+og6l9Swr26h9h0SnyJoAPtZ28REh0QY2ZO6Bn5MO+rUO0Cx3EAQlyv5uR4t+pwQgTX6AZ1UiwuuEfQgYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nNzHRPi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2D6C2BBFC;
	Wed, 19 Jun 2024 13:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718804128;
	bh=yBvuhzyTTo5MCSR4B92GBo/VtI8cInCfwPVaxiB6b+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nNzHRPi1GpL467dRVuVTPI+CyDwvFCpSBsxyP8lRdIxaIwrnC3TFcg/5b1j0PBVQ9
	 0oG9mCfsPpWjBspAkJ1dMSYnK2ldT0tZcVWKPoI5LNvqkIslZU3O7r9lkd7SzLrBkh
	 C7wdV2Yxs5e9oiUzX9+RC4Kg+6cOTQ92+AIa7iKI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	YonglongLi <liyonglong@chinatelecom.cn>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 204/217] mptcp: pm: update add_addr counters after connect
Date: Wed, 19 Jun 2024 14:57:27 +0200
Message-ID: <20240619125604.558475813@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
References: <20240619125556.491243678@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c                          |   16 ++++++++++------
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    4 ++--
 2 files changed, 12 insertions(+), 8 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -685,6 +685,7 @@ static void mptcp_pm_nl_add_addr_receive
 	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
 	unsigned int subflows_max;
+	bool sf_created = false;
 	int i, nr;
 
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
@@ -710,15 +711,18 @@ static void mptcp_pm_nl_add_addr_receive
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



