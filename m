Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA24079B12A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345020AbjIKVTL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238861AbjIKOGd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:06:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B57120
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:06:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49057C433C8;
        Mon, 11 Sep 2023 14:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441188;
        bh=bSPGdTjNUjuHh6+GSNxHxlj8cawtM4EWLf5cF95Vd2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jEq24VqsOiiiRiAPiGuZYqaZU7fKIfygAb4a8oStc/1SlUj0Kf09WgeW5f7Hqd71F
         D6VZTorBTioJQOnKawrGX36HvWq/bSObZfxXJjbU61nfZaluTa6pEDrRtrBkROST8r
         e3tr1THHmUfPzbF2a9xFe/QzY9TIaDK/s99XW71E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 326/739] block: move the BIO_CLONED checks out of __bio_try_merge_page
Date:   Mon, 11 Sep 2023 15:42:05 +0200
Message-ID: <20230911134700.206190009@linuxfoundation.org>
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

[ Upstream commit 939e1a370330841b2c0292a483d7b38f3ee45f88 ]

__bio_try_merge_page is a way too low-level helper to assert that the
bio is not cloned.  Move the check into bio_add_page and
bio_iov_iter_get_pages instead, which are the high level entry points
that should enforce this variant.  bio_add_hw_page already this
check, coverig the third (indirect) caller of __bio_try_merge_page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jinyoung Choi <j-young.choi@samsung.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Link: https://lore.kernel.org/r/20230724165433.117645-4-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 0ece1d649b6d ("bio-integrity: create multi-page bvecs in bio_integrity_add_page()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 8672179213b93..fa2d5b15fa0fd 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -945,9 +945,6 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 static bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off, bool *same_page)
 {
-	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
-		return false;
-
 	if (bio->bi_vcnt > 0) {
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
@@ -1129,6 +1126,9 @@ int bio_add_page(struct bio *bio, struct page *page,
 {
 	bool same_page = false;
 
+	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
+		return 0;
+
 	if (!__bio_try_merge_page(bio, page, len, offset, &same_page)) {
 		if (bio_full(bio, len))
 			return 0;
@@ -1337,6 +1337,9 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
 	int ret = 0;
 
+	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
+		return -EIO;
+
 	if (iov_iter_is_bvec(iter)) {
 		bio_iov_bvec_set(bio, iter);
 		iov_iter_advance(iter, bio->bi_iter.bi_size);
-- 
2.40.1



