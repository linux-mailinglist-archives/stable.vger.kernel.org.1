Return-Path: <stable+bounces-93942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6450A9D21AD
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 09:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5FFAB22621
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 08:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A197D198A25;
	Tue, 19 Nov 2024 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doxeka68"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7F7198A17;
	Tue, 19 Nov 2024 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005371; cv=none; b=BcSbASrT4sGCGEXOvkL5jPaXBfU3qwz6IBv+dhmWn8WUyhK2Ep3eboNe4vJ3XMSVYKzX8NwDHoeu3TYtH8ai9YBJqOwQZ8Rzr4BZ9Q3S5/oCnwdqXAZqm8udo4p4ZZMICrd35g73pEJZPbRwFidwSHbte1JMQ1SJ4Rq5zoN26Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005371; c=relaxed/simple;
	bh=3AMU3wdCDVm5tVBiothvkIyHUAqsTq8A8UY0redF5Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cH8t/VVuXoMtSWgwW68q54DSQiHPBfhQvvlGwLk7OCzKjCWTu1fUhmhj3vt2BxUG7kbLd8ZS93ePvxsGHjTGz4wyESWXTc4N5m67qHAU5pzXoehELC+7JJ0pQO2vc5oBX5fOvIJEJLKm1KVoMktysXmDD7NOKp2fqSPKIuD62Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doxeka68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ABCC4CED6;
	Tue, 19 Nov 2024 08:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732005370;
	bh=3AMU3wdCDVm5tVBiothvkIyHUAqsTq8A8UY0redF5Z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=doxeka68YbwmxL66JgPGJzbu1nuwjNmbNV4DMl8ebHKnT2fUzTM2ZkjpWQe9TCyWD
	 xCx16QiNXLWf3VqkB0qRtrft1SzgBq/S2efSD41eoE8HCaqPKhUW2JgSHcOEfEweJO
	 gpTGbYUVlX5xAVKjLEPGssGpbn2n3dNAL8VTPQqXwNG/DeJetBKza94W/K5IhwWoav
	 zcX4goDBYHBHFS2HfDU0aIeOQp+5x8aYm8yim+eo8LdiTCWyx1pEjL6v9Q4R3O9EPa
	 T866z/lnvDPaTxSuw1w6fEKRIaUp8hFZysnZYcetgAxaWL5ZO5L+BaqTxxRQfraoAK
	 IKc6QX1lgbnWg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 7/7] mptcp: pm: use _rcu variant under rcu_read_lock
Date: Tue, 19 Nov 2024 09:35:55 +0100
Message-ID: <20241119083547.3234013-16-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119083547.3234013-9-matttbe@kernel.org>
References: <20241119083547.3234013-9-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=matttbe@kernel.org; h=from:subject; bh=3AMU3wdCDVm5tVBiothvkIyHUAqsTq8A8UY0redF5Z0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnPE3kpcUzql7unpgDC1+yMvbNybGpiD38BF8gM QHbIRiAgtOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzxN5AAKCRD2t4JPQmmg c5jgEADLvhabaRG2tpo+/4jChu5phYD7gxelnYKGYDsrD1TBZ+4ckhdkXExg5AjmyTi0rZeBruB B44J6TgCVBi6K6/G0hcCQbNasv2pinsqirCBBfoJ9A1dsLpbqmA6Y4uV3vEWINOkKVMFzkmXbVX cZZXV6vahXMFQUXuHHYXdIQWLB5La05DfqSU0adaxuLUOW8hnkYV4+ko/bcCNhRMrYQAVvrNRvb 5iPTKYSMXxkdz/7gCQ3xeaybQuj7ZvgJZyULShuJr2P7D6DzGRtui1mn/qzb2FJZNz97TAtbvfy VoyASV/Kx2NNWffi4WeU32iwuTC6X52WGXSl8Y1otRDU1UxuxUVK2EDzI/Xf4GvuVYD+spf82Xs +KGaHfzsPTpgO+9z/bHfSBU+AyZ2oByqw7SrNsDyNrEroZMGd/hIz25b75AvrAMVtjn3EPDhGjH heOjoZ+DjyO5fe+ZHZ3zOK0udXgF2aTa0HjIXloEJtVoZNifM1VGsMHuc+VFUpr0hpRidC53iWZ OBezT4Z15+DeBy5YCN03clzXjeUmGQ4VkIntcmuRJdjipWU1E6n2uBYeCl1d2RLo2ErjkF+jjgp 1VDxm2CHDRtWH40vCOxX16OAHSaHIaY9NKxzVwiOWBzkg2NHxcbbKnnC9V6bayx70pIa+Pwaa8j Ev656Mv/cdjjjPQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit db3eab8110bc0520416101b6a5b52f44a43fb4cf upstream.

In mptcp_pm_create_subflow_or_signal_addr(), rcu_read_(un)lock() are
used as expected to iterate over the list of local addresses, but
list_for_each_entry() was used instead of list_for_each_entry_rcu() in
__lookup_addr(). It is important to use this variant which adds the
required READ_ONCE() (and diagnostic checks if enabled).

Because __lookup_addr() is also used in mptcp_pm_nl_set_flags() where it
is called under the pernet->lock and not rcu_read_lock(), an extra
condition is then passed to help the diagnostic checks making sure
either the associated spin lock or the RCU lock is held.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241112-net-mptcp-misc-6-12-pm-v1-3-b835580cefa8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9b65d9360976..3fd7de56a30f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -529,7 +529,8 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry(entry, &pernet->local_addr_list, list) {
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
+				lockdep_is_held(&pernet->lock)) {
 		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}
-- 
2.45.2


