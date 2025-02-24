Return-Path: <stable+bounces-118999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C42A423DB
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912B0440200
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2A5254873;
	Mon, 24 Feb 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PQuBmG3m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6B625485E;
	Mon, 24 Feb 2025 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407975; cv=none; b=StOBkuRt0CydRMmeR7fGoMgOgd8s4hGlNM1HpRepvoBW4SNMZ5gq/ozWFBmR+m55ttMtcFHWDo8WejEseFdCACtSKmubLrxZ2dGPCKZWt+1zmdwg10xdY8z1s9X+bWj6dBglUZmmt/kc19IdTRgo597AMtlc1Du6dv7wViLGI9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407975; c=relaxed/simple;
	bh=IhH5t6vVpn1YL3Hr2HLGRvpg/FUl1tgBiYYletTEaIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXHCWy/HKqyGH65X4kJDDexCrecvmjDeKdNnNc7P28kboe0lNue2C3y9W3caqLB3CAcLEpJCvladdPsnO8ar3GdCubgdGC5d4qOJtAGHhxto99c0hxB9VcjT6gds3QyY2p7tGnicBWIRHom1BkCMRnDJGRFgOE0KnjOKredC1f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PQuBmG3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343C1C4CED6;
	Mon, 24 Feb 2025 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740407975;
	bh=IhH5t6vVpn1YL3Hr2HLGRvpg/FUl1tgBiYYletTEaIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQuBmG3mkagak/jbzkrwhCyrm++0vZXp9yf6iWluvO5q0w5ukjoFIb54QzdHrNaYf
	 mGmpGrGD825ZNEe91/v1SKwq33d7X3QD6agnaa1ZXYI3evgr8ZTB1kc/SFn9N8fEZS
	 S4pGP2iX6svwEZThi1CET7mtawe5mDUiXFJo1eUs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 031/140] md/md-bitmap: replace md_bitmap_status() with a new helper md_bitmap_get_stats()
Date: Mon, 24 Feb 2025 15:33:50 +0100
Message-ID: <20250224142604.230987839@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142602.998423469@linuxfoundation.org>
References: <20250224142602.998423469@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 38f287d7e495ae00d4481702f44ff7ca79f5c9bc ]

There are no functional changes, and the new helper will be used in
multiple places in following patches to avoid dereferencing bitmap
directly.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20240826074452.1490072-3-yukuai1@huaweicloud.com
Signed-off-by: Song Liu <song@kernel.org>
Stable-dep-of: 8d28d0ddb986 ("md/md-bitmap: Synchronize bitmap_get_stats() with bitmap lifetime")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md-bitmap.c | 25 ++++++-------------------
 drivers/md/md-bitmap.h |  8 +++++++-
 drivers/md/md.c        | 29 ++++++++++++++++++++++++++++-
 3 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 2085b1705f144..f7b02d87a6da7 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2112,32 +2112,19 @@ int md_bitmap_copy_from_slot(struct mddev *mddev, int slot,
 }
 EXPORT_SYMBOL_GPL(md_bitmap_copy_from_slot);
 
-
-void md_bitmap_status(struct seq_file *seq, struct bitmap *bitmap)
+int md_bitmap_get_stats(struct bitmap *bitmap, struct md_bitmap_stats *stats)
 {
-	unsigned long chunk_kb;
 	struct bitmap_counts *counts;
 
 	if (!bitmap)
-		return;
+		return -ENOENT;
 
 	counts = &bitmap->counts;
+	stats->missing_pages = counts->missing_pages;
+	stats->pages = counts->pages;
+	stats->file = bitmap->storage.file;
 
-	chunk_kb = bitmap->mddev->bitmap_info.chunksize >> 10;
-	seq_printf(seq, "bitmap: %lu/%lu pages [%luKB], "
-		   "%lu%s chunk",
-		   counts->pages - counts->missing_pages,
-		   counts->pages,
-		   (counts->pages - counts->missing_pages)
-		   << (PAGE_SHIFT - 10),
-		   chunk_kb ? chunk_kb : bitmap->mddev->bitmap_info.chunksize,
-		   chunk_kb ? "KB" : "B");
-	if (bitmap->storage.file) {
-		seq_printf(seq, ", file: ");
-		seq_file_path(seq, bitmap->storage.file, " \t\n");
-	}
-
-	seq_printf(seq, "\n");
+	return 0;
 }
 
 int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 8b89e260a93b7..60b86ee939081 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -234,6 +234,12 @@ struct bitmap {
 	int cluster_slot;		/* Slot offset for clustered env */
 };
 
+struct md_bitmap_stats {
+	unsigned long	missing_pages;
+	unsigned long	pages;
+	struct file	*file;
+};
+
 /* the bitmap API */
 
 /* these are used only by md/bitmap */
@@ -244,7 +250,7 @@ void md_bitmap_destroy(struct mddev *mddev);
 
 void md_bitmap_print_sb(struct bitmap *bitmap);
 void md_bitmap_update_sb(struct bitmap *bitmap);
-void md_bitmap_status(struct seq_file *seq, struct bitmap *bitmap);
+int md_bitmap_get_stats(struct bitmap *bitmap, struct md_bitmap_stats *stats);
 
 int  md_bitmap_setallbits(struct bitmap *bitmap);
 void md_bitmap_write_all(struct bitmap *bitmap);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 27a6a11b71ee4..b73649fd8e039 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8290,6 +8290,33 @@ static void md_seq_stop(struct seq_file *seq, void *v)
 	spin_unlock(&all_mddevs_lock);
 }
 
+static void md_bitmap_status(struct seq_file *seq, struct mddev *mddev)
+{
+	struct md_bitmap_stats stats;
+	unsigned long used_pages;
+	unsigned long chunk_kb;
+	int err;
+
+	err = md_bitmap_get_stats(mddev->bitmap, &stats);
+	if (err)
+		return;
+
+	chunk_kb = mddev->bitmap_info.chunksize >> 10;
+	used_pages = stats.pages - stats.missing_pages;
+
+	seq_printf(seq, "bitmap: %lu/%lu pages [%luKB], %lu%s chunk",
+		   used_pages, stats.pages, used_pages << (PAGE_SHIFT - 10),
+		   chunk_kb ? chunk_kb : mddev->bitmap_info.chunksize,
+		   chunk_kb ? "KB" : "B");
+
+	if (stats.file) {
+		seq_puts(seq, ", file: ");
+		seq_file_path(seq, stats.file, " \t\n");
+	}
+
+	seq_putc(seq, '\n');
+}
+
 static int md_seq_show(struct seq_file *seq, void *v)
 {
 	struct mddev *mddev = list_entry(v, struct mddev, all_mddevs);
@@ -8365,7 +8392,7 @@ static int md_seq_show(struct seq_file *seq, void *v)
 		} else
 			seq_printf(seq, "\n       ");
 
-		md_bitmap_status(seq, mddev->bitmap);
+		md_bitmap_status(seq, mddev);
 
 		seq_printf(seq, "\n");
 	}
-- 
2.39.5




