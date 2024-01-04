Return-Path: <stable+bounces-9740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B589F824B44
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 23:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE931C22462
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 22:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C822D05A;
	Thu,  4 Jan 2024 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nnYAwOEd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB42D02B
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so760765a12.1
        for <stable@vger.kernel.org>; Thu, 04 Jan 2024 14:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704409056; x=1705013856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0xphhCE17SpyYQoGsUBG8Xw3xXoJ8LzymxUK0emg8Y=;
        b=nnYAwOEdUo+djnN8WAV6981Cuuo31WZBEnDeFTWZ/q3csq9thmG7JBVSpr0qHfHx8v
         JG9Q6dr4OdwkyN2vSgzPzEn/4yPSjkOI/RWFUJuEYQ8HuE9GWAGODofAlQo0naZ/DQGx
         J4kfx4uiS26JN/e1MQbAZJKziAntrNlxKqf7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704409056; x=1705013856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0xphhCE17SpyYQoGsUBG8Xw3xXoJ8LzymxUK0emg8Y=;
        b=E8MlnlLtTRRO9olQXdzqabHTjbB6VjixWa4M4n0NqEZUP0tIlRI7tig+sMy+l8fZkr
         AajptC2RZa82FkqpIdq9fdjRkpZXq8Gzxv7FmWhUVWlHaNl+rM6agaCxDZZzsE3d87NI
         T8JnXuPfRcQtvi8mK+Zfb2u6wfOVpp2LeM9GFkEvI4Q8oSgrfUbgpsg0r3YwaEOco8IM
         tcuzjDMB7cfL6ItOS2t2pD3fkn7TwnAMrJ5k2kMk7WW2hM+S0HoDFlRY428iqjiyWkkM
         cW2jIqGpAphnJ1xPgcA4zRt6Hu1dZcuG3C1neDceyXZB5FsPByx6mtvFAxnyghZx+jIF
         MfEg==
X-Gm-Message-State: AOJu0YyC/mZgLoGAXIi2lSc34EAf8FjaJMiKVp74TUepr/z4BGUgBiK5
	wyoknDc33VPxkkAItZyEu6IVvoytJJxW5LUKgDfiP2KTLw==
X-Google-Smtp-Source: AGHT+IER3kWpjFvqhiONKYcT6reomulZYTjVxJi0ejh4vtPPkw0BNoBU0H8+KqfumzRsLcSi68s2rA==
X-Received: by 2002:a05:6a20:4288:b0:199:431:ba28 with SMTP id o8-20020a056a20428800b001990431ba28mr1357678pzj.74.1704409056464;
        Thu, 04 Jan 2024 14:57:36 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:c642:5162:9986:5b8b])
        by smtp.gmail.com with UTF8SMTPSA id f50-20020a056a000b3200b006d9b2d86bcasm177557pfu.46.2024.01.04.14.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 14:57:36 -0800 (PST)
From: Sarthak Kukreti <sarthakkukreti@chromium.org>
To: stable@vger.kernel.org
Cc: Sarthak Kukreti <sarthakkukreti@chromium.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1.y] block: Don't invalidate pagecache for invalid falloc modes
Date: Thu,  4 Jan 2024 14:57:33 -0800
Message-ID: <20240104225733.2021982-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <2023101511-outpost-crucial-c477@gregkh>
References: <2023101511-outpost-crucial-c477@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only call truncate_bdev_range() if the fallocate mode is supported. This
fixes a bug where data in the pagecache could be invalidated if the
fallocate() was called on the block device with an invalid mode.

Fixes: 25f4c41415e5 ("block: implement (some of) fallocate for block devices")
Cc: stable@vger.kernel.org
Reported-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Link: https://lore.kernel.org/r/20231011201230.750105-1-sarthakkukreti@chromium.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
(cherry picked from commit 1364a3c391aedfeb32aa025303ead3d7c91cdf9d)
Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 block/fops.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 6197d1c41652..01cb6260fa24 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -655,24 +655,35 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
 	filemap_invalidate_lock(inode->i_mapping);
 
-	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file->f_mode, start, end);
-	if (error)
-		goto fail;
-
+	/*
+	 * Invalidate the page cache, including dirty pages, for valid
+	 * de-allocate mode calls to fallocate().
+	 */
 	switch (mode) {
 	case FALLOC_FL_ZERO_RANGE:
 	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL);
 		break;
-- 
2.43.0.472.g3155946c3a-goog


