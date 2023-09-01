Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7071578F8E6
	for <lists+stable@lfdr.de>; Fri,  1 Sep 2023 09:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346055AbjIAHGj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 1 Sep 2023 03:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjIAHGi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 1 Sep 2023 03:06:38 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C00CC5
        for <stable@vger.kernel.org>; Fri,  1 Sep 2023 00:06:34 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230901070631epoutp039a1d3069d119c491b8ade8463b4181f8~AtJAtnifj2719827198epoutp03S
        for <stable@vger.kernel.org>; Fri,  1 Sep 2023 07:06:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230901070631epoutp039a1d3069d119c491b8ade8463b4181f8~AtJAtnifj2719827198epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693551991;
        bh=007ZtfqUYfDpf2svNAZ7ZRCqhQb3uKTf4ztNFGUDLwk=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=MiUcErxuBxfEiuQ9f3UFcW5YjEO8EWxpe8Hy726rtpZ06TNwoUhLyXAAGSRieanxQ
         ks49aDqxRPJ3csDRYjv+6te3i5H88gSxldUIh0Hof25u9lSLi/UqqzfLzmY/k1JT3f
         bz2MW6lDLW7ve/fGf6+NxUbXY3Tc2pWjcAXA30mw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230901070630epcas5p2d2565ed2fc0c61b5cdb29fb67c8c1826~AtI---g220883908839epcas5p2j;
        Fri,  1 Sep 2023 07:06:30 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RcTbR5YLqz4x9Q1; Fri,  1 Sep
        2023 07:06:27 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.49.09635.37D81F46; Fri,  1 Sep 2023 16:06:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230901070627epcas5p4cb281d7a6326da7cc255271562474459~AtI9I-jWM1564715647epcas5p4Q;
        Fri,  1 Sep 2023 07:06:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230901070627epsmtrp28a386b44e92beff20bfcbce61601c4e1~AtI9IKqVu1034410344epsmtrp2P;
        Fri,  1 Sep 2023 07:06:27 +0000 (GMT)
X-AuditID: b6c32a4b-2f5ff700000025a3-f9-64f18d731d32
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.2B.08742.37D81F46; Fri,  1 Sep 2023 16:06:27 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230901070625epsmtip1bc8a5aa12befdbd744e2de56feafd4b5~AtI7UxeI83245732457epsmtip16;
        Fri,  1 Sep 2023 07:06:25 +0000 (GMT)
Message-ID: <6e21ae88-fd9d-a77c-c360-741326b209e6@samsung.com>
Date:   Fri, 1 Sep 2023 12:36:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/2] nvme: fix memory corruption for passthrough
 metadata
Content-Language: en-US
To:     Vincent Fu <vincent.fu@samsung.com>
Cc:     "ankit.kumar@samsung.com" <ankit.kumar@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "hch@lst.de" <hch@lst.de>,
        "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "vincentfu@gmail.com" <vincentfu@gmail.com>
From:   KANCHAN JOSHI/Host Software /SSIR/Staff Engineer/Samsung
         Electronics <joshi.k@samsung.com>
In-Reply-To: <20230831140834.85315-1-vincent.fu@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmum5x78cUg+4tWhZrrvxmt1h9t5/N
        4uaBnUwWK1cfZbI4//Ywk8WkQ9cYLeYve8puse71exaLBRsfMVo87u5gtNjQJujA7bFz1l12
        j/P3NrJ4XD5b6rFpVSebx+Yl9R67bzawefRtWcXo8XmTXABHVLZNRmpiSmqRQmpecn5KZl66
        rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtCZSgpliTmlQKGAxOJiJX07m6L80pJU
        hYz84hJbpdSClJwCkwK94sTc4tK8dL281BIrQwMDI1OgwoTsjJaLegXvOSquzLrF3MDYwd7F
        yMkhIWAiMWlWI5gtJLCbUaKr272LkQvI/sQosbu9kQXC+cYocfZEAzNMx+3nt9khEnsZJXYt
        2sgK4bxllHg46R+Qw8HBK2AnceBtAUgDi4CKxPyXIJM4gcKCEidnPgGzRQWSJH5dncMIYgsL
        BEks2d8HdgazgLjErSfzmUBsEQF1iUPf+8DmMwtcYpb48vUhWDMbUPOJ659ZQHZxCthITLgv
        B9ErL7H97RxmkHoJgR0cEif6FjNBXO0isXPtWqgPhCVeHd8C9b+UxOd3e9kg7GSJSzPPQdWX
        SDzecxDKtpdoPdXPDLKLWUBTYv0ufYhdfBK9v58wgYQlBHglOtqEIKoVJe5NesoKYYtLPJyx
        BMr2kNj76Co0pPczSjx+6zOBUWEWUqjMQvL9LCTfzEJYvICRZRWjZGpBcW56arFpgXFeajk8
        tpPzczcxgpOwlvcOxkcPPugdYmTiYDzEKMHBrCTCG2v2LkWINyWxsiq1KD++qDQntfgQoykw
        eiYyS4km5wPzQF5JvKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxSDUx7
        tslPZv36/aHG0vliSk3WS2JnJ2YsZtQrTI66xNx2YcL/7PtzFv5PuCnHoMi2a8Zsyc5FuW2h
        KxdNZ51d8C78TbCVxCUb97BO//tJ7ps1GL1bdkiG3/tSLDq3vUfyvv3/I39vzEoLMtj0bMOR
        VR3P1abtYTl8TTJxvtslM1n9dp2EHg0Ovd/v/v0+8XOzRV+D53fVsvqFkws8We2/NYS5PT6u
        y71tnmTBn/DlfWtSLs05n+0sVPdq19x1ettWWjGt3MlUsedlv8kf39nC3z3tZP5fuMmyuy1f
        1n9vFJvj01eb/8YWzvJTvx/0wm5eItuiH4vPi5x59bzD6fnU+ZZVoWVzk0Ifl+TvKhe13cSn
        xFKckWioxVxUnAgAeTdhAUsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSnG5x78cUg9cfhCzWXPnNbrH6bj+b
        xc0DO5ksVq4+ymRx/u1hJotJh64xWsxf9pTdYt3r9ywWCzY+YrR43N3BaLGhTdCB22PnrLvs
        HufvbWTxuHy21GPTqk42j81L6j1232xg8+jbsorR4/MmuQCOKC6blNSczLLUIn27BK6Mlot6
        Be85Kq7MusXcwNjB3sXIySEhYCJx+/ltMFtIYDejRHN/LERcXKL52g+oGmGJlf+eA9lcQDWv
        GSVe9kwBcjg4eAXsJA68LQCpYRFQkZj/spEFxOYVEJQ4OfMJmC0qkCSx534jE4gtLBAksWR/
        H9hMZqD5t57MB4uLCKhLHPrexwoyn1ngGrPE6el32SAO2s8o8XqXIIjNBjRo7frLjCB7OQVs
        JCbcl4OYYybRtbWLEcKWl9j+dg7zBEahWUjOmIVk3SwkLbOQtCxgZFnFKJlaUJybnltsWGCY
        l1quV5yYW1yal66XnJ+7iREccVqaOxi3r/qgd4iRiYPxEKMEB7OSCG+s2bsUId6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4rziL3pThATSE0tSs1NTC1KLYLJMHJxSDUxbZfp557DvamoquHA4S3xu
        Wsx2EwG72+9ln0/nUplu9bJa32p17JpWdZnNRX8LzgiYqlaK+f1qXPj7PI9yFCvzOuuojDu2
        qVJfqnaffi1XMOMUT3xidMS2MMmPOz89/areyZ524DzfhtkSN//Yz+9eX7rCVuQj347M2K3Z
        z5cLLS5ndtc+8aFUKb/xa82xwC1plzT+blLwOLe71OTKmhk1S6cnaIXbxMjX3y28ZBhdZeUn
        2S/5ZY/tShNOv+iNE9wNX/2s8dC9/OKEFf/tP+oBv+7a22xddOOmm9/M89GPvfPSrqi8kdjZ
        v+qnuK5ewISnJyZ+/PjEosN2ivt30eAgV6WEfbKKqRpPapPedymxFGckGmoxFxUnAgATdoi5
        JwMAAA==
X-CMS-MailID: 20230901070627epcas5p4cb281d7a6326da7cc255271562474459
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230831140919uscas1p2384b869cd6ec943769c647d34c532972
References: <20230814070213.161033-2-joshi.k@samsung.com>
        <CGME20230831140919uscas1p2384b869cd6ec943769c647d34c532972@uscas1p2.samsung.com>
        <20230831140834.85315-1-vincent.fu@samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/31/2023 7:39 PM, Vincent Fu wrote:
> I think the metadata size check is too strict. Commands where the metadata size
> is too small should result in errors but when the metadata size is larger than
> needed they should still go through.

Indeed.
I will fold that change in the next version.

> In any case, I tested this patch on a QEMU NVMe device (which supports PI by
> default).
> 
> I formatted the device with a 512+16 lbaf with a separate buffer for metadata:
> 
> nvme format /dev/ng0n1 -m 0 -i 1 -p 0 --lbaf 2 --force
> 
> Using the latest fio I wrote some data to it:
> 
> ./fio --name=difdix --ioengine=io_uring_cmd --cmd_type=nvme \
>    --filename=/dev/ng0n1 --rw=write --bs=512 --md_per_io_size=16 --pi_act=1 \
>    --pi_chk=APPTAG --apptag=0x8888 --apptag_mask=0xFFFF --number_ios=128
> 
> Then I wrote a small program to read 4096 bytes from the device with only a
> 16-byte (instead of 64-byte) metadata buffer. Without this patch the kernel
> crashes. With the patch the read fails with an error message in the kernel log.
> 
> Tested-by: Vincent Fu <vincent.fu@samsung.com>

Thanks.
