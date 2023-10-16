Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6B97CB286
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 20:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjJPS33 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 14:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPS32 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 14:29:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B7E95
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 11:29:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7650CC433C8;
        Mon, 16 Oct 2023 18:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697480966;
        bh=yuGWXVbbEcuLeJ7Extuqjbdhidvv8Ij/CY/GCaXH430=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jn8xE6pqedjuHU8T69hr6m/q0c4n4YsWH67r+Qkch+x4Fm2VJ1iTMHcTXaV4HfEZa
         xMaNxPY2giJFKQOXl+3Urk046fGsnAv4bEYhFUjbRVDa8m0yhCg1Wk6LNXBwhL94s8
         WiPiSO+x2ScDiZN7gKppUKGJ6l+nEDI98DDS2ph6sNeElAhbE4sxVq4xx6IXc8jgOO
         82hMbCu51Ld8NwxEuoCkZ26WEkGlFsXWizFKnwRXtl45uH8X2h9XiJxunog18lTRZG
         4NNb6KkfDZM7I+6A+H2BLFuvGcgpKb3YkdiKrLOxk0TUVKdew5TeVtgimnhxbM/haE
         0T5gZS272sstA==
Date:   Mon, 16 Oct 2023 12:29:23 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshiiitr@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        vincentfu@gmail.com, ankit.kumar@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
Message-ID: <ZS2BA_Oj4kcwRbiY@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
 <20231013051458.39987-1-joshi.k@samsung.com>
 <20231013052612.GA6423@lst.de>
 <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com>
 <ZSlL-6Oa5J9duahR@kbusch-mbp>
 <3438f3b8-f7d4-f0bd-44ef-7efb09ed6151@samsung.com>
 <20231013154708.GA17455@lst.de>
 <CA+1E3r+gSWvN3VR38Uu=rHLy=9+iC-G5ta2sXq6LEXTG+OK_-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+1E3r+gSWvN3VR38Uu=rHLy=9+iC-G5ta2sXq6LEXTG+OK_-g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Oct 14, 2023 at 12:05:17AM +0530, Kanchan Joshi wrote:
> On Fri, Oct 13, 2023 at 9:17 PM Christoph Hellwig <hch@lst.de> wrote:
> > But I see no way out.
> > Now can we please get a patch to disable the unprivileged passthrough
> > ASAP to fix this probably exploitable hole?  Or should I write one?
> 
> I can write. I was waiting to see whether Keith has any different
> opinion on the route that v4 takes.

Sorry for the delay, I had some trouble with my test machine last week.

It sounds like the kernel memory is the only reason for the concern, and
you don't really care if we're corrupting user memory. If so, let's just
use that instead of kernel bounce buffers. (Minor digression, the
current bounce 'buf' is leaking kernel memory on reads since it doesn't
zero it).

Anyway, here's a diff that maps userspace buffer for "integrity"
payloads and tests okay on my side. It enforces that you can't cross
virtual page boundaries, so you can't corrupt anything outside your vma.
The allocation error handling isn't here, but it's just a proof of
concept right now.

---
diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index ec8ac8cf6e1b9..f591ba0771d87 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -91,6 +91,19 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 }
 EXPORT_SYMBOL(bio_integrity_alloc);
 
+void bio_integrity_unmap_user(struct bio_integrity_payload *bip)
+{
+	struct bvec_iter iter;
+	struct bio_vec bv;
+	bool dirty = bio_data_dir(bip->bip_bio) == READ;
+
+	bip_for_each_vec(bv, bip, iter) {
+		if (dirty && !PageCompound(bv.bv_page))
+			set_page_dirty_lock(bv.bv_page);
+		unpin_user_page(bv.bv_page);
+	}
+}
+
 /**
  * bio_integrity_free - Free bio integrity payload
  * @bio:	bio containing bip to be freed
@@ -105,6 +118,8 @@ void bio_integrity_free(struct bio *bio)
 
 	if (bip->bip_flags & BIP_BLOCK_INTEGRITY)
 		kfree(bvec_virt(bip->bip_vec));
+	if (bip->bip_flags & BIP_INTEGRITY_USER)
+		bio_integrity_unmap_user(bip);;
 
 	__bio_integrity_free(bs, bip);
 	bio->bi_integrity = NULL;
@@ -160,6 +175,47 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL(bio_integrity_add_page);
 
+int bio_integrity_map_user(struct bio *bio, void __user *ubuf, unsigned int len,
+			   u32 seed, u32 maxvecs)
+{
+	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
+	unsigned long align = q->dma_pad_mask | queue_dma_alignment(q);
+	struct page *stack_pages[UIO_FASTIOV];
+	size_t offset = offset_in_page(ubuf);
+	struct page **pages = stack_pages;
+	struct bio_integrity_payload *bip;
+	unsigned long ptr = (uintptr_t)ubuf;
+	int npages, ret, p;
+	u32 bytes;
+
+	if (ptr & align)
+		return -EINVAL;
+
+	bip = bio_integrity_alloc(bio, GFP_KERNEL, maxvecs);
+	if (IS_ERR(bip))
+		return PTR_ERR(bip);
+
+	ret = pin_user_pages_fast(ptr, UIO_FASTIOV, FOLL_WRITE, pages);
+	if (unlikely(ret < 0))
+		return ret;
+
+	npages = ret;
+	bytes = min_t(u32, len, PAGE_SIZE - offset);
+	for (p = 0; p < npages; p++) {
+		ret = bio_integrity_add_page(bio, pages[p], bytes, offset);
+		if (ret != bytes)
+			return -EINVAL;
+		len -= ret;
+		offset = 0;
+		bytes = min_t(u32, len, PAGE_SIZE);
+	}
+
+	bip->bip_iter.bi_sector = seed;
+	bip->bip_flags |= BIP_INTEGRITY_USER;
+	return 0;
+}
+EXPORT_SYMBOL(bio_integrity_map_user);
+
 /**
  * bio_integrity_process - Process integrity metadata for a bio
  * @bio:	bio to generate/verify integrity metadata for
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d8ff796fd5f21..06d6bba8ed637 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -96,52 +96,18 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
 	return (void __user *)ptrval;
 }
 
-static void *nvme_add_user_metadata(struct request *req, void __user *ubuf,
+static int nvme_add_user_metadata(struct request *req, void __user *ubuf,
 		unsigned len, u32 seed)
 {
-	struct bio_integrity_payload *bip;
-	int ret = -ENOMEM;
-	void *buf;
 	struct bio *bio = req->bio;
+	int ret;
 
-	buf = kmalloc(len, GFP_KERNEL);
-	if (!buf)
-		goto out;
-
-	ret = -EFAULT;
-	if ((req_op(req) == REQ_OP_DRV_OUT) && copy_from_user(buf, ubuf, len))
-		goto out_free_meta;
-
-	bip = bio_integrity_alloc(bio, GFP_KERNEL, 1);
-	if (IS_ERR(bip)) {
-		ret = PTR_ERR(bip);
-		goto out_free_meta;
-	}
-
-	bip->bip_iter.bi_sector = seed;
-	ret = bio_integrity_add_page(bio, virt_to_page(buf), len,
-			offset_in_page(buf));
-	if (ret != len) {
-		ret = -ENOMEM;
-		goto out_free_meta;
-	}
+	ret = bio_integrity_map_user(bio, ubuf, len, seed, 1);
+	if (ret)
+		return ret;
 
 	req->cmd_flags |= REQ_INTEGRITY;
-	return buf;
-out_free_meta:
-	kfree(buf);
-out:
-	return ERR_PTR(ret);
-}
-
-static int nvme_finish_user_metadata(struct request *req, void __user *ubuf,
-		void *meta, unsigned len, int ret)
-{
-	if (!ret && req_op(req) == REQ_OP_DRV_IN &&
-	    copy_to_user(ubuf, meta, len))
-		ret = -EFAULT;
-	kfree(meta);
-	return ret;
+	return 0;
 }
 
 static struct request *nvme_alloc_user_request(struct request_queue *q,
@@ -160,14 +126,12 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 
 static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		u32 meta_seed, void **metap, struct io_uring_cmd *ioucmd,
-		unsigned int flags)
+		u32 meta_seed, struct io_uring_cmd *ioucmd, unsigned int flags)
 {
 	struct request_queue *q = req->q;
 	struct nvme_ns *ns = q->queuedata;
 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
 	struct bio *bio = NULL;
-	void *meta = NULL;
 	int ret;
 
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
@@ -194,13 +158,10 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		bio_set_dev(bio, bdev);
 
 	if (bdev && meta_buffer && meta_len) {
-		meta = nvme_add_user_metadata(req, meta_buffer, meta_len,
+		ret = nvme_add_user_metadata(req, meta_buffer, meta_len,
 				meta_seed);
-		if (IS_ERR(meta)) {
-			ret = PTR_ERR(meta);
+		if (ret)
 			goto out_unmap;
-		}
-		*metap = meta;
 	}
 
 	return ret;
@@ -221,7 +182,6 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	struct nvme_ns *ns = q->queuedata;
 	struct nvme_ctrl *ctrl;
 	struct request *req;
-	void *meta = NULL;
 	struct bio *bio;
 	u32 effects;
 	int ret;
@@ -233,7 +193,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	req->timeout = timeout;
 	if (ubuffer && bufflen) {
 		ret = nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
-				meta_len, meta_seed, &meta, NULL, flags);
+				meta_len, meta_seed, NULL, flags);
 		if (ret)
 			return ret;
 	}
@@ -245,9 +205,6 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	ret = nvme_execute_rq(req, false);
 	if (result)
 		*result = le64_to_cpu(nvme_req(req)->result.u64);
-	if (meta)
-		ret = nvme_finish_user_metadata(req, meta_buffer, meta,
-						meta_len, ret);
 	if (bio)
 		blk_rq_unmap_user(bio);
 	blk_mq_free_request(req);
@@ -450,7 +407,6 @@ struct nvme_uring_cmd_pdu {
 	u32 nvme_status;
 	union {
 		struct {
-			void *meta; /* kernel-resident buffer */
 			void __user *meta_buffer;
 		};
 		u64 result;
@@ -478,9 +434,6 @@ static void nvme_uring_task_meta_cb(struct io_uring_cmd *ioucmd,
 
 	result = le64_to_cpu(nvme_req(req)->result.u64);
 
-	if (pdu->meta_len)
-		status = nvme_finish_user_metadata(req, pdu->u.meta_buffer,
-					pdu->u.meta, pdu->meta_len, status);
 	if (req->bio)
 		blk_rq_unmap_user(req->bio);
 	blk_mq_free_request(req);
@@ -560,7 +513,6 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	struct request *req;
 	blk_opf_t rq_flags = REQ_ALLOC_CACHE;
 	blk_mq_req_flags_t blk_flags = 0;
-	void *meta = NULL;
 	int ret;
 
 	c.common.opcode = READ_ONCE(cmd->opcode);
@@ -608,7 +560,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (d.addr && d.data_len) {
 		ret = nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
-			d.metadata_len, 0, &meta, ioucmd, vec);
+			d.metadata_len, 0, ioucmd, vec);
 		if (ret)
 			return ret;
 	}
@@ -623,7 +575,6 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	pdu->meta_len = d.metadata_len;
 	req->end_io_data = ioucmd;
 	if (pdu->meta_len) {
-		pdu->u.meta = meta;
 		pdu->u.meta_buffer = nvme_to_user_ptr(d.metadata);
 		req->end_io = nvme_uring_cmd_end_io_meta;
 	} else {
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 41d417ee13499..965382e62f137 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -324,6 +324,7 @@ enum bip_flags {
 	BIP_CTRL_NOCHECK	= 1 << 2, /* disable HBA integrity checking */
 	BIP_DISK_NOCHECK	= 1 << 3, /* disable disk integrity checking */
 	BIP_IP_CHECKSUM		= 1 << 4, /* IP checksum */
+	BIP_INTEGRITY_USER	= 1 << 5, /* Integrity payload is user address */
 };
 
 /*
@@ -720,6 +721,7 @@ static inline bool bioset_initialized(struct bio_set *bs)
 
 extern struct bio_integrity_payload *bio_integrity_alloc(struct bio *, gfp_t, unsigned int);
 extern int bio_integrity_add_page(struct bio *, struct page *, unsigned int, unsigned int);
+extern int bio_integrity_map_user(struct bio *bio, void __user *ubuf, unsigned int len, u32 seed, u32 maxvecs);
 extern bool bio_integrity_prep(struct bio *);
 extern void bio_integrity_advance(struct bio *, unsigned int);
 extern void bio_integrity_trim(struct bio *);
@@ -789,6 +791,12 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
 	return 0;
 }
 
+static inline int bio_integrity_map_user(struct bio *bio, void __user *ubuf,
+					 unsigned int len, u32 seed, u32 maxvecs)
+{
+	return -EINVAL
+}
+
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
 /*
--
