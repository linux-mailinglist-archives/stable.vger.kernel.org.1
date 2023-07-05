Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AC8748BCA
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 20:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjGES0a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 14:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbjGES0I (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 14:26:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA6219A2
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 11:25:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A456E616CD
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 18:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08F3BC433C7;
        Wed,  5 Jul 2023 18:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688581221;
        bh=JamJjeCCkOl0qbFxmtmzV9hb2vvVrB1vx3JFpdV8h7Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=G8cOetNb+diIwOS8l11Vp7QJLP960UCtIQxIslSHQe+0L7f2naXT8OuKUAjCO2Hnd
         Wve0WEmh2V7nKJq6nrH1io1U1jArvTWR/ZZD+cDUZLisRJ83PhdFySljdEqtO5gn3M
         /gk6QwS2NIGNNHnyBdp0t+no1yeA2r/WGWgOF4/H80Z54auL1jm9FSkTyMk7YxdglN
         G2UAWOJMveeDbLVsbNsAVTBV01mPYLK9YWf2V8joQO3qopGVm5ayctVL3eyt63z+pH
         CKcieW+TjBBZs/0Qp9UKlTob7fSkBiK9nnbPZTp9e0/kbRRBh8JqX16rfeFIPWvWsb
         nvKmnKN8+nctA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF0B7C395C5;
        Wed,  5 Jul 2023 18:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] nfp: clean mc addresses in application firmware when
 closing port
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168858122090.23406.18329773090141093446.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Jul 2023 18:20:20 +0000
References: <20230705052818.7122-1-louis.peens@corigine.com>
In-Reply-To: <20230705052818.7122-1-louis.peens@corigine.com>
To:     Louis Peens <louis.peens@corigine.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        jacob.e.keller@intel.com, simon.horman@corigine.com,
        yinjun.zhang@corigine.com, netdev@vger.kernel.org,
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
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Jul 2023 07:28:18 +0200 you wrote:
> From: Yinjun Zhang <yinjun.zhang@corigine.com>
> 
> When moving devices from one namespace to another, mc addresses are
> cleaned in software while not removed from application firmware. Thus
> the mc addresses are remained and will cause resource leak.
> 
> Now use `__dev_mc_unsync` to clean mc addresses when closing port.
> 
> [...]

Here is the summary with links:
  - [net,v3] nfp: clean mc addresses in application firmware when closing port
    https://git.kernel.org/netdev/net/c/cc7eab25b1cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


