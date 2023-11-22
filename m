Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3BD7F5450
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 00:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjKVXKt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 18:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344480AbjKVXKs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 18:10:48 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EBD101
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 15:10:41 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1cf6af8588fso2517065ad.0
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 15:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700694641; x=1701299441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4VmGqLwu6+0aUcoKQWivq4WWqkcBsHai2MtZwYLGo3Q=;
        b=EUQ6XEwiMh8Lj0GcjWXfJBFAp36NNb6YiAd9O5ljEFpP42bbA1CXDhWsSDxQXDhe9w
         9euLnf6YMq1eKcvzd1BSr10kGX0RW3g0Mch2tgnZi/ouNF3psdn0t1OVheS+INrxGB1i
         uyCeeyPi+Rwbpht2HdRKB0GMqCxwhzohrw+bv4cFAuP4EBZEzqAtOsy1RXRwGDUePKE9
         VrSpn5Xernm2y5agJg8u1CuPL9dAaoNDWRn+FLhgIE2OmG725GHiQo+1QbiYdI53/yFM
         Ea7yVG8/xBgw5o9GKQvzHR3riOd6DGFGHG31Y8wJ/y5NOC5ivfWofIP1IMGrYZzdQP6c
         Nekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700694641; x=1701299441;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VmGqLwu6+0aUcoKQWivq4WWqkcBsHai2MtZwYLGo3Q=;
        b=RYOiCt5IjhpJrJkbLvzZxDpb5JDo6S8NJ0w04EJwLH9618iwO6UVfd0tP2EeySxiYd
         Akoe2raEy6NdIaA8BkR0ceVbof88fVkxSSgRBeZ2KC5fT2arR2y7DW6Ii3k/Lid0yIcZ
         gJJqdzBdQNEfzON9cQk6TDeh4r2Mcq2gBDm1Zs5Q034PWIOhYDEzXlnxnjhFF0hNwh2g
         /oBl2wy+ZP3XjBC0hXPq+3U0xhxO4V1iCSkswzFkAqVX3VzdRgcFQ8mtp/Z1oHdXR0Ro
         wZLLc7HYZbcBUO2dcmcS00P56V6p6THi448Iwno04zi3vzxLyo5D+00oo6qs8jx6oC2q
         cBWA==
X-Gm-Message-State: AOJu0Yzuh/8/zUUy/gZ2wauOhmO/Ipjed5mF8KGNZ7LUPCNs6Y1lqZFH
        FiO4BKp4xgVhTWj9F9ABzts=
X-Google-Smtp-Source: AGHT+IEKw1C90WRay6Mx6gyz36yJAUnjoXbMnogFREWLiEbxF27oLlQqvyaPTmw0O6sj2czeq08xwQ==
X-Received: by 2002:a17:902:e802:b0:1cf:7eec:86dc with SMTP id u2-20020a170902e80200b001cf7eec86dcmr1862890plg.23.1700694640957;
        Wed, 22 Nov 2023 15:10:40 -0800 (PST)
Received: from [10.10.13.50] ([104.129.198.116])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902f68c00b001c61901ed2esm209624plg.219.2023.11.22.15.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 15:10:40 -0800 (PST)
Message-ID: <0d6f1468-e10f-434c-aeb8-53b1c06ed289@gmail.com>
Date:   Wed, 22 Nov 2023 15:10:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 153/191] Input: xpad - add HyperX Clutch Gladiate
 Support
Content-Language: en-US
From:   "Nguyen, Max" <hphyperxdev@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, "Nguyen, Max" <maxwell.nguyen@hyperx.com>,
        carl.ng@hp.com
References: <20231016084015.400031271@linuxfoundation.org>
 <20231016084018.949398466@linuxfoundation.org>
 <MW4PR84MB17804D57BB57C0E2FB66EFC6EBADA@MW4PR84MB1780.NAMPRD84.PROD.OUTLOOK.COM>
 <MW4PR84MB178083997D411DFFD45BEFCDEBB7A@MW4PR84MB1780.NAMPRD84.PROD.OUTLOOK.COM>
 <6b2973c5-469a-4af8-995b-ee9196d0818b@gmail.com>
 <2023111814-impeach-sweep-aa30@gregkh>
 <9c3e4b65-4781-4d45-a270-f1b75dfb48d3@gmail.com>
 <8b130415-4f70-495c-85dc-355e3cd2db17@gmail.com>
 <2023112205-viselike-barracuda-f0c6@gregkh>
 <3d7d9872-e569-4821-b0e2-39c8c7be53c9@gmail.com>
In-Reply-To: <3d7d9872-e569-4821-b0e2-39c8c7be53c9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On 11/22/2023 2:18 PM, Nguyen, Max wrote:
>
> On 11/21/2023 10:39 PM, Greg KH wrote:
>> On Tue, Nov 21, 2023 at 04:17:54PM -0800, Nguyen, Max wrote:
>>> On 11/20/2023 3:52 PM, Nguyen, Max wrote:
>>>> On 11/18/2023 3:32 AM, Greg KH wrote:
>>>>> On Fri, Nov 17, 2023 at 03:42:22PM -0800, Nguyen, Max wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> We would like to apply this patch to version 6.1 of the LTS branch.
>>>>>>> This is to add a project ID for Android support for a gamepad
>>>>>>> controller.  We would like it to apply sooner than waiting
>>>>>>> for the next
>>>>>>> LTS branch due to project schedules.
>>>>>>>
>>>>>>> commite28a0974d749e5105d77233c0a84d35c37da047e
>>>>>>>
>>>>>>> Regards,
>>>>>>>
>>>>>>> Max
>>>>>>>
>>>>>> Hi Linux team,
>>>>>>
>>>>>> We would like to have this patch backported to LTS versions
>>>>>> 4.19, 5.4, 5.10,
>>>>>> and 5.15 as well.  The main purpose would to add our device ID
>>>>>> for support
>>>>>> across older android devices.  Feel free to let us know if there
>>>>>> are any
>>>>>> concerns or issues.
>>>>> Please provide a working backport that you have tested as I think 
>>>>> it did
>>>>> not apply cleanly on its own, right?
>>>>>
>>>>> thanks,
>>>>>
>>>>> greg k-h
>>>> Hi Greg,
>>>>
>>>> Do you have any general suggestions or instructions on how I can 
>>>> create
>>>> a backport to test?  I apologize as this is new to me.
>>>>
>>>> Also, what do you mean by the patch did not apply cleanly on its own?
>>>>
>>> We found that the patch does not apply correctly to the previous LTS
>>> kernels.  This is most likely due to addition of newer devices over 
>>> time.
>>> We will be sending separate patches for each kernel shortly.
>> Why not send a series adding all of the missing backported patches?
>> That makes it better so that all of the supported devices are now
>> working on the older kernels, not just this one.
>>
>> thanks,
>>
>> greg k-h
>
> Hi Greg,
>
> I am planning to send a patch for LTS versions 4.19 through 5.15 since 
> the single patch can apply to all of these versions with no issues.  I 
> plan to send a separate patch for LTS 6.1 since this patch could not 
> apply to the older LTS versions.
>
> Is this what you had in mind when you mentioned series?
>
I resent the patches as a series as described in the patch submission 
process on the kernel webpage.  I reviewed and believe it should be 
formatted correctly now.  Let me know if there are any issues.
