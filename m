Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EB67DEC7B
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 06:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjKBFvb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 01:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjKBFva (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 01:51:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4BC12C
        for <stable@vger.kernel.org>; Wed,  1 Nov 2023 22:51:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAD8BC433CD;
        Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698904287;
        bh=fvtzVEvpM+r/9FXChXvJSStKgLpd5sZnPv3/DnPjLuY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=b9HdS4eJTu0bUe1uiuDmCvSI9otRKopXjEldxn3KEIr6gOsNA/lmbrcKMcssphwUy
         TYOCKZXB9cj6+Z8ULK+N5RYRNAfIWm21ac8vEeV78S8HEiOVdb8n8EWuiHD0c5l0NG
         HxmEfopqYVnKF9qYuA4eC2DYSNc6MHcEpow7ZWzDEhOWtLkVIzQeB8bQZ5DneyS8Gv
         tJf0BsKc4KO1WWwZjB9j3RJSXdUmjKVgnNTeQdgbj6rjfNb7ZP91VnsQIGenuM3DWN
         rEvydeWJkiRsJBTvLm37+qHOdVAdX1DICaGKEa2AP7whOkuwFoKDq4JoxB3rlIag2L
         7COZ6Niq9/ShA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88644E00092;
        Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] llc: verify mac len before reading mac header
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169890428755.30377.9096227406672373743.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Nov 2023 05:51:27 +0000
References: <20231025234251.3796495-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20231025234251.3796495-1-willemdebruijn.kernel@gmail.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, stable@vger.kernel.org,
        willemb@google.com,
        syzbot+a8c7be6dee0de1b669cc@syzkaller.appspotmail.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Oct 2023 19:42:38 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> LLC reads the mac header with eth_hdr without verifying that the skb
> has an Ethernet header.
> 
> Syzbot was able to enter llc_rcv on a tun device. Tun can insert
> packets without mac len and with user configurable skb->protocol
> (passing a tun_pi header when not configuring IFF_NO_PI).
> 
> [...]

Here is the summary with links:
  - [net,v2] llc: verify mac len before reading mac header
    https://git.kernel.org/netdev/net/c/7b3ba18703a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


