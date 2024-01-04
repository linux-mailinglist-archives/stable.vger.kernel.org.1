Return-Path: <stable+bounces-9738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6380824B35
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 23:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB8A1C22AC7
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 22:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0482CCD9;
	Thu,  4 Jan 2024 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BmMZgins"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C1E2D021
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d4ba539f6cso7463215ad.3
        for <stable@vger.kernel.org>; Thu, 04 Jan 2024 14:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704408727; x=1705013527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OnrW8plSOEZLjLGb2fCdktIXMiQt5aXJhwMz5FyPRo=;
        b=BmMZginsuyi/I/3KpEE02Oo++RbNa9fN5YrX0pMpWCE2AYnZB7FZjHafQflWOodVhY
         /ms0bo3e/9/DJbQAM6XkpWug1b4oJpSyvZ8e1A6j+KplZ1o4d7gcQqJRKTltljPS9dTL
         QNZ2MMaVdCRt+N/AN93aehGql1YM54PKDmOKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704408727; x=1705013527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OnrW8plSOEZLjLGb2fCdktIXMiQt5aXJhwMz5FyPRo=;
        b=Ay693aVN+mtnbX1BAc83BfVcc+9QWZ9Bdh0mWd9K+CUzyUCHdgSb/Y23FQDDNsPvDa
         k//xnKBjBnXZb+O9QuogIWY3Hm5/pE/DcYM2Scd0KCDv0gRjnRC3Qfzw3rACQRN+vINi
         sX5PdUgVZ1Xioz+oIe92CSVGwhDPsgNjvJa+fO3Xk6oIw32MP9wGYMFom4zAtklm9c5Z
         x0dzXq92arvDJj7XoTLfXnbE9TWEU0bAoxIgslB2eX2HVO4O/NgcqFwhv6Mcx4KFEOqq
         4mDly/dUq7MYHYpO0Qtj8PmhxKYS4NwRMbURcbbWHtEiPY8c1YpnwOWOgIYe8I7z0sts
         vIOw==
X-Gm-Message-State: AOJu0YxLMqIo76KeO4iYgCGn/4Dkpgadt8RYOc6i4XezhpZYfxCVgJg0
	fYN+lYnepGNNKj1UGmjC63CHaIiJbTX0mvUD3dDMjX/qMQ==
X-Google-Smtp-Source: AGHT+IHuw8jPpjqqo0zFleCIZTbILQBj1NF5JEZAra98kkruogG5l7OFUhzxb6bijA0UqTxE3FX7dw==
X-Received: by 2002:a17:902:bd48:b0:1d4:20fb:c2ef with SMTP id b8-20020a170902bd4800b001d420fbc2efmr1173617plx.46.1704408727697;
        Thu, 04 Jan 2024 14:52:07 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:c642:5162:9986:5b8b])
        by smtp.gmail.com with UTF8SMTPSA id 21-20020a170902e9d500b001d40cc2c9c3sm127964plk.35.2024.01.04.14.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 14:52:07 -0800 (PST)
From: Sarthak Kukreti <sarthakkukreti@chromium.org>
To: stable@vger.kernel.org
Cc: Sarthak Kukreti <sarthakkukreti@chromium.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15.y] block: Don't invalidate pagecache for invalid falloc modes
Date: Thu,  4 Jan 2024 14:52:04 -0800
Message-ID: <20240104225204.1960293-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <2023101512-hurt-guise-534b@gregkh>
References: <2023101512-hurt-guise-534b@gregkh>
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
index 6c265a1bcf1b..4c8948979921 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -599,22 +599,33 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
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
 		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
 					    GFP_KERNEL, BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, 0);
 		break;
-- 
2.43.0.472.g3155946c3a-goog


