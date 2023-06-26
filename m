Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BD473E771
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjFZSPM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjFZSPH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:15:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2726810CB
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BC5C60F3E
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60395C433C0;
        Mon, 26 Jun 2023 18:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803304;
        bh=9RhFnNFUrYpExZRzEaigbNNxuuex4f5kuF0Xbx1Rv9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RO5wDhrEkrxRP27K1kbilivQg31nCdgXuM20XzSeok9oRuS9qGk9pxR6xrmD0DKpC
         gMJSGrRh7Sh54BtWAx7D+aoJ2A8Wx2gA/2ihcTOenjCvDBesfOH5ENoYnljApbWfYd
         nJDWeEMqieWHCNLhO94Q0XilDi0BSX8VRUPViu8g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Suwan Kim <suwan.kim027@gmail.com>, edliaw@google.com,
        "Roberts, Martin" <martin.roberts@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 6.3 016/199] Revert "virtio-blk: support completion batching for the IRQ path"
Date:   Mon, 26 Jun 2023 20:08:42 +0200
Message-ID: <20230626180806.390383874@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michael S. Tsirkin <mst@redhat.com>

commit afd384f0dbea2229fd11159efb86a5b41051c4a9 upstream.

This reverts commit 07b679f70d73483930e8d3c293942416d9cd5c13.

This change appears to have broken things...
We now see applications hanging during disk accesses.
e.g.
multi-port virtio-blk device running in h/w (FPGA)
Host running a simple 'fio' test.
[global]
thread=1
direct=1
ioengine=libaio
norandommap=1
group_reporting=1
bs=4K
rw=read
iodepth=128
runtime=1
numjobs=4
time_based
[job0]
filename=/dev/vda
[job1]
filename=/dev/vdb
[job2]
filename=/dev/vdc
...
[job15]
filename=/dev/vdp

i.e. 16 disks; 4 queues per disk; simple burst of 4KB reads
This is repeatedly run in a loop.

After a few, normally <10 seconds, fio hangs.
With 64 queues (16 disks), failure occurs within a few seconds; with 8 queues (2 disks) it may take ~hour before hanging.
Last message:
fio-3.19
Starting 8 threads
Jobs: 1 (f=1): [_(7),R(1)][68.3%][eta 03h:11m:06s]
I think this means at the end of the run 1 queue was left incomplete.

'diskstats' (run while fio is hung) shows no outstanding transactions.
e.g.
$ cat /proc/diskstats
...
252       0 vda 1843140071 0 14745120568 712568645 0 0 0 0 0 3117947 712568645 0 0 0 0 0 0
252      16 vdb 1816291511 0 14530332088 704905623 0 0 0 0 0 3117711 704905623 0 0 0 0 0 0
...

Other stats (in the h/w, and added to the virtio-blk driver ([a]virtio_queue_rq(), [b]virtblk_handle_req(), [c]virtblk_request_done()) all agree, and show every request had a completion, and that virtblk_request_done() never gets called.
e.g.
PF= 0                         vq=0           1           2           3
[a]request_count     -   839416590   813148916   105586179    84988123
[b]completion1_count -   839416590   813148916   105586179    84988123
[c]completion2_count -           0           0           0           0

PF= 1                         vq=0           1           2           3
[a]request_count     -   823335887   812516140   104582672    75856549
[b]completion1_count -   823335887   812516140   104582672    75856549
[c]completion2_count -           0           0           0           0

i.e. the issue is after the virtio-blk driver.

This change was introduced in kernel 6.3.0.
I am seeing this using 6.3.3.
If I run with an earlier kernel (5.15), it does not occur.
If I make a simple patch to the 6.3.3 virtio-blk driver, to skip the blk_mq_add_to_batch()call, it does not fail.
e.g.
kernel 5.15 - this is OK
virtio_blk.c,virtblk_done() [irq handler]
                 if (likely(!blk_should_fake_timeout(req->q))) {
                          blk_mq_complete_request(req);
                 }

kernel 6.3.3 - this fails
virtio_blk.c,virtblk_handle_req() [irq handler]
                 if (likely(!blk_should_fake_timeout(req->q))) {
                          if (!blk_mq_complete_request_remote(req)) {
                                  if (!blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr), virtblk_complete_batch)) {
                                           virtblk_request_done(req);    //this never gets called... so blk_mq_add_to_batch() must always succeed
                                   }
                          }
                 }

If I do, kernel 6.3.3 - this is OK
virtio_blk.c,virtblk_handle_req() [irq handler]
                 if (likely(!blk_should_fake_timeout(req->q))) {
                          if (!blk_mq_complete_request_remote(req)) {
                                   virtblk_request_done(req); //force this here...
                                  if (!blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr), virtblk_complete_batch)) {
                                           virtblk_request_done(req);    //this never gets called... so blk_mq_add_to_batch() must always succeed
                                   }
                          }
                 }

Perhaps you might like to fix/test/revert this change...
Martin

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306090826.C1fZmdMe-lkp@intel.com/
Cc: Suwan Kim <suwan.kim027@gmail.com>
Tested-by: edliaw@google.com
Reported-by: "Roberts, Martin" <martin.roberts@intel.com>
Message-Id: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/virtio_blk.c |   82 ++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -348,63 +348,33 @@ static inline void virtblk_request_done(
 	blk_mq_end_request(req, status);
 }
 
-static void virtblk_complete_batch(struct io_comp_batch *iob)
-{
-	struct request *req;
-
-	rq_list_for_each(&iob->req_list, req) {
-		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
-		virtblk_cleanup_cmd(req);
-	}
-	blk_mq_end_request_batch(iob);
-}
-
-static int virtblk_handle_req(struct virtio_blk_vq *vq,
-			      struct io_comp_batch *iob)
-{
-	struct virtblk_req *vbr;
-	int req_done = 0;
-	unsigned int len;
-
-	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
-		struct request *req = blk_mq_rq_from_pdu(vbr);
-
-		if (likely(!blk_should_fake_timeout(req->q)) &&
-		    !blk_mq_complete_request_remote(req) &&
-		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
-					 virtblk_complete_batch))
-			virtblk_request_done(req);
-		req_done++;
-	}
-
-	return req_done;
-}
-
 static void virtblk_done(struct virtqueue *vq)
 {
 	struct virtio_blk *vblk = vq->vdev->priv;
-	struct virtio_blk_vq *vblk_vq = &vblk->vqs[vq->index];
-	int req_done = 0;
+	bool req_done = false;
+	int qid = vq->index;
+	struct virtblk_req *vbr;
 	unsigned long flags;
-	DEFINE_IO_COMP_BATCH(iob);
+	unsigned int len;
 
-	spin_lock_irqsave(&vblk_vq->lock, flags);
+	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
 	do {
 		virtqueue_disable_cb(vq);
-		req_done += virtblk_handle_req(vblk_vq, &iob);
+		while ((vbr = virtqueue_get_buf(vblk->vqs[qid].vq, &len)) != NULL) {
+			struct request *req = blk_mq_rq_from_pdu(vbr);
 
+			if (likely(!blk_should_fake_timeout(req->q)))
+				blk_mq_complete_request(req);
+			req_done = true;
+		}
 		if (unlikely(virtqueue_is_broken(vq)))
 			break;
 	} while (!virtqueue_enable_cb(vq));
 
-	if (req_done) {
-		if (!rq_list_empty(iob.req_list))
-			iob.complete(&iob);
-
-		/* In case queue is stopped waiting for more buffers. */
+	/* In case queue is stopped waiting for more buffers. */
+	if (req_done)
 		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
-	}
-	spin_unlock_irqrestore(&vblk_vq->lock, flags);
+	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
 }
 
 static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
@@ -1283,15 +1253,37 @@ static void virtblk_map_queues(struct bl
 	}
 }
 
+static void virtblk_complete_batch(struct io_comp_batch *iob)
+{
+	struct request *req;
+
+	rq_list_for_each(&iob->req_list, req) {
+		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
+		virtblk_cleanup_cmd(req);
+	}
+	blk_mq_end_request_batch(iob);
+}
+
 static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct virtio_blk *vblk = hctx->queue->queuedata;
 	struct virtio_blk_vq *vq = get_virtio_blk_vq(hctx);
+	struct virtblk_req *vbr;
 	unsigned long flags;
+	unsigned int len;
 	int found = 0;
 
 	spin_lock_irqsave(&vq->lock, flags);
-	found = virtblk_handle_req(vq, iob);
+
+	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
+		struct request *req = blk_mq_rq_from_pdu(vbr);
+
+		found++;
+		if (!blk_mq_complete_request_remote(req) &&
+		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
+						virtblk_complete_batch))
+			virtblk_request_done(req);
+	}
 
 	if (found)
 		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);


