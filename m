Return-Path: <stable+bounces-263322-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +SwhJqUbMGoaNwUAu9opvQ
	(envelope-from <stable+bounces-263322-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:35:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 041C2687BE7
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:35:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=P5DtBwae;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263322-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263322-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BEDE305A974
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 15:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AE63D1A94;
	Mon, 15 Jun 2026 15:33:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E543D1A9F
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:33:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537632; cv=none; b=uExYLXG0GYT5N5LgQn2XYWAIcKD6wwUdWZfbuvovUkTay/sIU0sVmtkbg9Jm2x7BcdIt2ZjNtPPMj4iLbMmL7zD06tj/GFH40t+k/ztks2kBigSzvD3PLJmtYLKcIUwU0Cjh1Faxv79R0C9lOyE4Al1Fqra6NABIEvgoc1JuK+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537632; c=relaxed/simple;
	bh=2bkhaZIKcbvjbRcdJ6gd6nr6aIWfNbCfFPKxuHXh9DM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fTllOua4taNZyJTGQz8b1CuYfPS/bhuaM3qI4xodC8r7RXfa+2Wjj6mqyt27wSjIXcE2oQuJD7h47SwPnMNmICof3WFEdnfDxOYK377FxgdxpXn3/HScORybFKlNj/FwzIOkAjMGbHth9JATgbko/kCFLMN32T8oEsvb3+v3Q0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P5DtBwae; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F251F00A3A;
	Mon, 15 Jun 2026 15:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781537631;
	bh=Gzxin1IxIm1vNQKnnLRNY8sAmfacG7ejRaql8RQKhtc=;
	h=Subject:To:Cc:From:Date;
	b=P5DtBwaeO9qMeZ+3cI8qzHqboURCi+sp5VQ12PQSWBFd5A2mUud1Zcp2Cxzdq7bsa
	 PqeuissG0+A824R3Y1JHJLQ/Z4KkW/+1RVWt287RuEaN5B9qTjBEezzaWLqhZvx2M4
	 oRjoiLFrXgExm1gqzNoZtwhwpmURkYvyn8QtfKCA=
Subject: FAILED: patch "[PATCH] fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios" failed to apply to 6.6-stable tree
To: jannh@google.com,brauner@kernel.org,mszeredi@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:55:25 +0200
Message-ID: <2026061525-banshee-overlay-7405@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263322-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jannh@google.com,m:brauner@kernel.org,m:mszeredi@redhat.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 041C2687BE7


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 4e3d1b2c48ca6c55f1e9ca7f8dccc76f120f276c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061525-banshee-overlay-7405@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e3d1b2c48ca6c55f1e9ca7f8dccc76f120f276c Mon Sep 17 00:00:00 2001
From: Jann Horn <jannh@google.com>
Date: Tue, 19 May 2026 16:40:34 +0200
Subject: [PATCH] fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios

FUSE_NOTIFY_RETRIEVE must be limited to uptodate folios; !uptodate folios
can contain uninitialized data.
Since FUSE_NOTIFY_RETRIEVE is intended to only return data that is already
in the page cache and not wait for data from the FUSE daemon, treat
!uptodate folios as if they weren't present.

This only has security impact on systems that don't enable automatic
zero-initialization of all page allocations via
CONFIG_INIT_ON_ALLOC_DEFAULT_ON or init_on_alloc=1.

Cc: stable@kernel.org
Fixes: 2d45ba381a74 ("fuse: add retrieve request")
Signed-off-by: Jann Horn <jannh@google.com>
Link: https://patch.msgid.link/20260519-fuse-retrieve-uptodate-v1-1-a7a1912a37f9@google.com
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5dda7080f4a9..08d364ed7d6c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1912,6 +1912,10 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 		folio = filemap_get_folio(mapping, index);
 		if (IS_ERR(folio))
 			break;
+		if (!folio_test_uptodate(folio)) {
+			folio_put(folio);
+			break;
+		}
 
 		folio_offset = offset_in_folio(folio, pos);
 		nr_bytes = min(folio_size(folio) - folio_offset, num);


