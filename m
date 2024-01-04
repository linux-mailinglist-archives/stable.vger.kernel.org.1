Return-Path: <stable+bounces-9733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC69824ADF
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 23:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732581C210E0
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 22:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8C32C860;
	Thu,  4 Jan 2024 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UBVKFdFc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6F2CCB0
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28c0df4b42eso19977a91.1
        for <stable@vger.kernel.org>; Thu, 04 Jan 2024 14:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704407278; x=1705012078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vW7oRi12eMhZHnVJANhqZdn++wly1R3lkm8gB/ftufE=;
        b=UBVKFdFcPubC2On5q0oPfm2woD9ifCoJ7pkMPMF3+w8IvVH/JZ2QV0wJvbG07bzMXK
         tEIq4JMfw9mgZflgiPZSR9IP1rb4Kxkyr/KbY48vdtYlf0EbOgOzqlrGpMNeJVPG3e+h
         App5Vd1zI2scxx0syxqN/XGut3rW6c/uEF2Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704407278; x=1705012078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vW7oRi12eMhZHnVJANhqZdn++wly1R3lkm8gB/ftufE=;
        b=YZ87/0zVkfWQrj2+r7AC8Il+hTAALPfk2K9Pa47Oz4vEOROlru1+YLn8m+a1rm7rc0
         KagQqDfg/hSFXdrz1kfzD46A76JLMfSpuSsISO3SA42nmcJWIazhLMBj4hrwtFNifMzK
         gME1M8XX8a9bl6sxss5IeSofQ8vQaU6FNKn8oqTOQerFFjhuJh88n8WtZUbiNyk2ZPid
         7bcrKKUs0CuCNEjB41nGVqN5fW0IUmujR7nr/bwtCemS73QX+CHss7zjLfXOU8iK1xC3
         eBu4e1AzU3tOkFCiPYBarrN5RdX8D7ftLOBxlZsC5tTcus7xlDgQF++uoq0vGyyhKuVr
         5tQA==
X-Gm-Message-State: AOJu0YyvYppbRSSyC3OFYtjr0NTkSNaPCooigtkc80seqWxy/0O1fm3J
	kAsYQXltzv2AcIpyA5az1W1quGBEiWuwflHGHqL5ieSXTQ==
X-Google-Smtp-Source: AGHT+IH8hXLCvlbJkkN9KgCg/OVp4hJ0JkiP0TZlP+JciH6NLJOY+4FBjfo0lqrsoaeTx/28L+SWBA==
X-Received: by 2002:a17:90b:3017:b0:28c:bbef:4a8e with SMTP id hg23-20020a17090b301700b0028cbbef4a8emr1434733pjb.6.1704407277789;
        Thu, 04 Jan 2024 14:27:57 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:c642:5162:9986:5b8b])
        by smtp.gmail.com with UTF8SMTPSA id v3-20020a17090aaf0300b0028c94f78c07sm4134999pjq.30.2024.01.04.14.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 14:27:57 -0800 (PST)
From: Sarthak Kukreti <sarthakkukreti@chromium.org>
To: stable@vger.kernel.org
Cc: Sarthak Kukreti <sarthakkukreti@chromium.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14.y] block: Don't invalidate pagecache for invalid falloc modes
Date: Thu,  4 Jan 2024 14:27:45 -0800
Message-ID: <20240104222745.1783780-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <2023101517-patriarch-reuse-cc1c@gregkh>
References: <2023101517-patriarch-reuse-cc1c@gregkh>
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
index a56974d04010..a3f1fba18d64 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2033,21 +2033,26 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
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


