Return-Path: <stable+bounces-226808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPc9CSeUuWkJKwIAu9opvQ
	(envelope-from <stable+bounces-226808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:49:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD4F2B02BF
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 461BE3101072
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B4036606E;
	Tue, 17 Mar 2026 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zxvGa7NJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B2F377579;
	Tue, 17 Mar 2026 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768275; cv=none; b=YFuSMzJ1COFNwEGlaciemsn6/Fp/JuKa2YLuHqI5XjY+mj9TlYQMr4512GEd5QRSI8WD4heGAH+JLKdRShYgvK708rut6TgKZWZE9/BGHXGRttdFkxWRRVOF6nqVCcB55lB/OGsH+u1Hund+mOJnb6atIBWrBstbaL7F8NYwn7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768275; c=relaxed/simple;
	bh=3ZmH0BBfzw7+W9uNmkZ3W8VZOjDnT5pqCBPdcMwMY5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikMJzJIuMKyiGERYdbztNMw7fFx+d45ztnT82AcVsd3JocZAhekjePx71hIo9e19vVN2lzcVxI/s4AWfT+fBHxOjmiEfHdVqtF66Qi+RHECRnwQMa2+O5SvpReO2OiK+le/sIa/uNiedmFAEaHp7sPmDenuCpdxoehNylOH9Vo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zxvGa7NJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC57C2BCB0;
	Tue, 17 Mar 2026 17:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768275;
	bh=3ZmH0BBfzw7+W9uNmkZ3W8VZOjDnT5pqCBPdcMwMY5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zxvGa7NJlW41gfQyMH/jnRF6wspGUh9JsqVi/FiDQ6gE7pLJQsyafrYUINSUCv3+6
	 +LRBUXcEmBxCULWSTFkqhkIH+6Xl2K66+dTn6/OwDYl3cH88Gg5Hgl1TL4UomnWLNq
	 KG1S65dHdpwUn2Rghnqcd5GQDvbHKDpnxrxfotgU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mehul Rao <mehulrao@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 246/333] net: nexthop: fix percpu use-after-free in remove_nh_grp_entry
Date: Tue, 17 Mar 2026 17:34:35 +0100
Message-ID: <20260317163008.489019624@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,google.com,nvidia.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226808-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 2FD4F2B02BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mehul Rao <mehulrao@gmail.com>

commit b2662e7593e94ae09b1cf7ee5f09160a3612bcb2 upstream.

When removing a nexthop from a group, remove_nh_grp_entry() publishes
the new group via rcu_assign_pointer() then immediately frees the
removed entry's percpu stats with free_percpu(). However, the
synchronize_net() grace period in the caller remove_nexthop_from_groups()
runs after the free. RCU readers that entered before the publish still
see the old group and can dereference the freed stats via
nh_grp_entry_stats_inc() -> get_cpu_ptr(nhge->stats), causing a
use-after-free on percpu memory.

Fix by deferring the free_percpu() until after synchronize_net() in the
caller. Removed entries are chained via nh_list onto a local deferred
free list. After the grace period completes and all RCU readers have
finished, the percpu stats are safely freed.

Fixes: f4676ea74b85 ("net: nexthop: Add nexthop group entry stats")
Cc: stable@vger.kernel.org
Signed-off-by: Mehul Rao <mehulrao@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20260306233821.196789-1-mehulrao@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/nexthop.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2005,7 +2005,8 @@ static void nh_hthr_group_rebalance(stru
 }
 
 static void remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
-				struct nl_info *nlinfo)
+				struct nl_info *nlinfo,
+				struct list_head *deferred_free)
 {
 	struct nh_grp_entry *nhges, *new_nhges;
 	struct nexthop *nhp = nhge->nh_parent;
@@ -2065,8 +2066,8 @@ static void remove_nh_grp_entry(struct n
 	rcu_assign_pointer(nhp->nh_grp, newg);
 
 	list_del(&nhge->nh_list);
-	free_percpu(nhge->stats);
 	nexthop_put(nhge->nh);
+	list_add(&nhge->nh_list, deferred_free);
 
 	/* Removal of a NH from a resilient group is notified through
 	 * bucket notifications.
@@ -2086,6 +2087,7 @@ static void remove_nexthop_from_groups(s
 				       struct nl_info *nlinfo)
 {
 	struct nh_grp_entry *nhge, *tmp;
+	LIST_HEAD(deferred_free);
 
 	/* If there is nothing to do, let's avoid the costly call to
 	 * synchronize_net()
@@ -2094,10 +2096,16 @@ static void remove_nexthop_from_groups(s
 		return;
 
 	list_for_each_entry_safe(nhge, tmp, &nh->grp_list, nh_list)
-		remove_nh_grp_entry(net, nhge, nlinfo);
+		remove_nh_grp_entry(net, nhge, nlinfo, &deferred_free);
 
 	/* make sure all see the newly published array before releasing rtnl */
 	synchronize_net();
+
+	/* Now safe to free percpu stats — all RCU readers have finished */
+	list_for_each_entry_safe(nhge, tmp, &deferred_free, nh_list) {
+		list_del(&nhge->nh_list);
+		free_percpu(nhge->stats);
+	}
 }
 
 static void remove_nexthop_group(struct nexthop *nh, struct nl_info *nlinfo)



