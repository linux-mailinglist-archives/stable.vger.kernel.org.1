Return-Path: <stable+bounces-240846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OiQGOly62nCMwAAu9opvQ
	(envelope-from <stable+bounces-240846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:40:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C861745F612
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 868413023E32
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88663B38AE;
	Fri, 24 Apr 2026 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Q1Ne0mS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4563D3D04;
	Fri, 24 Apr 2026 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037991; cv=none; b=fCu3kWbLNC4AXDC6u2pq5eywsRMbIJYCvB9StpwQqYQ1YascRkIogHdQx93HcWvxbz+tgOdpI37jaXw4p9F3/QGdO1Pl3QwSuSbWXuNMbOY1DJz96g2zVe/hD6F06gQ6cyw0dyvgByKUQTz6M26CNifgNRtuEaKqbEKWolC5fhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037991; c=relaxed/simple;
	bh=l//CQKOaBjmfxjumba+U0HijTfvrLM4OOUVuAQRYScI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdVIpvj65rM+f8wp81+nDSrA0PoMMHP/IVvJxXTN4mCVNV6V/6l8dHWfnEnIdmImueKMzM/9bIuKqr4aQghiC+Bme6CKvFiwCBmFQghChwhx+wzkOTke4FUdGaOhnKQK5WuEAPQlukwl9nv2OFjJ8HqiF82BaagBwWlTLkTpXdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Q1Ne0mS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAF3C19425;
	Fri, 24 Apr 2026 13:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037991;
	bh=l//CQKOaBjmfxjumba+U0HijTfvrLM4OOUVuAQRYScI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0Q1Ne0mSPnhj/1u6dbNUN9vAEvNqQJLTQ21fCLH3Ggi3UuZMhFSgsBHsVX8eDzySW
	 EQ5hh+9vMCdj+kXzTKRq/VUTvlw+SLqhYMR/IY03ygThOi8VIeMc1TuKxuwAQ+hKxB
	 8uMPvuumS5QhJuQt86/b7u0nmMptdYIEm2qf5zsg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Samuel Page <sam@bynar.io>,
	Qi Tang <tpluszz77@gmail.com>,
	Zijun Hu <nightu@northwestern.edu>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.6 147/166] fuse: reject oversized dirents in page cache
Date: Fri, 24 Apr 2026 15:31:01 +0200
Message-ID: <20260424132603.883061538@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: C861745F612
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[northwestern.edu:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,bynar.io,gmail.com,northwestern.edu,redhat.com,kernel.org];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240846-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.893];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[northwestern.edu:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bynar.io:email]

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Samuel Page <sam@bynar.io>

commit 51a8de6c50bf947c8f534cd73da4c8f0a13e7bed upstream.

fuse_add_dirent_to_cache() computes a serialized dirent size from the
server-controlled namelen field and copies the dirent into a single
page-cache page. The existing logic only checks whether the dirent fits
in the remaining space of the current page and advances to a fresh page
if not. It never checks whether the dirent itself exceeds PAGE_SIZE.

As a result, a malicious FUSE server can return a dirent with
namelen=4095, producing a serialized record size of 4120 bytes. On 4 KiB
page systems this causes memcpy() to overflow the cache page by 24 bytes
into the following kernel page.

Reject dirents that cannot fit in a single page before copying them into
the readdir cache.

Fixes: 69e34551152a ("fuse: allow caching readdir")
Cc: stable@vger.kernel.org # v6.16+
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Zijun Hu <nightu@northwestern.edu>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Link: https://patch.msgid.link/20260420090139.662772-1-mszeredi@redhat.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fuse/readdir.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -41,6 +41,10 @@ static void fuse_add_dirent_to_cache(str
 	unsigned int offset;
 	void *addr;
 
+	/* Dirent doesn't fit in readdir cache page?  Skip caching. */
+	if (reclen > PAGE_SIZE)
+		return;
+
 	spin_lock(&fi->rdc.lock);
 	/*
 	 * Is cache already completed?  Or this entry does not go at the end of



