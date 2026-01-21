Return-Path: <stable+bounces-210718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNqcFbeicGlyYgAAu9opvQ
	(envelope-from <stable+bounces-210718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 10:56:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A9F54C31
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 10:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C78A08A79DA
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 09:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3598647D932;
	Wed, 21 Jan 2026 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtwykO5O"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378AC478871
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988372; cv=none; b=GBohBVuq4uhecoNSf0NP0Q4qwmBvxOVmJpSHUHsvia1Scq0b3NwetdkEGDK7NyXDf+203q64/bgmfFNVwD6EzvHM0uypDV7s8j22x4m0HG7Tdght99Vnea8CkhrbCjuXL5lfFxEs6IiR0dquN6XxcQc6SFTver2UeRDqVAe0Ka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988372; c=relaxed/simple;
	bh=/eN8zIIKNQxpmQVucIiTVzawDQ+FEdRDaShjbYiZjOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1ahEhgYks2oA7HccSjFl4Y0pT7Sq4CqxKr1KlfRgoOTk6aX8KYRAKFH7fQOunRUK3K/EYmgSvPK6Xu3Sx7lQoIfN9TY0k+PQFC3x0ddXu82qmD03K/Bt7LsqpGhrGjMkAL4LSTVKzPMJkmXrO34LAFGABAaAQlx4nlRp5pvSTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtwykO5O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768988369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p5jzsHOIycUcrMTy/H8KSOotdO8DAPpOaD75wfpgfoA=;
	b=gtwykO5Ov0Im4RvFZDzFDt6i5yWuU9csOGbGwzPmvvVeC77gUiBqcyaprZYxPiaT/g+8QO
	C7I2pnrXdaAcUAAUTEUKTEQvXHPbZcnYb8lxI8Z1JMneLZnxqHxQxbCKX0Yeioc86xSqQH
	riPkkbp+cX1ASWQwQXDbEDgKZEIqJgc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-CGOyXWI3MrC7WyZiDbSpjg-1; Wed,
 21 Jan 2026 04:39:25 -0500
X-MC-Unique: CGOyXWI3MrC7WyZiDbSpjg-1
X-Mimecast-MFC-AGG-ID: CGOyXWI3MrC7WyZiDbSpjg_1768988364
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 799BA1954B06;
	Wed, 21 Jan 2026 09:39:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2A681800665;
	Wed, 21 Jan 2026 09:39:21 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	stable@vger.kernel.org,
	Guangwu Zhang <guazhang@redhat.com>
Subject: [PATCH] nvmet: fix race in nvmet_bio_done() leading to NULL pointer dereference
Date: Wed, 21 Jan 2026 17:38:54 +0800
Message-ID: <20260121093854.1705806-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210718-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ming.lei@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: C5A9F54C31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is a race condition in nvmet_bio_done() that can cause a NULL
pointer dereference in blk_cgroup_bio_start():

1. nvmet_bio_done() is called when a bio completes
2. nvmet_req_complete() is called, which invokes req->ops->queue_response(req)
3. The queue_response callback can re-queue and re-submit the same request
4. The re-submission reuses the same inline_bio from nvmet_req
5. Meanwhile, nvmet_req_bio_put() (called after nvmet_req_complete)
   invokes bio_uninit() for inline_bio, which sets bio->bi_blkg to NULL
6. The re-submitted bio enters submit_bio_noacct_nocheck()
7. blk_cgroup_bio_start() dereferences bio->bi_blkg, causing a crash:

  BUG: kernel NULL pointer dereference, address: 0000000000000028
  #PF: supervisor read access in kernel mode
  RIP: 0010:blk_cgroup_bio_start+0x10/0xd0
  Call Trace:
   submit_bio_noacct_nocheck+0x44/0x250
   nvmet_bdev_execute_rw+0x254/0x370 [nvmet]
   process_one_work+0x193/0x3c0
   worker_thread+0x281/0x3a0

Fix this by reordering nvmet_bio_done() to call nvmet_req_bio_put()
BEFORE nvmet_req_complete(). This ensures the bio is cleaned up before
the request can be re-submitted, preventing the race condition.

Fixes: 190f4c2c863a ("nvmet: fix memory leak of bio integrity")
Cc: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: stable@vger.kernel.org
Cc: Guangwu Zhang <guazhang@redhat.com>
Link: http://www.mail-archive.com/debian-kernel@lists.debian.org/msg146238.html
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 8d246b8ca604..0103815542d4 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -180,9 +180,10 @@ u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 static void nvmet_bio_done(struct bio *bio)
 {
 	struct nvmet_req *req = bio->bi_private;
+	blk_status_t blk_status = bio->bi_status;
 
-	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
 	nvmet_req_bio_put(req, bio);
+	nvmet_req_complete(req, blk_to_nvme_status(req, blk_status));
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-- 
2.47.0


