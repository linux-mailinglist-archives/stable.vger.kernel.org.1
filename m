Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1156B7DF12C
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 12:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjKBLa2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 07:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKBLa1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 07:30:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD07111
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 04:30:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AC9AC433C9;
        Thu,  2 Nov 2023 11:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698924624;
        bh=A+QTuP4H2KqMqbO8ewDZNTpUxhLTk27eTGwNl1gvwUg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tXve6Hu5PHF1S084mucTYeLulgOp5aJRp7C2G+efosnckCa5NjMw7Fcg1af9i3I3V
         /I0vHBGxouaaVfar2kt45UmmHfLxMf9Cb+Q33FtCaazscxnjrrtBt8zEU80ubLYIrA
         D8HOw+4nQgSuelVTiO5l22S4b2R35mwul290Xu04SuU5is2kG0WCFFqh8gRzoBIsYr
         3q6NIE67Cf+rpXwmEjVhp7Ym4drkHB9+Q+DL7FPQNQDIFlUGTaELaZwRdSuEfS8drk
         y9lXWcxAoqi7b4IsCA0Iog+e7Jgb7ByfFvejwV5PTFiilN4gt+o1SC0udTCyATz73b
         BirGmwhQZp6ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D159C395FC;
        Thu,  2 Nov 2023 11:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] net: ethtool: Fix documentation of ethtool_sprintf()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169892462437.16317.7188504016558577027.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Nov 2023 11:30:24 +0000
References: <20231028192511.100001-1-andrew@lunn.ch>
In-Reply-To: <20231028192511.100001-1-andrew@lunn.ch>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, alexanderduyck@fb.com,
        justinstitt@google.com, stable@vger.kernel.org
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Sat, 28 Oct 2023 21:25:11 +0200 you wrote:
> This function takes a pointer to a pointer, unlike sprintf() which is
> passed a plain pointer. Fix up the documentation to make this clear.
> 
> Fixes: 7888fe53b706 ("ethtool: Add common function for filling out strings")
> Cc: Alexander Duyck <alexanderduyck@fb.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> [...]

Here is the summary with links:
  - [v1,net] net: ethtool: Fix documentation of ethtool_sprintf()
    https://git.kernel.org/netdev/net/c/f55d8e60f109

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


