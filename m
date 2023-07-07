Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B7B74B4BA
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 17:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjGGP4o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 11:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGGP4o (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 11:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9346A1BF4
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 08:56:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29D84619D7
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 15:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F72C433C7;
        Fri,  7 Jul 2023 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688745401;
        bh=bkZ09eBR9K1JcVuv4LdBb9/5RmwuTsr4HcJUCgWtcRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=seq7cXOPzbXCYN0FwZuDKwocnEZzSoLnzDnKWhQwnBqkr2+P16c3tFKtRLEJeUeuT
         OQnkM4lJw0mXnmABrRUBqiEHNWmhD2YidctMlfWXA+gRu6XrEe2NOJuRpaow+qiMeX
         VEoPdnkGNm3vaemy8rAtPUQySI9R+qvGFAKeEwxg=
Date:   Fri, 7 Jul 2023 17:56:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     stable@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH linux-5.4.y] bgmac: fix *initial* chip reset to support
 BCM5358
Message-ID: <2023070731-boxcar-pointed-d73f@gregkh>
References: <20230706111346.20234-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230706111346.20234-1-zajec5@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jul 06, 2023 at 01:13:46PM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> commit f99e6d7c4ed3be2531bd576425a5bd07fb133bd7 upstream.
> 
> While bringing hardware up we should perform a full reset including the
> switch bit (BGMAC_BCMA_IOCTL_SW_RESET aka SICF_SWRST). It's what
> specification says and what reference driver does.
> 
> This seems to be critical for the BCM5358. Without this hardware doesn't
> get initialized properly and doesn't seem to transmit or receive any
> packets.
> 
> Originally bgmac was calling bgmac_chip_reset() before setting
> "has_robosw" property which resulted in expected behaviour. That has
> changed as a side effect of adding platform device support which
> regressed BCM5358 support.
> 
> Fixes: f6a95a24957a ("net: ethernet: bgmac: Add platform device support")
> Cc: Jon Mason <jdmason@kudzu.us>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Link: https://lore.kernel.org/r/20230227091156.19509-1-zajec5@gmail.com
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Upstream commit wasn't backported to 5.4 (and older) because it couldn't
> be cherry-picked cleanly. There was a small fuzz caused by a missing
> commit 8c7da63978f1 ("bgmac: configure MTU and add support for frames
> beyond 8192 byte size").
> 
> I've manually cherry-picked fix for BCM5358 to the linux-5.4.x.
> ---
>  drivers/net/ethernet/broadcom/bgmac.c | 8 ++++++--
>  drivers/net/ethernet/broadcom/bgmac.h | 2 ++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 

Now queued up, thanks.

greg k-h
