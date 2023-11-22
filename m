Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71AB7F3A9F
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 01:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjKVASB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 21 Nov 2023 19:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKVASA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 21 Nov 2023 19:18:00 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F71F4
        for <stable@vger.kernel.org>; Tue, 21 Nov 2023 16:17:57 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id 98e67ed59e1d1-28098ebd5aeso4970993a91.0
        for <stable@vger.kernel.org>; Tue, 21 Nov 2023 16:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700612276; x=1701217076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UHAcpvU+eVs0NsKFjWhxOoa97l9fKN/fj+2hBaE0nLQ=;
        b=INoQGanciceM/o3DPjJNJVa5HIPEru75kLOvgYUxGH1yQAg0Li/Rqj1evzx124/Wpw
         7EFlkkfHfWA/GOUWPItmJbueWzc4Wdks6GFH8iG7+ieElUxaOTitD+wRcudJwq3uUrCd
         e4S7gpPNVMbMiLj6qHy8RSL97luojkBpByAqlK2FF4OTrYr73So1vpsVlUwMruQXdrtg
         q+VdmMLiHbmkJ4TH/byUxi72tLvVk+KJbz5owEsbsEQTjmCF3MY3+U2jHOQ5+5lohQQw
         In3Tu3/KEz+AQt7VIZzj0+GUBmMuwJs48viqj32spUfxfwKji7nT5xsdKjqKxtXd1ouL
         IcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700612276; x=1701217076;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHAcpvU+eVs0NsKFjWhxOoa97l9fKN/fj+2hBaE0nLQ=;
        b=Hr1BtFLRXA0FhY+Vpd3p6VZqfc9IlLx6ayRhbKOyWJ3KxR4aieuOKpJAIkiI/qrRm1
         FpA386+auITWKd0A3nL6IYOm0f2kFk2YiqSVk+t4Kn7B7BktqV/u12OpS45h7Dv/iqNU
         QHMQtYuRQMHpBaib/GTeQdxiX1Tlb++vDRaX/9f1Cns/8SXcYnmRX6RJQNjC9pN3jXNx
         I5PiW4VdBFigPH/KvW2ahAKGW4fDWaxpclkR/Tco2UmfqX1bWO+vwE8tTs8obm/5KaIx
         +YAD7fe/jj5SVahArfNOP/Ib4cE2msBI5vrZtr9bcMTy1D8ImQ8npr5AX9az26V4AgqE
         A7lA==
X-Gm-Message-State: AOJu0YyVOpnukrvVHKeEppRBMcvf7UHErHp+0quUkUd3MhRw9t3YJHj2
        59PEB0Pg7wvIMWz3swj1xuU=
X-Google-Smtp-Source: AGHT+IHdTG1bdssvL0ItH/m2SWWyIRlteZKjU2+a0/kgWMy/s/iUya8vyiLYqh8SKJodmYSHP38V4A==
X-Received: by 2002:a17:90b:4a4e:b0:280:cd15:9684 with SMTP id lb14-20020a17090b4a4e00b00280cd159684mr1026246pjb.37.1700612276170;
        Tue, 21 Nov 2023 16:17:56 -0800 (PST)
Received: from [10.10.13.50] ([136.226.64.177])
        by smtp.gmail.com with ESMTPSA id jw11-20020a170903278b00b001cc3a6813f8sm8569741plb.154.2023.11.21.16.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 16:17:55 -0800 (PST)
Message-ID: <8b130415-4f70-495c-85dc-355e3cd2db17@gmail.com>
Date:   Tue, 21 Nov 2023 16:17:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 153/191] Input: xpad - add HyperX Clutch Gladiate
 Support
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
Content-Language: en-US
In-Reply-To: <9c3e4b65-4781-4d45-a270-f1b75dfb48d3@gmail.com>
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


On 11/20/2023 3:52 PM, Nguyen, Max wrote:
>
> On 11/18/2023 3:32 AM, Greg KH wrote:
>> On Fri, Nov 17, 2023 at 03:42:22PM -0800, Nguyen, Max wrote:
>>>> Hi,
>>>>
>>>> We would like to apply this patch to version 6.1 of the LTS branch.
>>>> This is to add a project ID for Android support for a gamepad
>>>> controller.  We would like it to apply sooner than waiting for the 
>>>> next
>>>> LTS branch due to project schedules.
>>>>
>>>> commite28a0974d749e5105d77233c0a84d35c37da047e
>>>>
>>>> Regards,
>>>>
>>>> Max
>>>>
>>> Hi Linux team,
>>>
>>> We would like to have this patch backported to LTS versions 4.19, 
>>> 5.4, 5.10,
>>> and 5.15 as well.  The main purpose would to add our device ID for 
>>> support
>>> across older android devices.  Feel free to let us know if there are 
>>> any
>>> concerns or issues.
>> Please provide a working backport that you have tested as I think it did
>> not apply cleanly on its own, right?
>>
>> thanks,
>>
>> greg k-h
>
> Hi Greg,
>
> Do you have any general suggestions or instructions on how I can 
> create a backport to test?  I apologize as this is new to me.
>
> Also, what do you mean by the patch did not apply cleanly on its own?
>
We found that the patch does not apply correctly to the previous LTS 
kernels.  This is most likely due to addition of newer devices over 
time.  We will be sending separate patches for each kernel shortly.
