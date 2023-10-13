Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559C67C7D0C
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 07:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjJMFc6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 01:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJMFc6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 01:32:58 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F5FBC
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 22:32:54 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231013053251epoutp026f3e3e47d25871c57d03e85086b2331d~Nk9OZBjK62794127941epoutp02l
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 05:32:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231013053251epoutp026f3e3e47d25871c57d03e85086b2331d~Nk9OZBjK62794127941epoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697175171;
        bh=i6mQ53pmJmScjLHPFNSyagi2TiK5TeXO1gJWVu0BM0g=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=otEp5YndX8Qp2k9rzevhapIZxtdqupFw6AQ4TiGk/zqeieM2nBbMZuQA1Kxs+TQ8c
         joBmnuPg33Mq35kGI3UM8o+TOWs/fA0Gowd4jWT9afSuYsrxDhBES/o3hg5Gq/DdNx
         V+PSlWxn+IB+7/wT6PipaSfIU7WCazjVtatnakHY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231013053251epcas5p4c9203f4caa1f4d8717a1befe8aa1b4c9~Nk9N91k0C0425404254epcas5p4j;
        Fri, 13 Oct 2023 05:32:51 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4S6FX118Vgz4x9QG; Fri, 13 Oct
        2023 05:32:49 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.B5.09635.186D8256; Fri, 13 Oct 2023 14:32:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231013053248epcas5p40dfac6454e90700856fa7409bddc8b05~Nk9Lnn_n70425404254epcas5p4f;
        Fri, 13 Oct 2023 05:32:48 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231013053248epsmtrp235e58fd55f127844cf5b638ca505dff8~Nk9Lm01VG1605416054epsmtrp2_;
        Fri, 13 Oct 2023 05:32:48 +0000 (GMT)
X-AuditID: b6c32a4b-2f5ff700000025a3-ea-6528d681491f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.C5.08649.086D8256; Fri, 13 Oct 2023 14:32:48 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231013053246epsmtip184868320452015213afc7758b84a6951~Nk9KBpqiJ1388613886epsmtip1W;
        Fri, 13 Oct 2023 05:32:46 +0000 (GMT)
Message-ID: <fedb15f7-3986-12b3-599c-884e0381aff2@samsung.com>
Date:   Fri, 13 Oct 2023 11:02:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
Content-Language: en-US
To:     hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
From:   Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231013051458.39987-1-joshi.k@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmum7jNY1Ug+XLWSzWXPnNbrH6bj+b
        xcrVR5kszr89zGQx6dA1Rov5y56yW6x7/Z7FYsHGR4wWj7s7GC02tAk6cHnsnHWX3eP8vY0s
        HpfPlnpsWtXJ5rF5Sb3H7psNbB59W1YxenzeJBfAEZVtk5GamJJapJCal5yfkpmXbqvkHRzv
        HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
        Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2PV9n2MBa/YKp7s+cjUwHiUtYuRk0NC
        wETi5udHzF2MXBxCArsZJc5/W8EE4XxilNg+9QWU841R4trMWcwwLXsWLmaESOxllNjVPJMN
        wnnLKLF080RGkCpeATuJa3N+gi1hEVCVeHmsEyouKHFy5hMWEFtUIEni19U5YHFhATeJKauX
        gG1gFhCXuPVkPhOILSLgItHw7w3YNmaBZYwSO39sZO9i5OBgE9CUuDC5FKSGU8BSYu+zH4wQ
        vfIS29/OAXtIQmAHh8SBVVOhznaRWDn7BAuELSzx6vgWdghbSuLzu71sEHayxKWZ55gg7BKJ
        x3sOQtn2Eq2n+plB9jID7V2/Sx9iF59E7+8nTCBhCQFeiY42IYhqRYl7k55Cw1dc4uGMJVC2
        h8SOzbfBLhAS6GGUOHOWbQKjwiykUJmF5PtZSL6ZhbB4ASPLKkbJ1ILi3PTUYtMC47zUcniE
        J+fnbmIEJ2At7x2Mjx580DvEyMTBeIhRgoNZSYR3dpxGqhBvSmJlVWpRfnxRaU5q8SFGU2D0
        TGSWEk3OB+aAvJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamOq4
        z++LjX+o+Lli7bQte757l77eox/xec+u7V2v9bnKQhQuL/zz6tueFplrEjmzW2q3SG9uU5H3
        KrrleaU5KjfPp+ix8IMrc+IC5+7dJrXswqOGKNbCuITTv+rrjkvx31H68Cj+dPnNGwnJB9N5
        zYPFvafemZC87YrJpd4uKdbtYTKX5yrkJ3cmBYgFmR3beKLMJsRM99R/gUA7N2eFdfvVZBJu
        LA24v4unb4l16efAgkZ+3vrE1q7n1+3vtzMXPe6RFS44pf6Up/gse/Kdl6UZ1+7WZCUXPLat
        q5/guU3rus059mqlounH9msVbDd2rOereM/4xnfDl+lRLP6P6w4Yy07mPXvc95n4tPOySizF
        GYmGWsxFxYkA9cdrHkkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnG7DNY1Ug5d/ZS3WXPnNbrH6bj+b
        xcrVR5kszr89zGQx6dA1Rov5y56yW6x7/Z7FYsHGR4wWj7s7GC02tAk6cHnsnHWX3eP8vY0s
        HpfPlnpsWtXJ5rF5Sb3H7psNbB59W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CVsWr7PsaCV2wV
        T/Z8ZGpgPMraxcjJISFgIrFn4WJGEFtIYDejxPRZBRBxcYnmaz/YIWxhiZX/ngPZXEA1rxkl
        NrxcBdbAK2AncW3OT7BBLAKqEi+PdULFBSVOznzCAmKLCiRJ7LnfyARiCwu4SUxZvYQZxGYG
        WnDryXywuIiAi0TDvzeMIAuYBZYxShzY/oURYlsPo8TrIxOBVnNwsAloSlyYXArSwClgKbH3
        2Q9GiEFmEl1bu6BseYntb+cwT2AUmoXkjllI9s1C0jILScsCRpZVjJKpBcW56bnJhgWGeanl
        esWJucWleel6yfm5mxjB0aalsYPx3vx/eocYmTgYDzFKcDArifDOjtNIFeJNSaysSi3Kjy8q
        zUktPsQozcGiJM5rOGN2ipBAemJJanZqakFqEUyWiYNTqoFpw/WEtdvCPSL38IXsS1y62Opu
        67SfHx7opc/Y9Pbfs+3LV+xTUE24t8Whbs/OsLIyjjkKgfK7lh1+tOHDmVWheZuLEg/XPJ1V
        qbBMLFpKwnbHo4UahpXzLO3DXE5MO39iii7vzkLHjcE37fbWvxB63Liy7kWI6dojHxTfuxxv
        zCuRnJtW+nLJk2kKc4P0pFcrH87T0Pl/6No14f/b98SvbrRt+T7134T5T9quvbTw/vCQ2TTx
        mINxotmR847H/X/m2x3NE5rafeTkwy4GlUt7mBnvGv56YWHXYuIye9/pdZfF/CbqSU/87JZz
        Wn5FzDXOFnnph8c9ssVCXzrql7zK+MctFfNzeqT9zr/ac2ecfaHEUpyRaKjFXFScCAB37/ps
        JQMAAA==
X-CMS-MailID: 20231013053248epcas5p40dfac6454e90700856fa7409bddc8b05
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
        <20231013051458.39987-1-joshi.k@samsung.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/13/2023 10:44 AM, Kanchan Joshi wrote:
> User can specify a smaller meta buffer than what the device is
> wired to update/access. Kernel makes a copy of the meta buffer into
> which the device does DMA.
> As a result, the device overwrites the unrelated kernel memory, causing
> random kernel crashes.
> 
> Same issue is possible for extended-lba case also. When user specifies a
> short unaligned buffer, the kernel makes a copy and uses that for DMA.
> 
> Detect these situations and prevent corruption for unprivileged user
> passthrough. No change to status-quo for privileged/root user.
> 
> Fixes: 63263d60e0f9 ("nvme: Use metadata for passthrough commands")

Since change is only for unprivileged user, I should have changed this 
'Fixes:' to point to this patch instead:

5b7717f44b1 (nvme: fine-granular CAP_SYS_ADMIN for nvme io commands)
