Return-Path: <stable+bounces-112390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8631CA28C78
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7903A2C08
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A79142E86;
	Wed,  5 Feb 2025 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kF8ocKcr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F5126C18;
	Wed,  5 Feb 2025 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763413; cv=none; b=Jadn4uevtjvnVn67nJRLNZr+Fq+oAqs+EKA9ubkILRH0BNx0LFmv+N/FjIZOjU5k4VGdfBRgMSl0uUSvvs9yrlZ1yCUZSCATy9d9OLvdeKGFtAElNDoYV2PN7QJ0jjEEpMi17bD0fNCNSvJl57MAx5BS9gaD479vDpi0E7Pjlis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763413; c=relaxed/simple;
	bh=0z+voExZYlBio4+RpZtNcfDAaM043turGWffPe0/arQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3Q8yYdEPXJvrIByYXKjLHE67CIN3qRW6eIzFiF5gXksx4kSVcHHu/KBJhjYqJ1k6PrJ+2xyueG81vwgN7NNK2HrAnUxMGTXdYCXRkfZwOUP//2FhYC4PKFbhkHrdx/7Bw4Tgxh55PJFdupIirLZDsPB07wPwNXhXfBrY38Tcu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kF8ocKcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59EAC4CEDD;
	Wed,  5 Feb 2025 13:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738763413;
	bh=0z+voExZYlBio4+RpZtNcfDAaM043turGWffPe0/arQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kF8ocKcro0JLuVGyJcqXNEj/eXFzMVT81wCg9qRrWN7lGVRBzr6h4BFi6NGccQahs
	 pvOHHEt22UPus91d9HjuJj4Q/bEMlpph0lTw80+0pgy5VVh7rpBMVgDh3+ymQ5rt/g
	 n3NMabVfu3xC7RnDgl8fWzDzDwn2s94wFGZVDvEM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Yang Erkun <yangerkun@huawei.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 010/590] block: retry call probe after request_module in blk_request_module
Date: Wed,  5 Feb 2025 14:36:05 +0100
Message-ID: <20250205134455.626980507@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Erkun <yangerkun@huawei.com>

[ Upstream commit 457ef47c08d2979f3e59ce66267485c3faed70c8 ]

Set kernel config:

 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_LOOP_MIN_COUNT=0

Do latter:

 mknod loop0 b 7 0
 exec 4<> loop0

Before commit e418de3abcda ("block: switch gendisk lookup to a simple
xarray"), lookup_gendisk will first use base_probe to load module loop,
and then the retry will call loop_probe to prepare the loop disk. Finally
open for this disk will success. However, after this commit, we lose the
retry logic, and open will fail with ENXIO. Block device autoloading is
deprecated and will be removed soon, but maybe we should keep open success
until we really remove it. So, give a retry to fix it.

Fixes: e418de3abcda ("block: switch gendisk lookup to a simple xarray")
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20241209110435.3670985-1-yangerkun@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/genhd.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 8645cf3b0816e..99344f53c7897 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -778,7 +778,7 @@ static ssize_t disk_badblocks_store(struct device *dev,
 }
 
 #ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
-void blk_request_module(dev_t devt)
+static bool blk_probe_dev(dev_t devt)
 {
 	unsigned int major = MAJOR(devt);
 	struct blk_major_name **n;
@@ -788,14 +788,26 @@ void blk_request_module(dev_t devt)
 		if ((*n)->major == major && (*n)->probe) {
 			(*n)->probe(devt);
 			mutex_unlock(&major_names_lock);
-			return;
+			return true;
 		}
 	}
 	mutex_unlock(&major_names_lock);
+	return false;
+}
+
+void blk_request_module(dev_t devt)
+{
+	int error;
+
+	if (blk_probe_dev(devt))
+		return;
 
-	if (request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt)) > 0)
-		/* Make old-style 2.4 aliases work */
-		request_module("block-major-%d", MAJOR(devt));
+	error = request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt));
+	/* Make old-style 2.4 aliases work */
+	if (error > 0)
+		error = request_module("block-major-%d", MAJOR(devt));
+	if (!error)
+		blk_probe_dev(devt);
 }
 #endif /* CONFIG_BLOCK_LEGACY_AUTOLOAD */
 
-- 
2.39.5




