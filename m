Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D141070210D
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 03:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbjEOBSe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 14 May 2023 21:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjEOBSd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 14 May 2023 21:18:33 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDAA10FF
        for <stable@vger.kernel.org>; Sun, 14 May 2023 18:18:28 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230515011824epoutp022fcfb6f45659b2ee73a85d99b69e51dd~fLE8j0WOb0377003770epoutp02S
        for <stable@vger.kernel.org>; Mon, 15 May 2023 01:18:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230515011824epoutp022fcfb6f45659b2ee73a85d99b69e51dd~fLE8j0WOb0377003770epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684113504;
        bh=DeV/BfaTUBjaGOVIdGhJ2+8zQxv3Hkj/cowmWaTWwVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZepWR+w7BzpM/yVq/oLtTh+JW4VOkSvo6zLYb54LKPyZ/GId0ufr8n9oeZ7ob3dx
         7ghGPXwNRs9kOhySrc67KklILmz3HkuMiICAJgi7oDbUIFV3xW4f4D2DC93+WV5ax6
         ZRimHpOySUD8UVTYw2pf1Pl/F/HdFTWTXJPmjlFg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230515011823epcas1p12b5d80154a5d7c69e2bb8a4c555449cb~fLE8PD4D21406514065epcas1p1-;
        Mon, 15 May 2023 01:18:23 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.249]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QKM272Rvwz4x9Q8; Mon, 15 May
        2023 01:18:23 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.58.48828.F5881646; Mon, 15 May 2023 10:18:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230515011823epcas1p2e05135dda9e7e159d637016d81d55abc~fLE7jzx-O1016510165epcas1p28;
        Mon, 15 May 2023 01:18:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230515011822epsmtrp17353547e23573ba14a84046133d59466~fLE7jGXhe2036920369epsmtrp1R;
        Mon, 15 May 2023 01:18:22 +0000 (GMT)
X-AuditID: b6c32a35-eee92a800000bebc-e6-6461885f4177
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.9A.27706.E5881646; Mon, 15 May 2023 10:18:22 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.41]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230515011822epsmtip123ee6cabdce956e10fcb59fc7119f760~fLE7ZK36U2071320713epsmtip1C;
        Mon, 15 May 2023 01:18:22 +0000 (GMT)
From:   Yeongjin Gil <youngjin.gil@samsung.com>
To:     stable@vger.kernel.org
Cc:     Yeongjin Gil <youngjin.gil@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2] dm verity: fix error handling for check_at_most_once on
 FEC
Date:   Mon, 15 May 2023 10:18:16 +0900
Message-Id: <20230515011816.25372-1-youngjin.gil@samsung.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023050701-epileptic-unethical-f46c@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmgW58R2KKweFVghZb/h1htThxS9pi
        wcZHjBYz9j9ld2Dx2LSqk82jb8sqRo/Pm+QCmKMaGG0Si5IzMstSFVLzkvNTMvPSbZVCQ9x0
        LZQUMvKLS2yVog0NjfQMDcz1jIyM9EyNYq2MTJUU8hJzU22VKnShepUUipILgGpzK4uBBuSk
        6kHF9YpT81IcsvJLQS7UK07MLS7NS9dLzs9VUihLzCkFGqGkn/CNMWNW0zamgmP8FSfezGRv
        YPzB08XIySEhYCJx5NRaFhBbSGAHo8TjFTJdjFxA9idGiaX3zjNBON8YJSauf8sK0/Hl5C1m
        iMReRonFG9YzwrV86uoHq2IT0JWY+vIpkM3BISIgJXH/qjWIySxQLjHnsz1IhbBAoMSNfTPB
        NrMIqEqs3dLBDmLzCthKdPU2M0Hskpe42bWfGcTmFLCUWHD4BjNEjaDEyZlPwHqZgWqat84G
        u0dC4BC7xM8LM6CaXSR2X+1lh7CFJV4d3wJlS0m87G9jh2hoZ5RY8XAOI4Qzg1Hi7/v7UG/a
        SzS3NrNBXK0psX6XPkRYUWLn77mMEJv5JN597YEqF5Q4fa2bGaRcQoBXoqNNCCKsJnFl0i+o
        EhmJvgezoG7wkHh6bT/7BEbFWUj+mYXkn1kIixcwMq9iFEstKM5NTy02LDBEjuNNjOAkqWW6
        g3Hi2w96hxiZOBgPMUpwMCuJ8LbPjE8R4k1JrKxKLcqPLyrNSS0+xJgMDO2JzFKiyfnANJ1X
        Em9oZmZpYWlkYmhsZmhIWNjE0sDEzMjEwtjS2ExJnPfLU+0UIYH0xJLU7NTUgtQimC1MHJxS
        DUwNR8XkL15fL2a+5+J/tas+N46cDHi129n4ZouJ3o2jHsEczKWLD7sd7NH/sTvw5tGohKOH
        6+NmHr0zwS3lTy7zua2ZLpc9HpQf1FnLyvezooVnw9cL+8KKmaYHPZqYfJrzx/pj2kvzz3RH
        fP8pmpaVP29mso9S5/sfGgU6tY/uL+LxSAnU2fa09FZckZmq152D/1S9D2haJc5M2vH2ULdV
        Gbv8pV0ZYc+ivVvnXV2+YJ9/3K0O/puyL88qua/7mdPFZBW136Zuubu9+IrmFxmPwqfwn5cQ
        /JP8+VvXgW9dVdUV/q+0JcVKOLfv74hnzJbc0ho9fa+b9rYa/XmVEl+5T2m3xU59Kvm74lan
        +HElluKMREMt5qLiRAByQE4wSQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSnG5cR2KKwb0PZhZb/h1htThxS9pi
        wcZHjBYz9j9ld2Dx2LSqk82jb8sqRo/Pm+QCmKO4bFJSczLLUov07RK4MmY1bWMqOMZfceLN
        TPYGxh88XYycHBICJhJfTt5i7mLk4hAS2M0osfLzPCaIhIzEn4nv2boYOYBsYYnDh4shaj4w
        Ssyf9YAVpIZNQFdi6sunrCA1IgJSEvevWoOEmQUqJV5dvwA2RljAX+LGrV/MIDaLgKrE2i0d
        7CA2r4CtRFdvM9QqeYmbXfvBajgFLCUWHL4BZgsJWEg8mTaDEaJeUOLkzCcsEPPlJZq3zmae
        wCgwC0lqFpLUAkamVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYweGppbmDcfuqD3qH
        GJk4GA8xSnAwK4nwts+MTxHiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampB
        ahFMlomDU6qBaavpHibbdvYrgSIOz66alpyf2nt6vZ7J2Vy7ZapLlTqiXGsvLv2Zz+xtOJH3
        nnKU8aQXyfN3mniz23MJ22xMKpvZUmaWFfKvZZnlj7n+e05XlR8736jZ8O3ggTtcy1Oz+hK/
        auzW8elpU/7x12v7Sb2lP4t2dvEvq6ifx9Zc/GK1AsMxfYHQ7sTn9q2sqiuev30hw3LCav89
        lvtmi23Zr014KVIU51dduDzshOeqs8XJfq5vV8yevtX4gdFlN3mnVa0PHe6ryJsrs7wK1/e4
        5nu+4JKYhF5igtUZk/69j7g+dfVOjewxFzk194JiyO9Xy2IePe5OO3pm+rG64PzpbBpVVvFH
        /xy8uvPnBb4QJZbijERDLeai4kQAbIz1+r4CAAA=
X-CMS-MailID: 20230515011823epcas1p2e05135dda9e7e159d637016d81d55abc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230515011823epcas1p2e05135dda9e7e159d637016d81d55abc
References: <2023050701-epileptic-unethical-f46c@gregkh>
        <CGME20230515011823epcas1p2e05135dda9e7e159d637016d81d55abc@epcas1p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
v2:
-Add bio definition in verity_verify_io
---
 drivers/md/dm-verity-target.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index c801f6b93b7b..450377655791 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -475,13 +475,14 @@ static int verity_verify_io(struct dm_verity_io *io)
 	struct bvec_iter start;
 	unsigned b;
 	struct crypto_wait wait;
+	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
 
 	for (b = 0; b < io->n_blocks; b++) {
 		int r;
 		sector_t cur_block = io->block + b;
 		struct ahash_request *req = verity_io_hash_req(v, io);
 
-		if (v->validated_blocks &&
+		if (v->validated_blocks && bio->bi_status == BLK_STS_OK &&
 		    likely(test_bit(cur_block, v->validated_blocks))) {
 			verity_bv_skip_block(v, io, &io->iter);
 			continue;
-- 
2.40.1

