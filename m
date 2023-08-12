Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC05077A18C
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 19:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjHLRyx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 13:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHLRyx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 13:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C62D10F2
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 10:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691862850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y6JMIceaTcnICqNcbaFYg3o1RLYMTBxxd2akh5qJtnM=;
        b=LKmrv0zq3j2c8OtBF56NR5S1J+nAHh5HWXPOiG7FJi/CtM5wnnh1D8fRagbmvk0Or6WoEf
        EQKTBHz1SbCt87pGZf7PRs1FrnNNca+Q0bqIwH5zaPB4zZ54jWESXPjPISpzVhgft9MD3d
        icTSouEVArwe2u5sWSvpxJOfeppaQrc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-0J20ApurMDua3rDV-gcvBQ-1; Sat, 12 Aug 2023 13:54:08 -0400
X-MC-Unique: 0J20ApurMDua3rDV-gcvBQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-99bca0b9234so183347066b.2
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 10:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691862847; x=1692467647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6JMIceaTcnICqNcbaFYg3o1RLYMTBxxd2akh5qJtnM=;
        b=dXQ4CUuqMX/jrb/gIhwr/2sFMP/VEm/bMewBuZSz1jk207qD5fVwsEtLmdw/TeXEpx
         CSyhIN4NxVdcikfiY5gqAbP80P/6dVmMZri7OhCex00heThG7Y4FIIL3rk7Bm/H4qvrs
         yhpMARrEjWTOq78ngGOFbvGoZiYmDL+R/panbxNA5H3FBQUo7z9CDlNoofS1n1nxdb2j
         6sWDBijOwspdZX5cpY6N20gXHPsowubJnlOrVejaYAvQi30qyoF0JAN0/tiqiFTZNvGB
         ixITd25798ue+DjexAfr6KRRHS7lfWKqKyBmnPEDkK8Eb7AQaA+51Sn1lCwhWUCLV1zq
         BVzw==
X-Gm-Message-State: AOJu0YzEBfRHfpQrRN5fxB28YGKp/JKWA9BenFj0g65iAx0DfUJPg20w
        TvgTrEzF2DFDuFuRoY+cga0+/97E6CyxDO9qXGBW76dKW6JXNQcuonY4K0UyzLHCp4O01lrRF2J
        hh3NQoRTkWzAPAkIo
X-Received: by 2002:a17:907:7886:b0:993:d7ff:afe7 with SMTP id ku6-20020a170907788600b00993d7ffafe7mr4652262ejc.13.1691862847517;
        Sat, 12 Aug 2023 10:54:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQBNa70+l4NheelS7z+OH5oUQe1f9+CSNWCNqySt7M+NRNof703pKOFK8hUlUiKsSuE2hE4A==
X-Received: by 2002:a17:907:7886:b0:993:d7ff:afe7 with SMTP id ku6-20020a170907788600b00993d7ffafe7mr4652252ejc.13.1691862847224;
        Sat, 12 Aug 2023 10:54:07 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090608cc00b00993004239a4sm3674515eje.215.2023.08.12.10.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 10:54:06 -0700 (PDT)
Message-ID: <bc324146-2ab3-9457-587c-89a3bcda7960@redhat.com>
Date:   Sat, 12 Aug 2023 19:54:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] platform/x86: lenovo-ymc: Only bind on machines with a
 convertible DMI chassis-type
To:     Andrew Kallmeyer <kallmeyeras@gmail.com>
Cc:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        platform-driver-x86@vger.kernel.org, Gergo Koteles <soyer@irl.hu>,
        =?UTF-8?Q?Andr=c3=a9_Apitzsch?= <git@apitzsch.eu>,
        stable@vger.kernel.org
References: <20230812144818.383230-1-hdegoede@redhat.com>
 <CAG4kvq8O1em-DJa6JucOtym-kNxPuGUa+zK8R8PqYPEu2nHBiw@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAG4kvq8O1em-DJa6JucOtym-kNxPuGUa+zK8R8PqYPEu2nHBiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On 8/12/23 19:25, Andrew Kallmeyer wrote:
> On Sat, Aug 12, 2023 at 7:48 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> The lenovo-ymc driver is causing the keyboard + touchpad to stop working
>> on some regular laptop models such as the Lenovo ThinkBook 13s G2 ITL 20V9.
>>
>> The problem is that there are YMC WMI GUID methods in the ACPI tables
>> of these laptops, despite them not being Yogas and lenovo-ymc loading
>> causes libinput to see a SW_TABLET_MODE switch with state 1.
>>
>> This in turn causes libinput to ignore events from the builtin keyboard
>> and touchpad, since it filters those out for a Yoga in tablet mode.
>>
>> Similar issues with false-positive SW_TABLET_MODE=1 reporting have
>> been seen with the intel-hid driver.
>>
>> Copy the intel-hid driver approach to fix this and only bind to the WMI
>> device on machines where the DMI chassis-type indicates the machine
>> is a convertible.
>>
>> Add a 'force' module parameter to allow overriding the chassis-type check
>> so that users can easily test if the YMC interface works on models which
>> report an unexpected chassis-type.
>>
>> Fixes: e82882cdd241 ("platform/x86: Add driver for Yoga Tablet Mode switch")
>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229373
>> Cc: Gergo Koteles <soyer@irl.hu>
>> Cc: Andrew Kallmeyer <kallmeyeras@gmail.com>
>> Cc: André Apitzsch <git@apitzsch.eu>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Too bad that this caused problems for some people. Thank you for
> getting it fixed Hans!
> 
> While I had trouble applying this patch as is (maybe the code has
> changed a bit since my patch), I was able to manually add these lines
> and test this fix on my laptop (Yoga 7 14AIL7). The new device was
> found and everything worked as expected.
> 
> Tested-by: Andrew Kallmeyer <kallmeyeras@gmail.com>

Great, thank you for the quick test.

Regards,

Hans



