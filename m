Return-Path: <stable+bounces-112225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D92CA27919
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 18:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A49F166539
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 17:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6BB2165FE;
	Tue,  4 Feb 2025 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ZpOwqhh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F037B21638B
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691737; cv=none; b=id/SigfvbeXn97NEXJ2lzG/D2WqFEDu+VIQEsrOTYWzAuNMXs9f6gHAxTTWy5l2K/zmcQxAQY/NK2XbYstDW3BaZRUTa0OozirY+KkBv6HCdOWeg9aO/VBFqZAJpBhNdyj1a3Th/vV/g3njK1jtWlRJ18cF1fuQGZ+wMUP4CWMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691737; c=relaxed/simple;
	bh=jLxOxSpStlMWtddA4u2/JVgZiGY06hRnfpxOw2fkfK4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pKs7GkgVK9kRsAaaY3sS6MlOxHjB84mIQFYi1oeD3oSL08kdZWMqFurBuuUrM/Q4sp9MIW1wlBHdi6GczkdRlLqI4SR1BfDh6VBMFFWskULozhOZLAmzhHtd8dAPuX0Gn06HBl/yfqJQcY2NrcTJLSA9N1t9zqm2qhXkPyTspG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0ZpOwqhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A56C4CEDF;
	Tue,  4 Feb 2025 17:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738691736;
	bh=jLxOxSpStlMWtddA4u2/JVgZiGY06hRnfpxOw2fkfK4=;
	h=Subject:To:Cc:From:Date:From;
	b=0ZpOwqhh7y4wP2KdXDAmLcWEftDNGcwx0OKhYagyziyV77iy96sHxj0aRCZQuJLcr
	 6Ro4LOiKKtrxuui5YXLu6Q9xfJ4nv1fjUls7dQ+FtR3QKjV06+CCB2KMt+OTYH/hg0
	 MKh2nzTi9nsE5z+W+3IbaZXPSjcBt6+hGXqucnbY=
Subject: FAILED: patch "[PATCH] md/md-bitmap: Synchronize bitmap_get_stats() with bitmap" failed to apply to 5.15-stable tree
To: yukuai3@huawei.com,harshit.m.mogalapalli@oracle.com,song@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Feb 2025 18:55:20 +0100
Message-ID: <2025020420-simile-joyride-42b9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8d28d0ddb986f56920ac97ae704cc3340a699a30
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025020420-simile-joyride-42b9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8d28d0ddb986f56920ac97ae704cc3340a699a30 Mon Sep 17 00:00:00 2001
From: Yu Kuai <yukuai3@huawei.com>
Date: Fri, 24 Jan 2025 17:20:55 +0800
Subject: [PATCH] md/md-bitmap: Synchronize bitmap_get_stats() with bitmap
 lifetime

After commit ec6bb299c7c3 ("md/md-bitmap: add 'sync_size' into struct
md_bitmap_stats"), following panic is reported:

Oops: general protection fault, probably for non-canonical address
RIP: 0010:bitmap_get_stats+0x2b/0xa0
Call Trace:
 <TASK>
 md_seq_show+0x2d2/0x5b0
 seq_read_iter+0x2b9/0x470
 seq_read+0x12f/0x180
 proc_reg_read+0x57/0xb0
 vfs_read+0xf6/0x380
 ksys_read+0x6c/0xf0
 do_syscall_64+0x82/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Root cause is that bitmap_get_stats() can be called at anytime if mddev
is still there, even if bitmap is destroyed, or not fully initialized.
Deferenceing bitmap in this case can crash the kernel. Meanwhile, the
above commit start to deferencing bitmap->storage, make the problem
easier to trigger.

Fix the problem by protecting bitmap_get_stats() with bitmap_info.mutex.

Cc: stable@vger.kernel.org # v6.12+
Fixes: 32a7627cf3a3 ("[PATCH] md: optimised resync using Bitmap based intent logging")
Reported-and-tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Closes: https://lore.kernel.org/linux-raid/ca3a91a2-50ae-4f68-b317-abd9889f3907@oracle.com/T/#m6e5086c95201135e4941fe38f9efa76daf9666c5
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20250124092055.4050195-1-yukuai1@huaweicloud.com
Signed-off-by: Song Liu <song@kernel.org>

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index ec4ecd96e6b1..23c09d22fcdb 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2355,7 +2355,10 @@ static int bitmap_get_stats(void *data, struct md_bitmap_stats *stats)
 
 	if (!bitmap)
 		return -ENOENT;
-
+	if (bitmap->mddev->bitmap_info.external)
+		return -ENOENT;
+	if (!bitmap->storage.sb_page) /* no superblock */
+		return -EINVAL;
 	sb = kmap_local_page(bitmap->storage.sb_page);
 	stats->sync_size = le64_to_cpu(sb->sync_size);
 	kunmap_local(sb);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 866015b681af..465ca2af1e6e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8376,6 +8376,10 @@ static int md_seq_show(struct seq_file *seq, void *v)
 		return 0;
 
 	spin_unlock(&all_mddevs_lock);
+
+	/* prevent bitmap to be freed after checking */
+	mutex_lock(&mddev->bitmap_info.mutex);
+
 	spin_lock(&mddev->lock);
 	if (mddev->pers || mddev->raid_disks || !list_empty(&mddev->disks)) {
 		seq_printf(seq, "%s : ", mdname(mddev));
@@ -8451,6 +8455,7 @@ static int md_seq_show(struct seq_file *seq, void *v)
 		seq_printf(seq, "\n");
 	}
 	spin_unlock(&mddev->lock);
+	mutex_unlock(&mddev->bitmap_info.mutex);
 	spin_lock(&all_mddevs_lock);
 
 	if (mddev == list_last_entry(&all_mddevs, struct mddev, all_mddevs))


