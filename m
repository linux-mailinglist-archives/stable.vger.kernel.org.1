Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5B377A669
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 14:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjHMM4Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 08:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjHMM4Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 08:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51EC1712
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 05:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691931340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HpP/UmSbd/3zjTPm/BSKDWOF8g8BW3I43bbgTg39mWs=;
        b=LuLmVg8OI/6pI1uvt4Q89XaUxZYFRfmMXaKmbfor4BioD1KTsSmStdDrphBi6iF1kEzHFf
        +4K6/I7XCRgtkuq/Cerr4O6XN0pVbxg2FDlX/ZAVjaVFkWYFw6jlM71bhbuYnVAX6PDjjf
        M5SGCtNj4zblmXc2GgqnCyPw6/Tlc8M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-KKioEPdVMKqULqOipHTTZg-1; Sun, 13 Aug 2023 08:55:37 -0400
X-MC-Unique: KKioEPdVMKqULqOipHTTZg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a35b0d4ceso217424266b.3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 05:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691931336; x=1692536136;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpP/UmSbd/3zjTPm/BSKDWOF8g8BW3I43bbgTg39mWs=;
        b=jeDbbBKCLZLKdVoP2NbLuecfUgg2poqftLv7FzDy61Sa5bw+WF5bg1HCf1nK2uge2a
         dayilcqftGwyoXx9rIXhAMz1IKp96yMiXExw4ZaYKrzDZkUz3cPGiQbkb5HfwIdSpQvf
         LwCOsteG2i1W5443bdwxoIQHzdlkDvFaQhztEu4qdFzeIftTTzvh+2orLZ6oixa8xzU6
         mh4AMTClF5epwZlYkdow3m78bns5fT0tVxJ2TqYkbjoSC5gsVpWv4kHQ8D02Ko6isdHe
         4DgSeWoKQa0R5Fkw4QkbikvQxYKavcT95A7NgnbblNIM5hRoqHt9qieshSXDKtwIrf81
         9VRA==
X-Gm-Message-State: AOJu0YwL3AdjObGCosULDOcRDDe1lWSeW22EAsda8nuzfBtk1siaO/DT
        Gd6dC94k14+SjGaYde0p2zORhXu/BMA8kIgUhTNnwrzqLM+/91z2APYjVuOOlheqtf3/BH6muyf
        nsFSV3JiNYmg4dbSM
X-Received: by 2002:a17:907:7808:b0:99c:5708:496f with SMTP id la8-20020a170907780800b0099c5708496fmr5118838ejc.47.1691931336086;
        Sun, 13 Aug 2023 05:55:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIUElMEBgLGDCNoSKEWoy78stJZTL1FIpMSpD1/CLtmm0cQm1qmnui9WG0RhJbclb3JpmKKQ==
X-Received: by 2002:a17:907:7808:b0:99c:5708:496f with SMTP id la8-20020a170907780800b0099c5708496fmr5118816ejc.47.1691931335312;
        Sun, 13 Aug 2023 05:55:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709065a9200b00991e2b5a27dsm4586275ejq.37.2023.08.13.05.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 05:55:34 -0700 (PDT)
Message-ID: <1c2fac32-ba63-9e55-f809-d86a1afed3f9@redhat.com>
Date:   Sun, 13 Aug 2023 14:55:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] platform/x86: lenovo-ymc: Only bind on machines with a
 convertible DMI chassis-type
Content-Language: en-US, nl
To:     =?UTF-8?B?R2VyZ8WRIEvDtnRlbGVz?= <soyer@irl.hu>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org,
        Andrew Kallmeyer <kallmeyeras@gmail.com>,
        =?UTF-8?Q?Andr=c3=a9_Apitzsch?= <git@apitzsch.eu>,
        stable@vger.kernel.org
References: <20230812144818.383230-1-hdegoede@redhat.com>
 <3d4143b70eaeb45e6feabde0c9d90c1a07312163.camel@irl.hu>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <3d4143b70eaeb45e6feabde0c9d90c1a07312163.camel@irl.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On 8/12/23 22:48, Gergő Köteles wrote:
> Hi,
> 
> On Sat, 2023-08-12 at 16:48 +0200, Hans de Goede wrote:
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
> Thanks for fixing this!
> It works on Yoga 7 14ARB7.
> 
> Tested-by: Gergő Köteles <soyer@irl.hu>

On 8/12/23 19:25, Andrew Kallmeyer wrote:

> Too bad that this caused problems for some people. Thank you for
> getting it fixed Hans!
> 
> Tested-by: Andrew Kallmeyer <kallmeyeras@gmail.com>

Thank you both for testing this.

I've added this to the pdx86/fixes branch now, with both
your Tested-by-s added.

Regards,

Hans




>> ---
>> Note: The chassis-type can be checked by doing:
>> cat /sys/class/dmi/id/chassis_type
>> if this reports 31 or 32 then this patch should not have any impact
>> on your machine.
>> ---
>>  drivers/platform/x86/lenovo-ymc.c | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/platform/x86/lenovo-ymc.c b/drivers/platform/x86/lenovo-ymc.c
>> index 41676188b373..f360370d5002 100644
>> --- a/drivers/platform/x86/lenovo-ymc.c
>> +++ b/drivers/platform/x86/lenovo-ymc.c
>> @@ -24,6 +24,10 @@ static bool ec_trigger __read_mostly;
>>  module_param(ec_trigger, bool, 0444);
>>  MODULE_PARM_DESC(ec_trigger, "Enable EC triggering work-around to force emitting tablet mode events");
>>  
>> +static bool force;
>> +module_param(force, bool, 0444);
>> +MODULE_PARM_DESC(force, "Force loading on boards without a convertible DMI chassis-type");
>> +
>>  static const struct dmi_system_id ec_trigger_quirk_dmi_table[] = {
>>  	{
>>  		/* Lenovo Yoga 7 14ARB7 */
>> @@ -35,6 +39,20 @@ static const struct dmi_system_id ec_trigger_quirk_dmi_table[] = {
>>  	{ }
>>  };
>>  
>> +static const struct dmi_system_id allowed_chasis_types_dmi_table[] = {
>> +	{
>> +		.matches = {
>> +			DMI_EXACT_MATCH(DMI_CHASSIS_TYPE, "31" /* Convertible */),
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_EXACT_MATCH(DMI_CHASSIS_TYPE, "32" /* Detachable */),
>> +		},
>> +	},
>> +	{ }
>> +};
>> +
>>  struct lenovo_ymc_private {
>>  	struct input_dev *input_dev;
>>  	struct acpi_device *ec_acpi_dev;
>> @@ -111,6 +129,13 @@ static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
>>  	struct input_dev *input_dev;
>>  	int err;
>>  
>> +	if (!dmi_check_system(allowed_chasis_types_dmi_table)) {
>> +		if (force)
>> +			dev_info(&wdev->dev, "Force loading Lenovo YMC support\n");
>> +		else
>> +			return -ENODEV;
>> +	}
>> +
>>  	ec_trigger |= dmi_check_system(ec_trigger_quirk_dmi_table);
>>  
>>  	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
> 

