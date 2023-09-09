Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C70B7992FC
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 02:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbjIIAA2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 8 Sep 2023 20:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjIIAA1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 8 Sep 2023 20:00:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E9718E
        for <stable@vger.kernel.org>; Fri,  8 Sep 2023 17:00:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF6D5C433C7;
        Sat,  9 Sep 2023 00:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694217623;
        bh=SY5HqVl6vzf2DY6JRXwG/yT139bO6hklB5plKgi+eWo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Yb2P/B+v7ZY0CeBYfVtU/NjTCNkiB7ECr7YZYNyovMmDpmNZO73syZCLgr5SjGukh
         OG4CJ1RAxzk3C5rjWcJachfqyhOiXl2gSoM/KqCckf6eonsKQ18LAhdHKYCBKJWtnA
         XX0iRadtWdb9R0ogVxLUrKzkGYzY71MW/flJr9+NGJHlQbXpV4+6WK3u/j8oarDGU0
         V86VdbXGIyelWla+gxcI/s6AodETbEdh6IQwYDItqQ5S4k059tcMEhBMpKtI0QU4i9
         g94xacjXq01B+btyuNNrtjJXrKVR/NPJewYeOgQui5/gz+cb/2ViKcENH97xA8A6Zv
         2BeSmcXXJuiuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1B98E53807;
        Sat,  9 Sep 2023 00:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: Add override check to kprobe multi link attach
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169421762372.9366.5282819170421075658.git-patchwork-notify@kernel.org>
Date:   Sat, 09 Sep 2023 00:00:23 +0000
References: <20230907200652.926951-1-jolsa@kernel.org>
In-Reply-To: <20230907200652.926951-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        stable@vger.kernel.org, bpf@vger.kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        tixxdz@gmail.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  7 Sep 2023 22:06:51 +0200 you wrote:
> Currently the multi_kprobe link attach does not check error
> injection list for programs with bpf_override_return helper
> and allows them to attach anywhere. Adding the missing check.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: Add override check to kprobe multi link attach
    https://git.kernel.org/bpf/bpf/c/41bc46c12a80
  - [bpf,2/2] selftests/bpf: Add kprobe_multi override test
    https://git.kernel.org/bpf/bpf/c/7182e56411b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


