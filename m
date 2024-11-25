Return-Path: <stable+bounces-95373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2829D8527
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 13:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC70163EC8
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 12:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE8C199EB7;
	Mon, 25 Nov 2024 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RKLXow9j"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E022500BA
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732536775; cv=none; b=c54KkjC8yXG3L6ggncAlDVX0Vo/IlHG39mLoLetNgwXaAeRZZbd7sf+JzQpJBsB5c5A2qtLu3cEGyWFQbLOuMZjcyACFLToWz2Nb871cudPcqtquGxkKbIIPO6BrKz7TWPdL+L0ydg+fvUkDFN+3Qf2dgTL2ZBrJDei8a3tHOQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732536775; c=relaxed/simple;
	bh=OTFA4YHcmTX2rE9VZMJi8dYmyJ3gOId3oqf11EayORc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvGnojadkPHXbGJk/2lW5YFGXuHZiO781tKJUTWqCTzeky2X6wPX8uxsyId9bOIXVezFc2aReeh9sdc7VWEHwHQWzW6VzrbhoZiey/VCrJQOP0HGHfSD0ZBLDQRgPX2peyk9XKRlBXhdjvqmBlPTi0dO5Ksw6kiDwW4tblMBe1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RKLXow9j; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732536774; x=1764072774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DTMBd2bEmcPXjqc240XdNVBag2jiPQjMByKFYkTYHmU=;
  b=RKLXow9j6LJ4Y+iRq2OKKO0hwM6g1TT3RUekz3RsOcZ6R9NODuPzobcf
   p3mpsCxFx+dRhh676yc3dfDulHBFXqqS87BDXBAgA0ctsMDsi5TQ/BQ9D
   M5vDy3L1Hcua5/y+tXvV0ax62H8LGg04bMjWAzZFVPp7Lrog7uqok9sul
   o=;
X-IronPort-AV: E=Sophos;i="6.12,182,1728950400"; 
   d="scan'208";a="445815155"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 12:12:50 +0000
Received: from EX19MTAUEC001.ant.amazon.com [10.0.29.78:17053]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.39.77:2525] with esmtp (Farcaster)
 id 596df114-ca7b-498a-bc48-056552d0844b; Mon, 25 Nov 2024 12:12:49 +0000 (UTC)
X-Farcaster-Flow-ID: 596df114-ca7b-498a-bc48-056552d0844b
Received: from EX19EXOUEA001.ant.amazon.com (10.252.134.47) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 25 Nov 2024 12:12:49 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19EXOUEA001.ant.amazon.com (10.252.134.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 25 Nov 2024 12:12:48 +0000
Received: from email-imr-corp-prod-iad-1box-1a-6851662a.us-east-1.amazon.com
 (10.124.125.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 25 Nov 2024 12:12:48 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-iad-1box-1a-6851662a.us-east-1.amazon.com (Postfix) with ESMTP id CE80240765;
	Mon, 25 Nov 2024 12:12:48 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 8D8BE22462; Mon, 25 Nov 2024 12:12:48 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>, Puranjay Mohan <pjy@amazon.com>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Anuj Gupta
	<anuj20.g@samsung.com>, Keith Busch <kbusch@kernel.org>, Hagar Hemdan
	<hagarhem@amazon.com>
Subject: [PATCH 6.1] nvme: fix metadata handling in nvme-passthrough
Date: Mon, 25 Nov 2024 12:10:07 +0000
Message-ID: <20241125121009.17855-2-hagarhem@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241125121009.17855-1-hagarhem@amazon.com>
References: <20241125121009.17855-1-hagarhem@amazon.com>
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


