Return-Path: <stable+bounces-235790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OJjG/Iq22kT+AgAu9opvQ
	(envelope-from <stable+bounces-235790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 07:17:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE8B3E2D00
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 07:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3EC03014C7D
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 05:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05000277017;
	Sun, 12 Apr 2026 05:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UW5+1LiJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9ED1DE4E0
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 05:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775971055; cv=none; b=nL9wuJrgxnDWZZNHrxWWjqITQOTEV8DVLkoaKcj6RtdOTE/MqJJGUz6GH4GaNGLCL/jP7dN9yoG1lF8XxJ3za8M5+v/jU/8/bFNiFzq5l2GYgZ1ADf+IgmIiPbxyMfRykR5WqLR/TPvUnqd4uPf9hiY/rgJSa5J1PKnrpgap7eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775971055; c=relaxed/simple;
	bh=AVDtBQNstLZ20HiUsQtgX1j1YeHtNkG87qisyabwY8o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dgH+UIZhFGKwz2XD0Xub7ag4hQ4sIap16uAkT1jbWiMIX5gcfS7GP7uQf34+XIlzn8d/osIV9FDAe44yqqxjVrnSWSt4Lv3EWd9l+NYZqb6Pl+GPEtLbrxGjU9F0TeuEUoQyqfblK2L3z/Tz8XVkuRK9GdRXczULB/DTfbr64Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UW5+1LiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED038C19424;
	Sun, 12 Apr 2026 05:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775971055;
	bh=AVDtBQNstLZ20HiUsQtgX1j1YeHtNkG87qisyabwY8o=;
	h=Subject:To:Cc:From:Date:From;
	b=UW5+1LiJMHnwDVBVAiHOxn2z7fn1AIpbyn//nOgsn4+omx7rUQDSWCeYX2cy38o6O
	 +yOnsMZkghU8CbzaJLXTO+nvwJGsGtm3bOGmZkhBD0PZgfgB7CeZ49No79Gnd1achJ
	 tTVSoOtr+/SVaSRbxNfy+XfPz75HfGxEw62u/mp4=
Subject: FAILED: patch "[PATCH] Revert "mptcp: add needs_id for netlink appending addr"" failed to apply to 6.6-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 12 Apr 2026 07:17:24 +0200
Message-ID: <2026041224-kinfolk-mustiness-e33d@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235790-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ietf.org:url,msgid.link:url,gregkh:email]
X-Rspamd-Queue-Id: DBE8B3E2D00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8e2760eaab778494fc1fa257031e0e1799647f46
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026041224-kinfolk-mustiness-e33d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8e2760eaab778494fc1fa257031e0e1799647f46 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 7 Apr 2026 10:41:41 +0200
Subject: [PATCH] Revert "mptcp: add needs_id for netlink appending addr"

This commit was originally adding the ability to add MPTCP endpoints
with ID 0 by accident. The in-kernel PM, handling MPTCP endpoints at the
net namespace level, is not supposed to handle endpoints with such ID,
because this ID 0 is reserved to the initial subflow, as mentioned in
the MPTCPv1 protocol [1], a per-connection setting.

Note that 'ip mptcp endpoint add id 0' stops early with an error, but
other tools might still request the in-kernel PM to create MPTCP
endpoints with this restricted ID 0.

In other words, it was wrong to call the mptcp_pm_has_addr_attr_id
helper to check whether the address ID attribute is set: if it was set
to 0, a new MPTCP endpoint would be created with ID 0, which is not
expected, and might cause various issues later.

Fixes: 584f38942626 ("mptcp: add needs_id for netlink appending addr")
Cc: stable@vger.kernel.org
Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.2-9 [1]
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260407-net-mptcp-revert-pm-needs-id-v2-1-7a25cbc324f8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 82e59f9c6dd9..0ebf43be9939 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -720,7 +720,7 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 					     struct mptcp_pm_addr_entry *entry,
-					     bool needs_id, bool replace)
+					     bool replace)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	int ret = -EINVAL;
@@ -779,7 +779,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id && needs_id) {
+	if (!entry->addr.id) {
 find_next:
 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
 						    MPTCP_PM_MAX_ADDR_ID + 1,
@@ -790,7 +790,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id && needs_id)
+	if (!entry->addr.id)
 		goto out;
 
 	__set_bit(entry->addr.id, pernet->id_bitmap);
@@ -923,7 +923,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
 		return -ENOMEM;
 
 	entry->addr.port = 0;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true, false);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, false);
 	if (ret < 0)
 		kfree(entry);
 
@@ -977,18 +977,6 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
 	return 0;
 }
 
-static bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
-				      struct genl_info *info)
-{
-	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
-
-	if (!nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
-					 mptcp_pm_address_nl_policy, info->extack) &&
-	    tb[MPTCP_PM_ADDR_ATTR_ID])
-		return true;
-	return false;
-}
-
 /* Add an MPTCP endpoint */
 int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
@@ -1037,9 +1025,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 			goto out_free;
 		}
 	}
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
-						!mptcp_pm_has_addr_attr_id(attr, info),
-						true);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
 		goto out_free;


