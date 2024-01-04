Return-Path: <stable+bounces-9735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DD4824AF5
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 23:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0301EB2124E
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 22:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F2B2C681;
	Thu,  4 Jan 2024 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ATld5RB6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A82BD12
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d9af1f12d5so723729b3a.3
        for <stable@vger.kernel.org>; Thu, 04 Jan 2024 14:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704407899; x=1705012699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JilSBw4whEPYu6Fz7K5M4ffeN115rBMZFFEBtmJZaks=;
        b=ATld5RB6imfNObkCScFw/zGZL5J2N55tMgp284N6xkzI9MkpqHMBL95c42iurUc423
         9JkQo2gVymDNsj5XNVdWhbmoHP1l/z7w1VTwA8rBD/t+/GHa1MYEZV3vv/MzP1ENIc5l
         k9zalk2pXNjnmHtW6u84T4QLNcEaDk2uFbfOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704407899; x=1705012699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JilSBw4whEPYu6Fz7K5M4ffeN115rBMZFFEBtmJZaks=;
        b=YXYdkieqcCH9TVKR1KfJUd8GRKfQUYEhYqzTdRb7qc8SOn0NTknGmkkcn1JdDsXtdb
         xMlpGKB6KvrqIKJWUvQ4K76lcE+UwXIpgkMRxdRVmRjcVsL9xKmYDooU0cMj861V/ilZ
         /0j8UjzZ08lsK7KERcNQ3JZJgTYN86TTIKA1jhSaKNEeJWLGOvY2m5W59ZwuUG7Ip9HZ
         XTAHnJyXrGBpZ84gzDrSt0SA6Zgy6f0gVqWtDkUfPpe70VwKiSjrrldobvCDzTcmH+ON
         GmRxMmHkb8OEvuHsldAwNFZE5aFN0PACsRFWvRNnM1qCHFIp66nttoW5CeNRaa+51wbF
         2zvg==
X-Gm-Message-State: AOJu0Yw8n38opDS/4QhnUjDz+yp+PDErS1n8GCCuuVzQbksFoJo2NcYC
	F/RYarvhGyn0nYiV5ujyrdvDqqkQjjh8veCxYXMResRkeg==
X-Google-Smtp-Source: AGHT+IF2vGUeourNtRNho+6Ab1IjmFUvMavl/lv3cYYHw7bFcMcc5mOjFQ9G8m0v9OnPScTP9eFZww==
X-Received: by 2002:a05:6a20:2d95:b0:199:1977:5d3e with SMTP id bf21-20020a056a202d9500b0019919775d3emr922029pzb.33.1704407899627;
        Thu, 04 Jan 2024 14:38:19 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:c642:5162:9986:5b8b])
        by smtp.gmail.com with UTF8SMTPSA id u29-20020a056a00099d00b006d9a38fe569sm157793pfg.89.2024.01.04.14.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 14:38:19 -0800 (PST)
From: Sarthak Kukreti <sarthakkukreti@chromium.org>
To: stable@vger.kernel.org
Cc: Sarthak Kukreti <sarthakkukreti@chromium.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4.y] block: Don't invalidate pagecache for invalid falloc modes
Date: Thu,  4 Jan 2024 14:38:16 -0800
Message-ID: <20240104223816.1864056-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <2023101515-buffing-copy-1686@gregkh>
References: <2023101515-buffing-copy-1686@gregkh>
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
index fa329c7eddf0..e528ad860143 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2114,21 +2114,26 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
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


