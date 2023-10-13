Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B0F7C885C
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 17:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjJMPMJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 11:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjJMPMH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 11:12:07 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7859FC9
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 08:12:05 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231013151202epoutp03746146ca76a478a9ff0491b4e0f5bf3b~Ns26Z3afB2109621096epoutp03d
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 15:12:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231013151202epoutp03746146ca76a478a9ff0491b4e0f5bf3b~Ns26Z3afB2109621096epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697209922;
        bh=qnMnyohs5nmJISS97BmHCgDxl7EvhWJv5GDMuDHFoIk=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=IsmkH4u6JbRarYT3MtzkoJV129yFbvYLtOTdwyB72nSakC6hRl0yTlXVogDC4zSoZ
         vlGksLGOoW6SL9WwoemHGL+oCmLypLK+C2a4ENKHZPCRKqJkkMM6rTIKIWBXIc8WmP
         1LOuhP+mNFXNtYMmRAIcRFoAY4G4338hOlyveIB0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231013151201epcas5p328b7013d003d9597e10f6102dc8788b4~Ns25j7-Tz3175431754epcas5p3O;
        Fri, 13 Oct 2023 15:12:01 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4S6VNH4KnVz4x9Pq; Fri, 13 Oct
        2023 15:11:59 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.D0.09023.F3E59256; Sat, 14 Oct 2023 00:11:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231013151158epcas5p1bf7625abf71b63019c2886adde3e7326~Ns2258faz2248722487epcas5p1L;
        Fri, 13 Oct 2023 15:11:58 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231013151158epsmtrp11f7ea7543f7273dce6b5edbc64d74bef~Ns225Qh1v0144901449epsmtrp1D;
        Fri, 13 Oct 2023 15:11:58 +0000 (GMT)
X-AuditID: b6c32a44-a21ff7000000233f-93-65295e3fa21f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.CC.08649.E3E59256; Sat, 14 Oct 2023 00:11:58 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231013151156epsmtip1deb7f9c4144840f6831c85303040f4c1~Ns2078PPn2293722937epsmtip16;
        Fri, 13 Oct 2023 15:11:55 +0000 (GMT)
Message-ID: <3438f3b8-f7d4-f0bd-44ef-7efb09ed6151@samsung.com>
Date:   Fri, 13 Oct 2023 20:41:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
From:   Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <ZSlL-6Oa5J9duahR@kbusch-mbp>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmuq59nGaqwcTnchZrrvxmt1h9t5/N
        YuXqo0wW598eZrKYdOgao8X8ZU/ZLda9fs9isWDjI0aLx90djBYb2gQduDx2zrrL7nH+3kYW
        j8tnSz02repk89i8pN5j980GNo++LasYPT5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53
        jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6UEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xi
        q5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnbHiv3vBfu6Kf28XsjUwTubsYuTkkBAw
        kfi05S9TFyMXh5DAbkaJQ5cWQDmfGCWez1jHCOF8Y5Q48HY2K0zLx7tLWCASe4Gqlv5jhXDe
        Mkq03f/KDlLFK2AnsWftJrAOFgFViU/NX1gh4oISJ2c+YQGxRQWSJH5dncMIYgsLuElMWb2E
        GcRmFhCXuPVkPhOILSKgLHF3/kywBcwCrxkl7jSdBiri4GAT0JS4MLkUpIZTQEvi3boOFohe
        eYntb+cwg9RLCGzhkDj1+TETxNkuEl/vPGaBsIUlXh3fwg5hS0m87G+DspMlLs08B1VfIvF4
        z0Eo216i9VQ/2F5moL3rd+lD7OKT6P39hAkkLCHAK9HRJgRRrShxb9JTaGCJSzycsQTK9pDY
        sfk2NOAamCQubfrAPIFRYRZSsMxC8v4sJO/MQti8gJFlFaNkakFxbnpqsmmBYV5qOTzCk/Nz
        NzGCE7CWyw7GG/P/6R1iZOJgPMQowcGsJMI7O04jVYg3JbGyKrUoP76oNCe1+BCjKTB+JjJL
        iSbnA3NAXkm8oYmlgYmZmZmJpbGZoZI47+vWuSlCAumJJanZqakFqUUwfUwcnFINTMuVVx2Z
        K6PuVno6USmFX0Gd5d/kSHXu6p/Hut9oizksuOm2auaK37/2ij//aNvJ4DK7zl/sxDKfDQ5B
        6z9q2jxW6DAV1o3c9/OB/aEDsusa4t+G6Zz2Sax7t+mCEL9m/A5OQTGDSame2mEWL/Rf/lW4
        pL6i7J5c/iWJzyp/2LZJTMiJdqx6eP37As/VeVOtvicy9/Jz7mt5ErrTpfvx0m3vw5/rMLY/
        WvFD/sLm5+cmHi5kzT8UJrnKPznriVbc4po7ZX+n3n++syxg8bwb3iy3YqanLzTT35fs/D16
        5Te249fvb3nt0TvzyHoukbqn388pbdg0cy9TwO7VZ0s6Tkhv3yhxr7TAT3nym8vz0jYosRRn
        JBpqMRcVJwIAn49hz0kEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnK5dnGaqwZSzIhZrrvxmt1h9t5/N
        YuXqo0wW598eZrKYdOgao8X8ZU/ZLda9fs9isWDjI0aLx90djBYb2gQduDx2zrrL7nH+3kYW
        j8tnSz02repk89i8pN5j980GNo++LasYPT5vkgvgiOKySUnNySxLLdK3S+DKWPHfvWA/d8W/
        twvZGhgnc3YxcnJICJhIfLy7hKWLkYtDSGA3o8T1u+eZIRLiEs3XfrBD2MISK/89Z4coes0o
        8eDdDrAEr4CdxJ61m1hBbBYBVYlPzV9YIeKCEidnPmEBsUUFkiT23G9kArGFBdwkpqxeAraA
        GWjBrSfzweIiAsoSd+fPZAVZwAyyYNq566wQ2xqYJPb3P2DrYuTgYBPQlLgwuRSkgVNAS+Ld
        ug4WiEFmEl1buxghbHmJ7W/nME9gFJqF5I5ZSPbNQtIyC0nLAkaWVYySqQXFuem5yYYFhnmp
        5XrFibnFpXnpesn5uZsYwdGmpbGD8d78f3qHGJk4GA8xSnAwK4nwzo7TSBXiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOazhjdoqQQHpiSWp2ampBahFMlomDU6qBSS+D58e1Gyo/uDwY7daU5yZq
        F2Ss1hR0Et0/cW5g0umLltwnmlbUzF52Qk26Ze9fUcPPb49ILggLv+dcf22qn1PJ87cn7uYV
        /i0Rjz4Z+bM83Hguz6xSqwyZdUs4XETW9e95wWBjcV1OouDJbAfFiuL7eZZ14r165X0mS3cq
        CCw8bS38p6Ex6vPB1iD5MyvZO7/O4A9Zr31+X6b0LIPsb6L6YewKfTvCbJftk2Hg/H3olc7+
        ZtnYlBNzTP1F1DVc1CXmrtoWJyzy1Y9lT6XQ1RiFzvDO9Sk3Dy78vbOuWdVv7W/bnQXtKhrT
        5INq8uL1rh3blO9x5KHGyZtvVrvtyGzbwegnteAEMGHszFNiKc5INNRiLipOBAC6cSpHJQMA
        AA==
X-CMS-MailID: 20231013151158epcas5p1bf7625abf71b63019c2886adde3e7326
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
        <20231013051458.39987-1-joshi.k@samsung.com> <20231013052612.GA6423@lst.de>
        <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com>
        <ZSlL-6Oa5J9duahR@kbusch-mbp>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/13/2023 7:24 PM, Keith Busch wrote:
> On Fri, Oct 13, 2023 at 03:44:38PM +0530, Kanchan Joshi wrote:
>> On 10/13/2023 10:56 AM, Christoph Hellwig wrote:
>>> On Fri, Oct 13, 2023 at 10:44:58AM +0530, Kanchan Joshi wrote:
>>>> Changes since v3:
>>>> - Block only unprivileged user
>>>
>>> That's not really what at least I had in mind.  I'd much rather
>>> completely disable unprivileged passthrough for now as an easy
>>> backportable patch.  And then only re-enable it later in a way
>>> where it does require using SGLs for all data transfers.
>>>
>>
>> I did not get how forcing SGLs can solve the issue at hand.
>> The problem happened because (i) user specified short buffer/len, and
>> (ii) kernel allocated buffer. Whether the buffer is fed to device using
>> PRP or SGL does not seem to solve the large DMA problem.
> 
> The problem is a disconnect between the buffer size provided and the
> implied size of the command. The idea with SGL is that it requires an
> explicit buffer size, so the device will know the buffer is short and
> return an appropriate error.

Thanks for clearing this up.
It seems we will have two limitations with this approach - (i) sgl for 
the external metadata buffer, and (ii) using sgl for data-transfer will 
reduce the speed of passthrough io, perhaps more than what can happen 
using the checks. And if we make the sgl opt-in, that means leaving the 
hole for the case when this was not chosen.
