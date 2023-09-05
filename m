Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970657924E1
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 18:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjIEQAH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 12:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351474AbjIEFWI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 01:22:08 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFE1CCB
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 22:22:02 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230905052159epoutp0475659f66f0fb75d38225f9f7b993d0cf~B6S4xdpAi3152231522epoutp04u
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 05:21:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230905052159epoutp0475659f66f0fb75d38225f9f7b993d0cf~B6S4xdpAi3152231522epoutp04u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693891319;
        bh=ZSzpqw7io+vpYe7EpNqzOEdGMoJyUNbsKrAI4ciskw0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SZznal1v57XoVUbvf7cbvm+PlJUG4wwoTHkcyXIEYtdmsIMmgGsUobMVHqHQjvfuF
         mHuhCikjG69B+G1iQ2RZoSif3PIpkOADRx8jEOdyVwJzBAOv991wSXnAruhJYevvKt
         /oYlKKuvM631yyG+iC8orvNx6dMujpKUEKIxTb5g=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230905052159epcas5p3eff3cdd0a3a7de947f93b10e6d05eb55~B6S4VVw6z1914119141epcas5p3L;
        Tue,  5 Sep 2023 05:21:59 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Rfv511L0Zz4x9QG; Tue,  5 Sep
        2023 05:21:57 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.D6.09023.4FAB6F46; Tue,  5 Sep 2023 14:21:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230905052156epcas5p1cff7df2bcffc5e5080d29cda8c17a238~B6S2N4vZx0731107311epcas5p1c;
        Tue,  5 Sep 2023 05:21:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230905052156epsmtrp15732e50abf0e2f396688ab2168ee34c1~B6S2NG5F_0392903929epsmtrp1s;
        Tue,  5 Sep 2023 05:21:56 +0000 (GMT)
X-AuditID: b6c32a44-29b9ca800000233f-44-64f6baf46cc1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.36.08788.4FAB6F46; Tue,  5 Sep 2023 14:21:56 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230905052155epsmtip1831d670128ddcbba66c44a3a36785744~B6S0pUlE81025010250epsmtip1v;
        Tue,  5 Sep 2023 05:21:54 +0000 (GMT)
Date:   Tue, 5 Sep 2023 10:48:25 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com, gost.dev@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v2 1/2] nvme: fix memory corruption for passthrough
 metadata
Message-ID: <20230905051825.GA4073@green245>
MIME-Version: 1.0
In-Reply-To: <ZPH5Hjsqntn7tBCh@kbusch-mbp>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmhu7XXd9SDM6vZbZYc+U3u8Xqu/1s
        FjcP7GSyWLn6KJPF+beHmSwmHbrGaDF/2VN2i3Wv37NYLNj4iNHicXcHo8WGNkEHbo+ds+6y
        e5y/t5HF4/LZUo9NqzrZPDYvqffYfbOBzaNvyypGj8+b5AI4orJtMlITU1KLFFLzkvNTMvPS
        bZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DOVFIoS8wpBQoFJBYXK+nb2RTll5ak
        KmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ/z/sI2xYLNoxdpzm5kbGA8I
        djFyckgImEgsXbWBGcQWEtjNKDFvUUQXIxeQ/YlR4tCuxawQzjdGiYVTFrDBdKzd9R4qsZdR
        Ys26H2wQzjNGif4tR1hAqlgEVCSm7FzM3sXIwcEmoClxYXIpSFhEQFni7vyZYM3MAm8ZJXa/
        fwW2W1ggSGLJ/j52EJtXQEdiwdZ9zBC2oMTJmU/AZnIKaEk83HyPEcQWBRp0YNtxJpBBEgJr
        OSSen77NBrJMQsBF4sj1PIhLhSVeHd/CDmFLSbzsb4OykyUuzTzHBGGXSDzecxDKtpdoPdUP
        tpdZIEPi4ZXbjBA2n0Tv7ydMEON5JTrahCDKFSXuTXrKCmGLSzycsQTK9pC4vGwqMyRMbjNK
        vFiznHkCo9wsJO/MQrICwraS6PzQxDoLaAWzgLTE8n8cEKamxPpd+gsYWVcxSqYWFOempyab
        FhjmpZbD4zg5P3cTIzjharnsYLwx/5/eIUYmDsZDjBIczEoivO/kv6UI8aYkVlalFuXHF5Xm
        pBYfYjQFRs9EZinR5Hxgys8riTc0sTQwMTMzM7E0NjNUEud93To3RUggPbEkNTs1tSC1CKaP
        iYNTqoGpzrk3wUP52deCLfpXdb+f8eg7MKVFebLhzpmK/NJKmgpN+mrCf9ef9xe9OGfl4pUz
        CgVUfwTmW6xZ2/XrbLWm21ueO0LhbQoaXxj/6f6Qbq1Tmqsw8bvVYtmVCu+/lR49sCsu3ttO
        w33RoYP7V1aqG006/W/rwk13n205lVe8551VcvVHJ3vlX3mVDN62K/fP7CnxspmuG/UxYj/L
        hAT/4u0pfBvulvVf2N99fJehgYPa59z6mQ+nfb5R3fCg8t3XmZveFPFGFQu+3DF5yyyjkKAf
        p7Qkw152Mvype5+R7bPveXKL7N/Dk7NFe7zupqvznHitcYBdMFdXSdBK6u+sqadWPfIP29Ls
        4Foa9fytEktxRqKhFnNRcSIA/rqMHEEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSnO6XXd9SDKY/VrFYc+U3u8Xqu/1s
        FjcP7GSyWLn6KJPF+beHmSwmHbrGaDF/2VN2i3Wv37NYLNj4iNHicXcHo8WGNkEHbo+ds+6y
        e5y/t5HF4/LZUo9NqzrZPDYvqffYfbOBzaNvyypGj8+b5AI4orhsUlJzMstSi/TtErgyjm87
        zljwVKhi0Z3JzA2MPfxdjJwcEgImEmt3vWftYuTiEBLYzSgxueMIM0RCXKL52g92CFtYYuW/
        5+wQRU8YJbZM2QaWYBFQkZiyczGQzcHBJqApcWFyKUhYREBZ4u78mWBDmQXeMkrsfv8KbKiw
        QJDEkv19YL28AjoSC7buY4YYepdR4u3sHawQCUGJkzOfsIDYzAJmEvM2P2QGWcAsIC2x/B8H
        SJhTQEvi4eZ7jCC2KNCyA9uOM01gFJyFpHsWku5ZCN0LGJlXMUqmFhTnpucWGxYY5aWW6xUn
        5haX5qXrJefnbmIER5GW1g7GPas+6B1iZOJgPMQowcGsJML7Tv5bihBvSmJlVWpRfnxRaU5q
        8SFGaQ4WJXHeb697U4QE0hNLUrNTUwtSi2CyTBycUg1M23vdjc9EnFyd2N0rqH785/EvWzQ3
        v9A4e+mIdeCibSfv7th1MuGNltdzr6vtzdyXdrw4tU1j3/22FUaegZ//Za9+lH1wpbe43sUQ
        5qDfjzuEKvcXuZf51XFmHdCZOf1i04movZfn1jcW7Jr+0/vA3f0zbt96WMhVlNFn1uP95mZ6
        8vOpnts8fdff80pety5ccTJ3ghrD7p1WrDduzRNY9HzP2n2/u1ce972y/LC7p2LQ/mibDt31
        aYpXl8eaJOZzfwlwMrLnLok+zxm45U0X+2O5psRKC2EbrWS90qqqnO19i24t0ZMICDfX97RU
        8tY6+vXL1j2i69NVzR5dkJWSFv9R4WW3bU72R67TtccZlViKMxINtZiLihMBtMqsRhEDAAA=
X-CMS-MailID: 20230905052156epcas5p1cff7df2bcffc5e5080d29cda8c17a238
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_be2e1_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230814070548epcas5p34eb8f36ab460ee2bf55030ce856844b9
References: <20230814070213.161033-1-joshi.k@samsung.com>
        <CGME20230814070548epcas5p34eb8f36ab460ee2bf55030ce856844b9@epcas5p3.samsung.com>
        <20230814070213.161033-2-joshi.k@samsung.com> <ZPH5Hjsqntn7tBCh@kbusch-mbp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

------nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_be2e1_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Sep 01, 2023 at 10:45:50AM -0400, Keith Busch wrote:
>On Mon, Aug 14, 2023 at 12:32:12PM +0530, Kanchan Joshi wrote:
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
>
>What if the user doesn't specify metadata or length for a command that
>uses it? The driver won't set MPTR in that case, causing the device to
>access NULL.

That is fine, because kernel is not going to allocate memory for that
case. I am not trying to provide any saftey net to user-space in this
patch. Rather, the objective is to prevent kernel-memory corruption.

>And similiar to this problem, what if the metadata is extended rather
>than separate, and the user's buffer is too short? That will lead to the
>same type of problem you're trying to fix here?

No.
For extended metadata, userspace is using its own buffer. Since
intermediate kernel buffer does not exist, I do not have a problem to
solve.

>My main concern, though, is forward and backward compatibility. Even
>when metadata is enabled, there are IO commands that don't touch it, so
>some tool that erroneously requested it will stop working. Or perhaps
>some other future opcode will have some other metadata use that doesn't
>match up exactly with how read/write/compare/append use it. As much as
>I'd like to avoid bad user commands from crashing, these kinds of checks
>can become problematic for maintenance. 

For forward compatibility - if we have commands that need to specify
metadata in a different way (than what is possible from this interface),
we anyway need a new passthrough command structure.
Moreover, it's really about caring _only_ for cases when kernel allocates
memory for metadata. And those cases are specific (i.e., when
metadata and metalen are not zero). We don't have to think in terms of
opcode (existing or future), no?

For backward comptability, should we care about erroneous tools.
My concern is we currenly have a hole that can be exploited to affect
other sane applications and bring the kernel down to its knees.

------nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_be2e1_
Content-Type: text/plain; charset="utf-8"


------nvFln8z3L_krFSQI_duuyTsYVGNcxCMU6qftyQwhOSKtHzaF=_be2e1_--
