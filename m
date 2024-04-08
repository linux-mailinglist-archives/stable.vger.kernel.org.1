Return-Path: <stable+bounces-36834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672BE89C1F8
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993D91C21CA3
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABB6762DA;
	Mon,  8 Apr 2024 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xNR60mk/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE4171753;
	Mon,  8 Apr 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582478; cv=none; b=s7xzDUHYGD8S9IOcEH/RYxe5YkmZjaYhcVcIYVDTFlcZYJmenOmp+Kq4T95B5/dVuXS8z+GtK7vBpUQUVjpQ1CaoByAwvXU0ruyuEU4z2o3+blPg85tfjVHpFgag7Wlhj9dp2Ir9j//IhRjuegXEZu4xkgFBcCyk4AvKXNxPo0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582478; c=relaxed/simple;
	bh=ZQKdvOofL3G1KLw7+/yM1IAMrxtbBAWSdG7JN6TCWJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0JJ1h7p9TOXSNYuaQHXqVjOznN962i0jtvdispVvRLhbeeo932rrpTcLvczGsjWXCVMEDGiyO8Vz1H897LVo5+e2e9bZLIWENQIOKkWqW+MrH8ZHkMG338xl3XoS53e+ieiGArtFIANastc1tgP1GueLb/CCazBRV2dqfT0Jmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xNR60mk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA94C433C7;
	Mon,  8 Apr 2024 13:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582477;
	bh=ZQKdvOofL3G1KLw7+/yM1IAMrxtbBAWSdG7JN6TCWJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xNR60mk/wWqeKIhaC7ggGh9I0j/zPIJqScFemQN4HQ2TlO8znX+l9X680R1sOG8ap
	 44HhbW5/CRzmATt3wsa/i1oa8zFlx/5l5gOb1r9tIe4nmgWiM5HoJbfMBpxZcQhYif
	 f+YDUcrCmqX3Om2f9yxpZTG69yAQb3lOhc+Aj0pY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 6.6 096/252] netfilter: nf_tables: Fix potential data-race in __nft_flowtable_type_get()
Date: Mon,  8 Apr 2024 14:56:35 +0200
Message-ID: <20240408125309.632858480@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
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

From: Ziyang Xuan <william.xuanziyang@huawei.com>

commit 24225011d81b471acc0e1e315b7d9905459a6304 upstream.

nft_unregister_flowtable_type() within nf_flow_inet_module_exit() can
concurrent with __nft_flowtable_type_get() within nf_tables_newflowtable().
And thhere is not any protection when iterate over nf_tables_flowtables
list in __nft_flowtable_type_get(). Therefore, there is pertential
data-race of nf_tables_flowtables list entry.

Use list_for_each_entry_rcu() to iterate over nf_tables_flowtables list
in __nft_flowtable_type_get(), and use rcu_read_lock() in the caller
nft_flowtable_type_get() to protect the entire type query process.

Fixes: 3b49e2e94e6e ("netfilter: nf_tables: add flow table netlink frontend")
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8167,11 +8167,12 @@ static int nft_flowtable_parse_hook(cons
 	return err;
 }
 
+/* call under rcu_read_lock */
 static const struct nf_flowtable_type *__nft_flowtable_type_get(u8 family)
 {
 	const struct nf_flowtable_type *type;
 
-	list_for_each_entry(type, &nf_tables_flowtables, list) {
+	list_for_each_entry_rcu(type, &nf_tables_flowtables, list) {
 		if (family == type->family)
 			return type;
 	}
@@ -8183,9 +8184,13 @@ nft_flowtable_type_get(struct net *net,
 {
 	const struct nf_flowtable_type *type;
 
+	rcu_read_lock();
 	type = __nft_flowtable_type_get(family);
-	if (type != NULL && try_module_get(type->owner))
+	if (type != NULL && try_module_get(type->owner)) {
+		rcu_read_unlock();
 		return type;
+	}
+	rcu_read_unlock();
 
 	lockdep_nfnl_nft_mutex_not_held();
 #ifdef CONFIG_MODULES



