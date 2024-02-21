Return-Path: <stable+bounces-22037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EC185D9CF
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E678828884E
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C802C7994B;
	Wed, 21 Feb 2024 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qYFIypHu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC453816;
	Wed, 21 Feb 2024 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521761; cv=none; b=OlLv4Da++fhkJkevCiVFMLcqLIEd4YA3wyyPwmuBzIRhZafTW9w6Bdd5EEX8U5cWyvuc3QXpBHAz0emu3KhxfaH9yj+dL9w5sRpr9B/rRmr806QgaMMPc4Jo4gFfBbrpywHR2ciQocp5LE/ixCGuiawHqv3O2T/GVuaXgwfc3JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521761; c=relaxed/simple;
	bh=2ioa0P2FmDNmnlXud1Rnf8Slwjd08PvMAqMJMgBPKAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsivJx1X/eejsrT/u5C178ybI3eaz7NyWCBEgnCPyR4wfSQKY/Fbe2Vlu9Rd77Z3Y7bzN0w/Kdv0+4BNCpjuMjiKymDf4RofyIZO9iRccS97JAa6pmHaYX5EO7srzYSkKqOQ3UalUNauSjdxxMrPWcsDSFOgNjzBcgEnWuBaHkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qYFIypHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A785AC433F1;
	Wed, 21 Feb 2024 13:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708521761;
	bh=2ioa0P2FmDNmnlXud1Rnf8Slwjd08PvMAqMJMgBPKAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qYFIypHuRTzH3YbgNlk2/y/o1td3ZhaQ/yf5y+2QoWSPnysChw00K6JfyfTfysjFh
	 vbRY4p3FyDt793E8vRCzD1Fx+nxwKmmiz9KZ739m4+7IGv2G8kzcEArOM4dL4yYMzw
	 L+AWHVzMpw7Y3qTnhbDFjmRbC1nGCAXpb4K6h6jw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 197/202] Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d"
Date: Wed, 21 Feb 2024 14:08:18 +0100
Message-ID: <20240221125938.154860462@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125931.742034354@linuxfoundation.org>
References: <20240221125931.742034354@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junxiao Bi <junxiao.bi@oracle.com>

[ Upstream commit bed9e27baf52a09b7ba2a3714f1e24e17ced386d ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid5.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index b98abe927d06..e2fcc09a18cd 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -44,7 +44,6 @@
  */
 
 #include <linux/blkdev.h>
-#include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/raid/pq.h>
 #include <linux/async_tx.h>
@@ -6330,18 +6329,7 @@ static void raid5d(struct md_thread *thread)
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
 
-- 
2.43.0




