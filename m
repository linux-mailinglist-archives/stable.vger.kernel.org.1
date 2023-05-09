Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079EC6FC48C
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 13:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjEILG6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 07:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbjEILGx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 07:06:53 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CCD2D7D
        for <stable@vger.kernel.org>; Tue,  9 May 2023 04:06:49 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230509110648epoutp01d043def706bc2d37a464fde1492ddb80~ddO_c68nD1348113481epoutp01a
        for <stable@vger.kernel.org>; Tue,  9 May 2023 11:06:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230509110648epoutp01d043def706bc2d37a464fde1492ddb80~ddO_c68nD1348113481epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683630408;
        bh=agylVYPRlfQcb7aPK/5x21TlnqrRfMW2oCD7bVN+diQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQuE/GiPPOPpU7iKnwCnWxJYbDZFC+uSH/hWM8YEwgOmPsfSBX83lWtcpHqxwAlae
         ZvkmXoMwDX0IO9HbZ8Qmfa/WZC1D7S3joKKDfdU66Is6/o29AGNqjsnFrOvYLE6d2m
         LmEoWfnoO3COoeeO9wfLTzYUDReazi9cjxUaq5ms=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230509110647epcas1p17679604c40fa13093d41b0da64787536~ddO93Mnbr0910709107epcas1p1J;
        Tue,  9 May 2023 11:06:47 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.222]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QFwMq1QJ0z4x9Pw; Tue,  9 May
        2023 11:06:47 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.94.39132.7492A546; Tue,  9 May 2023 20:06:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20230509110646epcas1p3026b0edd96ed52fc29d40f8d389915d3~ddO8b9x6r0110701107epcas1p3a;
        Tue,  9 May 2023 11:06:46 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230509110646epsmtrp1917c2a083d5dda67e586093588859625~ddO8bUEWg1460014600epsmtrp1m;
        Tue,  9 May 2023 11:06:46 +0000 (GMT)
X-AuditID: b6c32a39-bc3ff700000098dc-19-645a29471dc1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.55.28392.5492A546; Tue,  9 May 2023 20:06:45 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.41]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230509110645epsmtip1265fc5da7b125698345b1d28c280fffa~ddO8R2W8m2540425404epsmtip1j;
        Tue,  9 May 2023 11:06:45 +0000 (GMT)
From:   Yeongjin Gil <youngjin.gil@samsung.com>
To:     stable@vger.kernel.org
Cc:     Yeongjin Gil <youngjin.gil@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 5.10.y] dm verity: fix error handling for check_at_most_once
 on FEC
Date:   Tue,  9 May 2023 20:06:44 +0900
Message-Id: <20230509110644.19746-1-youngjin.gil@samsung.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023050701-epileptic-unethical-f46c@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmga67ZlSKwYc3LBZb/h1htThxS9pi
        wcZHjBYz9j9ld2Dx2LSqk82jb8sqRo/Pm+QCmKMaGG0Si5IzMstSFVLzkvNTMvPSbZVCQ9x0
        LZQUMvKLS2yVog0NjfQMDcz1jIyM9EyNYq2MTJUU8hJzU22VKnShepUUipILgGpzK4uBBuSk
        6kHF9YpT81IcsvJLQS7UK07MLS7NS9dLzs9VUihLzCkFGqGkn/CNMWPJKp2C47wVz1eKNDBu
        5O5i5OSQEDCR2D73PnsXIxeHkMAORonFu3tZIZxPjBJdr15BOZ8ZJbZvvMkI03Jo+SkWiMQu
        Rol1Hb1McC1nprxgA6liE9CVmPryKVA7B4eIgJTE/avWICazQLnEnM/2IKawQKjEvV4JEJNF
        QFXi6M4MkD5eAVuJKXPfsUJskpe42bWfGcTmFLCUWHD4BjNEjaDEyZlPWEBsZqCa5q2zmUEO
        kBA4xC6x+ewzqGYXifmzGpghbGGJV8e3sEPYUhIv+9vYIRraGSVWPJzDCOHMYJT4+/4+VLe9
        RHNrMxvEzZoS63fpQ4QVJXb+nssIsZlP4t3XHqhyQYnT17qZQcolBHglOtqEIMJqElcm/YIq
        kZHoezAL6gYPie8Xv7BPYFScheSfWUj+mYWweAEj8ypGsdSC4tz01GLDAlPkCN7ECE6PWpY7
        GKe//aB3iJGJg/EQowQHs5II76qEsBQh3pTEyqrUovz4otKc1OJDjMnAwJ7ILCWanA9M0Hkl
        8YZmZpYWlkYmhsZmhoaEhU0sDUzMjEwsjC2NzZTEeb881U4REkhPLEnNTk0tSC2C2cLEwSnV
        wGT2K3o665XwKZWSe3tP5nreNM6bu1Jm3vZ3d8Q3u8o82zwj89O254fOHZ78bnHzo4XL66ZG
        Gu+6MCvc6VtfVkln5wqNI8JWZSnrLG/mHXlrLXloQuZNPa5iSZ3oG156OxITFqjkXHs+/0u/
        402ZVZM1Av0ebpl22/jJxDt1a7Qj467PrZiyLO7X9YuTNO78W17Cq3h858RXbE/t3/VPfBtv
        MXH+xinOp04W/HDVasuurb/mnj53/im/Dw7/vOLsjhQ0mvXe5ZnwpD7Np53V9MOuC2zrl4QH
        n5+x60/NkgTWO5Os3AScRO3nWC4KWODDc6dcbA7/up319c9/OP/nbGXwELCXEQ4/1W6UlHfk
        zCsbJZbijERDLeai4kQAdBVHXEYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSnK6rZlSKwZEHFhZb/h1htThxS9pi
        wcZHjBYz9j9ld2Dx2LSqk82jb8sqRo/Pm+QCmKO4bFJSczLLUov07RK4Mpas0ik4zlvxfKVI
        A+NG7i5GTg4JAROJQ8tPsXQxcnEICexglFizppkNIiEj8WfieyCbA8gWljh8uBii5gOjxKlP
        fYwgNWwCuhJTXz5lBakREZCSuH/VGiTMLFAp8er6BSYQW1ggWGLGojfsICUsAqoSR3dmgIR5
        BWwlpsx9xwqxSV7iZtd+ZhCbU8BSYsHhG2C2kICFxJNpMxgh6gUlTs58wgIxXl6ieets5gmM
        ArOQpGYhSS1gZFrFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcmFpaOxj3rPqgd4iR
        iYPxEKMEB7OSCO+qhLAUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQW
        wWSZODilGpi4zM7dX7fiorLeRPUlpb5MQm/miuqy3Xr0PtCl+NgB9euHXhoIVRy81XvCzqg4
        WEbuCEftwiy1j2ea2Lap6h+3yPuybaJ1f0F/telJZf+dh9KmbzuppKSmUvWOP2f15B8zmWur
        Ei03nZ0q84q3c+tSxT/Z33juPX1oWLV8hcTx8xoHj+YESxrpsOY5K1a/Eb1a08e2N0RHzvu1
        dqjf1tWK8evLA3pVdk2bzcD75utpQbOrV0WXreoye51rFLih99fP0K9pJazqZwNcrk+sWxl5
        ss3LaPdJy4DFH1MuZ929ejAljdf/zoKnex6sDTW5+7/4H2eRVNH6/X+mdeRmnHn0zkK8e0WF
        5z87D7a+3/uUWIozEg21mIuKEwEkfVc9uwIAAA==
X-CMS-MailID: 20230509110646epcas1p3026b0edd96ed52fc29d40f8d389915d3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230509110646epcas1p3026b0edd96ed52fc29d40f8d389915d3
References: <2023050701-epileptic-unethical-f46c@gregkh>
        <CGME20230509110646epcas1p3026b0edd96ed52fc29d40f8d389915d3@epcas1p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

In verity_end_io(), if bi_status is not BLK_STS_OK, it can be return
directly. But if FEC configured, it is desired to correct the data page
through verity_verify_io. And the return value will be converted to
blk_status and passed to verity_finish_io().

BTW, when a bit is set in v->validated_blocks, verity_verify_io() skips
verification regardless of I/O error for the corresponding bio. In this
case, the I/O error could not be returned properly, and as a result,
there is a problem that abnormal data could be read for the
corresponding block.

To fix this problem, when an I/O error occurs, do not skip verification
even if the bit related is set in v->validated_blocks.

Fixes: 843f38d382b1 ("dm verity: add 'check_at_most_once' option to only validate hashes once")
Cc: stable@vger.kernel.org
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
(cherry picked from commit e8c5d45f82ce0c238a4817739892fe8897a3dcc3)
---
 drivers/md/dm-verity-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index c801f6b93b7b..72168ea5fe52 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -481,7 +481,7 @@ static int verity_verify_io(struct dm_verity_io *io)
 		sector_t cur_block = io->block + b;
 		struct ahash_request *req = verity_io_hash_req(v, io);
 
-		if (v->validated_blocks &&
+		if (v->validated_blocks && bio->bi_status == BLK_STS_OK &&
 		    likely(test_bit(cur_block, v->validated_blocks))) {
 			verity_bv_skip_block(v, io, &io->iter);
 			continue;
-- 
2.40.1

