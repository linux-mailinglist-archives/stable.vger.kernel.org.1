Return-Path: <stable+bounces-201041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F9FCBE1A9
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 14:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8C75300EA0A
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 13:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4794331A6A;
	Mon, 15 Dec 2025 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUiRiEQx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B172C331A4A
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765806032; cv=none; b=UiSe9lxw0XbI4olIqti/7Y2cT+6I3pbDIMlfrn0TVhzJgPUnaPgIab3tVANjx74s1StmV4lx8pXPzRbP8QO8ze/OgWGhSQjTw3MOSeVpJRg1EmQA2vAnZctpXmaudFqSYw6qIYtf4t5U6xlfo/lxHEau+IzU6k7r5LdqMXTFJ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765806032; c=relaxed/simple;
	bh=ovJ0zyP/g9aXNafbNuG+hd9K81V+Lc2R0S5fghONlE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t3LsFafn3TABttbT6axeoiFT21QpsNzrwD+SuD3QCLg8fqvVVCz7pVmzB8Xyuu/7fgYZrY9icO6X6B/yG0xc2UDUaIM+Fl/FMwmR2L1ssOy15fqpkNF5TUxNEtJ6jdEEyni+Bc88poixkgIziQfKWGUsMAwx6kfRc/LAuj+/kvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUiRiEQx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c3259da34so2017510a91.2
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 05:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765806030; x=1766410830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LaqS3RSpbqvlmpnasR8sVbhgvyTt7K1QiH94F/Yk+ag=;
        b=AUiRiEQxLuCnCn4UvC6L0IGf4UaG14j0GjMP0840DN3Feo3g+wSu8roOSpybYlZYK2
         RS4lyRJe2T4PK+vpHXMKORukcVLOaD7Aw/AdE/KO/ihSPMlwtVrJGjpg3lSUKmOZ0MTM
         J9UNIsj7/5cg9YH6ihQ5MJmnqfLgQmfLl+OZ6EG10+zbYwzKsd0rFVM/K6M090Jh5unq
         lX/02gAim4mCxLV/NphAIhGYmqKoY6qJO/1S0Z8nG0rTrt1ZeqG7SpYTjYmbnCcOXp4m
         VzveZmKcHDA5gCbrBGvNGsYcDbus4sSDlwnk4eTrxsrnnqMd5loWmqBWo/y4gDBlmte7
         8hVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765806030; x=1766410830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaqS3RSpbqvlmpnasR8sVbhgvyTt7K1QiH94F/Yk+ag=;
        b=Zy4GuaLtlOSyqCZUagJed8hGiIJwDyqYvhOsgWweHqJVoQ8z+4p3OTeacYFTCdAACN
         A7V+KmwZ83z4a0p2f6wYR7aLMt2pSgJe0zsWQKrbSsHO8iD369Eo540x92ZNUsUz3e4+
         wcTDgGR/SkVg1NXSdyvVA6aItxfJ8PG5WGXj/HG8/t5jcAYOpNtN4PsnyBwRflqOAuSM
         WGZcgey6meVDYv8oI7r0IcuwX9U4ntEuxLYYY5pwwJ0bWtwMdKWrHQ6TVxH6BaajI2f6
         x0zB0kyDKGtroQ/nn7WDbiurup2+aOl1Zw6BgWMx2MmGwRzMpmIKaZfulQH+kGw0y6E+
         8snw==
X-Gm-Message-State: AOJu0Yw9eVuebDcQ8iMJFJ4+15yRr91fH+EBjr7eCG8kkZMjhKFx8YUv
	y0tTbF4UnwLTK4d9HdOtCC8YvgP60n0W8rA8iIxl7q6ZxgpcOZK5rdxIVANTwQ==
X-Gm-Gg: AY/fxX59l4G/NucAzWDcP/U/lsfhufvESv+SDKPMxvaQ0nYOAJYn5HnZ8SY6S17vE1L
	mCXDjjdp8D09Fv2/LlyFv1/wOI+MF/zPdgmVQD7zBUmShoSNRtk2Yubqc+zqhGOLE6UnLNNRrBU
	qvRbrf7+7lzVugjJywmQRGCMPgIEI2JUA3ilhoczbuVTqk0JZSm4d+vXefp49ylCg5pwVpmzaXy
	7GKs3Wn3GrxIET2jseDnYI1RSaIyyG2Vm4wuZB6teOlaDH7mkIlU+ssNt+1j7P5ScAAiqSNAQyL
	dYzHNM2JeMG8y0hLz67YCxlf1TpzEEyXzBCuG+srx9G306Saw0g/llQY1xJU29b/ViDnrQboCMT
	a67cQlAvALbCvd8THSmDTruW1VpJ2RqOnJTr2nR2+JpZS2IbMO1YbOHx5YIvSTMIuSRUs0Aw6TM
	Kgyo8Tqi6S
X-Google-Smtp-Source: AGHT+IH2HoaWsKGvvyPNwy/LERBF8rplt9/OpANYZBDCCXD3Qj0LMKNYm+cH2U/UH7qnjgbQwYK/ig==
X-Received: by 2002:a17:90b:3949:b0:32e:a10b:ce33 with SMTP id 98e67ed59e1d1-34abe478148mr9019359a91.21.1765806029815;
        Mon, 15 Dec 2025 05:40:29 -0800 (PST)
Received: from fly.nay.do ([49.37.35.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe3a21d1sm9259498a91.4.2025.12.15.05.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 05:40:29 -0800 (PST)
From: Ankan Biswas <spyjetfayed@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Ankan Biswas <spyjetfayed@gmail.com>
Subject: [PATCH 6.6.y] ext4: fix error message when rejecting the default hash
Date: Mon, 15 Dec 2025 19:09:57 +0530
Message-ID: <20251215133957.4236-1-spyjetfayed@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@suse.de>

[ Upstream commit a2187431c395cdfbf144e3536f25468c64fc7cfa ]

Commit 985b67cd8639 ("ext4: filesystems without casefold feature cannot
be mounted with siphash") properly rejects volumes where
s_def_hash_version is set to DX_HASH_SIPHASH, but the check and the
error message should not look into casefold setup - a filesystem should
never have DX_HASH_SIPHASH as the default hash.  Fix it and, since we
are there, move the check to ext4_hash_info_init.

Fixes:985b67cd8639 ("ext4: filesystems without casefold feature cannot
be mounted with siphash")

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
Link: https://patch.msgid.link/87jzg1en6j.fsf_-_@mailhost.krisman.be
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[ The commit a2187431c395 intended to remove the if-block which was used
  for an old SIPHASH rejection check. ]
Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/super.c | 20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 7afce7b744c0..85ba12a48f26 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2459,6 +2459,7 @@ static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
 #define DX_HASH_HALF_MD4_UNSIGNED	4
 #define DX_HASH_TEA_UNSIGNED		5
 #define DX_HASH_SIPHASH			6
+#define DX_HASH_LAST 			DX_HASH_SIPHASH
 
 static inline u32 ext4_chksum(struct ext4_sb_info *sbi, u32 crc,
 			      const void *address, unsigned int length)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 16a6c249580e..613f2bac439d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5138,16 +5138,27 @@ static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
 	return ret;
 }
 
-static void ext4_hash_info_init(struct super_block *sb)
+static int ext4_hash_info_init(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
 	unsigned int i;
 
+	sbi->s_def_hash_version = es->s_def_hash_version;
+
+	if (sbi->s_def_hash_version > DX_HASH_LAST) {
+		ext4_msg(sb, KERN_ERR,
+			 "Invalid default hash set in the superblock");
+		return -EINVAL;
+	} else if (sbi->s_def_hash_version == DX_HASH_SIPHASH) {
+		ext4_msg(sb, KERN_ERR,
+			 "SIPHASH is not a valid default hash value");
+		return -EINVAL;
+	}
+
 	for (i = 0; i < 4; i++)
 		sbi->s_hash_seed[i] = le32_to_cpu(es->s_hash_seed[i]);
 
-	sbi->s_def_hash_version = es->s_def_hash_version;
 	if (ext4_has_feature_dir_index(sb)) {
 		i = le32_to_cpu(es->s_flags);
 		if (i & EXT2_FLAGS_UNSIGNED_HASH)
@@ -5165,6 +5176,7 @@ static void ext4_hash_info_init(struct super_block *sb)
 #endif
 		}
 	}
+	return 0;
 }
 
 static int ext4_block_group_meta_init(struct super_block *sb, int silent)
@@ -5309,7 +5321,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (err)
 		goto failed_mount;
 
-	ext4_hash_info_init(sb);
+	err = ext4_hash_info_init(sb);
+	if (err)
+		goto failed_mount;
 
 	err = ext4_handle_clustersize(sb);
 	if (err)
-- 
2.52.0


