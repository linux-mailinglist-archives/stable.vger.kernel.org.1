Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7757B78A582
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 08:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjH1GKc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 02:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjH1GKZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 02:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1242A122
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 23:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97AF861DFF
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 06:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 044BEC433C8;
        Mon, 28 Aug 2023 06:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693203022;
        bh=YSD34U9HLx/wXNqtoDrWKl9l+3hnZR/njNrMuHDK4Rg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NQ0zuRmsuCh58l10aVKcXUf/DfSCCZ2FBphkCS0+oEpX0LkehiP8Z8/O43vCjgo5P
         njbN1SteUI1PMQGLjlM73Ktx18oiR5o/GeY/yi3xen2WdVLUtbr2Wbsop1KeGc58tv
         KsxJK6tfCSrDtkgFXiHNXM4TA18NFbRbsqaXzItC8k+cPzUEkawTzUbEsgvQBKhlGc
         FLN51p5oMQPRzuJBWd1/AWDO2DIML+wBPy+WsqOKI4VMNzFZ7vgN4LU0GARy1KaBWy
         /e8S1JKuJ1KV+wpF/7vGIzP7U/7RsO845anOJdV3LDPAuUra3TRBUFkVbQDQfaSFmQ
         A9AXRhgaCGg2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1431E33081;
        Mon, 28 Aug 2023 06:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] igb: set max size RX buffer when store bad packet is
 enabled
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169320302191.19170.10006129327745919806.git-patchwork-notify@kernel.org>
Date:   Mon, 28 Aug 2023 06:10:21 +0000
References: <20230824204619.1551135-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230824204619.1551135-1-anthony.l.nguyen@intel.com>
To:     Tony Nguyen <anthony.l.nguyen@intel.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, netdev@vger.kernel.org,
        radoslawx.tyl@intel.com, greearb@candelatech.com,
        jesse.brandeburg@intel.com, stable@vger.kernel.org,
        manfred.rudigier@omicronenergy.com, arpanax.arland@intel.com
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

On Thu, 24 Aug 2023 13:46:19 -0700 you wrote:
> From: Radoslaw Tyl <radoslawx.tyl@intel.com>
> 
> Increase the RX buffer size to 3K when the SBP bit is on. The size of
> the RX buffer determines the number of pages allocated which may not
> be sufficient for receive frames larger than the set MTU size.
> 
> Cc: stable@vger.kernel.org
> Fixes: 89eaefb61dc9 ("igb: Support RX-ALL feature flag.")
> Reported-by: Manfred Rudigier <manfred.rudigier@omicronenergy.com>
> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> [...]

Here is the summary with links:
  - [net] igb: set max size RX buffer when store bad packet is enabled
    https://git.kernel.org/netdev/net/c/bb5ed01cd242

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


