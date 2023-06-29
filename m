Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47563742316
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 11:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjF2JUY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 05:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjF2JUW (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 05:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EA1107
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 02:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF456614C0
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 09:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1789FC433C9;
        Thu, 29 Jun 2023 09:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688030421;
        bh=sjrhlxMoc3gMI+6YuwBO+Xl5zd/guz3kTM9x73kxq5c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eIea9TTtxrkRQxhJ1gdDnA2cjP6IXlLy3ZL8VD0rolkFQXuD99lrPLSpABAkDLRUI
         KEgLn6I3Mdlo7MTJZW98tVMYFYc3qzIt/zXXat9RGIBA8waFSiswEm5FGHPAwyhHbF
         vTK9KUv/qhUpmRGBj/sUZObI9qW2TI+EV2jJxprduanXBpHQpVc7CjFXg+XlhuJmRA
         JdT+4mRxaxV7GbSCaPVxE8aYXHtTih/MPRy0WD8BdxfZ1lOMjgsEDa2OUf0pQiKMYi
         5FjdQ5uiShVcX89m/OLbnJEa03wZ5HqSllc+MSPibMA3+6vgneRV+qBPYFMfNug5+P
         7TswPHR3Sifow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF516C41671;
        Thu, 29 Jun 2023 09:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: lan743x: Don't sleep in atomic context
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168803042097.16415.15204725768156666010.git-patchwork-notify@kernel.org>
Date:   Thu, 29 Jun 2023 09:20:20 +0000
References: <20230627035000.1295254-1-moritzf@google.com>
In-Reply-To: <20230627035000.1295254-1-moritzf@google.com>
To:     Moritz Fischer <moritzf@google.com>
Cc:     netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net,
        bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
        mdf@kernel.org, stable@vger.kernel.org
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
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 Jun 2023 03:50:00 +0000 you wrote:
> dev_set_rx_mode() grabs a spin_lock, and the lan743x implementation
> proceeds subsequently to go to sleep using readx_poll_timeout().
> 
> Introduce a helper wrapping the readx_poll_timeout_atomic() function
> and use it to replace the calls to readx_polL_timeout().
> 
> Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
> Cc: stable@vger.kernel.org
> Cc: Bryan Whitehead <bryan.whitehead@microchip.com>
> Cc: UNGLinuxDriver@microchip.com
> Signed-off-by: Moritz Fischer <moritzf@google.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: lan743x: Don't sleep in atomic context
    https://git.kernel.org/netdev/net/c/7a8227b2e76b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


