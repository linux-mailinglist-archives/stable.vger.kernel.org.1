Return-Path: <stable+bounces-61432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F49D93C369
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 15:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FCB2831A8
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 13:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B1919AD90;
	Thu, 25 Jul 2024 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcIDN+N9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4FB19CD17
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915611; cv=none; b=VODKP0bx7UE3t9pFpB7KAG9GC+dOi460JvZJMZ7hOhCX30iWbuY99qiw+2ircX56FkqGS0Fl2oLAHFmJxHn5FAdno3vWvuAEuZ4ZO2gJZRUlwXs81U4L1xqXvMCnI6HLNYTUAxPlDMe53DzdSu6mza0DEhUaAgi4Yfb7eojv1yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915611; c=relaxed/simple;
	bh=3DptWcwLjh9g8zYQkDpmU927nteARjkuZE/FKXChKm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=b1jYtISbH2NhpA47afqknJF9P5aGQ/hTQhrYFRaMRr1I7VhJ/rof841EMH2NnMpB+/PB5V24S4BKPco1UYxHIe8WdnTAPLlN3P7+md6JRhEfftbt3POrjd/GjssWGf9jSkT8ZYyOE7iOcvWrGupHH2VaVxwy3LaZPtwPcTlvvW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcIDN+N9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3684bea9728so548442f8f.3
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721915608; x=1722520408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dab5/E/NnHy054SxC+iMfAJWhgRYTq8/+i+ln2dGsjE=;
        b=BcIDN+N9V0sGltEObSTxh8PvxgGHo2Oej4GhjDZs+XLXxVEvbPNbOg8t2FekDW/l0h
         L1VtQ6WeUeRFJ6cnF2hLSwDVzhUsdtKw+paST9TsShHJY1PamIzgSdxFXBUuUsaZg1g2
         4UXl52SbVrqPlBvSbIrueZiDe6tbn5oAyntIzMU//J8JEeBuq6K0qB55gpNu4sPvf6TQ
         zy7n43YKmzKxfINH4Yf7gvYbOAjlYDo89cAW9gZeg5SsW+1E3bztElX638TZHUuzMXRV
         iCSIyLmsAS/I85cLvRgXMyQ9dVDsMcA8ZL0jpzxXKpME3MHl0lwljJ75YPqxoq3yxOy+
         H8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721915608; x=1722520408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dab5/E/NnHy054SxC+iMfAJWhgRYTq8/+i+ln2dGsjE=;
        b=DGyd+kRUJebDYYYIsYnZc3ZMkcL+2GoJW34YEkGh1dizzS/s7kV5TlePWxmgtowTKR
         OqovXde6sUMdCd/vpnEcjvGUvEM3wWcOsh94wUfgk9ONnHaYbGfx6ljJa310f4kt5air
         2kf/sZPeKGQcdBZIg6JN2irG5FVicO7QYXd2m7R36kmuRhf7QxW7WC62vhvJHYl8N1HX
         nNmoMlTNVKt81QHqTMm2NEmDk1zDcOFKlaP2MvuNTzf/4Tn6AOXLWyMiwU50WzRe3vAF
         V9gJZM6d6Jxmszfh0bmvoeiIgVpv82C9A+NiFJ1jfHhrQChLMeRNdM0W1zG3AFXSZSDd
         nxzw==
X-Gm-Message-State: AOJu0YwlYSKzuI+bwuyD45QjmW9RlN2z6ytTpMiMIzncCDk9ex4Kv7qH
	NNbjgiUdPuXwGsun+S3UIvOloLamPKyeK2ft/IBcFrxEAkHVSJpbYHu84rgz
X-Google-Smtp-Source: AGHT+IHzz8LAg/s+R1f5EuJfRWlCMZSCRRkZpdHPCkcQgZoUg3S21f/crO6UqpXKM6CHObn42fUOWw==
X-Received: by 2002:adf:f38c:0:b0:367:9803:bfe7 with SMTP id ffacd0b85a97d-36b367b1d98mr1670746f8f.53.1721915607770;
        Thu, 25 Jul 2024 06:53:27 -0700 (PDT)
Received: from laptop.home (83.50.134.37.dynamic.jazztel.es. [37.134.50.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280574b2c2sm35909005e9.28.2024.07.25.06.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 06:53:27 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: stable@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Jan Kara <jack@suse.cz>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>,
	syzbot+600a32676df180ebc4af@syzkaller.appspotmail.com
Subject: [PATCH 6.1.y] udf: Convert udf_mkdir() to new directory iteration code
Date: Thu, 25 Jul 2024 15:53:13 +0200
Message-Id: <20240725135313.155137-1-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 00bce6f792caccefa73daeaf9bde82d24d50037f ]

Convert udf_mkdir() to new directory iteration code.

Signed-off-by: Jan Kara <jack@suse.cz>
(cherry picked from commit 00bce6f792caccefa73daeaf9bde82d24d50037f)
Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
Reported-by: syzbot+600a32676df180ebc4af@syzkaller.appspotmail.com
---
 fs/udf/namei.c | 48 +++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 7c95c549dd64..a33e6d762716 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -665,8 +665,7 @@ static int udf_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		     struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc cfi, *fi;
+	struct udf_fileident_iter iter;
 	int err;
 	struct udf_inode_info *dinfo = UDF_I(dir);
 	struct udf_inode_info *iinfo;
@@ -678,47 +677,42 @@ static int udf_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	iinfo = UDF_I(inode);
 	inode->i_op = &udf_dir_inode_operations;
 	inode->i_fop = &udf_dir_operations;
-	fi = udf_add_entry(inode, NULL, &fibh, &cfi, &err);
-	if (!fi) {
-		inode_dec_link_count(inode);
+	err = udf_fiiter_add_entry(inode, NULL, &iter);
+	if (err) {
+		clear_nlink(inode);
 		discard_new_inode(inode);
-		goto out;
+		return err;
 	}
 	set_nlink(inode, 2);
-	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
-	cfi.icb.extLocation = cpu_to_lelb(dinfo->i_location);
-	*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
+	iter.fi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
+	iter.fi.icb.extLocation = cpu_to_lelb(dinfo->i_location);
+	*(__le32 *)((struct allocDescImpUse *)iter.fi.icb.impUse)->impUse =
 		cpu_to_le32(dinfo->i_unique & 0x00000000FFFFFFFFUL);
-	cfi.fileCharacteristics =
+	iter.fi.fileCharacteristics =
 			FID_FILE_CHAR_DIRECTORY | FID_FILE_CHAR_PARENT;
-	udf_write_fi(inode, &cfi, fi, &fibh, NULL, NULL);
-	brelse(fibh.sbh);
+	udf_fiiter_write_fi(&iter, NULL);
+	udf_fiiter_release(&iter);
 	mark_inode_dirty(inode);
 
-	fi = udf_add_entry(dir, dentry, &fibh, &cfi, &err);
-	if (!fi) {
+	err = udf_fiiter_add_entry(dir, dentry, &iter);
+	if (err) {
 		clear_nlink(inode);
-		mark_inode_dirty(inode);
 		discard_new_inode(inode);
-		goto out;
+		return err;
 	}
-	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
-	cfi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
-	*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
+	iter.fi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
+	iter.fi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
+	*(__le32 *)((struct allocDescImpUse *)iter.fi.icb.impUse)->impUse =
 		cpu_to_le32(iinfo->i_unique & 0x00000000FFFFFFFFUL);
-	cfi.fileCharacteristics |= FID_FILE_CHAR_DIRECTORY;
-	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
+	iter.fi.fileCharacteristics |= FID_FILE_CHAR_DIRECTORY;
+	udf_fiiter_write_fi(&iter, NULL);
+	udf_fiiter_release(&iter);
 	inc_nlink(dir);
 	dir->i_ctime = dir->i_mtime = current_time(dir);
 	mark_inode_dirty(dir);
 	d_instantiate_new(dentry, inode);
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-	err = 0;
 
-out:
-	return err;
+	return 0;
 }
 
 static int empty_dir(struct inode *dir)
-- 
2.39.2


