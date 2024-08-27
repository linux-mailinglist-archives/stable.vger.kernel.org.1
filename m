Return-Path: <stable+bounces-71002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D82B961118
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA261C21ED3
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C6A1C3F0D;
	Tue, 27 Aug 2024 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RfFAcVpz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6803B17C96;
	Tue, 27 Aug 2024 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771771; cv=none; b=d7aWzIaZ7tvUYS/v2fF2WUPZ3VB3R9Ax4W8C4CZRj0otTkpeom0o7LHcCYtug7ACFrwmvVtgggQcb833zzxletPxn+C1OUEcvSP60YmJ5KqAdGYE0bQV+YZrTRxPpWRBeX8YxqlIjB8uHY8oUa/xm8UA9nc3w31omDz37R1OsNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771771; c=relaxed/simple;
	bh=MjdOwlu8k2m4tMYjc+i3XWkigAF/Oq+43C9dJ8bKPFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hh6TC409AfOhRSDCWsVwC/TSFF0cBc8ORkuvRuPhE4HCl0IyItkCwlSVTXLCcUlsV9bsSOILYObiqEgH0I0X1S1Qv5TVvC95ApG3v7nw5Uzx0cB1VxnAk1fx5DsnxF5XTZHhtRvk3bCOGY1q6DDqXI/apS5Ac7/hmRBAmpUbzzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RfFAcVpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0CFC4AF50;
	Tue, 27 Aug 2024 15:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771771;
	bh=MjdOwlu8k2m4tMYjc+i3XWkigAF/Oq+43C9dJ8bKPFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RfFAcVpzaPCN1abBZ3rcJvDSFlHx91SHe6PY0cMqVlo/GXM/BoP5u8L9eiyMaPB+m
	 gqzXq7gJYOu1Nql49aWqTu8FVvVd2dnDi/B/6RAyj1HTgeJMXoFelK4C3+QDmf2kBK
	 wsMfWTEpeO7ksKKu0TLYXk86u6Fup7SjCaoynksA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 016/321] fs/ntfs3: add prefix to bitmap_size() and use BITS_TO_U64()
Date: Tue, 27 Aug 2024 16:35:24 +0200
Message-ID: <20240827143838.824478241@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Lobakin <aleksander.lobakin@intel.com>

commit 3f5ef5109f6a054ce58b3bec7214ed76c9cc269f upstream.

bitmap_size() is a pretty generic name and one may want to use it for
a generic bitmap API function. At the same time, its logic is
NTFS-specific, as it aligns to the sizeof(u64), not the sizeof(long)
(although it uses ideologically right ALIGN() instead of division).
Add the prefix 'ntfs3_' used for that FS (not just 'ntfs_' to not mix
it with the legacy module) and use generic BITS_TO_U64() while at it.

Suggested-by: Yury Norov <yury.norov@gmail.com> # BITS_TO_U64()
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ntfs3/bitmap.c  |    4 ++--
 fs/ntfs3/fsntfs.c  |    2 +-
 fs/ntfs3/index.c   |   11 ++++++-----
 fs/ntfs3/ntfs_fs.h |    4 ++--
 fs/ntfs3/super.c   |    2 +-
 5 files changed, 12 insertions(+), 11 deletions(-)

--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -656,7 +656,7 @@ int wnd_init(struct wnd_bitmap *wnd, str
 	wnd->total_zeroes = nbits;
 	wnd->extent_max = MINUS_ONE_T;
 	wnd->zone_bit = wnd->zone_end = 0;
-	wnd->nwnd = bytes_to_block(sb, bitmap_size(nbits));
+	wnd->nwnd = bytes_to_block(sb, ntfs3_bitmap_size(nbits));
 	wnd->bits_last = nbits & (wbits - 1);
 	if (!wnd->bits_last)
 		wnd->bits_last = wbits;
@@ -1320,7 +1320,7 @@ int wnd_extend(struct wnd_bitmap *wnd, s
 		return -EINVAL;
 
 	/* Align to 8 byte boundary. */
-	new_wnd = bytes_to_block(sb, bitmap_size(new_bits));
+	new_wnd = bytes_to_block(sb, ntfs3_bitmap_size(new_bits));
 	new_last = new_bits & (wbits - 1);
 	if (!new_last)
 		new_last = wbits;
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -493,7 +493,7 @@ static int ntfs_extend_mft(struct ntfs_s
 	ni->mi.dirty = true;
 
 	/* Step 2: Resize $MFT::BITMAP. */
-	new_bitmap_bytes = bitmap_size(new_mft_total);
+	new_bitmap_bytes = ntfs3_bitmap_size(new_mft_total);
 
 	err = attr_set_size(ni, ATTR_BITMAP, NULL, 0, &sbi->mft.bitmap.run,
 			    new_bitmap_bytes, &new_bitmap_bytes, true, NULL);
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1454,8 +1454,8 @@ static int indx_create_allocate(struct n
 
 	alloc->nres.valid_size = alloc->nres.data_size = cpu_to_le64(data_size);
 
-	err = ni_insert_resident(ni, bitmap_size(1), ATTR_BITMAP, in->name,
-				 in->name_len, &bitmap, NULL, NULL);
+	err = ni_insert_resident(ni, ntfs3_bitmap_size(1), ATTR_BITMAP,
+				 in->name, in->name_len, &bitmap, NULL, NULL);
 	if (err)
 		goto out2;
 
@@ -1516,8 +1516,9 @@ static int indx_add_allocate(struct ntfs
 	if (bmp) {
 		/* Increase bitmap. */
 		err = attr_set_size(ni, ATTR_BITMAP, in->name, in->name_len,
-				    &indx->bitmap_run, bitmap_size(bit + 1),
-				    NULL, true, NULL);
+				    &indx->bitmap_run,
+				    ntfs3_bitmap_size(bit + 1), NULL, true,
+				    NULL);
 		if (err)
 			goto out1;
 	}
@@ -2080,7 +2081,7 @@ static int indx_shrink(struct ntfs_index
 	if (err)
 		return err;
 
-	bpb = bitmap_size(bit);
+	bpb = ntfs3_bitmap_size(bit);
 	if (bpb * 8 == nbits)
 		return 0;
 
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -951,9 +951,9 @@ static inline bool run_is_empty(struct r
 }
 
 /* NTFS uses quad aligned bitmaps. */
-static inline size_t bitmap_size(size_t bits)
+static inline size_t ntfs3_bitmap_size(size_t bits)
 {
-	return ALIGN((bits + 7) >> 3, 8);
+	return BITS_TO_U64(bits) * sizeof(u64);
 }
 
 #define _100ns2seconds 10000000
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1108,7 +1108,7 @@ static int ntfs_fill_super(struct super_
 
 	/* Check bitmap boundary. */
 	tt = sbi->used.bitmap.nbits;
-	if (inode->i_size < bitmap_size(tt)) {
+	if (inode->i_size < ntfs3_bitmap_size(tt)) {
 		err = -EINVAL;
 		goto put_inode_out;
 	}



