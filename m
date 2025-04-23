Return-Path: <stable+bounces-135388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8606A98DF5
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D1D445C93
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE2D27FD42;
	Wed, 23 Apr 2025 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JgcyAdy2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A978519DF4C;
	Wed, 23 Apr 2025 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419792; cv=none; b=jfIinUunHstpr4GFDOXlxCFiXk01dlUrET7Dg5snhiRhy5mZPTxx0RkHTIn6ixnU8KBB6Kr2lWkZGBCd5u3jwIzgyfN5ZnexJyyQJJSpy7P2R8yl0hO7KsInJMp7I2OoVAi0SKwOWFpBavxw5RAa84bYvEFrDUCUHVLOiE58E6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419792; c=relaxed/simple;
	bh=klh7CPNNo/EHFbLEczpAYEY64zREzLp+VAP9scqvEWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0Uq7xmqek1DMl+0X3tpP8o4etWZUb4hHihu4q41ehByg55LxFRh1rns4787BPQpzZJ8kfv4jvkeMjsWUx1el281KjdtWPOk4brDDndXnYfM78PaixY64v/ww9ctZ0yHUE6baV2RHuPZrE6MSmfIoFuAGzCMCAh+rEuO/6FTr7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JgcyAdy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BAEC4CEEB;
	Wed, 23 Apr 2025 14:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745419792;
	bh=klh7CPNNo/EHFbLEczpAYEY64zREzLp+VAP9scqvEWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JgcyAdy213TjeE/XWlPdYm+i5tgl4tg3NvIP4Asm1h2psO6kLQNhkPsXPWl5WTewW
	 GCMdvW7uAxvsHVJ65vkuOH1hGTXepzBMREZ1ew8DvDQnTteTndCRlWQfuNVeSQGNHc
	 iQ+y7vLLOGpZevSr6i6rkFVOAo3DhZO0xq8nrViM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zheng Qixing <zhengqixing@huawei.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 010/241] md/md-bitmap: fix stats collection for external bitmaps
Date: Wed, 23 Apr 2025 16:41:14 +0200
Message-ID: <20250423142620.946097356@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
References: <20250423142620.525425242@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zheng Qixing <zhengqixing@huawei.com>

[ Upstream commit 6ec1f0239485028445d213d91cfee5242f3211ba ]

The bitmap_get_stats() function incorrectly returns -ENOENT for external
bitmaps.

Remove the external bitmap check as the statistics should be available
regardless of bitmap storage location.

Return -EINVAL only for invalid bitmap with no storage (neither in
superblock nor in external file).

Note: "bitmap_info.external" here refers to a bitmap stored in a separate
file (bitmap_file), not to external metadata.

Fixes: 8d28d0ddb986 ("md/md-bitmap: Synchronize bitmap_get_stats() with bitmap lifetime")
Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
Link: https://lore.kernel.org/linux-raid/20250403015322.2873369-1-zhengqixing@huaweicloud.com
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md-bitmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 9ae6cc8e30cbd..27409d05f0532 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2355,9 +2355,8 @@ static int bitmap_get_stats(void *data, struct md_bitmap_stats *stats)
 
 	if (!bitmap)
 		return -ENOENT;
-	if (bitmap->mddev->bitmap_info.external)
-		return -ENOENT;
-	if (!bitmap->storage.sb_page) /* no superblock */
+	if (!bitmap->mddev->bitmap_info.external &&
+	    !bitmap->storage.sb_page)
 		return -EINVAL;
 	sb = kmap_local_page(bitmap->storage.sb_page);
 	stats->sync_size = le64_to_cpu(sb->sync_size);
-- 
2.39.5




