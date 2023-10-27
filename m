Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65077D8F74
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 09:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345396AbjJ0HQK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 03:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbjJ0HQJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 03:16:09 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFEED4E
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 00:16:04 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231027071602epoutp0359b9d2743c9c989cbf9ce28e1bad4cf3~R5ZUJ95dN1845718457epoutp03H
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 07:16:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231027071602epoutp0359b9d2743c9c989cbf9ce28e1bad4cf3~R5ZUJ95dN1845718457epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698390962;
        bh=vqVTPW/OO5rrONOkrboS3rJTnWgAy8fH13741LE3I6E=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=SeVimsm1c9OwuISWeQtqXNyO/VM1AijhfZrfl5PXioi4NBcQ8qVgLCuURCEWxyibD
         oC58A261vSUMe4XRrh/uvx1X+M4p8o4zfVEHHH8djPIhGwQe3kL0wzbom2YmMg8PBM
         NstuNKDiN8zVG9j+Kk+CSHAS543Rbl6YQ1K/xqFI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231027071602epcas5p1ea637752568ff6d28d6a30ca9e255eca~R5ZTs9bSn2831128311epcas5p1i;
        Fri, 27 Oct 2023 07:16:02 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SGv8c1rzdz4x9Pv; Fri, 27 Oct
        2023 07:16:00 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.E0.10009.0B36B356; Fri, 27 Oct 2023 16:16:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231027071559epcas5p4cc7eb2a38e21776dcdf548406dfd617c~R5ZRgdz-81556915569epcas5p44;
        Fri, 27 Oct 2023 07:15:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231027071559epsmtrp16e50b5fd7611d52be0a6cd0d45dbb0ec~R5ZRfva2L2266822668epsmtrp1c;
        Fri, 27 Oct 2023 07:15:59 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-12-653b63b080af
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.61.08817.FA36B356; Fri, 27 Oct 2023 16:15:59 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231027071557epsmtip27d41aa15185a4e5bfe468830782755a9~R5ZPiE3bs2848128481epsmtip2d;
        Fri, 27 Oct 2023 07:15:57 +0000 (GMT)
Message-ID: <2dd010c2-32b2-05fd-2f8a-80e759e94d6e@samsung.com>
Date:   Fri, 27 Oct 2023 12:45:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "vincentfu@gmail.com" <vincentfu@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
From:   Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <aesib7wh6jkm6tsvonsuk73pmsgi3h6aikpzf52vbjbak3jspd@kbi4cm2uhsak>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmhu6GZOtUg4MnuCxW3+1ns7h5YCeT
        xcrVR5ksJh26xmgxf9lTdot1r9+zWOyb5WmxYOMjRosNbYIOnB47Z91l9zh/byOLx+WzpR6b
        VnWyeWxeUu+x+2YDm0ffllWMHp83yXm0H+hmCuCMyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneO
        NzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMATpQSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKr
        lFqQklNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd8fPXb5aC81wVW1/9YW1gfM3RxcjBISFg
        InH8kXcXIxeHkMBuRonX516ydzFyAjmfGCUWNihBJL4xSrzY858ZJAHS8KxlPjNEYi+jxKOG
        5VDOW0aJnx+OsoJU8QrYScz+spgNxGYRUJXYuOwcO0RcUOLkzCcsILaoQJLEr6tzGEFsYQFX
        iWezWsDizALiEreezGcCsUUETCWebNnCBLKAWeANk8SZf1NZQO5mE9CUuDC5FKSGU8BP4nnH
        cTaIXnmJ7W/ngB0kIbCFQ2LXhx1QZ7tIfJu5AcoWlnh1fAs7hC0l8bK/DcpOlrg08xwThF0i
        8XjPQSjbXqL1VD8zyF5moL3rd+lD7OKT6P39hAkSjLwSHW1CENWKEvcmPWWFsMUlHs5YAmV7
        SLQ3gbwLCquLjBJXOzuYJzAqzEIKlllI3p+F5J1ZCJsXMLKsYpRMLSjOTU8tNi0wyksth8d3
        cn7uJkZw8tXy2sH48MEHvUOMTByMhxglOJiVRHgjfSxShXhTEiurUovy44tKc1KLDzGaAuNn
        IrOUaHI+MP3nlcQbmlgamJiZmZlYGpsZKonzvm6dmyIkkJ5YkpqdmlqQWgTTx8TBKdXANHtG
        U3Yhl8UClhl7qib+nsLj29/9fO1LjbUVDt5vHz3bJXrxw5317A912+ydln/omb+yUmrSNnW1
        kv9GPqHphm65E532vtszs0sy8pjnpw07Iz79apP80rFiev7WvvOeEWdW3jmxJXxZz3GRlMXl
        2Yf/GK89evmole1ymdy1de0syi6/L4k/v1ox4/Qe4+LQ9vdRDu9uSjXrRAj0dS2I+usVv16Y
        a1/MVWM+yaYXJwW/TmlX/jZlyq0ghdXHbwg4bP1wSu2av7Pev7epN9hv7s61/BK6Y2fr/76l
        da/iZ4UeZPef+1b+md71tg3nStwjj6uwnkq23XcinvX/3RN3Ojcu3JdqkmD3rUXB7+yljnYl
        luKMREMt5qLiRADG0VqFRwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvO76ZOtUgwcNBhar7/azWdw8sJPJ
        YuXqo0wWkw5dY7SYv+wpu8W61+9ZLPbN8rRYsPERo8WGNkEHTo+ds+6ye5y/t5HF4/LZUo9N
        qzrZPDYvqffYfbOBzaNvyypGj8+b5DzaD3QzBXBGcdmkpOZklqUW6dslcGX8/PWbpeA8V8XW
        V39YGxhfc3QxcnJICJhIPGuZzwxiCwnsZpTYNjkYIi4u0XztBzuELSyx8t9zIJsLqOY1o8Sl
        l3/AGngF7CRmf1nMBmKzCKhKbFx2jh0iLihxcuYTFhBbVCBJYs/9RiYQW1jAVeLZrBawODPQ
        gltP5oPFRQRMJZ5s2cIEsoBZ4B2TxK3tv1khtl1klLjQ+w0ow8HBJqApcWFyKUgDp4CfxPOO
        42wQg8wkurZ2MULY8hLb385hnsAoNAvJHbOQ7JuFpGUWkpYFjCyrGCVTC4pz03OLDQuM8lLL
        9YoTc4tL89L1kvNzNzGCY01LawfjnlUf9A4xMnEwHmKU4GBWEuGN9LFIFeJNSaysSi3Kjy8q
        zUktPsQozcGiJM777XVvipBAemJJanZqakFqEUyWiYNTqoEpJclw64SEI1yeYtKPzzcKc8rP
        OD5tT8IV9gzX9wXJbwxPXjrAJ/b/2T+BaQ/nsL/zuPLsXVXVw421Sz7Hdn/QZy+7J6R5mmmu
        0f1DJu+1VsnblUks+pesP8Fmu4fiVZ2T5xiTK1XFF64urZabms0U/DDLvq6YR+ON/xJ1bkmX
        eO03aRkb25fM8ZHj8l4zbVFr1tKZcww/T+eqffnimEN5b/Wtt5uL5sdF5zv4PPR4GJmwIuOB
        iY/TLbvys41bW/cVNW4SOnamZ9LNVeXPT6exO9yMPbzUbMlNBrXb8T6KjxTfKkbPXZ+6549o
        di9Lf/tUxRWCGWY5uzV5uWeEGDL5BudKrTVZd3WGo/CtZUVKLMUZiYZazEXFiQAsoaSjJAMA
        AA==
X-CMS-MailID: 20231027071559epcas5p4cc7eb2a38e21776dcdf548406dfd617c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231016061151epcas5p1a0e18162b362ffbea754157e99f88995
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com>
        <20231016060519.231880-1-joshi.k@samsung.com>
        <aesib7wh6jkm6tsvonsuk73pmsgi3h6aikpzf52vbjbak3jspd@kbi4cm2uhsak>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/27/2023 12:36 PM, Shinichiro Kawasaki wrote:
> On Oct 16, 2023 / 11:35, Kanchan Joshi wrote:
>> Passthrough has got a hole that can be exploited to cause kernel memory
>> corruption. This is about making the device do larger DMA into
>> short meta/data buffer owned by kernel [1].
>>
>> As a stopgap measure, disable the support of unprivileged passthrough.
>>
>> This patch brings back coarse-granular CAP_SYS_ADMIN checks by reverting
>> following patches:
>>
>> - 7d9d7d59d44 ("nvme: replace the fmode_t argument to the nvme ioctl handlers with a simple bool")
>> - 313c08c72ee ("nvme: don't allow unprivileged passthrough on partitions")
>> - 6f99ac04c46 ("nvme: consult the CSE log page for unprivileged passthrough")
>> - ea43fceea41 ("nvme: allow unprivileged passthrough of Identify Controller")
>> - e4fbcf32c86 ("nvme: identify-namespace without CAP_SYS_ADMIN")
>> - 855b7717f44 ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")
>>
>> [1] https://lore.kernel.org/linux-nvme/20231013051458.39987-1-joshi.k@samsung.com/
> 
> This change looks affecting the blktests test case nvme/046. Should we adjust
> the test case for the coarse-granular CAP_SYS_ADMIN checks?

Nothing to adjust in the test, as there is no change in the kernel (at 
this point). I have made a note to revisit the test if anything changes.
