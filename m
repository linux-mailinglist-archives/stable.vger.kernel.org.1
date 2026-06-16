Return-Path: <stable+bounces-266420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bs67AlOeMWqmoQUAu9opvQ
	(envelope-from <stable+bounces-266420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:04:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25425694B91
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:04:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=AYv9Y96M;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266420-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266420-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8063B320F0D9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA56247CC7E;
	Tue, 16 Jun 2026 18:58:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81393CEBBD;
	Tue, 16 Jun 2026 18:58:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636330; cv=none; b=owMx9fZlS7g22eVIrNj1bU2AarX1fsuwaGYzY8melIdh/kpKeOWTNNH6J83WfRgbV3/zEB8yi/3YGTOBvIR0BVOeVg+ccEPMwCquTJJpwT5mlqGbvGyvFZ2BYSTIWHJKhhFQBIlzM8Hi+9Wc5KEptNe3NDNCMsR5fWiK/Qo1Z0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636330; c=relaxed/simple;
	bh=cklGEa3jkC1lM5JfUdwO0HjI1joTgZeokO7ip+CcmZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLvd6NrghK/QyMQkn8i6pSavDJBu4naES2DONKA0WPobDa+DSWmQ3F9O71FYBXO56ZTAuNuw4E8ee7T02490P4hE8lOUdu6NDTMdJevNkzsDpNTBdQVwFmRcxb/9Cp2KTwGEq/UISF3BWWsPnH4w7IyQuZi5V4skr9uK2Eah2zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AYv9Y96M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1D21F000E9;
	Tue, 16 Jun 2026 18:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781636329;
	bh=SEEnjFf7a3rA5Xfim7wf6WpHrlV8XFMniJi8KcO+Nos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AYv9Y96MgXlOCnfnJXSAXjrvNKZTLwZLhJsPsEnfGvnHZu6tGYcWCSv/hNu77M1HE
	 LsJauccS3NrCO5iy1jSuZ4wcpzQnFlPYImc7U96kOF6ILb9bzxCAfCG5r7EvKjgdvC
	 hjHnIRWhIkhUrZs3X68xaK+BJMmzJZ1WYuWymp6E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jann Horn <jannh@google.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: [PATCH 5.10 193/342] fuse: reject fuse_notify() pagecache ops on directories
Date: Tue, 16 Jun 2026 20:28:09 +0530
Message-ID: <20260616145057.169205780@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266420-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jannh@google.com,m:mszeredi@redhat.com,m:brauner@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25425694B91

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 9c954499d43aefac01c5dfb57a82b13d2dcf4b94 upstream.

The operations FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE allow the
FUSE daemon to actively write/read pagecache contents.

For directories with FOPEN_CACHE_DIR, the pagecache is used as
kernel-internal cache storage, and userspace is not supposed to have
direct access to this cache - in particular, fuse_parse_cache() will hit
WARN_ON() if the cache contains bogus data.

Reject FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE on anything other than
regular files with -EINVAL.

Fixes: 5d7bc7e8680c ("fuse: allow using readdir cache")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
Link: https://patch.msgid.link/20260519-fuse-dir-pagecache-v2-1-5428fa48e175@google.com
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fuse/dev.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1603,6 +1603,10 @@ static int fuse_notify_store(struct fuse
 	inode = fuse_ilookup(fc, nodeid,  NULL);
 	if (!inode)
 		goto out_up_killsb;
+	if (!S_ISREG(inode->i_mode)) {
+		err = -EINVAL;
+		goto out_iput;
+	}
 
 	mapping = inode->i_mapping;
 	index = outarg.offset >> PAGE_SHIFT;
@@ -1774,7 +1778,10 @@ static int fuse_notify_retrieve(struct f
 
 	inode = fuse_ilookup(fc, nodeid, &fm);
 	if (inode) {
-		err = fuse_retrieve(fm, inode, &outarg);
+		if (!S_ISREG(inode->i_mode))
+			err = -EINVAL;
+		else
+			err = fuse_retrieve(fm, inode, &outarg);
 		iput(inode);
 	}
 	up_read(&fc->killsb);



