Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD3A738CD3
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 19:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjFURMu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 13:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjFURMr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 13:12:47 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869EF19AD;
        Wed, 21 Jun 2023 10:12:43 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4716e4adb14so1642655e0c.0;
        Wed, 21 Jun 2023 10:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687367562; x=1689959562;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=toc9CYTHR42a7NITG1c4cPTSZbY+Re3tZ+t9Dq3HGFE=;
        b=fyiiAHa5jxKZGC/mYz+m/YkWi0uW5kBWNCwbhwwzzkbQ1bhLgODVVNlgnxtrEM08MG
         1uolqdZ4FFwC2PH4+ZUnHpC3bXWI0scJfwzZ9GDSa1GpqYULSu3PWHf1ekvKiADalpEx
         KUEUZ5qOeEdFKsmdXsC9M9/twxasZd72+kzZenKo8q251OnxaZBrieH0HjmZ4JQ2DM2N
         +rZIjzZTUlEIYxlNvnBLgScq8RMZYrbL7RO0n1u53thf/O0Rfv3memAiEJj4/aHP4e+i
         dHsrkeLhs9P3HS882PcHUg/0F4yLm+D8I3CDOJUva5qr+auMNx6fFu/HqDdh2wq4oCTc
         t3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367562; x=1689959562;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toc9CYTHR42a7NITG1c4cPTSZbY+Re3tZ+t9Dq3HGFE=;
        b=TsaP2ukvljMbGcLJ30sQJ9nuIsugCzHPWQDhCBnWb1w+9YjWBYgTHKvJhknVItFvGE
         FMfie6BrBQiVavTO9Ra7ZzRRiAjozvmjLiqzQljm9tqtZnjNXCxZV/xbkzA+LUcIr/H6
         BXFgG+2mWl1MVGBXxE6BwUrm/j8hWJqT+z4V3D3BEKxCLbLoIR/NVkwN1fo0kqozuIKG
         GKaCjAIKGyesWBC/lgVKggOttmT9xRhxSJPttGvTILJS3NUtzGu8bxafTsLe05fkF3vV
         1cnmSBGNZViG+CQBAqdKXhbnHkPJDm/zYNKWdW2h3oGxG8Dp5s7Vu7kF5k8aNOAvGi9f
         LjYw==
X-Gm-Message-State: AC+VfDx5+yW9MJYitTjy7cvvOIpW4FUAEtgziN5WGnPPZJ7oPNf2kRmf
        DV9Qh4t2O0H42zXotC1mRy4=
X-Google-Smtp-Source: ACHHUZ5pgniRmauejbcU6xPbs+ClsZ9PeFtW7Z1YkK+H4JnNlFKyUOvgJdHNjQs1RjhWcKYludl6aA==
X-Received: by 2002:a1f:5744:0:b0:46e:8084:92be with SMTP id l65-20020a1f5744000000b0046e808492bemr6494712vkb.6.1687367562471;
        Wed, 21 Jun 2023 10:12:42 -0700 (PDT)
Received: from [10.178.67.29] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a14a500b00761f635fbf6sm2460957qkj.8.2023.06.21.10.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 10:12:41 -0700 (PDT)
Message-ID: <cb3d7ae2-a7f8-537b-3b51-3491265b0e65@gmail.com>
Date:   Wed, 21 Jun 2023 18:12:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net] net: phy: Manual remove LEDs to ensure correct
 ordering
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>, netdev <netdev@vger.kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>, ansuelsmth@gmail.com,
        stable@vger.kernel.org
References: <20230617155500.4005881-1-andrew@lunn.ch>
 <8a41a15a-b832-3e66-d10a-df29f1a4c880@gmail.com>
 <ZJMtrw6zdi2YP7b5@shell.armlinux.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <ZJMtrw6zdi2YP7b5@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Russell,

On 6/21/2023 6:04 PM, Russell King (Oracle) wrote:
> On Wed, Jun 21, 2023 at 03:04:14PM +0100, Florian Fainelli wrote:
>> Hi Andrew,
>>
>> On 6/17/2023 4:55 PM, Andrew Lunn wrote:
>>> If the core is left to remove the LEDs via devm_, it is performed too
>>> late, after the PHY driver is removed from the PHY. This results in
>>> dereferencing a NULL pointer when the LED core tries to turn the LED
>>> off before destroying the LED.
>>>
>>> Manually unregister the LEDs at a safe point in phy_remove.
>>>
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Florian Fainelli <f.fainelli@gmail.com>
>>> Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
>>> Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
>>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>>
>> Thanks for fixing this, this is an improvement, though I can still hit
>> another sort of use after free whereby the GENET driver removes the
>> mdio-bcm-unimac platform device and eventually cuts the clock to the MDIO
>> block thus causing the following:
> 
> Hi Florian,
> 
> Can you try setting trigger_data->led_cdev to NULL after the
> cancel_delayed_work_sync() in netdev_trig_deactivate() and see
> what the effect is?

Thanks for the suggestion, getting an identical trace as before with 
that change.
-- 
Florian
