Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5142E772C0A
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 19:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjHGRG6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 13:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjHGRG5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 13:06:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F8C10D3
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 10:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691427968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+2bN+2QbGhq9h0FHi3A5aylDZ5TKWQyD8uS1jfBItL4=;
        b=IjWTKmeBkSjOgaG2p1Uo+FlNwkC4hEc83VPhTOOZpHtHY9X8JOEM3PCiGP3czWkscQp/um
        cMpPp+KsQ0zJ9BBT8owFWqPt8u8t5C03NKJugxk80RmkWJJ038IJgueAomzNmDL0yVwyyi
        ucvqsvK/U3mkM2wk1r0NHSayYCXVSws=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-HF7san1eOMW0drC_kEzjuw-1; Mon, 07 Aug 2023 13:06:06 -0400
X-MC-Unique: HF7san1eOMW0drC_kEzjuw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9b820c94fso52382571fa.2
        for <stable@vger.kernel.org>; Mon, 07 Aug 2023 10:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427965; x=1692032765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2bN+2QbGhq9h0FHi3A5aylDZ5TKWQyD8uS1jfBItL4=;
        b=cMCc3VHfLnNFeIEGpWHPlYe7f0QH7hmHlIgjqN8YOraM2X2G2cdX2P4ydH7/xYeV6o
         Cb0MFkpWYUZ9nn56rQkdBA3KxqV72e8cYyMUq3LKESqklP1KG9flRFlS1vfri6qCT1M9
         w2yLp8H9sPP4H+cUEDgNqRHMv4RtJ4ImTI1ZcMVjdRNb6uZJEWybQohie0vKM+MZkGpF
         nJx83/IPyxTybXSYZl9U/y9VfJKKfNVeNPwwILOz7WukG4jykbg4URA/o7Sw32cpgSe3
         9sj5WFZ6+e4gVDUUUhx91+1VT9UeAmapZTvEmdL1O7wSAc6V63WiQRd7dcMtElzgMtve
         i5wg==
X-Gm-Message-State: AOJu0YxxEjNIuvZMRCWHXFovvpZkDT0X7UTdd+94tc69EhyKdj21tWg/
        F6/fwJVEKqByU3WGwDuIGgR3IgCRiP8pZm7ddfQDUhCp8U5oBYfNMz1TOSu39AEfflbYSsA4MZR
        1Jj1j6n1IqOSMmUWz
X-Received: by 2002:a2e:8217:0:b0:2b6:d89e:74e2 with SMTP id w23-20020a2e8217000000b002b6d89e74e2mr6992769ljg.7.1691427965187;
        Mon, 07 Aug 2023 10:06:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT6vpsfSh0sALnDAZfqbKoc9EuWhKIUBNCSHBxjjTNtvISnhm4ewvF4pKaE0IzxDH4L2Oxvw==
X-Received: by 2002:a2e:8217:0:b0:2b6:d89e:74e2 with SMTP id w23-20020a2e8217000000b002b6d89e74e2mr6992748ljg.7.1691427964796;
        Mon, 07 Aug 2023 10:06:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090624c100b0098de7d28c34sm5459701ejb.193.2023.08.07.10.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 10:06:04 -0700 (PDT)
Message-ID: <4fae943f-6e72-3297-cc73-e1087e7a45bd@redhat.com>
Date:   Mon, 7 Aug 2023 19:06:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ACPI: resource: revert "Remove "Zen" specific match and
 quirks"
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, August Wikerfors <git@augustwikerfors.se>
References: <20230806151453.10690-1-hdegoede@redhat.com>
 <130cb2e0-90b4-7d7b-1633-3469c859b30f@amd.com>
 <b37098da-4437-ef5b-53ae-a536f550df08@redhat.com>
 <0c1cb09a-2e78-65ad-61c1-174e5226d08e@amd.com>
 <8f0cbe61-99aa-8c45-c29e-69c27ba96d81@redhat.com>
 <561f0807-a78c-4dab-b8ef-a0f0836902d9@amd.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <561f0807-a78c-4dab-b8ef-a0f0836902d9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On 8/7/23 13:39, Mario Limonciello wrote:
>>> We haven't even given a try to fixing it; I think the revert is still hasty.
>>>
>>> I don't have a machine that can reproduce this failure, but I did confirm that my keyboard still works with this:
>>>
>>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>>> index 1dd8d5aebf678..b74d7d8cc8630 100644
>>> --- a/drivers/acpi/resource.c
>>> +++ b/drivers/acpi/resource.c
>>> @@ -19,7 +19,7 @@
>>>   #include <linux/dmi.h>
>>>
>>>   #ifdef CONFIG_X86
>>> -#define valid_IRQ(i) (((i) != 0) && ((i) != 2))
>>> +#define valid_IRQ(i) ((i) > 2)
>>>   static inline bool acpi_iospace_resource_valid(struct resource *res)
>>>   {
>>>          /* On X86 IO space is limited to the [0 - 64K] IO port range */
>>>
>>> Can we perhaps see if that works instead for some affected people?
>>
>> That does not just skip the override stuff, it will make the kernel return irqresource_disabled(res, 1) for the kbd IRQ:
>>
>> static inline void irqresource_disabled(struct resource *res, u32 irq)
>> {
>>          res->start = irq;
>>          res->end = irq;
>>          res->flags |= IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
>> }
>>
>> Now not much code seems to actually check the IORESOURCE_DISABLED | IORESOURCE_UNSET flags, so this might still work but it does not seem like the right thing to do.
>>
> 
> Right; so it makes the resource get skipped when PNP is enumerated.

Which AFAICT means that PNP enumerated i8042-s will not have any IRQ assigned at all and this will not work.

Regards,

Hans

