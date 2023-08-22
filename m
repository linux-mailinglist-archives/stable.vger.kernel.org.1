Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F78E783B3B
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 09:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjHVHzq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 03:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjHVHzp (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 03:55:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F77D19B
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 00:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3E10616CE
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 07:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A98EC433C7;
        Tue, 22 Aug 2023 07:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692690943;
        bh=HgS4yGKAG70Gf+ddyrfQ4yCXJvgfhzVcU5cE2sHvA9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZmeH0c00ZEtMrTSee7G6WcrDoSDkz6l1EhgHWG8XYQCpb3JTyzQv5iTt3GMmc76ne
         i1F1KiRzfGGdgIs8m48wRn1si931WnDn7FDAkX18fj4/FPytTfgkvyE5l0ukjG/kV0
         gGc3eOCKJeYdBy7Rz4o/jnBDaaVk4Aa0Bl3WdmeR+BpAL6Oqbiz/Uj8jk10qAw0D9t
         VSsqXjYuXo6W1yUW1evsW1CJT0tckM3QDcfBijXoD41oZkCaYW1iKIzO6RdYoblcUN
         BIvXBy3xB6d8jQXDNahmfXhNId5AEdPJMyOoo103N3Uv6aNDWlWGpWk9gUDsuwEezH
         0IWLP+fv7l51Q==
Date:   Tue, 22 Aug 2023 09:55:39 +0200
From:   Simon Horman <horms@kernel.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
        stable@vger.kernel.org,
        syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com
Subject: Re: [PATCH net] batman-adv: Hold rtnl lock during MTU update via
 netlink
Message-ID: <20230822075539.GU2711035@kernel.org>
References: <20230821-batadv-missing-mtu-rtnl-lock-v1-1-1c5a7bfe861e@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821-batadv-missing-mtu-rtnl-lock-v1-1-1c5a7bfe861e@narfation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 21, 2023 at 09:48:48PM +0200, Sven Eckelmann wrote:
> The automatic recalculation of the maximum allowed MTU is usually triggered
> by code sections which are already rtnl lock protected by callers outside
> of batman-adv. But when the fragmentation setting is changed via
> batman-adv's own batadv genl family, then the rtnl lock is not yet taken.
> 
> But dev_set_mtu requires that the caller holds the rtnl lock because it
> uses netdevice notifiers. And this code will then fail the check for this
> lock:
> 
>   RTNL: assertion failed at net/core/dev.c (1953)
> 
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com
> Fixes: c6a953cce8d0 ("batman-adv: Trigger events for auto adjusted MTU")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
> This problem was just identified by syzbot [1]. I hope it is ok to directly
> send this patch to netdev instead of creating a single-patch PR from
> the batadv/net branch. If you still prefer a PR then we can also prepare
> it.
> 
> [1] https://lore.kernel.org/r/0000000000009bbb4b0603717cde@google.com

...
