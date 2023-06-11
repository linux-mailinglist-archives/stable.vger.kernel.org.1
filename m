Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6164072B09A
	for <lists+stable@lfdr.de>; Sun, 11 Jun 2023 09:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjFKHZA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 11 Jun 2023 03:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKHY7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Jun 2023 03:24:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9134B19D
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 00:24:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F35360C40
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 07:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2582FC433D2;
        Sun, 11 Jun 2023 07:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686468297;
        bh=2bayewoaJS9Vxfl68+H99m3kvefiD9zeGzfVazNTw/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nlNIiTjGOzZTyA5jgtRn5iakb2iX1WkUunA4IEpyQJWI7fKxC5Ml2UEPfo6KwBwy5
         BiTBht4fB5yBD+P3HlMxq952n65U/NoabB63TClZrgxOTxNde6hNXWQ5AE6c3VnXz1
         j3IbIEvUcZvqP2+nWamamHmev6/aPn37wuAWoYEk=
Date:   Sun, 11 Jun 2023 09:24:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     stable@vger.kernel.org
Subject: Re: Missing backport for 04361b8bb818 ("net: sfp: fix state loss
 when updating state_hw_mask")
Message-ID: <2023061137-algorithm-almanac-1337@gregkh>
References: <99df4175-f41a-47d1-9d55-99e1976e8127@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99df4175-f41a-47d1-9d55-99e1976e8127@lunn.ch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jun 11, 2023 at 12:37:11AM +0200, Andrew Lunn wrote:
> Hi Greg, Sasha
> 
> Commit 04361b8bb818 ("net: sfp: fix state loss when updating state_hw_mask")
> 
> ends with:
> 
>     Fixes: 8475c4b70b04 ("net: sfp: re-implement soft state polling setup")
> 
> git tag --contains 8475c4b70b04
> 
> shows that the problem was introduced in v6.1-rc1. However, the fix
> has not been backported yet to v6.1.X
> 
> Is the Fixes: tag not sufficient to trigger the machinery to get it
> back ported?

Not at all!  Please see the rules at:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

A "bare" Fixes: tag never guarantees that it will ever go to a stable
tree, you MUST put a cc: stable on it in order to make sure that
happens.

It's been that way for 18+ years now, nothing new :)

> Please could you back port it. It cleanly cherry-picks to v6.1.33

Now queued up, thanks.

greg k-h
