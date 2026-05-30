Return-Path: <stable+bounces-256973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLBXD2QPG2oT+wgAu9opvQ
	(envelope-from <stable+bounces-256973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:25:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7B760E23D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92AB1300A51D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF65D348C46;
	Sat, 30 May 2026 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ASt/I/4p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23012F25E4;
	Sat, 30 May 2026 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780158303; cv=none; b=CjGfF/vQT/ZRyQcRoo311d2VTFrVaAvP3lzUE9IWlwD2d9V3PoTtTxy6AhKZ015seC4OHsmtSnxbXrI1wsBo/EEKhdzfa5up56+xwKtXI4bYMU874mQlq47NJvTt0kF5Ua3qROgzJGIq7KPJS5Q0/Wai+jUSeYm7PSo4DVRj/5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780158303; c=relaxed/simple;
	bh=+/oE9t8fzmCGK6KyVzx4hQMSrFoTDjuo0baUEu7B5BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHERC4ZTPhgCcZ/tertT42dQqKEtqK0zQ+oAmEPhe5aH3fS5Fh9G1starAl7C8X1kmTT8eWOlPnf6T/0uOnounDcp92UT5ZeBJ50m7PgED7FOeYo7CnDMXUYaLwD/etzLT5V65knJOVt2UddT8gyjwC0QKE9ShL9romEDPRmrwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ASt/I/4p; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFD81F00893;
	Sat, 30 May 2026 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780158302;
	bh=rl/9zkno4epqR2kjCQcf8EF5A5uaOhjSdg8LtStHbls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ASt/I/4piDggS8NWqbmKT5e//reqj20h9MZh2qEZqebEHyl5SNY/SghOY/njDIgaB
	 umq30tceOAyzTDbclq0kOSP2Rprl2qhOGkRFXPQ5Wa6PTuNKtBPDMEE7eV4beeEu+p
	 QtvERrUXXUl+j4vNUnoiCYIoA/gIugQRbjBFAo8c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boris Burkov <boris@bur.io>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 008/969] btrfs: tracepoints: get correct superblock from dentry in event btrfs_sync_file()
Date: Sat, 30 May 2026 17:52:12 +0200
Message-ID: <20260530160300.712690852@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256973-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bur.io:email,suse.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: AE7B760E23D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 31847ccae4936..8054ce54807de 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -760,12 +760,15 @@ TRACE_EVENT(btrfs_sync_file,
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




