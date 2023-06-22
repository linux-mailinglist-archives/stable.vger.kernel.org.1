Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6A573974A
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 08:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjFVGQi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 02:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjFVGQh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 02:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3141D1731
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 23:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687414553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=bQxNRZKVncqA+MtbDqDOePL9KJcYOTMkewvpfqhF3Gw=;
        b=RHzyP5qYEMzzh6vrHHssb9q1e86lCE4itmMXc26CVlNsB5P9wIMc0WWQCtOjIXLolZIkkd
        KA1NhHjFrQ+ejRYTOOrSX5nPiqTqiXtpLGZANMBpj1IcEJ5Kksfr5SN+gA66mnPdq8UJpI
        PV+UYRWNL1VW3yyJs5X1ySigOggyBHo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-Uktz43EMNSe5wGsOZDbDyA-1; Thu, 22 Jun 2023 02:15:51 -0400
X-MC-Unique: Uktz43EMNSe5wGsOZDbDyA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9879d2fc970so368498366b.0
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 23:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687414550; x=1690006550;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQxNRZKVncqA+MtbDqDOePL9KJcYOTMkewvpfqhF3Gw=;
        b=aifSB6cEo+EKoO+hb05NxYbfblMGXdm1q3sCfEcxFB6WyE1umD7HMVsbUTZ+lKZVtV
         9Ll6zblf0YfHqXfZQpdtzVvJdOibm6k1ZNa8dqH5Cl4zi7Z8iZAfi4xxLJhmU5r8wnd3
         xwm3VRjY3F1kg/3jbhptF1gjTuPt9bl8Jq9AVKP6Qyu3fyAGp12fTwXR/X04OkhWfB12
         Mn3jBSdjGiwk2mt+cmh2/hj6sDqwq56gPMoN5dfSiifXSRmE4/X1s2itp8pwuGX7goLX
         ZwKx0VrmSgbClDWjzkZYbSjBUKNJYJ5yzoyRlmb6BX6gcg2/c8oGrN3d8QB/JgABwQJu
         Nc0g==
X-Gm-Message-State: AC+VfDzIQlNOtxOTrSywv4R21kPBvBjQXqUdjb6OO9BLbOqfu0ULASqF
        k+vN7P7Xa8u/qFIM/oxb65xfEKXFioQuea3Qh1kHJ8widl3ihMdmH8buXKj0M61pf2ZI4v7lOUt
        tDs1PJ7TrdjVUpYwwLOfLjL+eZ7JdHcGVvmQ9QbRFaTMyhnwNUuju/yd+C1Q1vpIShPDbMw==
X-Received: by 2002:a17:907:94c8:b0:987:33c3:e288 with SMTP id dn8-20020a17090794c800b0098733c3e288mr14103002ejc.29.1687414549686;
        Wed, 21 Jun 2023 23:15:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5prA2wZHbmiIwmDnqh9dr93LRLXPCX/K5g9Ro0B6urlj6KBCaJiofy9c+3l5IQyn30tgXD5g==
X-Received: by 2002:a17:907:94c8:b0:987:33c3:e288 with SMTP id dn8-20020a17090794c800b0098733c3e288mr14102985ejc.29.1687414549192;
        Wed, 21 Jun 2023 23:15:49 -0700 (PDT)
Received: from redhat.com ([2.52.159.126])
        by smtp.gmail.com with ESMTPSA id g11-20020a1709061c8b00b0096fbc516a93sm4074058ejh.211.2023.06.21.23.15.47
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 23:15:48 -0700 (PDT)
Date:   Thu, 22 Jun 2023 02:15:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     stable@vger.kernel.org
Subject: [mst@redhat.com: [PATCH v2] Revert "virtio-blk: support completion
 batching for the IRQ path"]
Message-ID: <20230622021540-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

----- Forwarded message from "Michael S. Tsirkin" <mst@redhat.com> -----

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Fri, 9 Jun 2023 03:27:28 -0400
To: linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>, Suwan Kim <suwan.kim027@gmail.com>, "Roberts, Martin" <martin.roberts@intel.com>, Jason Wang
	<jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org
Subject: [PATCH v2] Revert "virtio-blk: support completion batching for the IRQ path"
Message-ID: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>

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
Reported-by: "Roberts, Martin" <martin.roberts@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Since v1:
	fix build error

Still completely untested as I'm traveling.
Martin, Suwan, could you please test and report?
Suwan if you have a better revert in mind pls post and
I will be happy to drop this.

Thanks!


 drivers/block/virtio_blk.c | 82 +++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2b918e28acaa..b47358da92a2 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -348,63 +348,33 @@ static inline void virtblk_request_done(struct request *req)
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
@@ -1283,15 +1253,37 @@ static void virtblk_map_queues(struct blk_mq_tag_set *set)
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
-- 
MST

----- End forwarded message -----

