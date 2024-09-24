Return-Path: <stable+bounces-77051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC254984C3D
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 22:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07C31C20CB3
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 20:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD7513B58A;
	Tue, 24 Sep 2024 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy/r2ZOm"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E38B1386C6
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727210385; cv=none; b=nNV3qLGk0Azs4SGiRcNgOLm8G+I+s1WWBXT4jdiMo1ER9oNtD+cPpgW/ug0SP9AOWsUn60deqCYWmCWKChuM7bvzD3/s3laHp4f2GbxqYH2Ix1708ubmhbTQlkObuPHZtxIhAAB6NowR4mfDQZE1conwCHPL+24c/vrOgNsfu0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727210385; c=relaxed/simple;
	bh=ELHE7oebsWYWkfbLNh0r+gr3tRafuD8VoIiLRusJfDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JGIja/AJKZ5e/IKAjgFRHs9T/zP+/ydgWUfbDipmvgHL7o+a2nbdXFbrI3WhB6bB3iCix66LMT+TOzPxTjwLohYsL5ovc/Dls8JeulYaSTsrH0fR6WHxEaZb1ld16v7YGPMf2oiuPqSJuDB34Nl7ZmYe30X+sjFt4sppKx9j1uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uy/r2ZOm; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-49bc44e52d0so1985934137.1
        for <stable@vger.kernel.org>; Tue, 24 Sep 2024 13:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727210382; x=1727815182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nWJuIRWUsoXfEXtLHHT5XqXUYZvIS9PsnSwT6v1dcuc=;
        b=Uy/r2ZOmXfkF7TuevWuujJ0Bk1iwGPx1b9VYbEI33bazCcSSvOIaHO5Ie2jR8KE1IR
         WNJhSDtLT8AzBjk+CwrCTLOtf0eek+zFDN7p/U8gLEUIa6JPsJ5jslnO2hcbr2fOvj6Y
         ZQlSSzOo2+hs6p5jIrXWCP83/HjC7HLZJCxBYyFQNabtmjSU82RSnHSwTaW2RdsR4sTH
         sry9AfjMizRdLYTOUSX/uKdNAI1Lvw3tab0MYTu68FvXLS43x6jKmbeqN90HKG1jErip
         yh8FcyMp4y0p+bZ4j/iCWc5CDmroJLVu0dkHtflDPoh53cae+O+OSqFOopoPeTar5TzQ
         tmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727210382; x=1727815182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWJuIRWUsoXfEXtLHHT5XqXUYZvIS9PsnSwT6v1dcuc=;
        b=irjqCtkvk+5XdyrcA49j/6jMuOhsFRBUJbWTzTToXKT47QqVbKTgMwuHLU5NHAQY5D
         tvL0sbd6dud51sesWDEMMSwsevizOB5ptda9nzQGn++TlnaZ/tuNs4Qv8AqmW+v0yQUn
         vtynGMe7XSh8GbmWxqjv9Psddu+QAw0DHOY9OqhqYiLOcDd77htYHWTi+be8kdbwx5MA
         /dXU0t//MMUh2Mf269HcLe5cH+n1mtp+42hjSF8DC01objI2iQrSR7NeuBQCuFg98PJG
         MOzuif1aQv3cUFCtHtDf1USVMM/HhVZRIZUvv+Ei7ZPvYrJKFVuKsbk8XtXB7Dbo5WiB
         SkCg==
X-Gm-Message-State: AOJu0Yw5nmpokWsDkDhSUUEClAjC9R/Kf1E6pjk0AqoeOgVMh0LH27Nh
	yB/rrRaxV+ZCVbaJrvV6CRCU6oSnq2I/a1MehsmxG+urreihP4jn4YC78U3f
X-Google-Smtp-Source: AGHT+IETdxJTZxha+rqx356GCvh2PL8DM5E5uYzcXkLmcFm9T+Ge6m/K3diH50JM9/3WneniJpW8bg==
X-Received: by 2002:a05:6102:94f:b0:49b:cfe3:a303 with SMTP id ada2fe7eead31-4a15dc62844mr1040115137.9.1727210382370;
        Tue, 24 Sep 2024 13:39:42 -0700 (PDT)
Received: from diogo-jahchan-ASUS-TUF-Gaming-A15-FA507RM-FA507RM.. ([200.4.98.18])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a151860053sm1307695137.24.2024.09.24.13.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 13:39:41 -0700 (PDT)
From: Diogo Jahchan Koike <djahchankoike@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Diogo Jahchan Koike <djahchankoike@gmail.com>
Subject: [PATCH 6.1.y] btrfs: calculate the right space for delayed refs when updating global reserve
Date: Tue, 24 Sep 2024 17:38:52 -0300
Message-ID: <20240924203916.713326-1-djahchankoike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

commit f8f210dc84709804c9f952297f2bfafa6ea6b4bd upstream.

When updating the global block reserve, we account for the 6 items needed
by an unlink operation and the 6 delayed references for each one of those
items. However the calculation for the delayed references is not correct
in case we have the free space tree enabled, as in that case we need to
touch the free space tree as well and therefore need twice the number of
bytes. So use the btrfs_calc_delayed_ref_bytes() helper to calculate the
number of bytes need for the delayed references at
btrfs_update_global_block_rsv().

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[Diogo: this patch has been cherry-picked from the original commit;
conflicts included lack of a define (picked from commit 5630e2bcfe223)
and lack of btrfs_calc_delayed_ref_bytes (picked from commit 0e55a54502b97)
- changed const struct -> struct for compatibility.]
Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>

---
Fixes WARNING in btrfs_chunk_alloc (2) [0]
[0]: https://syzkaller.appspot.com/bug?extid=57de2b05959bc1e659af
---
 fs/btrfs/block-rsv.c   | 16 +++++++++-------
 fs/btrfs/block-rsv.h   | 12 ++++++++++++
 fs/btrfs/delayed-ref.h | 21 +++++++++++++++++++++
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index ec96285357e0..f7e3d6c2e302 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -378,17 +378,19 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 
 	/*
 	 * But we also want to reserve enough space so we can do the fallback
-	 * global reserve for an unlink, which is an additional 5 items (see the
-	 * comment in __unlink_start_trans for what we're modifying.)
+	 * global reserve for an unlink, which is an additional
+	 * BTRFS_UNLINK_METADATA_UNITS items.
 	 *
 	 * But we also need space for the delayed ref updates from the unlink,
-	 * so its 10, 5 for the actual operation, and 5 for the delayed ref
-	 * updates.
+	 * so add BTRFS_UNLINK_METADATA_UNITS units for delayed refs, one for
+	 * each unlink metadata item.
 	 */
-	min_items += 10;
-
+	min_items += BTRFS_UNLINK_METADATA_UNITS;
+
 	num_bytes = max_t(u64, num_bytes,
-			  btrfs_calc_insert_metadata_size(fs_info, min_items));
+			  btrfs_calc_insert_metadata_size(fs_info, min_items) +
+			  btrfs_calc_delayed_ref_bytes(fs_info,
+					       BTRFS_UNLINK_METADATA_UNITS));
 
 	spin_lock(&sinfo->lock);
 	spin_lock(&block_rsv->lock);
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index 578c3497a455..662c52b4bd44 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -50,6 +50,18 @@ struct btrfs_block_rsv {
 	u64 qgroup_rsv_reserved;
 };
 
+/*
+ * Number of metadata items necessary for an unlink operation:
+ *
+ * 1 for the possible orphan item
+ * 1 for the dir item
+ * 1 for the dir index
+ * 1 for the inode ref
+ * 1 for the inode
+ * 1 for the parent inode
+ */
+#define BTRFS_UNLINK_METADATA_UNITS		6
+
 void btrfs_init_block_rsv(struct btrfs_block_rsv *rsv, enum btrfs_rsv_type type);
 void btrfs_init_root_block_rsv(struct btrfs_root *root);
 struct btrfs_block_rsv *btrfs_alloc_block_rsv(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index d6304b690ec4..5c6bb23d45a5 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -253,6 +253,27 @@ extern struct kmem_cache *btrfs_delayed_extent_op_cachep;
 int __init btrfs_delayed_ref_init(void);
 void __cold btrfs_delayed_ref_exit(void);
 
+static inline u64 btrfs_calc_delayed_ref_bytes(struct btrfs_fs_info *fs_info,
+					       int num_delayed_refs)
+{
+	u64 num_bytes;
+
+	num_bytes = btrfs_calc_insert_metadata_size(fs_info, num_delayed_refs);
+
+	/*
+	 * We have to check the mount option here because we could be enabling
+	 * the free space tree for the first time and don't have the compat_ro
+	 * option set yet.
+	 *
+	 * We need extra reservations if we have the free space tree because
+	 * we'll have to modify that tree as well.
+	 */
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
+		num_bytes *= 2;
+
+	return num_bytes;
+}
+
 static inline void btrfs_init_generic_ref(struct btrfs_ref *generic_ref,
 				int action, u64 bytenr, u64 len, u64 parent)
 {
-- 
2.43.0


