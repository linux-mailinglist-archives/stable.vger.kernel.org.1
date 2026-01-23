Return-Path: <stable+bounces-211342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PqlIoMdc2ngsQAAu9opvQ
	(envelope-from <stable+bounces-211342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 08:04:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 001A9715FC
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 08:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2E4E305E31E
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 06:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EDE338911;
	Fri, 23 Jan 2026 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="tNF99gqV"
X-Original-To: stable@vger.kernel.org
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED0433FE27;
	Fri, 23 Jan 2026 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151483; cv=none; b=VY1G9JUGih/nx7ro5ZB2+aLj7HLXKiacOMT58mXBy4odNxO0kiFi/TUJELA/NU9/f5jrDy4irPUQMHck9fnsjvk4za8MBw4iNxdCtv7+aKQAI6OUepC+KG7t6Xxpdnx1V4ILv3jIcLjSahHEvAC/u5zMvsHvRpGqm87i13QDuRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151483; c=relaxed/simple;
	bh=BR7+cfJEaBNBYHwMCXGwidYW7SMy5OOv9HfA+Plaiok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ku+hy3nyrBpc3QvvPaqpL615EcSNqEs25SwIpaJzk8RozTgSJNzeCmym2qjZ3OZgnQcS+YS7WJKGJT6cKFa49cpmc5Z1mMht+QGutcjWUys7Uo4fnSTuziwXSCU+Udi+M4zhMtMYi+0mGfzblmdBua77dWQ8vJwAgqvmTTg+Rtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=tNF99gqV; arc=none smtp.client-ip=120.232.169.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=tNF99gqV7Ead5GG0tXIcuitu6lPBiSKpU+UVEf0L3q3CShaUVn58h76+wWj84ok1aMv5xRGXRfNeZ
	 zJ/CiyUITbHQgbfrMcyLraYJ0ih+9Ds9zyFBEGOadadE9I//yDOEhGOChYP3rM2QHUh+ErjnWydBvR
	 ceVyNeFSFXNRTtbQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-32-12046 (RichMail) with SMTP id 2f0e69731be8c88-01caf;
	Fri, 23 Jan 2026 14:57:46 +0800 (CST)
X-RM-TRANSID:2f0e69731be8c88-01caf
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	kubik.bartlomiej@gmail.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	khalid@kernel.org,
	almaz.alexandrovich@paragon-software.com,
	ntfs3@lists.linux.dev
Subject: [PATCH 6.6.y] fs/ntfs3: Initialize allocated memory before use
Date: Fri, 23 Jan 2026 14:57:53 +0800
Message-Id: <20260123065753.4067735-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-211342-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[139.com];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,paragon-software.com:email,139.com:mid,139.com:email]
X-Rspamd-Queue-Id: 001A9715FC
X-Rspamd-Action: no action

From: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>

[ Upstream commit a8a3ca23bbd9d849308a7921a049330dc6c91398 ]

KMSAN reports: Multiple uninitialized values detected:

- KMSAN: uninit-value in ntfs_read_hdr (3)
- KMSAN: uninit-value in bcmp (3)

Memory is allocated by __getname(), which is a wrapper for
kmem_cache_alloc(). This memory is used before being properly
cleared. Change kmem_cache_alloc() to kmem_cache_zalloc() to
properly allocate and clear memory before use.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Fixes: 78ab59fee07f ("fs/ntfs3: Rework file operations")
Tested-by: syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com
Reported-by: syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=332bd4e9d148f11a87dc

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Fixes: 78ab59fee07f ("fs/ntfs3: Rework file operations")
Tested-by: syzbot+0399100e525dd9696764@syzkaller.appspotmail.com
Reported-by: syzbot+0399100e525dd9696764@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0399100e525dd9696764

Reviewed-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Li hongliang <1468888505@139.com>
---
 fs/ntfs3/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 76326299ba36..ce381eafd084 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1327,7 +1327,7 @@ struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		fa |= FILE_ATTRIBUTE_READONLY;
 
 	/* Allocate PATH_MAX bytes. */
-	new_de = __getname();
+	new_de = kmem_cache_zalloc(names_cachep, GFP_KERNEL);
 	if (!new_de) {
 		err = -ENOMEM;
 		goto out1;
@@ -1756,10 +1756,9 @@ int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
 	struct NTFS_DE *de;
 
 	/* Allocate PATH_MAX bytes. */
-	de = __getname();
+	de = kmem_cache_zalloc(names_cachep, GFP_KERNEL);
 	if (!de)
 		return -ENOMEM;
-	memset(de, 0, PATH_MAX);
 
 	/* Mark rw ntfs as dirty. It will be cleared at umount. */
 	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
@@ -1795,7 +1794,7 @@ int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry)
 		return -EINVAL;
 
 	/* Allocate PATH_MAX bytes. */
-	de = __getname();
+	de = kmem_cache_zalloc(names_cachep, GFP_KERNEL);
 	if (!de)
 		return -ENOMEM;
 
-- 
2.34.1



