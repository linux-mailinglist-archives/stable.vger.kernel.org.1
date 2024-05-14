Return-Path: <stable+bounces-44219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A780F8C51CA
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12F7DB22475
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A3A13C690;
	Tue, 14 May 2024 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pCLk4MY5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02E213AD16;
	Tue, 14 May 2024 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685036; cv=none; b=i4X57RjW+hXiK1rSileMU+NHS3OtQp53s2R+kyczmBjygxNtDCqTRc3TDj3SEaLxp6NDllmS7l9WAjM1bg8PrdjnjYPID0puPBlgS6AI7mH1Z6K9mICXsJ0jRH8yiI9gQuaCJMo63/GsrOP+pEkQIjcCRUd7mSgNzgJBOvMo1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685036; c=relaxed/simple;
	bh=auhhlMzPZ13+UDSeFc0ow0lJSpxVchO8CNZleajY4A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntsy6yCQR3Yv5lwGzXx11dclHaLQiifU1/U21gqCHFbm4hfdt3YKxK1PX6Lxy23hHflUe6ubGBf+WGCVg2suqMlidltTcqbmreX87/Vk7mGDxhnKdxuW6GpYsQ9+UYosuGAt89GpYGSdOV/r89RYikj6tOI8y36MER6HoM45Llk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pCLk4MY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829E0C2BD10;
	Tue, 14 May 2024 11:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715685036;
	bh=auhhlMzPZ13+UDSeFc0ow0lJSpxVchO8CNZleajY4A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCLk4MY5JAFWyhTdnqlerL9nXuLdTLliy8cfQKuCve/ptSDSTvpwCdcnrnTvdMw7P
	 OF9PbsK3MaRAF7+lc9EJD+PwaYNKlY9wyBglzUME51D8qMyuYG3ix3A7oyy2dLOYlf
	 xxp2NsY50MMH77qjWE6+61fIq8YOng+ilrj4UpoA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Nan <linan122@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 124/301] block: fix overflow in blk_ioctl_discard()
Date: Tue, 14 May 2024 12:16:35 +0200
Message-ID: <20240514101036.931833527@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
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

From: Li Nan <linan122@huawei.com>

[ Upstream commit 22d24a544b0d49bbcbd61c8c0eaf77d3c9297155 ]

There is no check for overflow of 'start + len' in blk_ioctl_discard().
Hung task occurs if submit an discard ioctl with the following param:
  start = 0x80000000000ff000, len = 0x8000000000fff000;
Add the overflow validation now.

Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20240329012319.2034550-1-linan666@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/ioctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index d1d8e8391279a..68265f914c27b 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -89,7 +89,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 		unsigned long arg)
 {
 	uint64_t range[2];
-	uint64_t start, len;
+	uint64_t start, len, end;
 	struct inode *inode = bdev->bd_inode;
 	int err;
 
@@ -110,7 +110,8 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 	if (len & 511)
 		return -EINVAL;
 
-	if (start + len > bdev_nr_bytes(bdev))
+	if (check_add_overflow(start, len, &end) ||
+	    end > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
 	filemap_invalidate_lock(inode->i_mapping);
-- 
2.43.0




