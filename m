Return-Path: <stable+bounces-24063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35373869276
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC052835CD
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A1013B295;
	Tue, 27 Feb 2024 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fBJiGIBa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F2A1E534;
	Tue, 27 Feb 2024 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040931; cv=none; b=JHEJ4mHArZjNkaRwxJSyUg8v3DWsX/z64eIBtcqZyGspeTMCf1dp9JgR/Womenh32HSqIboNVSGbgQEKo9RpyF6BZBtJ3d5TIGhkM9kwMtTKCYR13nMNgS/jipYO4zOLEtqvvrPYp762sa0itjYPm6pT2cp4jnegDT0F1gU/OUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040931; c=relaxed/simple;
	bh=ulKaGtPmFlk+c6rJhZ5kayvT5LrUpcJn/1NATR5pGO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBPGvLo1MhDVpV+N7mJPFeUS5kg8py3t4NR/FZimHHGnZMW44zWaaq0IdHGrzVN1lLEkvuFkKwAfCxtVNDRk9yvjYMlzuGkPVAkB3EFwhlbrrP9re6/w5W8ZXH35H74KmacFuSKXUgfHrcxI/L2TqqNdLCvWzA1Z6N+wi5+xegk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fBJiGIBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91142C43390;
	Tue, 27 Feb 2024 13:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709040930;
	bh=ulKaGtPmFlk+c6rJhZ5kayvT5LrUpcJn/1NATR5pGO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fBJiGIBaXsbpLyx460AtncXLcWMWkS6XxXZgavOBScgSnVLtvzbWJe0zNvYcR+7u5
	 W5JfzSIGTeU3hBTIWwHCqMljPMRtGjDpNvnuRhx71/Lx2ikkrJXassLVAv0ajyp85Z
	 XPZHmstTFlx+sA6IAbC2ZCTgrQqqO+UEJKLm6l30=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 6.7 159/334] dm-crypt: recheck the integrity tag after a failure
Date: Tue, 27 Feb 2024 14:20:17 +0100
Message-ID: <20240227131635.611176966@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 42e15d12070b4ff9af2b980f1b65774c2dab0507 upstream.

If a userspace process reads (with O_DIRECT) multiple blocks into the same
buffer, dm-crypt reports an authentication error [1]. The error is
reported in a log and it may cause RAID leg being kicked out of the
array.

This commit fixes dm-crypt, so that if integrity verification fails, the
data is read again into a kernel buffer (where userspace can't modify it)
and the integrity tag is rechecked. If the recheck succeeds, the content
of the kernel buffer is copied into the user buffer; if the recheck fails,
an integrity error is reported.

[1] https://people.redhat.com/~mpatocka/testcases/blk-auth-modify/read2.c

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-crypt.c |   89 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 16 deletions(-)

--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -62,6 +62,8 @@ struct convert_context {
 		struct skcipher_request *req;
 		struct aead_request *req_aead;
 	} r;
+	bool aead_recheck;
+	bool aead_failed;
 
 };
 
@@ -82,6 +84,8 @@ struct dm_crypt_io {
 	blk_status_t error;
 	sector_t sector;
 
+	struct bvec_iter saved_bi_iter;
+
 	struct rb_node rb_node;
 } CRYPTO_MINALIGN_ATTR;
 
@@ -1370,10 +1374,13 @@ static int crypt_convert_block_aead(stru
 	if (r == -EBADMSG) {
 		sector_t s = le64_to_cpu(*sector);
 
-		DMERR_LIMIT("%pg: INTEGRITY AEAD ERROR, sector %llu",
-			    ctx->bio_in->bi_bdev, s);
-		dm_audit_log_bio(DM_MSG_PREFIX, "integrity-aead",
-				 ctx->bio_in, s, 0);
+		ctx->aead_failed = true;
+		if (ctx->aead_recheck) {
+			DMERR_LIMIT("%pg: INTEGRITY AEAD ERROR, sector %llu",
+				    ctx->bio_in->bi_bdev, s);
+			dm_audit_log_bio(DM_MSG_PREFIX, "integrity-aead",
+					 ctx->bio_in, s, 0);
+		}
 	}
 
 	if (!r && cc->iv_gen_ops && cc->iv_gen_ops->post)
@@ -1757,6 +1764,8 @@ static void crypt_io_init(struct dm_cryp
 	io->base_bio = bio;
 	io->sector = sector;
 	io->error = 0;
+	io->ctx.aead_recheck = false;
+	io->ctx.aead_failed = false;
 	io->ctx.r.req = NULL;
 	io->integrity_metadata = NULL;
 	io->integrity_metadata_from_pool = false;
@@ -1768,6 +1777,8 @@ static void crypt_inc_pending(struct dm_
 	atomic_inc(&io->io_pending);
 }
 
+static void kcryptd_queue_read(struct dm_crypt_io *io);
+
 /*
  * One of the bios was finished. Check for completion of
  * the whole request and correctly clean up the buffer.
@@ -1781,6 +1792,15 @@ static void crypt_dec_pending(struct dm_
 	if (!atomic_dec_and_test(&io->io_pending))
 		return;
 
+	if (likely(!io->ctx.aead_recheck) && unlikely(io->ctx.aead_failed) &&
+	    cc->on_disk_tag_size && bio_data_dir(base_bio) == READ) {
+		io->ctx.aead_recheck = true;
+		io->ctx.aead_failed = false;
+		io->error = 0;
+		kcryptd_queue_read(io);
+		return;
+	}
+
 	if (io->ctx.r.req)
 		crypt_free_req(cc, io->ctx.r.req, base_bio);
 
@@ -1816,15 +1836,19 @@ static void crypt_endio(struct bio *clon
 	struct dm_crypt_io *io = clone->bi_private;
 	struct crypt_config *cc = io->cc;
 	unsigned int rw = bio_data_dir(clone);
-	blk_status_t error;
+	blk_status_t error = clone->bi_status;
+
+	if (io->ctx.aead_recheck && !error) {
+		kcryptd_queue_crypt(io);
+		return;
+	}
 
 	/*
 	 * free the processed pages
 	 */
-	if (rw == WRITE)
+	if (rw == WRITE || io->ctx.aead_recheck)
 		crypt_free_buffer_pages(cc, clone);
 
-	error = clone->bi_status;
 	bio_put(clone);
 
 	if (rw == READ && !error) {
@@ -1845,6 +1869,22 @@ static int kcryptd_io_read(struct dm_cry
 	struct crypt_config *cc = io->cc;
 	struct bio *clone;
 
+	if (io->ctx.aead_recheck) {
+		if (!(gfp & __GFP_DIRECT_RECLAIM))
+			return 1;
+		crypt_inc_pending(io);
+		clone = crypt_alloc_buffer(io, io->base_bio->bi_iter.bi_size);
+		if (unlikely(!clone)) {
+			crypt_dec_pending(io);
+			return 1;
+		}
+		clone->bi_iter.bi_sector = cc->start + io->sector;
+		crypt_convert_init(cc, &io->ctx, clone, clone, io->sector);
+		io->saved_bi_iter = clone->bi_iter;
+		dm_submit_bio_remap(io->base_bio, clone);
+		return 0;
+	}
+
 	/*
 	 * We need the original biovec array in order to decrypt the whole bio
 	 * data *afterwards* -- thanks to immutable biovecs we don't need to
@@ -2107,6 +2147,14 @@ dec:
 
 static void kcryptd_crypt_read_done(struct dm_crypt_io *io)
 {
+	if (io->ctx.aead_recheck) {
+		if (!io->error) {
+			io->ctx.bio_in->bi_iter = io->saved_bi_iter;
+			bio_copy_data(io->base_bio, io->ctx.bio_in);
+		}
+		crypt_free_buffer_pages(io->cc, io->ctx.bio_in);
+		bio_put(io->ctx.bio_in);
+	}
 	crypt_dec_pending(io);
 }
 
@@ -2136,11 +2184,17 @@ static void kcryptd_crypt_read_convert(s
 
 	crypt_inc_pending(io);
 
-	crypt_convert_init(cc, &io->ctx, io->base_bio, io->base_bio,
-			   io->sector);
+	if (io->ctx.aead_recheck) {
+		io->ctx.cc_sector = io->sector + cc->iv_offset;
+		r = crypt_convert(cc, &io->ctx,
+				  test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags), true);
+	} else {
+		crypt_convert_init(cc, &io->ctx, io->base_bio, io->base_bio,
+				   io->sector);
 
-	r = crypt_convert(cc, &io->ctx,
-			  test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags), true);
+		r = crypt_convert(cc, &io->ctx,
+				  test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags), true);
+	}
 	/*
 	 * Crypto API backlogged the request, because its queue was full
 	 * and we're in softirq context, so continue from a workqueue
@@ -2182,10 +2236,13 @@ static void kcryptd_async_done(void *dat
 	if (error == -EBADMSG) {
 		sector_t s = le64_to_cpu(*org_sector_of_dmreq(cc, dmreq));
 
-		DMERR_LIMIT("%pg: INTEGRITY AEAD ERROR, sector %llu",
-			    ctx->bio_in->bi_bdev, s);
-		dm_audit_log_bio(DM_MSG_PREFIX, "integrity-aead",
-				 ctx->bio_in, s, 0);
+		ctx->aead_failed = true;
+		if (ctx->aead_recheck) {
+			DMERR_LIMIT("%pg: INTEGRITY AEAD ERROR, sector %llu",
+				    ctx->bio_in->bi_bdev, s);
+			dm_audit_log_bio(DM_MSG_PREFIX, "integrity-aead",
+					 ctx->bio_in, s, 0);
+		}
 		io->error = BLK_STS_PROTECTION;
 	} else if (error < 0)
 		io->error = BLK_STS_IOERR;
@@ -3110,7 +3167,7 @@ static int crypt_ctr_optional(struct dm_
 			sval = strchr(opt_string + strlen("integrity:"), ':') + 1;
 			if (!strcasecmp(sval, "aead")) {
 				set_bit(CRYPT_MODE_INTEGRITY_AEAD, &cc->cipher_flags);
-			} else  if (strcasecmp(sval, "none")) {
+			} else if (strcasecmp(sval, "none")) {
 				ti->error = "Unknown integrity profile";
 				return -EINVAL;
 			}



