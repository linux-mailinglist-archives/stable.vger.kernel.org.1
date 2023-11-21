Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D217F35E3
	for <lists+stable@lfdr.de>; Tue, 21 Nov 2023 19:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjKUS3P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 21 Nov 2023 13:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbjKUS3O (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 21 Nov 2023 13:29:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD4C191
        for <stable@vger.kernel.org>; Tue, 21 Nov 2023 10:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700591349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E2kgZUqh4YN3kuh9w9quInDBCqas/0qHNpCsiDxrgHo=;
        b=L0mOpnKrIWG9CzNUmuQxs+lDp5Uqp062frh9vwwNIrgNhHRdPr7KIGEZweAyMdPD/ZxI4j
        kgphHZYPUyEp5kRisxWhLIfIwjFGnXK4oqr0Vu0nHOXafsOi2a0qhZhC58DGhk5TbbRBgo
        vE3tteHmUBL73rifFjFnPGPUx8wP5FE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-GPOI_8hrNm-H88vSDP2DbA-1; Tue, 21 Nov 2023 13:29:07 -0500
X-MC-Unique: GPOI_8hrNm-H88vSDP2DbA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a02ccc2fb53so46505266b.1
        for <stable@vger.kernel.org>; Tue, 21 Nov 2023 10:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700591346; x=1701196146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2kgZUqh4YN3kuh9w9quInDBCqas/0qHNpCsiDxrgHo=;
        b=YCvZqzBfBrTWZyb0cF5IF+PczzNFpMUSv5fqkiQGX8NAjbDtm64NLnSMSGnQU4MDB3
         tTicop9TBtYT5kTMmrcEQqrdZiAS3086p8H565tBzSq9EhJmxQMy9IQ7CsdA1xuOR+gD
         ZEmVUJ8f/AJOtw3HEgNpNToKTPqIVb1vVG9ij4F5YqAEMD9uWbEsETnRMAna8F4BUHmD
         1A3uDZhZQ+aZoSpbhNWutYwoiydA8OfXDpsFgB4cCIrooFnsHlQK27PZk0NrXS7Sm2eS
         ttrJTGDDTq+FmZCvOgFrMOSqRwAdEDpkECeE1BXqO3ltVTL5Bfym6s3wSgi6eDH7PVsF
         4aaA==
X-Gm-Message-State: AOJu0YxTUWMfqTemd/JSinI5DfnIGVF3aMO8WG1Wj0NnYT++OUNu0qgT
        hKOOvvE/WHJNkiNOgQVR2AM9Ph2UQ6/JCByhhdpCWQG25S0aEwuwcBqWSYNc61dEDfr/l9K+bom
        2vGlwzGD8aliw5j4Q
X-Received: by 2002:a17:906:fc13:b0:9e2:af47:54c9 with SMTP id ov19-20020a170906fc1300b009e2af4754c9mr7743220ejb.19.1700591346686;
        Tue, 21 Nov 2023 10:29:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7G0BKFAOnN2k+98sPYUhbWMvtHiRwspjkltuVgDU201IS1z9jEoZ1ovFS9khQ0vuCB/4xRA==
X-Received: by 2002:a17:906:fc13:b0:9e2:af47:54c9 with SMTP id ov19-20020a170906fc1300b009e2af4754c9mr7743204ejb.19.1700591346355;
        Tue, 21 Nov 2023 10:29:06 -0800 (PST)
Received: from ?IPV6:2001:1c00:2a07:3a01:6c4:9fb2:fbc:7029? (2001-1c00-2a07-3a01-06c4-9fb2-0fbc-7029.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:6c4:9fb2:fbc:7029])
        by smtp.gmail.com with ESMTPSA id l18-20020a170906645200b009ad89697c86sm5606991ejn.144.2023.11.21.10.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 10:29:05 -0800 (PST)
Message-ID: <4eff7cff-3136-44d0-bf83-0d803122f9da@redhat.com>
Date:   Tue, 21 Nov 2023 19:29:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: misc: ljca: Fix enumeration error on Dell
 Latitude 9420
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Wentong Wu <wentong.wu@intel.com>,
        Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        stable@vger.kernel.org
References: <20231104175104.38786-1-hdegoede@redhat.com>
 <2023112109-talon-atrocious-ad46@gregkh>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2023112109-talon-atrocious-ad46@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On 11/21/23 15:05, Greg Kroah-Hartman wrote:
> On Sat, Nov 04, 2023 at 06:51:04PM +0100, Hans de Goede wrote:
>> Not all LJCA chips implement SPI and on chips without SPI reading
>> the SPI descriptors will timeout.
>>
>> On laptop models like the Dell Latitude 9420, this is expected behavior
>> and not an error.
>>
>> Modify the driver to continue without instantiating a SPI auxbus child,
>> instead of failing to probe() the whole LJCA chip.
>>
>> Fixes: 54f225fa5b58 ("usb: Add support for Intel LJCA device")
> 
> That commit id isn't in Linus's tree, are you sure it's correct?

Sorry no idea where I got that commit-id from, probably from when
I was carrying the patch in my personal tree for testing it.

I'll send a v3 with the correct commit-id.

Regards,

Hans

