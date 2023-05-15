Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543F3702112
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 03:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbjEOBT1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 14 May 2023 21:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbjEOBT0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 14 May 2023 21:19:26 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7B0170B
        for <stable@vger.kernel.org>; Sun, 14 May 2023 18:19:24 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230515011923epoutp02e8a52fb0682bc72b726367b8c7fd6296~fLFzz-E_x0652306523epoutp02p
        for <stable@vger.kernel.org>; Mon, 15 May 2023 01:19:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230515011923epoutp02e8a52fb0682bc72b726367b8c7fd6296~fLFzz-E_x0652306523epoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684113563;
        bh=irPQKgwsCeyzV6EI/oxkzHKOJoGhzgClIisHJPF2Y6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pfr86Pc+JL19ldwwSZI10/lLMafrDRs893K/+beWNdfZVSZJzWpd+rI1JkLoenNWb
         NiRyrQOPNn7h6AcvCsJzUK0/hlvSwwLmomD6iJgli/jzS8UXTKXullfzKHCwFvu9Pn
         k00tHJfmfy0Y7pMAsaBbJmqxeJ9ieGp/mcmaUUBw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230515011923epcas1p40c27e2c75b6b1e6ab77928a13126a449~fLFzfwdsC0585605856epcas1p4C;
        Mon, 15 May 2023 01:19:23 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.249]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QKM3G4trSz4x9Py; Mon, 15 May
        2023 01:19:22 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.B8.48828.A9881646; Mon, 15 May 2023 10:19:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20230515011922epcas1p3b2e3748b9953d9c6c5d36a0f059d92f9~fLFyvRu--0272302723epcas1p3g;
        Mon, 15 May 2023 01:19:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230515011922epsmtrp1e5752cad036bbd48d3bdfe5d143e8bf3~fLFyumAu72098120981epsmtrp1P;
        Mon, 15 May 2023 01:19:22 +0000 (GMT)
X-AuditID: b6c32a35-6ddff7000000bebc-b5-6461889a2584
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.2B.27706.A9881646; Mon, 15 May 2023 10:19:22 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.41]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230515011922epsmtip26f543a3199f1505a4f5ef10f3b881075~fLFyjBpEf2145721457epsmtip2y;
        Mon, 15 May 2023 01:19:22 +0000 (GMT)
From:   Yeongjin Gil <youngjin.gil@samsung.com>
To:     stable@vger.kernel.org
Cc:     Yeongjin Gil <youngjin.gil@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2] dm verity: fix error handling for check_at_most_once on
 FEC
Date:   Mon, 15 May 2023 10:19:19 +0900
Message-Id: <20230515011919.25514-1-youngjin.gil@samsung.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023050708-verdict-proton-a5f0@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmge6sjsQUg1+L1S22/DvCanHilrTF
        go2PGC1m7H/K7sDisWlVJ5tH35ZVjB6fN8kFMEc1MNokFiVnZJalKqTmJeenZOal2yqFhrjp
        WigpZOQXl9gqRRsaGukZGpjrGRkZ6ZkaxVoZmSop5CXmptoqVehC9SopFCUXANXmVhYDDchJ
        1YOK6xWn5qU4ZOWXglyoV5yYW1yal66XnJ+rpFCWmFMKNEJJP+EbY8bTF4fYCo7xV6zaKNnA
        +IOni5GTQ0LARGL2sjbGLkYuDiGBHYwShy4eZ4VwPjFKrJ7wlhnC+cYo8WjvRiaYlvsP7jJB
        JPYySryZ/58JruXWn22sIFVsAroSU18+BbI5OEQEpCTuX7UGMZkFyiXmfLYHqRAWCJS4sW8m
        C4jNIqAqcb3nCpjNK2Ar8fLTNHaIXfISN7v2M4PYnEB7Ly2ZxQZRIyhxcuYTsHpmoJrmrbPB
        DpUQOMQuce90IytEs4vE6uffoAYJS7w6vgXKlpJ42d/GDtHQziix4uEcRghnBqPE3/f3obrt
        JZpbm9kgrtaUWL9LHyKsKLHz91xGiM18Eu++9kCVC0qcvtbNDFIuIcAr0dEmBBFWk7gy6RdU
        iYxE34NZUDd4SHztPMgygVFxFpJ/ZiH5ZxbC4gWMzKsYxVILinPTU4sNCwyR43gTIzhJapnu
        YJz49oPeIUYmDsZDjBIczEoivO0z41OEeFMSK6tSi/Lji0pzUosPMSYDQ3sis5Rocj4wTeeV
        xBuamVlaWBqZGBqbGRoSFjaxNDAxMzKxMLY0NlMS5/3yVDtFSCA9sSQ1OzW1ILUIZgsTB6dU
        A9NaHe71z+8fqcgtSc3cZb/2ds25jYJ/2ZZOmb3IM8VdUTWW+0vDsQ9qVw7cOvlI+cfUznhv
        kYN3jn24Jb6/cfoO4UXvKg6cU/Z438n0598k8dCvzzKEFXlWhu9dNk96bX0q09Yia6nqZ4uZ
        /Pkm9JVeqlVa9ivtf07T3fcnXd/vlJ1n8VT5gfcst1yNq6UKsx58Wp67+J3XnGrFXS+5Vy5a
        tk93x/RNyf/mMV461vOzyCX834GC0ydPdrqzbrhf8pZlpUzRto/fut9PN0n2yNngZ6nttMY9
        9WGL4F+m3NdqtytPMSw2ebBJ9ebyzhdSsxaWPBNbVLvd4I/rarfd2p5y+1V7f/EF1kW0nOKp
        eLjghRJLcUaioRZzUXEiAHOehTRJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvO6sjsQUg3uX2S22/DvCanHilrTF
        go2PGC1m7H/K7sDisWlVJ5tH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVwZTx9cYit4Bh/xaqN
        kg2MP3i6GDk5JARMJO4/uMvUxcjFISSwm1FiwdU3zBAJGYk/E9+zdTFyANnCEocPF0PUfGCU
        2PL4KxtIDZuArsTUl09ZQWpEBKQk7l+1BgkzC1RKvLp+gQnEFhbwl7hx6xfYSBYBVYnrPVdY
        QGxeAVuJl5+msUOskpe42bUfrIYT6J5LS2aBjRcSMJa48ekdI0S9oMTJmU9YIObLSzRvnc08
        gVFgFpLULCSpBYxMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgoNTS3MH4/ZVH/QO
        MTJxMB5ilOBgVhLhbZ8ZnyLEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC
        1CKYLBMHp1QDkx/fFIc07mP1y6N/a4XldkUuiWqcO61inyN30IabqjlrYi6szE1tlLvWJXdy
        4d8Jn22X6q/RSLrL8GxCDz/zWua9LDzL7XzV11QvvbVDwsqlalkl6/ITM67uaftivuF4vJWs
        W1drSc6+RRJdiqFm6acnHO879VHF80n5tot3lZ+dUwzyL0r6Kt2376Oaqcbx/NBOJR/W0o06
        765+f3I5qrP+tN2FB48XVFVJ75BfNlP9DN9dcQs1HdG71fNev/VW82tOtZy9cc/ujweXKdcs
        dLMqniWS55iqaqGxKbXR4FuH+Df+V+GBOwXfzXwZy6H3hV9NK/AJR+GfH7pS2pW7H22yfFbz
        wHmpZB8no0GPEktxRqKhFnNRcSIAOoSThL0CAAA=
X-CMS-MailID: 20230515011922epcas1p3b2e3748b9953d9c6c5d36a0f059d92f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230515011922epcas1p3b2e3748b9953d9c6c5d36a0f059d92f9
References: <2023050708-verdict-proton-a5f0@gregkh>
        <CGME20230515011922epcas1p3b2e3748b9953d9c6c5d36a0f059d92f9@epcas1p3.samsung.com>
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

