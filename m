Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182806FC612
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 14:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbjEIMQn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 08:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjEIMQm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 08:16:42 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12639358C
        for <stable@vger.kernel.org>; Tue,  9 May 2023 05:16:40 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230509121637epoutp04cdb91caa395fc5f6a123721e0cbdee16~deL8U4kb21782817828epoutp04J
        for <stable@vger.kernel.org>; Tue,  9 May 2023 12:16:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230509121637epoutp04cdb91caa395fc5f6a123721e0cbdee16~deL8U4kb21782817828epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683634597;
        bh=uKMficNuGiYW38r8JODWyd+3pinDiOeMJBWiSwhpVOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UQ+x361mawK0VxxD/A8gf76FRDsSxudAuYwMvnSYCBwvzqeFd10UyVt08/p9DdokD
         SVOFjue0q7cIzMarLiRGzGsr28gCJh+G1MRfrbxziptR32r763lM0AyZTpd98CWM4y
         dDyPChGBjBbjvkyusuqy1f/bXBDEZVtNt1D/36Ck=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230509121637epcas1p283f94dce6b550576cefaa0ac2cb36ec7~deL76Zth91887418874epcas1p2T;
        Tue,  9 May 2023 12:16:37 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.226]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QFxwP0BScz4x9Pr; Tue,  9 May
        2023 12:16:37 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.E1.44594.4A93A546; Tue,  9 May 2023 21:16:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230509121636epcas1p2cfba5b6113e53af2a3a9f447676fc482~deL7LcZnh1887418874epcas1p2Q;
        Tue,  9 May 2023 12:16:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230509121636epsmtrp16aff9cc8c4afc56e27043eae7a4a9271~deL7K3hIK2175921759epsmtrp1W;
        Tue,  9 May 2023 12:16:36 +0000 (GMT)
X-AuditID: b6c32a37-a4dfd7000000ae32-a2-645a39a463a0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.1A.28392.4A93A546; Tue,  9 May 2023 21:16:36 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.41]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230509121636epsmtip1a3fe8fa460769723511f09eb845a3b2c~deL69vNjj0714007140epsmtip10;
        Tue,  9 May 2023 12:16:36 +0000 (GMT)
From:   Yeongjin Gil <youngjin.gil@samsung.com>
To:     stable@vger.kernel.org
Cc:     Yeongjin Gil <youngjin.gil@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 5.10.y] dm verity: fix error handling for check_at_most_once
 on FEC
Date:   Tue,  9 May 2023 21:16:30 +0900
Message-Id: <20230509121630.13518-1-youngjin.gil@samsung.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023050701-epileptic-unethical-f46c@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmge4Sy6gUg46nFhZb/h1htThxS9pi
        wcZHjBYz9j9ld2Dx2LSqk82jb8sqRo/Pm+QCmKMaGG0Si5IzMstSFVLzkvNTMvPSbZVCQ9x0
        LZQUMvKLS2yVog0NjfQMDcz1jIyM9EyNYq2MTJUU8hJzU22VKnShepUUipILgGpzK4uBBuSk
        6kHF9YpT81IcsvJLQS7UK07MLS7NS9dLzs9VUihLzCkFGqGkn/CNMWPbpbNsBZP5K54+Oc3Y
        wHiep4uRg0NCwETi5xeHLkYuDiGBHYwSbZv+sEI4nxglbuy/zgLhfGaUuD35ElMXIydYx96V
        t9ggErsYJX7uPsAG13Ly0BZmkCo2AV2JqS+fsoLsEBGQkrh/1RrEZBYol5jz2R7EFBYIlbjX
        KwFSzCKgKnF4/36wRl4BW4lJlxoYIVbJS9zsgohzClhKLDh8A6pGUOLkzCcsIDYzUE3z1tnM
        IBdICBxjl3i8pJsdotlFYun2x1C2sMSr41ugbCmJl/1t7BAN7YwSKx7OYYRwZjBK/H1/nxWi
        yl6iubWZDeJoTYn1u/QhwooSO3/PZYTYzCfx7msPVLmgxOlr3cyQIOWV6GgTggirSVyZ9Auq
        REai78EsqBs8JF7cXs06gVFxFpJ/ZiH5ZxbC4gWMzKsYxVILinPTU4sNC4yRo3gTIzhFapnv
        YJz29oPeIUYmDsZDjBIczEoivKsSwlKEeFMSK6tSi/Lji0pzUosPMSYDQ3sis5Rocj4wSeeV
        xBuamVlaWBqZGBqbGRoSFjaxNDAxMzKxMLY0NlMS5/3yVDtFSCA9sSQ1OzW1ILUIZgsTB6dU
        A5OY1cQFy67Xznc+NeFy1o9ZKeEaBS+1Q27ErPPZebP0o0JHveRK90b3uUutu6Z6vBd8kOr7
        +ue30Pw1pjO3rFu7X6Z8r1e/E9fseQwyNw7+k66R0WI6uz9mp3f/a4YCu6I5TbFrH57qO+rx
        VmxqmQebPN/bpWdvpb/+Jb63Nf71Ew0zXVlbi5unjuT+dtzA8sV+4vS3+9xnR7DdviPj2Ctr
        oRLRbBPacstmvclvpRnbrywR5Z0rsO2Jv37XFK2TiWs/BS4XXrxZTWvrRJeKqjo2xTe/b0n8
        9N1o77ouu+PZdvNJC33D59zZvlTwrMSHdNOpl107XxzI9+5iLvB+90hi+gfvX4ef/PmTJfot
        WNJPiaU4I9FQi7moOBEA1zvouEgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSnO4Sy6gUg+9/JCy2/DvCanHilrTF
        go2PGC1m7H/K7sDisWlVJ5tH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVwZWy7dJatYDJ/xdMn
        pxkbGM/zdDFyckgImEjsXXmLrYuRi0NIYAejxKxjV1ggEjISfya+B0pwANnCEocPF0PUfGCU
        WNF9ng2khk1AV2Lqy6esIDUiAlIS969ag4SZBSolXl2/wARiCwsES8xY9IYdxGYRUJU4vH8/
        M4jNK2ArMelSAyPEKnmJm10QcU4BS4kFh2+A2UICFhJPps1ghKgXlDg58wkLxHx5ieats5kn
        MArMQpKahSS1gJFpFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcHhqae1g3LPqg94h
        RiYOxkOMEhzMSiK8qxLCUoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQ
        WgSTZeLglGpgWrjtwe9V9hw3Rbj2S782rrwQ83Gip/jNG9rb9jezFLlcdX4Y9MKfV4hnc/hL
        j0NFwtcfL52/Srlwo5mFp223z03F7nvTf+iwhphk6lRdXnjzBOeiHV8OTY9k6Pl17OMP87Xi
        J2XNJ/NMDby5XyHr9ueiZ3/4GfVXu737MitgRmtE96KvE3OmTYuLnDWR8/+u/XvynyTJXDwn
        5tWupnFcLunos6d3Y2Lny8rGyXo+uawzQTnSsmbW9HDhazZVWxdf3butoWWmq84KhsSnwuY7
        J/zOm1m8ZtWsA7IMn1UeXepbddHJvs3Hfdq+lRonbtz5vm1ZxbnlO65aL3weNonF97XlQVOb
        2D0hXdXKv6fZ3fquxFKckWioxVxUnAgAqQJl374CAAA=
X-CMS-MailID: 20230509121636epcas1p2cfba5b6113e53af2a3a9f447676fc482
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230509121636epcas1p2cfba5b6113e53af2a3a9f447676fc482
References: <2023050701-epileptic-unethical-f46c@gregkh>
        <CGME20230509121636epcas1p2cfba5b6113e53af2a3a9f447676fc482@epcas1p2.samsung.com>
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

