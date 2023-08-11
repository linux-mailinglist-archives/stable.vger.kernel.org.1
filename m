Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA6977961D
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 19:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjHKRaZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 13:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbjHKRaY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 13:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A83130CD;
        Fri, 11 Aug 2023 10:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A70D61811;
        Fri, 11 Aug 2023 17:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0AD9C433C7;
        Fri, 11 Aug 2023 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691775022;
        bh=hmymYMJgDoB3tSkHIeM57oDgcXzXM+Kn+DojGssEGSo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GTEl2SxQlw9VUAEbLIC+hUiLLJGuxDMq6fL0KWfIDtM0ZjS+o763Ex2P3h+sp9bss
         GGmhbQhok/TSU3ZbhgUZH4jJ9FXFtXVp7aLajBr2GZHyJ9o12ANHC5KA6P6OikqpII
         qp8fsM+KIYxd6sx78I2FEApRTnWRisR1E8+tswLo9h2q6IglJYi2CUu7HVEiftTBHr
         QghlNDfod2C3f5pUUDmDcVqUJeRJOk3O0wR0zZU7EZhPejq+PYs5gnlsiqQjvZZKxb
         CWtPAvZcVOGnn+CvHTvFAnhhelq/2aqeqfl62f9IcE9HH7eNdjPTTTEBysYs88v+jY
         xE7isMYGel59A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8121FC595D0;
        Fri, 11 Aug 2023 17:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bluetooth: Add device 0bda:4853 to device tables
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169177502252.30118.3287584454013141504.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Aug 2023 17:30:22 +0000
References: <20230809010403.24612-1-Larry.Finger@lwfinger.net>
In-Reply-To: <20230809010403.24612-1-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, hildawu@realtek.com,
        stable@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  8 Aug 2023 20:04:03 -0500 you wrote:
> This device is part of a Realtek RTW8852BE chip. The device table
> is as follows:
> 
> T: Bus=03 Lev=01 Prnt=01 Port=09 Cnt=03 Dev#= 4 Spd=12 MxCh= 0
> D: Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=0bda ProdID=4853 Rev= 0.00
> S: Manufacturer=Realtek
> S: Product=Bluetooth Radio
> S: SerialNumber=00e04c000001
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms
> E: Ad=02(O) Atr=02(Bulk) MxPS= 64 Ivl=0ms
> E: Ad=82(I) Atr=02(Bulk) MxPS= 64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
> I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
> I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
> I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
> I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
> I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
> E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms
> 
> [...]

Here is the summary with links:
  - [v2] bluetooth: Add device 0bda:4853 to device tables
    https://git.kernel.org/bluetooth/bluetooth-next/c/0ae8f7d53554

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


