Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1077C82C6
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 12:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjJMKOx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 06:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjJMKOv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 06:14:51 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ECFA9
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 03:14:49 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231013101445epoutp023fe3ae31789c887657dda66bcb1db573~NozWnpNO23188531885epoutp02C
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 10:14:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231013101445epoutp023fe3ae31789c887657dda66bcb1db573~NozWnpNO23188531885epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697192085;
        bh=sAdsrcy47KgvtkQqo+Eoi6qGMV6FSrM+SBH+rU2sZ9A=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=UCNrX41MnEbKCo3Xx55t1c2xCIfVsFS1s04P+nU11ZDOHZLL8wkz43VxYoE5lSKOZ
         KokTC3f85kkrtOniyHSK50wvt0cK8s6b561CQDdGceI1vv/nDaF7iembM8PRsTWPUh
         9xiAk4lNamniOPWKOu3Xu54VFfxlr7Wr1DOdmwsg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231013101444epcas5p4be0502dc3f69d9b2699b01b520623ce6~NozVsL3zm1661116611epcas5p4x;
        Fri, 13 Oct 2023 10:14:44 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4S6MnG3Sk6z4x9Pr; Fri, 13 Oct
        2023 10:14:42 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.3D.09638.29819256; Fri, 13 Oct 2023 19:14:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20231013101442epcas5p3a38926de76ca3720e5a63ad22800ccb9~NozTdR4K73104731047epcas5p32;
        Fri, 13 Oct 2023 10:14:42 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231013101442epsmtrp1ca4abffbe4275810de738a4cd4ede26d~NozTcjpTc2720427204epsmtrp1x;
        Fri, 13 Oct 2023 10:14:42 +0000 (GMT)
X-AuditID: b6c32a4a-92df9700000025a6-c2-652918928def
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.D8.18916.19819256; Fri, 13 Oct 2023 19:14:41 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231013101439epsmtip188630c337170fe35772c9012e38a2f5f~NozRgHYgk2167721677epsmtip1c;
        Fri, 13 Oct 2023 10:14:39 +0000 (GMT)
Message-ID: <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com>
Date:   Fri, 13 Oct 2023 15:44:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
From:   Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231013052612.GA6423@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmpu4kCc1Ug41TJCzWXPnNbrH6bj+b
        xcrVR5kszr89zGQx6dA1Rov5y56yW6x7/Z7FYsHGR4wWj7s7GC02tAk6cHnsnHWX3eP8vY0s
        HpfPlnpsWtXJ5rF5Sb3H7psNbB59W1YxenzeJBfAEZVtk5GamJJapJCal5yfkpmXbqvkHRzv
        HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
        Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+P+sbuMBUdZK3o2TmJtYNzA0sXIySEh
        YCKx4uxKIJuLQ0hgN6PEyUeXoZxPjBJtR5cgOKeP9zHBtPSefs0OkdjJKLHm/hMmCOcto8Tt
        57/YQKp4Bewkjv1qYgaxWQRUJd43H2CEiAtKnJz5BGy5qECSxK+rc8DiwgJuElNWLwGrZxYQ
        l7j1ZD7YNhEBJYmnr84yQsTvMUosvG3excjBwSagKXFhcilImFNAW2L37ncsECXyEtvfzmEG
        uUdCYC2HxPwpV9ggrnaROHd/FSOELSzx6vgWdghbSuJlfxuUnSxxaeY5qC9LJB7vOQhl20u0
        nupnBtnLDLR3/S59iF18Er2/QX7nACrhlehoE4KoVpS4N+kpK4QtLvFwxhIo20Nix+bb0ABd
        zSixaMVq5gmMCrOQQmUWku9nIXlnFsLmBYwsqxglUwuKc9NTi00LjPJSy+ERnpyfu4kRnIC1
        vHYwPnzwQe8QIxMH4yFGCQ5mJRHe2XEaqUK8KYmVValF+fFFpTmpxYcYTYHRM5FZSjQ5H5gD
        8kriDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi4JRqYPJjOXB/5f2pm9fq
        +/JVr/fT/vDRoa7HdN/RFVsTP57fs/Kt7WuHLX96F5SWd7JW/crKTZnqcUY+6/ABLp91DtPP
        7hXmuncp+VRidG3ky9PPn3MLNLYnXavT39ea/+tEfoil7JG5HEmv3l+xviTQ/fltx+q4O6Xp
        9pN+SOU+MXvoc8NAxvejZNWp7UeqJqtreXAcrOAO257wRumpQbB//8MbuzPr9kywUSs/ES//
        Ma5g6nEDV2bG/8a/u5M8TrDNXWP1ap+txuMF19fIei1+dF5gm/EmeW2nWTYTSppmfXxeUV56
        OHDrnqayza3sL3vO7jDItvy42GbxUj2OuVr7Wp5KLz8wd3G1jKUXX97UrnYlluKMREMt5qLi
        RACT3ZKTSQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJTneihGaqwe5ZZhZrrvxmt1h9t5/N
        YuXqo0wW598eZrKYdOgao8X8ZU/ZLda9fs9isWDjI0aLx90djBYb2gQduDx2zrrL7nH+3kYW
        j8tnSz02repk89i8pN5j980GNo++LasYPT5vkgvgiOKySUnNySxLLdK3S+DKuH/sLmPBUdaK
        no2TWBsYN7B0MXJySAiYSPSefs3excjFISSwnVGiceUfZoiEuETztR/sELawxMp/z6GKXjNK
        /Dz0jBUkwStgJ3HsVxNYA4uAqsT75gOMEHFBiZMzn4BtEBVIkthzv5EJxBYWcJOYsnoJWD0z
        0IJbT+aDxUUElCSevjrLCLKAWeAeo8TdLzuhtq1mlLgz7xfQJA4ONgFNiQuTS0EaOAW0JXbv
        fscCMchMomtrFyOELS+x/e0c5gmMQrOQ3DELyb5ZSFpmIWlZwMiyilE0taA4Nz03ucBQrzgx
        t7g0L10vOT93EyM4zrSCdjAuW/9X7xAjEwfjIUYJDmYlEd7ZcRqpQrwpiZVVqUX58UWlOanF
        hxilOViUxHmVczpThATSE0tSs1NTC1KLYLJMHJxSDUxr3jW5anuePzT9yD2zSX++PF2yW7uw
        +NeK2Pgdy4QWpBwtyXxmfzekp3bdl7/VBXy3rjZdYz956VU5w4Gy5XPC84W5eZJd6yJuSdVY
        6dkk/pq9maFTjj3f7fmN1oeMctWfisM4Cx9oy1X/1GW1ntURJlKxae1tr6lffikJTNDbkp/S
        8JN7xgoBX6mlfFP2X3WKP/bpdd/tIMfD1h9Xmt/ZFL9QmeN+8PnWSQGaO+ZOMpc/pfnx1/Fz
        eyd2q315uOn6CZEHtbPE0mNu+xtkbJXccm09V9p3yV7GVWKn5x2WmGzdkzjX/e2PYve3R27X
        22xVWuW9nvPlmduit5YoXZwkmiCT+azk6uGTf9t6n0/8psRSnJFoqMVcVJwIADMlDB4iAwAA
X-CMS-MailID: 20231013101442epcas5p3a38926de76ca3720e5a63ad22800ccb9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
        <20231013051458.39987-1-joshi.k@samsung.com> <20231013052612.GA6423@lst.de>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/13/2023 10:56 AM, Christoph Hellwig wrote:
> On Fri, Oct 13, 2023 at 10:44:58AM +0530, Kanchan Joshi wrote:
>> Changes since v3:
>> - Block only unprivileged user
> 
> That's not really what at least I had in mind.  I'd much rather
> completely disable unprivileged passthrough for now as an easy
> backportable patch.  And then only re-enable it later in a way
> where it does require using SGLs for all data transfers.
> 

I did not get how forcing SGLs can solve the issue at hand.
The problem happened because (i) user specified short buffer/len, and 
(ii) kernel allocated buffer. Whether the buffer is fed to device using 
PRP or SGL does not seem to solve the large DMA problem.

