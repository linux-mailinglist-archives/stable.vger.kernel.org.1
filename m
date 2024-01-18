Return-Path: <stable+bounces-11907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7C28316E3
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 11:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6B31F26B59
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 10:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA35C2376E;
	Thu, 18 Jan 2024 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="urKwrTly"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CB322F06;
	Thu, 18 Jan 2024 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575068; cv=none; b=b5rHuVFb9GgA9RF/CQBZG1eHFNwPGs0jfnDvEZHUDGcYeXlzqON6i78T1zIG8ycpxrq1E8GqgRdc8omamKJp1Inzy9pNUq7IFEZ3IucNXYWZKaHhQeNerjeBe3Jkz/OwsVf2/2z4G5Hd7bhdGdcmAsiS4rg6obdrUKcHeUCHxf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575068; c=relaxed/simple;
	bh=CjT0Uf8fuBqG02KtLz6BAXGIrwhsl2rrNGRySypaRH8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:User-Agent:X-stable:
	 X-Patchwork-Hint:MIME-Version:Content-Transfer-Encoding; b=Lg5X7pKWQlC108BAsXuGH5yneGezHtMOCSJDNIvg9wRIjy5zpiwDltcVFL7p8HOQtIx4yVMum0HR65VOTn4SFHZyFKtr60q+Rhnr1rPxq1rJziz6LanGD913YgkZEoWa5ePyrM5NlRBiCYX3rKHbTZnSKKXy8E6i/BoVjLaunOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=urKwrTly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B046BC433C7;
	Thu, 18 Jan 2024 10:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705575068;
	bh=CjT0Uf8fuBqG02KtLz6BAXGIrwhsl2rrNGRySypaRH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=urKwrTlyWMAtyXJ5xAdy0iUQOB1wu5n5daQxMHSfk+KgtoXSH7YiMP9PceG9ENhXv
	 huxx4eoEg53xuLJ0LZRjzVYrll4ACgoP21hSKFLHr1A30crgg/qOCxmPn0OhTTy0y9
	 at58tIDMsa5pfzgAJKLEpu5l7/2mHZgcHCMMGLbw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH 6.7 15/28] Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d"
Date: Thu, 18 Jan 2024 11:49:05 +0100
Message-ID: <20240118104301.754560579@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118104301.249503558@linuxfoundation.org>
References: <20240118104301.249503558@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junxiao Bi <junxiao.bi@oracle.com>

commit bed9e27baf52a09b7ba2a3714f1e24e17ced386d upstream.

This reverts commit 5e2cf333b7bd5d3e62595a44d598a254c697cd74.

That commit introduced the following race and can cause system hung.

 md_write_start:             raid5d:
 // mddev->in_sync == 1
 set "MD_SB_CHANGE_PENDING"
                            // running before md_write_start wakeup it
                             waiting "MD_SB_CHANGE_PENDING" cleared
                             >>>>>>>>> hung
 wakeup mddev->thread
 ...
 waiting "MD_SB_CHANGE_PENDING" cleared
 >>>> hung, raid5d should clear this flag
 but get hung by same flag.

The issue reverted commit fixing is fixed by last patch in a new way.

Fixes: 5e2cf333b7bd ("md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d")
Cc: stable@vger.kernel.org # v5.19+
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20231108182216.73611-2-junxiao.bi@oracle.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid5.c |   12 ------------
 1 file changed, 12 deletions(-)

--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -36,7 +36,6 @@
  */
 
 #include <linux/blkdev.h>
-#include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/raid/pq.h>
 #include <linux/async_tx.h>
@@ -6820,18 +6819,7 @@ static void raid5d(struct md_thread *thr
 			spin_unlock_irq(&conf->device_lock);
 			md_check_recovery(mddev);
 			spin_lock_irq(&conf->device_lock);
-
-			/*
-			 * Waiting on MD_SB_CHANGE_PENDING below may deadlock
-			 * seeing md_check_recovery() is needed to clear
-			 * the flag when using mdmon.
-			 */
-			continue;
 		}
-
-		wait_event_lock_irq(mddev->sb_wait,
-			!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags),
-			conf->device_lock);
 	}
 	pr_debug("%d stripes handled\n", handled);
 



