Return-Path: <stable+bounces-270915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ixf6AwKYRmosZgsAu9opvQ
	(envelope-from <stable+bounces-270915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:55:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2907D6FAC17
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:55:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=uJGQnFab;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270915-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270915-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 717F430625D2
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA2935F8D2;
	Thu,  2 Jul 2026 16:36:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485E833A71B;
	Thu,  2 Jul 2026 16:36:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010184; cv=none; b=G9Jw8DapqBSwnW1QEHeTZZTcoFJpIg3h4yrgHEbFzxAlej1YDKsS7L7SDfzTdRhG1qVFmsD0NwUsV5fn4IMmzATFCJmtO6C4fHstqiSzB4zM3xIfpmk8KA62tAX/N8vz8BuR70plDyV2nIRF2Oi9toxz3UKvh2JSCU2e8XsYuWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010184; c=relaxed/simple;
	bh=xJZkS6XvHSFVDFEQvHqYpAqjcGQYFKMtq/oHMCh66pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzWO/jKgJhQp3KBARzG5SsmMSMv7CIkJwu+tjRKMDYbll9oRmRpqgeZCV377wm/IeIHUvS9HCbFkEhIdPVzsi7lp2jKw+8RBACeGb3IMVgfLDX3vqu0FsZRQF7SSmOIfdAqpB2G7EkK2Ks0tY1G+aL/coljFh1JZJb6b7m7w6rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uJGQnFab; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F101F000E9;
	Thu,  2 Jul 2026 16:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010182;
	bh=+lxHR5FNE+xfppGNp+8shAdFA/2p3gKoYXz2NPRKAWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uJGQnFabtNwMMbv1aVyk9JjBHw35Y4K62wPONtJfEHPTn8uLg04C06pqcrSmWj2O1
	 ymhniTByhP3L+YxFPic1dORl+fKB/v5HX/EQsQrP4vnpOOEzkpwwBr2sGbbPmlFMya
	 UeUj7BFsM5Rl17i+mAfPWY2czy8dxwIH7IR5IWbc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 013/204] eventpoll: split __ep_remove()
Date: Thu,  2 Jul 2026 18:17:50 +0200
Message-ID: <20260702155118.948184868@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270915-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:torvalds@linux-foundation.org,m:brauner@kernel.org,m:quentin.schulz@cherry.de,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cherry.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,msgid.link:url,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2907D6FAC17

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 0f7bdfd413000985de09fc39eb9efa1e091a3ce0 ]

Split __ep_remove() to delineate file removal from epoll item removal.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-2-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8f9dc2f4891ff5..1cba4ae4a076bc 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -797,6 +797,9 @@ static void ep_free(struct eventpoll *ep)
 	kfree_rcu(ep, rcu);
 }
 
+static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi, struct file *file);
+static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi);
+
 /*
  * Removes a "struct epitem" from the eventpoll RB tree and deallocates
  * all the associated resources. Must be called with "mtx" held.
@@ -808,8 +811,6 @@ static void ep_free(struct eventpoll *ep)
 static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 {
 	struct file *file = epi->ffd.file;
-	struct epitems_head *to_free;
-	struct hlist_head *head;
 
 	lockdep_assert_irqs_enabled();
 
@@ -825,8 +826,21 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 		return false;
 	}
 
-	to_free = NULL;
-	head = file->f_ep;
+	__ep_remove_file(ep, epi, file);
+	return __ep_remove_epi(ep, epi);
+}
+
+/*
+ * Called with &file->f_lock held,
+ * returns with it released
+ */
+static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi, struct file *file)
+{
+	struct epitems_head *to_free = NULL;
+	struct hlist_head *head = file->f_ep;
+
+	lockdep_assert_held(&ep->mtx);
+
 	if (hlist_is_singular_node(&epi->fllink, head)) {
 		/* See eventpoll_release() for details. */
 		WRITE_ONCE(file->f_ep, NULL);
@@ -840,6 +854,11 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 	hlist_del_rcu(&epi->fllink);
 	spin_unlock(&file->f_lock);
 	free_ephead(to_free);
+}
+
+static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
+{
+	lockdep_assert_held(&ep->mtx);
 
 	rb_erase_cached(&epi->rbn, &ep->rbr);
 
-- 
2.53.0




