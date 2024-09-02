Return-Path: <stable+bounces-72702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C54AD968325
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 11:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704561F22F65
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 09:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20341C32F8;
	Mon,  2 Sep 2024 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YY0I2zQD"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE7A1C2DB4
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269111; cv=none; b=kg1WDCDOTpemIuGIy25BPkaTJrBa1ACn2t+39VV5eeBLDyeU1sfRYB0PsRN6Nw0wSTZlRlqWxpbLwsU+Dd3ZXYcZaKDDk8JrlLICGrLPsDW4JESNlqz6nj67pLg7FqV+8tRPfxlBxV4YHmw9KFcNzqRjPTqeVvto2a/1TRmSOHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269111; c=relaxed/simple;
	bh=hC/76uv1mgTWLVOKF3McCa797RcOQWA8z1Q+ampNA70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ni14mmAFuJtxE/mzP/XNHySSfjVOWZVyKnqdTN+JPHqQak8lhoc9k97HPaOTa+EMUyyGKuzLaVwWm3mlzvbzEbxclV9sYqSSI+NrK3rFxg5yH3OuwbcKl5Owo111zmZidFum51G/yX4x1pyXHw6awrsY+2DI6Z/OVqmKdzBKcBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YY0I2zQD; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2704d461058so2164689fac.0
        for <stable@vger.kernel.org>; Mon, 02 Sep 2024 02:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725269109; x=1725873909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d0LiR1Okca6vVLH1p6UsMUxJH88RK8865fVAaDxese8=;
        b=YY0I2zQD96cLhDLC6Sf8AE8MACqNEKUzkRjrDwuhIHA0sS2NFD4LUiS/Ct4X+5vz/L
         tZVf8I3LoVtbsv3HgyQL2xfh3iv8hlHv0sGDLSX9iFv/0427Sq/SUffIgh0f4bHuF8tG
         tmGMReJXxLB4e07IHEwpWQPcNyTL+EwWUCLH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725269109; x=1725873909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0LiR1Okca6vVLH1p6UsMUxJH88RK8865fVAaDxese8=;
        b=QeRQ7ezf+6hdV0ugvAANS3sSH8UTQ7w/d2wiIiKe90b1wEU81R8nl+BJQEgMeR0ILT
         JmvzWE1LHmifkIoB0C0RUOsDXD67cd560VcMBrLDJXWDKkIpHgJv1t77tqcPenG7G63p
         HbEHhJf+YFSz2zy7v/dXd75gppQOt4VQK7ttQXSo4JKMBv7jO/F458Zvp5VoH8Zv7O3T
         aFRJIxpS5vHHSEbVPE49AEYbYn0MVFwz6wO8/HFYmZ9ecWg3YXBok5ExDQkHwU7QZJxg
         co2wm0r/bDTO3TQQc/xjQjTx1e3Q9xRItpF4ZEZ6aed4J7L/mwjqsLxvKQMsJoiIBLp2
         SuoA==
X-Gm-Message-State: AOJu0YzDPkTZj8DGKy0R1Obe6ExeVG/cfomYJOQxICcYw7yv59mJIXbj
	U8vmorAPg2X8iDiBhgcXN7BBpvxVfhqUxhbtWaEpg8O30VESt1u00YAPpdL8iLuOE5QDZX88MTm
	69/uzbwT4SCB9i30bAEkLqSFwI6vPmIPIRCsYPEuIJuOYJ037Vby4slB/XBQgH/ErxlZ4H7rvh7
	wu0HHWX5jCUoYduTksB2OUUaKRbtYHAvVSMFnfPZokGyjp6FPIog==
X-Google-Smtp-Source: AGHT+IFbXmwGyvqj8OjVfSqw+t9YYclw5JmzSzE+/zNkckVyVa3MDG8sPwlrwBXXD7/eizaudPkBjg==
X-Received: by 2002:a05:6871:ca52:b0:261:1b66:5ab1 with SMTP id 586e51a60fabf-2779013817amr14310066fac.21.1725269108527;
        Mon, 02 Sep 2024 02:25:08 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d7dc5sm6100493a12.77.2024.09.02.02.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 02:25:07 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: axboe@kernel.dk,
	martin.petersen@oracle.com,
	linux-block@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Christoph Hellwig <hch@lst.de>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v4.19-v5.10] block: initialize integrity buffer to zero before writing it to media
Date: Mon,  2 Sep 2024 02:24:59 -0700
Message-Id: <20240902092459.5147-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 899ee2c3829c5ac14bfc7d3c4a5846c0b709b78f ]

Metadata added by bio_integrity_prep is using plain kmalloc, which leads
to random kernel memory being written media.  For PI metadata this is
limited to the app tag that isn't used by kernel generated metadata,
but for non-PI metadata the entire buffer leaks kernel memory.

Fix this by adding the __GFP_ZERO flag to allocations for writes.

Fixes: 7ba1ba12eeef ("block: Block layer data integrity support")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Link: https://lore.kernel.org/r/20240613084839.1044015-2-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 block/bio-integrity.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index a4cfc9727..499697330 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -216,6 +216,7 @@ bool bio_integrity_prep(struct bio *bio)
 	unsigned int bytes, offset, i;
 	unsigned int intervals;
 	blk_status_t status;
+	gfp_t gfp = GFP_NOIO;
 
 	if (!bi)
 		return true;
@@ -238,12 +239,20 @@ bool bio_integrity_prep(struct bio *bio)
 		if (!bi->profile->generate_fn ||
 		    !(bi->flags & BLK_INTEGRITY_GENERATE))
 			return true;
+
+		/*
+		 * Zero the memory allocated to not leak uninitialized kernel
+		 * memory to disk.  For PI this only affects the app tag, but
+		 * for non-integrity metadata it affects the entire metadata
+		 * buffer.
+		 */
+		gfp |= __GFP_ZERO;
 	}
 	intervals = bio_integrity_intervals(bi, bio_sectors(bio));
 
 	/* Allocate kernel buffer for protection data */
 	len = intervals * bi->tuple_size;
-	buf = kmalloc(len, GFP_NOIO | q->bounce_gfp);
+	buf = kmalloc(len, gfp | q->bounce_gfp);
 	status = BLK_STS_RESOURCE;
 	if (unlikely(buf == NULL)) {
 		printk(KERN_ERR "could not allocate integrity buffer\n");
-- 
2.39.4


