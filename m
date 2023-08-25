Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CF47880AA
	for <lists+stable@lfdr.de>; Fri, 25 Aug 2023 09:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjHYHKp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 25 Aug 2023 03:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243033AbjHYHK1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 25 Aug 2023 03:10:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3958A1FD3
        for <stable@vger.kernel.org>; Fri, 25 Aug 2023 00:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8A6F66618
        for <stable@vger.kernel.org>; Fri, 25 Aug 2023 07:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17063C433C7;
        Fri, 25 Aug 2023 07:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692947423;
        bh=ANcqmrfmUqry2M3Okymt6F6zYJogSeActNc5bmci11c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VxSozqKDqQK9k7D2etb0QxFAhqX8y4rOgRbHSw2jh/OCZEgOIfnqB9+5Ogyy1REoo
         M3dYZa29Ke3B0WhrcJtGhR6KyNP5R6eGnM0+pjP8l45IbTDoUowcEBlXFGhZSmhgvl
         EJ8WAYlzJOFteru8E9G4i4UtcMYMpCm31LR/jIKttuPEi7qY6G1Xp9X0oUyCHyS7s0
         7acV9c0MrJ8wrC8SIULlkdtmGw5fg+vqKTQquEZtdY9jRDCJoodgmF3+aF2M+VWtcR
         88yMiY6ehNBd5uUeZCEPOBuNUqhLWau6Kv/iFYKRb1QbKuugafgstBVEOp7rnjQBGu
         Hy3cpZC7kW8eQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0AD1E33083;
        Fri, 25 Aug 2023 07:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169294742298.19723.4676181056392087198.git-patchwork-notify@kernel.org>
Date:   Fri, 25 Aug 2023 07:10:22 +0000
References: <20230823134102.1848881-1-nicolas.dichtel@6wind.com>
In-Reply-To: <20230823134102.1848881-1-nicolas.dichtel@6wind.com>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, daniel@iogearbox.net, ast@kernel.org,
        john.fastabend@gmail.com, gnault@redhat.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        stable@vger.kernel.org, siwar.zitouni@6wind.com
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 23 Aug 2023 15:41:02 +0200 you wrote:
> The goal is to support a bpf_redirect() from an ethernet device (ingress)
> to a ppp device (egress).
> The l2 header is added automatically by the ppp driver, thus the ethernet
> header should be removed.
> 
> CC: stable@vger.kernel.org
> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Tested-by: Siwar Zitouni <siwar.zitouni@6wind.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
    https://git.kernel.org/netdev/net/c/a4f39c9f14a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


