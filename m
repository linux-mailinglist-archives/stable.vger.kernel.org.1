Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8061E71494D
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 14:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjE2MUK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 08:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjE2MUJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 08:20:09 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E2CC7
        for <stable@vger.kernel.org>; Mon, 29 May 2023 05:20:06 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230529122002epoutp025cf3f86d317cbccb029aea5f4833d5c6~jnIoKriFB1307213072epoutp02Y
        for <stable@vger.kernel.org>; Mon, 29 May 2023 12:20:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230529122002epoutp025cf3f86d317cbccb029aea5f4833d5c6~jnIoKriFB1307213072epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685362802;
        bh=ITjfzlPyujW6+iA83Uybvw9X0CE8IuulF+1iLqjVJZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NaMdH1AYLOpaUFaYJw0Wtx3LuX6OeMqccuLD9YuEY+hFs7TjSGUAzQfMNIwz9RVPl
         FpZvOrvwFuCqABVc/o3Z1LmFBFrjN/hI5MIRt4le6od168FgtHUkvh5xQD4h8hB08g
         QoPLjf/RCyyzgf9fKTPyGTssSeASPIWMI8H9tLro=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230529122001epcas5p25f7bec60a3cab1216a095df15bf8ac8c~jnInkIOiv2446824468epcas5p2J;
        Mon, 29 May 2023 12:20:01 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QVF335THZz4x9Pr; Mon, 29 May
        2023 12:19:59 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.4F.04567.F6894746; Mon, 29 May 2023 21:19:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230529121959epcas5p1817b7f018f3b60495a8374d58b5fec01~jnIlgEbX21259712597epcas5p1e;
        Mon, 29 May 2023 12:19:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230529121959epsmtrp14d6f3c7946f8d68d4ca47745d9e995ac~jnIlfiVYk1055510555epsmtrp1e;
        Mon, 29 May 2023 12:19:59 +0000 (GMT)
X-AuditID: b6c32a49-943ff700000011d7-cd-6474986f2a4a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.E4.27706.F6894746; Mon, 29 May 2023 21:19:59 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230529121958epsmtip21a588d234080c62b177d40db1b52469f~jnIkaXqz42311023110epsmtip2X;
        Mon, 29 May 2023 12:19:57 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     stable@vger.kernel.org
Cc:     Anuj Gupta <anuj20.g@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1.y] block: fix bio-cache for passthru IO
Date:   Mon, 29 May 2023 17:46:30 +0530
Message-Id: <20230529121630.302280-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023052844-splatter-emphasize-8de2@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7bCmhm7+jJIUg31N2hZNE/4yW6y+289m
        cfT/WzaLBRsfMTqweFw+W+rRt2UVo8fnTXIBzFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGm
        ZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAy5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqp
        BSk5BSYFesWJucWleel6eaklVoYGBkamQIUJ2RnL5zayFMzjqXgyYytrA+NKri5GTg4JAROJ
        zweXsnYxcnEICexmlFhw/QEbhPOJUaL3ci8LhPONUeLH90fMMC23ds1mA7GFBPYySrSeyoAo
        +swoMWXya6AEBwebgKbEhcmlIKaIgJTE/avWIOXMAlkSLd/fs4DYwgLWEg++vWABKWERUJW4
        8DEBJMwrYClxA+hAiE3yEjMvfWcHsTkFLCQWXelihqgRlDg58wkLxEh5ieats5lBLpAQOMQu
        ceHsfSaIZheJHTPeskPYwhKvjm+BsqUkXva3QdnJEpdmnoOqL5F4vOcglG0P9FU/M8htzECf
        rN+lD7GLT6L39xMmkLCEAK9ER5sQRLWixL1JT6FOFpd4OGMJlO0hMfPqZVZIQHUzSuzZVT+B
        UX4Wkg9mIflgFsKyBYzMqxglUwuKc9NTi00LDPNSy+GRmpyfu4kRnN60PHcw3n3wQe8QIxMH
        4yFGCQ5mJRFe28TiFCHelMTKqtSi/Pii0pzU4kOMpsAQnsgsJZqcD0yweSXxhiaWBiZmZmYm
        lsZmhkrivOq2J5OFBNITS1KzU1MLUotg+pg4OKUamMLum6wJTzC/qisgZpC6otLWXP/MubIM
        E5sT+//q3zn1Q/h5yCz7hdfOhl49ycRXNIfNYNeSU8Eu4gIrhL+1te71N+18FqY/aeuiuZOc
        OpP9v7l/TH2YPbvd4OC114vqgqpOrZq4ekLzraWvM9gt97bnpR/UeP06vPPicc3ZHTPlpzPU
        /d306uiGn3xehyO1crPb3/24uePClcPtcxzCMi/v6ikTeWK0Nad5vuc3bqknYuyPtxapy7A+
        qf5+6vJWm3TnE8ff6nBaC5o+yG4RjLmucq5cy0rgwBHLc77Sm8rXbqn+dEMkq680wP1NH7fC
        oipv3aUnDy13iev4tY5L7l1dcHtwrET5Q7EkFpcCDSWW4oxEQy3mouJEAMFrN/j4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvG7+jJIUg7bT/BZNE/4yW6y+289m
        cfT/WzaLBRsfMTqweFw+W+rRt2UVo8fnTXIBzFFcNimpOZllqUX6dglcGcvnNrIUzOOpeDJj
        K2sD40quLkZODgkBE4lbu2azdTFycQgJ7GaUuHXsCTNEQlyi+doPdghbWGLlv+fsEEUfGSUu
        9x9j6WLk4GAT0JS4MLkUxBQRkJK4f9UapJxZIEdi2rsZTCC2sIC1xINvL8CqWQRUJS58TAAJ
        8wpYStwAOgNiurzEzEvfwTZxClhILLrSBXaBkIC5xIydJ1kh6gUlTs58wgIxXl6ieets5gmM
        ArOQpGYhSS1gZFrFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcnFqaOxi3r/qgd4iR
        iYPxEKMEB7OSCK9tYnGKEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KL
        YLJMHJxSDUwTvnrc/tnpIn/zyOtvFsX9NvmSRcVXPbmT9pe4Gopb3bS3/DrvhdwBSbE6Fq3i
        tfdtKqesVfqs/qXeNqnmWP7DgsO3l6/zerri+KlpFsH3F+wtnJ3g9O6e540NXO1za1N6js8U
        229Q6jCTcbvZmZNqpdqC+/mfd+89UTefYYb4BR776oWXL13qydx7VLjvcWfZ14btX5fO7+lq
        rr6hnXk/PIN766M65TdLby7QKT/5MWXz9bCn1SZXV9lP09/EeSqMTdWjvXTSZZNLW7Scz90s
        UnGVbrf917bH6HCEvvA0+72Hb8bGC/WZVt++9yrFzFvWy9BP+eKN6YyzNJe4P3CY+if9UXFe
        T3bwL//N+WZKLMUZiYZazEXFiQCBEIGSvQIAAA==
X-CMS-MailID: 20230529121959epcas5p1817b7f018f3b60495a8374d58b5fec01
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230529121959epcas5p1817b7f018f3b60495a8374d58b5fec01
References: <2023052844-splatter-emphasize-8de2@gregkh>
        <CGME20230529121959epcas5p1817b7f018f3b60495a8374d58b5fec01@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Anuj Gupta <anuj20.g@samsung.com>

commit <8af870aa5b847> ("block: enable bio caching use for passthru IO")
introduced bio-cache for passthru IO. In case when nr_vecs are greater
than BIO_INLINE_VECS, bio and bvecs are allocated from mempool (instead
of percpu cache) and REQ_ALLOC_CACHE is cleared. This causes the side
effect of not freeing bio/bvecs into mempool on completion.

This patch lets the passthru IO fallback to allocation using bio_kmalloc
when nr_vecs are greater than BIO_INLINE_VECS. The corresponding bio
is freed during call to blk_mq_map_bio_put during completion.

Cc: stable@vger.kernel.org # 6.1
fixes <8af870aa5b847> ("block: enable bio caching use for passthru IO")

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Link: https://lore.kernel.org/r/20230523111709.145676-1-anuj20.g@samsung.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
(cherry picked from commit 46930b7cc7727271c9c27aac1fdc97a8645e2d00)
---
 block/blk-map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 34735626b00f..66da9e2b19ab 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -246,7 +246,7 @@ static struct bio *blk_rq_map_bio_alloc(struct request *rq,
 {
 	struct bio *bio;
 
-	if (rq->cmd_flags & REQ_POLLED) {
+	if (rq->cmd_flags & REQ_POLLED && (nr_vecs <= BIO_INLINE_VECS)) {
 		blk_opf_t opf = rq->cmd_flags | REQ_ALLOC_CACHE;
 
 		bio = bio_alloc_bioset(NULL, nr_vecs, opf, gfp_mask,
-- 
2.25.1

