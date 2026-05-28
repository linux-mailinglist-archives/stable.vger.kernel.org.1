Return-Path: <stable+bounces-255162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN5EDDeeGGpAlggAu9opvQ
	(envelope-from <stable+bounces-255162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:57:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9848F5F785F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 692293137EF4
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14CE3403E7;
	Thu, 28 May 2026 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KpBujxB+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C233290B0;
	Thu, 28 May 2026 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998139; cv=none; b=Bz7x+HGHADQ4TpwbT9hE7x9goalENlpjJGSzuGREnOkZW0WpJyZwNb/jblDvEbr05AV2Jdh5t/vomxgzJ3sJEWXaRDHRGQSIA7KvkpwuGV8GoRyXDLJzhFND1sOMgRmJoPTjKG3T11UYf1aY/ccB9766qlSVMjapLQ9tJMDTkYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998139; c=relaxed/simple;
	bh=naBXAwCc8OLmHMlpKnVtnKz6tmFVD/GcmShII6KVKVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X64M3wJzrnhaJT7IRtCOUb3FPYTW9LmtoHXPCt4cpwMlWSpawF1mTifhDW+qN6mWNSJhwoNyvEOvCv8pGLEXKqGjafCXLqte34lww5fMU2+fUsMoPpXZ2ZhfWdvipZDIGOTBmmTg0Im34tehMAohiKyU4LCrRSHq574xj9wP5Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KpBujxB+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26971F00A3A;
	Thu, 28 May 2026 19:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998138;
	bh=ywUe7k2syKnPKJhThR1x6UhIIUAdhW4AdpPdqlhtx/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KpBujxB+vnIlIodI8CHk6GzpNdkKgduBJNL97CV5MqQYN3jVjTsDb/j/W050+Ikmb
	 ROicm/OaUKWMdUMTx2v4pH+TD7jb34Bhn7G5ljyHpnjDScXLj19UlOtK5x3GZ59riz
	 BseY5fUuGa+Vf4rqaR1oJKJtJOtTxLmg/TcpJVhI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.0 066/461] l2tp: use list_del_rcu in l2tp_session_unhash
Date: Thu, 28 May 2026 21:43:15 +0200
Message-ID: <20260528194648.831176338@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-255162-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9848F5F785F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

commit 979c017803c40829b03acd9e5236e354b7622360 upstream.

An unprivileged local user can pin a host CPU indefinitely in
l2tp_session_get_by_ifname() by issuing L2TP_CMD_SESSION_GET on
L2TP_ATTR_IFNAME concurrently with L2TP_CMD_SESSION_CREATE and
L2TP_CMD_SESSION_DELETE on the same tunnel. All three commands take
GENL_UNS_ADMIN_PERM, so CAP_NET_ADMIN in the netns user namespace
suffices; on any host that has l2tp_core loaded the trigger is
reachable from a standard `unshare -Urn` sandbox.

l2tp_session_unhash() removes a session from tunnel->session_list
with list_del_init(), but that list is walked by
l2tp_session_get_by_ifname() with list_for_each_entry_rcu() under
rcu_read_lock_bh(). list_del_init() leaves the deleted entry's
next/prev self-pointing; a reader that has loaded the entry and
then advances pos->list.next reads &session->list, container_of()s
back to the same session, and list_for_each_entry_rcu() never
reaches the list head. The CPU stays in strcmp() inside the
walker, with BH and preemption disabled, so RCU grace periods on
the host stall behind it and the wedged thread cannot be killed
(SIGKILL is delivered on syscall return).

Use list_del_rcu() to match the existing list_add_rcu() in
l2tp_session_register(); the deleted session remains visible to
in-flight walkers with consistent next/prev pointers until
kfree_rcu() in l2tp_session_free() releases it. tunnel->session_list
has exactly one list_del_init() call site; the list_del_init
(&session->clist) at l2tp_core.c:533 operates on the per-collision
list, which is not walked under RCU. list_empty(&session->list) is
not used anywhere in net/l2tp/ after the unhash point, so dropping
the post-delete self-init is safe; the fix has no userspace-visible
behavior change.

Fixes: 89b768ec2dfef ("l2tp: use rcu list add/del when updating lists")
Cc: stable@vger.kernel.org # 6.11+
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Link: https://patch.msgid.link/20260518183447.64078-1-michael.bommarito@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1360,7 +1360,7 @@ static void l2tp_session_unhash(struct l
 		spin_lock_bh(&pn->l2tp_session_idr_lock);
 
 		/* Remove from the per-tunnel list */
-		list_del_init(&session->list);
+		list_del_rcu(&session->list);
 
 		/* Remove from per-net IDR */
 		if (tunnel->version == L2TP_HDR_VER_3) {



