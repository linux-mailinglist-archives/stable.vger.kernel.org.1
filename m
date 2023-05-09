Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EB16FC616
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 14:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjEIMTE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 08:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjEIMTD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 08:19:03 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBE84202
        for <stable@vger.kernel.org>; Tue,  9 May 2023 05:19:02 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230509121900epoutp03570169322261bbd26fbf71ebda35be7b~deOBDAYms1004510045epoutp03E
        for <stable@vger.kernel.org>; Tue,  9 May 2023 12:19:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230509121900epoutp03570169322261bbd26fbf71ebda35be7b~deOBDAYms1004510045epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683634740;
        bh=Kxt/Y1PqyKdOIAJYfvxf3NE+IzEhWiAyuOpXWL9pbFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PJlKW990oA5n/pMH1CvWoGzw0qhKUUoy+Fk3w0KU9ag6az35tekFL8uenRz1edNuN
         RXbWjKnW4XLGx0obt6U1FtNxUjjwCnqsrlV9dTTLOoKS7V0o0E4O4DqZK36ZmT4eAM
         2TcqWYzAOp8B4myheZyhSHYG30o+A+5k2IERu3lU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230509121859epcas1p314ef2d33f1e4a169c1820fee38a494fd~deOAwV-nv0961609616epcas1p3h;
        Tue,  9 May 2023 12:18:59 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.225]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QFxz74ZNhz4x9Pv; Tue,  9 May
        2023 12:18:59 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.6E.48828.33A3A546; Tue,  9 May 2023 21:18:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230509121858epcas1p24a0d408759e91024d242768821827a34~deN-1Hcjj2988529885epcas1p2W;
        Tue,  9 May 2023 12:18:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230509121858epsmtrp2dfa7bb23659fbcae90f6f2c52591339d~deN-0kJr82372923729epsmtrp2a;
        Tue,  9 May 2023 12:18:58 +0000 (GMT)
X-AuditID: b6c32a35-6ddff7000000bebc-f7-645a3a3377ef
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.2A.28392.23A3A546; Tue,  9 May 2023 21:18:58 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.41]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230509121858epsmtip298e0cb78cfbebd19c0030c4034989c2b~deN-o6uYu1770817708epsmtip2a;
        Tue,  9 May 2023 12:18:58 +0000 (GMT)
From:   Yeongjin Gil <youngjin.gil@samsung.com>
To:     stable@vger.kernel.org
Cc:     Yeongjin Gil <youngjin.gil@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 4.19.y] dm verity: fix error handling for check_at_most_once
 on FEC
Date:   Tue,  9 May 2023 21:18:56 +0900
Message-Id: <20230509121856.13689-1-youngjin.gil@samsung.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023050708-verdict-proton-a5f0@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmga6xVVSKwaQGeYst/46wWpy4JW2x
        YOMjRosZ+5+yO7B4bFrVyebRt2UVo8fnTXIBzFENjDaJRckZmWWpCql5yfkpmXnptkqhIW66
        FkoKGfnFJbZK0YaGRnqGBuZ6RkZGeqZGsVZGpkoKeYm5qbZKFbpQvUoKRckFQLW5lcVAA3JS
        9aDiesWpeSkOWfmlIBfqFSfmFpfmpesl5+cqKZQl5pQCjVDST/jGmLH21wu2gsn8FXvaprI3
        MJ7n6WLk5JAQMJG49nwuWxcjF4eQwA5GiQMLp7JDOJ8YJaadesIC4XxmlDj0+wgzTMv6KQcZ
        IRK7GCUe3UHSsv3IJyaQKjYBXYmpL5+ydjFycIgISEncv2oNYjILlEvM+WwPUiEsECrx9v8/
        RpAwi4CqxLX92SBhXgFbiWX/z7NCrJKXuNm1H2wtJ9DaS0tmsUHUCEqcnAlyGyfQRHmJ5q2z
        mUEukBA4xC7Rv/AHVLOLxKXZvxghbGGJV8e3sEPYUhKf3+1lg2hoZ5RY8XAOI4Qzg1Hi7/v7
        UN32Es2tzWwQR2tKrN+lDxFWlNj5ey4jxGY+iXdfe6DKBSVOX+tmBimXEOCV6GgTggirSVyZ
        9AuqREai78EsqBs8JGadfsQ+gVFxFpJ/ZiH5ZxbC4gWMzKsYxVILinPTU4sNCwyR43gTIzhJ
        apnuYJz49oPeIUYmDsZDjBIczEoivKsSwlKEeFMSK6tSi/Lji0pzUosPMSYDA3sis5Rocj4w
        TeeVxBuamVlaWBqZGBqbGRoSFjaxNDAxMzKxMLY0NlMS5/3yVDtFSCA9sSQ1OzW1ILUIZgsT
        B6dUA9OpHSf6TK7E73jY2bzh6EFlpftSTvmtDGFp26r16hfk9M/POfmsV9hvhSaP84I5lT5v
        XdafvqShs9CoV9zfqd7XO2z/V76oa/O4gl1iEiwuOM+v7bO78VDlkvczvcqkFGU2Fq3ST0+O
        hirkX1jz9s/yLY/eFt2t2iC0wfq8VBK/10sZD/P4S7+uiVxbuTJgecnBspBZmjtVi3xMPpY2
        nT2oLxrFxsJ/4m7U1Z8rXqbcLHmVzdGx8a5t1+pj11j+GNjr6foxaNdPn9j+MtXwj9WbessJ
        nzOWah3mfGpuduu7cdjZj9IZPuIzT8dpOxvETvkbqn7XoZTR1Ob8bZXlS2ebfj5luPiq1D6r
        0uMz4pRYijMSDbWYi4oTAb+j82FJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSvK6RVVSKwcsLJhZb/h1htThxS9pi
        wcZHjBYz9j9ld2Dx2LSqk82jb8sqRo/Pm+QCmKO4bFJSczLLUov07RK4Mtb+esFWMJm/Yk/b
        VPYGxvM8XYycHBICJhLrpxxk7GLk4hAS2MEocXvhFFaIhIzEn4nv2boYOYBsYYnDh4shaj4w
        SvzsnMYIUsMmoCsx9eVTVpAaEQEpiftXrUHCzAKVEq+uX2ACCQsLBEtc76oDMVkEVCWu7c8G
        qeAVsJVY9v881CJ5iZtd+5lBbE6gay4tmcUGYgsJGEvc+PSOEaJeUOLkzCcsENPlJZq3zmae
        wCgwC0lqFpLUAkamVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwaGppbWDcc+qD3qH
        GJk4GA8xSnAwK4nwrkoISxHiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampB
        ahFMlomDU6qBqdVN+ag0+wcXE0Nb6WtBS+qMuThvl8Yz8Z8tVpq441rS/BOsM6Qs6y9cmXQj
        9/PB/3dEbXen1i0xkV+RWvZ2qp2jrsDuz5zCyrUllySmfFonISaxY3r0z+fPqjp2SZ2bemza
        vyWFe+X21UV/tYk4HvOcT17/WslBW/W1TJIJpkbTPjw8xnm7L42D/5US34odRrlr+FXmVz5a
        8SLyFuuR4Fd9yziETnsuVFFZcDc8K2Qdk3vvjfb/vlldx1/PqzjlkN2T9r3nl07Ecs4XvzL+
        q181iE1Od3X4vMk/5MOXaxW6nJWbNhoq601WkV1/p54hw/qwQI7PJZavCi77LWe909z9ck9g
        XEXGfPuw4wIflFiKMxINtZiLihMBZpLJVLwCAAA=
X-CMS-MailID: 20230509121858epcas1p24a0d408759e91024d242768821827a34
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230509121858epcas1p24a0d408759e91024d242768821827a34
References: <2023050708-verdict-proton-a5f0@gregkh>
        <CGME20230509121858epcas1p24a0d408759e91024d242768821827a34@epcas1p2.samsung.com>
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
 drivers/md/dm-verity-target.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 36945030520a..74e716636e19 100644
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

