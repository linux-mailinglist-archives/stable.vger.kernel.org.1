Return-Path: <stable+bounces-234259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNWwOMyc1mnlGggAu9opvQ
	(envelope-from <stable+bounces-234259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:22:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9F63C0811
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18988303ABC2
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B483D8907;
	Wed,  8 Apr 2026 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T1EwEDbP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB81B2DAFAA;
	Wed,  8 Apr 2026 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672396; cv=none; b=PzaavmmHU/bkfFz1oKoLrQRICq4CBsP8V+SjsmRrPrnQ9XNtvPy8qmKOOUTCxO4Vunp+qyuuR8I0K1foPP/2GMQYM83ywB2kSMKBpNydDNfSRAJTicnhzBA9JYjx6AuUw7Fya7WJnBaNeDviLGJO6GvC+s3XnGST8SijNCxaXuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672396; c=relaxed/simple;
	bh=o3hwE1rVwKHTxGMkmH8EH3kly2CbiFdNRe2jHKyzp1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/TYj2vY+QSOrBHpbpwL1STWYmOCopSZ2p4EgF2545MiQEMFWnXhVRaKYfV7B5sj1YmRb9xKtP4BOPMd/FLXVzysXKQSd50kiyebRiBfbSmRTeqnBTOQBN8VE7rQMDFXiIYRkM92DW+DUE8zN0NzmlQUkiCgtdO2pu0r3vqfQUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T1EwEDbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5039DC2BC87;
	Wed,  8 Apr 2026 18:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672395;
	bh=o3hwE1rVwKHTxGMkmH8EH3kly2CbiFdNRe2jHKyzp1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T1EwEDbPzTebLAb5CoC9S6HljNAhbMVj0suuOULZFyio9Pn4xbaiN44XHePY4GB8f
	 WtMAvS8ah2S/lbzA8eb5V0YxZvpBqf1lYu4er4Vd9peLKKH1ADrg6RsaWq3/5Tq4wJ
	 AkVKtf+lIv+nklVjfzMH9tIS8tvBWCQctGfrffoU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Maximilian Heyne <mheyne@amazon.de>,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 261/312] blk-mq: move the call to blk_put_queue out of blk_mq_destroy_queue
Date: Wed,  8 Apr 2026 20:02:58 +0200
Message-ID: <20260408175943.495534611@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234259-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,amazon.de:email,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ispras.ru:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,grimberg.me:email]
X-Rspamd-Queue-Id: EB9F63C0811
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 2b3f056f72e56fa07df69b4705e0b46a6c08e77c ]

The fact that blk_mq_destroy_queue also drops a queue reference leads
to various places having to grab an extra reference.  Move the call to
blk_put_queue into the callers to allow removing the extra references.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Link: https://lore.kernel.org/r/20221018135720.670094-2-hch@lst.de
[axboe: fix fabrics_q vs admin_q conflict in nvme core.c]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 03b3bcd319b3 ("nvme: fix admin request_queue lifetime")
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
Tested-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c            |  4 +---
 block/bsg-lib.c           |  2 ++
 drivers/nvme/host/apple.c |  1 +
 drivers/nvme/host/core.c  | 10 ++++++++--
 drivers/nvme/host/pci.c   |  1 +
 drivers/scsi/scsi_sysfs.c |  1 +
 drivers/ufs/core/ufshcd.c |  2 ++
 7 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a9697541d67f9..8b9e5ca398242 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4194,9 +4194,6 @@ void blk_mq_destroy_queue(struct request_queue *q)
 	blk_sync_queue(q);
 	blk_mq_cancel_work_sync(q);
 	blk_mq_exit_queue(q);
-
-	/* @q is and will stay empty, shutdown and put */
-	blk_put_queue(q);
 }
 EXPORT_SYMBOL(blk_mq_destroy_queue);
 
@@ -4213,6 +4210,7 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
 	disk = __alloc_disk_node(q, set->numa_node, lkclass);
 	if (!disk) {
 		blk_mq_destroy_queue(q);
+		blk_put_queue(q);
 		return ERR_PTR(-ENOMEM);
 	}
 	set_bit(GD_OWNS_QUEUE, &disk->state);
diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index d6f5dcdce748c..435c32373cd68 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -325,6 +325,7 @@ void bsg_remove_queue(struct request_queue *q)
 
 		bsg_unregister_queue(bset->bd);
 		blk_mq_destroy_queue(q);
+		blk_put_queue(q);
 		blk_mq_free_tag_set(&bset->tag_set);
 		kfree(bset);
 	}
@@ -400,6 +401,7 @@ struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 	return q;
 out_cleanup_queue:
 	blk_mq_destroy_queue(q);
+	blk_put_queue(q);
 out_queue:
 	blk_mq_free_tag_set(set);
 out_tag_set:
diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 262d2b60ac6dd..c5fc293c22123 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1510,6 +1510,7 @@ static int apple_nvme_probe(struct platform_device *pdev)
 	if (!blk_get_queue(anv->ctrl.admin_q)) {
 		nvme_start_admin_queue(&anv->ctrl);
 		blk_mq_destroy_queue(anv->ctrl.admin_q);
+		blk_put_queue(anv->ctrl.admin_q);
 		anv->ctrl.admin_q = NULL;
 		ret = -ENODEV;
 		goto put_dev;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 938af571dc13e..044e1a9c099b3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5031,6 +5031,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 
 out_cleanup_admin_q:
 	blk_mq_destroy_queue(ctrl->admin_q);
+	blk_put_queue(ctrl->admin_q);
 out_free_tagset:
 	blk_mq_free_tag_set(set);
 	ctrl->admin_q = NULL;
@@ -5042,8 +5043,11 @@ EXPORT_SYMBOL_GPL(nvme_alloc_admin_tag_set);
 void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl)
 {
 	blk_mq_destroy_queue(ctrl->admin_q);
-	if (ctrl->ops->flags & NVME_F_FABRICS)
+	blk_put_queue(ctrl->admin_q);
+	if (ctrl->ops->flags & NVME_F_FABRICS) {
 		blk_mq_destroy_queue(ctrl->fabrics_q);
+		blk_put_queue(ctrl->fabrics_q);
+	}
 	blk_mq_free_tag_set(ctrl->admin_tagset);
 }
 EXPORT_SYMBOL_GPL(nvme_remove_admin_tag_set);
@@ -5099,8 +5103,10 @@ EXPORT_SYMBOL_GPL(nvme_alloc_io_tag_set);
 
 void nvme_remove_io_tag_set(struct nvme_ctrl *ctrl)
 {
-	if (ctrl->ops->flags & NVME_F_FABRICS)
+	if (ctrl->ops->flags & NVME_F_FABRICS) {
 		blk_mq_destroy_queue(ctrl->connect_q);
+		blk_put_queue(ctrl->connect_q);
+	}
 	blk_mq_free_tag_set(ctrl->tagset);
 }
 EXPORT_SYMBOL_GPL(nvme_remove_io_tag_set);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 15bc7d81df4bd..27a4706bc9131 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1783,6 +1783,7 @@ static void nvme_dev_remove_admin(struct nvme_dev *dev)
 		 */
 		nvme_start_admin_queue(&dev->ctrl);
 		blk_mq_destroy_queue(dev->ctrl.admin_q);
+		blk_put_queue(dev->ctrl.admin_q);
 		blk_mq_free_tag_set(&dev->admin_tagset);
 	}
 }
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 456b92c3a7811..af81b2ba0c9b3 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1486,6 +1486,7 @@ void __scsi_remove_device(struct scsi_device *sdev)
 	mutex_unlock(&sdev->state_mutex);
 
 	blk_mq_destroy_queue(sdev->request_queue);
+	blk_put_queue(sdev->request_queue);
 	kref_put(&sdev->host->tagset_refcnt, scsi_mq_free_tags);
 	cancel_work_sync(&sdev->requeue_work);
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f72ba0b206437..a39ffc62d88a1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9651,6 +9651,7 @@ void ufshcd_remove(struct ufs_hba *hba)
 	ufshpb_remove(hba);
 	ufs_sysfs_remove_nodes(hba->dev);
 	blk_mq_destroy_queue(hba->tmf_queue);
+	blk_put_queue(hba->tmf_queue);
 	blk_mq_free_tag_set(&hba->tmf_tag_set);
 	scsi_remove_host(hba->host);
 	/* disable interrupts */
@@ -9953,6 +9954,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 
 free_tmf_queue:
 	blk_mq_destroy_queue(hba->tmf_queue);
+	blk_put_queue(hba->tmf_queue);
 free_tmf_tag_set:
 	blk_mq_free_tag_set(&hba->tmf_tag_set);
 out_remove_scsi_host:
-- 
2.53.0




