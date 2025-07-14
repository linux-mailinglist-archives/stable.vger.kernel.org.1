Return-Path: <stable+bounces-161822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D221CB03A50
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 11:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3630C3B48BB
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 09:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2B5237713;
	Mon, 14 Jul 2025 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="03bBtZxi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E87CA6B
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484045; cv=none; b=aHnzyiHM1oUopoXrgoo2PKsqbXhKvIWzXw74p3fzqA/l9tKymZyNDN7225xRz7rx8fOMWe4KdftU6f0mj0Lt55WKYL6XESx+Qz37Tl0lUag3eWW4N0PpIWzmqXj3t/kWQ3dByqTm5rOh74Bq3QSYfmOSxDeaqan5mJTr5UfurYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484045; c=relaxed/simple;
	bh=Auk/+4t3f8asO46bd8qSvv622eyqVnCJPCofCyF+YQI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XoRC8HLpvkQ4dl+iiXcGI2+aoQh51ZuYDGyfTQYIj16PvNtkS4SokJIWwf0e+9dgmVo70t+8Qyy5jfCqtg/UKFhTAESHZyMxSPRcojZxRoiJ1+35lnGPvymP8O0tZzxgvZ/VMu457m68C0HjP6XYP1NCt+z9q2Gw8PsEbKSCB54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=03bBtZxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45949C4CEED;
	Mon, 14 Jul 2025 09:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752484045;
	bh=Auk/+4t3f8asO46bd8qSvv622eyqVnCJPCofCyF+YQI=;
	h=Subject:To:Cc:From:Date:From;
	b=03bBtZxixL7jKpAhYn4J4sg1Xm3HP7SQfTPEk+bVRyIl/1nBWulVu4MmbxS4IAcam
	 XU3XOHFFfsY5t4HHtbe3eoF1/vaI7b5gwdA3DvHYONCegB//4nNpQf4Dxvju7aZjzn
	 3BWr/bHy4Fby7wC0U+odsyuAzKGDEKa1H0vXCxvY=
Subject: FAILED: patch "[PATCH] erofs: fix large fragment handling" failed to apply to 6.12-stable tree
To: xiang@kernel.org,axel@axelfontaine.com,hsiangkao@linux.alibaba.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Jul 2025 11:07:22 +0200
Message-ID: <2025071422-preview-germinate-b2de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b44686c8391b427fb1c85a31c35077e6947c6d90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071422-preview-germinate-b2de@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b44686c8391b427fb1c85a31c35077e6947c6d90 Mon Sep 17 00:00:00 2001
From: Gao Xiang <xiang@kernel.org>
Date: Sat, 12 Jul 2025 03:58:26 +0800
Subject: [PATCH] erofs: fix large fragment handling

Fragments aren't limited by Z_EROFS_PCLUSTER_MAX_DSIZE. However, if
a fragment's logical length is larger than Z_EROFS_PCLUSTER_MAX_DSIZE
but the fragment is not the whole inode, it currently returns
-EOPNOTSUPP because m_flags has the wrong EROFS_MAP_ENCODED flag set.
It is not intended by design but should be rare, as it can only be
reproduced by mkfs with `-Eall-fragments` in a specific case.

Let's normalize fragment m_flags using the new EROFS_MAP_FRAGMENT.

Reported-by: Axel Fontaine <axel@axelfontaine.com>
Closes: https://github.com/erofs/erofs-utils/issues/23
Fixes: 7c3ca1838a78 ("erofs: restrict pcluster size limitations")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20250711195826.3601157-1-hsiangkao@linux.alibaba.com

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 0d19bde8c094..06b867d2fc3b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -315,10 +315,12 @@ static inline struct folio *erofs_grab_folio_nowait(struct address_space *as,
 /* The length of extent is full */
 #define EROFS_MAP_FULL_MAPPED	0x0008
 /* Located in the special packed inode */
-#define EROFS_MAP_FRAGMENT	0x0010
+#define __EROFS_MAP_FRAGMENT	0x0010
 /* The extent refers to partial decompressed data */
 #define EROFS_MAP_PARTIAL_REF	0x0020
 
+#define EROFS_MAP_FRAGMENT	(EROFS_MAP_MAPPED | __EROFS_MAP_FRAGMENT)
+
 struct erofs_map_blocks {
 	struct erofs_buf buf;
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 32e3905e75fe..e3f28a1bb945 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1034,7 +1034,7 @@ static int z_erofs_scan_folio(struct z_erofs_frontend *f,
 		if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 			folio_zero_segment(folio, cur, end);
 			tight = false;
-		} else if (map->m_flags & EROFS_MAP_FRAGMENT) {
+		} else if (map->m_flags & __EROFS_MAP_FRAGMENT) {
 			erofs_off_t fpos = offset + cur - map->m_la;
 
 			err = z_erofs_read_fragment(inode->i_sb, folio, cur,
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 0bebc6e3a4d7..f1a15ff22147 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -413,8 +413,7 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 	    !vi->z_tailextent_headlcn) {
 		map->m_la = 0;
 		map->m_llen = inode->i_size;
-		map->m_flags = EROFS_MAP_MAPPED |
-			EROFS_MAP_FULL_MAPPED | EROFS_MAP_FRAGMENT;
+		map->m_flags = EROFS_MAP_FRAGMENT;
 		return 0;
 	}
 	initial_lcn = ofs >> lclusterbits;
@@ -489,7 +488,7 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 			goto unmap_out;
 		}
 	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
-		map->m_flags |= EROFS_MAP_FRAGMENT;
+		map->m_flags = EROFS_MAP_FRAGMENT;
 	} else {
 		map->m_pa = erofs_pos(sb, m.pblk);
 		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
@@ -617,7 +616,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 	if (lstart < lend) {
 		map->m_la = lstart;
 		if (last && (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
-			map->m_flags |= EROFS_MAP_MAPPED | EROFS_MAP_FRAGMENT;
+			map->m_flags = EROFS_MAP_FRAGMENT;
 			vi->z_fragmentoff = map->m_plen;
 			if (recsz > offsetof(struct z_erofs_extent, pstart_lo))
 				vi->z_fragmentoff |= map->m_pa << 32;
@@ -797,7 +796,7 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
 	iomap->length = map.m_llen;
 	if (map.m_flags & EROFS_MAP_MAPPED) {
 		iomap->type = IOMAP_MAPPED;
-		iomap->addr = map.m_flags & EROFS_MAP_FRAGMENT ?
+		iomap->addr = map.m_flags & __EROFS_MAP_FRAGMENT ?
 			      IOMAP_NULL_ADDR : map.m_pa;
 	} else {
 		iomap->type = IOMAP_HOLE;


