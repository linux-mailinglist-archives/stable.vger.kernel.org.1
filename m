Return-Path: <stable+bounces-95375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEE29D8676
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 14:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B7B6B2F708
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 12:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739CF2500BA;
	Mon, 25 Nov 2024 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oFxi/PP3"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE6C19992D
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732536786; cv=none; b=QnWVB+qz2PP34ngumJl++sdGGST9exstWmdmZGunvWem4bVqlsHGP4gqI/rhcTKEuhU1JW3yGK3Z9h33QI2KEA9VGrMhqyLOfK692SrlqmD0g0dp47xjd01v4nob4JlcheQ01t3b2f009RxRrTofrFSUb08gJZx8jKNyKvfVFCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732536786; c=relaxed/simple;
	bh=lfdCdKWybZEMujuynpEBxh/d/jsYtRcopqfggUDp1J4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poBb+Y08tvYgjNktnIb33ty8BxF6P+68JiImKDZq7z9Rn6u4BslPEjw3ZdmEVOcP2n/xtHhigdEtZf2xJCU5Y3KsTEhcmhWfFN0Bg8cL3LScbOLIDH7+oP0EDomy8haZeTxG8Hs4lKzjB6cbjEZi/xr2uk1SfWH0ZNMztSPUBJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oFxi/PP3; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732536785; x=1764072785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ko+J9Isi5zS3KqRYwGR4STHGaxRfXw9PHB8Ljz+WORU=;
  b=oFxi/PP3r/2F5nlCCLb6BtU+ULEVMbJk8ZuyuRDFmeQbel3yuIeeIa0+
   pqMTF3l5ekrG6Z+tA5FjtQ40m8fCm4tezYR8WF53n0nXscnyuEH9C4u2J
   tMJZhomHCrhOqraD5v0aFut8+CvAzphaFLnMY/xLQPtb4JIi+zPqQr6AX
   8=;
X-IronPort-AV: E=Sophos;i="6.12,182,1728950400"; 
   d="scan'208";a="445815202"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 12:13:04 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.44.209:34906]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.19.131:2525] with esmtp (Farcaster)
 id 9e625b92-c8b6-4384-a7be-8f5a4f4ff41a; Mon, 25 Nov 2024 12:13:03 +0000 (UTC)
X-Farcaster-Flow-ID: 9e625b92-c8b6-4384-a7be-8f5a4f4ff41a
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.108) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 25 Nov 2024 12:13:02 +0000
Received: from email-imr-corp-prod-pdx-all-2b-f5cd2367.us-west-2.amazon.com
 (10.124.125.2) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 25 Nov 2024 12:13:02 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-pdx-all-2b-f5cd2367.us-west-2.amazon.com (Postfix) with ESMTP id 37069C000E;
	Mon, 25 Nov 2024 12:13:02 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id BDDAA22462; Mon, 25 Nov 2024 12:13:01 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>, Puranjay Mohan <pjy@amazon.com>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Anuj Gupta
	<anuj20.g@samsung.com>, Keith Busch <kbusch@kernel.org>, Hagar Hemdan
	<hagarhem@amazon.com>
Subject: [PATCH 5.10] nvme: fix metadata handling in nvme-passthrough
Date: Mon, 25 Nov 2024 12:10:09 +0000
Message-ID: <20241125121009.17855-4-hagarhem@amazon.com>
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
Signed-off-by: Puranjay Mohan <pjy@amazon.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ Move the changes from nvme_map_user_request() to nvme_submit_user_cmd()
  to make it work on 5.10 ]
Signed-off-by: Puranjay Mohan <pjy@amazon.com>
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 30a642c8f537..bee55902fe6c 100644
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


