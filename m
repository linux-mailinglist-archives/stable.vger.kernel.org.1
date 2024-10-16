Return-Path: <stable+bounces-86446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4869A050B
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 11:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5294C1F26809
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 09:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E708204934;
	Wed, 16 Oct 2024 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hUdhX4vD"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BBE2038A4
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069670; cv=none; b=J8PbyVW9eXIocHw3Lfnm0ieAePwxDcLFO1VcIwoPUSHI3hKh98L8uv0+Q2gG6BriKxq7sQwR8GZz5NaV1TQY755oooVTwQHqCTG4MHvs//4fcSLBFN5+9tbHYZYzW7MIUm3xJ1AMA8zj5HS5/z6J8K/zxxUVirsDCJ0mFW5IZhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069670; c=relaxed/simple;
	bh=Z0mfeoi3eZ3k6ncZtzZ+PlzJB2b5MV6Vl0a1xyU4QW8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=etc72ZnGJ+8ilsKc3PbrpdlvCpXA5pLBQjqdhX9QgkH+aalCe/HsN4+VoOIwCcJuOiyieF9BhiJ7rbwS9K3Ew8kLELdCuMyshiagCFHgbt1RVB3Ox8y4Lp+h/Ro9r4BgF7+/cQmmnnBQw+TjNYRW5e4FDcxB7m9v3gw+TsZP69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hUdhX4vD; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729069669; x=1760605669;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UcTHLD6sRCmV7ayE8d9IppwXDwkVLKNLEKqgv4jGmMo=;
  b=hUdhX4vDzM9FhVf9w10Y7upVl3x84wneDiqABiE6x224jI985XDtYJEJ
   aghhcwqD/cM+Ig07K16P9eXoQWwLHNhsIUxmvNEv/OJHB6EyGI7+pY2oJ
   m12OMGKYq3PvJDf6BWw627JY/tyA9DKWrxLwdn3IrJKmM83ZuPIZZlMna
   M=;
X-IronPort-AV: E=Sophos;i="6.11,207,1725321600"; 
   d="scan'208";a="461213309"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 09:07:43 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.0.204:24357]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.8.207:2525] with esmtp (Farcaster)
 id 2d14e9d2-f0ff-44c7-8c9b-a494451bfecb; Wed, 16 Oct 2024 09:07:42 +0000 (UTC)
X-Farcaster-Flow-ID: 2d14e9d2-f0ff-44c7-8c9b-a494451bfecb
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 09:07:42 +0000
Received: from email-imr-corp-prod-iad-all-1b-1323ce6b.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Wed, 16 Oct 2024 09:07:42 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com [10.15.97.110])
	by email-imr-corp-prod-iad-all-1b-1323ce6b.us-east-1.amazon.com (Postfix) with ESMTP id 44F154034D;
	Wed, 16 Oct 2024 09:07:42 +0000 (UTC)
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
	id 02C4B20849; Wed, 16 Oct 2024 09:07:41 +0000 (UTC)
From: Puranjay Mohan <pjy@amazon.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <stable@vger.kernel.org>,
	<puranjay12@gmail.com>, <amazon-linux-kernel@amazon.com>
Subject: [PATCH 6.1.y] nvme: fix metadata handling in nvme-passthrough
Date: Wed, 16 Oct 2024 09:07:39 +0000
Message-ID: <20241016090739.43470-1-pjy@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

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
---
 drivers/nvme/host/ioctl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index b3e322e4ade38..a02873792890e 100644
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
@@ -95,10 +96,15 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
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
 
@@ -122,7 +128,7 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	if (bdev)
 		bio_set_dev(bio, bdev);
 
-	if (bdev && meta_buffer && meta_len) {
+	if (has_metadata) {
 		meta = nvme_add_user_metadata(req, meta_buffer, meta_len,
 				meta_seed);
 		if (IS_ERR(meta)) {
-- 
2.40.1


