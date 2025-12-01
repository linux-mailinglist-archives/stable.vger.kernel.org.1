Return-Path: <stable+bounces-197988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 535C6C992CC
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 22:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CC504E1CBC
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 21:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12995284662;
	Mon,  1 Dec 2025 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kawgDZZJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C0C23F40D
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764624567; cv=none; b=qouUNB+YECaCEoS/J8uOtIXI+GkdnyCP9fAt6Wzs36S12sfk5F8/PvltMKN/G+v3J9u7j4CqvQAwKwjKdKcGeBG+pkIlb644rNCVDVOMNzpU88W4LJhrm3GiPezbN+UPfzXzTo6JqQeapQZztsHGt0n5ouIqWo9cASN8AhqAN3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764624567; c=relaxed/simple;
	bh=OHacAfIyeO5JPAiH83V5PfherCAW10QkpHeTsDtRm/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvMe37QJ9/17sH6zlwP5edSjUAauSX/kCI4M9j0OJ+WWml8xKBGg2zfDdEpc2TZhFjV9lgCeyNA2RKSBGMgb83vmjwqf1MoAmEQ4tYLMYusCYFCWNsAqFmc5V6jeYY86etWp6kX9yF/I8KmnJNE5PgDKyrZdbHEirGCfB1Fw7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kawgDZZJ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6418134d2f7so819197a12.3
        for <stable@vger.kernel.org>; Mon, 01 Dec 2025 13:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764624563; x=1765229363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhLRJqiJP7YUf8BkFXMNu5F1Fow6nH74qHWkckyQhp8=;
        b=kawgDZZJREIASC/topJGJCTzeDfqHk9/1wDGShIl9iS3V+rP8SZKr3i+FVUO4ZBXE3
         pCAaKB3KjYJp13rLVzxrLtVxMTKQG0l+4UwzT5JKuT3akYhLvWhIQ8QSSdr5hV7R3y1G
         Deaw/n1TNZiLgAcSYA61W9PwHopTPXcmn6VuP1iOd+K/pjJEulluG0plijDxczqa7K2B
         BQI3t6BxciXjBt0+zyLcU+oHyp2PsaayvK7pRRblvQOJeH3U54i4qeRAzsTkV+WFNM1x
         8w5fGsMRefnCCEYHkyPch9pw8ppyhw3rsEituz1qoy9fTjdsixB8e34wN3rWUCtzuGJc
         oMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764624563; x=1765229363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JhLRJqiJP7YUf8BkFXMNu5F1Fow6nH74qHWkckyQhp8=;
        b=sYIRP5gsu+2lD61RGpoAIOmhRL0RzxAougowyi4YTywMEIByj3yhDl7IlWTnQ3TtvT
         wgMxkC3KKHUFQtipBxBaw6uIFFxcUOSKWVRjr18ALatlSmo+/8kiLvQWyWpVPPGooido
         UR5h66w9hO5yqzClJZaC4Hx77J6p3m3I3j/H1ImHUQ+phR7eehwOoz8MfkFXxvkBYFIA
         aDAl0PXMMUIUdqvA67qEqg5yCajWAzg+X9pQNKZh/KUxLMGg0OTSuBufFadWwKfZGC/4
         5kEQO1Dd6NnFuRLI/HrGr0nRkqoXDMVSlRG+b6nuD71DJeTgz8WWzrqmvpKSLWT86IhA
         lLFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6Jh1OGm8xGZC3+pQr9Eb+/hcCvTuErNoYjbQEouVCj/qOPouj05BoGDiXpc6G4P8wfmasE2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYf4slyf14CjYHpykX7ApAmO8OenWC+br4GE+elNgN7ZIoja/z
	GxvNKjW7+uN5aXVnU6BucLvVsI13HjK2qYozbLkXCOD/4C4l8erpGUt7
X-Gm-Gg: ASbGncuMvlzhigCSoReGnzVvapSOtmZ+cIxkm1RwLb1EZPDBD2gedXXMSJvDh64dkrt
	9o8dysEpP606J+29ZT1O3DgE2uTPS1aOI0xNgkrE1SHbHUr3glUh0TYxQdtpV31A/hHteVFe0z8
	LKytvwoin6vYcOtX/r+RWqddyrIm9PRyKcQR1vbkSK7hgWHFgZt90PgREvqoChM2745OM8G3QQ6
	ytxM7JuyNLJTJXGqVkERhezmUbErRDpGgJlDj0FU/oiWt5EjM+1CowQkz4zt3HuhWtRRLF/NKOq
	TH8IWTlMAxYUxs03cS9KO9RecmpUPypOa7A12PsBYZA0005P2II1kjaBFQphH2ptmQUflHuwW5Y
	o5WnNPaEUU2hy/nuix36OjDo49/usRhvLwXfGLaSSKteVpguZij9rWMQwzaj9M6D9T9e/a/wzzH
	AQifAym4sdQwn9/g==
X-Google-Smtp-Source: AGHT+IHTR6TMIRL8Gy6fWSoJPxXo+FyHwv0N4OoyTuMM3fnw1YXGzI2yUlsj0aEIj3kgGeRaqGBUTQ==
X-Received: by 2002:a05:6402:2106:b0:645:3dce:b53b with SMTP id 4fb4d7f45d1cf-6455a063751mr19485790a12.5.1764624562788;
        Mon, 01 Dec 2025 13:29:22 -0800 (PST)
Received: from bhk ([165.50.39.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6475104fd7asm13519497a12.23.2025.12.01.13.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 13:29:22 -0800 (PST)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	jack@suse.cz,
	sandeen@redhat.com,
	brauner@kernel.org,
	Slava.Dubeyko@ibm.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>,
	stable@vger.kernel.org,
	syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Subject: [PATCH v3 1/2] hfs: ensure sb->s_fs_info is always cleaned up
Date: Mon,  1 Dec 2025 23:23:06 +0100
Message-ID: <20251201222843.82310-2-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201222843.82310-1-mehdi.benhadjkhelifa@gmail.com>
References: <20251201222843.82310-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hfs was converted to the new mount api a bug was introduced by
changing the allocation pattern of sb->s_fs_info. If setup_bdev_super()
fails after a new superblock has been allocated by sget_fc(), but before
hfs_fill_super() takes ownership of the filesystem-specific s_fs_info
data it was leaked.

Fix this by freeing sb->s_fs_info in hfs_kill_super().

Cc: stable@vger.kernel.org
Fixes: ffcd06b6d13b ("hfs: convert hfs to use the new mount api")
Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 fs/hfs/mdb.c   | 35 ++++++++++++++---------------------
 fs/hfs/super.c | 10 +++++++++-
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 53f3fae60217..f28cd24dee84 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -92,7 +92,7 @@ int hfs_mdb_get(struct super_block *sb)
 		/* See if this is an HFS filesystem */
 		bh = sb_bread512(sb, part_start + HFS_MDB_BLK, mdb);
 		if (!bh)
-			goto out;
+			return -EIO;
 
 		if (mdb->drSigWord == cpu_to_be16(HFS_SUPER_MAGIC))
 			break;
@@ -102,13 +102,14 @@ int hfs_mdb_get(struct super_block *sb)
 		 * (should do this only for cdrom/loop though)
 		 */
 		if (hfs_part_find(sb, &part_start, &part_size))
-			goto out;
+			return -EIO;
 	}
 
 	HFS_SB(sb)->alloc_blksz = size = be32_to_cpu(mdb->drAlBlkSiz);
 	if (!size || (size & (HFS_SECTOR_SIZE - 1))) {
 		pr_err("bad allocation block size %d\n", size);
-		goto out_bh;
+		brelse(bh);
+		return -EIO;
 	}
 
 	size = min(HFS_SB(sb)->alloc_blksz, (u32)PAGE_SIZE);
@@ -125,14 +126,16 @@ int hfs_mdb_get(struct super_block *sb)
 	brelse(bh);
 	if (!sb_set_blocksize(sb, size)) {
 		pr_err("unable to set blocksize to %u\n", size);
-		goto out;
+		return -EIO;
 	}
 
 	bh = sb_bread512(sb, part_start + HFS_MDB_BLK, mdb);
 	if (!bh)
-		goto out;
-	if (mdb->drSigWord != cpu_to_be16(HFS_SUPER_MAGIC))
-		goto out_bh;
+		return -EIO;
+	if (mdb->drSigWord != cpu_to_be16(HFS_SUPER_MAGIC)) {
+		brelse(bh);
+		return -EIO;
+	}
 
 	HFS_SB(sb)->mdb_bh = bh;
 	HFS_SB(sb)->mdb = mdb;
@@ -174,7 +177,7 @@ int hfs_mdb_get(struct super_block *sb)
 
 	HFS_SB(sb)->bitmap = kzalloc(8192, GFP_KERNEL);
 	if (!HFS_SB(sb)->bitmap)
-		goto out;
+		return -EIO;
 
 	/* read in the bitmap */
 	block = be16_to_cpu(mdb->drVBMSt) + part_start;
@@ -185,7 +188,7 @@ int hfs_mdb_get(struct super_block *sb)
 		bh = sb_bread(sb, off >> sb->s_blocksize_bits);
 		if (!bh) {
 			pr_err("unable to read volume bitmap\n");
-			goto out;
+			return -EIO;
 		}
 		off2 = off & (sb->s_blocksize - 1);
 		len = min((int)sb->s_blocksize - off2, size);
@@ -199,12 +202,12 @@ int hfs_mdb_get(struct super_block *sb)
 	HFS_SB(sb)->ext_tree = hfs_btree_open(sb, HFS_EXT_CNID, hfs_ext_keycmp);
 	if (!HFS_SB(sb)->ext_tree) {
 		pr_err("unable to open extent tree\n");
-		goto out;
+		return -EIO;
 	}
 	HFS_SB(sb)->cat_tree = hfs_btree_open(sb, HFS_CAT_CNID, hfs_cat_keycmp);
 	if (!HFS_SB(sb)->cat_tree) {
 		pr_err("unable to open catalog tree\n");
-		goto out;
+		return -EIO;
 	}
 
 	attrib = mdb->drAtrb;
@@ -229,12 +232,6 @@ int hfs_mdb_get(struct super_block *sb)
 	}
 
 	return 0;
-
-out_bh:
-	brelse(bh);
-out:
-	hfs_mdb_put(sb);
-	return -EIO;
 }
 
 /*
@@ -359,8 +356,6 @@ void hfs_mdb_close(struct super_block *sb)
  * Release the resources associated with the in-core MDB.  */
 void hfs_mdb_put(struct super_block *sb)
 {
-	if (!HFS_SB(sb))
-		return;
 	/* free the B-trees */
 	hfs_btree_close(HFS_SB(sb)->ext_tree);
 	hfs_btree_close(HFS_SB(sb)->cat_tree);
@@ -373,6 +368,4 @@ void hfs_mdb_put(struct super_block *sb)
 	unload_nls(HFS_SB(sb)->nls_disk);
 
 	kfree(HFS_SB(sb)->bitmap);
-	kfree(HFS_SB(sb));
-	sb->s_fs_info = NULL;
 }
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 47f50fa555a4..df289cbdd4e8 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -431,10 +431,18 @@ static int hfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void hfs_kill_super(struct super_block *sb)
+{
+	struct hfs_sb_info *hsb = HFS_SB(sb);
+
+	kill_block_super(sb);
+	kfree(hsb);
+}
+
 static struct file_system_type hfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "hfs",
-	.kill_sb	= kill_block_super,
+	.kill_sb	= hfs_kill_super,
 	.fs_flags	= FS_REQUIRES_DEV,
 	.init_fs_context = hfs_init_fs_context,
 };
-- 
2.52.0


