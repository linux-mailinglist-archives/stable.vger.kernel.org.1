Return-Path: <stable+bounces-73733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36E496EE20
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46FCFB20B78
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B916D156887;
	Fri,  6 Sep 2024 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGe3Sp1V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AB671B3A;
	Fri,  6 Sep 2024 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611489; cv=none; b=Nidw8QBrtb2CDArPFWRDoFDL+tJLmz38NBAwQnePyZOHc0a52p3hWh2/oQgodoU7x6Mg+OelGNfVtRDJ0cw+XmbDvhyos7uxgFLeaYUDhzNAcQDXwHPHugUZabcXLh3oYgxx9TcAoCP4n1HCUNtHslAnW78WTlXXVc0mxw322uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611489; c=relaxed/simple;
	bh=8FYhV6+YmJ1MCBbQbcvZD7kXadOPieUoGu5azrcd/Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYx8qj8+QawbAwTiRkuHbLisGhIOP1vLS7lNr6yUj0ZwAjiVxREzdWsUCGuI9Q1T8qhfItM/nOZmt2tGyoGdEtoUj/z9wWJfNcs1lJ1lCCWMhxMi8LGFL/Aiazh89wMgO6uvIFLziPhQy6UpXgfpC/bx2UuyxLApYYXGwDfInOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGe3Sp1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1773C4CEC5;
	Fri,  6 Sep 2024 08:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725611489;
	bh=8FYhV6+YmJ1MCBbQbcvZD7kXadOPieUoGu5azrcd/Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGe3Sp1VAN5sgB92hxbzBVeKMthjnnx6/4Y82NZZy2gUVzbqFjp7Se4Z4xqpQSznI
	 BBXOkxyE+Dc5cI1ShVy/vH2mVXQW5f26hSEInByx7CvMzXmLgTESib/Ct+HRVgTzp7
	 SQLgZ4IoNh4WlXEDwEx4DuMTfixnbn6Ipzy2Jxoa7V/W7W0/1dXxGQYtPku0yDRRLJ
	 QBj3yAsoeF29EXN9BNmagOg3UCT+2fSl7i3mDgH/T4Ma5GAQzPV7PtUybwXzNOWa15
	 1KaSUMB1BsCj1JolKE/NaLQzvLWJZcU5HDwqWAAwgp+9kaVMmwoGijCJEYFdZL69Ej
	 pGlSjR8q2Ccsg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mptcp: pm: fullmesh: select the right ID later
Date: Fri,  6 Sep 2024 10:31:24 +0200
Message-ID: <20240906083123.1767956-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082641-cauterize-slum-9eb2@gregkh>
References: <2024082641-cauterize-slum-9eb2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3133; i=matttbe@kernel.org; h=from:subject; bh=8FYhV6+YmJ1MCBbQbcvZD7kXadOPieUoGu5azrcd/Kg=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2r3bT4XRaBjJPpb84Xh77y6s33eNIRCNcSLtZ 65BawLofB6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtq92wAKCRD2t4JPQmmg c6pPD/sGDtvhHK35KTozUVRnWXV4h42tTWasIhX3OW6qOofcet3KVQSlJ94ZNdHNwmXlz9ib85e Xla/iBqrveJTfXHMq81aqL9xRCNDeGQJsBQuuvNT/hGXWd9DCKI3PeTe2jjaWrSTYtItIqpvUl/ tA55zTPG18PFJqenUaRz+Nl7TElfyF39F+kr5BGGFKTlqd1XXp9avuiwRA6Xxxh2nZzk/csmHc2 ZgaCu72OAkxRh04QWq0KM88UlLOcaPdioZUurmxdFCesf/ZVs/tzF5PN9sqo/3yRVPmBaiuvImp pgGw6AfctFQvnbwhKQDr0RMd9UXjNj75e26A2YOYju1BjzmTW4Zvn5jnpMrEovPScJsriXo9zUG hSzgFvocPy0fMLsEPnQD4U76+WrNnIo6O/pvv688oXsaqlABDQZ9dyrmsaRXdsUn1cn5Q7n6fPj 1ovnyEMtXAbMgTkgLpT+AHTDXFzxHs+vKIhqNAvhXj4SKM4VHiEV0IyzrtkWMJgVV3kMDz6g4oO UhjGyS/Fr7/1AwQ98zs8eXlY4MHa2q0N+K22Mi1hHysCL+EJvbtKyM0MJNvt+0PTJ9RI5uuzYXc ++D4fPdbrtWrpd1fpgXz/rh8k7DFYdbg8Mk8SqyE/iugt8HKwPQL7qk3GZwdCclu7Gf7QnY+rNK LZ3GZVzsO1WgdcA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 09355f7abb9fbfc1a240be029837921ea417bf4f upstream.

When reacting upon the reception of an ADD_ADDR, the in-kernel PM first
looks for fullmesh endpoints. If there are some, it will pick them,
using their entry ID.

It should set the ID 0 when using the endpoint corresponding to the
initial subflow, it is a special case imposed by the MPTCP specs.

Note that msk->mpc_endpoint_id might not be set when receiving the first
ADD_ADDR from the server. So better to compare the addresses.

Fixes: 1a0d6136c5f0 ("mptcp: local addresses fullmesh")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-12-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_netlink.c, because the new 'mpc_addr' variable is
  added where the 'local' one was, before commit b9d69db87fb7 ("mptcp:
  let the in-kernel PM use mixed IPv4 and IPv6 addresses"), that is not
  a candidate for the backports. This 'local' variable has been moved to
  the new place to reduce the scope, and help with possible future
  backports.
  Note that addresses_equal() has been used instead of
  mptcp_addresses_equal(), renamed in commit 4638de5aefe5 ("mptcp:
  handle local addrs announced by userspace PMs"), not in this version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ceeb5fbe8d35..1914c553a9ad 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -554,7 +554,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
-	struct mptcp_addr_info local;
+	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
 	int i = 0;
@@ -562,6 +562,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
+	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
+
 	rcu_read_lock();
 	__mptcp_flush_join_list(msk);
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
@@ -580,7 +582,13 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 
 		if (msk->pm.subflows < subflows_max) {
 			msk->pm.subflows++;
-			addrs[i++] = entry->addr;
+			addrs[i] = entry->addr;
+
+			/* Special case for ID0: set the correct ID */
+			if (addresses_equal(&entry->addr, &mpc_addr, entry->addr.port))
+				addrs[i].id = 0;
+
+			i++;
 		}
 	}
 	rcu_read_unlock();
@@ -589,6 +597,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	 * 'IPADDRANY' local address
 	 */
 	if (!i) {
+		struct mptcp_addr_info local;
+
 		memset(&local, 0, sizeof(local));
 		local.family = msk->pm.remote.family;
 
-- 
2.45.2


