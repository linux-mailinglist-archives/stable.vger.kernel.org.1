Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B355E6FC4BD
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 13:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjEILNw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 07:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjEILNu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 07:13:50 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D36F46AC
        for <stable@vger.kernel.org>; Tue,  9 May 2023 04:13:45 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230509111343epoutp018bf78989f8f5967e3dd129f76a6ad66f~ddVBbI4zN2012720127epoutp01h
        for <stable@vger.kernel.org>; Tue,  9 May 2023 11:13:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230509111343epoutp018bf78989f8f5967e3dd129f76a6ad66f~ddVBbI4zN2012720127epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683630823;
        bh=agylVYPRlfQcb7aPK/5x21TlnqrRfMW2oCD7bVN+diQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=cg5Kh6IEoVz4irXMl5xZceNWZr/XKGSIPwkd5IkoqmAAe1kdq2Kru4F2rhfpQtsx+
         IBPgFYyNUublJIxGjU8y9zRPOSP7M69aGDE1lZmaNVGoOIuwTcFK2SQmpT1nteV95x
         ad+PRsaFZ/nRQtGmS4yHSUO2YQURgp74CC36czsY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230509111343epcas1p3956c8a0e207ed28b62372f04373b2ace~ddVA7G9yc0124301243epcas1p3V;
        Tue,  9 May 2023 11:13:43 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.247]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QFwWp5f0Hz4x9Pt; Tue,  9 May
        2023 11:13:42 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.A7.48828.6EA2A546; Tue,  9 May 2023 20:13:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230509111342epcas1p21e2e6d28b5c90982018f7bea15164247~ddU--VPdu1009610096epcas1p26;
        Tue,  9 May 2023 11:13:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230509111342epsmtrp1a38d9425056e64c91f62834f0687f248~ddU-_pK1-1830618306epsmtrp17;
        Tue,  9 May 2023 11:13:42 +0000 (GMT)
X-AuditID: b6c32a35-6ddff7000000bebc-98-645a2ae6e3cd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.44.27706.6EA2A546; Tue,  9 May 2023 20:13:42 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.41]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230509111341epsmtip2f177254f52f31f641432c987775cbc10~ddU-1UdEb1635916359epsmtip2F;
        Tue,  9 May 2023 11:13:41 +0000 (GMT)
From:   Yeongjin Gil <youngjin.gil@samsung.com>
To:     youngjin.gil@samsung.com
Cc:     stable@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 5.10.y] dm verity: fix error handling for check_at_most_once
 on FEC
Date:   Tue,  9 May 2023 20:13:40 +0900
Message-Id: <20230509111340.19925-1-youngjin.gil@samsung.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmge4zragUg3VvdSy2/DvCanHilrTF
        go2PGC1m7H/K7sDisWlVJ5tH35ZVjB6fN8kFMEc1MNokFiVnZJalKqTmJeenZOal2yqFhrjp
        WigpZOQXl9gqRRsaGukZGpjrGRkZ6ZkaxVoZmSop5CXmptoqVehC9SopFCUXANXmVhYDDchJ
        1YOK6xWn5qU4ZOWXglyoV5yYW1yal66XnJ+rpFCWmFMKNEJJP+EbY8aSVToFx3krnq8UaWDc
        yN3FyMkhIWAi8fHWQuYuRi4OIYEdjBJbXk5ng3A+MUrc/trIDuF8Y5T4uvgKI0zLpxVfoBJ7
        GSXOXVmJ0LL+13mwKjYBXYmpL5+ygtgiAjISOyfNZwKxmQXSJPqOvwWKc3AIC4RK3OuVAAmz
        CKhK7N6yDKycV8BW4kDjMqhl8hI3u/YzQ8QFJU7OfMICMUZeonnrbLC7JQRWsUt8nnqYDaLB
        ReLkgxMsELawxKvjW9ghbCmJl/1t7BAN7YwSKx7OYYRwZjBK/H1/nxWiyl6iubWZDeQ6ZgFN
        ifW79CHCihI7f89lhNjMJ/Huaw9UuaDE6WvdzCDlEgK8Eh1tQhBhNYkrk35BlchI9D2YBXWD
        h8TS6a/A4SAkECtx/PE3tgmMCrOQ/DYLyW+zEI5YwMi8ilEstaA4Nz212LDAEDmONzGCk6SW
        6Q7GiW8/6B1iZOJgPMQowcGsJMK7KiEsRYg3JbGyKrUoP76oNCe1+BBjMjC0JzJLiSbnA9N0
        Xkm8oZmZpYWlkYmhsZmhIWFhE0sDEzMjEwtjS2MzJXHeL0+1U4QE0hNLUrNTUwtSi2C2MHFw
        SjUwWa45Vf/Lpzhmd4sKA7tQY9Qb1ZlGpgqiR5ZMLPMQMZkwjze17PiER7/7/noy1nZXOdza
        PMdnG79iNWfNgk2X5Vv/TP625Pgu+Z6jt9+mh7t+vmoxo1iHv0fpw+ci7he8a+6kP9rDaqVm
        qD1h5ZTr0RKrC5k3iZo4ZDnPrL2rrfHk2F/VDoWD7r5RnqqJc66EPXMLf7Rpet2VxnqhnvzH
        +459vaqmZa964OOl6xE9QrEd9/IUt88O+L1Mpq8zcF3JQnOOXJN6nbl77zMp15vGT16SuvGV
        pkTzp2uJ+n9530tqT7x7TDe8fZ26f5F9cVD4i54HLJ+9tnodcfk+1zxV4fKyKHUZ7cw3m9gv
        zb+rxFKckWioxVxUnAgA919HNkkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprELMWRmVeSWpSXmKPExsWy7bCSvO4zragUg1OzWSy2/DvCanHilrTF
        go2PGC1m7H/K7sDisWlVJ5tH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVwZSxZpVNwnLfi+UqR
        BsaN3F2MnBwSAiYSn1Z8Ye9i5OIQEtjNKLGk+z4rREJG4s/E92xdjBxAtrDE4cPFEDUfGCVW
        P33PBFLDJqArMfXlU7B6EaD6nZPmg8WZBTIkzs1ZxwZiCwsES8xY9IYdxGYRUJXYvWUZWD2v
        gK3EgcZljBC75CVudu1nhogLSpyc+YQFYo68RPPW2cwTGPlmIUnNQpJawMi0ilEytaA4Nz23
        2LDAMC+1XK84Mbe4NC9dLzk/dxMjONi0NHcwbl/1Qe8QIxMH4yFGCQ5mJRHeVQlhKUK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwTS9pmZW1e1JZemeF
        8qvLvLLZP24euL5avNzd42m/2VXPlKf2bdPXLewJNC9cZD1t36KM63NLrGfs9lJ6LWVsu3lx
        5tM6kcsHH0QuZvI6kmSlx3Hx8BP39A1BaVPeJHF5T53jJacSZ5F5/vD3qx3OhpteaD/bFiar
        biC/rZExXo5/z1Y2Qa+Ap2qcT48x6z+ft83+f1JcubNn+Z3+M9uO6X1nDl0wa/0K1U03+F6x
        zCv1OS2+/UMk8/vuDfyRzjoTG3KCr2+YzJ54Q+zENF/hi7ffnShtVroTKyXkmikw3/CKWoXY
        vH1XXh7/c1hr2+XMyLx5Og5fli65qBUhP2vVROHzrqc+3t7yo+3oxjf/pyqxFGckGmoxFxUn
        AgAPM9BupQIAAA==
X-CMS-MailID: 20230509111342epcas1p21e2e6d28b5c90982018f7bea15164247
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230509111342epcas1p21e2e6d28b5c90982018f7bea15164247
References: <CGME20230509111342epcas1p21e2e6d28b5c90982018f7bea15164247@epcas1p2.samsung.com>
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

