Return-Path: <stable+bounces-258079-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAzzNsIjG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-258079-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:52:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 476E96108A3
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1153B3051162
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82CA3B9D80;
	Sat, 30 May 2026 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="syD5S6gt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5F825B0BC;
	Sat, 30 May 2026 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163150; cv=none; b=mc2nhMXstXRxgCtI/XCYEYD3UNxsVm7PERdnIHjvD2Pvwu/6l8zlby7yAGMTr9Ze/YDtjwdlMyNfCUQ/5Y96qbUjU6KESQcMF4wL9aSJi97R8yGv1wlrfryeltMdKB7GBxzsmyWAfFNZVo1F+kC++tftH02w+idZPv+99mi0a4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163150; c=relaxed/simple;
	bh=O4+JZb3h6kWCzf2pqZkWYYvxfuPnakfUAvMlHDxHC4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T46UQmUj5xsWiD9t45OFQzVyimWItVbv8lrAcXkn8Pg6mYhNsJd7Jo/y5+ERvkT9dmyFn7Yr3lfoQyS7KG8yncjL6FKUmoE8MhllZqcFxTmaLAcGnHOj45aKiM8kDlJTJW6FDZI+heekL+VpJHf4gvnekjDAZsYHZAp2qV7HO7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=syD5S6gt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706021F00893;
	Sat, 30 May 2026 17:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163149;
	bh=MPTYdvT0bvrWjPpy2c7p7TXmKfK/M6Y7TZioW5xi6gA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=syD5S6gtmNPq2s2kf0X4OVckcGxBaauFKXGzCwT5rtPCj4V081QItBB8KkVNB4n37
	 iTWj3juNTWfGEtlAs5OZ0Vt0It1FV04kWHbRVJAGx2GAv4x/A4rRZj4zHPOzWYcpDy
	 NPCSi2hXoiKG2c+/UMUyRr5bu4w4Bh+Y7KO5ecoI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.15 172/776] fuse: quiet down complaints in fuse_conn_limit_write
Date: Sat, 30 May 2026 17:58:06 +0200
Message-ID: <20260530160244.942143788@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258079-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 476E96108A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Darrick J. Wong <djwong@kernel.org>

commit 129a45f9755a89f573c6a513a6b9e3d234ce89b0 upstream.

gcc 15 complains about an uninitialized variable val that is passed by
reference into fuse_conn_limit_write:

 control.c: In function ‘fuse_conn_congestion_threshold_write’:
 include/asm-generic/rwonce.h:55:37: warning: ‘val’ may be used uninitialized [-Wmaybe-uninitialized]
    55 |         *(volatile typeof(x) *)&(x) = (val);                            \
       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
 include/asm-generic/rwonce.h:61:9: note: in expansion of macro ‘__WRITE_ONCE’
    61 |         __WRITE_ONCE(x, val);                                           \
       |         ^~~~~~~~~~~~
 control.c:178:9: note: in expansion of macro ‘WRITE_ONCE’
   178 |         WRITE_ONCE(fc->congestion_threshold, val);
       |         ^~~~~~~~~~
 control.c:166:18: note: ‘val’ was declared here
   166 |         unsigned val;
       |                  ^~~

Unfortunately there's enough macro spew involved in kstrtoul_from_user
that I think gcc gives up on its analysis and sprays the above warning.
AFAICT it's not actually a bug, but we could just zero-initialize the
variable to enable using -Wmaybe-uninitialized to find real problems.

Previously we would use some weird uninitialized_var annotation to quiet
down the warnings, so clearly this code has been like this for quite
some time.

Cc: stable@vger.kernel.org # v5.9
Fixes: 3f649ab728cda8 ("treewide: Remove uninitialized_var() usage")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fuse/control.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -120,7 +120,7 @@ static ssize_t fuse_conn_max_background_
 					      const char __user *buf,
 					      size_t count, loff_t *ppos)
 {
-	unsigned val;
+	unsigned int val = 0;
 	ssize_t ret;
 
 	ret = fuse_conn_limit_write(file, buf, count, ppos, &val,
@@ -162,7 +162,7 @@ static ssize_t fuse_conn_congestion_thre
 						    const char __user *buf,
 						    size_t count, loff_t *ppos)
 {
-	unsigned val;
+	unsigned int val = 0;
 	struct fuse_conn *fc;
 	struct fuse_mount *fm;
 	ssize_t ret;



