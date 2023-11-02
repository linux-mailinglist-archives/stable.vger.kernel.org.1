Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD4C7DEED7
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 10:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbjKBJ2i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 05:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbjKBJ2i (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 05:28:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F7213A
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 02:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698917270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tNnRdsjxIC0iBF13rnXxYXRGCuFIpLMoaUg4RVC5gi4=;
        b=HFh4S4qQBEjPnd80fikOmFa5eHxm9k/iziJG61tPvlx2DzJZWSQtqCydgGWk0o2H9BBwCg
        UhM2vp+sVrIRiv/b72w+Y/a1Gm50iFvxv+g7Ylc7XwM17XDmlpHDkf4oEUhLHrwsJ4GAXr
        /K7mDOVvhmPG1o7WZOoXQWy1yReEttc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-jG-ceYoJOe2ZghYpRZVPOw-1; Thu, 02 Nov 2023 05:27:48 -0400
X-MC-Unique: jG-ceYoJOe2ZghYpRZVPOw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9d2946be350so50808066b.3
        for <stable@vger.kernel.org>; Thu, 02 Nov 2023 02:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698917267; x=1699522067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tNnRdsjxIC0iBF13rnXxYXRGCuFIpLMoaUg4RVC5gi4=;
        b=q+w4oeqchVWOcyNZRs+iWpTSA0e+22JC+srjiD9YcI/b/DMCRhfq0BpEyWCtkiQiGa
         dhNiHj1ag99ZOeeKCxh+w7Q8X2smKq3zF4LZPAq73IyXd+R59MF+KRB913IjiIeO1JIX
         cKNJK6AYtxk9Uw/MrdLZJLlPwuPSSVOPMp5vnpbe8PRriLSdSJYxM2HwVlaFAWkWRLRW
         Lq5jmNRq+/eyFNcoyausL75IE/zKnSjVo3NIGq1dMXfIRe9IpE/B0z/iO5lnv8iz5ZgR
         RJ9l65VioajzK0L9SQMzdV+T/xAUG7eeePPCTI8KsCC+d3PRrkPIjpTGTUtSjbBh4GFW
         6Hnw==
X-Gm-Message-State: AOJu0YxCvALdwMSgI3j4XaYgub1wu5CjbmLpMP4H+exC8nFCeh5A6fJ5
        ifU6YCsvGYzplTllog22ero/ZEAFJVBZ49pobYIYsJeQlZVgmUnfuELchzObSTyWB3KLqQv3pey
        SmgcKqr9D1hJ4t/Mb
X-Received: by 2002:a17:907:2d88:b0:9bf:60f9:9b7f with SMTP id gt8-20020a1709072d8800b009bf60f99b7fmr4438594ejc.4.1698917267452;
        Thu, 02 Nov 2023 02:27:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVdAJMGW2RRxLPpnz3wxf4NHyOv5Vi3xoLsv4GlevlSUnY98+4XGswJk8A1rKNWNoc53brKw==
X-Received: by 2002:a17:907:2d88:b0:9bf:60f9:9b7f with SMTP id gt8-20020a1709072d8800b009bf60f99b7fmr4438581ejc.4.1698917267004;
        Thu, 02 Nov 2023 02:27:47 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id v9-20020a1709060b4900b009cc1e8ed7c5sm895859ejg.133.2023.11.02.02.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 02:27:46 -0700 (PDT)
Message-ID: <597e7a7f-06e9-6f6f-2b27-1fa02ca046ad@redhat.com>
Date:   Thu, 2 Nov 2023 10:27:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] media: v4l2-cci: Add support for little-endian
 encoded registers
Content-Language: en-US, nl
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-media@vger.kernel.org,
        Alain Volmat <alain.volmat@foss.st.com>, stable@vger.kernel.org
References: <20231101122354.270453-1-alexander.stein@ew.tq-group.com>
 <20231102012217.GC5933@pendragon.ideasonboard.com>
 <ZUNCFESRnKMwkHl7@kekkonen.localdomain> <4980064.31r3eYUQgx@steina-w>
 <ZUNc-LRZiotD3OsK@kekkonen.localdomain>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZUNc-LRZiotD3OsK@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On 11/2/23 09:25, Sakari Ailus wrote:
> Hi Alexander,
> 
> On Thu, Nov 02, 2023 at 08:51:12AM +0100, Alexander Stein wrote:
>> Hi,
>>
>> thanks for the feedback.
>>
>> Am Donnerstag, 2. November 2023, 07:30:44 CET schrieb Sakari Ailus:
>>> Hi Laurent,
>>>
>>> On Thu, Nov 02, 2023 at 03:22:17AM +0200, Laurent Pinchart wrote:
>>>> Hi Alexander,
>>>>
>>>> Thank you for the patch.
>>>>
>>>> On Wed, Nov 01, 2023 at 01:23:53PM +0100, Alexander Stein wrote:
>>>>> Some sensors, e.g. Sony, are using little-endian registers. Add support
>>>>> for
>>>>
>>>> I would write Sony IMX290 here, as there are Sony sensors that use big
>>>> endian.
>>>
>>> Almost all of them. There are a few exceptions indeed. This seems to be a
>>> bug.
>>
>> Let's name IMX290 here as an actual example. No need to worry about other 
>> models here.
>>
>>>>> those by encoding the endianess into Bit 20 of the register address.
>>>>>
>>>>> Fixes: af73323b97702 ("media: imx290: Convert to new CCI register access
>>>>> helpers") Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>>>>> ---
>>>>>
>>>>>  drivers/media/v4l2-core/v4l2-cci.c | 44 ++++++++++++++++++++++++------
>>>>>  include/media/v4l2-cci.h           |  5 ++++
>>>>>  2 files changed, 41 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/media/v4l2-core/v4l2-cci.c
>>>>> b/drivers/media/v4l2-core/v4l2-cci.c index bc2dbec019b04..673637b67bf67
>>>>> 100644
>>>>> --- a/drivers/media/v4l2-core/v4l2-cci.c
>>>>> +++ b/drivers/media/v4l2-core/v4l2-cci.c
>>>>> @@ -18,6 +18,7 @@
>>>>>
>>>>>  int cci_read(struct regmap *map, u32 reg, u64 *val, int *err)
>>>>>  {
>>>>>
>>>>> +	bool little_endian;
>>>>>
>>>>>  	unsigned int len;
>>>>>  	u8 buf[8];
>>>>>  	int ret;
>>>>>
>>>>> @@ -25,6 +26,7 @@ int cci_read(struct regmap *map, u32 reg, u64 *val,
>>>>> int *err)> > 
>>>>>  	if (err && *err)
>>>>>  	
>>>>>  		return *err;
>>>>>
>>>>> +	little_endian = reg & CCI_REG_LE;
>>>>
>>>> You could initialize the variable when declaring it. Same below.
>>>
>>> I was thinking of the same, but then it'd be logical to move initialisation
>>> of all related variables there. reg is modified here though. I'd keep
>>> setting little_endian here. If someone wants to move it, that could be done
>>> in a separate patch.
>>>
>>>>>  	len = FIELD_GET(CCI_REG_WIDTH_MASK, reg);
>>>>>  	reg = FIELD_GET(CCI_REG_ADDR_MASK, reg);
>>>>>
>>>>> @@ -40,16 +42,28 @@ int cci_read(struct regmap *map, u32 reg, u64 *val,
>>>>> int *err)> > 
>>>>>  		*val = buf[0];
>>>>>  		break;
>>>>>  	
>>>>>  	case 2:
>>>>> -		*val = get_unaligned_be16(buf);
>>>>> +		if (little_endian)
>>>>> +			*val = get_unaligned_le16(buf);
>>>>> +		else
>>>>> +			*val = get_unaligned_be16(buf);
>>>>
>>>> Unrelated to this patch, isn't buf aligned to a 4 bytes boundary ?
>>>
>>> Very probably, as it's right after len that's an unsigned int. Adding
>>> __aligned(8) would ensure we don't need any of the unaligned variants, and
>>> most likely would keep the stack layout as-is.
>>
>> You mean something like this?
>>
>> u8 __aligned(8) buf[8];
>> [...]
>> if (little_endian)
>> 	*val = le64_to_cpup(buf);
>> else
>> 	*val = be64_to_cpup(buf);
>>
>> But what about 24 Bits? There is no le24_to_cpup. I would rather use the same 
>> API for all cases.
> 
> The aligned APIs are much better choice when you can use them. The 24 bit
> case can remain special IMO.
> 
>>
>>> Or... how about putting it in an union with a u64? That would mean it's
>>> accessible as u64 alignment-wise while the alignment itself is up to the
>>> ABI. A comment would be good to have probably.
>>
>> An additional union seems a bit too much here. Unless something suitable 
>> already exists for general usage.
> 
> I think it's nicer than using __aligned() as you get ABI alignment that
> way, not something you force manually --- that's a bit crude.
> 
> I wonder that others think.

I'm fine with adding the __aligned(8) and switching the non 24 bit
cases to helpers which assume alignment. The most important note
I have is that that is a separate improvement from this series though.

So this should be done in a follow-up patch which is not Cc: stable .

Regards,

Hans


