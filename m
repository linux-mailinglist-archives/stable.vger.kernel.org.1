Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B551A74C1EE
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 12:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjGIKa0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 06:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjGIKaV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 06:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6A712A
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 03:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEE1860BBF
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 10:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 193EEC433C9;
        Sun,  9 Jul 2023 10:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688898620;
        bh=JNjdE7h2KECVVFRvJju8wvUIdWAf0hYPNyWWMZWiwuE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cta4/LHpwmWC2DGW1rTuvflBNM0PuxedXbH94A5f1yG6Noihxu+ZEqvKF+bypLOKO
         8t5IsKUasS4+mXtOGnnumr8lfgjuk3x39881byrMaWByhL5V6RHjycKEiqUBxxZdmV
         DfrMziZndtZ6ddnzYcEVFxgioPW6MunbG6Bmre8vC5SSQ0aot4IQRYEUmCf0FW12dS
         q/SvBPH0bYT/KLivtdWau31sfIGklBmZ+vBA8UotUpf4PkNqgUfoXvF2x1WhHM00dI
         wvQBz82GvO5HCYUDwze/kTk996qE2gdMjivF0/KwdjQ0bCd9cZagoa0lVIRTCkFBg4
         0HYsBNF/hUKCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF446C395F8;
        Sun,  9 Jul 2023 10:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: lan743x: select FIXED_PHY
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168889861997.29064.9707742111397535356.git-patchwork-notify@kernel.org>
Date:   Sun, 09 Jul 2023 10:30:19 +0000
References: <20230708-lan743x-fixed-phy-v1-1-3fd19580546c@kernel.org>
In-Reply-To: <20230708-lan743x-fixed-phy-v1-1-3fd19580546c@kernel.org>
To:     Simon Horman <horms@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Pavithra.Sathyanarayanan@microchip.com,
        rdunlap@infradead.org, stable@vger.kernel.org,
        netdev@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 08 Jul 2023 15:06:25 +0100 you wrote:
> The blamed commit introduces usage of fixed_phy_register() but
> not a corresponding dependency on FIXED_PHY.
> 
> This can result in a build failure.
> 
>  s390-linux-ld: drivers/net/ethernet/microchip/lan743x_main.o: in function `lan743x_phy_open':
>  drivers/net/ethernet/microchip/lan743x_main.c:1514: undefined reference to `fixed_phy_register'
> 
> [...]

Here is the summary with links:
  - [net] net: lan743x: select FIXED_PHY
    https://git.kernel.org/netdev/net/c/73c4d1b307ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


