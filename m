Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C966F02BF
	for <lists+stable@lfdr.de>; Thu, 27 Apr 2023 10:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243094AbjD0InD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Apr 2023 04:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243056AbjD0InC (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Apr 2023 04:43:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82674C01
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 01:43:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5696F63BAC
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 08:43:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D10DC433D2;
        Thu, 27 Apr 2023 08:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682584980;
        bh=fttL0CPp91PzpTiH+zXIDwEu+bCr/U7Kn8G4mxErfLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o4fAClIrM3xlx7NIzkS2rkkNscySdrqJ4UOyWBEMZ9k0M6ydeD9/cP0qK/jLhmqtE
         U3ts4xhJSOFTfiKfQDqIMDZdMhn8oolJix2fsxPye8D257Rs6AgWlZ7jgKcJ0JKNHJ
         A/1yPOUHsX612iwiz47SXjVc3jageT2B+uScra4k=
Date:   Thu, 27 Apr 2023 10:42:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Sasha Levin <sashal@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        stable@vger.kernel.org, mptcp@lists.linux.dev,
        Christoph Paasch <cpaasch@apple.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 6.1 0/2] mptcp: Stable backports for v6.1.26
Message-ID: <2023042750-reappear-anteater-bbcf@gregkh>
References: <20230424-upstream-stable-20230424-conflicts-6-1-v1-0-b054457d3646@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424-upstream-stable-20230424-conflicts-6-1-v1-0-b054457d3646@tessares.net>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Apr 24, 2023 at 04:09:07PM +0200, Matthieu Baerts wrote:
> Hi Greg, Sasha,
> 
> Recently, 2 patches related to MPTCP have not been backported to v6.1
> tree due to conflicts:
> 
>  - 2a6a870e44dd ("mptcp: stops worker on unaccepted sockets at listener close") [1]
>  - 63740448a32e ("mptcp: fix accept vs worker race") [2]
> 
> I then here resolved the conflicts, documented what I did in each patch
> and ran our tests suite. Everything seems OK.
> 
> These patches are based on top of the latest linux-stable-rc/linux-6.1.y
> version.
> 
> Do you mind adding these two patches to v6.1 queue please?
> 
> [1] https://lore.kernel.org/r/2023042259-gravity-hate-a9a3@gregkh
> [2] https://lore.kernel.org/r/2023042215-chastise-scuba-8478@gregkh
> 
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Paolo Abeni (2):
>       mptcp: stops worker on unaccepted sockets at listener close
>       mptcp: fix accept vs worker race
> 
>  net/mptcp/protocol.c | 74 +++++++++++++++++++++++++++++++++---------------
>  net/mptcp/protocol.h |  2 ++
>  net/mptcp/subflow.c  | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 130 insertions(+), 26 deletions(-)
> ---
> base-commit: e4ff6ff54dea67f94036a357201b0f9807405cc6
> change-id: 20230424-upstream-stable-20230424-conflicts-6-1-f325fe76c540
> 
> Best regards,
> -- 
> Matthieu Baerts <matthieu.baerts@tessares.net>

Both now queued up, thanks.

greg k-h
