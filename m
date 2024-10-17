Return-Path: <stable+bounces-86705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871469A2E64
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 22:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F301F233CF
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 20:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB461D097F;
	Thu, 17 Oct 2024 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="r25dzxY3"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A7C1DD0DE
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196451; cv=none; b=d5ifxVnupwTzbOzkCNeWA5N30uMe56uP2fJRqAtyBjcxRS4pZR0Cc3hycIkqBXlrPv+CVTR2MpTacgUDmsCBxZK1lEV8gbteWEVWPaJtgy2l20aQxwjFsWpAGCfgfCsFAORMTd3uRiIGwbY/RUUTpuzVssVsnkeiSMznBTzy13w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196451; c=relaxed/simple;
	bh=aRZLdMPiWqurLD9AhzG9EYLtW4uQwVoowM7/Y26UjsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SjaIEqcDxS/xbFS7YQh283NUTaYYMJ+1xbKD3+9liLm0qbrnZB5uqYbVMDElvE8nlyaA7XqjxYEGf406WMxrwPMYGEm/6pp64WYhUpyimZYxaSqm3kCrPOAJxn2RqWirsPeWWsgQcYWDBDA5u2xQuTssBvFOj/VnVECQ3d00BIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=r25dzxY3; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dOLxLQoQttR6OOGc3c/Z34m9rSedmEP85DgEiSP7CH4=; b=r25dzxY3SfNq8DDMNXxsqmc28u
	jhhhWWpCWnA237XpwENh38QWIa1gvMOzb3EbTpTrLCVMa6bvIhMfaFVn87F73X5hmihSA2wBnTwME
	VmANGKojkNQYgiLk2mwlJzEGipjjqcaDDzL5wjTjjr+PtJDnupVFZvMhR3do4O3WvVy5C0cgPOMzn
	SFU4Fzc3V4E8Q6YrLYu5Dl/vju7Wp3gTrWTDVkYWYmbLkQ99dQ0Z9QcZo+IT3Z4Lvm+B7wZwwBhrV
	NJ6VP31jZ4I4gmyxJwuDiqfokrWKVmYcXkb8mxgAuQWxN1hKR6S9PR8gpl/P1NDA5BufmUDScTah0
	r1mkPs9w==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1WzH-00BmZ7-HT; Thu, 17 Oct 2024 22:20:47 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 16/20] udf: Convert udf_link() to new directory iteration code
Date: Thu, 17 Oct 2024 17:19:58 -0300
Message-Id: <20241017202002.406428-17-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017202002.406428-1-cascardo@igalia.com>
References: <20241017202002.406428-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit dbfb102d16fb780c84f41adbaeb7eac907c415dc ]

Convert udf_link() to use new directory iteration code for adding entry
into the directory.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/namei.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 827cd0cb1251..f54ffa133e77 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1222,27 +1222,21 @@ static int udf_link(struct dentry *old_dentry, struct inode *dir,
 		    struct dentry *dentry)
 {
 	struct inode *inode = d_inode(old_dentry);
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc cfi, *fi;
+	struct udf_fileident_iter iter;
 	int err;
 
-	fi = udf_add_entry(dir, dentry, &fibh, &cfi, &err);
-	if (!fi) {
+	err = udf_fiiter_add_entry(dir, dentry, &iter);
+	if (err)
 		return err;
-	}
-	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
-	cfi.icb.extLocation = cpu_to_lelb(UDF_I(inode)->i_location);
+	iter.fi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
+	iter.fi.icb.extLocation = cpu_to_lelb(UDF_I(inode)->i_location);
 	if (UDF_SB(inode->i_sb)->s_lvid_bh) {
-		*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
+		*(__le32 *)((struct allocDescImpUse *)iter.fi.icb.impUse)->impUse =
 			cpu_to_le32(lvid_get_unique_id(inode->i_sb));
 	}
-	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
-	if (UDF_I(dir)->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		mark_inode_dirty(dir);
+	udf_fiiter_write_fi(&iter, NULL);
+	udf_fiiter_release(&iter);
 
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
 	inc_nlink(inode);
 	inode->i_ctime = current_time(inode);
 	mark_inode_dirty(inode);
-- 
2.34.1


