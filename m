Return-Path: <stable+bounces-271088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QM/JJKKXRmr4ZQsAu9opvQ
	(envelope-from <stable+bounces-271088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:53:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8976FAB7E
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:53:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Xm9DHW3G;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271088-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271088-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 975C2305B266
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79C337A84C;
	Thu,  2 Jul 2026 16:43:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843F53A6B85;
	Thu,  2 Jul 2026 16:43:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010638; cv=none; b=sBJPa/J+B0OYwZRLK3vCa73DLvVcuyDEAQei6pGbxgsfDNGLB5yu7Pt31YDaCPJy7XzxzbCCtg52kNhkrAwLI0HMOvfQQt7fljhrk4l4UHMMYi84eUHDGnds21G0n/0XDOSqGyh/y1dckX0UuaMTuhK9wMxrQR6Jt9OJJOvtU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010638; c=relaxed/simple;
	bh=Os/HpYZEuSef0pt+IGVEke9DwFVWxaAHLFPzX/rwvAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XS1v0D32h2AS7LrxMXyvJMqs0lMzp9FWFDPusarAwPNcsLHIAx4AzpW1KEy97iYfYIvRUKG5Oq9eEUNiJJgWoIwJbrLvAYnIjUdKVT4+5Nh2jaTjoOgqqR9QttCUjiYiNmRo+vQPXTWypUVkF/BFApLnm6zi3J4QBzCZ8bY2R5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xm9DHW3G; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA36A1F000E9;
	Thu,  2 Jul 2026 16:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010637;
	bh=c9I70Y6EER+R4AZL8TV+0AyvhPgohrpDhfZntq00JBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xm9DHW3GjDZJkPhDGtonHAOq1Xgk2HN8+VGjBfIvqUeR5BgfjYJ4xR6bL3U3t4WhI
	 0QQvEAmnTU0Jd6MutH2s1SWfRxEZNO6+sYGIDQYcVXLdzHJSmHbEtHrLbkDX4McHLh
	 N0XWBwxpLGanvhgFtx+88ykImnooKhsxsiUazy/k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.12 158/204] f2fs: keep atomic write retry from zeroing original data
Date: Thu,  2 Jul 2026 18:20:15 +0200
Message-ID: <20260702155121.968562981@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271088-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:qiwenjie@xiaomi.com,m:chao@kernel.org,m:jaegeuk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,xiaomi.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D8976FAB7E

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenjie Qi <qwjhust@gmail.com>

commit 6d874b65aadce56ac78f76129dbcfc2599b638f8 upstream.

A partial atomic write reserves a block in the COW inode before reading the
original data page for the untouched bytes in that page.

If that read fails, write_begin returns an error but leaves the COW inode
entry as NEW_ADDR. A retry of the same partial write then finds the COW
entry, treats it as existing COW data, and f2fs_write_begin() zeroes the
whole folio because blkaddr is NEW_ADDR.

If the retry is committed, the bytes outside the retried write range are
committed as zeroes instead of preserving the original file contents.

Only use the COW inode as the read source when it already has a real data
block. If the COW entry is still NEW_ADDR, treat it as a reservation to
reuse: keep reading the old data from the original inode and avoid
reserving or accounting the same atomic block again.

Cc: stable@kernel.org
Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/data.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3566,6 +3566,7 @@ static int prepare_atomic_write_begin(st
 	pgoff_t index = folio->index;
 	int err = 0;
 	block_t ori_blk_addr = NULL_ADDR;
+	bool cow_has_reserved_block = false;
 
 	/* If pos is beyond the end of file, reserve a new block in COW inode */
 	if ((pos & PAGE_MASK) >= i_size_read(inode))
@@ -3575,9 +3576,11 @@ static int prepare_atomic_write_begin(st
 	err = __find_data_block(cow_inode, index, blk_addr);
 	if (err) {
 		return err;
-	} else if (*blk_addr != NULL_ADDR) {
+	} else if (__is_valid_data_blkaddr(*blk_addr)) {
 		*use_cow = true;
 		return 0;
+	} else if (*blk_addr == NEW_ADDR) {
+		cow_has_reserved_block = true;
 	}
 
 	if (is_inode_flag_set(inode, FI_ATOMIC_REPLACE))
@@ -3590,10 +3593,13 @@ static int prepare_atomic_write_begin(st
 
 reserve_block:
 	/* Finally, we should reserve a new block in COW inode for the update */
-	err = __reserve_data_block(cow_inode, index, blk_addr, node_changed);
-	if (err)
-		return err;
-	inc_atomic_write_cnt(inode);
+	if (!cow_has_reserved_block) {
+		err = __reserve_data_block(cow_inode, index, blk_addr,
+					   node_changed);
+		if (err)
+			return err;
+		inc_atomic_write_cnt(inode);
+	}
 
 	if (ori_blk_addr != NULL_ADDR)
 		*blk_addr = ori_blk_addr;



