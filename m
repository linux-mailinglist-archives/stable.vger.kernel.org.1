Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62D7784DCE
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 02:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjHWAa1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 20:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjHWAa1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 20:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE94CF9
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 17:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8832F632C6
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 00:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B149CC433CB;
        Wed, 23 Aug 2023 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692750624;
        bh=CoLz3mD8z3EEnrbY+VFjJFD64qCW/Afi2VmVdewI4/Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UFktCEzctW4y2wlIHFFSLqgvs8nF6H4/MQ0qiQbUQJQaBffabN1Q0a8OIZ7KGWKKo
         RDWWy/buROKpjv0mRDtiCE4Rs9znIT46WTR3DzwjKMWKvcEjnWqu9yvjOT2fmMcGzn
         BkchH9KiP4aQhRy2XBra5KLNT79lMLo/6g9L4swtYCCqj8sQPDcYAITtcip/Sia9C6
         qKCwiDHNOR9/tnQFbNsBtv0M2Jk0qJ5KMCbFk0A1Yuh+NgkZX89MAbF7eRy5KhJupb
         jnWF+F46LHMnODf2egESvoD1Ok8SDelwkRR8kM1jCNjhDZX2WDzBUNgqcoe4IGXeSO
         sHQ1LkO2moqZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96E97E21ED3;
        Wed, 23 Aug 2023 00:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] batman-adv: Hold rtnl lock during MTU update via
 netlink
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169275062461.22438.15672454677210639225.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Aug 2023 00:30:24 +0000
References: <20230821-batadv-missing-mtu-rtnl-lock-v1-1-1c5a7bfe861e@narfation.org>
In-Reply-To: <20230821-batadv-missing-mtu-rtnl-lock-v1-1-1c5a7bfe861e@narfation.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, b.a.t.m.a.n@lists.open-mesh.org,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com
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

On Mon, 21 Aug 2023 21:48:48 +0200 you wrote:
> The automatic recalculation of the maximum allowed MTU is usually triggered
> by code sections which are already rtnl lock protected by callers outside
> of batman-adv. But when the fragmentation setting is changed via
> batman-adv's own batadv genl family, then the rtnl lock is not yet taken.
> 
> But dev_set_mtu requires that the caller holds the rtnl lock because it
> uses netdevice notifiers. And this code will then fail the check for this
> lock:
> 
> [...]

Here is the summary with links:
  - [net] batman-adv: Hold rtnl lock during MTU update via netlink
    https://git.kernel.org/netdev/net/c/987aae75fc10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


