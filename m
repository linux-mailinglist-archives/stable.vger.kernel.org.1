Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E86E776336
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 17:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjHIPB0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 11:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjHIPBZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 11:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03912108
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691593238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dveDaPi6Pv31ovE5nh4Udys9b+Io+evbznraaB9ZP6k=;
        b=CFASmCewFZ9PGenPHY+ChJObI+Wl8rMtTVjxgzUp1xUUeiYQ9ZNMmKKHSDMGCEZ8M1DLDv
        B7amg0MRXayja2evSBRhvFElisWBnyAUZAMlXZPHu1H/vLEx8eLKP/8nkgbLo1VcxyGRG+
        GNxmxANwztfp9pZeo3k73HsjcaHKauA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-xKZxF96iPLKJVMc_s_-dyA-1; Wed, 09 Aug 2023 11:00:37 -0400
X-MC-Unique: xKZxF96iPLKJVMc_s_-dyA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5219ceead33so5071847a12.2
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 08:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691593235; x=1692198035;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dveDaPi6Pv31ovE5nh4Udys9b+Io+evbznraaB9ZP6k=;
        b=f3TnzehKz871UjFPsgbozfJjDyX1Ilo/qxldUFI0S0rvuHL1Tx1Wp8SxTTIuWhTZN5
         9RNdzNqVnEYQ8cpN9tRcBh6MQuxPhOBQXuyMI+2F/fACRGPMBXfDy8wPDFoeNbRCo52i
         8742ouJGLRl8jt4Oyg2pgYaDt+6X2ZmLOzpTx4kW8gwPtFMNy6qbIm6IZTC9aW9M67X7
         K1rOmVAs9+IbbgWZE5hByOIzZK0BgpFN5Cy1J4s0RSEP2Vhr/KvEI1eV83yT8W/HmN5b
         ga63mCfe/nwVYnqcDrICXUHwsBpPj7j7ln0BGFWffpwYFo2wA4Esz8yte69xatb67Btp
         BJ+Q==
X-Gm-Message-State: AOJu0YxrNcVslbAAO8I0rBcProy4tsHJ4iqk5lI0FMRJxyTIlF5l3C6v
        +FGwSpS88dCHNLiWULFMZSrWwKYUKXoT06k8jo1nO4EOg5Uz1cZ50mSqFdCNcJcGvqsPAZuwZPk
        v++03NpX2BvOqqc1HafQvHafU
X-Received: by 2002:a50:ed83:0:b0:523:4dea:2498 with SMTP id h3-20020a50ed83000000b005234dea2498mr2759511edr.19.1691593235401;
        Wed, 09 Aug 2023 08:00:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBydt7ncisNSGPFhnkpSoFZ6lJjwg/5Am06dis4i75dQxHRBzi1C/4QrSr8oiu+7QmmEtncQ==
X-Received: by 2002:a50:ed83:0:b0:523:4dea:2498 with SMTP id h3-20020a50ed83000000b005234dea2498mr2759486edr.19.1691593235143;
        Wed, 09 Aug 2023 08:00:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id g17-20020a056402115100b005230f2a12b9sm8024864edw.43.2023.08.09.08.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 08:00:34 -0700 (PDT)
Message-ID: <642bc861-f7fa-4c5f-2082-eb26258132a5@redhat.com>
Date:   Wed, 9 Aug 2023 17:00:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/3] ACPI: resource: Honor MADT INT_SRC_OVR settings
 for IRQ1 on AMD Zen
Content-Language: en-US, nl
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        August Wikerfors <git@augustwikerfors.se>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
References: <20230809085526.84913-1-hdegoede@redhat.com>
 <20230809085526.84913-4-hdegoede@redhat.com>
 <f133d401-1975-6c85-47c5-f9464d5ef06f@kernel.org>
 <3fe197da-c26e-e826-4ea2-c13d2880046d@redhat.com>
 <CAJZ5v0garg=icaM5f0JNvY+ip7PX1omMRWDS-UvF1_1f82SYZg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0garg=icaM5f0JNvY+ip7PX1omMRWDS-UvF1_1f82SYZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On 8/9/23 16:57, Rafael J. Wysocki wrote:
> On Wed, Aug 9, 2023 at 4:40 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 8/9/23 11:20, Jiri Slaby wrote:
>>> On 09. 08. 23, 10:55, Hans de Goede wrote:
>>>> On AMD Zen acpi_dev_irq_override() by default prefers the DSDT IRQ 1
>>>> settings over the MADT settings.
>>>>
>>>> This causes the keyboard to malfunction on some laptop models
>>>> (see Links), all models from the Links have an INT_SRC_OVR MADT entry
>>>> for IRQ 1.
>>> ...
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ...
>>>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
>>>> index 21b542a6866c..b88e5e0135ab 100644
>>>> --- a/arch/x86/kernel/acpi/boot.c
>>>> +++ b/arch/x86/kernel/acpi/boot.c
>>>> @@ -52,6 +52,7 @@ int acpi_lapic;
>>>>   int acpi_ioapic;
>>>>   int acpi_strict;
>>>>   int acpi_disable_cmcff;
>>>> +int acpi_int_src_ovr[NR_IRQS_LEGACY];
>>>
>>> So why not to use bool to make it clear this is not an irq number, but a state?
>>>
>>>>     /* ACPI SCI override configuration */
>>>>   u8 acpi_sci_flags __initdata;
>>>> @@ -588,6 +589,9 @@ acpi_parse_int_src_ovr(union acpi_subtable_headers * header,
>>>>         acpi_table_print_madt_entry(&header->common);
>>>>   +    if (intsrc->source_irq < NR_IRQS_LEGACY)
>>>> +        acpi_int_src_ovr[intsrc->source_irq] = 1;
>>>
>>> And "true" here.
>>
>> Ack that would indeed be better.
>>
>> Rafael, can you fix this up while merging or do you want a v4 series ?
> 
> I think I can do that.

Great, thank you.

Do you have any comments on this series, or is this ready for merging now?

Regards,

Hans

