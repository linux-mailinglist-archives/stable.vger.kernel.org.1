Return-Path: <stable+bounces-52671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B9490CBA5
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA7428150D
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF3B12DD92;
	Tue, 18 Jun 2024 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUDfNaN6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A050446557;
	Tue, 18 Jun 2024 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718713538; cv=none; b=oC4Vo/pAmnmn7AJpz9qWNn0ytaqlmYMlBV+C2CGoGG48eCCJXpwATx0wD51uIlqPI5y3qMlMsOjeeVLIjlSEC0KrOe+myF26EXJJafgiQag8nVdCAJZDDHo+TE/r8C2YRf+VNGSI3mxjd8DpQ9OBWtzC8UHmVPSkRMeg8nDN1QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718713538; c=relaxed/simple;
	bh=K/taICzCpokM0vVUSrILEpWuoajl2iU7quhDSghLxmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpxE+t+HD/xQCgG0t7LSm+30MJwfz7cfEOfcCGl5o+462uWG8vRRk9HzcUkNhto3QMCNaHpTuDkPbfiWcQssBkigt36ymvuZKbdn+TUEx6krfdTdvZLUJ9W4trqttEG+VrRz7KGQqxcb7ttGEYMriawVNf4HX187/pBPAztekm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUDfNaN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE26C32786;
	Tue, 18 Jun 2024 12:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718713537;
	bh=K/taICzCpokM0vVUSrILEpWuoajl2iU7quhDSghLxmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jUDfNaN6orhCykhux8jukFZAQ2w/ystIHcdJPLDd9AN6DC2gPN70PedlhGJL4miIx
	 nA7r7vBgeNhi9DiuAPuYmVoPDsGHe0s3c/kDm9CzwpLmPZc3oGTenCfw4wEpB6zWWW
	 WWpCrHGSmCpnCdAyboBm14K7++aplF0tyj4a94nWmBcb4HzQOgalJrhXpmb6RHv3zp
	 B14+go9KK3NnWss1QK1WQO01rePqy+8TnibWWhoYrvoQGxve/TUmyMNSxRro2XXq3n
	 aDCB/Gw8cC3FhrfrFD+OJALEGvKJwjvE+KnPcsBEKakLWp8gwC6czTgNYr/QtAxWwa
	 4yli7tUj4FvVg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	YonglongLi <liyonglong@chinatelecom.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y] mptcp: pm: update add_addr counters after connect
Date: Tue, 18 Jun 2024 14:25:32 +0200
Message-ID: <20240618122531.641433-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024061753-platinum-rented-6220@gregkh>
References: <2024061753-platinum-rented-6220@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4013; i=matttbe@kernel.org; h=from:subject; bh=OzV5maSS4JXB7Hq8hZnsjDw3o0e/Di0BuyP1ZVM404M=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmcXy7VNIv8gyNkUmnqggY1yo4JYQF0PEwD2cma n8BtDiDCFOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZnF8uwAKCRD2t4JPQmmg c3OHD/9F2NvKPziuNDE95Qsbq+0FjUTa/8ptbm05Vpyd9JKQ28jvYFIIjij9WqBvl8Q5NjkNN65 EYPxMw0Ys1VcpZ4Zsje9tIEVl3sfAfY3Pcba8Z1y1nQHM+d5XgvMyckBBb2XlZmYuN8O1vPnLor PRMv+BTY8erksvGtllbaLLDMLdbCo/m/VlWWunQHuy8aeOB3Rs5Nv0A5uKLL1hqg1LOltJGahfN j104RtkLLgqmuh9EJG9WEm6st9I+oFZ7Ydu8cOPcyv27a28+xB8tmGOKUi9kmUjuod193mughoH UWOE1sYQPcH6ppL+Oa6MV1yTQtUhKmV6osaLRCBK+MZgN6n1vJyPSLbdlyryf1B4Qktks+Haczu 9qTy4r+1k+WJ6uOjZxJFLAFiYZOaeRnLkXhRYDM4PRN2HqSiJ3wHmjwwyi7ez9Os8H3EyvfpXsL c1B06H5oIsY+rlr5v7tgVj4iikGZ5/B06uWXm3By3acqdUJefWOle3PwtNxAsL2Ty+6lRGOs27s RRd+idnmB2LDlx5ZeVBPDhPVqBSVzl28XCLSjfMdoNp5CG3zLcoiHtoHiutS3PluYvuUIqztKc4 v2t5AKROrPJ33cHI642DOoEDDMP499kCJ0/27HE9QBostPwsqu4T4RAHrGwuaaU1XQcqhVurgnY y5xMKqIXGDDgNig==
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
[ Conflicts in pm_netlink.c because commit 1a0d6136c5f0 ("mptcp: local
  addresses fullmesh") is not present in this version (+ others changing
  the context). To resolve the conflicts, the same block is moved later,
  and under the condition that the call to __mptcp_subflow_connect()
  didn't fail.
  The selftest modification has been dropped, because the modified test
  is not in this version. That's fine, we can test with selftests from a
  newer version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7472473605e3..452c7e21befd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -371,15 +371,12 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_addr_info remote;
 	struct mptcp_addr_info local;
+	int err;
 
 	pr_debug("accepted %d:%d remote family %d",
 		 msk->pm.add_addr_accepted, msk->pm.add_addr_accept_max,
 		 msk->pm.remote.family);
-	msk->pm.add_addr_accepted++;
 	msk->pm.subflows++;
-	if (msk->pm.add_addr_accepted >= msk->pm.add_addr_accept_max ||
-	    msk->pm.subflows >= msk->pm.subflows_max)
-		WRITE_ONCE(msk->pm.accept_addr, false);
 
 	/* connect to the specified remote address, using whatever
 	 * local address the routing configuration will pick.
@@ -391,9 +388,16 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	local.family = remote.family;
 
 	spin_unlock_bh(&msk->pm.lock);
-	__mptcp_subflow_connect((struct sock *)msk, &local, &remote);
+	err = __mptcp_subflow_connect((struct sock *)msk, &local, &remote);
 	spin_lock_bh(&msk->pm.lock);
 
+	if (!err) {
+		msk->pm.add_addr_accepted++;
+		if (msk->pm.add_addr_accepted >= msk->pm.add_addr_accept_max ||
+		    msk->pm.subflows >= msk->pm.subflows_max)
+			WRITE_ONCE(msk->pm.accept_addr, false);
+	}
+
 	mptcp_pm_announce_addr(msk, &remote, true);
 }
 
-- 
2.43.0


