Return-Path: <stable+bounces-95387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576439D8801
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D49166CC6
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 14:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1441B0F22;
	Mon, 25 Nov 2024 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TJJaBJeD"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5F1AF0CA
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732545007; cv=none; b=guYXpPjpA6BjGfkkDJr5rwibSdq6KdPtlONAsP3/xxoVyHaxsZuue34NwTcgK2UUZEhoM/IZtHnyt3WQnSUgNm0wnTjFFVPmTlKHx3CdFDHoqaLLqmRYuN+dBZbJhnnri4gL9Fu+/pz6CKmvZFkfE5VO/UdRfBzA2dDUnjfs+W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732545007; c=relaxed/simple;
	bh=DVL+m8+vijnsadOuEH90T3BgTy7zXNFd6NjZGjpDTzw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cwq6ZHhvAmmBUUc8PoAPbseMqAHIa8IwqabYUZ03XxfN0bbONXsJmLpa4FuI+3+bpupXAXydUUv1b6tYcdb3exFhIyjucGdiALggaRYtn/xMMfv0Wi4hC8rehrUjQ+SPwUUY13TUwOosWCXFl0hFTIuQyAMxtEtllMIOMM4RKGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TJJaBJeD; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732545002; x=1764081002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kT5okadEVbxmvz5K385U2BwMqiIHbA4MUm1xzm+8d54=;
  b=TJJaBJeDEC15YYWSoStzwxrxVmw6E/ZmbQnY5Z5SkoPYAzdRGL0PgEGY
   lHAjYMjXMUmR4sYb3j2rgfy+Cj51/Ntv21pqenFGSBPHFbQBGuiW7hmyS
   bHNxDbYOLzoQJzOgdhB6V9Z9+W2JWM2vNeeX2USc6/MjoeV6DM/gF0wHG
   o=;
X-IronPort-AV: E=Sophos;i="6.12,183,1728950400"; 
   d="scan'208";a="355497775"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 14:30:00 +0000
Received: from EX19MTAUEA002.ant.amazon.com [10.0.44.209:35209]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.3.20:2525] with esmtp (Farcaster)
 id 74345e8f-5102-40ec-a64f-c51b8d12747e; Mon, 25 Nov 2024 14:29:59 +0000 (UTC)
X-Farcaster-Flow-ID: 74345e8f-5102-40ec-a64f-c51b8d12747e
Received: from EX19EXOUEB001.ant.amazon.com (10.252.135.46) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 25 Nov 2024 14:29:56 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19EXOUEB001.ant.amazon.com (10.252.135.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 25 Nov 2024 14:29:56 +0000
Received: from email-imr-corp-prod-pdx-all-2c-c4413280.us-west-2.amazon.com
 (10.124.125.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 25 Nov 2024 14:29:56 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-pdx-all-2c-c4413280.us-west-2.amazon.com (Postfix) with ESMTP id C6F4EA03B5;
	Mon, 25 Nov 2024 14:29:55 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 5BC3220D96; Mon, 25 Nov 2024 14:29:55 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>, Puranjay Mohan <pjy@amazon.com>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Anuj Gupta
	<anuj20.g@samsung.com>, Keith Busch <kbusch@kernel.org>, Hagar Hemdan
	<hagarhem@amazon.com>
Subject: [PATCH 4.19] nvme: fix metadata handling in nvme-passthrough
Date: Mon, 25 Nov 2024 14:29:53 +0000
Message-ID: <20241125142953.30943-1-hagarhem@amazon.com>
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
  to make it work on 4.19 ]
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6adff541282b..fcf062f3b507 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -802,11 +802,16 @@ static int nvme_submit_user_cmd(struct request_queue *q,
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
@@ -821,7 +826,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
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


