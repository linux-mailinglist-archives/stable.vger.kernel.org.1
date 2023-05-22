Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070B770CA17
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbjEVTzP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbjEVTyt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:54:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCD395
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:54:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79BF262B65
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8672EC433EF;
        Mon, 22 May 2023 19:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785287;
        bh=6murL6H4vztFDi9aESZP5gD7A3IbyCG9pTLQTqz18sI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H9bPTXMnbj2C4+DJpMELoJDUgJmK4TcrkjtL0UxsSP9bwesbr2cLSBp36dtD71VpB
         y9dW5zN1z5++fWzSvtV9ZzSpxI8wLG3HvK40dAN1vVURTPMli2rmNBaOWkkG4m+xnP
         7thwVjsN1GYXpwqE+qjOpuZmsmqUCF93kxfCbpkI=
Date:   Mon, 22 May 2023 20:38:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     stable@vger.kernel.org, Peng Zhang <zhangpeng.00@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Tad <support@spotco.us>,
        Michael Keyes <mgkeyes@vigovproductions.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Robert Hensing <robert@hercules-ci.com>
Subject: Re: Backport request: [PATCH] maple_tree: make maple state reusable
 after mas_empty_area()
Message-ID: <2023052230-unleaded-attention-bfff@gregkh>
References: <20230522192934.kz5gp7rp2jeycaqj@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522192934.kz5gp7rp2jeycaqj@x220>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 22, 2023 at 07:29:34PM +0000, Alyssa Ross wrote:
> Hi, please backport commit 0257d9908d38c0b1669af4bb1bc4dbca1f273fe6 to
> 6.1.y onwards.  This patch fixes a regression which broke some programs,
> like GHC (the Haskell compiler).  We've been shipping this patch in
> NixOS unstable for the last couple of weeks, to positive results.
> 
> (The patch had "Cc: <stable@vger.kernel.org>" but from what I can tell
> has not been selected for backporting.  Apologies if I've just missed
> it.)

You just missed it, it's queued up for the next stable releases.

thanks,

greg k-h
