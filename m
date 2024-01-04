Return-Path: <stable+bounces-9736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CFC824B24
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 23:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369DF285916
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 22:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590392CCB2;
	Thu,  4 Jan 2024 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QBSUMdW2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13A32D61A
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28c0536806fso827297a91.0
        for <stable@vger.kernel.org>; Thu, 04 Jan 2024 14:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704408376; x=1705013176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5saOzn+yoJIzJcV96SCVWHj3tbgytbdHtkZx2VfHHtI=;
        b=QBSUMdW2qmMD0AC8kjb+b0CoNpLYWLI/148A8A9L5FgqR7v4lQNDPswKh7XEF0Q94n
         GWbYMwXxrupVpbLysQCQbqAWpa7aXnsIOQAkW7sZ9udM9zwQMrrwQhL9L7X5xTbtBtHC
         ORnPnORS4POZUzrWR5WoZ7jKqJ1dfBNO/COBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704408376; x=1705013176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5saOzn+yoJIzJcV96SCVWHj3tbgytbdHtkZx2VfHHtI=;
        b=AvaKUsmxcLOEPCqGQkPn4aV1uLszJP6IM1Q2Xqt9rZXF0eBmnbu1VAtHnCBr8G76Rp
         d1sY0VeqvHgTRW5P1eV93hszuyysAs8kVXBfLnlfuFHdwda/H/mp8DlVNNEa4HmOtpXj
         JAkWzwqPB69ILxJTnT00CTKOBU3N0eIeNu2nd1STi0uYa8ldvi3FcBa4FoDPBOHQU/mu
         pt9DWA+mBXGQpYbvU0L9CGjPvKvjrCErgnjYRPeOH/KsMyrZMqD5KgDC7a3boUHAvt9B
         90Hr7jcHWXQLQqWM/n3Tighw3sUgFN2yPlXpruOly2ZJ47B+d47WJCVfczZIWSLqPo8W
         5yCw==
X-Gm-Message-State: AOJu0Yxp1/kCN0v4B/G2b3tf/fkH0Yg+6u49dUT7KTCbN6rY06U3piAh
	WIaYkIsO6zEFKb6lLVz08NU2qHiB8SXnkGj/Daz9s9VO5A==
X-Google-Smtp-Source: AGHT+IF5Apbtm3G4jyRbBnVRBTVeAtMdf8pkGDONcDKsh/0yzGwvYyOXklzPY8w/lRH7ZO0V/Sl/OQ==
X-Received: by 2002:a17:90a:c485:b0:28c:a31f:e5c6 with SMTP id j5-20020a17090ac48500b0028ca31fe5c6mr1150407pjt.99.1704408376347;
        Thu, 04 Jan 2024 14:46:16 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:c642:5162:9986:5b8b])
        by smtp.gmail.com with UTF8SMTPSA id ie21-20020a17090b401500b0028b96c9424dsm227678pjb.1.2024.01.04.14.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 14:46:16 -0800 (PST)
From: Sarthak Kukreti <sarthakkukreti@chromium.org>
To: stable@vger.kernel.org
Cc: Sarthak Kukreti <sarthakkukreti@chromium.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.10.y] block: Don't invalidate pagecache for invalid falloc modes
Date: Thu,  4 Jan 2024 14:46:11 -0800
Message-ID: <20240104224611.1913563-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <2023101513-depraved-ecosphere-6b50@gregkh>
References: <2023101513-depraved-ecosphere-6b50@gregkh>
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
 fs/block_dev.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 29f020c4b2d0..906f985c74e7 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2031,22 +2031,33 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file->f_mode, start, end);
-	if (error)
-		return error;
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
+			break;
+
 		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
 					    GFP_KERNEL, BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			break;
+
 		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			break;
+
 		error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, 0);
 		break;
-- 
2.43.0.472.g3155946c3a-goog


