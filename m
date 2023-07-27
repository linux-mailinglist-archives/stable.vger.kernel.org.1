Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C54764382
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 03:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjG0BuY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Jul 2023 21:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjG0BuX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Jul 2023 21:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65CA19B6
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 18:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C02260F77
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 01:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C2AEC433CA;
        Thu, 27 Jul 2023 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690422621;
        bh=okgicIMQRwa06Kn5HgLanFk5xVYeRdrGhB1xMC23kW8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FBfMjQSScVnTtqnKNAKfTB2YfPHCfelcuPIC0YaIPGQXfNw30c+cM9u2XfQ4DA+r5
         ySyMLc1gqqEnZh3pbIjrnpGHasy4/mgTBOB6oze8huGrBOu/G4PrfkQvnYwF3AE1HX
         Gp8dVuZnW2QB+1bGV6vO6//kzytaelba8Ioh5JwLipX6DojIuWZ563PNBoh0vpd2yN
         vvy+HJExGCKtiO5skOPs2cAyDAL8S4ONd1I7Tpt4lpEoE6Cb6K5pecFOXmJngz+pcu
         Y73QgtjRe5cRtOW1yNeTCyc/tKW93BwQjvgUol0pSh4dGfFHSW8sMKpm8PLm4pY0hd
         WGYLZMhW+Nanw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FA8DC691D7;
        Thu, 27 Jul 2023 01:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mptcp: More fixes for 6.5
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169042262144.20624.14186289485941755366.git-patchwork-notify@kernel.org>
Date:   Thu, 27 Jul 2023 01:50:21 +0000
References: <20230725-send-net-20230725-v1-0-6f60fe7137a9@kernel.org>
In-Reply-To: <20230725-send-net-20230725-v1-0-6f60fe7137a9@kernel.org>
To:     Mat Martineau <martineau@kernel.org>
Cc:     matthieu.baerts@tessares.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        geliang.tang@suse.com, netdev@vger.kernel.org,
        mptcp@lists.linux.dev, stable@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jul 2023 11:34:54 -0700 you wrote:
> Patch 1: Better detection of ip6tables vs ip6tables-legacy tools for
> self tests. Fix for 6.4 and newer.
> 
> Patch 2: Only generate "new listener" event if listen operation
> succeeds. Fix for 6.2 and newer.
> 
> Signed-off-by: Mat Martineau <martineau@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,1/2] selftests: mptcp: join: only check for ip6tables if needed
    https://git.kernel.org/netdev/net/c/016e7ba47f33
  - [net,2/2] mptcp: more accurate NL event generation
    https://git.kernel.org/netdev/net/c/21d9b73a7d52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


