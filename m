Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774B07C5E12
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 22:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjJKUMo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 16:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjJKUMn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 16:12:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE749D
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 13:12:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c62d61dc96so1779145ad.0
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 13:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697055156; x=1697659956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rQNnXBnSwzfsN2zrI7/k3aUY1SO1WpMoDwjEZpkrIxM=;
        b=Yo4Q9xdIFr68Wucs1ifeWk5zzo6mpTk23PUK4877tDeNxUT6CDiDDdTOUGHGLNeMTR
         GBM7NgfKkr2feCVJQypkGgCDDHNkU6H7toLWftB1Q92P6gbcuutxH9NDa5WZjDWaIFg6
         Ew+8TxPS2uFzCf/LZx7OBa1ncesTw7KwgK0Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697055156; x=1697659956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQNnXBnSwzfsN2zrI7/k3aUY1SO1WpMoDwjEZpkrIxM=;
        b=j8hPUYqjkLZmH6EN7PWQpxUW9JfqqC7ZP6/ISayrBVfRlLbE7FjWTZJx/OllCAI3Ke
         TYdjrFJvmSENoRySMfeQzDZoqXRBotcsVhd3o6BEv7WWOWazdwgimcaMhoyv9mPtwoQ5
         5fsHh0YZJOp1PK8IlrUkp2NmPjyKcgzEWRCqbk7VfmBgtB3Uhxh/tOu2M309VW5CPgQn
         YKxVfmNjO4SwlgSCT1fz1nDrwNv5/R4CPD+8lJDZlCu96VCIq+ddNWw7QF+It/wxvjBc
         /tkqYpJXoQjAgfeToV3K9xnEx4c2AhTfpFCSljSRjX98QbKBajvRTmDZdYiWPSd5+hrC
         pXOA==
X-Gm-Message-State: AOJu0YyqAigtK/Dx9wOiM4U0yDgbcuWn9APiRtvakBDsOqk1O9XYYCTh
        ZStmBd7T7pHAIGaAonK+eMUiNg==
X-Google-Smtp-Source: AGHT+IHnC5io+CLGcm9SFSID5XfybPMNO3Vqy63f8KprIuTpCwNwyaYRhoXL3YLKxVI+4yIF8orucA==
X-Received: by 2002:a17:902:db10:b0:1bd:f7d7:3bcd with SMTP id m16-20020a170902db1000b001bdf7d73bcdmr21362238plx.50.1697055156027;
        Wed, 11 Oct 2023 13:12:36 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:2c44:f765:835a:f6b3])
        by smtp.gmail.com with UTF8SMTPSA id jc5-20020a17090325c500b001bf8779e051sm233685plb.289.2023.10.11.13.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 13:12:35 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        stable@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH] block: Don't invalidate pagecache for invalid falloc modes
Date:   Wed, 11 Oct 2023 13:12:30 -0700
Message-ID: <20231011201230.750105-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Only call truncate_bdev_range() if the fallocate mode is
supported. This fixes a bug where data in the pagecache
could be invalidated if the fallocate() was called on the
block device with an invalid mode.

Fixes: 25f4c41415e5 ("block: implement (some of) fallocate for block devices")
Cc: stable@vger.kernel.org
Reported-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 block/fops.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index acff3d5d22d4..73e42742543f 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -772,24 +772,35 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
 	filemap_invalidate_lock(inode->i_mapping);
 
-	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
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
+		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
+		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL);
 		break;
-- 
2.42.0.609.gbb76f46606-goog

