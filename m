Return-Path: <stable+bounces-108374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139A2A0B17E
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 09:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AEAC3A1C1D
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 08:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270C5233D97;
	Mon, 13 Jan 2025 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUjLd07T"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFC2233D7C
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757708; cv=none; b=e5iIVcKDs9ePc6855hTv4Aqyn6yGzG44LvQEI1xVwFAXwNh4ne04r/J5unXOi/vfMaEVYxwfZV+gjV/wvSEjw2dZ9v/VvPjF3tW/iya7qB7r1SLVcfYSm6Sf4ixDWIh1T7BD5F4IeMGc2vAgjC0mwEr4TL84MmE9PXpqm438kgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757708; c=relaxed/simple;
	bh=/cxzzrN7/GzaCbkjS70CNzuy4PcXFzOJwq1zTpZiqNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OmU6picpe8dy7Uehq1q/tKS1qM3Mg86IqvqETIsXgRswMZ5F7T50kJh5IehGH1IyEPUCKEKBHSWl4ik671GFXQlA/s4lrt+Mx35SiDblQ4IU0C0fdrd6y2T3deZrhbDMp7+P9XKxQngSM1RZYKmioGnryqYSCxsnDai5wY8ARrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUjLd07T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736757706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gCSKRehdPVlRSB0gi9q64eOYrcUlvnOEgFN0OKryN3E=;
	b=PUjLd07ThbKjB9iMHgUZMuI4h4pqm9HdnL+Ewhq11djgAi/gwZT75376TCJ5LLMDLF3UaY
	zqXlRHYwRcb0P3Xgy9BApZRnd06XKVkcrPy95iMpxtRJ/j38XT01BtPIPS2pOyiAWAlmlq
	i54NkUeu2FPb8JIO/306PXjDdqdvniE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-yMFvgeimOMeg9UV1yR8WpA-1; Mon,
 13 Jan 2025 03:41:44 -0500
X-MC-Unique: yMFvgeimOMeg9UV1yR8WpA-1
X-Mimecast-MFC-AGG-ID: yMFvgeimOMeg9UV1yR8WpA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D99A1195606B;
	Mon, 13 Jan 2025 08:41:42 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7241019560AD;
	Mon, 13 Jan 2025 08:41:40 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	John Garry <john.g.garry@oracle.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH V2] block: mark GFP_NOIO around sysfs ->store()
Date: Mon, 13 Jan 2025 16:41:03 +0800
Message-ID: <20250113084103.762630-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

sysfs ->store is called with queue freezed, meantime we have several
->store() callbacks(update_nr_requests, wbt, scheduler) to allocate
memory with GFP_KERNEL which may run into direct reclaim code path,
then potential deadlock can be caused.

Fix the issue by marking NOIO around sysfs ->store()

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reported-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Closes: https://lore.kernel.org/linux-block/ead7c5ce5138912c1f3179d62370b84a64014a38.camel@linux.intel.com/
Fixes: bd166ef183c2 ("blk-mq-sched: add framework for MQ capable IO schedulers")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- add Closes & Reviewed-by & Fixes tag

 block/blk-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e828be777206..e09b455874bf 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -681,6 +681,7 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	struct queue_sysfs_entry *entry = to_queue(attr);
 	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
 	struct request_queue *q = disk->queue;
+	unsigned int noio_flag;
 	ssize_t res;
 
 	if (!entry->store_limit && !entry->store)
@@ -711,7 +712,9 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 
 	mutex_lock(&q->sysfs_lock);
 	blk_mq_freeze_queue(q);
+	noio_flag = memalloc_noio_save();
 	res = entry->store(disk, page, length);
+	memalloc_noio_restore(noio_flag);
 	blk_mq_unfreeze_queue(q);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
-- 
2.44.0


