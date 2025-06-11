Return-Path: <stable+bounces-152470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D14AD6097
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202033AB01F
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967472BD5B0;
	Wed, 11 Jun 2025 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q93+gPCN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4501288C1D
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675712; cv=none; b=qCWDiK0Plzqcdp47ALnlYySH5WGwEaYAzqYlbRYDUv05YP0ErVbwQZdnOKdroVjYZ6o9CXgRlCkZHQLahAejm8wlmS3A6emYXuaGHVn62EX6SSVvuSHlOIU1HR5Tpv4XOwh3El5yorSUax+Iy04FzbTNvveLP1mfNy7szWIuXUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675712; c=relaxed/simple;
	bh=nswKQa5a31acLMr4D9xTUEoShZBSU/LI+vrC7FkAwn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aalVRhzS9DS3T9mUAHNL8fR5SpNZMus+ox+odPLXTokGw6JjwSqQodqoqf4ioACbgMH0b+MQ3GUfeuCA8ssBjLd5OyUpe+go3UF3jTl3s7h9i5hut+u/M3tsg3y/XJN5kmMlfdSO7aW5qUgDm7XeTHU0N7NP2wIxFdkQXRCkhU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q93+gPCN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234bfe37cccso4053815ad.0
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675710; x=1750280510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqtCdZGnuOqKPVWHD6iediu/nsXJ6KYPnIYiWLaG6Yk=;
        b=Q93+gPCNM3H7TKNcqLqMA9q2fsrrENZcE1a1blFNJ4Kc5Hr2J3mBVJcAe2tRNQHVVk
         mWjXWV6FyA2eRlsHJK84AXElJ+ZTLrA4wtobh2cYnOuusL+hcA/GfznaVVehZlB8w9EN
         ljzGhiT2V1nTDWQdhd1YRrwOTA6ds+8f7KwakZ7Ik2MgpibgnHuPLaaKfB3BGBxFqZlP
         EMrQr6u7xhdyMTVwzg2Qpqd4PVyMvp6Spz3ATMe9OxuY4TiA+A5HGRhTLdGkQcGarh49
         zzMz5nmevUW9Y/0otbKO/+5pX7KMUkUI7nk/idK6vX+gn3JOCeJgMi4QQXZG9+RRkWbK
         fGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675710; x=1750280510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqtCdZGnuOqKPVWHD6iediu/nsXJ6KYPnIYiWLaG6Yk=;
        b=a0FlHTBxYd8d1f7VMdr3YQFZvHNXPzYiOIvTLON6Ul6PYAHkNYXhClIGHWTdMT67vw
         b/zdxDL41aIyyD1gTWV8dw2zF2X+iLrVDR0YtH2BTYmpf7Fl6UJMQY/r3APgHvmMExVk
         r8bJwd3BOLHtX5NQ/tZzySi4A21i2mI0ETGB4PDAvdRfkBIRRVpqPy6y9PhGu6Qd5DW5
         pn0P1eiNkLyjnlgRyD/mJkNOZO77w5OtDl/B2Y02mtIQ8no4UjkAfxiJ98b/c96SkI49
         2km/NBauCDtwNHdZ0RUeg1PAjC/xAmwGZEknt4l39TOVCLNkvRqTaNprWSOC4qnMrS4N
         AKOg==
X-Gm-Message-State: AOJu0Yx1KYyuQqM8rJwPTVhQ3FhOtgGZIEOzSfJ7ssZl3uFTfCArLhFa
	xaFNgRkLN4Btfpxjz8mF5HHzWGGSmtFOuz1asJveCi5rjM4V25i0+Xx9f5QU2HWK
X-Gm-Gg: ASbGncu9HG7q25e6w/68AkkYFpCluIBN28yfzInLQXeb7iwladTPF3uAJYj05V6cw1v
	gde2EPHkRoiGg0kE2uu4R4alFsmJWhkY+lAqwPnKXSrzOuY8kvPJ3tWI59s6U03yV/HE0+tJO4e
	wjhs1jEqiGmhIRJV5NAcWsF9P2DzS2qJqaVjRxHTJz8FestnmBrwnouDhNLIme59/WMoSrrXX7t
	wL0hFBKfzdsEI/CnrWw8fGrmhRavnSgEwM10yu2ZxTYu81hPfe/IQR1//uZ+jk9OxXGYg5HklTm
	E/iAcPck9p55njtCsp/YIu06sZwxMfcD+Vr6cFxUeq19rQDPL56AcuIQCFl3bR7aH8L7w/ooaqZ
	rFHrRdcvvKos=
X-Google-Smtp-Source: AGHT+IEmnaFsl1cZCI21eJLUVB8xnCfP4RqHedAOpwh1fRUWc7rnXP+YEdt1A+gMKY2Guhtk/csmjw==
X-Received: by 2002:a17:903:4b4b:b0:235:2e0:aa9 with SMTP id d9443c01a7336-2364ca0c15cmr14677005ad.14.1749675709899;
        Wed, 11 Jun 2025 14:01:49 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:49 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	lei lu <llfamsec@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 16/23] xfs: don't walk off the end of a directory data block
Date: Wed, 11 Jun 2025 14:01:20 -0700
Message-ID: <20250611210128.67687-17-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
In-Reply-To: <20250611210128.67687-1-leah.rumancik@gmail.com>
References: <20250611210128.67687-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: lei lu <llfamsec@gmail.com>

[ Upstream commit 0c7fcdb6d06cdf8b19b57c17605215b06afa864a ]

This adds sanity checks for xfs_dir2_data_unused and xfs_dir2_data_entry
to make sure don't stray beyond valid memory region. Before patching, the
loop simply checks that the start offset of the dup and dep is within the
range. So in a crafted image, if last entry is xfs_dir2_data_unused, we
can change dup->length to dup->length-1 and leave 1 byte of space. In the
next traversal, this space will be considered as dup or dep. We may
encounter an out of bound read when accessing the fixed members.

In the patch, we make sure that the remaining bytes large enough to hold
an unused entry before accessing xfs_dir2_data_unused and
xfs_dir2_data_unused is XFS_DIR2_DATA_ALIGN byte aligned. We also make
sure that the remaining bytes large enough to hold a dirent with a
single-byte name before accessing xfs_dir2_data_entry.

Signed-off-by: lei lu <llfamsec@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_dir2_data.c | 31 ++++++++++++++++++++++++++-----
 fs/xfs/libxfs/xfs_dir2_priv.h |  7 +++++++
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_dir2_data.c b/fs/xfs/libxfs/xfs_dir2_data.c
index dbcf58979a59..e1d5da6d8d4a 100644
--- a/fs/xfs/libxfs/xfs_dir2_data.c
+++ b/fs/xfs/libxfs/xfs_dir2_data.c
@@ -175,78 +175,99 @@ __xfs_dir3_data_check(
 	 * Loop over the data/unused entries.
 	 */
 	while (offset < end) {
 		struct xfs_dir2_data_unused	*dup = bp->b_addr + offset;
 		struct xfs_dir2_data_entry	*dep = bp->b_addr + offset;
+		unsigned int	reclen;
+
+		/*
+		 * Are the remaining bytes large enough to hold an
+		 * unused entry?
+		 */
+		if (offset > end - xfs_dir2_data_unusedsize(1))
+			return __this_address;
 
 		/*
 		 * If it's unused, look for the space in the bestfree table.
 		 * If we find it, account for that, else make sure it
 		 * doesn't need to be there.
 		 */
 		if (be16_to_cpu(dup->freetag) == XFS_DIR2_DATA_FREE_TAG) {
 			xfs_failaddr_t	fa;
 
+			reclen = xfs_dir2_data_unusedsize(
+					be16_to_cpu(dup->length));
 			if (lastfree != 0)
 				return __this_address;
-			if (offset + be16_to_cpu(dup->length) > end)
+			if (be16_to_cpu(dup->length) != reclen)
+				return __this_address;
+			if (offset + reclen > end)
 				return __this_address;
 			if (be16_to_cpu(*xfs_dir2_data_unused_tag_p(dup)) !=
 			    offset)
 				return __this_address;
 			fa = xfs_dir2_data_freefind_verify(hdr, bf, dup, &dfp);
 			if (fa)
 				return fa;
 			if (dfp) {
 				i = (int)(dfp - bf);
 				if ((freeseen & (1 << i)) != 0)
 					return __this_address;
 				freeseen |= 1 << i;
 			} else {
 				if (be16_to_cpu(dup->length) >
 				    be16_to_cpu(bf[2].length))
 					return __this_address;
 			}
-			offset += be16_to_cpu(dup->length);
+			offset += reclen;
 			lastfree = 1;
 			continue;
 		}
+
+		/*
+		 * This is not an unused entry. Are the remaining bytes
+		 * large enough for a dirent with a single-byte name?
+		 */
+		if (offset > end - xfs_dir2_data_entsize(mp, 1))
+			return __this_address;
+
 		/*
 		 * It's a real entry.  Validate the fields.
 		 * If this is a block directory then make sure it's
 		 * in the leaf section of the block.
 		 * The linear search is crude but this is DEBUG code.
 		 */
 		if (dep->namelen == 0)
 			return __this_address;
-		if (!xfs_verify_dir_ino(mp, be64_to_cpu(dep->inumber)))
+		reclen = xfs_dir2_data_entsize(mp, dep->namelen);
+		if (offset + reclen > end)
 			return __this_address;
-		if (offset + xfs_dir2_data_entsize(mp, dep->namelen) > end)
+		if (!xfs_verify_dir_ino(mp, be64_to_cpu(dep->inumber)))
 			return __this_address;
 		if (be16_to_cpu(*xfs_dir2_data_entry_tag_p(mp, dep)) != offset)
 			return __this_address;
 		if (xfs_dir2_data_get_ftype(mp, dep) >= XFS_DIR3_FT_MAX)
 			return __this_address;
 		count++;
 		lastfree = 0;
 		if (hdr->magic == cpu_to_be32(XFS_DIR2_BLOCK_MAGIC) ||
 		    hdr->magic == cpu_to_be32(XFS_DIR3_BLOCK_MAGIC)) {
 			addr = xfs_dir2_db_off_to_dataptr(geo, geo->datablk,
 						(xfs_dir2_data_aoff_t)
 						((char *)dep - (char *)hdr));
 			name.name = dep->name;
 			name.len = dep->namelen;
 			hash = xfs_dir2_hashname(mp, &name);
 			for (i = 0; i < be32_to_cpu(btp->count); i++) {
 				if (be32_to_cpu(lep[i].address) == addr &&
 				    be32_to_cpu(lep[i].hashval) == hash)
 					break;
 			}
 			if (i >= be32_to_cpu(btp->count))
 				return __this_address;
 		}
-		offset += xfs_dir2_data_entsize(mp, dep->namelen);
+		offset += reclen;
 	}
 	/*
 	 * Need to have seen all the entries and all the bestfree slots.
 	 */
 	if (freeseen != 7)
diff --git a/fs/xfs/libxfs/xfs_dir2_priv.h b/fs/xfs/libxfs/xfs_dir2_priv.h
index 7404a9ff1a92..9046d08554e9 100644
--- a/fs/xfs/libxfs/xfs_dir2_priv.h
+++ b/fs/xfs/libxfs/xfs_dir2_priv.h
@@ -185,10 +185,17 @@ void xfs_dir2_sf_put_ftype(struct xfs_mount *mp,
 
 /* xfs_dir2_readdir.c */
 extern int xfs_readdir(struct xfs_trans *tp, struct xfs_inode *dp,
 		       struct dir_context *ctx, size_t bufsize);
 
+static inline unsigned int
+xfs_dir2_data_unusedsize(
+	unsigned int	len)
+{
+	return round_up(len, XFS_DIR2_DATA_ALIGN);
+}
+
 static inline unsigned int
 xfs_dir2_data_entsize(
 	struct xfs_mount	*mp,
 	unsigned int		namelen)
 {
-- 
2.50.0.rc1.591.g9c95f17f64-goog


