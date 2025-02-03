Return-Path: <stable+bounces-111990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9F1A2545F
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 09:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC831882993
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 08:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC201FBC81;
	Mon,  3 Feb 2025 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="d2IkSQwl"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F4A1FAC4F
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738571182; cv=none; b=O7EegiweR30BQyk1HgvZX9yi7JwcBQHXG9dX48epglUE0MYZEuKV6qQd7kdhnoesfgDzNXwu2z+qu4//w6+feg4SfDzk5KXSJCIxN9WFQ3zs6g/DIzSPW+zPgd65lA0Pqu1D1dRNgIrhxqfqjswTq3/s3+Lbul6adeygeCUOVUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738571182; c=relaxed/simple;
	bh=xSjEp1yA63jv5Zs01vCkFjEVW68PopW5dwKWxiBbLPA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c4r6Hido7+iyqvw4q6mwP79FPCOGGDQIlEUIjSo5cj3gJ/8801Flwcl8ig/LEtzoGbw43Ad4Sj57aOsbpgbiyYeVn0kDs0kaXqa23ZCtqDzCdgJUc7+dMYmQgIDGg0nUhoNPoldulKBwDM+ICWmIPkAhDq57dMb1Vly8dwmWOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=d2IkSQwl; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738571180; x=1770107180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wr6UAad7IFzx2p8cEVmmsoLCOuP4iAT6FK84i6J3zxU=;
  b=d2IkSQwl8Fq59RusfdWyv0yotBPXjDh99uOMYLDZSwZNUqParEpDJOIY
   TGUVIX+nAznvTQsK4fO+NR+uVifyFvVpWidIR47xcm+EGWNN2OmBk7/CU
   8aiH9XRYNRPye7uzN+xNYDVVL0lf0lSEAvP5/pF9ruh44eyKnKdfsGgZd
   M=;
X-IronPort-AV: E=Sophos;i="6.13,255,1732579200"; 
   d="scan'208";a="468838736"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 08:26:17 +0000
Received: from EX19MTAUEA001.ant.amazon.com [10.0.44.209:64584]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.28.202:2525] with esmtp (Farcaster)
 id 8d2ac0d4-8d8a-4d84-9a40-37eaf8bf3647; Mon, 3 Feb 2025 08:26:17 +0000 (UTC)
X-Farcaster-Flow-ID: 8d2ac0d4-8d8a-4d84-9a40-37eaf8bf3647
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 3 Feb 2025 08:26:12 +0000
Received: from email-imr-corp-prod-pdx-all-2b-f5cd2367.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Mon, 3 Feb 2025 08:26:12 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-pdx-all-2b-f5cd2367.us-west-2.amazon.com (Postfix) with ESMTP id CF951C0C32;
	Mon,  3 Feb 2025 08:26:11 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 62DBE20DB5; Mon,  3 Feb 2025 08:26:11 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>, Puranjay Mohan <pjy@amazon.com>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Anuj Gupta
	<anuj20.g@samsung.com>, Keith Busch <kbusch@kernel.org>, Hagar Hemdan
	<hagarhem@amazon.com>
Subject: [PATCH 6.1] nvme: fix metadata handling in nvme-passthrough
Date: Mon, 3 Feb 2025 08:24:58 +0000
Message-ID: <20250203082501.28771-1-hagarhem@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Puranjay Mohan <pjy@amazon.com>

[ Upstream commit 7c2fd76048e95dd267055b5f5e0a48e6e7c81fd9 ]

On an NVMe namespace that does not support metadata, it is possible to
send an IO command with metadata through io-passthru. This allows issues
like [1] to trigger in the completion code path.
nvme_map_user_request() doesn't check if the namespace supports metadata
before sending it forward. It also allows admin commands with metadata to
be processed as it ignores metadata when bdev == NULL and may report
success.

Reject an IO command with metadata when the NVMe namespace doesn't
support it and reject an admin command if it has metadata.

[1] https://lore.kernel.org/all/mb61pcylvnym8.fsf@amazon.com/

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ Minor changes to make it work on 6.1 ]
Signed-off-by: Puranjay Mohan <pjy@amazon.com>
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
Resend as all stables contain the fix except 6.1.
---
 drivers/nvme/host/ioctl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 875dee6ecd40..19a7f0160618 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2011-2014, Intel Corporation.
  * Copyright (c) 2017-2021 Christoph Hellwig.
  */
+#include <linux/blk-integrity.h>
 #include <linux/ptrace.h>	/* for force_successful_syscall_return */
 #include <linux/nvme_ioctl.h>
 #include <linux/io_uring.h>
@@ -171,10 +172,15 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	struct request_queue *q = req->q;
 	struct nvme_ns *ns = q->queuedata;
 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
+	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
+	bool has_metadata = meta_buffer && meta_len;
 	struct bio *bio = NULL;
 	void *meta = NULL;
 	int ret;
 
+	if (has_metadata && !supports_metadata)
+		return -EINVAL;
+
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
@@ -198,7 +204,7 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	if (bdev)
 		bio_set_dev(bio, bdev);
 
-	if (bdev && meta_buffer && meta_len) {
+	if (has_metadata) {
 		meta = nvme_add_user_metadata(req, meta_buffer, meta_len,
 				meta_seed);
 		if (IS_ERR(meta)) {
-- 
2.40.1


