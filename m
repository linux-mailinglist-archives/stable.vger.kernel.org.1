Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4986D7F5330
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 23:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbjKVWSX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 17:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343586AbjKVWSU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 17:18:20 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A013E1A5
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 14:18:15 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-6be0277c05bso320527b3a.0
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 14:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700691495; x=1701296295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M1SpqJqPEK0HKjMWOwWd0RTX2RpCriEx/eCEsJOAXHY=;
        b=mwuwztrKT1OdM+fua0Z12LtI+uP1szuQ2eJaYUO6yChQ2DHA3l0mhl080svab+W/ZU
         tv1uH5smZE1riYoGrRPLEtnZ/ENG+kFC352B4Gu18OMrDgutZ/8ONMFo3NdJGa2tvoTI
         ODEPUm4wE7v8tnRwQAPCoyDPt1qFr4190MUMLYp3MSmpq2zxSXhqlL+G9BW4mlmUPsXU
         KjgNilOjfqRRr6tM1O3eXC/s9TAbUvCEYse6ZuKnqekfah51WM/ieZ4DtP4nxiMhwiLk
         M4QzGU+XsxGQ8l5xAvrXAplGXVeNIHfW/1UbFeKT4BYMnGQYqMNXw42g8ypbB5D2YQkn
         +VfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700691495; x=1701296295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1SpqJqPEK0HKjMWOwWd0RTX2RpCriEx/eCEsJOAXHY=;
        b=kJHUI6A9/Le63/WUoFUkjlxseEUeOMoglTpWnCsauiVUQ9TvSRPZC+WaYu+Z0lWCGI
         rSOnXa666n7Jyc/SC6zEPGumPsKDQT+1q0qEg3M2jMqChtZfKWB29tLiEXZln9wXcrOE
         b/dujSLEODnUX0+jI/XEHATkwdmiF/089t6YiAYJEg3umib1aET5BpDoxnDO1bWK/37H
         hcFPYXe4a/1GVQ9uvvTTsR3GHDYVJUq1NIaEyq0qhN3CgjbQyEvOwKMbsOrgsEqU2u6d
         0OAKJqnaIVdorndOCVET35UJmYBu6/eZbNhtwOantmpchOVZ3hRHJFn8/SbLb0WgNP0/
         R17A==
X-Gm-Message-State: AOJu0YxojpzprP3/pQjRh89/OdplIJn6FSnoPobWYOdSf3hS11BS4m5N
        LKyNKHuOuwYJMN+UXV9IWe8=
X-Google-Smtp-Source: AGHT+IE9zFIQ6f/L9vM1NZnAtpU8Py+/aOWkpLQdguS0VkRDJ7gkoUA0V1/UNeLoPzZ8m6F6dhrf5Q==
X-Received: by 2002:a05:6a20:daa8:b0:188:569:855 with SMTP id iy40-20020a056a20daa800b0018805690855mr4769327pzb.51.1700691494922;
        Wed, 22 Nov 2023 14:18:14 -0800 (PST)
Received: from [10.10.13.50] ([104.129.198.116])
        by smtp.gmail.com with ESMTPSA id y34-20020a056a00182200b006cb88a284f0sm202890pfa.201.2023.11.22.14.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 14:18:14 -0800 (PST)
Message-ID: <3d7d9872-e569-4821-b0e2-39c8c7be53c9@gmail.com>
Date:   Wed, 22 Nov 2023 14:18:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 153/191] Input: xpad - add HyperX Clutch Gladiate
 Support
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
Content-Language: en-US
From:   "Nguyen, Max" <hphyperxdev@gmail.com>
In-Reply-To: <2023112205-viselike-barracuda-f0c6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On 11/21/2023 10:39 PM, Greg KH wrote:
> On Tue, Nov 21, 2023 at 04:17:54PM -0800, Nguyen, Max wrote:
>> On 11/20/2023 3:52 PM, Nguyen, Max wrote:
>>> On 11/18/2023 3:32 AM, Greg KH wrote:
>>>> On Fri, Nov 17, 2023 at 03:42:22PM -0800, Nguyen, Max wrote:
>>>>>> Hi,
>>>>>>
>>>>>> We would like to apply this patch to version 6.1 of the LTS branch.
>>>>>> This is to add a project ID for Android support for a gamepad
>>>>>> controller.  We would like it to apply sooner than waiting
>>>>>> for the next
>>>>>> LTS branch due to project schedules.
>>>>>>
>>>>>> commite28a0974d749e5105d77233c0a84d35c37da047e
>>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Max
>>>>>>
>>>>> Hi Linux team,
>>>>>
>>>>> We would like to have this patch backported to LTS versions
>>>>> 4.19, 5.4, 5.10,
>>>>> and 5.15 as well.  The main purpose would to add our device ID
>>>>> for support
>>>>> across older android devices.  Feel free to let us know if there
>>>>> are any
>>>>> concerns or issues.
>>>> Please provide a working backport that you have tested as I think it did
>>>> not apply cleanly on its own, right?
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>> Hi Greg,
>>>
>>> Do you have any general suggestions or instructions on how I can create
>>> a backport to test?  I apologize as this is new to me.
>>>
>>> Also, what do you mean by the patch did not apply cleanly on its own?
>>>
>> We found that the patch does not apply correctly to the previous LTS
>> kernels.  This is most likely due to addition of newer devices over time.
>> We will be sending separate patches for each kernel shortly.
> Why not send a series adding all of the missing backported patches?
> That makes it better so that all of the supported devices are now
> working on the older kernels, not just this one.
>
> thanks,
>
> greg k-h

Hi Greg,

I am planning to send a patch for LTS versions 4.19 through 5.15 since 
the single patch can apply to all of these versions with no issues.  I 
plan to send a separate patch for LTS 6.1 since this patch could not 
apply to the older LTS versions.

Is this what you had in mind when you mentioned series?

