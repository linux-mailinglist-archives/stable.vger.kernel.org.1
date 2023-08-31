Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C132C78EF4D
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 16:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbjHaOJZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 10:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245476AbjHaOJY (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 10:09:24 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1154D1
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 07:09:21 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230831140920usoutp014743bce01c0e40d2a5f9a3a329dc510e~AfQ5F442N2674826748usoutp01A;
        Thu, 31 Aug 2023 14:09:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230831140920usoutp014743bce01c0e40d2a5f9a3a329dc510e~AfQ5F442N2674826748usoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693490960;
        bh=8g1TPPMVMgzgEygDZgoGVEC+0XwnoQ/QgkvL/3yr038=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=GWiIXA57PuU3LXcMVP9B1P/tmyS9nh3Sh38YMJngdJcVoUDzyDWJOhh6qTE8Dr2MB
         THHZe5Bqjusl4Jgt1xQDaJ4c/WcxzJQDY9RlFASJY1WEmGpcbGYlFUeShdblv/nGxL
         NXaHr0t/QQsow/l7D9GlIurktosTeQZYCISJP7XM=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230831140919uscas1p1070ab1cfcfd96482a6803a1234f08c30~AfQ43yqmg0117601176uscas1p1Z;
        Thu, 31 Aug 2023 14:09:19 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 66.13.62237.F0F90F46; Thu,
        31 Aug 2023 10:09:19 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230831140919uscas1p20f84c512d5c624cfb35b925ccf8beae9~AfQ4U1jPC3245232452uscas1p2r;
        Thu, 31 Aug 2023 14:09:19 +0000 (GMT)
X-AuditID: cbfec370-823ff7000001f31d-29-64f09f0f1b13
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 27.47.31410.F0F90F46; Thu,
        31 Aug 2023 10:09:19 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 31 Aug 2023 07:09:18 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Thu,
        31 Aug 2023 07:09:18 -0700
From:   Vincent Fu <vincent.fu@samsung.com>
To:     "joshi.k@samsung.com" <joshi.k@samsung.com>
CC:     "ankit.kumar@samsung.com" <ankit.kumar@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "hch@lst.de" <hch@lst.de>,
        "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Vincent Fu <vincent.fu@samsung.com>,
        "vincentfu@gmail.com" <vincentfu@gmail.com>
Subject: Re: [PATCH v2 1/2] nvme: fix memory corruption for passthrough
 metadata
Thread-Topic: [PATCH v2 1/2] nvme: fix memory corruption for passthrough
        metadata
Thread-Index: AQHZzn3EVuw/Gvu24EGX1R9hYquQ0rAFAaCA
Date:   Thu, 31 Aug 2023 14:09:18 +0000
Message-ID: <20230831140834.85315-1-vincent.fu@samsung.com>
In-Reply-To: <20230814070213.161033-2-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djX87r88z+kGMybbWSx+m4/m8XK1UeZ
        LM6/PcxkMenQNUaL+cuesluse/2exWLBxkeMFhvaBB04PHbOusvucf7eRhaPy2dLPTat6mTz
        2Lyk3mP3zQY2j8+b5ALYo7hsUlJzMstSi/TtErgyjs7qZy1o4ajYt2EjcwPjAbYuRk4OCQET
        iR0TvzB3MXJxCAmsZJRonn+aCcJpZZK4tmMnE0zV54OToarWMkqcfHYIyvnEKLHkSB8LhLOM
        UWLimResXYwcHGwCmhJv9xeAdIsI6Ev0N18Eq2EW+M4ssXTlPkaQhLBAkMSS/X3sEEXBEp+n
        /gTrFREwkvh5MQMkzCKgKvHv5jGwK3gFrCV+vDkCVs4pYCUx5dB1MJtRQEzi+6k1YDXMAuIS
        t57Mh7paUGLR7D3MELaYxL9dD6F+VpS4//0lO0S9nsSNqVPYIGxtiWULXzND7BKUODnzCQtE
        vaTEwRU3wO6XELjDITH1+F92iISLxOypW6AWSEtMX3OZBeR+CYF8iXd9MRDhColfP24xQtjW
        Egv/rIe6k0/i769HjBMYlWchOXsWkpNmITlpFpKTFjCyrGIULy0uzk1PLTbOSy3XK07MLS7N
        S9dLzs/dxAhMT6f/HS7YwXjr1ke9Q4xMHIyHGCU4mJVEeGPN3qUI8aYkVlalFuXHF5XmpBYf
        YpTmYFES5zW0PZksJJCeWJKanZpakFoEk2Xi4JRqYJolnfBy5lHOy/mPL3u5mbEemvpK3v+o
        7n7OW2F3rzqoWvjvuD1znQpL1/kfZ2/uWR14ZX/kcp8zmrOLi4Tk7PJSA896iGk93VDkz7wp
        WWSO1k8lvxcLG7tTHkZsWSf5IiAqb+KkJ39WZBfFrWCacWLXnroN0/kzZx8qc9vbVT7zxt7f
        Ew5k3dwWu9aw2NK/SJ77zyWRcoWtQRsrvGbIsLyTdd6/VsT0AkNpkdsCKRfLToVF9yKyuQPe
        Jq0I/O4qpvSrOzlB8kJF2ve7h87E/FjLv/9TZmPrwVNRadmzZm/J/rY9cofo1eDMjvznxheT
        r07/7FnqWFbo4XDrnkahZOf8X4rplXW6J1qfvdGy3qrEUpyRaKjFXFScCADMWOkvvgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWS2cA0SZd//ocUg32T+CxW3+1ns1i5+iiT
        xfm3h5ksJh26xmgxf9lTdot1r9+zWCzY+IjRYkOboAOHx85Zd9k9zt/byOJx+Wypx6ZVnWwe
        m5fUe+y+2cDm8XmTXAB7FJdNSmpOZllqkb5dAlfG0Vn9rAUtHBX7NmxkbmA8wNbFyMkhIWAi
        8fngZOYuRi4OIYHVjBLdl9awQjifGCV6ft5mh3CWMUps+f4eqIWDg01AU+Lt/gKQbhEBfYn+
        5ossIDXMAt+ZJZau3McIkhAWCJJYsr+PHaIoWOJU9xImkF4RASOJnxczQMIsAqoS/24eYwKx
        eQWsJX68OQJWLiRgKfGspw1sDKeAlcSUQ9fB4owCYhLfT60Bq2cWEJe49WQ+E8QHAhJL9pxn
        hrBFJV4+/scKYStK3P/+kh2iXk/ixtQpbBC2tsSyha+ZIfYKSpyc+YQFol5S4uCKGywTGMVn
        IVkxC0n7LCTts5C0L2BkWcUoXlpcnJteUWycl1quV5yYW1yal66XnJ+7iREYw6f/HY7ZwXjv
        1ke9Q4xMHIyHGCU4mJVEeGPN3qUI8aYkVlalFuXHF5XmpBYfYpTmYFES590x5WKKkEB6Yklq
        dmpqQWoRTJaJg1Oqgam7YPq0LW5zzz8+8yde/NUhBT6m8Ht3pOyCmKP7Pvey/FHhVN4kH5L/
        MbOyt9ahMyzp9DOWvsCFj2b5BL+c+PtEK9NWcS9z09VTHNQ2ljzX8P69bpeV5pGFF//aBsS7
        BvyZdIwjSdb5gNOstwpO/sJnXLfsKbeW7eWLMlRrEOhqaF/9ct4VgbdZRrdaBSd+js1UKtyi
        u/H/3dCJ2jdEln466HvmC8dptefOtsqiuUoH6jY399zVYl+sJ+tkOtv2xtpl2t+LlT/HdRS+
        W5zlpWWvVNG3aq2GlozG7zt3anbk3ws8+4n75gJ2v1v37rmrMn4V+rpaOvpvzdJXa7bdvWkV
        zT75l6qxcZSHy5z/QUosxRmJhlrMRcWJAN+VeMpQAwAA
X-CMS-MailID: 20230831140919uscas1p20f84c512d5c624cfb35b925ccf8beae9
CMS-TYPE: 301P
X-CMS-RootMailID: 20230831140919uscas1p20f84c512d5c624cfb35b925ccf8beae9
References: <20230814070213.161033-2-joshi.k@samsung.com>
        <CGME20230831140919uscas1p20f84c512d5c624cfb35b925ccf8beae9@uscas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

I think the metadata size check is too strict. Commands where the metadata =
size
is too small should result in errors but when the metadata size is larger t=
han
needed they should still go through.

In any case, I tested this patch on a QEMU NVMe device (which supports PI b=
y
default).

I formatted the device with a 512+16 lbaf with a separate buffer for metada=
ta:

nvme format /dev/ng0n1 -m 0 -i 1 -p 0 --lbaf 2 --force

Using the latest fio I wrote some data to it:

./fio --name=3Ddifdix --ioengine=3Dio_uring_cmd --cmd_type=3Dnvme \
  --filename=3D/dev/ng0n1 --rw=3Dwrite --bs=3D512 --md_per_io_size=3D16 --p=
i_act=3D1 \
  --pi_chk=3DAPPTAG --apptag=3D0x8888 --apptag_mask=3D0xFFFF --number_ios=
=3D128

Then I wrote a small program to read 4096 bytes from the device with only a
16-byte (instead of 64-byte) metadata buffer. Without this patch the kernel
crashes. With the patch the read fails with an error message in the kernel =
log.

Tested-by: Vincent Fu <vincent.fu@samsung.com>=
