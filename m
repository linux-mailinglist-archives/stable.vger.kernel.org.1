Return-Path: <stable+bounces-100285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0082E9EA493
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 02:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40341888C1F
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 01:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAA813049E;
	Tue, 10 Dec 2024 01:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JAf/56ZQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1316041C64;
	Tue, 10 Dec 2024 01:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733795871; cv=none; b=De9bfiGbjlINXxWchM6XDJ1xBgh3+7wbXQS/uiVvTfLHH4j10fq4V5TQn8EaYb9m0mEvyB33D5DzEMLjIMeFAKbghzo37YCvv2nZd/gGYcPzes5qLMNIVjr7qbese4z0VxFanViK642zaHGosnigVgf3BgvkYU5NvanupSRNlOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733795871; c=relaxed/simple;
	bh=iTUf1gyrgkG99zCHnSj0k2DtbRvXdQtVSf7dRkcrdsk=;
	h=Date:To:From:Subject:Message-Id; b=Rm/S3FP+cN9v6A6LCQ+Od6OrcL58lMD+ZOIThb5kYiptVusmDbkQM7jSkGr5uDiPmHm1mCDQUQp+DwgDUheLUlhDi3Drm6sTjGDQbJ3ct6nFos39W6I+5C6S5dw0TKVZwVEDkCLqTxO/O/kn77y0h2PXiMCbfRUX56fNnvkSXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JAf/56ZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4C6C4CED1;
	Tue, 10 Dec 2024 01:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733795870;
	bh=iTUf1gyrgkG99zCHnSj0k2DtbRvXdQtVSf7dRkcrdsk=;
	h=Date:To:From:Subject:From;
	b=JAf/56ZQv9ZxLGSpfH2gglIoWa4fVnwkKqxWUPGRdlcJkosbAs+1S3rb2OgC5Tjkx
	 bzTFjmeaVqnMBmt1EL2pt7BkGtLxVRlTUZXt43JcMnWqU+zviBnZ5XCPcKBTvZ6QpB
	 T5/qObBr5IHwjMfBLqiaNoxbs0Bln2t+tHhP0fAE=
Date: Mon, 09 Dec 2024 17:57:49 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,senozhatsky@chromium.org,deshengwu@tencent.com,kasong@tencent.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + zram-fix-uninitialized-zram-not-releasing-backing-device.patch added to mm-hotfixes-unstable branch
Message-Id: <20241210015750.7D4C6C4CED1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: zram: fix uninitialized ZRAM not releasing backing device
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     zram-fix-uninitialized-zram-not-releasing-backing-device.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/zram-fix-uninitialized-zram-not-releasing-backing-device.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Kairui Song <kasong@tencent.com>
Subject: zram: fix uninitialized ZRAM not releasing backing device
Date: Tue, 10 Dec 2024 00:57:16 +0800

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/block/zram/zram_drv.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/block/zram/zram_drv.c~zram-fix-uninitialized-zram-not-releasing-backing-device
+++ a/drivers/block/zram/zram_drv.c
@@ -1444,12 +1444,16 @@ static void zram_meta_free(struct zram *
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
@@ -2334,11 +2338,6 @@ static void zram_reset_device(struct zra
 
 	zram->limit_pages = 0;
 
-	if (!init_done(zram)) {
-		up_write(&zram->init_lock);
-		return;
-	}
-
 	set_capacity_and_notify(zram->disk, 0);
 	part_stat_set_all(zram->disk->part0, 0);
 
_

Patches currently in -mm which might be from kasong@tencent.com are

zram-refuse-to-use-zero-sized-block-device-as-backing-device.patch
zram-fix-uninitialized-zram-not-releasing-backing-device.patch


