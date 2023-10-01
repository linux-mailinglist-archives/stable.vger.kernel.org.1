Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC25C7B493E
	for <lists+stable@lfdr.de>; Sun,  1 Oct 2023 20:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbjJASka (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 1 Oct 2023 14:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbjJASk3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 1 Oct 2023 14:40:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E6BD3
        for <stable@vger.kernel.org>; Sun,  1 Oct 2023 11:40:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 663FEC433C7;
        Sun,  1 Oct 2023 18:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696185625;
        bh=PWCNXHuvuTJjFY0Ik8yvE3vODJwezAgpe2yQ+TFEW9A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Qo1VrCUlzRY5PSAcPbilPZokdnlkLNCGItCTNRWANcLkNV51KiD6+SXTyw+oqcZwj
         seRPaZNfcFtkS+YIQcfKt99O6Q17jksgbCie09f8LTbrjLIL70ALmyWyAJLBVU1Pbj
         tcbonfxsrpzHuHZ7y5lHlh4Rg6sK5aMt39BUR9+pLakjhWOvdU3I+YTqqc+GM4vrue
         uZvdhJIonTFy1zI3BZN/B+J2tP/QXxvViSIqSx8zvI6tEN/PcmZR1Ua7EF6KmHUQlJ
         huNJG/YPnjX6agR4qJuPKRCZZo62g7NdLKnTMMQQjxFN6gIJQuFvu/lK5Kxr4Oj3jG
         4y8x+1TGNahig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41015C395C5;
        Sun,  1 Oct 2023 18:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 1/3] net: replace calls to sock->ops->connect() with
 kernel_connect()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169618562525.20334.9043221644649917375.git-patchwork-notify@kernel.org>
Date:   Sun, 01 Oct 2023 18:40:25 +0000
References: <20230921234642.1111903-1-jrife@google.com>
In-Reply-To: <20230921234642.1111903-1-jrife@google.com>
To:     Jordan Rife <jrife@google.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        netdev@vger.kernel.org, dborkman@kernel.org, horms@verge.net.au,
        pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        santosh.shilimkar@oracle.com, ast@kernel.org, rdna@fb.com,
        stable@vger.kernel.org, willemb@google.com
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

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Sep 2023 18:46:40 -0500 you wrote:
> commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_connect")
> ensured that kernel_connect() will not overwrite the address parameter
> in cases where BPF connect hooks perform an address rewrite. This change
> replaces direct calls to sock->ops->connect() in net with kernel_connect()
> to make these call safe.
> 
> Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
> Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
> Cc: stable@vger.kernel.org
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jordan Rife <jrife@google.com>
> 
> [...]

Here is the summary with links:
  - [net,v5,1/3] net: replace calls to sock->ops->connect() with kernel_connect()
    https://git.kernel.org/netdev/net/c/26297b4ce1ce
  - [net,v5,2/3] net: prevent rewrite of msg_name in sock_sendmsg()
    https://git.kernel.org/netdev/net/c/86a7e0b69bd5
  - [net,v5,3/3] net: prevent address rewrite in kernel_bind()
    https://git.kernel.org/netdev/net/c/c889a99a21bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


