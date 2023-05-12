Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B8570020F
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 10:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbjELIAm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 04:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240313AbjELIA3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 04:00:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D865E10E4A
        for <stable@vger.kernel.org>; Fri, 12 May 2023 01:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DE80653BA
        for <stable@vger.kernel.org>; Fri, 12 May 2023 08:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEDCCC433EF;
        Fri, 12 May 2023 08:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683878422;
        bh=peiXR2wIzOlotz4x3dY6IyZNIatjmCjjAfG6Bws8ZRk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cl8pSJ7zsfPDFUSVBykJEGouGiv1jjV116OWIfpP4znD+d4pXjS4J5oi2TckOQ7V7
         midcb3mAKsypN9ZtgowiUJD4kGkCMh98LydemzBKXd1p88VYZQXIIrnnmZTwWuOJZC
         29+FauvGPIkcf1Da3e3Xp5uVctQCUPmlAg/n7/0UnaKJorZ2QttbnRuGiwYn6H8KNe
         m+viE5unLk8S0Z4H44MTVGjGKm8R5P6J9V4ivUGt3MCUY0GBCQGLzSEtEgHn+Yt87O
         8NbuST4pzYneWeU8OOElxP8xPWDRJUpzygIS+nebpgsXjJfx6WK7jEmnikqN9MgLwt
         a/x+0rqtavGrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A447CE450BB;
        Fri, 12 May 2023 08:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] nfp: fix NFP_NET_MAX_DSCP definition error
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168387842266.16770.1434182525934270705.git-patchwork-notify@kernel.org>
Date:   Fri, 12 May 2023 08:00:22 +0000
References: <20230511065056.8882-1-louis.peens@corigine.com>
In-Reply-To: <20230511065056.8882-1-louis.peens@corigine.com>
To:     Louis Peens <louis.peens@corigine.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        simon.horman@corigine.com, netdev@vger.kernel.org,
        stable@vger.kernel.org, oss-drivers@corigine.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 11 May 2023 08:50:56 +0200 you wrote:
> From: Huayu Chen <huayu.chen@corigine.com>
> 
> The patch corrects the NFP_NET_MAX_DSCP definition in the main.h file.
> 
> The incorrect definition result DSCP bits not being mapped properly when
> DCB is set. When NFP_NET_MAX_DSCP was defined as 4, the next 60 DSCP
> bits failed to be set.
> 
> [...]

Here is the summary with links:
  - [net] nfp: fix NFP_NET_MAX_DSCP definition error
    https://git.kernel.org/netdev/net/c/de9c1a23add9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


