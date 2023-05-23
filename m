Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B34870DDEB
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 15:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjEWNuX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 09:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbjEWNuV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 09:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A154126
        for <stable@vger.kernel.org>; Tue, 23 May 2023 06:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1955E62C11
        for <stable@vger.kernel.org>; Tue, 23 May 2023 13:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77D66C433EF;
        Tue, 23 May 2023 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684849819;
        bh=sxTiIAaLgwzPwBjNdyaOUpP5ixPNGf4rUtL+qfK4kVM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=COwpi6JNvRmoSTQfTcPoGrJTxp8KiWZs8YEiF440hFMoO0CbnFEVvde3qCeFSVboX
         zrsHVqqAwtLerDdjq5M0Nezsv4Ir/JzWBfHMem7tmgtzD2dUbF/oIRsiIIL52d9XQu
         jlvDr2Cy7uIUrVE+udBrrsMZslN7CpKx4JDt0ZLEYGpzMyZBVA8q2y4jWmiBwbEw2d
         jbfgTRhvWZi/9fRNQLBzLX8XYVaHLb43iY1bvV/D6jWlE3IT7ysogyzPMMKNCvkPUr
         SkFuRrK+ur/xmNcnwHYD5Ma7meZcGxOnHQKCGrriNHzYlOAZMvtgH8c4EDMIn8RDQH
         93cqThO9Ek4PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5DE1AE22B06;
        Tue, 23 May 2023 13:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv{4,6}/raw: fix output xfrm lookup wrt protocol
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168484981938.29246.10376121993213737020.git-patchwork-notify@kernel.org>
Date:   Tue, 23 May 2023 13:50:19 +0000
References: <20230522120820.1319391-1-nicolas.dichtel@6wind.com>
In-Reply-To: <20230522120820.1319391-1-nicolas.dichtel@6wind.com>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, dsahern@kernel.org, klassert@kernel.org,
        netdev@vger.kernel.org, stable@vger.kernel.org
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
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 22 May 2023 14:08:20 +0200 you wrote:
> With a raw socket bound to IPPROTO_RAW (ie with hdrincl enabled), the
> protocol field of the flow structure, build by raw_sendmsg() /
> rawv6_sendmsg()),  is set to IPPROTO_RAW. This breaks the ipsec policy
> lookup when some policies are defined with a protocol in the selector.
> 
> For ipv6, the sin6_port field from 'struct sockaddr_in6' could be used to
> specify the protocol. Just accept all values for IPPROTO_RAW socket.
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv{4,6}/raw: fix output xfrm lookup wrt protocol
    https://git.kernel.org/netdev/net/c/3632679d9e4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


