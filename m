Return-Path: <stable+bounces-256836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /qLKGmcnGmqu1wgAu9opvQ
	(envelope-from <stable+bounces-256836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 01:55:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA72B609FBE
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 01:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EBE53037469
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 23:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6147344D92;
	Fri, 29 May 2026 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sd/xGbxx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8656230C35C
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780098916; cv=none; b=hEf0d5eKA47UvHwUkjuvTIKWz15wW20+VD2WIqEtzQ0Dvo9Ng1eYZ9aIWRuh8l1bugPhRIjNkNK4aQy1jrEIdPZblOgibBdXJ3YMvhoBRkgOO9t3Dr6o7u20YUP4j9/qIiaq6DV8Zf9mugjLS1LYw0z2qtroe8JMxxOb4hUKCdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780098916; c=relaxed/simple;
	bh=5J5POAr9ejTdlLjy1DQfPQE22wUR/8PpRfKHnnYpQUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbUBCOyNZ1vCDOvltSEB6AH/ijmKn16EqNG+MC/vQ4vPtpxou5oFVuOG0oxsqQJTIhCdDmIF0FdP7cjqI6zjd0Avas+ZajOwXRXP0nGKy9ZmqC6bpXGPqxAybx/9GzOikMymNYV2KEgmGJKGDMMUS+59+9xWrgR8F884NZD56Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sd/xGbxx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FB21F00893;
	Fri, 29 May 2026 23:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780098915;
	bh=cnLfbRCfs/OAg+OvCFYW/qAe72x0q5dTfktLtn0KTfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sd/xGbxxoHzmUYnOLDeZB8MywgsebEO3Zy2cOnXQ5KrDej3LZeBqcK4WakStxY9qO
	 71vdAulP6fWbXIuPSx0agIj99keYzIuaQY6Fa6tiw4LSm4QG6pMgit/c7uzBbnV2cn
	 KVs9BOe97Bh+WKLJ+sKvlXATLkCqrpw7P3Si3Une66InThTa9mNBtDJKkAop3u9L1C
	 pWY7KZTXrZSfSUzaOhUB9/ZyLxoUMl+TrOZQ84stHp6UtS+SnXFxiNdjDA9vE5ugp0
	 soHftDU1zXYrI/Y5uK+zr8XBHHfL6y2cnenWT/pzojExCgbYluFVna74FNhP00PuFZ
	 0vR1PmD1cfGWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net: hsr: defer node table free until after RCU readers
Date: Fri, 29 May 2026 19:55:12 -0400
Message-ID: <20260529235512.1985956-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052840-statistic-envoy-e450@gregkh>
References: <2026052840-statistic-envoy-e450@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256836-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BA72B609FBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit aaec7096f9961eb223b5b149abe9495525c205d9 ]

HSR node-list and node-status generic-netlink operations run under
rcu_read_lock(). They walk hsr->node_db through hsr_get_next_node() and
hsr_get_node_data(), but RTM_DELLINK teardown removes the same node table
with plain list_del() and frees each node immediately.

That lets a generic-netlink reader hold a struct hsr_node pointer across
hsr_dellink(). In a KASAN build, widening the reader window after
hsr_get_next_node() obtains the node reproduces a slab-use-after-free
when the reader copies node->macaddress_A; the freeing stack is
hsr_del_nodes() from hsr_dellink().

Use list_del_rcu() and defer the free through the existing
hsr_free_node_rcu() callback. This matches the lifetime rule used by the
HSR prune paths, which already delete nodes with list_del_rcu() and
call_rcu().

Fixes: b9a1e627405d ("hsr: implement dellink to clean up resources")
Cc: stable@vger.kernel.org # v5.3+
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Link: https://patch.msgid.link/20260513233838.3064715-2-michael.bommarito@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ replaced `list_del`+`call_rcu(hsr_free_node_rcu)` with `list_del_rcu`+`kfree_rcu(node, rcu_head)` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_framereg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index e44a039e36afe..fec8dd8460568 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -121,8 +121,10 @@ void hsr_del_nodes(struct list_head *node_db)
 	struct hsr_node *node;
 	struct hsr_node *tmp;
 
-	list_for_each_entry_safe(node, tmp, node_db, mac_list)
-		kfree(node);
+	list_for_each_entry_safe(node, tmp, node_db, mac_list) {
+		list_del_rcu(&node->mac_list);
+		kfree_rcu(node, rcu_head);
+	}
 }
 
 void prp_handle_san_frame(bool san, enum hsr_port_type port,
-- 
2.53.0


