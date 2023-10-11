Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1887C4F47
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 11:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjJKJk3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 05:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjJKJk2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 05:40:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7CBA4
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 02:40:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5775C433CA;
        Wed, 11 Oct 2023 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697017226;
        bh=WRT6G5ZYtV7v/9Z+5239GhfTbBtfI5U0mxDqQ61pQMA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ukh3qSfAYF0xgq2fBSjCuB1h+0l3TfswHpzUKwm8fiUTFqzMo8/gNMAKh+buMLHMI
         RPiLl281OFjDZ0lk8QIiwag512xqgUD6HlGpB4iQPoBOTM95X5IK7z/wIbqDtSuI4h
         0Bgla0gA7qw4VZ8leWrpktqLIpHOKjkC+VkD/X70YN0JLfppBaQU7y28LR1a/R7ACd
         qP5jEflq23S0pnXx06ZuWpl5pMFVnZlcfKoFyLwngDiTrUq6WvJOwayszbU294o30s
         EGLKwT5KBakIn6tQsuTs9j7fc7832VPAS83ULAPld4+virqnhBce2yDbWyCsR8jkos
         4wzWuDzFsBYcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7F57C595C4;
        Wed, 11 Oct 2023 09:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] nfp: flower: avoid rmmod nfp crash issues
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169701722681.1947.9222553022108785688.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Oct 2023 09:40:26 +0000
References: <20231009112155.13269-1-louis.peens@corigine.com>
In-Reply-To: <20231009112155.13269-1-louis.peens@corigine.com>
To:     Louis Peens <louis.peens@corigine.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, yanguo.li@corigine.com, netdev@vger.kernel.org,
        stable@vger.kernel.org, oss-drivers@corigine.com
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
by David S. Miller <davem@davemloft.net>:

On Mon,  9 Oct 2023 13:21:55 +0200 you wrote:
> From: Yanguo Li <yanguo.li@corigine.com>
> 
> When there are CT table entries, and you rmmod nfp, the following
> events can happen:
> 
> task1：
>     nfp_net_pci_remove
>           ↓
>     nfp_flower_stop->(asynchronous)tcf_ct_flow_table_cleanup_work(3)
>           ↓
>     nfp_zone_table_entry_destroy(1)
> 
> [...]

Here is the summary with links:
  - [net] nfp: flower: avoid rmmod nfp crash issues
    https://git.kernel.org/netdev/net/c/14690995c141

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


