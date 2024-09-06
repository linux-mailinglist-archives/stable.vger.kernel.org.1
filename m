Return-Path: <stable+bounces-73730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CB396EE16
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0064B21250
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ABD14A09C;
	Fri,  6 Sep 2024 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rP9tQihe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE5245BE3;
	Fri,  6 Sep 2024 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611413; cv=none; b=gkBXp2hSXmAbgR3zcWksjfRBxS8/WIHD7R6ivHMcC3UzIqcNr9NpZ22FAR6TPPeHKj6q5XO3m0h9r18Y0IRYhfTQzYTFPZ6K+FqlO2k7vMC/JUpY6kYAppglIcz20kf2zVOon3KrSnqqrS6jWNRDGW9+/SCY5na5GDs0ry3NWWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611413; c=relaxed/simple;
	bh=Nlwqfuy+i8iMAMg/j4j/5DiveAwkVlPn3sYt3htU9ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8v94q5z1sGbzEFEJwC53why2id9RVqBa8Gnlu4v4zZVK9xiTi1S1DDo+CqKC0nXnvKkQCPuy2EUsss9p3E6IetYUtZoe3XIUkqW9VC2kQB7X+a2GjE6gZblkzrCHx6iD7GWf1KaGT785wvb5bPTgpnvr/spEfgUQFmjBMkY9+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rP9tQihe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604E0C4CEC4;
	Fri,  6 Sep 2024 08:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725611412;
	bh=Nlwqfuy+i8iMAMg/j4j/5DiveAwkVlPn3sYt3htU9ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rP9tQihe0YIQOr9CVfpsI0SQw1H+U/Z6/IWd6q+g8wGU1u5BXtCQFUqW+/ZoW/wPN
	 fqRqZL5/Njc6Va/fe55dLy2opUiGuvW7pD4mNRTGv+G0gqOFlVn8GRp/EyEtpgvOlc
	 EL6Tdbl3LgefPAZp39KP5vFcGwsxCTOUc8HKqotAW2Wob25llIXqnoH/2jQdByBQHe
	 iq+yQk363+ga2PGvFqsu6x2lJ62In+vqQ4DRnYpVJ6uqxn4jMScactgn+PscicoNsK
	 bt+drEkKB9rOEoWONIO9I6W4iQ0AL/2lJhUyEAalo100tYV3MyT4U5IVWr/rkKUZHr
	 gpHuqS9n4LcUw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mptcp: pm: only decrement add_addr_accepted for MPJ req
Date: Fri,  6 Sep 2024 10:30:01 +0200
Message-ID: <20240906083000.1766120-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082652-polka-escapist-f8f8@gregkh>
References: <2024082652-polka-escapist-f8f8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2880; i=matttbe@kernel.org; h=from:subject; bh=Nlwqfuy+i8iMAMg/j4j/5DiveAwkVlPn3sYt3htU9ac=; b=kA0DAAgB9reCT0JpoHMByyZiAGbavYij6cuBSdqniqNx40sMoIPAEidHh3k5lZ1h2E8f9kXxA 4kCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJm2r2IAAoJEPa3gk9CaaBz4KEQAKWi 3NCs2T7VDOhQKuXrTra5pWu6i8bWjjf/CnvWYK1Z6pOjuatX5m0FzDTSqON+qCasAp4mWxlu7Tg GY/kpMtUOeLFU5WFwItCMo+/kG7uVHYcWWApA2FDTPXqff1Bc432U+jeXKon8FKXJyZaMx3b2Bs RVMenx/6z18XM0XBnI+AwXhr0MZ+9kzNY6PyhgALXmbHBVBYpUXETc7p4DayM5hRGzRVVUXFFxn 5WxVTtGc+0ARziS0j9lH15QJglNS1534kQ2A68RJOaf7B+or8zgAOlzbv5jNLxYApkbrOhxvOvO hTa/1v7+RMvbu6qfiz33618f/+CikYYozaqmPlzPJHazD6F7ggIZ7rLo0ejfeMCLaoS/6m0YkDT VXinLIRKurfnHvGLzuCEppkeMedJfQER/msHk5hI8Aah1bCBvJzOLQYJAg0UK1WZKkc6EtyBVf/ yD7MV15fvvjy0vtdDzpy5m8Zi/ok34wc/5o0NWQaOnSsiQ9aQqc8KDuNKCIRnKq8ajnucaVj5x6 M1etfT8g1X2kXSSDDBrw31IKym9gNmWZmZob4m2u6lPaule/GycNXkjzxdWi8DrKSXKwWMlO59K mBwUVXWJETEDzazVCxfmp72PZlOoByAOjB0ohI2dPj1jeN63nwXr3XnzvIGJFh7kDXxv0VlwS0S GFajU
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 1c1f721375989579e46741f59523e39ec9b2a9bd upstream.

Adding the following warning ...

  WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)

... before decrementing the add_addr_accepted counter helped to find a
bug when running the "remove single subflow" subtest from the
mptcp_join.sh selftest.

Removing a 'subflow' endpoint will first trigger a RM_ADDR, then the
subflow closure. Before this patch, and upon the reception of the
RM_ADDR, the other peer will then try to decrement this
add_addr_accepted. That's not correct because the attached subflows have
not been created upon the reception of an ADD_ADDR.

A way to solve that is to decrement the counter only if the attached
subflow was an MP_JOIN to a remote id that was not 0, and initiated by
the host receiving the RM_ADDR.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-9-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_netlink.c, because the context is different, but the
  same lines can still be modified. The conflicts are due to commit
  4d25247d3ae4 ("mptcp: bypass in-kernel PM restrictions for non-kernel
  PMs") and commit a88c9e496937 ("mptcp: do not block subflows creation
  on errors"), adding new features and not present in this version.
  Note that because some features to better track subflows are missing
  in this version, it is required to remove the WARN_ON, because the
  counter could be 0 in some cases. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index fc1c983dc0d2..eeda20ec161c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -757,7 +757,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			mptcp_close_ssk(sk, ssk, subflow);
 			spin_lock_bh(&msk->pm.lock);
 
-			removed = true;
+			removed |= subflow->request_join;
 			msk->pm.subflows--;
 			if (rm_type == MPTCP_MIB_RMSUBFLOW)
 				__MPTCP_INC_STATS(sock_net(sk), rm_type);
@@ -767,7 +767,11 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		if (!removed)
 			continue;
 
-		if (rm_type == MPTCP_MIB_RMADDR) {
+		if (rm_type == MPTCP_MIB_RMADDR && rm_list->ids[i] &&
+		    msk->pm.add_addr_accepted != 0) {
+			/* Note: if the subflow has been closed before, this
+			 * add_addr_accepted counter will not be decremented.
+			 */
 			msk->pm.add_addr_accepted--;
 			WRITE_ONCE(msk->pm.accept_addr, true);
 		} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
-- 
2.45.2


