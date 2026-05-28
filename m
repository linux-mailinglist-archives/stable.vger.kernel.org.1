Return-Path: <stable+bounces-255674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGreDYalGGrClggAu9opvQ
	(envelope-from <stable+bounces-255674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:28:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A32555F8C98
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52EA23297448
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE8A30C15B;
	Thu, 28 May 2026 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gjiePxFF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D464E2C11F9;
	Thu, 28 May 2026 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999575; cv=none; b=r4jA3ZvZsFyVnXfQ2DYehniALegegjDCxPT40rRy55hO3fvOoC3CpxUtwU+Er5iKEwHMxeebbZLqw6yLGZRyHYJxzDE7vKsAfFT2Fw5NNjenbSXEYFDdFDCRSwWxxMix22jwBf7m7ipotgBRcrW7LPdKrf7/sZunFXwzV1kVAoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999575; c=relaxed/simple;
	bh=SF8DqkoQZ0nzo416vBx7kyjxbGBmxpnfLnhn2JMqb7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pja/XH4Q261JfxyN3fDusHKGcRVkq7DKwR+LVs3dIzFSq/ZTe+0RQQnT1o95sOUpr0sA4ETsHQWwrvZrKI5W3+8ft4vRWOR43UFzToxrzAg5t6Ae+x+fSBojTOyuOfZLBflk8V/5iKvZEnEmY5UfTJjPac9Pj2D12AOLOVvSde4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gjiePxFF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AD91F000E9;
	Thu, 28 May 2026 20:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999574;
	bh=/TPC9Jmq72JGDqdK7wEvY17iil1TZXBVweQU1Cls9u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gjiePxFFTmo+yW24P52m78sb3EHvTrE7vjgch2wfsMLeXc8ctmYofrPafZm4Bhlva
	 ZZj3tUhyRkJ/cnif/2wDtDYZYR7nv1KHDp3WHw7vEZTztg8v2oGeizCsLrM+H1mT3P
	 XxL1rroQjL/dTLjLz8Fr4TouXjWoTTpB1OgCFc04=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 6.18 078/377] fs/ntfs3: handle attr_set_size() errors when truncating files
Date: Thu, 28 May 2026 21:45:16 +0200
Message-ID: <20260528194640.631084376@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255674-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,paragon-software.com,139.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[139.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,paragon-software.com:email]
X-Rspamd-Queue-Id: A32555F8C98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 576248a34b927e93b2fd3fff7df735ba73ad7d01 ]

If attr_set_size() fails while truncating down, the error is silently
ignored and the inode may be left in an inconsistent state.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
[ Minor context conflict resolved. ]
Signed-off-by: Bin Lan <lanbincn@139.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ntfs3/file.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -458,8 +458,8 @@ static int ntfs_truncate(struct inode *i
 {
 	struct super_block *sb = inode->i_sb;
 	struct ntfs_inode *ni = ntfs_i(inode);
-	int err, dirty = 0;
 	u64 new_valid;
+	int err;
 
 	if (!S_ISREG(inode->i_mode))
 		return 0;
@@ -475,7 +475,6 @@ static int ntfs_truncate(struct inode *i
 	}
 
 	new_valid = ntfs_up_block(sb, min_t(u64, ni->i_valid, new_size));
-
 	truncate_setsize(inode, new_size);
 
 	ni_lock(ni);
@@ -489,22 +488,19 @@ static int ntfs_truncate(struct inode *i
 		ni->i_valid = new_valid;
 
 	ni_unlock(ni);
+	if (unlikely(err))
+		return err;
 
 	ni->std_fa |= FILE_ATTRIBUTE_ARCHIVE;
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	if (!IS_DIRSYNC(inode)) {
-		dirty = 1;
+		mark_inode_dirty(inode);
 	} else {
 		err = ntfs_sync_inode(inode);
 		if (err)
 			return err;
 	}
 
-	if (dirty)
-		mark_inode_dirty(inode);
-
-	/*ntfs_flush_inodes(inode->i_sb, inode, NULL);*/
-
 	return 0;
 }
 



