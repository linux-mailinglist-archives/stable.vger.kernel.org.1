Return-Path: <stable+bounces-120480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BBFA506E3
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084DB3A6254
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD212505CF;
	Wed,  5 Mar 2025 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N07rBQsD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A11946C7;
	Wed,  5 Mar 2025 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197084; cv=none; b=HOeeH6+VPzQywtKaOp922BpnhuDpm/lzGeyQUXqvXghH5ndtnJ8WUVdh2KcyX9grmlrGlpRF+zLt6ot8UtAmPaSRSP6ZF9VxmoabCYXMdqNc4mggDau3Cq5/P6a2mehJ47jxCU7K0Ast7nlGkEQEj0/TIUTBQlRT2zippqTwdDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197084; c=relaxed/simple;
	bh=8B7xVjJTYBNpcTpycvoHUsRxRrFC2SOwvLAj86P/mMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQByXu7LTsk1gEDoV+q4Gu+U/RMxzzV8Wd+cG/7XMU8pwZv1WNmwxwEsns7J3jFVlnLvchpwDK+aVEn9kMXKdka/yqzn4aEa32j9DeZta8CLdN+LfRRJWp9xaZJxyqYLPsgAaoDo4jMs8NFjWR3sN6GvqN8b1sL/tAI9v4HB3HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N07rBQsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47BDC4CED1;
	Wed,  5 Mar 2025 17:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197083;
	bh=8B7xVjJTYBNpcTpycvoHUsRxRrFC2SOwvLAj86P/mMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N07rBQsDReOJmIhFxhZT+F66dOc++XDLAO4EszVTv3DKdZxhO/Uq+38O5e9f+3kFN
	 RSCbQAOo+AnLiAfJ+sJjdzu9BBmRsWWFYq4Yo1dSgEdV1iP8nw5najijOozoVUoofP
	 KWU9fNgpmu2WK64QtUoOuI1H/4tVlTQ2Lt0Do544=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 005/176] md/md-bitmap: replace md_bitmap_status() with a new helper md_bitmap_get_stats()
Date: Wed,  5 Mar 2025 18:46:14 +0100
Message-ID: <20250305174505.669144197@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
References: <20250305174505.437358097@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 9d8ac04c23462..736268447d3e1 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2022,32 +2022,19 @@ int md_bitmap_copy_from_slot(struct mddev *mddev, int slot,
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
index 3a4750952b3a7..00ac4c3ecf4d9 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -233,6 +233,12 @@ struct bitmap {
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
@@ -243,7 +249,7 @@ void md_bitmap_destroy(struct mddev *mddev);
 
 void md_bitmap_print_sb(struct bitmap *bitmap);
 void md_bitmap_update_sb(struct bitmap *bitmap);
-void md_bitmap_status(struct seq_file *seq, struct bitmap *bitmap);
+int md_bitmap_get_stats(struct bitmap *bitmap, struct md_bitmap_stats *stats);
 
 int  md_bitmap_setallbits(struct bitmap *bitmap);
 void md_bitmap_write_all(struct bitmap *bitmap);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 743244b06f679..887479e0d3afe 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8280,6 +8280,33 @@ static void md_seq_stop(struct seq_file *seq, void *v)
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
@@ -8355,7 +8382,7 @@ static int md_seq_show(struct seq_file *seq, void *v)
 		} else
 			seq_printf(seq, "\n       ");
 
-		md_bitmap_status(seq, mddev->bitmap);
+		md_bitmap_status(seq, mddev);
 
 		seq_printf(seq, "\n");
 	}
-- 
2.39.5




