Return-Path: <stable+bounces-252926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFhzEcr/DWp+5QUAu9opvQ
	(envelope-from <stable+bounces-252926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:39:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A51596E3C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D266C3173E65
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8202E342CB3;
	Wed, 20 May 2026 18:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zq/dmYU6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3904D17A2FC;
	Wed, 20 May 2026 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301952; cv=none; b=dmg7duRYwEtpH9gxQl3fDE98scxrWDIVgX6rqW7FP56DNllFLPr/jwfPB/cR/wKGXq8snBym2BCGYqWqwD9g0xMTgoF6eKPWNWstDwkkuNlL5YyC1heyq/qC2c0KeZIccjTozktY5YbCu4QydGHHNSN2R0kdBd28JOqYwleohAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301952; c=relaxed/simple;
	bh=jVlvgMqMZu4Nl3mCrgrXVgV0kBdQzeabY0/B8Qeihrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4/lpiiefY5L+sKCCl+9vb5PBv9yh15Yh8BqZND60oZOY0XxA8smbt76rzLCzWF7ahozt7RwnF0LmfB+aOAeCmmY+ozAdN9fYtzQ8o9jzLq8nsy8mtEgpjonvZTV6gWmKT/rBUBrk/2rUPPocCfn349Z/VALRJItOEbWgkwENjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zq/dmYU6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFED1F000E9;
	Wed, 20 May 2026 18:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301951;
	bh=3sEdDdUp+fHU4yL3t0MmHsY5bXZWLcy2VllCE1NyLrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zq/dmYU6PG0CWvG/xWWUYi+wkahujM0m1mUEb/rmISxtFlPqRM444LK2l9m5rumpZ
	 3l2upo4Z0PCKNuEj+khxjxk5lDAPPxrzqbtaKBhTHxMMWQLEE45rgToiej17wxsR8o
	 xMSYrZjJYe6DZWqOq1vnSY7suURJmGas1WQZKCW4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Carlier <devnexen@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 040/508] bpf: Use RCU-safe iteration in dev_map_redirect_multi() SKB path
Date: Wed, 20 May 2026 18:17:43 +0200
Message-ID: <20260520162059.461910515@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-252926-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: D1A51596E3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Carlier <devnexen@gmail.com>

[ Upstream commit 8ed82f807bb09d2c8455aaa665f2c6cb17bc6a19 ]

The DEVMAP_HASH branch in dev_map_redirect_multi() uses
hlist_for_each_entry_safe() to iterate hash buckets, but this function
runs under RCU protection (called from xdp_do_generic_redirect_map()
in softirq context). Concurrent writers (__dev_map_hash_update_elem,
dev_map_hash_delete_elem) modify the list using RCU primitives
(hlist_add_head_rcu, hlist_del_rcu).

hlist_for_each_entry_safe() performs plain pointer dereferences without
rcu_dereference(), missing the acquire barrier needed to pair with
writers' rcu_assign_pointer(). On weakly-ordered architectures (ARM64,
POWER), a reader can observe a partially-constructed node. It also
defeats CONFIG_PROVE_RCU lockdep validation and KCSAN data-race
detection.

Replace with hlist_for_each_entry_rcu() using rcu_read_lock_bh_held()
as the lockdep condition, consistent with the rcu_dereference_check()
used in the DEVMAP (non-hash) branch of the same functions. Also fix
the same incorrect lockdep_is_held(&dtab->index_lock) condition in
dev_map_enqueue_multi(), where the lock is not held either.

Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20260320072645.16731-1-devnexen@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/devmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 3939221bd6098..c169f0624e100 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -642,7 +642,7 @@ int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
 		for (i = 0; i < dtab->n_buckets; i++) {
 			head = dev_map_index_hash(dtab, i);
 			hlist_for_each_entry_rcu(dst, head, index_hlist,
-						 lockdep_is_held(&dtab->index_lock)) {
+						rcu_read_lock_bh_held()) {
 				if (!is_valid_dst(dst, xdpf))
 					continue;
 
@@ -724,7 +724,6 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
 	struct bpf_dtab_netdev *dst, *last_dst = NULL;
 	int excluded_devices[1+MAX_NEST_DEV];
 	struct hlist_head *head;
-	struct hlist_node *next;
 	int num_excluded = 0;
 	unsigned int i;
 	int err;
@@ -764,7 +763,7 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
 	} else { /* BPF_MAP_TYPE_DEVMAP_HASH */
 		for (i = 0; i < dtab->n_buckets; i++) {
 			head = dev_map_index_hash(dtab, i);
-			hlist_for_each_entry_safe(dst, next, head, index_hlist) {
+			hlist_for_each_entry_rcu(dst, head, index_hlist, rcu_read_lock_bh_held()) {
 				if (is_ifindex_excluded(excluded_devices, num_excluded,
 							dst->dev->ifindex))
 					continue;
-- 
2.53.0




