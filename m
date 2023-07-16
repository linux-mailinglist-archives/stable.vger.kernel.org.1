Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C395755480
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjGPUbC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjGPUbB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:31:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044C3E40
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:31:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A97260E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3E6C433C8;
        Sun, 16 Jul 2023 20:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539458;
        bh=4wdoPoDoU/I0fBOLHS9pBXLVVZzKXJs+p+bUTI6z/y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E46iiybdkXq4XPaMvjbcTdwiPyLzrc0EczyQPER9b18XlpjkUtoTPrJTghWRMEmxh
         BGJnVJ4Al0j/uaeKm06EuvErGdY7V14j1ay0FYI8hHmmv3AzjL0LebSvU9Mm+Ijm5m
         TjAa28tayPWWvpuFUUGHhPvCI92JAz859iDI/8PE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yue Hu <huyue2@coolpad.com>,
        Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 005/591] erofs: avoid tagged pointers to mark sync decompression
Date:   Sun, 16 Jul 2023 21:42:24 +0200
Message-ID: <20230716194924.004567620@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit cdba55067f2f9fdc7870ffcb6aef912d3468cff8 ]

We could just use a boolean in z_erofs_decompressqueue for sync
decompression to simplify the code.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230204093040.97967-2-hsiangkao@linux.alibaba.com
Stable-dep-of: 967c28b23f6c ("erofs: kill hooked chains to avoid loops on deduplicated compressed images")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zdata.c | 42 ++++++++++++++++--------------------------
 fs/erofs/zdata.h |  2 +-
 2 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ccf7c55d477fe..8e80871a8c1d7 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1157,12 +1157,12 @@ static void z_erofs_decompressqueue_work(struct work_struct *work)
 }
 
 static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
-				       bool sync, int bios)
+				       int bios)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(io->sb);
 
 	/* wake up the caller thread for sync decompression */
-	if (sync) {
+	if (io->sync) {
 		if (!atomic_add_return(bios, &io->pending_bios))
 			complete(&io->u.done);
 		return;
@@ -1294,9 +1294,8 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	return page;
 }
 
-static struct z_erofs_decompressqueue *
-jobqueue_init(struct super_block *sb,
-	      struct z_erofs_decompressqueue *fgq, bool *fg)
+static struct z_erofs_decompressqueue *jobqueue_init(struct super_block *sb,
+			      struct z_erofs_decompressqueue *fgq, bool *fg)
 {
 	struct z_erofs_decompressqueue *q;
 
@@ -1313,6 +1312,7 @@ jobqueue_init(struct super_block *sb,
 		init_completion(&fgq->u.done);
 		atomic_set(&fgq->pending_bios, 0);
 		q->eio = false;
+		q->sync = true;
 	}
 	q->sb = sb;
 	q->head = Z_EROFS_PCLUSTER_TAIL_CLOSED;
@@ -1326,20 +1326,6 @@ enum {
 	NR_JOBQUEUES,
 };
 
-static void *jobqueueset_init(struct super_block *sb,
-			      struct z_erofs_decompressqueue *q[],
-			      struct z_erofs_decompressqueue *fgq, bool *fg)
-{
-	/*
-	 * if managed cache is enabled, bypass jobqueue is needed,
-	 * no need to read from device for all pclusters in this queue.
-	 */
-	q[JQ_BYPASS] = jobqueue_init(sb, fgq + JQ_BYPASS, NULL);
-	q[JQ_SUBMIT] = jobqueue_init(sb, fgq + JQ_SUBMIT, fg);
-
-	return tagptr_cast_ptr(tagptr_fold(tagptr1_t, q[JQ_SUBMIT], *fg));
-}
-
 static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 				    z_erofs_next_pcluster_t qtail[],
 				    z_erofs_next_pcluster_t owned_head)
@@ -1361,8 +1347,7 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 
 static void z_erofs_decompressqueue_endio(struct bio *bio)
 {
-	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
-	struct z_erofs_decompressqueue *q = tagptr_unfold_ptr(t);
+	struct z_erofs_decompressqueue *q = bio->bi_private;
 	blk_status_t err = bio->bi_status;
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
@@ -1381,7 +1366,7 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
 	}
 	if (err)
 		q->eio = true;
-	z_erofs_decompress_kickoff(q, tagptr_unfold_tags(t), -1);
+	z_erofs_decompress_kickoff(q, -1);
 	bio_put(bio);
 }
 
@@ -1394,7 +1379,6 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	struct address_space *mc = MNGD_MAPPING(EROFS_SB(sb));
 	z_erofs_next_pcluster_t qtail[NR_JOBQUEUES];
 	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
-	void *bi_private;
 	z_erofs_next_pcluster_t owned_head = f->owned_head;
 	/* bio is NULL initially, so no need to initialize last_{index,bdev} */
 	pgoff_t last_index;
@@ -1404,7 +1388,13 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	unsigned long pflags;
 	int memstall = 0;
 
-	bi_private = jobqueueset_init(sb, q, fgq, force_fg);
+	/*
+	 * if managed cache is enabled, bypass jobqueue is needed,
+	 * no need to read from device for all pclusters in this queue.
+	 */
+	q[JQ_BYPASS] = jobqueue_init(sb, fgq + JQ_BYPASS, NULL);
+	q[JQ_SUBMIT] = jobqueue_init(sb, fgq + JQ_SUBMIT, force_fg);
+
 	qtail[JQ_BYPASS] = &q[JQ_BYPASS]->head;
 	qtail[JQ_SUBMIT] = &q[JQ_SUBMIT]->head;
 
@@ -1473,7 +1463,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				last_bdev = mdev.m_bdev;
 				bio->bi_iter.bi_sector = (sector_t)cur <<
 					LOG_SECTORS_PER_BLOCK;
-				bio->bi_private = bi_private;
+				bio->bi_private = q[JQ_SUBMIT];
 				if (f->readahead)
 					bio->bi_opf |= REQ_RAHEAD;
 				++nr_bios;
@@ -1506,7 +1496,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 		kvfree(q[JQ_SUBMIT]);
 		return;
 	}
-	z_erofs_decompress_kickoff(q[JQ_SUBMIT], *force_fg, nr_bios);
+	z_erofs_decompress_kickoff(q[JQ_SUBMIT], nr_bios);
 }
 
 static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index d98c952129852..b139de5473a97 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -110,7 +110,7 @@ struct z_erofs_decompressqueue {
 		struct work_struct work;
 	} u;
 
-	bool eio;
+	bool eio, sync;
 };
 
 static inline bool z_erofs_is_inline_pcluster(struct z_erofs_pcluster *pcl)
-- 
2.39.2



