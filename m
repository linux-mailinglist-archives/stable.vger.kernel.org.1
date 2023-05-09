Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7926FC483
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 13:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbjEILFQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 07:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbjEILFO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 07:05:14 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58F0E46
        for <stable@vger.kernel.org>; Tue,  9 May 2023 04:05:13 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230509110511epoutp04ecaceb70dcf538355ec813099a2f6f8c~ddNk0N-Wd2546125461epoutp04-
        for <stable@vger.kernel.org>; Tue,  9 May 2023 11:05:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230509110511epoutp04ecaceb70dcf538355ec813099a2f6f8c~ddNk0N-Wd2546125461epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683630311;
        bh=jx1vMBovPdDBOY1Y7fo/xIP/3VRboFey7l6MHlb3OHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IiOHkqokvN3xyss122+UltKUHPI6YckYSO8FGg/SbGOkgyD3uhDpp9Y/An8IlRI7V
         JjtKJzu3azxZiti9o+shS1HABTcqPwau0Va5azjJli+4qXy0Xr0U0m6pwrUCOX7qWx
         pqTb4ulLMr7szCyJpH9rEpG/EIECoY3/7/Nbhxnk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230509110511epcas1p367a0cb4628135cd5c9c1fa093021f871~ddNkh-Kpd2436724367epcas1p38;
        Tue,  9 May 2023 11:05:11 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.223]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QFwKz21nMz4x9Pw; Tue,  9 May
        2023 11:05:11 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.46.48828.7E82A546; Tue,  9 May 2023 20:05:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230509110510epcas1p2f1aada47a081ae8158a62867de464cf9~ddNj6YSEW0818208182epcas1p2L;
        Tue,  9 May 2023 11:05:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230509110510epsmtrp2e73b348b100112f80c93f6e5660506d5~ddNj5ttos1460314603epsmtrp23;
        Tue,  9 May 2023 11:05:10 +0000 (GMT)
X-AuditID: b6c32a35-6ddff7000000bebc-97-645a28e778c2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.C3.27706.6E82A546; Tue,  9 May 2023 20:05:10 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.41]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230509110510epsmtip1c60248f1f3dc823afafbfa7a6ae6a9f6~ddNjwoQiO3142231422epsmtip1G;
        Tue,  9 May 2023 11:05:10 +0000 (GMT)
From:   Yeongjin Gil <youngjin.gil@samsung.com>
To:     stable@vger.kernel.org
Cc:     Yeongjin Gil <youngjin.gil@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 5.4.y] dm verity: fix error handling for check_at_most_once
 on FEC
Date:   Tue,  9 May 2023 20:05:08 +0900
Message-Id: <20230509110508.19628-1-youngjin.gil@samsung.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023050709-dry-stand-f81b@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmnu5zjagUg18L+Cy2/DvCanHilrTF
        go2PGC1m7H/K7sDisWlVJ5tH35ZVjB6fN8kFMEc1MNokFiVnZJalKqTmJeenZOal2yqFhrjp
        WigpZOQXl9gqRRsaGukZGpjrGRkZ6ZkaxVoZmSop5CXmptoqVehC9SopFCUXANXmVhYDDchJ
        1YOK6xWn5qU4ZOWXglyoV5yYW1yal66XnJ+rpFCWmFMKNEJJP+EbY8bK1jdMBcd5Kz787mZs
        YNzI3cXIySEhYCJxZdkcpi5GLg4hgR2MEnO7rzFCOJ8YJRYv6mODcL4xSrTdv8gE09Lx5SQ7
        RGIvo8S5hx1scC17/zxgBqliE9CVmPryKWsXIweHiICUxP2r1iAms0C5xJzP9iCmsECIxOED
        uSDFLAKqEuu332YBsXkFbCUWTN3CArFKXuJm136wgZwC+hIrfx9nhqgRlDg58wlYDTNQTfPW
        2cwgF0gIHGOXmNe+jBmi2UXi7uo3rBC2sMSr41vYIWwpic/v9rJBNLQzSqx4OIcRwpnBKPH3
        /X2oDnuJ5tZmNoijNSXW79KHCCtK7Pw9lxFiM5/Eu689UOWCEqevdTODlEsI8Ep0tAlBhNUk
        rkz6BVUiI9H3YBbUDR4SEw9vZJ3AqDgLyT+zkPwzC2HxAkbmVYxiqQXFuempxYYFhshxvIkR
        nCS1THcwTnz7Qe8QIxMH4yFGCQ5mJRHeVQlhKUK8KYmVValF+fFFpTmpxYcYk4GhPZFZSjQ5
        H5im80riDc3MLC0sjUwMjc0MDQkLm1gamJgZmVgYWxqbKYnzfnmqnSIkkJ5YkpqdmlqQWgSz
        hYmDU6qBaY72z116eYV54W3/9ioxP5Dt23BYe9fkjb0B10x/KmzNuSxxco3h9Fu8TIfU7ipP
        1tGou/Vjdr5rUw5z8l6/qhmX5/99kDx7+gqX9niGVu3bRreurxZYLt1Q4+bxaLbgLOH+7f/P
        r8n1Ved/sS35uWvdl9X9guHyz4O7gw5XKe8WYd+xoPybl7XwVsWrV0T/vfjv4qn2Q2nXba7t
        v5h3WiYpOXNac1br727LyQmVam3KjsnJDIn//fMk1zHTzvzncQGbPi5/PGlx2f7Ic2z6E61a
        Yy2ZLrEqLNif+kyHMfD7XCOuinenJyXJ7coPt/BPKj4S5Zqpdchu2qq17WW+f1Yl+RxXfnX9
        WSvrrt/zlViKMxINtZiLihMBNYdwOEkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSnO4zjagUg643phZb/h1htThxS9pi
        wcZHjBYz9j9ld2Dx2LSqk82jb8sqRo/Pm+QCmKO4bFJSczLLUov07RK4Mla2vmEqOM5b8eF3
        N2MD40buLkZODgkBE4mOLyfZQWwhgd2MEtv3qEDEZST+THzP1sXIAWQLSxw+XNzFyAVU8oFR
        4uWp06wgNWwCuhJTXz5lBakREZCSuH/VGiTMLFAp8er6BSaQsLBAkMThD4EgYRYBVYn122+z
        gNi8ArYSC6ZuYYHYJC9xs2s/M4jNKaAvsfL3cWaIa/Qkvj/bxgxRLyhxcuYTFojx8hLNW2cz
        T2AUmIUkNQtJagEj0ypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjODQ1NLcwbh91Qe9
        Q4xMHIyHGCU4mJVEeFclhKUI8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1
        ILUIJsvEwSnVwJT9VeOtzFFz1aLQigffwmO+Sh9eKln6T1bMa9c2+YXuAresq9n5m/aYLvyy
        +peRdG0D857LK8NndG5R37f4ENfZPWecbj5WM5rw6gubvqmqnIzdyrAn/Uo95w1nO9cuKxd/
        MWOei4viB93yLAZZcYbgO1EPTur9bG/9XbX77c6a7MZpv6vuiCYLCnZv85nAsqPohbzxtccH
        ikw6E3ew3Fhy+1GP+B29dzP4ldTsZtz78PQoq/7Td10fl6sH716Z6uPbcTLH4IHHP202xgXp
        M//M3uF0cNe9BUdNIgVUXaJTv/U9Ko223/5s4eW/s44te20TfuLxEyEZzeSMlPszbeo/+H01
        175z6Lqt5nd+mQNKLMUZiYZazEXFiQCOt9YlvAIAAA==
X-CMS-MailID: 20230509110510epcas1p2f1aada47a081ae8158a62867de464cf9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230509110510epcas1p2f1aada47a081ae8158a62867de464cf9
References: <2023050709-dry-stand-f81b@gregkh>
        <CGME20230509110510epcas1p2f1aada47a081ae8158a62867de464cf9@epcas1p2.samsung.com>
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
index 9dcdf34b7e32..ddf9687a8473 100644
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

