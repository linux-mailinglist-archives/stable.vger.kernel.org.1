Return-Path: <stable+bounces-105575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10EC9FAD0B
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 11:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2579B164DF3
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 10:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F1218F2DA;
	Mon, 23 Dec 2024 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="05yKk2Nu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009F517BB35
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734949059; cv=none; b=dT6Ux5e9gVQOE/PBnm2SHCvYm1ghHQwaHHHNqb6MKfh5akIDXZTGsIYEAibu88HKasWOR9M0/4bJLq4XNLbHHGTFmTSXcSn7mgxrWJsHIxziaC1HlS6CO+hZ7jBrugYo5KGpJsJ/o58RhkQX5H4J+KrHlcgTEiBOViZe/pvBS4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734949059; c=relaxed/simple;
	bh=Rsihdq8eY/qq1olqR9AfJenbbsXtrt5A03WxUUeAOps=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S70Qvq+jWB5rGWvPgPi5LoXaZ3mGXHLHTsTxh2qBER18tMlVI66KwXEEWaXiAVDg5wSS9RJpP9DpbXB6tq+9DYVDYaMh7oy2vnPZb1q5djYMalf9rhhDCnOILyCd7iLbeO87Ikb3XGHmJH2fLIXTiLVqwgTTilip4mBMdIWmIVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=05yKk2Nu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF394C4CED3;
	Mon, 23 Dec 2024 10:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734949058;
	bh=Rsihdq8eY/qq1olqR9AfJenbbsXtrt5A03WxUUeAOps=;
	h=Subject:To:Cc:From:Date:From;
	b=05yKk2Nu7iUGCmHi0fba7bLPmIcAySxt+wBv9APp5S4NMeQGVXdw7vrYIXit+dsWm
	 dMfNkFB/Pu5r9BR/udZgfKTA3ldO0rZj4N4eUFInETlQ9NFY7gXIGoeHUcRhL2frwn
	 LJDcCFV8hBnhPrUyU44Q4lsO4QIP1XxJb1qGN8TM=
Subject: FAILED: patch "[PATCH] zram: fix uninitialized ZRAM not releasing backing device" failed to apply to 5.15-stable tree
To: kasong@tencent.com,akpm@linux-foundation.org,deshengwu@tencent.com,senozhatsky@chromium.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Dec 2024 11:17:35 +0100
Message-ID: <2024122335-italicize-barge-aaae@gregkh>
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
git cherry-pick -x 74363ec674cb172d8856de25776c8f3103f05e2f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122335-italicize-barge-aaae@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 74363ec674cb172d8856de25776c8f3103f05e2f Mon Sep 17 00:00:00 2001
From: Kairui Song <kasong@tencent.com>
Date: Tue, 10 Dec 2024 00:57:16 +0800
Subject: [PATCH] zram: fix uninitialized ZRAM not releasing backing device

Setting backing device is done before ZRAM initialization.  If we set the
backing device, then remove the ZRAM module without initializing the
device, the backing device reference will be leaked and the device will be
hold forever.

Fix this by always reset the ZRAM fully on rmmod or reset store.

Link: https://lkml.kernel.org/r/20241209165717.94215-3-ryncsn@gmail.com
Fixes: 013bf95a83ec ("zram: add interface to specif backing device")
Signed-off-by: Kairui Song <kasong@tencent.com>
Reported-by: Desheng Wu <deshengwu@tencent.com>
Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e86cc3d2f4d2..45df5eeabc5e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1444,12 +1444,16 @@ static void zram_meta_free(struct zram *zram, u64 disksize)
 	size_t num_pages = disksize >> PAGE_SHIFT;
 	size_t index;
 
+	if (!zram->table)
+		return;
+
 	/* Free all pages that are still in this zram device */
 	for (index = 0; index < num_pages; index++)
 		zram_free_page(zram, index);
 
 	zs_destroy_pool(zram->mem_pool);
 	vfree(zram->table);
+	zram->table = NULL;
 }
 
 static bool zram_meta_alloc(struct zram *zram, u64 disksize)
@@ -2326,11 +2330,6 @@ static void zram_reset_device(struct zram *zram)
 
 	zram->limit_pages = 0;
 
-	if (!init_done(zram)) {
-		up_write(&zram->init_lock);
-		return;
-	}
-
 	set_capacity_and_notify(zram->disk, 0);
 	part_stat_set_all(zram->disk->part0, 0);
 


