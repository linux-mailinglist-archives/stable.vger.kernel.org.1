Return-Path: <stable+bounces-52594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1744590B98E
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 20:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916EA1F225A8
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 18:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C7D197A88;
	Mon, 17 Jun 2024 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WpxYtjYv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2833A197A89
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648344; cv=none; b=qnp3eI2xgNlv5I2sPOk5i83vazTMKZElk+deRV67INGD9M2P/XjXyLVJx0J6KxbSjbzHmm1WADcEzkT/zpWzCmackH3YEeFnd6gZdkKiE+P9zVD/jKEOS4W1YZ7aXseuDWwl/svNgURHyQP3dz4nIFMuUakRb4jbWCc0UxU5kBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648344; c=relaxed/simple;
	bh=811XamsU/q/pm9Pp0inGe9YYPdaPU/toqimPpsZD6aY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZB0IWhjqslzvsPeiWeeEWqCOAb2bMobhZrOq6VVWP7MAbZ4mw7FS4y/kpaTFMRxf7//f8mz7Uchxlz3XbTYoZRHDYzk5kJhyNmXaGq+nLwGtOl0ZfSgW1P6SsjRyb1gc3qb5GOAY1/F0w0hdEcDBt8Xn7xVWp/EuzVcdj8Nzj4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WpxYtjYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A94C2BD10;
	Mon, 17 Jun 2024 18:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718648343;
	bh=811XamsU/q/pm9Pp0inGe9YYPdaPU/toqimPpsZD6aY=;
	h=Subject:To:Cc:From:Date:From;
	b=WpxYtjYvBrmPTJlmYbUzx894hSADBgDhDI594PFdaJsB/7inwXKu0ym7G/P2Q+Ue+
	 lf88c5cWFF+vptXqrKLZCGwKU5rjhtchfZGoqKspnKy5uNNp2X9Iw4wsmnbyuY7iAN
	 ABmEWFB4xwP5m0qZzDZF/nTfi6YIQcvLDnr/kSaM=
Subject: FAILED: patch "[PATCH] mptcp: pm: update add_addr counters after connect" failed to apply to 5.15-stable tree
To: liyonglong@chinatelecom.cn,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 20:18:52 +0200
Message-ID: <2024061752-crowbar-granddad-34da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 40eec1795cc27b076d49236649a29507c7ed8c2d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061752-crowbar-granddad-34da@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

40eec1795cc2 ("mptcp: pm: update add_addr counters after connect")
6a09788c1a66 ("mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID")
e571fb09c893 ("selftests: mptcp: add speed env var")
4aadde088a58 ("selftests: mptcp: add fullmesh env var")
080b7f5733fd ("selftests: mptcp: add fastclose env var")
662aa22d7dcd ("selftests: mptcp: set all env vars as local ones")
9e9d176df8e9 ("selftests: mptcp: add pm_nl_set_endpoint helper")
1534f87ee0dc ("selftests: mptcp: drop sflags parameter")
595ef566a2ef ("selftests: mptcp: drop addr_nr_ns1/2 parameters")
0c93af1f8907 ("selftests: mptcp: drop test_linkfail parameter")
be7e9786c915 ("selftests: mptcp: set FAILING_LINKS in run_tests")
4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
ae947bb2c253 ("selftests: mptcp: join: skip Fastclose tests if not supported")
d4c81bbb8600 ("selftests: mptcp: join: support local endpoint being tracked or not")
4a0b866a3f7d ("selftests: mptcp: join: skip test if iptables/tc cmds fail")
0c4cd3f86a40 ("selftests: mptcp: join: use 'iptables-legacy' if available")
6c160b636c91 ("selftests: mptcp: update userspace pm subflow tests")
48d73f609dcc ("selftests: mptcp: update userspace pm addr tests")
8697a258ae24 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 40eec1795cc27b076d49236649a29507c7ed8c2d Mon Sep 17 00:00:00 2001
From: YonglongLi <liyonglong@chinatelecom.cn>
Date: Fri, 7 Jun 2024 17:01:50 +0200
Subject: [PATCH] mptcp: pm: update add_addr counters after connect

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

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 766a8409fa67..ea9e5817b9e9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -677,6 +677,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
 	unsigned int subflows_max;
+	bool sf_created = false;
 	int i, nr;
 
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
@@ -704,15 +705,18 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	if (nr == 0)
 		return;
 
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
index aea314d140c9..108aeeb84ef1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2249,10 +2249,10 @@ remove_tests()
 	if reset "remove invalid addresses"; then
 		pm_nl_set_limits $ns1 3 3
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 flags signal
-		pm_nl_set_limits $ns2 3 3
+		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+		pm_nl_set_limits $ns2 2 2
 		addr_nr_ns1=-3 speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1


