Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F51779BECD
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350652AbjIKVkT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238863AbjIKOGi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:06:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92CBCF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:06:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05658C433C7;
        Mon, 11 Sep 2023 14:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441194;
        bh=mreJ62WD1SOXlrqdhrFWHAivBuaeVc6Wfj9oUjEA4LM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQeYL3KXmip5SpAE5vD+El2D/mCv3Av29W6Zvh77qrDRghxYKvBhR980hkwg6K0tW
         6GMerNJFTVIz/TyTVsSHfbeGHiSZBqGZyQMQkNLUTGRVdbIWRElHvQyuNIxglSyJ3l
         ju0jJbXEBUk/OMGagvZmHdhLF+3HM0OagOBqUeO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 328/739] block: move the bi_size overflow check in __bio_try_merge_page
Date:   Mon, 11 Sep 2023 15:42:07 +0200
Message-ID: <20230911134700.261573529@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 613699050a49760f1d70c74f71bd0b013ca3c356 ]

Checking for availability in bi_size in a function that attempts to
merge into an existing segment is a bit odd, as the limit also applies
when adding a new segment.  This code works fine as we always call
__bio_try_merge_page, but contributes to sub-optimal calling conventions
and doesn't lead to clear code.

Move it to two of the callers instead, the third one already has a more
strict check that includes max_hw_segments anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jinyoung Choi <j-young.choi@samsung.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Link: https://lore.kernel.org/r/20230724165433.117645-6-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 0ece1d649b6d ("bio-integrity: create multi-page bvecs in bio_integrity_add_page()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 4369c9a355c3c..b9b8328d1bc82 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -949,10 +949,6 @@ static bool __bio_try_merge_page(struct bio *bio, struct page *page,
 
 	if (!page_is_mergeable(bv, page, len, off, same_page))
 		return false;
-	if (bio->bi_iter.bi_size > UINT_MAX - len) {
-		*same_page = false;
-		return false;
-	}
 	bv->bv_len += len;
 	bio->bi_iter.bi_size += len;
 	return true;
@@ -1125,6 +1121,8 @@ int bio_add_page(struct bio *bio, struct page *page,
 
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return 0;
+	if (bio->bi_iter.bi_size > UINT_MAX - len)
+		return 0;
 
 	if (bio->bi_vcnt > 0 &&
 	    __bio_try_merge_page(bio, page, len, offset, &same_page))
@@ -1206,6 +1204,9 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
 {
 	bool same_page = false;
 
+	if (WARN_ON_ONCE(bio->bi_iter.bi_size > UINT_MAX - len))
+		return -EIO;
+
 	if (bio->bi_vcnt > 0 &&
 	    __bio_try_merge_page(bio, page, len, offset, &same_page)) {
 		if (same_page)
-- 
2.40.1



