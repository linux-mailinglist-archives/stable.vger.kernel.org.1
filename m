Return-Path: <stable+bounces-254762-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI4yO6j1F2ofXggAu9opvQ
	(envelope-from <stable+bounces-254762-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:58:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 097215EE270
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F60A306D0F9
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 07:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E208D334C0D;
	Thu, 28 May 2026 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xQffgp6C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E71E30F92E
	for <stable@vger.kernel.org>; Thu, 28 May 2026 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954879; cv=none; b=VyVVvPnpLxBF4A/U12zPPcuZGx56PHai89S1TiBaxA8/9mVnoi195wph7qZiZd08KMZXW0OZMy95+SxHkyYKX7Xfo8iQ7UqUwxu0p1gASjlvE+G33LEDGEKUjjDz4nYdCKzQtgbb3cJRlZ2Sz14FigYxA6kA11u1X6crw+vwJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954879; c=relaxed/simple;
	bh=u2SZyzW0WWEk+4WOQJ6aL75XiJvo8DQN1+Y6LPVwJQo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gR9ktP09FssWnQLeHTP+4QGHhucS9ctAjv8/0IvrLXOQvHdivR8SltkqROE7H0gzlZwZhVbmrEL+2+mJc868yAVPgbQ1TQRmSZsiC04aL98QvhsfqtB4rdcPH+O+d929kA5LLglHpRP2qczbXxI1FtM82N93yxhGOcpauLK1fc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xQffgp6C; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B591F000E9;
	Thu, 28 May 2026 07:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779954878;
	bh=juA4cPXpdvhoNbfbROP0lcfNCJkrJvdW6Y2892LEaCI=;
	h=Subject:To:Cc:From:Date;
	b=xQffgp6CO5RNC2CSsB4LFTSVWjQsqqO/9uYKQFV0/cAdR4rElWFmr8SCC5A3XmPwu
	 +v7HthkqYxhmk/q/f5nabRmcKMbmSKW678ytvfEiVGWbXwuR1CjIkkMtvnj2hp8+WQ
	 cpjJT2Q2S5B515hJAXxMs+cLwSaAw2IIQfpXVMzg=
Subject: FAILED: patch "[PATCH] net: hsr: defer node table free until after RCU readers" failed to apply to 6.12-stable tree
To: michael.bommarito@gmail.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 09:53:39 +0200
Message-ID: <2026052839-nickname-snuff-d391@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254762-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: 097215EE270
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x aaec7096f9961eb223b5b149abe9495525c205d9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052839-nickname-snuff-d391@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aaec7096f9961eb223b5b149abe9495525c205d9 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 13 May 2026 19:38:38 -0400
Subject: [PATCH] net: hsr: defer node table free until after RCU readers

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

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 124619920d38..b514e43766ef 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -163,8 +163,8 @@ void hsr_del_nodes(struct list_head *node_db)
 	struct hsr_node *tmp;
 
 	list_for_each_entry_safe(node, tmp, node_db, mac_list) {
-		list_del(&node->mac_list);
-		hsr_free_node(node);
+		list_del_rcu(&node->mac_list);
+		call_rcu(&node->rcu_head, hsr_free_node_rcu);
 	}
 }
 


