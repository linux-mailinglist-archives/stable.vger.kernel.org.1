Return-Path: <stable+bounces-9734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23339824AE6
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 23:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A661AB23D50
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 22:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F313E1F927;
	Thu,  4 Jan 2024 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LNnGZK7w"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566E92C6A8
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 22:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59600dbfb58so439751eaf.1
        for <stable@vger.kernel.org>; Thu, 04 Jan 2024 14:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704407578; x=1705012378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfydtHSDgeC/ZN/QFb9eTDddYSw3rQjSXWby+tjt3bs=;
        b=LNnGZK7wQtDruutMiZpT3B6XBzG+ZrPVxatdG7rPbU7ezDdQv5qXqhTaRNA+6m52T2
         QZhlWkSk1M9ttXEZIXkRiWGjcsahNEDxkww/qjO6zPyTerutjBSFadvwdvmw6vGQeiWy
         qv3z7lT9r4x1TTUeiF4wbyMe4h0YyXzTUzULE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704407578; x=1705012378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfydtHSDgeC/ZN/QFb9eTDddYSw3rQjSXWby+tjt3bs=;
        b=oAaD9WXPfUNRRIszOlYkWtDof60jNA73LAPTpAPPW9VRpwm2g+9H4qFdk2EwSpcoMz
         6+mLr8rGUjkn7kvWFmab2NE9dGuodUw3Dzm5uvRHybjfHYxXHAxMhvcEPvdrY8vXepFG
         pxwxLLeGXWPQ4OdNZlA0WZ+PQrabwI5XU+kzta1gLv4m9OjKO/T54UCamu6IXioCwfUk
         L9Q4PG7JYlGiHSrdyZxrbuNnonG6CU6ggcCh1fMw7Yf5TbWTzTbCHc7R28k51FsMN/gv
         m+rz68tk4jEG7D/j//zlRl5l2dQ03QOtuSaJUBBOvrEDNZ+J884/CwDWUDYsVPYZLuGC
         8rzg==
X-Gm-Message-State: AOJu0Yz30AAYiI1M0bAxhzdOjECRTLptDrdlHkSmG/aGUlvr+IXKObbw
	Ex7IHVZArPIK+iio7B87DxeMaE5HtAN/rfp3LatZlnGC4g==
X-Google-Smtp-Source: AGHT+IH2fskj2l3dx1tRnTww6XZhlBsgT1t2kkTnlGbhoWOSdFWvvRstYxeeZ+f1/T5B2lXzATfKjA==
X-Received: by 2002:a05:6358:6f1b:b0:174:b7f1:4302 with SMTP id r27-20020a0563586f1b00b00174b7f14302mr1434635rwn.61.1704407577966;
        Thu, 04 Jan 2024 14:32:57 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:c642:5162:9986:5b8b])
        by smtp.gmail.com with UTF8SMTPSA id f33-20020a635561000000b005c6aa4d4a0dsm169618pgm.45.2024.01.04.14.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 14:32:57 -0800 (PST)
From: Sarthak Kukreti <sarthakkukreti@chromium.org>
To: stable@vger.kernel.org
Cc: Sarthak Kukreti <sarthakkukreti@chromium.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19.y] block: Don't invalidate pagecache for invalid falloc modes
Date: Thu,  4 Jan 2024 14:32:54 -0800
Message-ID: <20240104223254.1816165-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <2023101516-genetics-gratify-225c@gregkh>
References: <2023101516-genetics-gratify-225c@gregkh>
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
 fs/block_dev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index b34f76af59c4..5c6ff1572405 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2041,21 +2041,26 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	/* Invalidate the page cache, including dirty pages. */
+	/*
+	 * Invalidate the page cache, including dirty pages, for valid
+	 * de-allocate mode calls to fallocate().
+	 */
 	mapping = bdev->bd_inode->i_mapping;
-	truncate_inode_pages_range(mapping, start, end);
 
 	switch (mode) {
 	case FALLOC_FL_ZERO_RANGE:
 	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
+		truncate_inode_pages_range(mapping, start, end);
 		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
 					    GFP_KERNEL, BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+		truncate_inode_pages_range(mapping, start, end);
 		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
+		truncate_inode_pages_range(mapping, start, end);
 		error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, 0);
 		break;
-- 
2.43.0.472.g3155946c3a-goog


