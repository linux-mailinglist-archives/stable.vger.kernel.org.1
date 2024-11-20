Return-Path: <stable+bounces-94290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79E59D3C10
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D84F0B2AD31
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEED19F41C;
	Wed, 20 Nov 2024 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qEvqM6fC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B56A1B4F13;
	Wed, 20 Nov 2024 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107618; cv=none; b=fyRfp1CujvXUkyF/1iotbFDWS89moq5yqJaUm4P3pgX446dFopXkREQHwrFB0+HjgffvmHoKVuY7EZMkRIZm8F8bs4qQ7oLkUXb2XSTaDx0xowyLtX34++4wFJFBJxNOevUunuishnWCkKwaAmztU/HVlcFYLAnSqFIpHfiEH0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107618; c=relaxed/simple;
	bh=fsOq2AROUmiuj7yMot+13OdaKrXDFpouQnpRRG0GaAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlwILTN2uylAGqmE1DBUoMAsZWJlod3oZU3Dm6jSwRyQduEjWqBtXDxNPPNrPwxwp4Tp8VnqlnQplESfLoCNI7aZ04KAmPCzODugvMklw1gOnklj84hAt0z/NqchEC3p4jhIXAp+O4/toblY3Hcjji0vqpKf0mAHjPElkqQQc58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qEvqM6fC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21DEC4CECD;
	Wed, 20 Nov 2024 13:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732107617;
	bh=fsOq2AROUmiuj7yMot+13OdaKrXDFpouQnpRRG0GaAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qEvqM6fCbk+apB/2wrwjfdkSWDO6HBwki0Ab7+qCcsPbfF291p5WrndhfrPNxUa01
	 0lXpo3KrNwFmRdhezBNmNDT9mcIMluCmuBMlJ0cdnRER1LEOuygbHXvGMZrifM1awY
	 4Pd9WJnlS/530UM1rtaZUlJOl9qltVtHSgIlf58Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 70/82] mptcp: drop lookup_by_id in lookup_addr
Date: Wed, 20 Nov 2024 13:57:20 +0100
Message-ID: <20241120125631.187094903@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120125629.623666563@linuxfoundation.org>
References: <20241120125629.623666563@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geliang Tang <tanggeliang@kylinos.cn>

commit af250c27ea1c404e210fc3a308b20f772df584d6 upstream.

When the lookup_by_id parameter of __lookup_addr() is true, it's the same
as __lookup_addr_by_id(), it can be replaced by __lookup_addr_by_id()
directly. So drop this parameter, let __lookup_addr() only looks up address
on the local address list by comparing addresses in it, not address ids.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-4-c436ba5e569b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: db3eab8110bc ("mptcp: pm: use _rcu variant under rcu_read_lock")
[ Conflicts in pm_netlink.c, because commit 6a42477fe449 ("mptcp: update
  set_flags interfaces") is not in this version, and causes too many
  conflicts when backporting it. The conflict is easy to resolve: addr
  is a pointer here here in mptcp_pm_nl_set_flags(), the rest of the
  code is the same. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -521,15 +521,12 @@ __lookup_addr_by_id(struct pm_nl_pernet
 }
 
 static struct mptcp_pm_addr_entry *
-__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
-	      bool lookup_by_id)
+__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if ((!lookup_by_id &&
-		     mptcp_addresses_equal(&entry->addr, info, entry->addr.port)) ||
-		    (lookup_by_id && entry->addr.id == info->id))
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}
 	return NULL;
@@ -560,7 +557,7 @@ static void mptcp_pm_create_subflow_or_s
 
 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr, false);
+		entry = __lookup_addr(pernet, &mpc_addr);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;
@@ -2064,7 +2061,8 @@ int mptcp_pm_nl_set_flags(struct net *ne
 	}
 
 	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr(pernet, &addr->addr, lookup_by_id);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr->addr.id) :
+			       __lookup_addr(pernet, &addr->addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;



