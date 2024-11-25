Return-Path: <stable+bounces-95381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B73CB9D8722
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 14:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C864284F11
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 13:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07621ADFFB;
	Mon, 25 Nov 2024 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HHrDrdIe"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CDA1AB52F
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542828; cv=none; b=kfAPl2GhkFNG7SpyagE8jtwP3vsJCcjIScvVMJDn2E+tiS02cPcZTIDlFCZzVdFUxAtKGlXpsB2+YpZn0VWxjanMksoD6NFJDUqJiWpQykHAR9SuHS3bm0WkjfuCJYlKhWobVGMOi9PIve0yZ7iI0JIp8k08+V3jFE8z1cqKZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542828; c=relaxed/simple;
	bh=zLr5w+VN+eNEq7P16tIvW6iMHtr1RjiiWLjk6vsRzc4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sjgBv/wsR5/zWS2Jdek6xwK0QzrRjvxktjL1LFKli1NEA4zvO5h8+HzYaXanOBF9wn3nUpmzEHWMyoUQ1Sc30q7u+3WDVWZEBJdur0EB3kl2CHuxk3f4FeiZ2PAH6NHE3WOqhUyNSbE0F10zmzBW4k2IWHOaNXvwQ3SHaYpwbXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HHrDrdIe; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732542828; x=1764078828;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1E4XqsXW5YNH4ZgShkCuk0oCQHxdLFcDfnP/7CxYpXE=;
  b=HHrDrdIeWlmzTzCdDGI/ficLT+LWLglDEKk6qGYJ7kcFmeasBTVkWwaI
   Ik+1pw4tMJzNCdu/gTa7D1rSGZwL0gLwiihJLo9uPP1ERXTjTUsV88n5x
   6qk50tjpq9chox9lndZe8mgo+0JbhQpDr+MkkGgiAuy8Ck94zLrdEFj2S
   c=;
X-IronPort-AV: E=Sophos;i="6.12,182,1728950400"; 
   d="scan'208";a="473016701"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 13:53:41 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.29.78:31132]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.15.229:2525] with esmtp (Farcaster)
 id bb9601ad-1de6-41c6-a16d-b8284b448ed5; Mon, 25 Nov 2024 13:53:39 +0000 (UTC)
X-Farcaster-Flow-ID: bb9601ad-1de6-41c6-a16d-b8284b448ed5
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 25 Nov 2024 13:53:39 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.124.125.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 25 Nov 2024 13:53:39 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTP id 7453EA06D9;
	Mon, 25 Nov 2024 13:53:38 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 0943320D96; Mon, 25 Nov 2024 13:53:38 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>, Puranjay Mohan <pjy@amazon.com>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Anuj Gupta
	<anuj20.g@samsung.com>, Keith Busch <kbusch@kernel.org>, Hagar Hemdan
	<hagarhem@amazon.com>
Subject: [PATCH 5.4] nvme: fix metadata handling in nvme-passthrough
Date: Mon, 25 Nov 2024 13:53:34 +0000
Message-ID: <20241125135334.3822-1-hagarhem@amazon.com>
X-Mailer: git-send-email 2.40.1
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
Signed-off-by: Puranjay Mohan <pjy@amazon.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ Move the changes from nvme_map_user_request() to nvme_submit_user_cmd()
  to make it work on 5.4 ]
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0676637e1eab..a841fd4929ad 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -921,11 +921,16 @@ static int nvme_submit_user_cmd(struct request_queue *q,
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
 	req = nvme_alloc_request(q, cmd, 0, NVME_QID_ANY);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
@@ -940,7 +945,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
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


