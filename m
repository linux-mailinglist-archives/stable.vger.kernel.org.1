Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48DF73861D
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 16:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjFUOEU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 10:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjFUOET (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 10:04:19 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D25D10F0;
        Wed, 21 Jun 2023 07:04:18 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f9bff0a543so6411185e9.3;
        Wed, 21 Jun 2023 07:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687356256; x=1689948256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sTj4N8AyQeGueLQopgRBElDXMOrvz59DWnnVguPB4fY=;
        b=M1gbVuc+RN42zWur8u5nhytwFvXZfc4HduYsPVI5oStBFZapiVbWZU1IeAGCCRYZuc
         +hhGgts6O4T3LCfHAick7zpsWYS6pAcnIElb1nl0phCRiYT5+iQgyVr06zhPN1Ep2Rs4
         q1enPWhJ2ATiQQf9KDg7SYqNjU/SDHyz3j0WSjjgZI+jcQxTzBOjDPYt9zK1xd8A0h7d
         JhHQl/0CoUYTeaVaqFcAXGSTRUsSvy3MH/VIpg1pUfRLJIku2fCYqiZQ50pGGWkFBn0d
         3qtWgR8mylMEwOOeiXs2aZCkP4cEAZ8ObzP6wWZb5yv0yw2MHgwf3AnV3KCDRS2o0Cei
         FGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687356256; x=1689948256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTj4N8AyQeGueLQopgRBElDXMOrvz59DWnnVguPB4fY=;
        b=LW8gAqDyTKtqDwEDKG2S+n2GM/0sq5yQNRTO1zxuug6YW6Os1brhK1uc67F2Juc57h
         UpmrjFjTMnSxpBK+Wdde/ADUarpHbP9whlfKQMfbN3Zw4wwLViU9372SitA1ebAzq+q/
         Hzl67hC+o0OyjtI5wPLEgOsfyCXdu+7OTAfAurmDRa8mTFY/9nTxm/zIqkUq2VeLgAU3
         8NwbuHZzLRCwpUKMaFGezB+UlCJ3eX5AKUAyHd7rdpKwzyI0+R5+d+FiNs208qbYisHW
         w8GeV21zwzCjgWEfBx2UjrH2QE1LezrXec6njXvm3QKEi2P1P80lzvzmo2vb27vitvu/
         28Aw==
X-Gm-Message-State: AC+VfDxzIEndD2mJRSMU3B9snlHEtMvz3dduPm90nbH5ir/tDJMnkWMj
        vjK6hAzHTV+B3pYWkbnmCBY=
X-Google-Smtp-Source: ACHHUZ6IzAAGUzdcRmruPdog4zjc0n9DUn+61QTk6b9HR+TmMRLA0baJqQT+sLg0Yv25L3icLYar/A==
X-Received: by 2002:a1c:6a04:0:b0:3f7:e7a5:5bc5 with SMTP id f4-20020a1c6a04000000b003f7e7a55bc5mr12578832wmc.24.1687356256242;
        Wed, 21 Jun 2023 07:04:16 -0700 (PDT)
Received: from [10.178.67.29] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id y10-20020a05600c20ca00b003f9b29ba838sm5094036wmm.35.2023.06.21.07.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 07:04:15 -0700 (PDT)
Message-ID: <8a41a15a-b832-3e66-d10a-df29f1a4c880@gmail.com>
Date:   Wed, 21 Jun 2023 15:04:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net] net: phy: Manual remove LEDs to ensure correct
 ordering
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>, netdev <netdev@vger.kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>, ansuelsmth@gmail.com,
        Russell King <rmk+kernel@armlinux.org.uk>,
        stable@vger.kernel.org
References: <20230617155500.4005881-1-andrew@lunn.ch>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230617155500.4005881-1-andrew@lunn.ch>
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

Hi Andrew,

On 6/17/2023 4:55 PM, Andrew Lunn wrote:
> If the core is left to remove the LEDs via devm_, it is performed too
> late, after the PHY driver is removed from the PHY. This results in
> dereferencing a NULL pointer when the LED core tries to turn the LED
> off before destroying the LED.
> 
> Manually unregister the LEDs at a safe point in phy_remove.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Florian Fainelli <f.fainelli@gmail.com>
> Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
> Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Thanks for fixing this, this is an improvement, though I can still hit 
another sort of use after free whereby the GENET driver removes the 
mdio-bcm-unimac platform device and eventually cuts the clock to the 
MDIO block thus causing the following:

# reboot -f
[   18.162000] bcmgenet 8f00000.ethernet eth0: Link is Down
[   18.305163] SError Interrupt on CPU2, code 0x00000000bf000002 -- SError
[   18.305170] GISB: target abort at 0x8f00e14 [R ], core: cpu_0
[   18.305180] CPU: 2 PID: 41 Comm: kworker/2:1 Not tainted 
6.4.0-rc5-next-20230607-gc7a93fa22690 #98
[   18.305187] Hardware name: BCM972180HB_V20 (DT)
[   18.305191] Workqueue: events set_brightness_delayed
[   18.305214] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[   18.305220] pc : el1_abort+0x30/0x5c
[   18.305230] lr : el1_abort+0x24/0x5c
[   18.305235] sp : ffffffc082b73a90
[   18.305236] x29: ffffffc082b73a90 x28: ffffff8002fad780 x27: 
0000000000000000
[   18.305243] x26: 0000000000000000 x25: 0000000000000000 x24: 
ffffff807dbb340d
[   18.305250] x23: 0000000060000005 x22: ffffffc08066d9ac x21: 
0000000096000210
[   18.305256] x20: ffffffc082b55e14 x19: ffffffc082b73ad0 x18: 
0000000000000000
[   18.305263] x17: 74656e2f74656e72 x16: 656874652e303030 x15: 
303066382f626472
[   18.305269] x14: ffffff8004a84cd8 x13: 6e69622f7273752f x12: 
0000000000000000
[   18.305275] x11: ffffff8002d1c710 x10: 0000000000000870 x9 : 
ffffffc080667e34
[   18.305282] x8 : ffffff8003d44a80 x7 : fefefefefefefeff x6 : 
000073746e657665
[   18.305288] x5 : ffffff8003d44a80 x4 : ffffffc082b73ad0 x3 : 
0000000000000025
[   18.305294] x2 : 000000000000001c x1 : 0000000004208060 x0 : 
0000000000000000
[   18.305303] Kernel panic - not syncing: Asynchronous SError Interrupt
[   18.305306] CPU: 2 PID: 41 Comm: kworker/2:1 Not tainted 
6.4.0-rc5-next-20230607-gc7a93fa22690 #98
[   18.305311] Hardware name: BCM972180HB_V20 (DT)
[   18.305314] Workqueue: events set_brightness_delayed
[   18.305319] Call trace:
[   18.305321]  dump_backtrace+0xdc/0x114
[   18.305329]  show_stack+0x1c/0x28
[   18.305333]  dump_stack_lvl+0x44/0x58
[   18.305339]  dump_stack+0x14/0x1c
[   18.305342]  panic+0x128/0x2f8
[   18.305350]  nmi_panic+0x50/0x70
[   18.305356]  arm64_serror_panic+0x74/0x80
[   18.305361]  do_serror+0x2c/0x5c
[   18.305366]  el1h_64_error_handler+0x30/0x44
[   18.305372]  el1h_64_error+0x64/0x68
[   18.305378]  el1_abort+0x30/0x5c
[   18.305383]  el1h_64_sync_handler+0x64/0xc8
[   18.305389]  el1h_64_sync+0x64/0x68
[   18.305392]  readl_relaxed+0x0/0x8
[   18.305401]  __mdiobus_write+0x3c/0x94
[   18.305409]  mdiobus_write+0x4c/0x70
[   18.305415]  phy_write+0x1c/0x24
[   18.305419]  bcm_phy_read_shadow+0x24/0x40
[   18.305423]  bcm_phy_led_brightness_set+0x40/0x94
[   18.305428]  phy_led_set_brightness+0x48/0x68
[   18.305434]  set_brightness_delayed_set_brightness+0x44/0x7c
[   18.305443]  set_brightness_delayed+0xc4/0x1a4
[   18.305447]  process_one_work+0x1c0/0x284
[   18.305455]  process_scheduled_works+0x44/0x48
[   18.305461]  worker_thread+0x1e8/0x264
[   18.305467]  kthread+0xcc/0xdc
[   18.305474]  ret_from_fork+0x10/0x20
[   18.311812] Kernel Offset: disabled
[   18.311814] CPU features: 0x00000003,00010000,0000420b
[   18.311818] Memory Limit: none
[   18.566507] ---[ end Kernel panic - not syncing: Asynchronous SError 
Interrupt ]---

still not clear to me how the workqueue managed to execute and not 
finish before we unregistered the PHY device.
-- 
Florian
