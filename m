Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4D873470A
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 18:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjFRQkV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 12:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjFRQkV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 12:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FC7E4C
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 09:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B09C96112D
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 16:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AEB5C433C9;
        Sun, 18 Jun 2023 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687106419;
        bh=U1FSySq+U9b79O+B14ckaEI0+IvWsB1Uht1VxzfW+eU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=skPz7VgyukHw5Fs+nrvMbc32K/62P+R5opplJbwyuCawW1Coxn7+di/5o3zRVCImV
         gQOQD5gYkOZ2FJHbD9haBiIEVvSbob98HnYVk0zKHl2sCrCbv4JYL8QIGjMOLx3etq
         /Bk8aD4HJfPfgEXRpLvUYGTg3A6gKwTh6cPKqHlyQ2fKNCfZshV0/0UOrMXl0LLq5l
         9jpJyhYjI0vE9/1KNXZTF0QDo8silSTi7bH/rCHpayTdbgTPFanuDofOd0pVJZLQwr
         PDT6SFcOX0xUcEkp5+YsfWdzoqSkWnyZfHKkRmDuB5Ec9sHJwP84M8MvvEEuFo+lx2
         ZbdT52ISGBcvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00461C395C7;
        Sun, 18 Jun 2023 16:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: Manual remove LEDs to ensure correct ordering
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168710641899.5271.11988489535830400301.git-patchwork-notify@kernel.org>
Date:   Sun, 18 Jun 2023 16:40:18 +0000
References: <20230617155500.4005881-1-andrew@lunn.ch>
In-Reply-To: <20230617155500.4005881-1-andrew@lunn.ch>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, hkallweit1@gmail.com, ansuelsmth@gmail.com,
        rmk+kernel@armlinux.org.uk, stable@vger.kernel.org,
        f.fainelli@gmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 17 Jun 2023 17:55:00 +0200 you wrote:
> If the core is left to remove the LEDs via devm_, it is performed too
> late, after the PHY driver is removed from the PHY. This results in
> dereferencing a NULL pointer when the LED core tries to turn the LED
> off before destroying the LED.
> 
> Manually unregister the LEDs at a safe point in phy_remove.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: Manual remove LEDs to ensure correct ordering
    https://git.kernel.org/netdev/net/c/c938ab4da0eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


