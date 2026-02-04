Return-Path: <stable+bounces-214269-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFetINhtg2kFmwMAu9opvQ
	(envelope-from <stable+bounces-214269-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:03:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AA2E9C9A
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A91731F5515
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EE427702D;
	Wed,  4 Feb 2026 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pq7kJQ6V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFFA2BD012;
	Wed,  4 Feb 2026 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219124; cv=none; b=LQSNAEzGLbhQNc8eTDms5KqQs9dzsRh1UvDQHdSbOskYna+N+FCI4f4okuhfZ0JS7HpsgRjm2S1S6vD8TunWGaBvD12iFaT04WAjDfGKH5XmGXVivF+/vqL4OGZGLA1t4JSAjCdyRZZm69w0CS5S1evQ4T4fjXnrO7rVvlySx0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219124; c=relaxed/simple;
	bh=xTQUe9O9/waiirkcEnwElWO0vvV1ecS2CcFA6B0QMQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqSf2cJEefL7eYmLm9M50D9rGM8Ywwm3oT2GvD0RJjEUOJmrQqb/vIUOem8IbatDzUqBHBiciM+Es5u4F4ZoCIy6LPOmz4+gWdqHge4f9jKTv3m/PXm/soknWfVxdjVmudBv+o3N4ef/cG5O2+a21nmqdGlf4xGFpZSlFv8k9xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pq7kJQ6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3B7C4CEF7;
	Wed,  4 Feb 2026 15:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219124;
	bh=xTQUe9O9/waiirkcEnwElWO0vvV1ecS2CcFA6B0QMQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pq7kJQ6V8kZDTEcAvLEtiab7gaUdBHTctR3XSFUNNL+J33ezGIQ3gegMeAvthS3jq
	 f/Q6/dWtAFaf8dA5muDgUDSByP01yQFDHvzIwRvW7W2YK/Bikp2yJazwc3CUdPxMGw
	 FaZr6CfB0lTHPikOxvUIGK2isIP0Te/Az0JVwiJg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Guangwu Zhang <guazhang@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6.18 075/122] nvmet: fix race in nvmet_bio_done() leading to NULL pointer dereference
Date: Wed,  4 Feb 2026 15:40:57 +0100
Message-ID: <20260204143854.551210194@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214269-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail-archive.com:url,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,yadro.com:email]
X-Rspamd-Queue-Id: A2AA2E9C9A
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

commit 0fcee2cfc4b2e16e62ff8e0cc2cd8dd24efad65e upstream.

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/target/io-cmd-bdev.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -180,9 +180,10 @@ u16 blk_to_nvme_status(struct nvmet_req
 static void nvmet_bio_done(struct bio *bio)
 {
 	struct nvmet_req *req = bio->bi_private;
+	blk_status_t blk_status = bio->bi_status;
 
-	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
 	nvmet_req_bio_put(req, bio);
+	nvmet_req_complete(req, blk_to_nvme_status(req, blk_status));
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY



