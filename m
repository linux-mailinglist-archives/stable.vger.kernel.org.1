Return-Path: <stable+bounces-73737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F042D96EE2B
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDCF283990
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6245A156887;
	Fri,  6 Sep 2024 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAkje3CY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D92B14B945;
	Fri,  6 Sep 2024 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611600; cv=none; b=eGWg2JRhT4SD00MIzphCr6MGfpMBWyTB5WNX0H803jBEihAkE6K0Tol83iT62D/hK5KadD8957ld9JXK3MVax+RZMfhXLLde1woUdg9SjSYoaitdto9eQFX5DRPsAei7YXTGidOUdMpsAD3kNNI23CrJRBJRltYFnA2YVqTrpfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611600; c=relaxed/simple;
	bh=Z62n185CB0yM1UOJV4NPZIV7ZpuDWNQfXN/kIwfF5RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjwwruNtSi7bkttsMw+iTwGmhS971VKMRZhFoAVWMmrvM5MPoappuUXXQY5zARTi/lx6kubtqHgd2tc6ARRoplBAQwD+0fZFQHiad5D175X4F0gyM/Qq5cgzl71xhpoCjxicz1urDwdmlVZRaZQ1lj6KzlWybEO1eCRrppzyu/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAkje3CY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77869C4CEC4;
	Fri,  6 Sep 2024 08:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725611600;
	bh=Z62n185CB0yM1UOJV4NPZIV7ZpuDWNQfXN/kIwfF5RA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fAkje3CYby8Z9CoPqbIfgvaHumiw/RyJchGN7i5/KvG852MrK6Ukt31jRE3myfKzl
	 zX40kw/11P80EYpIj22AO543R32F/IR52mxG0cvZe5Q0ovrhIC1Y6TpRiL+lkLBx37
	 4Sy76pkFBIW+Tj/Ln2P/Xsj1unF3AO7KcsaLFqcHDeFGepmMSHo4qJnO05YhEZzLbw
	 bfCplce6i88iIF/tdldySkSmndJ1L0dKrZN0XheR2wGEtJlsNp3AGnDuvwtNUMPXZX
	 uf2zDgVDUZ1+EPKaGQcq5+9vmZ94YrTHBxlkDCtTcyDPkC+wJTvUCsPMJo23cAmDV8
	 3jSU1BEPyn6GQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] mptcp: pm: skip connecting to already established sf
Date: Fri,  6 Sep 2024 10:33:09 +0200
Message-ID: <20240906083308.1770314-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083003-chowder-scurvy-2e9c@gregkh>
References: <2024083003-chowder-scurvy-2e9c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2154; i=matttbe@kernel.org; h=from:subject; bh=Z62n185CB0yM1UOJV4NPZIV7ZpuDWNQfXN/kIwfF5RA=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2r5ETYFQ4gNottCk06UjUKphVJjw0pwvkU/pw X0+1Ar7FWqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtq+RAAKCRD2t4JPQmmg c4hTD/4oHJ0pK6Pv8IucvbcpwN5ZM4sU1NFCjR7mnaFujiUmQp1lwuVfFkpsJNqJ6XPZZ2g+FEh RYYvyfDb37V1DZLaWbrQuJkBUqM1G0yp0hYhAj3cqkYE77FQEHzSesaKCu/lO3bgYVv8NCKvMG8 1mBRAZAWmgZZKYOB7rXKqQn/wl6M4U5RWpq8u5zoV5bDvWEozFhLG16s/4qLp3tMq9hzaaAYsEu gR6dF65Mk/HfH68KQcg/dSE5t3qIJn6FXyv/3HLgYLXhv6Agii4WyR2oDxCOH/QVo2Qgxl5s61o 345OzxRiPXyRF6OAi+BPJtk3v4/0IWtRo3OKhzChsxXnhu91r5UVRUyV2pljGLzYgoT7JseOmdR cN+oANgYQXZIOzkPaIg5VAXWh9FnLQS+1p++jo3K+P+iSvordv+DjZQTEfT8foq3ztXPQBzbK84 KGIrDl8f6dIfaXlGwpS7TYkIMuAHYPfUXBWilAvXSpIzcDS+jnG0Fa8s8sprNPyjDd+e31jdElj m0DaBAFQrF6cM+pZ3sq3AkqwCrWn/AfiXX5K3Aw39vj2lf89FC2eQOFYt5XJs7tfeMNbrQfhoAw E2TkwTxskw5C27N4V5XzfgcjaKmVlT3DFRObHgPy9A0ClDaj/IvXI4LribuWIXyyVXuH+SiPfRq 9aA3FbUa3SNWsfA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit bc19ff57637ff563d2bdf2b385b48c41e6509e0d upstream.

The lookup_subflow_by_daddr() helper checks if there is already a
subflow connected to this address. But there could be a subflow that is
closing, but taking time due to some reasons: latency, losses, data to
process, etc.

If an ADD_ADDR is received while the endpoint is being closed, it is
better to try connecting to it, instead of rejecting it: the peer which
has sent the ADD_ADDR will not be notified that the ADD_ADDR has been
rejected for this reason, and the expected subflow will not be created
at the end.

This helper should then only look for subflows that are established, or
going to be, but not the ones being closed.

Fixes: d84ad04941c3 ("mptcp: skip connecting the connected address")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in pm_netlink.c, due to commit 4638de5aefe5 ("mptcp: handle
  local addrs announced by userspace PMs"), not in this version, and
  changing the context. The same fix can still be applied. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6434569e1c7f..5622dd05087c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -145,12 +145,15 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
-	struct sock_common *skc;
 
 	list_for_each_entry(subflow, list, node) {
-		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		remote_address(skc, &cur);
+		if (!((1 << inet_sk_state_load(ssk)) &
+		      (TCPF_ESTABLISHED | TCPF_SYN_SENT | TCPF_SYN_RECV)))
+			continue;
+
+		remote_address((struct sock_common *)ssk, &cur);
 		if (addresses_equal(&cur, daddr, daddr->port))
 			return true;
 	}
-- 
2.45.2


