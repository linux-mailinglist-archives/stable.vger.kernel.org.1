Return-Path: <stable+bounces-187851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460B6BED3B3
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 18:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A615E1F71
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 16:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E69246788;
	Sat, 18 Oct 2025 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtbKz7lP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4551124677A
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760804076; cv=none; b=ouCSg47fNavlD3zO0jsF7FBE37L2BMoqKjJbW0QlnvlMLu9pAzuHIK2F/WA2iZcDdZsqs48m4OJRHgltg7rgHMg6M4zcXKF6L5oPAEI5RIimIJ7U/+XPPscQnRwr4RMVBItYd+uvYYSwwKS3Ad4zi6VhdALE1LGFgQywZhnZJU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760804076; c=relaxed/simple;
	bh=io0vbrIhYWPKGAl6497hmYoo8lVUbK30tBP2aepljMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=at5lcOwn4n4uos1tkGfVLPPPWwNuA8qnswqvODx/7qULmMOBcV7CmPmjPeUr/WdPIvOgtk8Vb17PyEVmblH37Qclp4apuW03/3vyUy7Uy4NHtWGfGUMFF6JNy2DTXuJPhSbQX5t+XrZVXau0P4YaS7rAE87Ttq6ZQ2pyRiEOhNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtbKz7lP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3E5C4CEF9;
	Sat, 18 Oct 2025 16:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760804075;
	bh=io0vbrIhYWPKGAl6497hmYoo8lVUbK30tBP2aepljMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JtbKz7lPLkmRB0rdpems/WcS9nKRkMW04TxpxbEMWiLCf+0j/tfSAPlP2CQjnnizq
	 7IHLK0sssTSQqP96WU5P/qk/0Q4H8fWAj3frDHRO80FaT29QGkBU9aOF3UOsUYeIUC
	 xS/chQj7Edl8rAXNkGdYPpzjVce0CIuDso1cJ3cgV+5aR1HmDcnEcGRZPhhpdFYt8t
	 3/XNxzxY0FOxeGYCr93Zte6c0HsK3xOMP68P7Cy3o9i5t4kMiiZtXMhIoE4m8nsDM4
	 knkOy/js2cEk/VUCLGDq1hKy6wWGTaZuDn2N4f2DBf710VXreattDYavpjVNH2FE2t
	 WIYL+oO9Rgs/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] blk-crypto: fix missing blktrace bio split events
Date: Sat, 18 Oct 2025 12:14:33 -0400
Message-ID: <20251018161433.836920-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101657-rule-straw-2a51@gregkh>
References: <2025101657-rule-straw-2a51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 06d712d297649f48ebf1381d19bd24e942813b37 ]

trace_block_split() is missing, resulting in blktrace inability to catch
BIO split events and making it harder to analyze the BIO sequence.

Cc: stable@vger.kernel.org
Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ added queue parameter to trace_block_split() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-crypto-fallback.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index c162b754efbd6..4ba66b3a2f961 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -18,6 +18,7 @@
 #include <linux/mempool.h>
 #include <linux/module.h>
 #include <linux/random.h>
+#include <trace/events/block.h>
 
 #include "blk-crypto-internal.h"
 
@@ -227,7 +228,9 @@ static bool blk_crypto_split_bio_if_needed(struct bio **bio_ptr)
 			bio->bi_status = BLK_STS_RESOURCE;
 			return false;
 		}
+
 		bio_chain(split_bio, bio);
+		trace_block_split(bio->bi_disk->queue, split_bio, bio->bi_iter.bi_sector);
 		submit_bio_noacct(bio);
 		*bio_ptr = split_bio;
 	}
-- 
2.51.0


