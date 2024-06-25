Return-Path: <stable+bounces-55546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A8A91641D
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3684AB283F6
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D6314A4D2;
	Tue, 25 Jun 2024 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AVf7osTY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86538149DF4;
	Tue, 25 Jun 2024 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309221; cv=none; b=cSzmSOGHb4wAKs15MQpec7gR/On+nSjWKjs1RJl6+7jgxy7Twblw4hv6fdDzxScv9PTTAC1tAy6nYPp//HQLT8mfkKHamhBGSlIqWFlGQlLhtP1avvtc93xwXfALSiYpr7HLWqLe1vYE/UwbvgaNgy4xNRKzU3AsSEhCzzEudv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309221; c=relaxed/simple;
	bh=QqHIiCpGIVkPSUZGKuQkyIOqd3SjY2GF8WVreUcUlp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9HgnezdOnX/H+lXlr+YcIR5tR4YhK11QbDe8luhWUcJHtQH1kTGUIPC25AdlgUnYzye3n1xB3hi9ey1B4hULkvr2xN5TvP5ZSnMSfILPII8g0zrFLazSGKmJQGiQ6qVTxRqTow9NduFsIQcdMFySY9jEpICgafmzn2jUlXP0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AVf7osTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10054C32781;
	Tue, 25 Jun 2024 09:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719309221;
	bh=QqHIiCpGIVkPSUZGKuQkyIOqd3SjY2GF8WVreUcUlp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AVf7osTY0EaLzW5BLzhKs+uW36Kb4xXej/3ClJnV6NO3WAJHeKh5nsrQeuDOSpZbY
	 BmQ8WOThV3bJFp0ITfT0fTUoQZrP8VbTaTU3H47/AwaXGRsGWDQRygF64+xexhd+j6
	 TpwU4HtB+UH9Q1p9kWMjhvFrAnHjgfGuReVej7UU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6 136/192] btrfs: retry block group reclaim without infinite loop
Date: Tue, 25 Jun 2024 11:33:28 +0200
Message-ID: <20240625085542.380239639@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
References: <20240625085537.150087723@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Burkov <boris@bur.io>

commit 4eb4e85c4f818491efc67e9373aa16b123c3f522 upstream.

If inc_block_group_ro systematically fails (e.g. due to ETXTBUSY from
swap) or btrfs_relocate_chunk systematically fails (from lack of
space), then this worker becomes an infinite loop.

At the very least, this strands the cleaner thread, but can also result
in hung tasks/RCU stalls on PREEMPT_NONE kernels and if the
reclaim_bgs_lock mutex is not contended.

I believe the best long term fix is to manage reclaim via work queue,
where we queue up a relocation on the triggering condition and re-queue
on failure. In the meantime, this is an easy fix to apply to avoid the
immediate pain.

Fixes: 7e2718099438 ("btrfs: reinsert BGs failed to reclaim")
CC: stable@vger.kernel.org # 6.6+
Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/block-group.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1788,6 +1788,7 @@ void btrfs_reclaim_bgs_work(struct work_
 		container_of(work, struct btrfs_fs_info, reclaim_bgs_work);
 	struct btrfs_block_group *bg;
 	struct btrfs_space_info *space_info;
+	LIST_HEAD(retry_list);
 
 	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
 		return;
@@ -1924,8 +1925,11 @@ void btrfs_reclaim_bgs_work(struct work_
 		}
 
 next:
-		if (ret)
-			btrfs_mark_bg_to_reclaim(bg);
+		if (ret) {
+			/* Refcount held by the reclaim_bgs list after splice. */
+			btrfs_get_block_group(bg);
+			list_add_tail(&bg->bg_list, &retry_list);
+		}
 		btrfs_put_block_group(bg);
 
 		mutex_unlock(&fs_info->reclaim_bgs_lock);
@@ -1945,6 +1949,9 @@ next:
 	spin_unlock(&fs_info->unused_bgs_lock);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
 end:
+	spin_lock(&fs_info->unused_bgs_lock);
+	list_splice_tail(&retry_list, &fs_info->reclaim_bgs);
+	spin_unlock(&fs_info->unused_bgs_lock);
 	btrfs_exclop_finish(fs_info);
 	sb_end_write(fs_info->sb);
 }



