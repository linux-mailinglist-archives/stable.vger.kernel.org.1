Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AB7758B07
	for <lists+stable@lfdr.de>; Wed, 19 Jul 2023 03:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjGSBvG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 18 Jul 2023 21:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGSBvF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 18 Jul 2023 21:51:05 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97851BDA
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 18:51:03 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-765942d497fso578176485a.1
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 18:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689731463; x=1692323463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8LIcee80TlFwkQItUqzVZWIorzXij+Cs/P+ayGlbYfg=;
        b=nQpSW0KGIsEys7dOcknaCVkqgPvE7Z7Xzyjonl00mfKUYto/Q0/BxgQ99EzOnltmCD
         AwI96gK1aUmcB4dkuD011hQYez4cZ4amUjIpU+iTYdBLfQIZ14mO1F9AvSfsdALCMlaM
         1iL7X3kleC4A5y/xnbjAYDaqjSudkQiXmbFbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689731463; x=1692323463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LIcee80TlFwkQItUqzVZWIorzXij+Cs/P+ayGlbYfg=;
        b=i29gSUTkaPud1XNek8az+rywdCT1c3WCQzwrStpGlgKVg7HqT+L4aAMLZ+n+K5iitq
         U3N/tIjcjaI/4dLi5QU1b4yKikmFEHnLQHuiDLetygf91an3AfXaklPsPLoHLPPya7C2
         alGgzuVBpGrfo1QuKM5TdPGtAJ47I/2A940phzFN595aH+I3YrcIYN7RWycLSqeB691J
         o9JSUxHz1hk7YfyBrwbJmr4FGuoFySfC0iQ5AgdWvswX6704Dn7LGG1XLLUYI+X7baRM
         RMJwmHJzn+mSKsDvlwJkIfTLxOvwEdUOjvJZ4XIQ3iT/pwBn4zIBLcwcH1AIlBG7ANmA
         315g==
X-Gm-Message-State: ABy/qLbArw1CKVH1CtYZH7W46YZ5AQLIhJhJXtVausrI6iL3+JfjMoot
        nF+c9jC64DB8Tq1QoDOA6Y+xJPNlyeI9KN67jzQ=
X-Google-Smtp-Source: APBJJlEFPeCQWouzb3yyuGIfxJmfhQzQ+SgxDKF1I4ZNGO8LBhrfn9NCrWqwli0h8s1TP+B8UrbhiQ==
X-Received: by 2002:a37:8707:0:b0:768:eff:cfb1 with SMTP id j7-20020a378707000000b007680effcfb1mr9033274qkd.42.1689731462936;
        Tue, 18 Jul 2023 18:51:02 -0700 (PDT)
Received: from [192.168.0.198] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id x1-20020a05620a14a100b00767da10efb6sm966879qkj.97.2023.07.18.18.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 18:51:02 -0700 (PDT)
Message-ID: <35203a19-1623-0fbd-d7f4-98bfa2d2f482@joelfernandes.org>
Date:   Tue, 18 Jul 2023 21:51:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Build failures / crashes in stable queue branches
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     stable <stable@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <897ebb05-5a1f-e353-8877-49721c52d065@roeck-us.net>
 <20230715154923.GA2193946@google.com>
 <907909df-d64f-e40a-0c9c-fc5c225a235c@huaweicloud.com>
 <2023071625-parsnip-pursuable-b5c8@gregkh>
 <da595585-4929-2c21-7e48-f9f8cdad6cf7@joelfernandes.org>
 <2023071840-hatchling-fiction-65a8@gregkh>
 <CAEXW_YR801_BhsevD0UjbXpt47H82=uX2oqcLoCo9pdW2NYOjw@mail.gmail.com>
 <af66a503-cc85-5690-0f17-708efafe338f@huaweicloud.com>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <af66a503-cc85-5690-0f17-708efafe338f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 7/18/23 21:16, Yu Kuai wrote:
> Hi,
> 
> 在 2023/07/19 1:14, Joel Fernandes 写道:
>> On Tue, Jul 18, 2023 at 10:45 AM Greg KH <gregkh@linuxfoundation.org> 
>> wrote:
>>>
>>> On Tue, Jul 18, 2023 at 09:52:45AM -0400, Joel Fernandes wrote:
>>>> On 7/16/23 10:30, Greg KH wrote:
>>>>> On Sun, Jul 16, 2023 at 11:20:33AM +0800, Yu Kuai wrote:
>>>>>> Hi,
>>>>>>
>>>>>> 在 2023/07/15 23:49, Joel Fernandes 写道:
>>>>>>> Hi Yu,
>>>>>>>
>>>>>>> On Fri, Jul 14, 2023 at 03:21:46AM -0700, Guenter Roeck wrote:
>>>>>>> [..]
>>>>>>>> ---------
>>>>>>>> 6.1.y:
>>>>>>>>
>>>>>>>> Build reference: v6.1.38-393-gb6386e7314b4
>>>>>>>> Compiler version: alpha-linux-gcc (GCC) 11.4.0
>>>>>>>> Assembler version: GNU assembler (GNU Binutils) 2.40
>>>>>>>>
>>>>>>>> Building alpha:allmodconfig ... failed
>>>>>>>> Building m68k:allmodconfig ... failed
>>>>>>>> --------------
>>>>>>>> Error log:
>>>>>>>> <stdin>:1517:2: warning: #warning syscall clone3 not implemented 
>>>>>>>> [-Wcpp]
>>>>>>>> In file included from block/genhd.c:28:
>>>>>>>> block/genhd.c: In function 'disk_release':
>>>>>>>> include/linux/blktrace_api.h:88:57: error: statement with no 
>>>>>>>> effect [-Werror=unused-value]
>>>>>>>>       88 | # define 
>>>>>>>> blk_trace_remove(q)                            (-ENOTTY)
>>>>>>>>          
>>>>>>>> |                                                         ^
>>>>>>>> block/genhd.c:1185:9: note: in expansion of macro 
>>>>>>>> 'blk_trace_remove'
>>>>>>>>     1185 |         blk_trace_remove(disk->queue);
>>>>>>>
>>>>>>> 6.1 stable is broken and gives build warning without:
>>>>>>>
>>>>>>> cbe7cff4a76b ("blktrace: use inline function for 
>>>>>>> blk_trace_remove() while blktrace is disabled")
>>>>>>>
>>>>>>> Could you please submit it to stable for 6.1? (I could have done 
>>>>>>> that but it
>>>>>>> looks like you already backported related patches so its best for 
>>>>>>> you to do
>>>>>>> it, thanks for your help!).
>>>>>>
>>>>>> Thanks for the notice, however, I'll suggest to revert this patch for
>>>>>> now, because there are follow up fixes that is not applied yet.
>>>>>
>>>>> Which specific patch should be dropped?
>>>>>
>>>>
>>>> Yu: Ping? ;-). Are you suggesting the original set be reverted, or Greg
>>>> apply the above fix? Let us please keep 6.1 stable unbroken. ;-)
>>>>
>>>> Apologies for my noise if the issue has already been resolved.
>>>
>>> I think it has been resolved, but testing against the latest -rc release
>>> I sent out yesterday would be appreciated.
>>
>> Great.  Sure, I am going to run it today.
> 
> Sorry about the trouble, currently this patch will cause that scsi host
> module can't be unloaded, and there are follow up fixes for this:
> 
> https://lore.kernel.org/all/20230621160111.1433521-1-yukuai1@huaweicloud.com/
> https://lore.kernel.org/all/20230705024001.177585-1-yukuai1@huaweicloud.com/
> 
> The second patch is not applied yet, either revert the original patch or
> apply the above fix to stable as well.

The latest 6.1 stable now builds so it is all good.

thanks,

  - Joel
