Return-Path: <stable+bounces-255808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ/BG8GmGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:34:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6835F8FC1
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54B20324DA7B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0141EA65;
	Thu, 28 May 2026 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cTQj4FFh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4D92F39B4;
	Thu, 28 May 2026 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999938; cv=none; b=TuI7pqGxoqcgstN+1TjUzI/H8BYnEkneIbw1byJmKAYT6HGCcvnBFD+Pzb3ial+z0D1o0th/V2TG5LF28x1LmJbR9ht5iIA3wyfgtCfvo+I9bt4l4dci5vSrtbeWpFt/7lymbTD3GZJvIeRwi7QhjDcEF90jgO6B+YJzI+DsG1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999938; c=relaxed/simple;
	bh=4PGWEzVh3BYBnQD0lsUEVOcmUvNDzCyv8ZHJp2JSC7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mqo1ligafA38lCYW+TL+IXeBLo7P1V3gAsMepmNmF0BPQqZEwYe+1a/bqJdZklL1X/3DN3fpXJbIODtlJTcPrt0C0Zcltbf0iwDyk+6aN+VXbCbRQKpsXToG9jXyCia7oz7vAHFbbd9wvY6oL2QIDg10eoJWqzXDiLESCLlwJCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cTQj4FFh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6102C1F000E9;
	Thu, 28 May 2026 20:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999936;
	bh=zx+ZnqdF66/+T83NJmbPHy8N51JQQRlGrwgr4PUdvhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cTQj4FFhVftTVp4Txyx3S/Qcw9bhMmlN0iFgznazENfRJVmCmo6GbVSu/QyCJUcgI
	 1Wk3WXYmG1RIlQd51uYQCPBrulwoXfKEm7138MgWaYTFM9iCpMkGlPkrxj4RLgjWFC
	 B8/nf+wd36GEwXj40Y6oF5adQoy2rG5PDJlkOoUs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 245/377] netfs: Fix potential UAF in netfs_unlock_abandoned_read_pages()
Date: Thu, 28 May 2026 21:48:03 +0200
Message-ID: <20260528194645.474812903@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sashiko.dev:server fail,msgid.link:server fail,linux.dev:server fail,sea.lore.kernel.org:server fail,infradead.org:server fail,manguebit.org:server fail,linuxfoundation.org:server fail];
	TAGGED_FROM(0.00)[bounces-255808-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,msgid.link:url,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,manguebit.org:email]
X-Rspamd-Queue-Id: 9E6835F8FC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit dbe556972100fabb8e5a1b3d2163831ff07b1e8e ]

netfs_unlock_abandoned_read_pages(rreq) accesses the index of the folios it
is wanting to unlock and compares that to rreq->no_unlock_folio so that it
doesn't unlock a folio being read for netfs_perform_write() or
netfs_write_begin().

However, given that netfs_unlock_abandoned_read_pages() is called _after_
NETFS_RREQ_IN_PROGRESS is cleared, the one folio that it's not allowed to
dereference is the one specified by ->no_unlock_folio as ownership
immediately reverts to the caller.

Fix this by storing the folio pointer instead and using that rather than
the index.  Also fix netfs_unlock_read_folio() where the same applies.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Closes: https://sashiko.dev/#/patchset/20260414082004.3756080-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://patch.msgid.link/20260512123404.719402-20-dhowells@redhat.com
cc: Paulo Alcantara <pc@manguebit.org>
cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/buffered_read.c | 4 ++--
 fs/netfs/read_collect.c  | 2 +-
 fs/netfs/read_retry.c    | 2 +-
 include/linux/netfs.h    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 085cd392bf5ac..ebaabec376326 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -669,7 +669,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 		ret = PTR_ERR(rreq);
 		goto error;
 	}
-	rreq->no_unlock_folio	= folio->index;
+	rreq->no_unlock_folio	= folio;
 	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
 
 	ret = netfs_begin_cache_read(rreq, ctx);
@@ -735,7 +735,7 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 		goto error;
 	}
 
-	rreq->no_unlock_folio = folio->index;
+	rreq->no_unlock_folio = folio;
 	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
 	ret = netfs_begin_cache_read(rreq, ctx);
 	if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index d2d902f466271..4c7312a4c8597 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -83,7 +83,7 @@ static void netfs_unlock_read_folio(struct netfs_io_request *rreq,
 	}
 
 just_unlock:
-	if (folio->index == rreq->no_unlock_folio &&
+	if (folio == rreq->no_unlock_folio &&
 	    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags)) {
 		_debug("no unlock");
 	} else {
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 68fc869513ef1..999177426141a 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -288,7 +288,7 @@ void netfs_unlock_abandoned_read_pages(struct netfs_io_request *rreq)
 			struct folio *folio = folioq_folio(p, slot);
 
 			if (folio && !folioq_is_marked2(p, slot)) {
-				if (folio->index == rreq->no_unlock_folio &&
+				if (folio == rreq->no_unlock_folio &&
 				    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO,
 					     &rreq->flags)) {
 					_debug("no unlock");
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index ba17ac5bf356a..62a528f90666b 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -252,7 +252,7 @@ struct netfs_io_request {
 	unsigned long long	collected_to;	/* Point we've collected to */
 	unsigned long long	cleaned_to;	/* Position we've cleaned folios to */
 	unsigned long long	abandon_to;	/* Position to abandon folios to */
-	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
+	const struct folio	*no_unlock_folio; /* Don't unlock this folio after read */
 	unsigned int		direct_bv_count; /* Number of elements in direct_bv[] */
 	unsigned int		debug_id;
 	unsigned int		rsize;		/* Maximum read size (0 for none) */
-- 
2.53.0




