Return-Path: <stable+bounces-261506-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LNvNGz9LJWo7GQIAu9opvQ
	(envelope-from <stable+bounces-261506-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:43:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A0B64FF0C
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:43:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=uuje+aG0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261506-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261506-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E731D3037EC4
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E41328610;
	Sun,  7 Jun 2026 10:40:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144D32C1595;
	Sun,  7 Jun 2026 10:40:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828815; cv=none; b=sbNQwlxq99RqAaDahvnHjECXp+0JsCkMrB3ODZG1QOx2TBanc3BNDWs7o3mF+BTZ6DbV6/mdJ1Anpcve6av8NQo1vfS7QP4ViTNCrOuVrIiw8Zhn1DG4vi75wh/Cqdkz+BRohsEVaPiQc4NWW9Rr/tYJwdPzzFIif3BRu3CkNMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828815; c=relaxed/simple;
	bh=LR6Xk/b89tTZZVTPJBX7vlUHWtEpi391mZP/MUVDN6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeUwhMkS+78mxP1bDW6Z7hinM2vTfvlKtMa0Wo85s5W33/uhw/z34YEQimkXH0ydbS/HRNYqkdbZLiuPZo8rCgEHhTUlAjctXRNK4UJZIu+7OiWDwilFZbToLmDl3SKR3pRz3ZB4u4LVisv1mErwvM/zuiD86fURlLK87rQfcWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uuje+aG0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD561F00893;
	Sun,  7 Jun 2026 10:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828814;
	bh=DFcBprbiiw86PxxBkuMAQjAahDIPF2jsgFVWYjYmqDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uuje+aG0g55nFxTZ0/1GIxfgMNJxttAAwhXzTpLibLUOuqdI9A+VcF/sEh9vj+fQU
	 C1y41H+BF3o8fB5m6Jst1qoAnak8R4Y4aEOOKeWtt55bmAay7oY9UR9ZIw08gV87lO
	 p82+jfyL4JEgl0M/VL8Gs2ibHIjbvBpEzCgXL90c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	James Chapman <jchapman@katalix.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 193/315] l2tp: use refcount_inc_not_zero in l2tp_session_get_by_ifname
Date: Sun,  7 Jun 2026 11:59:40 +0200
Message-ID: <20260607095734.660455347@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Rspamd-Action: no action
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
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,katalix.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-261506-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:michael.bommarito@gmail.com,m:jchapman@katalix.com,m:horms@kernel.org,m:kuba@kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3A0B64FF0C

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

commit 05f95729ca844704d15e49ce14868af4b403b32b upstream.

A reader in l2tp_session_get_by_ifname() can return a pointer to a
session whose refcount has reached zero. The getter takes its
reference with plain refcount_inc(), but every other session getter
in the same file (l2tp_v2_session_get, l2tp_v3_session_get, and the
corresponding _get_next variants) uses refcount_inc_not_zero()
because the IDR/RCU lookup can race with refcount_dec_and_test() ->
l2tp_session_free() -> kfree_rcu(). The ifname getter is the only
outlier; the inconsistency was raised on-list after 979c017803c4
("l2tp: use list_del_rcu in l2tp_session_unhash").

A reader inside rcu_read_lock_bh() that matches session->ifname can
be preempted between the strcmp() and the refcount_inc(). If the
last reference drops on another CPU in that window, the reader's
refcount_inc() runs on a counter that has reached zero. refcount_t
catches the addition-on-zero, prints "refcount_t: addition on 0;
use-after-free", saturates the counter, and returns the saturated
pointer to the caller. Session memory is held live by the in-flight
RCU read section, but the kfree_rcu() callback queued from
l2tp_session_free() will free it once the grace period closes; a
caller that dereferences the returned session past that point hits
a slab-use-after-free. On PREEMPT_RT local_bh_disable() is a per-CPU
sleeping lock and the preemption window is real; on stock PREEMPT
kernels local_bh_disable() is a preempt_count increment that closes
the cross-CPU race in practice (see below).

Use refcount_inc_not_zero() and continue the list walk on failure,
matching the other session getters in the file. The ifname getter
is the only session getter in net/l2tp/ that still uses the bare
refcount_inc() pattern; this change restores file-internal
consistency. The success path is unchanged.

Fixes: abe7a1a7d0b6 ("l2tp: improve tunnel/session refcount helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: James Chapman <jchapman@katalix.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260523023423.2568972-1-michael.bommarito@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_core.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -441,12 +441,13 @@ struct l2tp_session *l2tp_session_get_by
 	idr_for_each_entry_ul(&pn->l2tp_tunnel_idr, tunnel, tmp, tunnel_id) {
 		if (tunnel) {
 			list_for_each_entry_rcu(session, &tunnel->session_list, list) {
-				if (!strcmp(session->ifname, ifname)) {
-					refcount_inc(&session->ref_count);
-					rcu_read_unlock_bh();
+				if (strcmp(session->ifname, ifname))
+					continue;
+				if (!refcount_inc_not_zero(&session->ref_count))
+					continue;
+				rcu_read_unlock_bh();
 
-					return session;
-				}
+				return session;
 			}
 		}
 	}



