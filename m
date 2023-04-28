Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354BD6F194B
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 15:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjD1NXs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 09:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346185AbjD1NXr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 09:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5669326A2
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 06:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682688180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xw5k5HB/XqttO2GdPnL9DIAwbzyOdlnfvD271qf0MJc=;
        b=e3IHNFpuVY5XngzRQcGoFknpZp4jaFHHSvktZ92oYOuGYpPkRVYVskepJ3ue7SKpOk/EoZ
        JltOsGb4JamlgaQ0xARM6YrNAQn831lBlphpsR9ijKDJuO7+O5t3DBEJQvi7KfurO+V+eb
        Ab3hOU09JQU2qmXyqpumazhNv5Pde8U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-PS0hWNV3ONaLAHiBzAMKpg-1; Fri, 28 Apr 2023 09:22:56 -0400
X-MC-Unique: PS0hWNV3ONaLAHiBzAMKpg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-506e62603f6so9889555a12.2
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 06:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682688175; x=1685280175;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xw5k5HB/XqttO2GdPnL9DIAwbzyOdlnfvD271qf0MJc=;
        b=J7+5llGOyK2UGSgUZ5saHnoscZ2VLY4rsPySKbXgNxPpWQCFzrHhcE24yq1vruIXVk
         GmrWy0RF/Ja8Tj0LQVW7ZfALRvuWMZ8jNn/yvDy2WYdOxOwuAc+vUO5GK+sv9mQZjFY3
         xDQNIxleCiNT7ph7zs1W3XU87Df8hj17K77osKa/AcuPmXrcUhFqIHkjCqzQBDjsSjCF
         hAUv0J5v7K6400qIvKAimCQkbPMOgur1Tn/UYWez3nFUS2BGbJRfbVPKBDBJ/a9Wtfbi
         evaTyjidPGM11YKHOy+uiMSKJ4JZdhbQqvcR4P2SZ7yvLqf7eL0FCE6qGhrFd0V2UGM6
         WV1A==
X-Gm-Message-State: AC+VfDxE+0AsjoHVS5NdIrAjm266CRxjF+2p8/oZdDb5i0NEJlJ4Q+D4
        oFZ4vG7jjh6tt4weKRwQsDyJHDCI03aH2lZU3FzaT+LgdGqAI8SGLejAI4j0ciD6Tyv76f4fSec
        jentnvgsV3QOnNsJg
X-Received: by 2002:a05:6402:50f:b0:506:8da7:fab7 with SMTP id m15-20020a056402050f00b005068da7fab7mr4553815edv.10.1682688175501;
        Fri, 28 Apr 2023 06:22:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6pwLHm2AzLmfLaqdpck/itqpURgmaLHJ46TeWsFBZ5DNBmq1cy3BPVHn2Xy/9FdNsLEekd/w==
X-Received: by 2002:a05:6402:50f:b0:506:8da7:fab7 with SMTP id m15-20020a056402050f00b005068da7fab7mr4553801edv.10.1682688175279;
        Fri, 28 Apr 2023 06:22:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id q3-20020a056402032300b004af6c5f1805sm9100221edw.52.2023.04.28.06.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 06:22:54 -0700 (PDT)
Message-ID: <689fdd60-66e4-d423-3ae5-f9fc4513a9b7@redhat.com>
Date:   Fri, 28 Apr 2023 15:22:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: REGRESSION: ThinkPad W530 dim backlight with recent changes
 introduced in Linux 6.1.24
Content-Language: en-US, nl
To:     =?UTF-8?B?0KDRg9GB0LXQsiDQn9GD0YLQuNC9?= 
        <rockeraliexpress@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, stable@vger.kernel.org,
        Daniel Dadap <ddadap@nvidia.com>
References: <CAK4BXn0ngZRmzx1bodAF8nmYj0PWdUXzPGHofRrsyZj8MBpcVA@mail.gmail.com>
 <2023041711-overcoat-fantastic-c817@gregkh>
 <CAK4BXn30dd3oCwcF2yVb5nNnjR21=8J2_po-gSUuArd5y=f9Ww@mail.gmail.com>
 <CAJZ5v0g+PAOZs47LCrxRswZoCmHbGfBg3_cr13Y8zWPXDjgm3A@mail.gmail.com>
 <a3b89478-2d37-1b25-94e0-0e12396f6fd4@redhat.com>
 <CAK4BXn37Ns8Z8g4ysKoOZJaVa8K+mFQm5PupAanQwmz07ygW9A@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAK4BXn37Ns8Z8g4ysKoOZJaVa8K+mFQm5PupAanQwmz07ygW9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Русев,

On 4/27/23 17:35, Русев Путин wrote:
>> This patch should not change the maximum brightness. But you may need
> to adjust the brightness once after changing to a new kernel with
> the patch because the range / brightness-curve may be different.
> 
> This patch does change the display brightness curve but it is very
> buggy and does not change the brightness as soon as set. There is a
> very significant delay in brightness transition on the laptop due to
> this patch. Also it is worth mentioning that this patch also messes up
> color contrast of the display causing significantly deeper blacks on
> the display.

Ok, lets remove the acpi_backlight=video quirk for Lenovo ThinkPad W530
then. This was intended to make life easier for Nvidia binary driver
users, but since it is causing issues elsewhere  Nvidia binary driver
users will just have to manually pass acpi_backlight=video on
the kernel commandline until Nvidia fixes the driver.

I'll submit a patch to remove the quirk right away.

Regards,

Hans



