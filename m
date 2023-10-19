Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75767CFF9C
	for <lists+stable@lfdr.de>; Thu, 19 Oct 2023 18:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjJSQa3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 19 Oct 2023 12:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjJSQa2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Oct 2023 12:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4927124
        for <stable@vger.kernel.org>; Thu, 19 Oct 2023 09:30:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74281C433CB;
        Thu, 19 Oct 2023 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697733026;
        bh=goztQrEcCwel8WiO92EPnPqluDWj0ekTpEnyftm1HHU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=T1T1+1euB82YCyif1glLHx2uE4RnqS+RBEC+AfdNW5cWNWzIAEC50Ifb7dXK/yWIR
         HVaswHpw6viCqQ/N9kVaUqftktpv/zzqHcB/ufA9tKvbAorBeuXcFoOCl3O6tn+f1S
         vG02D615nj+1Arf+GpBDwMqQXFTBgBd9CrAJcXIvnj2OAa2j1mtm4oVwvGb6B6nlGt
         4PG1FamnDE6Ltnk3b10UWldajIka1bIDuZP9fYMVtcGUK/HidqQ3XWg1HiqV8P3ndx
         WaZjnza+TANOc8czKo2Ma6rOY+6UhWzffVcpCZ0/DYicg1AOFrgAAwkYeGnxA/lQpI
         0znAPYPdSEgag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D73FC595CE;
        Thu, 19 Oct 2023 16:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mptcp: Fixes for v6.6
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169773302637.11126.16694469873432658738.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Oct 2023 16:30:26 +0000
References: <20231018-send-net-20231018-v1-0-17ecb002e41d@kernel.org>
In-Reply-To: <20231018-send-net-20231018-v1-0-17ecb002e41d@kernel.org>
To:     Mat Martineau <martineau@kernel.org>
Cc:     matttbe@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
        dcaratti@redhat.com, cpaasch@apple.com, fw@strlen.de,
        netdev@vger.kernel.org, mptcp@lists.linux.dev,
        stable@vger.kernel.org, geliang.tang@suse.com
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
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Oct 2023 11:23:51 -0700 you wrote:
> Patch 1 corrects the logic for MP_JOIN tests where 0 RSTs are expected.
> 
> Patch 2 ensures MPTCP packets are not incorrectly coalesced in the TCP
> backlog queue.
> 
> Patch 3 avoids a zero-window probe and associated WARN_ON_ONCE() in an
> expected MPTCP reinjection scenario.
> 
> [...]

Here is the summary with links:
  - [net,1/5] selftests: mptcp: join: correctly check for no RST
    https://git.kernel.org/netdev/net/c/b134a5805455
  - [net,2/5] tcp: check mptcp-level constraints for backlog coalescing
    https://git.kernel.org/netdev/net/c/6db8a37dfc54
  - [net,3/5] mptcp: more conservative check for zero probes
    https://git.kernel.org/netdev/net/c/72377ab2d671
  - [net,4/5] mptcp: avoid sending RST when closing the initial subflow
    https://git.kernel.org/netdev/net/c/14c56686a64c
  - [net,5/5] selftests: mptcp: join: no RST when rm subflow/addr
    https://git.kernel.org/netdev/net/c/2cfaa8b3b7ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


