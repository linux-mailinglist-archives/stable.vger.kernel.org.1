Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83C97C4AAE
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 08:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345262AbjJKGdR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 02:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345373AbjJKGdM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 02:33:12 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46761A4
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 23:33:09 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231011063305epoutp0132e3feac4acd68c6160abd0148e9beff~M_fPLEI7w0849908499epoutp01J
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 06:33:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231011063305epoutp0132e3feac4acd68c6160abd0148e9beff~M_fPLEI7w0849908499epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697005985;
        bh=39QUOq9DLQ98d/L3BJKn7BT42RQyrSqp/nbGy8Q1AZY=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=Yu1G2oLLiThvRBU9vaMAQYxnNWN0ZavVW41H5TSqeCbG7lWJdPpImr9IAzhLhlFXD
         xPWKN2hM4Va+/BrN/g4rKD/da8IjydxiDLQWbi8n+DPGSdFMwNHmZXAnWdTfCDpLkn
         TPr2H7uCQZExyDh+57LYBGtJk8KfUGZeZt3Fyg7E=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231011063304epcas5p485b2132bae666b71d842403795246940~M_fOd_UWV2758527585epcas5p4U;
        Wed, 11 Oct 2023 06:33:04 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp3.localdomain
        (Postfix) with ESMTP id 4S52yS27j1z4x9Px; Wed, 11 Oct 2023 06:33:04 +0000
        (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20231011052647epcas5p3397e527e1f558363c68439abd69a5fde~M9lWURS432356923569epcas5p3t;
        Wed, 11 Oct 2023 05:26:47 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231011052647epsmtrp274729fca33ca3ea48e27ee13395994f5~M9lWTc_Cn2667626676epsmtrp2U;
        Wed, 11 Oct 2023 05:26:47 +0000 (GMT)
X-AuditID: b6c32a52-205ff700000049e4-6e-65263216c589
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.21.18916.61236256; Wed, 11 Oct 2023 14:26:46 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231011052645epsmtip28508b1e1a1962790a367d95f29f3164f~M9lUwLVFP1964119641epsmtip2u;
        Wed, 11 Oct 2023 05:26:45 +0000 (GMT)
Message-ID: <1296674576.21697005984297.JavaMail.epsvc@epcpadp4>
Date:   Wed, 11 Oct 2023 10:56:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshiiitr@gmail.com>
Cc:     kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, cpgs@samsung.com, stable@vger.kernel.org,
        Vincent Fu <vincent.fu@samsung.com>
From:   Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231011050254.GA32444@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSvK6YkVqqwYO3lhZrrvxmt1h9t5/N
        4uUhTYuVq48yWZx/e5jJYtKha4wW85c9ZbdY9/o9i8WCjY8YLR53dzBabGgTdOD22DnrLrvH
        +XsbWTwuny312LSqk81j85J6j903G9g8+rasYvT4vEkugCOKyyYlNSezLLVI3y6BK6N56jLG
        gkWcFS9bF7A2MPaxdzFyckgImEhMOvgQzBYS2M4o8WiPHURcXKL52g+oGmGJlf+eA9lcQDWv
        GSWOt/wHS/AK2Enc29wFZrMIqErM+byVCSIuKHFy5hMWEFtUIEliz/1GsLiwgI/E4kWzGEFs
        ZqAFt57MB4uLCLhL7L64nBlkAbPAbaAjnsxmhdg2l0li5S2QSRwcbAKaEhcml4I0cAroSEze
        v5AVYpCZRNfWLqih8hLb385hnsAoNAvJHbOQ7JuFpGUWkpYFjCyrGEVTC4pz03OTCwz1ihNz
        i0vz0vWS83M3MYKjTStoB+Oy9X/1DjEycTAeYpTgYFYS4X2UqZIqxJuSWFmVWpQfX1Sak1p8
        iFGag0VJnFc5pzNFSCA9sSQ1OzW1ILUIJsvEwSnVwKTven+p3gp5Hpt9rz+ePSa4yu+ehjND
        Wf7ioG+iVz8uWeQ0xehC7wlf/7gshl/m4ZGXpkcvEY/8cKVEesOemig5F49cpWd8u159MOJ/
        EDkna35Zg4zes8mmTZ/U/m/9+7u9lqVmughXZONbo11P8mK1zRao5OrqvHt38b/lIdl5EwJC
        TvMYVNz+mVky551Hzur35n5CB5a825U4Z+KEqGvholbds25NdTL4kL66mu/vyR3Fdq++31ma
        xNG3XFve40NEL0d6t0rt/WPbWL4EV5t1S656kpe0pr9l3rJNHPHf/7rFfPv50N21j2Fimvil
        3EOPG0xPFZ3248i/tyGe5224gsH/nN+5ThIFQcv8tyixFGckGmoxFxUnAgA3PgqyJQMAAA==
X-CMS-MailID: 20231011052647epcas5p3397e527e1f558363c68439abd69a5fde
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20231006135322epcas5p1c9acf38b04f35017181c715c706281dc
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com>
        <1891546521.01696823881551.JavaMail.epsvc@epcpadp4>
        <20231010074634.GA6514@lst.de>
        <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com>
        <20231011050254.GA32444@lst.de>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/11/2023 10:32 AM, Christoph Hellwig wrote:
>> Just that I was not sure on (i) whether to go back that far in
>> history, and (ii) what patch to tag.
> 
> I think the one that adds the original problem is:
> 
> 63263d60e0f9f37bfd5e6a1e83a62f0e62fc459f
> Author: Keith Busch <kbusch@kernel.org>
> Date:   Tue Aug 29 17:46:04 2017 -0400
> 
>      nvme: Use metadata for passthrough commands

Thanks.

> 
>>>> +     /* Exclude commands that do not have nlb in cdw12 */
>>>> +     if (!nvme_nlb_in_cdw12(c->common.opcode))
>>>> +             return true;
>>>
>>> So we can still get exactly the same corruption for all commands that
>>> are not known?  That's not a very safe way to deal with the issue..
>>
>> Given the way things are in NVMe, I do not find a better way.
>> Maybe another day for commands that do (or can do) things very
>> differently for nlb and PI representation.
> 
> Fixing just a subset of these problems is pointless.  If people want
> to use metadata on vendor specific commands they need to work with
> NVMe to figure out a generic way to pass the length.

Do you suggest that vendor specific opcodes should be blocked here?


