Return-Path: <stable+bounces-73741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB8196EE3D
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4D3283AF9
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76EC155741;
	Fri,  6 Sep 2024 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9gwl28E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9188B15278E;
	Fri,  6 Sep 2024 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611704; cv=none; b=KTaC5GE54NLSDWjxWS9nqDdqNezahyUWD+QQjMdRaRK+u91wVD4KNp+AXGEVX8wrER376D28zmeMXgK6q7olTu4ymW28s8uUBklwcn8MI0YRXsb+b0mAaGh7Nhx4Dthow1BIXuUWdF6TwybI3jnBQ9hJL7woLFGrro4WHeKnaKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611704; c=relaxed/simple;
	bh=np5NkUIgIdpg15r12EUuUFIcTkw3/SuwcViRCT3TJ5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7Oe8HJr3ZDEnQj8chtI0v0mIZ8O1gbIZwkbfpjRCJ7TrUUfndeyh6SDGp7fUniQO0MhuV9ey0aYVYBfdXyA9i1ucn+Ywxe4BxVTtXEGvndWDQGZacHBjjdIcWyf+O9octBdnfYYq73Zp7ctcTKN6O2ulklLsSRbBNDDcoKvlA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9gwl28E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DE0C4CEC8;
	Fri,  6 Sep 2024 08:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725611704;
	bh=np5NkUIgIdpg15r12EUuUFIcTkw3/SuwcViRCT3TJ5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N9gwl28Ely3Cg/Mw5k5xB9AVuOZd+GTMC9V1orGFnj1bQeykpk79GJU+hD6O1xJoo
	 Jq9Ki0JDbFocyykGqPtKB7m9X+ucAFtk0HuqP7OY+RJwhrRDBB4Z3sr7voCgWbdpd8
	 Hxk+a9O7VgQlGjhBpoKN9MdqVNtX09iWPvEM8bwV748dI1aH1OyZPQIF6oYVSV7KvR
	 khmKqmLGu2ZLhCSbDKdkyhDKMqDPqsKHppiw6jG7iDPiFbePNd5M+bfWjaUcSiroxb
	 TNkI6CGxc325JpjhaubFAIdEoP3kVDRPnlN4WjoSCTiGadJ18jR/Y4SnLH3YfttI5a
	 q/qTj+viPIbTA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] mptcp: pm: ADD_ADDR 0 is not a new address
Date: Fri,  6 Sep 2024 10:34:55 +0200
Message-ID: <20240906083454.1772761-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083024-distort-gallantly-afea@gregkh>
References: <2024083024-distort-gallantly-afea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3898; i=matttbe@kernel.org; h=from:subject; bh=np5NkUIgIdpg15r12EUuUFIcTkw3/SuwcViRCT3TJ5I=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2r6uHb3Sc75tOtcgTkA3PQs9UPZwt5d99vFnQ L7gAwcwwdKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtq+rgAKCRD2t4JPQmmg c0t/EACddKSUVYcZRdcwvpUToRLanvy10IdUEQZq38v/gUFqdyg7TLUuv9TMi30e0q+HMd9inSc QlAWRjtWQbMvc4ORx1M5JSI8sgowX6R38Mj2sPeamWRZ13KDTHPwid0Bgvo8H8alUsms0mHPvbc jQJbtemJgVfde5tREFUcfC2uovG0Swt2ItqPwVWqeLjqTeT5/CLr4nMyaqF/0p2yKJSGQ3reJ7N TBapB7kqTbbGJUsPTmXRKg/EiiOpTkZDRy/IiRFk8k8922BfM/923QRXkEppmGk/kkJRoHOXP0S YciwYYY2e9vqys6jKJl03rtL2L09F++cgapIjD8ZKe8xWkexEOJN3LZBd1LZMBrcBEDGQFS1+3b Hazrj+sDnCDYqUyf1xVhFONY6JceQrccDLk0Q6apBddhMfSLZH582euL1mddv14cc+UsRnSVo4k PavpLnRP+O0Zphbblq3bo3yNfJJ/rWH34p8KO2Yet41FB5uYV/GU0bP9jy7OIrjzkVSTzjGnR6p hGUuv6D+FAWwZuwnUKRP6JRCjXZrHAQSH+oGz7NGIGb4GiuzGzTTUzk9e2stK7yDNZEgqF/ihfp Tug8inhkLnKt5L46T5qtojst9zhWZiAZ4FD2HdZHER4Hg6j4fpXcIwmdwXvGGbALC5pVAfhJReX CYQOBwsopT14erQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 57f86203b41c98b322119dfdbb1ec54ce5e3369b upstream.

The ADD_ADDR 0 with the address from the initial subflow should not be
considered as a new address: this is not something new. If the host
receives it, it simply means that the address is available again.

When receiving an ADD_ADDR for the ID 0, the PM already doesn't consider
it as new by not incrementing the 'add_addr_accepted' counter. But the
'accept_addr' might not be set if the limit has already been reached:
this can be bypassed in this case. But before, it is important to check
that this ADD_ADDR for the ID 0 is for the same address as the initial
subflow. If not, it is not something that should happen, and the
ADD_ADDR can be ignored.

Note that if an ADD_ADDR is received while there is already a subflow
opened using the same address, this ADD_ADDR is ignored as well. It
means that if multiple ADD_ADDR for ID 0 are received, there will not be
any duplicated subflows created by the client.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in pm.c, due to commit 4d25247d3ae4 ("mptcp: bypass
  in-kernel PM restrictions for non-kernel PMs"), which is not in this
  version, and changes the context. The same fix can be applied here by
  adding the new check at the same place. Note that addresses_equal()
  has been used instead of mptcp_addresses_equal(), renamed in commit
  4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs"),
  not in this version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 4 +++-
 net/mptcp/pm_netlink.c | 9 +++++++++
 net/mptcp/protocol.h   | 2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d9111efa3c7f..b14eb6bccd36 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -189,7 +189,9 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (!READ_ONCE(pm->accept_addr)) {
+	/* id0 should not have a different address */
+	if ((addr->id == 0 && !mptcp_pm_nl_is_init_remote_addr(msk, addr)) ||
+	    (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6df7d62f6b44..932be4bc1274 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -672,6 +672,15 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	mptcp_pm_nl_addr_send_ack(msk);
 }
 
+bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *remote)
+{
+	struct mptcp_addr_info mpc_remote;
+
+	remote_address((struct sock_common *)msk, &mpc_remote);
+	return addresses_equal(&mpc_remote, remote, remote->port);
+}
+
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d940a059a8f3..9e0a5591d4e1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -742,6 +742,8 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
+bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *remote);
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
-- 
2.45.2


