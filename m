Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13827022A9
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 06:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238775AbjEOEGQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 00:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjEOEGN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 00:06:13 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECC5E68
        for <stable@vger.kernel.org>; Sun, 14 May 2023 21:06:11 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230515040608epoutp0375173aedb048dea6f66cbfc74a5c3dcc~fNXZ6W3Sm1638116381epoutp03Q
        for <stable@vger.kernel.org>; Mon, 15 May 2023 04:06:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230515040608epoutp0375173aedb048dea6f66cbfc74a5c3dcc~fNXZ6W3Sm1638116381epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684123568;
        bh=n9j7ByQIstDDip0DGMuATT9owQJySiRmIbuk3bL4iXg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=N3EHAItnZjdPJCvqdmgxwGqQ8UnGAlqxeqjfFDJimGitC8VhhX23PODTj/JRtWtdy
         tnOVJvU1C+tQCYPXAlUUlSFn3EQwAv9QYJuhnywsO5c05qrNTiQ2TpUl0mXMBePGUW
         7xhOmKzNTq96SId5qFlvD0u5J4T3wlVvkQdrAdH0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230515040608epcas1p44e0f4291028086baa2981154c8bcefc4~fNXZm7fO-3132631326epcas1p4O;
        Mon, 15 May 2023 04:06:08 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.222]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QKQlg6jgxz4x9Q8; Mon, 15 May
        2023 04:06:07 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.28.39132.FAFA1646; Mon, 15 May 2023 13:06:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230515040607epcas1p2312a701f1573700e8758a85ae29df98d~fNXY_QmkY0208602086epcas1p2N;
        Mon, 15 May 2023 04:06:07 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230515040607epsmtrp246830484cfaaff328366091676b88a72~fNXY8Fxj51112211122epsmtrp2q;
        Mon, 15 May 2023 04:06:07 +0000 (GMT)
X-AuditID: b6c32a39-bc3ff700000098dc-1a-6461afafad09
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.3F.28392.FAFA1646; Mon, 15 May 2023 13:06:07 +0900 (KST)
Received: from youngjingil02 (unknown [10.253.98.199]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230515040607epsmtip1c3948995a2a58a0f4b6d8539f13adb32~fNXYyda192828928289epsmtip1f;
        Mon, 15 May 2023 04:06:07 +0000 (GMT)
From:   "Yeongjin Gil" <youngjin.gil@samsung.com>
To:     "'Greg KH'" <gregkh@linuxfoundation.org>
Cc:     <stable@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        "'Mike Snitzer'" <snitzer@kernel.org>
In-Reply-To: <2023051508-payphone-dimly-b417@gregkh>
Subject: RE: [PATCH v2] dm verity: fix error handling for check_at_most_once
 on FEC
Date:   Mon, 15 May 2023 13:06:07 +0900
Message-ID: <001701d986e2$934c1cb0$b9e45610$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGmIPh3bC0J9cPI5sl/WkwIO9DdSgIVWPL/AlPPk8kCaiXaCa+K5pnw
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmvu769YkpBm0XTS2aF69ns9jy7wir
        xYlb0hYLNj5idGDx2LSqk81j/9w17B59W1YxenzeJBfAEtXAaJNYlJyRWZaqkJqXnJ+SmZdu
        qxQa4qZroaSQkV9cYqsUbWhopGdoYK5nZGSkZ2oUa2VkqqSQl5ibaqtUoQvVq6RQlFwAVJtb
        WQw0ICdVDyquV5yal+KQlV8KcqZecWJucWleul5yfq6SQlliTinQCCX9hG+MGQ0v5zAXHOCt
        uLqhn7WBsY27i5GTQ0LAROLps+dMXYxcHEICOxgljjZ3s0E4nxglzvS9Z4ZwPjNKLP50jA2m
        5cKjbnYQW0hgF6PEptlhEEWvGSXe/d7KDJJgE9CX+HXsHAuILSKgI9Fx5gSYzSxQIPH6wwuw
        QZxAg85uWAgU5+AQFgiVOPkxFiTMIqAq8engDbASXgFLiZ79vcwQtqDEyZlPoMbIS2x/O4cZ
        4h4Fid2fjrJCrHKTePHtPDtEjYjE7M42sAckBL6yS5y40c4O0eAi8bbxKyOELSzx6vgWqLiU
        xOd3e9kgGtoZJVY8nMMI4cxglPj7/j4rRJW9RHNrMxvI1cwCmhLrd+lDhBUldv6eywixmU/i
        3dceqHJBidPXuplByiUEeCU62oQgwmoSVyb9Yp3AqDwLyW+zkPw2C8kPsxCWLWBkWcUollpQ
        nJueWmxYYIoc4ZsYwYlUy3IH4/S3H/QOMTJxMB5ilOBgVhLhbZ8ZnyLEm5JYWZValB9fVJqT
        WnyIMRkY2hOZpUST84GpPK8k3tDMzNLC0sjE0NjM0JCwsImlgYmZkYmFsaWxmZI475en2ilC
        AumJJanZqakFqUUwW5g4OKUamJyFxF/YW56u2TRhaYlu3pL76QxmGh7usYnx0kmmIj0TH6gs
        uzglS6X+nWNgAU+9JWt3TUdNXrky83/36T+zZpk+Nf34ruGR/DQtgz3b5q2zDFMNL7vu8K3f
        TbosNet+5cf25MrA1kzTpIzLH6omb+/Y9+61ME/35WeWzrdrhRd9WpNa1szHWNCZfXxH7THW
        M48OyLqvuOK9o3dB5E+TRfqML5KE27KmdvYH7fl+JH3lO0mDPQcjdfhspqqXHvzxbVNh/nxR
        +9vvb3X2zIgRX+rXmLiO5cBprnq5J8GRvMfzXzbp6hwWr7OxaQvMjJr6v/mLz/YrLH/O198K
        i2/4M9/wp9H0LYu7+CxUT/9SYinOSDTUYi4qTgQAxsKTgFsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSnO769YkpBqu/y1s0L17PZrHl3xFW
        ixO3pC0WbHzE6MDisWlVJ5vH/rlr2D36tqxi9Pi8SS6AJYrLJiU1J7MstUjfLoEro+HlHOaC
        A7wVVzf0szYwtnF3MXJySAiYSFx41M3excjFISSwg1Hi3rtlbBAJGYk/E98D2RxAtrDE4cPF
        EDUvGSX6Fr5nAqlhE9CX+HXsHAuILSKgI9Fx5gSYzSxQJHHgzwIWiIYnjBKLt70GG8oJtO3s
        hoVgRcICwRJnF78Gs1kEVCU+HbwBVsMrYCnRs7+XGcIWlDg58wkLyBHMAnoSbRsZIebLS2x/
        O4cZ4k4Fid2fjrJC3OAm8eLbeXaIGhGJ2Z1tzBMYhWchmTQLYdIsJJNmIelYwMiyilEytaA4
        Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOEK0tHYw7ln1Qe8QIxMH4yFGCQ5mJRHe9pnxKUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwNRefEmZUVnq3
        PCPpYMeSzE2HucrqZnWHJP39fuFt+LbunKeF7Q9Kzrhvnc7wxHfaN/8CeaFFP5Yp/Tj+3jzl
        1bLHUn39N80nSpesFW6zVWE/tEf/oEb5fTvdm4tkOhTvcUzrFZSd1HpgQ+++AzL3Y8R+aYTe
        SVnwqXtWWJ56ls2C+ft1+VK41ltcfTh19/3d/29sYJWvn5izcC3vipu8m2bbxFpvvqJ7LSzM
        +SuvU8x5+d/nrhY/EzjIt/+XRqnMjJWBrw6+2zo3nNdspf37tYmudsv4Uhw43sw6/3RWt1ny
        igJ/uclalrMizR/Yr+TdX/j7OG/v2yITB88XZzg2VUze7csnrZN/5/6ybpZ/GkosxRmJhlrM
        RcWJACgEJiP/AgAA
X-CMS-MailID: 20230515040607epcas1p2312a701f1573700e8758a85ae29df98d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230515011823epcas1p2e05135dda9e7e159d637016d81d55abc
References: <2023050701-epileptic-unethical-f46c@gregkh>
        <CGME20230515011823epcas1p2e05135dda9e7e159d637016d81d55abc@epcas1p2.samsung.com>
        <20230515011816.25372-1-youngjin.gil@samsung.com>
        <2023051508-payphone-dimly-b417@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> On Mon, May 15, 2023 at 10:18:16AM +0900, Yeongjin Gil wrote:
> > In verity_end_io(), if bi_status is not BLK_STS_OK, it can be return
> > directly. But if FEC configured, it is desired to correct the data
> > page through verity_verify_io. And the return value will be converted
> > to blk_status and passed to verity_finish_io().
> >
> > BTW, when a bit is set in v->validated_blocks, verity_verify_io()
> > skips verification regardless of I/O error for the corresponding bio.
> > In this case, the I/O error could not be returned properly, and as a
> > result, there is a problem that abnormal data could be read for the
> > corresponding block.
> >
> > To fix this problem, when an I/O error occurs, do not skip
> > verification even if the bit related is set in v->validated_blocks.
> >
> > Fixes: 843f38d382b1 ("dm verity: add 'check_at_most_once' option to
> > only validate hashes once")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> > Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org> (cherry picked from
> > commit e8c5d45f82ce0c238a4817739892fe8897a3dcc3)
> 
> Why did you send this 3 times?
> 
> And what kernel(s) is this to be applied to?
> 
> confused,
I'm sorry for the confusion.

I've got patch failure mail 3 times from 4.19-stable, 5.4-stable,
5.10-stable.
So I replied to each mail after conflict resolution.
--in-reply-to '2023050708-verdict-proton-a5f0@gregkh'
--in-reply-to '2023050709-dry-stand-f81b@gregkh'
--in-reply-to '2023050701-epileptic-unethical-f46c@gregkh'

The stable kernel branches that I want to be applied are the above kernels.
> 
> greg k-h

