Return-Path: <stable+bounces-86349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DFB99ED77
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C601F25093
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8334B1B218C;
	Tue, 15 Oct 2024 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="s0uu2cgE"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2881B2189
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998815; cv=none; b=WYUxvqnMlBrVuu3bHZdwNGofiZcngGPleY2VqnfygoNPoXe7icAkMsGsRWjK947YYuZ9MAMQfwy54ezb4uPLOQCxJHRVcBNSwUg0sGUHrtv0UevZNoDSO1zEKyZtzMGSr7Bv1SbAMeI36eMpLZKunLgl4PfcEwACxbiu5mBhEX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998815; c=relaxed/simple;
	bh=kDDZxTjmqmQ7++wdZgpWj0jauEJfQS9x/20MGF5/vSI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OfnF0VXpcC6oaowVeHZCkvVrSt/unacItmgvPluxg4OeWECkmTMFuLrc6bJPRaJdGGoAiVCBa986jIQ8VMXhvk0gmxCem6h86QArySVU8bFYOBbJQj7Zbkjql/jGovfb67WRx18GYVEq90s+22BzfYyZbuoDtljC08ET5P3nRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=s0uu2cgE; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728998814; x=1760534814;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rn/S75aztWbJt/H4N5UJIv0XmOY88cOcp+499zOyeeQ=;
  b=s0uu2cgEjTvhIbDcNrxqP5Lmy9ShrGf+7+XxFiM7WiJ+UvgUgffP9Hug
   MCf17mkzW+DB+lT/k7h/BFH/3Eyk5Oci9YKxsBIqXRo3IIAAsgCCiajhR
   eZfchZgoD1koEAaIv4u6BVYRZuvcZzPIOrLCRyxvqPaIWPokZyHKFLDZ+
   4=;
X-IronPort-AV: E=Sophos;i="6.11,205,1725321600"; 
   d="scan'208";a="431586673"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 13:26:50 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:55320]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.29:2525] with esmtp (Farcaster)
 id 47c84b81-4899-4a77-8934-fc9402f33562; Tue, 15 Oct 2024 13:26:49 +0000 (UTC)
X-Farcaster-Flow-ID: 47c84b81-4899-4a77-8934-fc9402f33562
Received: from EX19EXOUWA002.ant.amazon.com (10.250.64.216) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 15 Oct 2024 13:26:49 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19EXOUWA002.ant.amazon.com (10.250.64.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 15 Oct 2024 13:26:49 +0000
Received: from email-imr-corp-prod-pdx-all-2b-22fa938e.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Tue, 15 Oct 2024 13:26:49 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com [10.15.97.110])
	by email-imr-corp-prod-pdx-all-2b-22fa938e.us-west-2.amazon.com (Postfix) with ESMTP id E9C7DC03E3;
	Tue, 15 Oct 2024 13:26:48 +0000 (UTC)
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
	id 7FE2C20845; Tue, 15 Oct 2024 13:26:48 +0000 (UTC)
From: Puranjay Mohan <pjy@amazon.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <stable@vger.kernel.org>,
	<puranjay12@gmail.com>
Subject: [PATCH 5.10] nvme: fix metadata handling in nvme-passthrough
Date: Tue, 15 Oct 2024 13:26:45 +0000
Message-ID: <20241015132645.115399-1-pjy@amazon.com>
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
before sending it forward. It also allows admin commands with metadata
to be processed as it ignores metadata when bdev == NULL and may report
success.

Reject an IO command with metadata when the NVMe namespace doesn't
support it and reject an admin command if it has metadata.

[1] https://lore.kernel.org/all/mb61pcylvnym8.fsf@amazon.com/

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ Move the changes from nvme_map_user_request() to nvme_submit_user_cmd()
  to make it work on 5.10 ]
Signed-off-by: Puranjay Mohan <pjy@amazon.com>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 30a642c8f5374..bee55902fe6ce 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1121,11 +1121,16 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	bool write = nvme_is_write(cmd);
 	struct nvme_ns *ns = q->queuedata;
 	struct gendisk *disk = ns ? ns->disk : NULL;
+	bool supports_metadata = disk && blk_get_integrity(disk);
+	bool has_metadata = meta_buffer && meta_len;
 	struct request *req;
 	struct bio *bio = NULL;
 	void *meta = NULL;
 	int ret;
 
+	if (has_metadata && !supports_metadata)
+		return -EINVAL;
+
 	req = nvme_alloc_request(q, cmd, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
@@ -1141,7 +1146,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 			goto out;
 		bio = req->bio;
 		bio->bi_disk = disk;
-		if (disk && meta_buffer && meta_len) {
+		if (has_metadata) {
 			meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
 					meta_seed, write);
 			if (IS_ERR(meta)) {
-- 
2.40.1


