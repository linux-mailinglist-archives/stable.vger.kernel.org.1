Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282E46FC614
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 14:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbjEIMSM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 08:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjEIMSL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 08:18:11 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B878A422F
        for <stable@vger.kernel.org>; Tue,  9 May 2023 05:18:08 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230509121806epoutp0228cd76024a5fc5b657276fc52b6aa9b8~deNPUFWji2580725807epoutp02h
        for <stable@vger.kernel.org>; Tue,  9 May 2023 12:18:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230509121806epoutp0228cd76024a5fc5b657276fc52b6aa9b8~deNPUFWji2580725807epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683634686;
        bh=yhZsdjveKOfuL6IQy0ODjJAo/gqFY6Md73F8m6fPcnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T5wYsah2aUkVN0PeTD30oEMWYSgWwHu6xu7f7MEP+pXTuoNGDZcdNhjbrj980oFA9
         ycGwiR3zjS1M97PwovNGFylKqc6iewVskZ+9HugYCMQfzVgHPcr36yoYY2B1nazCv7
         8KZaJiswZjDoF96IYPyGR/EwqpvESArNiJ4Mo8ek=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230509121806epcas1p43ac16219dab3f0987ea3547c6c3cc1af~deNO3ob7g2544225442epcas1p4E;
        Tue,  9 May 2023 12:18:06 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.226]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QFxy60kxTz4x9Ps; Tue,  9 May
        2023 12:18:06 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.02.44594.DF93A546; Tue,  9 May 2023 21:18:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20230509121805epcas1p3d1fbcb2f4b21163fb4df94252007f36a~deNN87FVZ0033800338epcas1p3x;
        Tue,  9 May 2023 12:18:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230509121805epsmtrp198e65e07e401cbcecb148e0dbe10b70a~deNN3kJkx2395223952epsmtrp1L;
        Tue,  9 May 2023 12:18:05 +0000 (GMT)
X-AuditID: b6c32a37-a4dfd7000000ae32-47-645a39fd606d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.98.27706.DF93A546; Tue,  9 May 2023 21:18:05 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.41]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230509121805epsmtip1ad24c6492241cd887bf43665f00a84d6~deNNvXONd0929909299epsmtip1M;
        Tue,  9 May 2023 12:18:05 +0000 (GMT)
From:   Yeongjin Gil <youngjin.gil@samsung.com>
To:     stable@vger.kernel.org
Cc:     Yeongjin Gil <youngjin.gil@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 5.4.y] dm verity: fix error handling for check_at_most_once
 on FEC
Date:   Tue,  9 May 2023 21:18:03 +0900
Message-Id: <20230509121803.13609-1-youngjin.gil@samsung.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023050709-dry-stand-f81b@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmvu4/y6gUgxczmSy2/DvCanHilrTF
        go2PGC1m7H/K7sDisWlVJ5tH35ZVjB6fN8kFMEc1MNokFiVnZJalKqTmJeenZOal2yqFhrjp
        WigpZOQXl9gqRRsaGukZGpjrGRkZ6ZkaxVoZmSop5CXmptoqVehC9SopFCUXANXmVhYDDchJ
        1YOK6xWn5qU4ZOWXglyoV5yYW1yal66XnJ+rpFCWmFMKNEJJP+EbY8b9b3/YCybzV6x9XNHA
        eJ6ni5GDQ0LARKJhQmgXIxeHkMAORomew6cYIZxPjBJrmt8wQTjfGCXufHvH0sXICdaxuPUE
        C0RiL6PEtrvdzHAt61Z8YQSpYhPQlZj68ikryA4RASmJ+1etQUxmgXKJOZ/tQUxhgRCJwwdy
        QYpZBFQlXt7dygZi8wrYSpze18AOsUpe4mbXfmYQm1NAX2Ll7+PMEDWCEidnPgE7hxmopnnr
        bLALJASOsUvcvn4UqtlFYv25WWwQtrDEq+NboOJSEi/729ghGtoZJVY8nMMI4cxglPj7/j4r
        RJW9RHNrMxvE0ZoS63fpQ4QVJXb+nssIsZlP4t3XHqhyQYnT10DhAApSXomONiGIsJrElUm/
        oEpkJPoezIK6wUPi37kHjBMYFWch+WcWkn9mISxewMi8ilEstaA4Nz212LDAGDmGNzGCE6SW
        +Q7GaW8/6B1iZOJgPMQowcGsJMK7KiEsRYg3JbGyKrUoP76oNCe1+BBjMjC0JzJLiSbnA1N0
        Xkm8oZmZpYWlkYmhsZmhIWFhE0sDEzMjEwtjS2MzJXHeL0+1U4QE0hNLUrNTUwtSi2C2MHFw
        SjUwlT5wDpjgXJKasoYp679myua/P2uVfyXI/2ifybqz27VLPdin8/e+hRuengrq5p3YJ/5b
        39d/u2R7QP2V3UwCFbNjH29lDdjvqXYuWahOZI2n430TGz+jnxUHGMTZFtyM0v48Tcfe9/rq
        su030s+lvRHtnHBviYiBrZBoVBDLg09OK8O5Njeffbnz8cUTK/r1XzVaR4q1HI/5efzhy0bl
        B87X1besqzGaYC35vr5yw4EP+1bMZFrMxrDEhP89l1eexYVLpa/zmKe7vXp8Yt5y14B/ci+S
        n2Wz6eR8q5Zq/bX4mMrqCQdmn3URLor3kosNUGpJSg9kNhHQ5J7CH2SeVDdX+IZ+x9btjlkc
        DQFKLMUZiYZazEXFiQCloIovRwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSnO5fy6gUg42HBS22/DvCanHilrTF
        go2PGC1m7H/K7sDisWlVJ5tH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVwZdz/9oe9YDJ/xdrH
        FQ2M53m6GDk5JARMJBa3nmDpYuTiEBLYzShxaPVjFoiEjMSfie/Zuhg5gGxhicOHiyFqPjBK
        7L16iRGkhk1AV2Lqy6esIDUiAlIS969ag4SZBSolXl2/wAQSFhYIkjj8IRAkzCKgKvHy7lY2
        EJtXwFbi9L4GdohN8hI3u/Yzg9icAvoSK38fB7OFBPQkvj/bxgxRLyhxcuYTFojx8hLNW2cz
        T2AUmIUkNQtJagEj0ypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjODQ1NLcwbh91Qe9
        Q4xMHIyHGCU4mJVEeFclhKUI8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1
        ILUIJsvEwSnVwKRR4SV/WEWG0fhIqOl5q7k7um9FV297tfV4s7XS5FUXe+N3S2n/ZUudM1Mu
        ReDWt6NO62567I4wqdebq305XJDDdlHazA9P7T+e/3ftnaxrh2g5T4zXh/WN61prIp0fpcxI
        4VFefUpp9yPTBNbHbU9nvJevfr95ye93Cg+UD6Yoz+aML1lUVr3tVOXju9rvm+467jgcWv97
        Xe6GtoOPX/kVSd3TcnUUXimXknmF89dny5hE85uWycu2vCkPXVWYednplHSMSd5JTxkr0zqe
        17u3W26wOZ1WdTO59sbe0q2J76/ctX+woftj3rkdBzXXHW6e+lv/S+zORPmL4lO31+ltq9eZ
        qvLbkKG/8+2bsCglluKMREMt5qLiRABZPSljvAIAAA==
X-CMS-MailID: 20230509121805epcas1p3d1fbcb2f4b21163fb4df94252007f36a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230509121805epcas1p3d1fbcb2f4b21163fb4df94252007f36a
References: <2023050709-dry-stand-f81b@gregkh>
        <CGME20230509121805epcas1p3d1fbcb2f4b21163fb4df94252007f36a@epcas1p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/md/dm-verity-target.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 9dcdf34b7e32..5a4c813ba240 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -471,13 +471,14 @@ static int verity_verify_io(struct dm_verity_io *io)
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

