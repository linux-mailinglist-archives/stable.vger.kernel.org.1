Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0C577B1CB
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 08:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjHNGpZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 14 Aug 2023 02:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjHNGpE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 Aug 2023 02:45:04 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806D9E62
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 23:44:58 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230814064456epoutp03303099ab356a6b2b3895e41eacadc718~7LPBk8FEW1116011160epoutp03C
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 06:44:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230814064456epoutp03303099ab356a6b2b3895e41eacadc718~7LPBk8FEW1116011160epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691995496;
        bh=+iQsm3hfosqQmSkkVmr8crzsyxw2qkaqPu3if0KTuPs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Khs7o0HNeyMJqVm/1mz4p0/1sWAUK1Gee87OQZ4MoxB8swZCh7zNaVg5vcN5vqQWg
         OltzAn0pQuZHTHXaK4IiAM1ZIPLcaFDTRx/SQfgcj30aSGLrrvN6hKrF5ydiNwM5Xq
         dQ6aofVMdIviSh96WehEewx1lAv8UCFjJ7sJx6s4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230814064455epcas5p2a013c18a7c6d8fae918c9f73ae09215b~7LPBImR6v2656526565epcas5p20;
        Mon, 14 Aug 2023 06:44:55 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RPPys5pCkz4x9Q9; Mon, 14 Aug
        2023 06:44:53 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.6D.55522.56DC9D46; Mon, 14 Aug 2023 15:44:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230814064453epcas5p216e308e567a0657e7a519c71c604031c~7LO-EcToY2429724297epcas5p2-;
        Mon, 14 Aug 2023 06:44:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230814064453epsmtrp116f50861ab0be9ab0e924c5a6f70a49e~7LO-Drfcl2107721077epsmtrp1F;
        Mon, 14 Aug 2023 06:44:53 +0000 (GMT)
X-AuditID: b6c32a49-67ffa7000000d8e2-70-64d9cd65ead4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.30.34491.56DC9D46; Mon, 14 Aug 2023 15:44:53 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230814064451epsmtip20e0d856471a8a7cdbc5c08f3623ecc0b~7LO87bWky1020810208epsmtip2-;
        Mon, 14 Aug 2023 06:44:50 +0000 (GMT)
Date:   Mon, 14 Aug 2023 12:11:30 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com, gost.dev@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH 1/2] nvme: fix memory corruption for passthrough
 metadata
Message-ID: <20230814064130.GA6702@green245>
MIME-Version: 1.0
In-Reply-To: <ZNZogPZtHsxi1S10@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmum7q2ZspBi9W61msufKb3WL13X42
        i5sHdjJZrFx9lMni/NvDTBaTDl1jtJi/7Cm7xbrX71ksFmx8xGjxuLuD0WJDm6ADt8fOWXfZ
        Pc7f28jicflsqcemVZ1sHpuX1HvsvtnA5tG3ZRWjx+dNcgEcUdk2GamJKalFCql5yfkpmXnp
        tkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBnKimUJeaUAoUCEouLlfTtbIryS0tS
        FTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM95MvsFcsJmrYtG0t+wNjLs5
        uhg5OSQETCRerTzB0sXIxSEksJtRomvnRHYI5xOjxITVXawQzjdGiZWvT7LAtFzY/wWqZS+j
        xNIju5ggnGeMErtbu5hAqlgEVCV+blvE3MXIwcEmoClxYXIpSFhEQFni7vyZYFOZBd4C1b9/
        xQySEBbwl7i8uhXM5hXQkWj6+5cVwhaUODnzCdhmTgF7idnH14LFRYEGHdh2nAnioi0cEk2b
        tUB2SQi4SOzsY4QIC0u8Or6FHcKWknjZ3wZlJ0tcmnkOqrVE4vGeg1C2vUTrqX6wE5gFMiQW
        7HnGBmHzSfT+fsIEMZ5XoqNNCKJcUeLepKesELa4xMMZS6BsD4kVZ/dCw+cDo0Tn62NMExjl
        ZiH5ZhaSFRC2lUTnhybWWUArmAWkJZb/44AwNSXW79JfwMi6ilEytaA4Nz212LTAMC+1HB7H
        yfm5mxjBCVfLcwfj3Qcf9A4xMnEwHmKU4GBWEuG95X4tRYg3JbGyKrUoP76oNCe1+BCjKTB2
        JjJLiSbnA1N+Xkm8oYmlgYmZmZmJpbGZoZI47+vWuSlCAumJJanZqakFqUUwfUwcnFINTAL/
        vxQxlSTd/W2wsUaR4caFEtUg2zKHY4e9mLbE5PIJ33vFrJ1Zqyr5PellX8XJMN+Sh99tzr1/
        LfLl6FK794//rtYonR1QcTuQXU3kpeZP8/8rY+q26DLdV71i9L+xwWgjm3/O5R2lM2U6ZP8I
        8V+q/7m5a5aZlKnQpNmMiTvK95xfYPDyuuLeFcVeZ3d4HXqnMfFZl6m2svYTydtvdorO9Vqh
        tL0nLmmC04QXs5YLOsssjHwQs27JwfxzzytOl/rnccY+fztNOF7uRnaH4hTBZ7mT3aYuvfGi
        X8yDOabhQvhmMYf6y2rdrHxLj5k/MtsoV9Cr0LNN91p07iH1030Od87O/TkpwGpZ440NHEos
        xRmJhlrMRcWJADmQnuNBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSvG7q2ZspBr/m8VisufKb3WL13X42
        i5sHdjJZrFx9lMni/NvDTBaTDl1jtJi/7Cm7xbrX71ksFmx8xGjxuLuD0WJDm6ADt8fOWXfZ
        Pc7f28jicflsqcemVZ1sHpuX1HvsvtnA5tG3ZRWjx+dNcgEcUVw2Kak5mWWpRfp2CVwZLSv7
        2Aqeslec/TaPvYGxna2LkZNDQsBE4sL+LyxdjFwcQgK7GSVuzXjFCJEQl2i+9oMdwhaWWPnv
        OTtE0RNGia83rrKCJFgEVCV+blvE3MXIwcEmoClxYXIpSFhEQFni7vyZrCD1zAJvGSV2v3/F
        DJIQFvCVeL38GwuIzSugI9H09y8rxNAPjBJvNj5mgkgISpyc+QSsiFnATGLe5odgC5gFpCWW
        /+MACXMK2EvMPr4W7AZRoGUHth1nmsAoOAtJ9ywk3bMQuhcwMq9ilEwtKM5Nzy02LDDMSy3X
        K07MLS7NS9dLzs/dxAiOIi3NHYzbV33QO8TIxMF4iFGCg1lJhPeW+7UUId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rziL3pThATSE0tSs1NTC1KLYLJMHJxSDUxHv/SyG5w5nNg1Vzp75dN2mf/z
        vz94ID/hsPIx8cO2DwsEtNyXfNQL5fvEWvqjL/ijkvHOeXFs0Uvs3+74skj/1J91u/X5hdo3
        fD3ctuSqetO5EHbRHatX1r+8ZyjywOZi77P+H6eS08uuhamt7alb4NJS+UvpdGjr0ba+63kb
        mK3u7z6efuhY25Q7K6YJZ5lHHy/lm/GyXtaxbrt7dPrDraLPNhTM3yc6yaW5/P6pn5NDe5K7
        i+f++WLc/OeAwMXcV+xS2dtq9yzuuM/ia/ftVHffm5ae2q0Tfi+/Llbl265yrJXTWevDOTkr
        701OAU57dy68mchhw3krlsFoQ4qU+YtJJnO2KZpsWCLdcIBLiaU4I9FQi7moOBEAjcWFsBED
        AAA=
X-CMS-MailID: 20230814064453epcas5p216e308e567a0657e7a519c71c604031c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----gE6680ZNUinvX0c6ClraybDZwn8mhhmyVsG0uFNlX7QT91ZL=_532d1_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811160454epcas5p2635d208557749a2431b99c27b30a727f
References: <20230811155906.15883-1-joshi.k@samsung.com>
        <CGME20230811160454epcas5p2635d208557749a2431b99c27b30a727f@epcas5p2.samsung.com>
        <20230811155906.15883-2-joshi.k@samsung.com>
        <ZNZogPZtHsxi1S10@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

------gE6680ZNUinvX0c6ClraybDZwn8mhhmyVsG0uFNlX7QT91ZL=_532d1_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Aug 11, 2023 at 10:57:36AM -0600, Keith Busch wrote:
>On Fri, Aug 11, 2023 at 09:29:05PM +0530, Kanchan Joshi wrote:
>> +static bool nvme_validate_passthru_meta(struct nvme_ctrl *ctrl,
>> +					struct nvme_ns *ns,
>> +					struct nvme_command *c,
>> +					__u64 meta, __u32 meta_len)
>> +{
>> +	/*
>> +	 * User may specify smaller meta-buffer with a larger data-buffer.
>> +	 * Driver allocated meta buffer will also be small.
>> +	 * Device can do larger dma into that, overwriting unrelated kernel
>> +	 * memory.
>> +	 */
>> +	if (ns && (meta_len || meta)) {
>> +		u16 nlb = lower_16_bits(le32_to_cpu(c->common.cdw12));
>> +
>> +		if (meta_len != (nlb + 1) * ns->ms) {
>> +			dev_err(ctrl->device,
>> +			"%s: metadata length does not match!\n", current->comm);
>> +			return false;
>> +		}
>
>Don't you need to check the command PRINFO PRACT bit to know if metadata
>length is striped/generated on the controller side?

Good point. Will add that check in v2.

------gE6680ZNUinvX0c6ClraybDZwn8mhhmyVsG0uFNlX7QT91ZL=_532d1_
Content-Type: text/plain; charset="utf-8"


------gE6680ZNUinvX0c6ClraybDZwn8mhhmyVsG0uFNlX7QT91ZL=_532d1_--
