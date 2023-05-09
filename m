Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428066FC47B
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 13:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbjEILE0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 07:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbjEILEF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 07:04:05 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D784E50
        for <stable@vger.kernel.org>; Tue,  9 May 2023 04:04:03 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230509110359epoutp012a9bf97c794a4f47eb011b6b052a49bf~ddMhDF0u81287812878epoutp01n
        for <stable@vger.kernel.org>; Tue,  9 May 2023 11:03:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230509110359epoutp012a9bf97c794a4f47eb011b6b052a49bf~ddMhDF0u81287812878epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683630239;
        bh=mF1kgDgQq25rjtgjDQJs9HK4VU8N7rnYAZ1bCfhUJBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODxyvx1VY6ipYR7yKvXA5XnBcfd9XmZlQT//vx3mTruKFbtxuXKTXwIS6WDLVpO4t
         fHNJIhiZM3QLPIIhUTgUoiaknGR1EunSvop8FqalLS2Z5tZyr5luXWQymFdO4SByPN
         AQ5V1cBfjVwUtE5759wrcpOWbOrgqPmahkUK3d+4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230509110358epcas1p4b212bc8d558d2b1db55ed0b5197d3d83~ddMgotVn82870428704epcas1p4r;
        Tue,  9 May 2023 11:03:58 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.224]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QFwJZ2l89z4x9Pt; Tue,  9 May
        2023 11:03:58 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.16.48828.E982A546; Tue,  9 May 2023 20:03:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20230509110357epcas1p3ba3beca785e208e745f424d5ded56a13~ddMfaEutE2284122841epcas1p3l;
        Tue,  9 May 2023 11:03:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230509110357epsmtrp2004d15aded8b7b1fb1641e9220d58aca~ddMfXmOGf1374113741epsmtrp2U;
        Tue,  9 May 2023 11:03:57 +0000 (GMT)
X-AuditID: b6c32a35-6ddff7000000bebc-bc-645a289e78e6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.A3.27706.D982A546; Tue,  9 May 2023 20:03:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.41]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230509110357epsmtip2ee38708b52bdf3a396ec9461e705b32b~ddMfLoP6h0915509155epsmtip2f;
        Tue,  9 May 2023 11:03:57 +0000 (GMT)
From:   Yeongjin Gil <youngjin.gil@samsung.com>
To:     stable@vger.kernel.org
Cc:     Yeongjin Gil <youngjin.gil@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 4.19.y] dm verity: fix error handling for check_at_most_once
 on FEC
Date:   Tue,  9 May 2023 20:03:24 +0900
Message-Id: <20230509110324.19464-1-youngjin.gil@samsung.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023050708-verdict-proton-a5f0@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmnu48jagUgzuX+C22/DvCanHilrTF
        go2PGC1m7H/K7sDisWlVJ5tH35ZVjB6fN8kFMEc1MNokFiVnZJalKqTmJeenZOal2yqFhrjp
        WigpZOQXl9gqRRsaGukZGpjrGRkZ6ZkaxVoZmSop5CXmptoqVehC9SopFCUXANXmVhYDDchJ
        1YOK6xWn5qU4ZOWXglyoV5yYW1yal66XnJ+rpFCWmFMKNEJJP+EbY8aqCR+YCo7zVsz4s4it
        gXEjdxcjJ4eEgInErpmT2LoYuTiEBHYwSszd8YEdwvnEKHFn5TMmCOcbo8SGBQeZYFrefJ7A
        DJHYyyhxc3UjE1zLq81zGEGq2AR0Jaa+fMraxcjBISIgJXH/qjWIySxQLjHnsz1IhbBAqMTb
        ///AqlkEVCX2T9jPDGLzCthKPN5wgA1il7zEzS6IOCfQ3ktLZrFB1AhKnJz5hAXEZgaqad46
        G+weCYFD7BKb3s+DanaRmNvzB+poYYlXx7ewQ9hSEp/f7WWDaGhnlFjxEORmEGcGo8Tf9/dZ
        IarsJZpbm9kgrtaUWL9LHyKsKLHz91xGiM18Eu++9kCVC0qcvtbNDFIuIcAr0dEmBBFWk7gy
        6RdUiYxE34NZUDd4SDzqPss0gVFxFpJ/ZiH5ZxbC4gWMzKsYxVILinPTU4sNCwyRI3kTIzhN
        apnuYJz49oPeIUYmDsZDjBIczEoivKsSwlKEeFMSK6tSi/Lji0pzUosPMSYDQ3sis5Rocj4w
        UeeVxBuamVlaWBqZGBqbGRoSFjaxNDAxMzKxMLY0NlMS5/3yVDtFSCA9sSQ1OzW1ILUIZgsT
        B6dUA9MW/e08R479m/noGsdS7b8ps9k2C7A9joj6tZ9J7qzizXm+F+LDZt2YPe3I9klBhxc6
        NfEsnPaFNcbRvGbixukmykcfMVR7H8m8vo2L07B/TvufmJctEt9/yAQvO6dQ1n+eJ3c/24vK
        go7ZX89LXnn9fWbnAf/H0x8rXT/a/oqh84BPtoLuebbp0s75flrhxzxYmZ9nRS9Zf4FP+3TS
        ngdnXNovvdhw8EuqiKdH5XvFc08ExftVwqad/7dGX1BCr/yTwZ3SS/N2ORari8YJntuTP033
        84fStSrmNZ289q9y/uru4VBQ7Hl8NqztuNvMs2d1M9685z+n9yAm4OzjWQtMC9y0FILNG2qi
        ErfdFHdWYinOSDTUYi4qTgQAdxR99koEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvO5cjagUg7tn+C22/DvCanHilrTF
        go2PGC1m7H/K7sDisWlVJ5tH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVwZaya8IGp4DhvxYw/
        i9gaGDdydzFyckgImEi8+TyBuYuRi0NIYDejRNP3K0wQCRmJPxPfs3UxcgDZwhKHDxdD1Hxg
        lFj9/g4LSA2bgK7E1JdPWUFqRASkJO5ftQYJMwtUSry6foEJJCwsECxxvasOJMwioCqxf8J+
        ZhCbV8BW4vGGA2wQm+QlbnZBxDmBzrm0ZBZYXEjAWOLGp3eMEPWCEidnPmGBGC8v0bx1NvME
        RoFZSFKzkKQWMDKtYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDk4tzR2M21d90DvE
        yMTBeIhRgoNZSYR3VUJYihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtS
        i2CyTBycUg1Mc7hcraR0nJ7OZC1Z5bDGhOkzl11M1qmJznMPyS89/EbXaer+l0+OnnMqfm51
        TuJpM7v4i8b7h0583XVpbcz+G/zty8RdNwp6PQz9f4dpD0++qqe82rEDLN8j8kXOh6q+v373
        4VaB6xdr5HJ+ioqFNR9p/aFwtlikOX1VSsHTuf7MX9bVhpmHpF1tqioQ0362tPvK7ABxtiqF
        mg8c1w4uu/EkPf/SKWeNlyu59165mnHlw7F7iSkqG7LyKzltjoRZ71jywtZFsfzr7b5PfI/n
        rtWrPCTJEf+gR3CmmO2/l6+ZnQ7Pe+kVfrVttnKG9rwbHXxcUluPP/TT7870Cfo1/06zk/T7
        pGNTbn5habgyXYmlOCPRUIu5qDgRALIiRW69AgAA
X-CMS-MailID: 20230509110357epcas1p3ba3beca785e208e745f424d5ded56a13
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230509110357epcas1p3ba3beca785e208e745f424d5ded56a13
References: <2023050708-verdict-proton-a5f0@gregkh>
        <CGME20230509110357epcas1p3ba3beca785e208e745f424d5ded56a13@epcas1p3.samsung.com>
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
index 36945030520a..2ff2ad16bb45 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -477,7 +477,7 @@ static int verity_verify_io(struct dm_verity_io *io)
 		sector_t cur_block = io->block + b;
 		struct ahash_request *req = verity_io_hash_req(v, io);
 
-		if (v->validated_blocks &&
+		if (v->validated_blocks && bio->bi_status == BLK_STS_OK &&
 		    likely(test_bit(cur_block, v->validated_blocks))) {
 			verity_bv_skip_block(v, io, &io->iter);
 			continue;
-- 
2.40.1

