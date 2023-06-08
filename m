Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03F2728317
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 16:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbjFHOw4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 10:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbjFHOw4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 10:52:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B484A10FB
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 07:52:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so4982585e9.0
        for <stable@vger.kernel.org>; Thu, 08 Jun 2023 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686235972; x=1688827972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7U80InyI1jDB9fEoyEolo/ocNxwMwPL2vZLJVrgTJA=;
        b=0OQbZYn39KPu+FNGcYlkL1MOnUoqaS6UTIV7RyNIubalfZq/MVEHzvV9wD2h8RwgCD
         jtyKUJJzTveSxN6c/jYOp7YlmaRp++M20H2/eTET/Q/nY1hIaYJLESXujgE6+VwYT+qa
         2k4zJS8wBVoaqWpVnxOBc/F1gdWR+yiitfaN5LaNucBU1ipOZry1c8WXf3cyvFRiHiky
         bVraPHbrr7DU/odNVYGR3rFmZWtCarjx6eqaVTS0nHaLlQvSglt6UzsbGaJ4ToW38/in
         Gk/isNCDxSNJgEU4LsHNDDF37C7yRiZph0kPg0Ia1lgi4gIfYbnASHU+5KHIBdSJTqty
         Y31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686235972; x=1688827972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7U80InyI1jDB9fEoyEolo/ocNxwMwPL2vZLJVrgTJA=;
        b=ArYhyVDHxAkNYWCqnG1u9MVWcYMYGD4S9jewlKQtxH3l3zhCZxsj0QsI87xRfU6ETF
         FxqUv0Rr+L9Z5gnUvkSENTSU9zxMBQ0CEby6Ir2SeMCj6rBI9sxIxIO6OIoNLEF3VxVF
         3lIDmJWDVfn15P5ISxSlHaAWfJKvMMJ0phSHITNoPpF7jwtfsR1O2dyr99SIve6oLNi1
         JBWf7jD22TRfMxcea/IW+TYma2bGnEU+askpIsA9GTucsIeAmvdBH329cdVPErAA+KOS
         AudxeSNvefsa2GurywuVIx6oMoTXhi2PvX+i9GXgNSlt9j5GPTvkNwK3xPlff0xgApYb
         oVIA==
X-Gm-Message-State: AC+VfDy4IdcjYsJuwYxlM04Hrt0fbiNsJ2/cxXMKKQlhLUGwZ0h7Io8J
        7tXPO1aeV0E/U1nPaLUyPmKcag==
X-Google-Smtp-Source: ACHHUZ7DTQ1Q6mOQiVimjTwsruHuDo4XK0foPMjlkPu/aokLcofD6jvVWcnXb1n1SzYnMPrpwhs0Cg==
X-Received: by 2002:a05:600c:21c8:b0:3f6:e59:c04c with SMTP id x8-20020a05600c21c800b003f60e59c04cmr1558444wmj.24.1686235972143;
        Thu, 08 Jun 2023 07:52:52 -0700 (PDT)
Received: from [192.168.1.91] (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id y8-20020a7bcd88000000b003f7ff6b1201sm936746wmj.29.2023.06.08.07.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 07:52:51 -0700 (PDT)
Message-ID: <e5f29e17-2c76-4171-002c-2b33241774b9@baylibre.com>
Date:   Thu, 8 Jun 2023 16:52:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [tiL6.1-P PATCH] regulator: tps65219: fix matching interrupts for
 their regulators
Content-Language: en-US
To:     Greg KH <greg@kroah.com>
Cc:     linux-patch-review@list.ti.com, s.sharma@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, aseketeli@baylibre.com, jpanis@baylibre.com,
        khilman@baylibre.com, d-gole@ti.com, vigneshr@ti.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
References: <20230608142132.3728511-1-jneanne@baylibre.com>
 <2023060840-handcart-subway-d834@gregkh>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <2023060840-handcart-subway-d834@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 08/06/2023 16:49, Greg KH wrote:
> On Thu, Jun 08, 2023 at 04:21:32PM +0200, Jerome Neanne wrote:
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> The driver's probe() first registers regulators in a loop and then in a
>> second loop passes them as irq data to the interrupt handlers.  However
>> the function to get the regulator for given name
>> tps65219_get_rdev_by_name() was a no-op due to argument passed by value,
>> not pointer, thus the second loop assigned always same value - from
>> previous loop.  The interrupts, when fired, where executed with wrong
>> data.  Compiler also noticed it:
>>
>>    drivers/regulator/tps65219-regulator.c: In function ‘tps65219_get_rdev_by_name’:
>>    drivers/regulator/tps65219-regulator.c:292:60: error: parameter ‘dev’ set but not used [-Werror=unused-but-set-parameter]
>>
>> Fixes: c12ac5fc3e0a ("regulator: drivers: Add TI TPS65219 PMIC regulators support")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
>> ---
>>
>> Notes:
>>      This is backport of upstream fix in TI mainline:
>>      Link: https://lore.kernel.org/all/20230507144656.192800-1-krzysztof.kozlowski@linaro.org/
> 
> What is the upstream commit id here?
> 
> thanks,
> 
> greg k-h
This was not intended to reach the whole list but TI only(I did not 
remove -cc all).

Non TI folks please ignore this patch.

Sorry for disturbance.
