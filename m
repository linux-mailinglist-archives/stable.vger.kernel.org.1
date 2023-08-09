Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B231D776C85
	for <lists+stable@lfdr.de>; Thu, 10 Aug 2023 01:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjHIXA0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 19:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjHIXAY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 19:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B316DE71
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 16:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B0F064633
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 23:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA4F3C433C9;
        Wed,  9 Aug 2023 23:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691622022;
        bh=PG86WY5yYn48ScTCNBYEksFoKIIGEniKtWos4nAaddw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XJqtpBafr3FdowGEPFg94JMGxihiQXT0XkzXhsI0FLtbhmy6YxWMPOrC0l+ojtf/D
         JblKCFYdvU8OeOkqSWzEVuS5vPZ62sJh+bbFgvGZdoJAjs0UeyYICMGXpZUdgHMdoN
         E2tY+0KU80uaXEC+tbXEUawqDdXM+i9+DS+/E3gDeGhQwbNfX62xk2rqlFbd+JldyC
         FBIXRKyZyrd12Mgj5Z8Uo0ia+SQcpLO7jJCWwJsFAbVa2K5dmSk9jq1RM2NwLjl2Xr
         2jxXqvGaI8U6DAH9v1qtacAzn9OVP1PUkIk/sDjSS6ZSeuWmA1PHFw5ILpmCPxcd1E
         +ltiQ/WSLXpRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8CAB5C64459;
        Wed,  9 Aug 2023 23:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: adjust ndisc_is_useropt() to also return true for
 PIO
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169162202257.2325.18099698343343735059.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Aug 2023 23:00:22 +0000
References: <20230807102533.1147559-1-maze@google.com>
In-Reply-To: <20230807102533.1147559-1-maze@google.com>
To:     =?utf-8?q?Maciej_=C5=BBenczykowski_=3Cmaze=40google=2Ecom=3E?=@ci.codeaurora.org
Cc:     zenczykowski@gmail.com, netdev@vger.kernel.org, furry@google.com,
        lorenzo@google.com, dsahern@gmail.com, davem@davemloft.net,
        edumazet@google.com, yoshfuji@linux-ipv6.org,
        stable@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Aug 2023 03:25:32 -0700 you wrote:
> The upcoming (and nearly finalized):
>   https://datatracker.ietf.org/doc/draft-collink-6man-pio-pflag/
> will update the IPv6 RA to include a new flag in the PIO field,
> which will serve as a hint to perform DHCPv6-PD.
> 
> As we don't want DHCPv6 related logic inside the kernel, this piece of
> information needs to be exposed to userspace.  The simplest option is to
> simply expose the entire PIO through the already existing mechanism.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: adjust ndisc_is_useropt() to also return true for PIO
    https://git.kernel.org/netdev/net/c/048c796beb6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


