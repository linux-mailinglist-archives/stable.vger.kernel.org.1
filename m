Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6197AFA64
	for <lists+stable@lfdr.de>; Wed, 27 Sep 2023 07:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjI0FxB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 27 Sep 2023 01:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjI0FwV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 27 Sep 2023 01:52:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D061BD5
        for <stable@vger.kernel.org>; Tue, 26 Sep 2023 22:50:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE5BC433C7;
        Wed, 27 Sep 2023 05:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695793841;
        bh=ukaVewD6Ow36ozXZyc50lB+Up0oYTVoEBye3cUBjsl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VFVZM0WaTbX8IzgNfWB/+nnCRvAIuLTuLl92HlRXE08qPst2pLLXEj8YN/Vz6IIQG
         tOalVEN9Swi/yFXO9dmzIHX6uxLrGEL3dGlqBt9X3uCvX2h/ULr3yDZ0JHZEEidMi3
         omXSTz5h84MwoWSAijg+eyYyMho88pj5JizQd1JVlYpVBy48MHnygjDIXfUsTuDy9S
         evjL9rBTHu64QLHm4Rpz8cletGeYTcYVnJ7aSEPN9xAPQSKUa1mXzEKKR1sAB8N/Md
         /eXHuBsT0uLYxpJ/owZrZWxmyoGW3NvfNRVcrRtpE7dzPNGXWAUtsHNjkHwUAqOSjc
         BhzzC+aKgKBhQ==
Date:   Wed, 27 Sep 2023 07:50:33 +0200
From:   Simon Horman <horms@kernel.org>
To:     Jordan Rife <jrife@google.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        netdev@vger.kernel.org, dborkman@kernel.org, pablo@netfilter.org,
        kadlec@netfilter.org, fw@strlen.de, santosh.shilimkar@oracle.com,
        ast@kernel.org, rdna@fb.com, stable@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net v5 1/3] net: replace calls to sock->ops->connect()
 with kernel_connect()
Message-ID: <20230927055033.GB224399@kernel.org>
References: <20230921234642.1111903-1-jrife@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921234642.1111903-1-jrife@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 21, 2023 at 06:46:40PM -0500, Jordan Rife wrote:
> commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_connect")
> ensured that kernel_connect() will not overwrite the address parameter
> in cases where BPF connect hooks perform an address rewrite. This change
> replaces direct calls to sock->ops->connect() in net with kernel_connect()
> to make these call safe.
> 
> Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
> Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
> Cc: stable@vger.kernel.org
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jordan Rife <jrife@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

