Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143987C91A1
	for <lists+stable@lfdr.de>; Sat, 14 Oct 2023 02:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjJNAAb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 20:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjJNAA3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 20:00:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6808DD7
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 17:00:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC706C433CC;
        Sat, 14 Oct 2023 00:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697241625;
        bh=VsIUpqefnf71mMlgC6Jl9mJd4GFzyW8fQmFd2shl82E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kdhuWIj/8is5C5CEBY2iv8c4urgz3gaU2gue93fPE0575jNcb3+aaJrIfWuKR7LIg
         sbQL4+FPMN3KGcwVdfdRbBX9IUArsDWgC/uL4srZHmtQOrdNYPQQr6cG2NdExtlsRV
         IWLIsoOkGJFmFeaWN94rDCIvTtFKZomoTJHiSsM4uHiBVYtqu4OCJV6T5Foy2CVMsR
         vcP5vA/N23Qfm23QlLlt6vL890nEOuwGDy8qOve4lB+dk1nAmeRv+iSSkzoqMCcStl
         S60CHu+suPUMXtqUgBa1DSguQrbLTW3mwOnbAEM2wHKsOtKAWkS93gA1UPXyrjZRUH
         REwOC0/BlcwPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C18D5C73FEA;
        Sat, 14 Oct 2023 00:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ice: fix over-shifted variable
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169724162478.10042.15458001965222573833.git-patchwork-notify@kernel.org>
Date:   Sat, 14 Oct 2023 00:00:24 +0000
References: <20231010203101.406248-1-jacob.e.keller@intel.com>
In-Reply-To: <20231010203101.406248-1-jacob.e.keller@intel.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        jesse.brandeburg@intel.com, przemyslaw.kitszel@intel.com,
        stable@vger.kernel.org, horms@kernel.org,
        himasekharx.reddy.pucha@intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Oct 2023 13:30:59 -0700 you wrote:
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Since the introduction of the ice driver the code has been
> double-shifting the RSS enabling field, because the define already has
> shifts in it and can't have the regular pattern of "a << shiftval &
> mask" applied.
> 
> [...]

Here is the summary with links:
  - [net] ice: fix over-shifted variable
    https://git.kernel.org/netdev/net/c/242e34500a32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


