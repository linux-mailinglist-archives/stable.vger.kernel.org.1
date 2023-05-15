Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78576702111
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 03:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjEOBTD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 14 May 2023 21:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237997AbjEOBTC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 14 May 2023 21:19:02 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A541707
        for <stable@vger.kernel.org>; Sun, 14 May 2023 18:19:00 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230515011856epoutp040be8e0852f7a85b47e8faf0f7077282a~fLFa39Qqq2687126871epoutp040
        for <stable@vger.kernel.org>; Mon, 15 May 2023 01:18:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230515011856epoutp040be8e0852f7a85b47e8faf0f7077282a~fLFa39Qqq2687126871epoutp040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684113536;
        bh=OfPXLs1BQb7pEc99I90INS4tATHhbZqyS5hRmZI2ntU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJ68cjTxOpfq7Gn9vA3H4fSlbtinRnXgfjyeKkE+2ytegJBt5rjQXLdc/1uU3rif6
         euLD3PAkG0xOBb9FWCrX+hCqRj4ceplRdIogxNeCQSSuRXk+yTjsJfbIPkqXvf2KBn
         qlMIziQ0cOBrVu7fA+cnwmxa9g1P6aZmZkd15IkM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230515011856epcas1p470ff3faefab5666dd0f51fb1b80cdd8c~fLFanISgg2380523805epcas1p4K;
        Mon, 15 May 2023 01:18:56 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.248]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QKM2l6z1jz4x9Q3; Mon, 15 May
        2023 01:18:55 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.58.13472.F7881646; Mon, 15 May 2023 10:18:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20230515011855epcas1p325968c8eaf11fdabd7a41996df8abc6f~fLFaA8I752568725687epcas1p3R;
        Mon, 15 May 2023 01:18:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230515011855epsmtrp220d70d0901cf36eff5630498140200e2~fLFaAQRj60910909109epsmtrp2T;
        Mon, 15 May 2023 01:18:55 +0000 (GMT)
X-AuditID: b6c32a38-78fff700000034a0-19-6461887f207a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.D9.28392.F7881646; Mon, 15 May 2023 10:18:55 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.41]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230515011855epsmtip25dd943831966c2212bb3c2e7a4e36f98~fLFZ19whb1937819378epsmtip2F;
        Mon, 15 May 2023 01:18:55 +0000 (GMT)
From:   Yeongjin Gil <youngjin.gil@samsung.com>
To:     stable@vger.kernel.org
Cc:     Yeongjin Gil <youngjin.gil@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2] dm verity: fix error handling for check_at_most_once on
 FEC
Date:   Mon, 15 May 2023 10:18:54 +0900
Message-Id: <20230515011854.25447-1-youngjin.gil@samsung.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023050709-dry-stand-f81b@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmgW59R2KKwed/FhZb/h1htThxS9pi
        wcZHjBYz9j9ld2Dx2LSqk82jb8sqRo/Pm+QCmKMaGG0Si5IzMstSFVLzkvNTMvPSbZVCQ9x0
        LZQUMvKLS2yVog0NjfQMDcz1jIyM9EyNYq2MTJUU8hJzU22VKnShepUUipILgGpzK4uBBuSk
        6kHF9YpT81IcsvJLQS7UK07MLS7NS9dLzs9VUihLzCkFGqGkn/CNMePX6+/MBcf4Kzq2H2Zt
        YPzB08XIySEhYCLx4GoLcxcjF4eQwA5Gidkzm9lBEkICnxglNj8Ohkh8ZpTY1PaUHabj2Ob3
        TBCJXYwS9xe9g3KAOuavfckIUsUmoCsx9eVT1i5GDg4RASmJ+1etQUxmgXKJOZ/tQSqEBQIl
        buybyQJiswioSvzZcooRpIRXwFZi1tVaiFXyEje79jOD2JwC+hIrfx8Hs3kFBCVOznwC1soM
        VNO8dTbYAxICx9gl3q3oh7rTRWLxw/VQtrDEq+NboGwpic/v9rJBNLQzSqx4OIcRwpnBKPH3
        /X1WiCp7iebWZjaIozUl1u/ShwgrSuz8PZcRYjOfxLuvPVDlghKnr3Uzg5RLCPBKdLQJQYTV
        JK5M+gVVIiPR92AW1A0eEgsut7BPYFScheSfWUj+mYWweAEj8ypGsdSC4tz01GLDAhPkKN7E
        CE6RWhY7GOe+/aB3iJGJg/EQowQHs5IIb/vM+BQh3pTEyqrUovz4otKc1OJDjMnAwJ7ILCWa
        nA9M0nkl8YZmZpYWlkYmhsZmhoaEhU0sDUzMjEwsjC2NzZTEeb881U4REkhPLEnNTk0tSC2C
        2cLEwSnVwOSVy29h0Rrv2+yQrSTFOmfl7FdNcZtf5i5KkeVc7bj7JR9/wqaV9dNWs92qW211
        +3HBG3uRg0vWH/NWDLt1XKvlal1Lhnyj5bkared8D5sD7R5YBO7m0dFcOPNDeR0D35JIV3Gm
        awXrPgrdWGgb/b75/eIqy5Sn5rlsvbd8ri3/L5tx8678SpudVZP6L/63XnT68ys1U54pU53u
        flzsmd7jWxU6de3FiysnMaov9F0jWVi1lPVH0IPeDOawRZGWAvMrWRK/ya3/NH+h+VwvRs9X
        8w4xehuyTSlOeJLpt8Lhhr739NtTF7Woc2V6sRbpMrVOlnmxala0zgRlq1nxSw0yt3JtNlyb
        8OBMkkCfjhJLcUaioRZzUXEiAJlobn5IBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvG59R2KKwc1tKhZb/h1htThxS9pi
        wcZHjBYz9j9ld2Dx2LSqk82jb8sqRo/Pm+QCmKO4bFJSczLLUov07RK4Mn69/s5ccIy/omP7
        YdYGxh88XYycHBICJhLHNr9n6mLk4hAS2MEo8XD3bXaIhIzEn4nv2boYOYBsYYnDh4shaj4w
        Suzc94cJpIZNQFdi6sunrCA1IgJSEvevWoOEmQUqJV5dvwBWIizgL3Hj1i9mEJtFQFXiz5ZT
        jCDlvAK2ErOu1kJskpe42bUfrIRTQF9i5e/jYLaQgJ7E92fbwGxeAUGJkzOfsECMl5do3jqb
        eQKjwCwkqVlIUgsYmVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgQHp5bWDsY9qz7o
        HWJk4mA8xCjBwawkwts+Mz5FiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2amp
        BalFMFkmDk6pBiY3A03F5PZJJ4+rxUtk1Id9sPy/997v/i1LFuSkbOA6/Gv+fLvMTYaCjJJJ
        5g5nj77s/vzGguurh/47nTn8S8Q7V9odLBAtfFgveCW/9NMnxmNvjs7seJin01nvty610Ev2
        lJVm2Eevxvo/Et53QsNZ3aqmCQb8266dWRf0x691/eN/d2766vRfzVI4vD7VbMK/0Ey3mUU/
        JRdOW3d49f6nPLtjqzdVWDyc+zRqjnBsyv33FknPfm9b9mfPojQRk7gPp3YumPPrXJE0Q9Qm
        1t47L9R4Iw3ZfmSdjWSV+5d5oJF1kfLM2UGVGVnLeSOVODmV66Q5l2rb1/h6B87y2DTvxHvr
        uiLuRadzVKVTzyuxFGckGmoxFxUnAgBXb33LvQIAAA==
X-CMS-MailID: 20230515011855epcas1p325968c8eaf11fdabd7a41996df8abc6f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230515011855epcas1p325968c8eaf11fdabd7a41996df8abc6f
References: <2023050709-dry-stand-f81b@gregkh>
        <CGME20230515011855epcas1p325968c8eaf11fdabd7a41996df8abc6f@epcas1p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

