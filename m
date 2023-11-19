Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01487F08A8
	for <lists+stable@lfdr.de>; Sun, 19 Nov 2023 20:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjKSTvl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 19 Nov 2023 14:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjKSTvZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 19 Nov 2023 14:51:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6C32D67
        for <stable@vger.kernel.org>; Sun, 19 Nov 2023 11:50:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5788FC433C8;
        Sun, 19 Nov 2023 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700423423;
        bh=2ndYzSeM4M85tVv7Ozf3E57uaVKbVurkw+JQM4qiER8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BNImtz2X4x68AzuduWxlpQXLPRnF9mmZL5CO4bMcsF72gmo5PSGYOEjF24LeLVo1h
         ymuvHe/nKe3drXgALie5poflb1AlBJxZYbas5SbbVPm2lORzI5jMWm0cNdcc4I0Hpq
         cbe2CKlryYjVeQeiJJ9zjYjqCs8keiL6prgoJwEM3uBmJzBtuzvBinEUJFFjT94xrf
         5KXSbYy9aQZjMUZ6+VUSX33aoH8vB1g51NBE5mn1KoYv4fi1WqU35b0C0ynZhFWKXR
         Xkttjxe7BmfLcbSVIrzL7XlPzDX2w/SrWuPxl3h+f5dYfkP+Y9Nlmtye+tPDmp0FoJ
         d3edO2weUl8AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A8CCC3274D;
        Sun, 19 Nov 2023 19:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: wangxun: fix kernel panic due to null pointer
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170042342323.11006.720383593121756548.git-patchwork-notify@kernel.org>
Date:   Sun, 19 Nov 2023 19:50:23 +0000
References: <20231117101108.893335-1-jiawenwu@trustnetic.com>
In-Reply-To: <20231117101108.893335-1-jiawenwu@trustnetic.com>
To:     Jiawen Wu <jiawenwu@trustnetic.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        mengyuanlou@net-swift.com, stable@vger.kernel.org
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

On Fri, 17 Nov 2023 18:11:08 +0800 you wrote:
> When the device uses a custom subsystem vendor ID, the function
> wx_sw_init() returns before the memory of 'wx->mac_table' is allocated.
> The null pointer will causes the kernel panic.
> 
> Fixes: 79625f45ca73 ("net: wangxun: Move MAC address handling to libwx")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> [...]

Here is the summary with links:
  - [net] net: wangxun: fix kernel panic due to null pointer
    https://git.kernel.org/netdev/net/c/8ba2c459668c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


