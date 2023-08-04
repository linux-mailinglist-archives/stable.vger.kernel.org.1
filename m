Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F3177004E
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 14:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjHDMeU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 08:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjHDMeQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 08:34:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF25E46B1
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 05:34:14 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHQ9G6WJkzrS0m;
        Fri,  4 Aug 2023 20:33:06 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 20:34:11 +0800
Message-ID: <071fe71c-7905-234a-384a-b86e73988849@huawei.com>
Date:   Fri, 4 Aug 2023 20:34:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 5.10 1/6] bpf: allow precision tracking for programs with
 subprogs
Content-Language: en-US
To:     Eduard Zingerman <eddyz87@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Pu Lehui <pulehui@huaweicloud.com>
CC:     <stable@vger.kernel.org>, Luiz Capitulino <luizcap@amazon.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20230801143700.1012887-1-pulehui@huaweicloud.com>
 <20230801143700.1012887-2-pulehui@huaweicloud.com>
 <2023080425-decline-chitchat-2075@gregkh>
 <412cc31a-0891-6c96-bc94-2e84cc0f57d7@huawei.com>
 <54d66dfa06580420383aefe4d43e8a7ce2bb4c2a.camel@gmail.com>
From:   Pu Lehui <pulehui@huawei.com>
In-Reply-To: <54d66dfa06580420383aefe4d43e8a7ce2bb4c2a.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 2023/8/4 20:18, Eduard Zingerman wrote:
> On Fri, 2023-08-04 at 20:15 +0800, Pu Lehui wrote:
>>
>> On 2023/8/4 18:33, Greg KH wrote:
>>> On Tue, Aug 01, 2023 at 10:36:55PM +0800, Pu Lehui wrote:
>>>> From: Andrii Nakryiko <andrii@kernel.org>
>>>>
>>>> [ Upstream commit be2ef8161572ec1973124ebc50f56dafc2925e07 ]
>>>
>>> For obvious reasons, I can't take this series only for 5.10 and not for
>>> 5.15, otherwise you would update your kernel and have a regression.
>>>
>>> So please, create a 5.15.y series also, and resend both of these, and
>>> then we will be glad to apply them.  For this series, I've dropped them
>>> from my review queue now.
>>>
>>
>> alright, it's fine for me. will send them soon.
> 
> Hi Pu,
> 
> I tried backporting to 5.15 and was unable to get all test_progs* green,
> because of necessity to pull in other conflicting commits.
> So, you strategy on backporting only sub-set relevant for this specific
> failure seems reasonable to me.

yep, actually, I'd prefer to backport the first 4 patches.

> 
> Thanks,
> Eduard.
> 
>>
>>> thanks,
>>>
>>> greg k-h
> 
