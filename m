Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A0B7A7C17
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjITL5y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbjITL5w (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:57:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4794DC6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:57:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA7CC433C9;
        Wed, 20 Sep 2023 11:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211065;
        bh=D3PtxeoaE60brmsBwFAxzL4FcJuRQQNerCaLTK8Oi40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L84ucu66/r0Y4h9Bei1oHV0boUtBT61smTICtG+vuPbcvfd1X88DhhsRjSxv+LVSC
         P0nQ1O/jw6fl5WmNn3Sv8BIZ6tyo83GMzOk+eF3ETihXMprISkc1enM/qRWAtgM5iY
         rkHhR1qzJPB8Bi+GWEROcZF8qZSj3x7TUQiZFxmY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 095/139] nvmet: use bvec_set_page to initialize bvecs
Date:   Wed, 20 Sep 2023 13:30:29 +0200
Message-ID: <20230920112839.143325109@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit fc41c97a3a7b08131e6998bc7692f95729f9d359 ]

Use the bvec_set_page helper to initialize bvecs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Link: https://lore.kernel.org/r/20230203150634.3199647-7-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 1f0bbf28940c ("nvmet-tcp: pass iov_len instead of sg->length to bvec_set_page()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/io-cmd-file.c | 10 ++--------
 drivers/nvme/target/tcp.c         |  5 ++---
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 871c4f32f443f..2d068439b129c 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -73,13 +73,6 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	return ret;
 }
 
-static void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)
-{
-	bv->bv_page = sg_page(sg);
-	bv->bv_offset = sg->offset;
-	bv->bv_len = sg->length;
-}
-
 static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 		unsigned long nr_segs, size_t count, int ki_flags)
 {
@@ -146,7 +139,8 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 
 	memset(&req->f.iocb, 0, sizeof(struct kiocb));
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
-		nvmet_file_init_bvec(&req->f.bvec[bv_cnt], sg);
+		bvec_set_page(&req->f.bvec[bv_cnt], sg_page(sg), sg->length,
+			      sg->offset);
 		len += req->f.bvec[bv_cnt].bv_len;
 		total_len += req->f.bvec[bv_cnt].bv_len;
 		bv_cnt++;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index cc05c094de221..c5759eb503d00 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -321,9 +321,8 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	while (length) {
 		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
 
-		iov->bv_page = sg_page(sg);
-		iov->bv_len = sg->length;
-		iov->bv_offset = sg->offset + sg_offset;
+		bvec_set_page(iov, sg_page(sg), sg->length,
+				sg->offset + sg_offset);
 
 		length -= iov_len;
 		sg = sg_next(sg);
-- 
2.40.1



