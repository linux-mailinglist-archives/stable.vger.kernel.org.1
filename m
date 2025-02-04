Return-Path: <stable+bounces-112222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD542A27916
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 18:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB6B3A2FC5
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 17:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110602165E7;
	Tue,  4 Feb 2025 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XHuAzA2r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39FE215F5A
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691726; cv=none; b=k4Z08RAz/frTMNWTFO2WZWJFIIxgknRnT/4VpjBsmvK7CuCstsYULIUpdBBkL8qJ2I9E7OxkCLcQHBhf8jV4AoJl7HctMsNc1sbJARceJlbjZYlX46Tidw4kez35zUUgSLgf4D1HoX/K+3cSTB7KqEkWtOaX/TcOmHVRSfxDAwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691726; c=relaxed/simple;
	bh=DjMqdLwJ3sXRr9HQlz01L76iq6vfYZIyhJCLePmOw/E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TCm4SY3Zr4UbWMwrsu4moa/MRNUpsn3vCU4oxoV9nCmAOLJ+loSkxmsGLU0nAzjcjBSgxWQ4ltZgpNj29Gun++tN9RByQhw5u+5G3KmnvLIQNF/GIw44aa1Mv/nkxgdnP58/fPju8K+awFW8Y0+2v6YH0K0wc0C0X+eNYpVBAPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XHuAzA2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A04C4CEDF;
	Tue,  4 Feb 2025 17:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738691726;
	bh=DjMqdLwJ3sXRr9HQlz01L76iq6vfYZIyhJCLePmOw/E=;
	h=Subject:To:Cc:From:Date:From;
	b=XHuAzA2rI6SkJGzhe7z/2CXqPsqnU75qLucGvarDnaeNh6Pz4Qcx07Gd0XrtCqKtp
	 vo92Dt5jxflnWtUImUeaw+crRY52NL7/6zjFAdHhS0m7KQOolvhU057aNjShStHzAE
	 8JNzqzQLjA3zGjVlZdoawttABE+8cREWXtBbIViA=
Subject: FAILED: patch "[PATCH] md/md-bitmap: Synchronize bitmap_get_stats() with bitmap" failed to apply to 6.6-stable tree
To: yukuai3@huawei.com,harshit.m.mogalapalli@oracle.com,song@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Feb 2025 18:55:19 +0100
Message-ID: <2025020419-snippet-epileptic-4280@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8d28d0ddb986f56920ac97ae704cc3340a699a30
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025020419-snippet-epileptic-4280@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


