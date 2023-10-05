Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDAA7BA70B
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 18:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjJEQrV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 12:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjJEQql (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 12:46:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DD2269D
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 09:40:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DA30C433C9;
        Thu,  5 Oct 2023 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696524025;
        bh=7XaG2GVyPHp1/W38bWaJQuHP6bwhoDCUos4hHFNyh1k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FHixNa63p9+sq9sl9xv45dsxDc4xz16wlMyHd+TEaNB0Zs0N96RDDlqmwEYPjAaIS
         lxdY1eSdyyKLUY9ps3r4UXEKqpqYHkATZ5E5/fg5ZGbkD0MDFyHQ1HOT0qrqxUFIgZ
         OOecBBpV5yrvJwNUp+oze+Y269Y8lbXbc9mBLpLXidTc6ehVHuMFQU9o2tzdnX+fBY
         JllUzRVuCsvJ5zKNzbA197qjlyJUT6BZrvTLYk6R9fbfQdfLWfSC9wUzLfgycD2uTe
         I5/SZm74Dzy4T+Mdq2dmigJIE2UOVI1HK3VpC8H+UCJ4b2qbPx9/SlIdVv1UaLT3+e
         m6xBvc+eDDPww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67275E11F50;
        Thu,  5 Oct 2023 16:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mptcp: Fixes and maintainer email update for v6.6
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169652402541.29548.3696837409901235215.git-patchwork-notify@kernel.org>
Date:   Thu, 05 Oct 2023 16:40:25 +0000
References: <20231004-send-net-20231004-v1-0-28de4ac663ae@kernel.org>
In-Reply-To: <20231004-send-net-20231004-v1-0-28de4ac663ae@kernel.org>
To:     Mat Martineau <martineau@kernel.org>
Cc:     matttbe@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        mptcp@lists.linux.dev, kishen.maloor@intel.com, fw@strlen.de,
        stable@vger.kernel.org, geliang.tang@suse.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 04 Oct 2023 13:38:10 -0700 you wrote:
> Patch 1 addresses a race condition in MPTCP "delegated actions"
> infrastructure. Affects v5.19 and later.
> 
> Patch 2 removes an unnecessary restriction that did not allow additional
> outgoing subflows using the local address of the initial MPTCP subflow.
> v5.16 and later.
> 
> [...]

Here is the summary with links:
  - [net,1/3] mptcp: fix delegated action races
    https://git.kernel.org/netdev/net/c/a5efdbcece83
  - [net,2/3] mptcp: userspace pm allow creating id 0 subflow
    https://git.kernel.org/netdev/net/c/e5ed101a6028
  - [net,3/3] MAINTAINERS: update Matthieu's email address
    https://git.kernel.org/netdev/net/c/8eed6ee362b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


