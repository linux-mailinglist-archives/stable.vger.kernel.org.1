Return-Path: <stable+bounces-256939-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNkCMNcNG2q/+ggAu9opvQ
	(envelope-from <stable+bounces-256939-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:18:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E83560E11B
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDB993073720
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C02334695;
	Sat, 30 May 2026 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sURBsfTv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE1B31DD96;
	Sat, 30 May 2026 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157605; cv=none; b=QRuSIcB16U/LHXaqkefMi09uK2NaTgKKwXP/QVf+GWrfTFTblQXZ88S/joKXePEq+qEOb6KvgTFaX91jvDXMq0RHdiV/PeS+WQcMkhTe/1DIXlvOW7Sj6W4ncmM03dTIzcZi8cNuMQ29UzPYxO1QDgXWueElD3/ncNEZqrUHxNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157605; c=relaxed/simple;
	bh=1o7kuhGQvHIMSBHBcSEYUv7i8OkPsCZiz8HjtjrEQto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2tiPd5bppCk1ih6ie/c1f9j4pPdPl4RYsXshokMV9LVCTixkI4oNFzUwAKMsNEvgMqC+WAGZvhn02ZjaUqsS8o5rKpDCVXOTuU8n/jlgsvaBpCFmhORGGDFolm63EPZUBq3I19IUChvn/+KQRIeshkHIrnv8+Oj6ZoO1///B0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sURBsfTv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF84D1F00893;
	Sat, 30 May 2026 16:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780157603;
	bh=ur+FcSdyxk8tN3dYiepQwyPNWTco+o9a2Ar3uQ6cMq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sURBsfTvJ/5JLfkHYE6fofoTgJ5UxtGcPL8RjfiebTMOrewe6/EtiTiL8Bwjnvlvx
	 maMughN9Ll6mRRL1KlEsYHpVoRIv2fTIIocd9xLEJpqxTkXG2oJTVYHju4kUK0s1C6
	 MR2O+hiG79grH3ksU5wUPf8y+WXMIsUytTPk/g9Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boris Burkov <boris@bur.io>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 004/776] btrfs: tracepoints: get correct superblock from dentry in event btrfs_sync_file()
Date: Sat, 30 May 2026 17:55:18 +0200
Message-ID: <20260530160240.356212925@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256939-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bur.io:email,suse.com:email]
X-Rspamd-Queue-Id: 3E83560E11B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Goldwyn Rodrigues <rgoldwyn@suse.de>

[ Upstream commit a85b46db143fda5869e7d8df8f258ccef5fa1719 ]

If overlay is used on top of btrfs, dentry->d_sb translates to overlay's
super block and fsid assignment will lead to a crash.

Use file_inode(file)->i_sb to always get btrfs_sb.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/btrfs.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index a5f77b685c55f..058c85534f3f1 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -695,12 +695,15 @@ TRACE_EVENT(btrfs_sync_file,
 	),
 
 	TP_fast_assign(
-		const struct dentry *dentry = file->f_path.dentry;
-		const struct inode *inode = d_inode(dentry);
+		struct dentry *dentry = file_dentry(file);
+		struct inode *inode = file_inode(file);
+		struct dentry *parent = dget_parent(dentry);
+		struct inode *parent_inode = d_inode(parent);
 
-		TP_fast_assign_fsid(btrfs_sb(file->f_path.dentry->d_sb));
+		dput(parent);
+		TP_fast_assign_fsid(btrfs_sb(inode->i_sb));
 		__entry->ino		= btrfs_ino(BTRFS_I(inode));
-		__entry->parent		= btrfs_ino(BTRFS_I(d_inode(dentry->d_parent)));
+		__entry->parent		= btrfs_ino(BTRFS_I(parent_inode));
 		__entry->datasync	= datasync;
 		__entry->root_objectid	=
 				 BTRFS_I(inode)->root->root_key.objectid;
-- 
2.53.0




